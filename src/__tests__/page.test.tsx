import { render, screen } from "@testing-library/react";
import { expect, test } from "vitest";

import Home from "@/app/page";

test("renders the CUMPAVIO smoke page", () => {
  render(<Home />);

  expect(
    screen.getByRole("heading", {
      level: 1,
      name: "CUMPAVIO",
    }),
  ).toBeDefined();

  expect(
    screen.getByText("Инженерная основа приложения работает."),
  ).toBeDefined();
});