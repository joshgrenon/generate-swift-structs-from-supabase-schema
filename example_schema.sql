CREATE TABLE "public"."customers" (
    "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
    "first_name" varchar(50) NOT NULL,
    "last_name" varchar(50) NOT NULL,
    "email" varchar(255) NOT NULL,
    "phone_number" varchar(20),
    "created_at" timestamp with time zone NOT NULL DEFAULT now(),
    "last_purchase_date" timestamp with time zone,
    "total_purchases" integer NOT NULL DEFAULT 0,
    "is_active" boolean NOT NULL DEFAULT true
);

CREATE TABLE "public"."inventory_items" (
    "id" bigserial NOT NULL,
    "sku" varchar(50) NOT NULL,
    "name" varchar(100) NOT NULL,
    "description" text,
    "category" varchar(50),
    "price" numeric(10,2) NOT NULL,
    "stock_quantity" integer NOT NULL DEFAULT 0,
    "last_restocked" timestamp with time zone,
    "is_discontinued" boolean NOT NULL DEFAULT false
);

CREATE TABLE "public"."sales" (
    "id" bigserial NOT NULL,
    "customer_id" uuid NOT NULL,
    "sale_date" timestamp with time zone NOT NULL DEFAULT now(),
    "total_amount" numeric(12,2) NOT NULL,
    "payment_method" varchar(50),
    "notes" text
);

CREATE TABLE "public"."sale_items" (
    "id" bigserial NOT NULL,
    "sale_id" bigint NOT NULL,
    "inventory_item_id" bigint NOT NULL,
    "quantity" integer NOT NULL,
    "unit_price" numeric(10,2) NOT NULL,
    "discount_percentage" numeric(5,2) DEFAULT 0
);

CREATE TABLE "public"."customer_preferences" (
    "customer_id" uuid NOT NULL,
    "preferred_contact_method" varchar(20) DEFAULT 'email',
    "subscribe_to_newsletter" boolean NOT NULL DEFAULT false,
    "favorite_categories" varchar[] DEFAULT '{}',
    "last_email_sent" timestamp with time zone,
    "account_credit" numeric(8,2) DEFAULT 0,
    "loyalty_points" integer DEFAULT 0,
    "notes" jsonb
);