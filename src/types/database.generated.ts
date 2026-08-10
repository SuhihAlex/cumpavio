export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  internal: {
    Tables: {
      crawl_runs: {
        Row: {
          crawler_version: string | null
          created_at: string
          error_summary: string | null
          finished_at: string | null
          id: string
          parser_version: string | null
          retailer_source_id: string
          started_at: string | null
          stats: Json
          status: Database["internal"]["Enums"]["run_status"]
          trigger_kind: string | null
        }
        Insert: {
          crawler_version?: string | null
          created_at?: string
          error_summary?: string | null
          finished_at?: string | null
          id?: string
          parser_version?: string | null
          retailer_source_id: string
          started_at?: string | null
          stats?: Json
          status?: Database["internal"]["Enums"]["run_status"]
          trigger_kind?: string | null
        }
        Update: {
          crawler_version?: string | null
          created_at?: string
          error_summary?: string | null
          finished_at?: string | null
          id?: string
          parser_version?: string | null
          retailer_source_id?: string
          started_at?: string | null
          stats?: Json
          status?: Database["internal"]["Enums"]["run_status"]
          trigger_kind?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "crawl_runs_retailer_source_id_fkey"
            columns: ["retailer_source_id"]
            isOneToOne: false
            referencedRelation: "retailer_sources"
            referencedColumns: ["id"]
          },
        ]
      }
      product_match_records: {
        Row: {
          confidence: number | null
          created_at: string
          decided_at: string | null
          evidence: Json
          id: string
          method: Database["internal"]["Enums"]["match_method"] | null
          source_listing_id: string
          status: Database["internal"]["Enums"]["match_status"]
          superseded_at: string | null
          variant_id: string | null
        }
        Insert: {
          confidence?: number | null
          created_at?: string
          decided_at?: string | null
          evidence?: Json
          id?: string
          method?: Database["internal"]["Enums"]["match_method"] | null
          source_listing_id: string
          status?: Database["internal"]["Enums"]["match_status"]
          superseded_at?: string | null
          variant_id?: string | null
        }
        Update: {
          confidence?: number | null
          created_at?: string
          decided_at?: string | null
          evidence?: Json
          id?: string
          method?: Database["internal"]["Enums"]["match_method"] | null
          source_listing_id?: string
          status?: Database["internal"]["Enums"]["match_status"]
          superseded_at?: string | null
          variant_id?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "product_match_records_source_listing_id_fkey"
            columns: ["source_listing_id"]
            isOneToOne: false
            referencedRelation: "source_listings"
            referencedColumns: ["id"]
          },
        ]
      }
      retailer_sources: {
        Row: {
          base_url: string | null
          created_at: string
          id: string
          retailer_id: string
          source_key: string
          source_type: Database["internal"]["Enums"]["source_type"]
          status: Database["public"]["Enums"]["record_status"]
          updated_at: string
        }
        Insert: {
          base_url?: string | null
          created_at?: string
          id?: string
          retailer_id: string
          source_key: string
          source_type: Database["internal"]["Enums"]["source_type"]
          status?: Database["public"]["Enums"]["record_status"]
          updated_at?: string
        }
        Update: {
          base_url?: string | null
          created_at?: string
          id?: string
          retailer_id?: string
          source_key?: string
          source_type?: Database["internal"]["Enums"]["source_type"]
          status?: Database["public"]["Enums"]["record_status"]
          updated_at?: string
        }
        Relationships: []
      }
      source_listing_observations: {
        Row: {
          content_hash: string | null
          crawl_run_id: string | null
          created_at: string
          error_details: Json | null
          extracted_attributes: Json
          id: string
          observed_at: string
          parse_status: Database["internal"]["Enums"]["parse_status"]
          parser_version: string | null
          raw_availability_text: string | null
          raw_identifiers: Json
          raw_price_text: string | null
          source_listing_id: string
          source_payload: Json
          title_raw: string | null
        }
        Insert: {
          content_hash?: string | null
          crawl_run_id?: string | null
          created_at?: string
          error_details?: Json | null
          extracted_attributes?: Json
          id?: string
          observed_at: string
          parse_status?: Database["internal"]["Enums"]["parse_status"]
          parser_version?: string | null
          raw_availability_text?: string | null
          raw_identifiers?: Json
          raw_price_text?: string | null
          source_listing_id: string
          source_payload?: Json
          title_raw?: string | null
        }
        Update: {
          content_hash?: string | null
          crawl_run_id?: string | null
          created_at?: string
          error_details?: Json | null
          extracted_attributes?: Json
          id?: string
          observed_at?: string
          parse_status?: Database["internal"]["Enums"]["parse_status"]
          parser_version?: string | null
          raw_availability_text?: string | null
          raw_identifiers?: Json
          raw_price_text?: string | null
          source_listing_id?: string
          source_payload?: Json
          title_raw?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "source_listing_observations_crawl_run_id_fkey"
            columns: ["crawl_run_id"]
            isOneToOne: false
            referencedRelation: "crawl_runs"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "source_listing_observations_source_listing_id_fkey"
            columns: ["source_listing_id"]
            isOneToOne: false
            referencedRelation: "source_listings"
            referencedColumns: ["id"]
          },
        ]
      }
      source_listings: {
        Row: {
          created_at: string
          external_id: string | null
          first_seen_at: string
          id: string
          last_checked_at: string
          last_seen_at: string
          retailer_source_id: string
          source_key: string
          source_url: string
          status: Database["public"]["Enums"]["record_status"]
          updated_at: string
        }
        Insert: {
          created_at?: string
          external_id?: string | null
          first_seen_at: string
          id?: string
          last_checked_at: string
          last_seen_at: string
          retailer_source_id: string
          source_key: string
          source_url: string
          status?: Database["public"]["Enums"]["record_status"]
          updated_at?: string
        }
        Update: {
          created_at?: string
          external_id?: string | null
          first_seen_at?: string
          id?: string
          last_checked_at?: string
          last_seen_at?: string
          retailer_source_id?: string
          source_key?: string
          source_url?: string
          status?: Database["public"]["Enums"]["record_status"]
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "source_listings_retailer_source_id_fkey"
            columns: ["retailer_source_id"]
            isOneToOne: false
            referencedRelation: "retailer_sources"
            referencedColumns: ["id"]
          },
        ]
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      [_ in never]: never
    }
    Enums: {
      match_method:
        | "gtin"
        | "manufacturer_identifier"
        | "mpn"
        | "normalized_model"
        | "deterministic"
        | "fuzzy"
        | "manual"
      match_status: "pending" | "matched" | "ambiguous" | "rejected"
      parse_status: "pending" | "parsed" | "partial" | "failed"
      run_status:
        | "pending"
        | "running"
        | "succeeded"
        | "partially_succeeded"
        | "failed"
        | "cancelled"
      source_type: "website" | "api" | "feed" | "sitemap" | "other"
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
  public: {
    Tables: {
      offers: {
        Row: {
          availability_status: Database["public"]["Enums"]["availability_status"]
          created_at: string
          currency_code: string
          current_comparable_price: number | null
          id: string
          last_observed_at: string | null
          retailer_id: string
          source_listing_id: string
          status: Database["public"]["Enums"]["record_status"]
          updated_at: string
          variant_id: string
        }
        Insert: {
          availability_status?: Database["public"]["Enums"]["availability_status"]
          created_at?: string
          currency_code?: string
          current_comparable_price?: number | null
          id?: string
          last_observed_at?: string | null
          retailer_id: string
          source_listing_id: string
          status?: Database["public"]["Enums"]["record_status"]
          updated_at?: string
          variant_id: string
        }
        Update: {
          availability_status?: Database["public"]["Enums"]["availability_status"]
          created_at?: string
          currency_code?: string
          current_comparable_price?: number | null
          id?: string
          last_observed_at?: string | null
          retailer_id?: string
          source_listing_id?: string
          status?: Database["public"]["Enums"]["record_status"]
          updated_at?: string
          variant_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "offers_retailer_id_fkey"
            columns: ["retailer_id"]
            isOneToOne: false
            referencedRelation: "retailers"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "offers_variant_id_fkey"
            columns: ["variant_id"]
            isOneToOne: false
            referencedRelation: "product_variants"
            referencedColumns: ["id"]
          },
        ]
      }
      price_observations: {
        Row: {
          availability_status: Database["public"]["Enums"]["availability_status"]
          comparable_price: number
          created_at: string
          currency_code: string
          id: string
          observed_at: string
          offer_id: string
          quality_reason: string | null
          quality_status: Database["public"]["Enums"]["price_observation_quality"]
          source_listing_observation_id: string
        }
        Insert: {
          availability_status?: Database["public"]["Enums"]["availability_status"]
          comparable_price: number
          created_at?: string
          currency_code?: string
          id?: string
          observed_at: string
          offer_id: string
          quality_reason?: string | null
          quality_status?: Database["public"]["Enums"]["price_observation_quality"]
          source_listing_observation_id: string
        }
        Update: {
          availability_status?: Database["public"]["Enums"]["availability_status"]
          comparable_price?: number
          created_at?: string
          currency_code?: string
          id?: string
          observed_at?: string
          offer_id?: string
          quality_reason?: string | null
          quality_status?: Database["public"]["Enums"]["price_observation_quality"]
          source_listing_observation_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "price_observations_offer_id_fkey"
            columns: ["offer_id"]
            isOneToOne: false
            referencedRelation: "offers"
            referencedColumns: ["id"]
          },
        ]
      }
      product_families: {
        Row: {
          brand: string
          brand_normalized: string
          category: Database["public"]["Enums"]["product_category"]
          created_at: string
          display_name: string
          id: string
          model_name: string
          model_normalized: string
          status: Database["public"]["Enums"]["record_status"]
          updated_at: string
        }
        Insert: {
          brand: string
          brand_normalized: string
          category: Database["public"]["Enums"]["product_category"]
          created_at?: string
          display_name: string
          id?: string
          model_name: string
          model_normalized: string
          status?: Database["public"]["Enums"]["record_status"]
          updated_at?: string
        }
        Update: {
          brand?: string
          brand_normalized?: string
          category?: Database["public"]["Enums"]["product_category"]
          created_at?: string
          display_name?: string
          id?: string
          model_name?: string
          model_normalized?: string
          status?: Database["public"]["Enums"]["record_status"]
          updated_at?: string
        }
        Relationships: []
      }
      product_variant_identifiers: {
        Row: {
          created_at: string
          id: string
          identifier_type: string
          is_primary: boolean
          normalized_value: string
          value: string
          variant_id: string
        }
        Insert: {
          created_at?: string
          id?: string
          identifier_type: string
          is_primary?: boolean
          normalized_value: string
          value: string
          variant_id: string
        }
        Update: {
          created_at?: string
          id?: string
          identifier_type?: string
          is_primary?: boolean
          normalized_value?: string
          value?: string
          variant_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "product_variant_identifiers_variant_id_fkey"
            columns: ["variant_id"]
            isOneToOne: false
            referencedRelation: "product_variants"
            referencedColumns: ["id"]
          },
        ]
      }
      product_variants: {
        Row: {
          attributes: Json
          created_at: string
          display_name: string
          family_id: string
          id: string
          status: Database["public"]["Enums"]["record_status"]
          updated_at: string
          variant_key: string
        }
        Insert: {
          attributes?: Json
          created_at?: string
          display_name: string
          family_id: string
          id?: string
          status?: Database["public"]["Enums"]["record_status"]
          updated_at?: string
          variant_key: string
        }
        Update: {
          attributes?: Json
          created_at?: string
          display_name?: string
          family_id?: string
          id?: string
          status?: Database["public"]["Enums"]["record_status"]
          updated_at?: string
          variant_key?: string
        }
        Relationships: [
          {
            foreignKeyName: "product_variants_family_id_fkey"
            columns: ["family_id"]
            isOneToOne: false
            referencedRelation: "product_families"
            referencedColumns: ["id"]
          },
        ]
      }
      retailers: {
        Row: {
          created_at: string
          id: string
          name: string
          slug: string
          status: Database["public"]["Enums"]["record_status"]
          updated_at: string
          website_url: string | null
        }
        Insert: {
          created_at?: string
          id?: string
          name: string
          slug: string
          status?: Database["public"]["Enums"]["record_status"]
          updated_at?: string
          website_url?: string | null
        }
        Update: {
          created_at?: string
          id?: string
          name?: string
          slug?: string
          status?: Database["public"]["Enums"]["record_status"]
          updated_at?: string
          website_url?: string | null
        }
        Relationships: []
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      [_ in never]: never
    }
    Enums: {
      availability_status:
        | "unknown"
        | "in_stock"
        | "out_of_stock"
        | "preorder"
        | "backorder"
      price_observation_quality:
        | "pending"
        | "accepted"
        | "suspicious"
        | "rejected"
      product_category: "smartphone" | "laptop"
      record_status: "active" | "inactive" | "archived"
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DatabaseWithoutInternals = Omit<Database, "__InternalSupabase">

type DefaultSchema = DatabaseWithoutInternals[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof DatabaseWithoutInternals },
  EnumName extends DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = DefaultSchemaEnumNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof DatabaseWithoutInternals },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never,
> = PublicCompositeTypeNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  internal: {
    Enums: {
      match_method: [
        "gtin",
        "manufacturer_identifier",
        "mpn",
        "normalized_model",
        "deterministic",
        "fuzzy",
        "manual",
      ],
      match_status: ["pending", "matched", "ambiguous", "rejected"],
      parse_status: ["pending", "parsed", "partial", "failed"],
      run_status: [
        "pending",
        "running",
        "succeeded",
        "partially_succeeded",
        "failed",
        "cancelled",
      ],
      source_type: ["website", "api", "feed", "sitemap", "other"],
    },
  },
  public: {
    Enums: {
      availability_status: [
        "unknown",
        "in_stock",
        "out_of_stock",
        "preorder",
        "backorder",
      ],
      price_observation_quality: [
        "pending",
        "accepted",
        "suspicious",
        "rejected",
      ],
      product_category: ["smartphone", "laptop"],
      record_status: ["active", "inactive", "archived"],
    },
  },
} as const
