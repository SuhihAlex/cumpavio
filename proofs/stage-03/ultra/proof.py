from __future__ import annotations

import json
import re
import sys
from dataclasses import dataclass
from decimal import Decimal, InvalidOperation
from typing import Any, Iterator

import httpx
from bs4 import BeautifulSoup, Tag


USER_AGENT = (
    "CUMPAVIO-Stage3-Feasibility-Proof/0.2 "
    "(+https://github.com/SuhihAlex/cumpavio)"
)


@dataclass(frozen=True)
class ProofSample:
    key: str
    category: str
    url: str
    expected_source_product_id: str
    expected_article_identifier: str
    expected_online_in_stock: bool
    expected_showroom_in_stock: bool
    expected_can_add_to_cart: bool
    expected_notify_when_available: bool


SAMPLES = (
    ProofSample(
        key="available_laptop",
        category="laptop",
        url=(
            "https://ultra.md/tehnica-computer/laptopuri/"
            "lenovo-ideapad-pro-5-16akp10-16-120-hz-24-gb-512-gb-"
            "amd-ryzen-ai-7-350-fara-so-grey"
        ),
        expected_source_product_id="262576",
        expected_article_identifier="83JN0047RK",
        expected_online_in_stock=True,
        expected_showroom_in_stock=False,
        expected_can_add_to_cart=True,
        expected_notify_when_available=False,
    ),
    ProofSample(
        key="unavailable_smartphone",
        category="smartphone",
        url="https://ultra.md/product/iphone-14-128gb-midnight-md",
        expected_source_product_id="145518",
        expected_article_identifier="MPUF3RX/A",
        expected_online_in_stock=False,
        expected_showroom_in_stock=False,
        expected_can_add_to_cart=False,
        expected_notify_when_available=True,
    ),
)


def iter_json_nodes(value: Any) -> Iterator[dict[str, Any]]:
    if isinstance(value, dict):
        yield value

        for child in value.values():
            yield from iter_json_nodes(child)

    elif isinstance(value, list):
        for child in value:
            yield from iter_json_nodes(child)


def has_type(
    node: dict[str, Any],
    expected: str,
) -> bool:
    node_type = node.get("@type")

    if isinstance(node_type, str):
        return node_type == expected

    if isinstance(node_type, list):
        return expected in node_type

    return False


def find_product_json_ld(
    soup: BeautifulSoup,
) -> dict[str, Any] | None:
    for script in soup.select(
        'script[type="application/ld+json"]'
    ):
        raw = (
            script.string
            or script.get_text(strip=True)
        )

        if not raw:
            continue

        try:
            payload = json.loads(raw)
        except json.JSONDecodeError:
            continue

        for node in iter_json_nodes(payload):
            if has_type(node, "Product"):
                return node

    return None


def first_offer(
    product: dict[str, Any] | None,
) -> dict[str, Any] | None:
    if not product:
        return None

    offers = product.get("offers")

    if isinstance(offers, dict):
        return offers

    if isinstance(offers, list):
        for offer in offers:
            if isinstance(offer, dict):
                return offer

    return None


def parse_decimal_price(
    value: object,
) -> Decimal | None:
    if value is None:
        return None

    text = (
        str(value)
        .replace("\u00a0", " ")
        .strip()
    )

    match = re.search(
        r"\d[\d\s]*(?:[.,]\d{1,2})?",
        text,
    )

    if not match:
        return None

    normalized = (
        match.group(0)
        .replace(" ", "")
        .replace(",", ".")
    )

    try:
        return Decimal(normalized)
    except InvalidOperation:
        return None


def extract_codes(
    soup: BeautifulSoup,
) -> dict[str, str]:
    container = soup.select_one(
        "div.product-purchase-card-codes"
    )

    if not container:
        return {}

    result: dict[str, str] = {}

    for row in container.find_all(
        "div",
        recursive=False,
    ):
        spans = row.find_all(
            "span",
            recursive=False,
        )

        if len(spans) < 2:
            continue

        key = (
            spans[0]
            .get_text(" ", strip=True)
            .rstrip(":")
            .strip()
        )

        value = spans[1].get_text(
            " ",
            strip=True,
        )

        if key and value:
            result[key] = value

    return result


def availability_from_badge(
    badge: Tag,
) -> bool | None:
    classes = set(
        badge.get("class", [])
    )

    use = badge.select_one(
        "svg use"
    )

    icon = (
        str(use.get("href", ""))
        if use
        else ""
    )

    if (
        "badge--success" in classes
        or icon.endswith("svg-check")
    ):
        return True

    if (
        "badge--danger" in classes
        or icon.endswith("svg-close")
    ):
        return False

    return None


def extract_availability(
    soup: BeautifulSoup,
) -> dict[str, bool | None]:
    container = soup.select_one(
        "div.product-details__availability"
    )

    result: dict[str, bool | None] = {
        "online_in_stock": None,
        "showroom_in_stock": None,
    }

    if not container:
        return result

    for badge in container.select(
        "span.badge"
    ):
        label = (
            badge
            .get_text(" ", strip=True)
            .casefold()
        )

        state = availability_from_badge(
            badge
        )

        if label == "în stoc":
            result["online_in_stock"] = state

        elif label == "în showroom":
            result["showroom_in_stock"] = state

    return result


