ALTER TABLE "public"."application_files"
ADD COLUMN "created_at" timestamp with time zone NOT NULL DEFAULT 'Now()'