def inspect_sample(
    client: httpx.Client,
    sample: ProofSample,
) -> dict[str, Any]:
    response = client.get(
        sample.url
    )

    response.raise_for_status()

    soup = BeautifulSoup(
        response.text,
        "lxml",
    )

    title_node = soup.select_one(
        "h1.product-details__title "
        "> span:first-of-type"
    )

    subtitle_node = soup.select_one(
        "h1.product-details__title "
        "> span:nth-of-type(2)"
    )

    codes = extract_codes(
        soup
    )

    availability = extract_availability(
        soup
    )

    product_json_ld = (
        find_product_json_ld(soup)
    )

    offer_json_ld = first_offer(
        product_json_ld
    )

    visible_price_node = soup.select_one(
        ".product-purchase-card__new-price"
    )

    visible_price_raw = (
        visible_price_node.get_text(
            " ",
            strip=True,
        )
        if visible_price_node
        else None
    )

    visible_price = parse_decimal_price(
        visible_price_raw
    )

    json_ld_price_raw = (
        offer_json_ld.get("price")
        if offer_json_ld
        else None
    )

    json_ld_price = parse_decimal_price(
        json_ld_price_raw
    )

    purchase_card = soup.select_one(
        ".product-purchase-card"
    )

    purchase_scope = (
        purchase_card
        or soup
    )

    can_add_to_cart = (
        purchase_scope.select_one(
            "button."
            "product-purchase-card__button--cart"
            '[data-endpoint*="/cart/add-product"]'
        )
        is not None
    )

    notify_when_available = (
        purchase_scope.find(
            string=re.compile(
                r"Notifică\s+când\s+"
                r"este\s+disponibil",
                re.IGNORECASE,
            )
        )
        is not None
    )

    json_ld_availability = (
        offer_json_ld.get(
            "availability"
        )
        if offer_json_ld
        else None
    )

    source_product_id = codes.get(
        "Cod produs"
    )

    article_identifier = codes.get(
        "Articol"
    )

    checks = {
        "http_200":
            response.status_code == 200,

        "product_json_ld_found":
            product_json_ld is not None,

        "source_product_id_found":
            bool(source_product_id),

        "source_product_id_matches_expected":
            source_product_id
            == sample.expected_source_product_id,

        "article_identifier_found":
            bool(article_identifier),

        "article_identifier_matches_expected":
            article_identifier
            == sample.expected_article_identifier,

        "visible_price_found":
            visible_price is not None,

        "json_ld_price_found":
            json_ld_price is not None,

        "visible_price_matches_json_ld":
            (
                visible_price is not None
                and json_ld_price is not None
                and visible_price
                == json_ld_price
            ),

        "online_availability_matches_expected":
            (
                availability[
                    "online_in_stock"
                ]
                == sample.expected_online_in_stock
            ),

        "showroom_availability_matches_expected":
            (
                availability[
                    "showroom_in_stock"
                ]
                == sample.expected_showroom_in_stock
            ),

        "cart_action_matches_expected":
            can_add_to_cart
            == sample.expected_can_add_to_cart,

        "notify_action_matches_expected":
            notify_when_available
            == sample.expected_notify_when_available,
    }

    json_ld_claims_in_stock = (
        isinstance(
            json_ld_availability,
            str,
        )
        and json_ld_availability.endswith(
            "/InStock"
        )
    )

    visible_json_ld_disagreement = (
        availability["online_in_stock"]
        is False
        and json_ld_claims_in_stock
    )

    return {
        "sample": {
            "key": sample.key,
            "category": sample.category,
        },

        "source": {
            "retailer": "Ultra",
            "url": str(response.url),
            "http_status":
                response.status_code,
        },

        "product": {
            "title": (
                title_node.get_text(
                    " ",
                    strip=True,
                )
                if title_node
                else None
            ),

            "subtitle": (
                subtitle_node.get_text(
                    " ",
                    strip=True,
                )
                if subtitle_node
                else None
            ),

            "source_product_id":
                source_product_id,

            "article_identifier":
                article_identifier,
        },

        "price": {
            "currency": (
                offer_json_ld.get(
                    "priceCurrency"
                )
                if offer_json_ld
                else None
            ),

            "visible_raw":
                visible_price_raw,

            "visible_comparable": (
                str(visible_price)
                if visible_price is not None
                else None
            ),

            "json_ld_comparable": (
                str(json_ld_price)
                if json_ld_price is not None
                else None
            ),
        },

        "availability": {
            **availability,

            "can_add_to_cart":
                can_add_to_cart,

            "notify_when_available":
                notify_when_available,

            "json_ld_availability":
                json_ld_availability,

            "visible_json_ld_disagreement":
                visible_json_ld_disagreement,

            "authority": (
                "scoped visible badge/icon "
                "and purchase-action semantics; "
                "JSON-LD availability is "
                "informational only"
            ),
        },

        "checks": checks,

        "passed": all(
            checks.values()
        ),
    }


def run_proof() -> dict[str, Any]:
    with httpx.Client(
        headers={
            "User-Agent": USER_AGENT,
        },
        follow_redirects=True,
        timeout=20.0,
    ) as client:
        results = [
            inspect_sample(
                client,
                sample,
            )
            for sample in SAMPLES
        ]

    return {
        "proof": (
            "CUMPAVIO Stage 3 / Ultra / "
            "two-category read-only proof"
        ),

        "sample_count": len(
            results
        ),

        "results": results,

        "passed": all(
            result["passed"]
            for result in results
        ),
    }


def main() -> int:
    if hasattr(
        sys.stdout,
        "reconfigure",
    ):
        sys.stdout.reconfigure(
            encoding="utf-8"
        )

    result = run_proof()

    print(
        json.dumps(
            result,
            ensure_ascii=False,
            indent=2,
        )
    )

    return (
        0
        if result["passed"]
        else 1
    )


if __name__ == "__main__":
    raise SystemExit(
        main()
    )