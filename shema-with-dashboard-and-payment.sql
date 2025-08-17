--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: neon_auth; Type: SCHEMA; Schema: -; Owner: neondb_owner
--

CREATE SCHEMA neon_auth;


ALTER SCHEMA neon_auth OWNER TO neondb_owner;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: neondb_owner
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO neondb_owner;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: neondb_owner
--

COMMENT ON SCHEMA public IS '';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: users_sync; Type: TABLE; Schema: neon_auth; Owner: neondb_owner
--

CREATE TABLE neon_auth.users_sync (
    raw_json jsonb NOT NULL,
    id text GENERATED ALWAYS AS ((raw_json ->> 'id'::text)) STORED NOT NULL,
    name text GENERATED ALWAYS AS ((raw_json ->> 'display_name'::text)) STORED,
    email text GENERATED ALWAYS AS ((raw_json ->> 'primary_email'::text)) STORED,
    created_at timestamp with time zone GENERATED ALWAYS AS (to_timestamp((trunc((((raw_json ->> 'signed_up_at_millis'::text))::bigint)::double precision) / (1000)::double precision))) STORED,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone
);


ALTER TABLE neon_auth.users_sync OWNER TO neondb_owner;

--
-- Name: job_application_files; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.job_application_files (
    application_file_id integer NOT NULL,
    file_name character varying(255),
    file_size character varying(45),
    file_url text,
    job_application_id integer,
    created_at timestamp with time zone DEFAULT '2025-07-06 07:22:45.360158+00'::timestamp with time zone NOT NULL
);


ALTER TABLE public.job_application_files OWNER TO neondb_owner;

--
-- Name: application_files_application_files_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.application_files_application_files_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.application_files_application_files_id_seq OWNER TO neondb_owner;

--
-- Name: application_files_application_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.application_files_application_files_id_seq OWNED BY public.job_application_files.application_file_id;


--
-- Name: job_applications; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.job_applications (
    job_application_id integer NOT NULL,
    role character varying(45),
    first_name character varying(45),
    last_name character varying(45),
    email character varying(255),
    phone character varying(45),
    portfolio character varying(255),
    experience character varying(45),
    availability character varying(45),
    cover_letter character varying(255),
    created_at timestamp with time zone DEFAULT '2025-06-27 14:18:28.071445+00'::timestamp with time zone,
    updated_at timestamp with time zone DEFAULT '2025-06-27 14:18:28.40919+00'::timestamp with time zone,
    status_id integer
);


ALTER TABLE public.job_applications OWNER TO neondb_owner;

--
-- Name: applications_application_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.applications_application_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.applications_application_id_seq OWNER TO neondb_owner;

--
-- Name: applications_application_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.applications_application_id_seq OWNED BY public.job_applications.job_application_id;


--
-- Name: budget_ranges; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.budget_ranges (
    budget_range_id integer NOT NULL,
    range_value character varying,
    range_label character varying,
    product_category_id smallint
);


ALTER TABLE public.budget_ranges OWNER TO neondb_owner;

--
-- Name: budget_ranges_budget_range_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.budget_ranges_budget_range_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.budget_ranges_budget_range_id_seq OWNER TO neondb_owner;

--
-- Name: budget_ranges_budget_range_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.budget_ranges_budget_range_id_seq OWNED BY public.budget_ranges.budget_range_id;


--
-- Name: challenges; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.challenges (
    challenge_id integer NOT NULL,
    project_id integer NOT NULL,
    title character varying(255) NOT NULL
);


ALTER TABLE public.challenges OWNER TO neondb_owner;

--
-- Name: challenges_challenge_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.challenges_challenge_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.challenges_challenge_id_seq OWNER TO neondb_owner;

--
-- Name: challenges_challenge_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.challenges_challenge_id_seq OWNED BY public.challenges.challenge_id;


--
-- Name: coupons; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.coupons (
    coupon_id integer NOT NULL,
    coupon_code character varying(45) NOT NULL,
    discount_amount numeric(5,2) NOT NULL,
    created_date timestamp without time zone NOT NULL,
    expiration_date timestamp without time zone NOT NULL,
    usage_limit integer NOT NULL
);


ALTER TABLE public.coupons OWNER TO neondb_owner;

--
-- Name: coupons_coupon_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.coupons_coupon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.coupons_coupon_id_seq OWNER TO neondb_owner;

--
-- Name: coupons_coupon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.coupons_coupon_id_seq OWNED BY public.coupons.coupon_id;


--
-- Name: course_enrollment; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.course_enrollment (
    course_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.course_enrollment OWNER TO neondb_owner;

--
-- Name: courses; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.courses (
    course_id integer NOT NULL,
    user_id integer NOT NULL,
    title character varying(255) NOT NULL,
    published boolean NOT NULL,
    date timestamp without time zone NOT NULL,
    description character varying(255) NOT NULL,
    price numeric(5,2) NOT NULL,
    duration character varying(45) NOT NULL
);


ALTER TABLE public.courses OWNER TO neondb_owner;

--
-- Name: courses_course_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.courses_course_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.courses_course_id_seq OWNER TO neondb_owner;

--
-- Name: courses_course_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.courses_course_id_seq OWNED BY public.courses.course_id;


--
-- Name: custom_offer_statuses; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.custom_offer_statuses (
    offer_status_id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.custom_offer_statuses OWNER TO neondb_owner;

--
-- Name: custom_offer_statuses_offer_status_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.custom_offer_statuses_offer_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.custom_offer_statuses_offer_status_id_seq OWNER TO neondb_owner;

--
-- Name: custom_offer_statuses_offer_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.custom_offer_statuses_offer_status_id_seq OWNED BY public.custom_offer_statuses.offer_status_id;


--
-- Name: custom_offers; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.custom_offers (
    offer_id integer NOT NULL,
    order_id integer NOT NULL,
    user_id integer NOT NULL,
    offer_amount_in_kobo integer NOT NULL,
    description text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    status_id integer NOT NULL,
    expires_at timestamp with time zone DEFAULT (now() + '48:00:00'::interval),
    rejection_reason text,
    project_duration_days integer,
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.custom_offers OWNER TO neondb_owner;

--
-- Name: custom_offers_offer_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.custom_offers_offer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.custom_offers_offer_id_seq OWNER TO neondb_owner;

--
-- Name: custom_offers_offer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.custom_offers_offer_id_seq OWNED BY public.custom_offers.offer_id;


--
-- Name: invoices; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.invoices (
    invoice_id integer NOT NULL,
    order_id integer NOT NULL,
    total_amount numeric(5,2) NOT NULL,
    date timestamp without time zone NOT NULL,
    duedate timestamp without time zone NOT NULL,
    status character varying(45) NOT NULL
);


ALTER TABLE public.invoices OWNER TO neondb_owner;

--
-- Name: invoices_invoice_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.invoices_invoice_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.invoices_invoice_id_seq OWNER TO neondb_owner;

--
-- Name: invoices_invoice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.invoices_invoice_id_seq OWNED BY public.invoices.invoice_id;


--
-- Name: job_app_app_files; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.job_app_app_files (
    job_application_id integer NOT NULL,
    application_file_id integer NOT NULL
);


ALTER TABLE public.job_app_app_files OWNER TO neondb_owner;

--
-- Name: job_app_statuses; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.job_app_statuses (
    status_id integer NOT NULL,
    status_name character varying(50) NOT NULL
);


ALTER TABLE public.job_app_statuses OWNER TO neondb_owner;

--
-- Name: job_app_statuses_status_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.job_app_statuses_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.job_app_statuses_status_id_seq OWNER TO neondb_owner;

--
-- Name: job_app_statuses_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.job_app_statuses_status_id_seq OWNED BY public.job_app_statuses.status_id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.notifications (
    notification_id integer NOT NULL,
    user_id integer NOT NULL,
    title character varying(255) NOT NULL,
    message text NOT NULL,
    is_read boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    link character varying(255)
);


ALTER TABLE public.notifications OWNER TO neondb_owner;

--
-- Name: notifications_notification_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.notifications_notification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notifications_notification_id_seq OWNER TO neondb_owner;

--
-- Name: notifications_notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.notifications_notification_id_seq OWNED BY public.notifications.notification_id;


--
-- Name: order_coupons; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.order_coupons (
    order_id integer NOT NULL,
    coupon_id integer NOT NULL
);


ALTER TABLE public.order_coupons OWNER TO neondb_owner;

--
-- Name: order_files; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.order_files (
    order_file_id integer NOT NULL,
    file_name character varying(255),
    file_size character varying(45),
    file_url text NOT NULL,
    order_id smallint,
    created_at timestamp with time zone DEFAULT '2025-07-06 07:30:35.152621+00'::timestamp with time zone NOT NULL
);


ALTER TABLE public.order_files OWNER TO neondb_owner;

--
-- Name: order_files_order_file_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.order_files_order_file_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_files_order_file_id_seq OWNER TO neondb_owner;

--
-- Name: order_files_order_file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.order_files_order_file_id_seq OWNED BY public.order_files.order_file_id;


--
-- Name: order_order_files; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.order_order_files (
    order_id integer NOT NULL,
    order_file_id integer NOT NULL
);


ALTER TABLE public.order_order_files OWNER TO neondb_owner;

--
-- Name: order_statuses; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.order_statuses (
    order_status_id integer NOT NULL,
    name character varying(45)
);


ALTER TABLE public.order_statuses OWNER TO neondb_owner;

--
-- Name: order_statuses_order_status_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.order_statuses_order_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_statuses_order_status_id_seq OWNER TO neondb_owner;

--
-- Name: order_statuses_order_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.order_statuses_order_status_id_seq OWNED BY public.order_statuses.order_status_id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.orders (
    order_id integer NOT NULL,
    user_id integer NOT NULL,
    category_id integer NOT NULL,
    title character varying(45),
    project_description character varying(255),
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    thumbnail character varying(255),
    order_status_id integer,
    budget_range character varying(45),
    timeline character varying(45),
    total_expected_amount_kobo integer DEFAULT 0 NOT NULL,
    amount_paid_to_date_kobo integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    is_portfolio boolean DEFAULT false,
    tracking_id character varying(100),
    offer_id integer
);


ALTER TABLE public.orders OWNER TO neondb_owner;

--
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

ALTER TABLE public.orders ALTER COLUMN order_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.orders_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: payments; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.payments (
    payment_id integer NOT NULL,
    order_id integer,
    paystack_reference character varying(255) NOT NULL,
    amount_kobo integer NOT NULL,
    currency character varying(10) NOT NULL,
    paystack_status character varying(45) NOT NULL,
    gateway_response text,
    customer_email character varying(255) NOT NULL,
    is_fraudulent boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT '2025-06-20 07:45:26.581799+00'::timestamp with time zone,
    updated_at timestamp without time zone DEFAULT '2025-06-20 07:45:26.581799'::timestamp without time zone,
    payment_option_selected character varying(50),
    discount_applied_percentage numeric(5,2)
);


ALTER TABLE public.payments OWNER TO neondb_owner;

--
-- Name: payments_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.payments_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payments_payment_id_seq OWNER TO neondb_owner;

--
-- Name: payments_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.payments_payment_id_seq OWNED BY public.payments.payment_id;


--
-- Name: product_budget_ranges; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.product_budget_ranges (
    product_budget_range_id integer NOT NULL,
    project_category_id smallint,
    budget_range_id smallint
);


ALTER TABLE public.product_budget_ranges OWNER TO neondb_owner;

--
-- Name: product_budget_ranges_product_budget_range_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.product_budget_ranges_product_budget_range_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_budget_ranges_product_budget_range_id_seq OWNER TO neondb_owner;

--
-- Name: product_budget_ranges_product_budget_range_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.product_budget_ranges_product_budget_range_id_seq OWNED BY public.product_budget_ranges.product_budget_range_id;


--
-- Name: product_categories; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.product_categories (
    category_id integer NOT NULL,
    category_name character varying(45) NOT NULL,
    category_description character varying(255),
    accepted_files character varying(255)
);


ALTER TABLE public.product_categories OWNER TO neondb_owner;

--
-- Name: product_categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.product_categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_categories_category_id_seq OWNER TO neondb_owner;

--
-- Name: product_categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.product_categories_category_id_seq OWNED BY public.product_categories.category_id;


--
-- Name: product_orders; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.product_orders (
    order_id integer NOT NULL,
    product_id integer NOT NULL
);


ALTER TABLE public.product_orders OWNER TO neondb_owner;

--
-- Name: products; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.products (
    product_id integer NOT NULL,
    category_id integer NOT NULL,
    name character varying(45) NOT NULL,
    description character varying(255) NOT NULL,
    price numeric(5,2) NOT NULL
);


ALTER TABLE public.products OWNER TO neondb_owner;

--
-- Name: products_product_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_product_id_seq OWNER TO neondb_owner;

--
-- Name: products_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.products_product_id_seq OWNED BY public.products.product_id;


--
-- Name: project_owner; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.project_owner (
    userid integer NOT NULL,
    projectid integer NOT NULL
);


ALTER TABLE public.project_owner OWNER TO neondb_owner;

--
-- Name: project_status; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.project_status (
    project_status_id integer NOT NULL,
    status character varying(45) NOT NULL
);


ALTER TABLE public.project_status OWNER TO neondb_owner;

--
-- Name: project_status_project_status_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.project_status_project_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_status_project_status_id_seq OWNER TO neondb_owner;

--
-- Name: project_status_project_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.project_status_project_status_id_seq OWNED BY public.project_status.project_status_id;


--
-- Name: project_status_status; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.project_status_status (
    project_id integer NOT NULL,
    project_status_id integer NOT NULL
);


ALTER TABLE public.project_status_status OWNER TO neondb_owner;

--
-- Name: project_tools; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.project_tools (
    project_id integer NOT NULL,
    tool_id integer NOT NULL
);


ALTER TABLE public.project_tools OWNER TO neondb_owner;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.roles (
    role_id integer NOT NULL,
    role_name character varying(45) NOT NULL
);


ALTER TABLE public.roles OWNER TO neondb_owner;

--
-- Name: roles_role_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.roles_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_role_id_seq OWNER TO neondb_owner;

--
-- Name: roles_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.roles_role_id_seq OWNED BY public.roles.role_id;


--
-- Name: secure_tokens; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.secure_tokens (
    id uuid NOT NULL,
    token text NOT NULL,
    offer_id integer,
    action text,
    expires_at timestamp with time zone,
    used boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.secure_tokens OWNER TO neondb_owner;

--
-- Name: solutions; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.solutions (
    solution_id integer NOT NULL,
    challenge_id integer NOT NULL,
    title character varying(255) NOT NULL
);


ALTER TABLE public.solutions OWNER TO neondb_owner;

--
-- Name: solutions_solution_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.solutions_solution_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.solutions_solution_id_seq OWNER TO neondb_owner;

--
-- Name: solutions_solution_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.solutions_solution_id_seq OWNED BY public.solutions.solution_id;


--
-- Name: testimonials; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.testimonials (
    testimonial_id integer NOT NULL,
    user_id integer NOT NULL,
    rating integer NOT NULL,
    review character varying(255),
    date timestamp without time zone NOT NULL
);


ALTER TABLE public.testimonials OWNER TO neondb_owner;

--
-- Name: testimonials_testimonial_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.testimonials_testimonial_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.testimonials_testimonial_id_seq OWNER TO neondb_owner;

--
-- Name: testimonials_testimonial_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.testimonials_testimonial_id_seq OWNED BY public.testimonials.testimonial_id;


--
-- Name: timelines; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.timelines (
    timeline_id integer NOT NULL,
    timeline_value character varying,
    timeline_label character varying,
    product_category_id smallint
);


ALTER TABLE public.timelines OWNER TO neondb_owner;

--
-- Name: todos; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.todos (
    todo_id integer NOT NULL,
    project_id integer NOT NULL,
    titile character varying(255) NOT NULL,
    status character varying(45) NOT NULL
);


ALTER TABLE public.todos OWNER TO neondb_owner;

--
-- Name: todos_todo_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.todos_todo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.todos_todo_id_seq OWNER TO neondb_owner;

--
-- Name: todos_todo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.todos_todo_id_seq OWNED BY public.todos.todo_id;


--
-- Name: tools; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.tools (
    tool_id integer NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE public.tools OWNER TO neondb_owner;

--
-- Name: tools_tool_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.tools_tool_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tools_tool_id_seq OWNER TO neondb_owner;

--
-- Name: tools_tool_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.tools_tool_id_seq OWNED BY public.tools.tool_id;


--
-- Name: user_coupons; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.user_coupons (
    user_id integer,
    coupon_id integer,
    user_coupon_id integer NOT NULL
);


ALTER TABLE public.user_coupons OWNER TO neondb_owner;

--
-- Name: user_coupons_user_coupon_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.user_coupons_user_coupon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_coupons_user_coupon_id_seq OWNER TO neondb_owner;

--
-- Name: user_coupons_user_coupon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.user_coupons_user_coupon_id_seq OWNED BY public.user_coupons.user_coupon_id;


--
-- Name: user_roles; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.user_roles (
    user_role_id integer NOT NULL,
    role_id integer,
    user_id integer
);


ALTER TABLE public.user_roles OWNER TO neondb_owner;

--
-- Name: user_roles_user_role_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.user_roles_user_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_roles_user_role_id_seq OWNER TO neondb_owner;

--
-- Name: user_roles_user_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.user_roles_user_role_id_seq OWNED BY public.user_roles.user_role_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    first_name character varying(45) NOT NULL,
    last_name character varying(45) NOT NULL,
    email character varying(255) NOT NULL,
    password text,
    bio character varying(255),
    profile_picture_url character varying(255),
    company_name character varying(255),
    phone character varying(45),
    created_at timestamp with time zone DEFAULT '2025-06-20 08:11:26.304144+00'::timestamp with time zone NOT NULL,
    updated_at timestamp with time zone DEFAULT '2025-06-20 08:12:14.117883+00'::timestamp with time zone NOT NULL,
    email_verified boolean DEFAULT false
);


ALTER TABLE public.users OWNER TO neondb_owner;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO neondb_owner;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: verification_tokens; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.verification_tokens (
    id integer NOT NULL,
    user_id integer NOT NULL,
    token character varying(255) NOT NULL,
    expires timestamp with time zone NOT NULL,
    type character varying(50) DEFAULT 'email_verification'::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.verification_tokens OWNER TO neondb_owner;

--
-- Name: verification_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.verification_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.verification_tokens_id_seq OWNER TO neondb_owner;

--
-- Name: verification_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.verification_tokens_id_seq OWNED BY public.verification_tokens.id;


--
-- Name: budget_ranges budget_range_id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.budget_ranges ALTER COLUMN budget_range_id SET DEFAULT nextval('public.budget_ranges_budget_range_id_seq'::regclass);


--
-- Name: challenges challenge_id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.challenges ALTER COLUMN challenge_id SET DEFAULT nextval('public.challenges_challenge_id_seq'::regclass);


--
-- Name: coupons coupon_id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.coupons ALTER COLUMN coupon_id SET DEFAULT nextval('public.coupons_coupon_id_seq'::regclass);


--
-- Name: courses course_id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.courses ALTER COLUMN course_id SET DEFAULT nextval('public.courses_course_id_seq'::regclass);


--
-- Name: custom_offer_statuses offer_status_id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.custom_offer_statuses ALTER COLUMN offer_status_id SET DEFAULT nextval('public.custom_offer_statuses_offer_status_id_seq'::regclass);


--
-- Name: custom_offers offer_id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.custom_offers ALTER COLUMN offer_id SET DEFAULT nextval('public.custom_offers_offer_id_seq'::regclass);


--
-- Name: invoices invoice_id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.invoices ALTER COLUMN invoice_id SET DEFAULT nextval('public.invoices_invoice_id_seq'::regclass);


--
-- Name: job_app_statuses status_id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.job_app_statuses ALTER COLUMN status_id SET DEFAULT nextval('public.job_app_statuses_status_id_seq'::regclass);


--
-- Name: job_application_files application_file_id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.job_application_files ALTER COLUMN application_file_id SET DEFAULT nextval('public.application_files_application_files_id_seq'::regclass);


--
-- Name: job_applications job_application_id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.job_applications ALTER COLUMN job_application_id SET DEFAULT nextval('public.applications_application_id_seq'::regclass);


--
-- Name: notifications notification_id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.notifications ALTER COLUMN notification_id SET DEFAULT nextval('public.notifications_notification_id_seq'::regclass);


--
-- Name: order_files order_file_id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.order_files ALTER COLUMN order_file_id SET DEFAULT nextval('public.order_files_order_file_id_seq'::regclass);


--
-- Name: order_statuses order_status_id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.order_statuses ALTER COLUMN order_status_id SET DEFAULT nextval('public.order_statuses_order_status_id_seq'::regclass);


--
-- Name: payments payment_id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payments ALTER COLUMN payment_id SET DEFAULT nextval('public.payments_payment_id_seq'::regclass);


--
-- Name: product_budget_ranges product_budget_range_id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.product_budget_ranges ALTER COLUMN product_budget_range_id SET DEFAULT nextval('public.product_budget_ranges_product_budget_range_id_seq'::regclass);


--
-- Name: product_categories category_id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.product_categories ALTER COLUMN category_id SET DEFAULT nextval('public.product_categories_category_id_seq'::regclass);


--
-- Name: products product_id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.products ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);


--
-- Name: project_status project_status_id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_status ALTER COLUMN project_status_id SET DEFAULT nextval('public.project_status_project_status_id_seq'::regclass);


--
-- Name: roles role_id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.roles ALTER COLUMN role_id SET DEFAULT nextval('public.roles_role_id_seq'::regclass);


--
-- Name: solutions solution_id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.solutions ALTER COLUMN solution_id SET DEFAULT nextval('public.solutions_solution_id_seq'::regclass);


--
-- Name: testimonials testimonial_id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.testimonials ALTER COLUMN testimonial_id SET DEFAULT nextval('public.testimonials_testimonial_id_seq'::regclass);


--
-- Name: todos todo_id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.todos ALTER COLUMN todo_id SET DEFAULT nextval('public.todos_todo_id_seq'::regclass);


--
-- Name: tools tool_id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.tools ALTER COLUMN tool_id SET DEFAULT nextval('public.tools_tool_id_seq'::regclass);


--
-- Name: user_coupons user_coupon_id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.user_coupons ALTER COLUMN user_coupon_id SET DEFAULT nextval('public.user_coupons_user_coupon_id_seq'::regclass);


--
-- Name: user_roles user_role_id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.user_roles ALTER COLUMN user_role_id SET DEFAULT nextval('public.user_roles_user_role_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Name: verification_tokens id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.verification_tokens ALTER COLUMN id SET DEFAULT nextval('public.verification_tokens_id_seq'::regclass);


--
-- Data for Name: users_sync; Type: TABLE DATA; Schema: neon_auth; Owner: neondb_owner
--

COPY neon_auth.users_sync (raw_json, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: budget_ranges; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.budget_ranges (budget_range_id, range_value, range_label, product_category_id) FROM stdin;
1	500-1000	500 - 1,000	3
2	1000-2000	1,000 - 2,000	3
3	2000-3000	2,000 - 3,000	3
4	3000+	3000+	3
5	200-500	200 - 500	1
6	500-1000	500 - 1000	1
7	1000-3000	1000 - 3000	1
8	3000+	3000+	1
9	200-500	200 - 500	2
10	500-1000	500 - 1000	2
11	1000-3000	1000 - 3000	2
12	3000+	3000+	2
13	1000-2000	1,000 - 2,000	4
14	2000-4000	2000 - 4000	4
15	4000-8000	4000 - 8000	4
16	8000+	8000+	4
17	100-500	100 - 500	5
18	500-1000	500 - 1000	5
19	1000-2000	1000 - 2000	5
20	2000+	2000	5
21	20-50	20 - 50	6
22	50-100	50 - 100	6
23	100-500	100 - 500	6
24	500+	500+	6
25	100-300	100 - 300	7
26	300-600	300 - 600	7
27	600-900	600 - 900	7
28	900+	900+	7
\.


--
-- Data for Name: challenges; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.challenges (challenge_id, project_id, title) FROM stdin;
\.


--
-- Data for Name: coupons; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.coupons (coupon_id, coupon_code, discount_amount, created_date, expiration_date, usage_limit) FROM stdin;
\.


--
-- Data for Name: course_enrollment; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.course_enrollment (course_id, user_id) FROM stdin;
\.


--
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.courses (course_id, user_id, title, published, date, description, price, duration) FROM stdin;
\.


--
-- Data for Name: custom_offer_statuses; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.custom_offer_statuses (offer_status_id, name) FROM stdin;
1	pending
2	accepted
3	rejected
4	expired
\.


--
-- Data for Name: custom_offers; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.custom_offers (offer_id, order_id, user_id, offer_amount_in_kobo, description, created_at, status_id, expires_at, rejection_reason, project_duration_days, updated_at) FROM stdin;
\.


--
-- Data for Name: invoices; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.invoices (invoice_id, order_id, total_amount, date, duedate, status) FROM stdin;
\.


--
-- Data for Name: job_app_app_files; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.job_app_app_files (job_application_id, application_file_id) FROM stdin;
\.


--
-- Data for Name: job_app_statuses; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.job_app_statuses (status_id, status_name) FROM stdin;
1	pending
2	employed
\.


--
-- Data for Name: job_application_files; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.job_application_files (application_file_id, file_name, file_size, file_url, job_application_id, created_at) FROM stdin;
\.


--
-- Data for Name: job_applications; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.job_applications (job_application_id, role, first_name, last_name, email, phone, portfolio, experience, availability, cover_letter, created_at, updated_at, status_id) FROM stdin;
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.notifications (notification_id, user_id, title, message, is_read, created_at, link) FROM stdin;
\.


--
-- Data for Name: order_coupons; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.order_coupons (order_id, coupon_id) FROM stdin;
\.


--
-- Data for Name: order_files; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.order_files (order_file_id, file_name, file_size, file_url, order_id, created_at) FROM stdin;
\.


--
-- Data for Name: order_order_files; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.order_order_files (order_id, order_file_id) FROM stdin;
\.


--
-- Data for Name: order_statuses; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.order_statuses (order_status_id, name) FROM stdin;
1	paid
2	partially_paid
3	pending
4	failed
5	currency_mismatch
6	overpayment_detected
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.orders (order_id, user_id, category_id, title, project_description, start_date, end_date, thumbnail, order_status_id, budget_range, timeline, total_expected_amount_kobo, amount_paid_to_date_kobo, created_at, updated_at, is_portfolio, tracking_id, offer_id) FROM stdin;
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.payments (payment_id, order_id, paystack_reference, amount_kobo, currency, paystack_status, gateway_response, customer_email, is_fraudulent, created_at, updated_at, payment_option_selected, discount_applied_percentage) FROM stdin;
\.


--
-- Data for Name: product_budget_ranges; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.product_budget_ranges (product_budget_range_id, project_category_id, budget_range_id) FROM stdin;
\.


--
-- Data for Name: product_categories; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.product_categories (category_id, category_name, category_description, accepted_files) FROM stdin;
3	3D Modeling & Animation	Professional 3D modeling, animation, and visualization services for your projects.	.fbx,.obj,.blend,.3ds,.max,.dae,.glb,.stl
5	UiUx Design	User-centered design solutions that enhance user experience.	.psd,.ai,.sketch,.fig,.xd,.pdf,.png,.jpg
7	Training Services	Your kids will love to learn 3D modeling and animation with our simple and easy to understand training services.	.pdf,.docx,.txt,.png,.jpg
1	Web Development	Custom web applications and websites built with modern technologies.	.zip,.rar,.pdf,.doc,.docx,.txt.,ai,.psd,.fig,.png,.jpg
2	Mobile App	Custom mobile applications for iOS and Android platforms, built with apache cordova. React Native coming soon	.zip,.rar,.pdf,.doc,.docx,.txt.,ai,.psd,.fig,.png,.jpg
4	Game Development	Engaging game development services for various platforms.	.unity,.uproject,.fbx,.obj,.blend,.pdf,.zip,.rar,.docx
6	Video & Voice Over	Professional voice-over services for your videos, games, and multimedia projects.	.mp3,.wav,.ogg,.aac,.m4a,.pdf,.docx,.txt,.png,.jpg
\.


--
-- Data for Name: product_orders; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.product_orders (order_id, product_id) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.products (product_id, category_id, name, description, price) FROM stdin;
\.


--
-- Data for Name: project_owner; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.project_owner (userid, projectid) FROM stdin;
\.


--
-- Data for Name: project_status; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.project_status (project_status_id, status) FROM stdin;
\.


--
-- Data for Name: project_status_status; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.project_status_status (project_id, project_status_id) FROM stdin;
\.


--
-- Data for Name: project_tools; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.project_tools (project_id, tool_id) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.roles (role_id, role_name) FROM stdin;
1	admin
2	customer
3	freelancer
4	author
5	student
6	user
7	guest
\.


--
-- Data for Name: secure_tokens; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.secure_tokens (id, token, offer_id, action, expires_at, used, created_at) FROM stdin;
\.


--
-- Data for Name: solutions; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.solutions (solution_id, challenge_id, title) FROM stdin;
\.


--
-- Data for Name: testimonials; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.testimonials (testimonial_id, user_id, rating, review, date) FROM stdin;
\.


--
-- Data for Name: timelines; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.timelines (timeline_id, timeline_value, timeline_label, product_category_id) FROM stdin;
7	4months+	4months+	1
1	1-2months	1-2months	3
2	2-3months	2-3months	3
3	3-6months	3-6months	3
5	1-2months	1-2months	1
6	2-4months	2-4months	1
4	2-4weeks	2-4weeks	1
8	2-4weeks	2-4 weeks	2
9	1-2months	1-2 months	2
10	2-4months	2-4 months	2
11	4months+	4 months+	2
12	3-6months	3-6 months	4
13	6-12months	6-12 months	4
14	12months+	12 months+	4
15	2-4weeks	2-4 weeks	5
16	1-2months	1-2 months	5
17	2-4months	2-4 months	5
18	4months+	4 months+	5
19	1-2days	1-2 days	6
20	2-5days	2-5 days	6
21	5-10days	5-10 days	6
22	10days+	10 days+	6
23	1-2days	1-2 days	7
24	2-5days	2-5 days	7
25	5-10days	5-10 days	7
26	10days+	10 days+	7
\.


--
-- Data for Name: todos; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.todos (todo_id, project_id, titile, status) FROM stdin;
\.


--
-- Data for Name: tools; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.tools (tool_id, name) FROM stdin;
\.


--
-- Data for Name: user_coupons; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.user_coupons (user_id, coupon_id, user_coupon_id) FROM stdin;
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.user_roles (user_role_id, role_id, user_id) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.users (user_id, first_name, last_name, email, password, bio, profile_picture_url, company_name, phone, created_at, updated_at, email_verified) FROM stdin;
\.


--
-- Data for Name: verification_tokens; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.verification_tokens (id, user_id, token, expires, type, created_at) FROM stdin;
\.


--
-- Name: application_files_application_files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.application_files_application_files_id_seq', 1, false);


--
-- Name: applications_application_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.applications_application_id_seq', 1, false);


--
-- Name: budget_ranges_budget_range_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.budget_ranges_budget_range_id_seq', 1, false);


--
-- Name: challenges_challenge_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.challenges_challenge_id_seq', 1, false);


--
-- Name: coupons_coupon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.coupons_coupon_id_seq', 1, false);


--
-- Name: courses_course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.courses_course_id_seq', 1, false);


--
-- Name: custom_offer_statuses_offer_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.custom_offer_statuses_offer_status_id_seq', 4, true);


--
-- Name: custom_offers_offer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.custom_offers_offer_id_seq', 87, true);


--
-- Name: invoices_invoice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.invoices_invoice_id_seq', 1, false);


--
-- Name: job_app_statuses_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.job_app_statuses_status_id_seq', 2, true);


--
-- Name: notifications_notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.notifications_notification_id_seq', 46, true);


--
-- Name: order_files_order_file_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.order_files_order_file_id_seq', 1, false);


--
-- Name: order_statuses_order_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.order_statuses_order_status_id_seq', 7, true);


--
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.orders_order_id_seq', 34, true);


--
-- Name: payments_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.payments_payment_id_seq', 25, true);


--
-- Name: product_budget_ranges_product_budget_range_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.product_budget_ranges_product_budget_range_id_seq', 1, false);


--
-- Name: product_categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.product_categories_category_id_seq', 1, false);


--
-- Name: products_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.products_product_id_seq', 1, false);


--
-- Name: project_status_project_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.project_status_project_status_id_seq', 1, false);


--
-- Name: roles_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.roles_role_id_seq', 1, true);


--
-- Name: solutions_solution_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.solutions_solution_id_seq', 1, false);


--
-- Name: testimonials_testimonial_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.testimonials_testimonial_id_seq', 1, false);


--
-- Name: todos_todo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.todos_todo_id_seq', 1, false);


--
-- Name: tools_tool_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.tools_tool_id_seq', 1, false);


--
-- Name: user_coupons_user_coupon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.user_coupons_user_coupon_id_seq', 1, false);


--
-- Name: user_roles_user_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.user_roles_user_role_id_seq', 9, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.users_user_id_seq', 27, true);


--
-- Name: verification_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.verification_tokens_id_seq', 6, true);


--
-- Name: users_sync users_sync_pkey; Type: CONSTRAINT; Schema: neon_auth; Owner: neondb_owner
--

ALTER TABLE ONLY neon_auth.users_sync
    ADD CONSTRAINT users_sync_pkey PRIMARY KEY (id);


--
-- Name: job_app_app_files application_application_files_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.job_app_app_files
    ADD CONSTRAINT application_application_files_pkey PRIMARY KEY (job_application_id, application_file_id);


--
-- Name: job_application_files application_files_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.job_application_files
    ADD CONSTRAINT application_files_pkey PRIMARY KEY (application_file_id);


--
-- Name: job_applications applications_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.job_applications
    ADD CONSTRAINT applications_pkey PRIMARY KEY (job_application_id);


--
-- Name: budget_ranges budget_ranges_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.budget_ranges
    ADD CONSTRAINT budget_ranges_pkey PRIMARY KEY (budget_range_id);


--
-- Name: product_categories category_name_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT category_name_unique UNIQUE (category_name);


--
-- Name: challenges challenges_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.challenges
    ADD CONSTRAINT challenges_pkey PRIMARY KEY (challenge_id);


--
-- Name: coupons coupons_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.coupons
    ADD CONSTRAINT coupons_pkey PRIMARY KEY (coupon_id);


--
-- Name: course_enrollment course_enrollment_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.course_enrollment
    ADD CONSTRAINT course_enrollment_pkey PRIMARY KEY (course_id, user_id);


--
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (course_id);


--
-- Name: custom_offer_statuses custom_offer_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.custom_offer_statuses
    ADD CONSTRAINT custom_offer_statuses_pkey PRIMARY KEY (offer_status_id);


--
-- Name: custom_offers custom_offers_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.custom_offers
    ADD CONSTRAINT custom_offers_pkey PRIMARY KEY (offer_id);


--
-- Name: users email_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT email_unique UNIQUE (email);


--
-- Name: invoices invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_pkey PRIMARY KEY (invoice_id);


--
-- Name: job_app_statuses job_app_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.job_app_statuses
    ADD CONSTRAINT job_app_statuses_pkey PRIMARY KEY (status_id);


--
-- Name: products name_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT name_unique UNIQUE (name);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (notification_id);


--
-- Name: order_coupons order_coupons_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.order_coupons
    ADD CONSTRAINT order_coupons_pkey PRIMARY KEY (order_id, coupon_id);


--
-- Name: order_files order_files_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.order_files
    ADD CONSTRAINT order_files_pkey PRIMARY KEY (order_file_id);


--
-- Name: order_order_files order_order_files_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.order_order_files
    ADD CONSTRAINT order_order_files_pkey PRIMARY KEY (order_id, order_file_id);


--
-- Name: order_statuses order_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.order_statuses
    ADD CONSTRAINT order_statuses_pkey PRIMARY KEY (order_status_id);


--
-- Name: payments payments_paystack_reference_key; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_paystack_reference_key UNIQUE (paystack_reference);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (payment_id);


--
-- Name: product_budget_ranges product_budget_ranges_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.product_budget_ranges
    ADD CONSTRAINT product_budget_ranges_pkey PRIMARY KEY (product_budget_range_id);


--
-- Name: product_categories product_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT product_categories_pkey PRIMARY KEY (category_id);


--
-- Name: product_orders product_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.product_orders
    ADD CONSTRAINT product_orders_pkey PRIMARY KEY (order_id, product_id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- Name: project_owner project_owner_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_owner
    ADD CONSTRAINT project_owner_pkey PRIMARY KEY (userid, projectid);


--
-- Name: project_status project_status_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_status
    ADD CONSTRAINT project_status_pkey PRIMARY KEY (project_status_id);


--
-- Name: project_status_status project_status_status_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_status_status
    ADD CONSTRAINT project_status_status_pkey PRIMARY KEY (project_id, project_status_id);


--
-- Name: project_tools project_tools_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_tools
    ADD CONSTRAINT project_tools_pkey PRIMARY KEY (project_id, tool_id);


--
-- Name: orders projects_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT projects_pkey PRIMARY KEY (order_id);


--
-- Name: roles role_name_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT role_name_unique UNIQUE (role_name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (role_id);


--
-- Name: secure_tokens secure_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.secure_tokens
    ADD CONSTRAINT secure_tokens_pkey PRIMARY KEY (id);


--
-- Name: solutions solutions_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.solutions
    ADD CONSTRAINT solutions_pkey PRIMARY KEY (solution_id, challenge_id);


--
-- Name: testimonials testimonials_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.testimonials
    ADD CONSTRAINT testimonials_pkey PRIMARY KEY (testimonial_id);


--
-- Name: todos todos_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.todos
    ADD CONSTRAINT todos_pkey PRIMARY KEY (todo_id, project_id);


--
-- Name: tools tools_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.tools
    ADD CONSTRAINT tools_pkey PRIMARY KEY (tool_id);


--
-- Name: user_coupons user_coupons_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.user_coupons
    ADD CONSTRAINT user_coupons_pkey PRIMARY KEY (user_coupon_id);


--
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (user_role_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: verification_tokens verification_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.verification_tokens
    ADD CONSTRAINT verification_tokens_pkey PRIMARY KEY (id);


--
-- Name: verification_tokens verification_tokens_token_key; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.verification_tokens
    ADD CONSTRAINT verification_tokens_token_key UNIQUE (token);


--
-- Name: users_sync_deleted_at_idx; Type: INDEX; Schema: neon_auth; Owner: neondb_owner
--

CREATE INDEX users_sync_deleted_at_idx ON neon_auth.users_sync USING btree (deleted_at);


--
-- Name: fk_challenges_copy1_challenges1_idx; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX fk_challenges_copy1_challenges1_idx ON public.solutions USING btree (challenge_id);


--
-- Name: fk_challenges_projects1_idx; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX fk_challenges_projects1_idx ON public.challenges USING btree (project_id);


--
-- Name: fk_course_enrollment_users1_idx; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX fk_course_enrollment_users1_idx ON public.course_enrollment USING btree (user_id);


--
-- Name: fk_invoices_orders1_idx; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX fk_invoices_orders1_idx ON public.invoices USING btree (order_id);


--
-- Name: fk_ordercoupons_coupon1_idx; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX fk_ordercoupons_coupon1_idx ON public.order_coupons USING btree (coupon_id);


--
-- Name: fk_ordercoupons_orders1_idx; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX fk_ordercoupons_orders1_idx ON public.product_orders USING btree (order_id);


--
-- Name: fk_orderorderfiles_orderfiles1_idx; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX fk_orderorderfiles_orderfiles1_idx ON public.order_order_files USING btree (order_file_id);


--
-- Name: fk_productorders_products1_idx; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX fk_productorders_products1_idx ON public.product_orders USING btree (product_id);


--
-- Name: fk_products_category1_idx; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX fk_products_category1_idx ON public.products USING btree (category_id);


--
-- Name: fk_project_status_status_project_status1_idx; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX fk_project_status_status_project_status1_idx ON public.project_status_status USING btree (project_status_id);


--
-- Name: fk_project_tools_tools1_idx; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX fk_project_tools_tools1_idx ON public.project_tools USING btree (tool_id);


--
-- Name: fk_projectowner_projects1_idx; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX fk_projectowner_projects1_idx ON public.project_owner USING btree (projectid);


--
-- Name: fk_projects_admins_idx; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX fk_projects_admins_idx ON public.orders USING btree (user_id);


--
-- Name: fk_projects_category1_idx; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX fk_projects_category1_idx ON public.orders USING btree (category_id);


--
-- Name: fk_projecttools_projects1_idx; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX fk_projecttools_projects1_idx ON public.project_tools USING btree (project_id);


--
-- Name: fk_roles_users1_idx; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX fk_roles_users1_idx ON public.courses USING btree (user_id);


--
-- Name: fk_todos_projects1_idx; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX fk_todos_projects1_idx ON public.todos USING btree (project_id);


--
-- Name: idx_notifications_created_at; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX idx_notifications_created_at ON public.notifications USING btree (created_at DESC);


--
-- Name: idx_notifications_user_id; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX idx_notifications_user_id ON public.notifications USING btree (user_id);


--
-- Name: job_app_app_files application_application_files_application_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.job_app_app_files
    ADD CONSTRAINT application_application_files_application_file_id_fkey FOREIGN KEY (application_file_id) REFERENCES public.job_application_files(application_file_id);


--
-- Name: job_app_app_files application_application_files_application_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.job_app_app_files
    ADD CONSTRAINT application_application_files_application_id_fkey FOREIGN KEY (job_application_id) REFERENCES public.job_applications(job_application_id);


--
-- Name: product_budget_ranges constraint_1; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.product_budget_ranges
    ADD CONSTRAINT constraint_1 FOREIGN KEY (project_category_id) REFERENCES public.product_categories(category_id);


--
-- Name: job_application_files constraint_1; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.job_application_files
    ADD CONSTRAINT constraint_1 FOREIGN KEY (job_application_id) REFERENCES public.job_applications(job_application_id);


--
-- Name: payments constraint_1; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT constraint_1 FOREIGN KEY (order_id) REFERENCES public.orders(order_id);


--
-- Name: product_budget_ranges constraint_2; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.product_budget_ranges
    ADD CONSTRAINT constraint_2 FOREIGN KEY (budget_range_id) REFERENCES public.budget_ranges(budget_range_id);


--
-- Name: order_files constraint_2; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.order_files
    ADD CONSTRAINT constraint_2 FOREIGN KEY (order_id) REFERENCES public.orders(order_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_coupons constraint_coupon_id; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.user_coupons
    ADD CONSTRAINT constraint_coupon_id FOREIGN KEY (coupon_id) REFERENCES public.coupons(coupon_id);


--
-- Name: budget_ranges constraint_product_category; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.budget_ranges
    ADD CONSTRAINT constraint_product_category FOREIGN KEY (product_category_id) REFERENCES public.product_categories(category_id) ON UPDATE CASCADE;


--
-- Name: user_coupons constraint_user_id; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.user_coupons
    ADD CONSTRAINT constraint_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: solutions fk_challenges_copy1_challenges1; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.solutions
    ADD CONSTRAINT fk_challenges_copy1_challenges1 FOREIGN KEY (challenge_id) REFERENCES public.challenges(challenge_id) ON UPDATE CASCADE;


--
-- Name: challenges fk_challenges_projects1; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.challenges
    ADD CONSTRAINT fk_challenges_projects1 FOREIGN KEY (project_id) REFERENCES public.orders(order_id) ON UPDATE CASCADE;


--
-- Name: course_enrollment fk_course_enrollment_courses1; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.course_enrollment
    ADD CONSTRAINT fk_course_enrollment_courses1 FOREIGN KEY (course_id) REFERENCES public.courses(course_id) ON UPDATE CASCADE;


--
-- Name: course_enrollment fk_course_enrollment_users1; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.course_enrollment
    ADD CONSTRAINT fk_course_enrollment_users1 FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE;


--
-- Name: orders fk_offer; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_offer FOREIGN KEY (offer_id) REFERENCES public.custom_offers(offer_id) ON UPDATE CASCADE;


--
-- Name: custom_offers fk_offer_status; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.custom_offers
    ADD CONSTRAINT fk_offer_status FOREIGN KEY (status_id) REFERENCES public.custom_offer_statuses(offer_status_id) ON UPDATE CASCADE;


--
-- Name: custom_offers fk_order_id; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.custom_offers
    ADD CONSTRAINT fk_order_id FOREIGN KEY (order_id) REFERENCES public.orders(order_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_coupons fk_ordercoupons_coupon1; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.order_coupons
    ADD CONSTRAINT fk_ordercoupons_coupon1 FOREIGN KEY (coupon_id) REFERENCES public.coupons(coupon_id) ON UPDATE CASCADE;


--
-- Name: order_order_files fk_orderorderfiles_orderfiles1; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.order_order_files
    ADD CONSTRAINT fk_orderorderfiles_orderfiles1 FOREIGN KEY (order_file_id) REFERENCES public.order_files(order_file_id) ON UPDATE CASCADE;


--
-- Name: product_orders fk_productorders_products1; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.product_orders
    ADD CONSTRAINT fk_productorders_products1 FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON UPDATE CASCADE;


--
-- Name: products fk_products_category1; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT fk_products_category1 FOREIGN KEY (category_id) REFERENCES public.product_categories(category_id) ON UPDATE CASCADE;


--
-- Name: project_owner fk_project_owner_projects1; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_owner
    ADD CONSTRAINT fk_project_owner_projects1 FOREIGN KEY (projectid) REFERENCES public.orders(order_id) ON UPDATE CASCADE;


--
-- Name: project_owner fk_project_owner_users1; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_owner
    ADD CONSTRAINT fk_project_owner_users1 FOREIGN KEY (userid) REFERENCES public.users(user_id) ON UPDATE CASCADE;


--
-- Name: project_status_status fk_project_status_status_project_status1; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_status_status
    ADD CONSTRAINT fk_project_status_status_project_status1 FOREIGN KEY (project_status_id) REFERENCES public.project_status(project_status_id);


--
-- Name: project_status_status fk_project_status_status_projects1; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_status_status
    ADD CONSTRAINT fk_project_status_status_projects1 FOREIGN KEY (project_id) REFERENCES public.orders(order_id);


--
-- Name: project_tools fk_project_tools_tools1; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_tools
    ADD CONSTRAINT fk_project_tools_tools1 FOREIGN KEY (tool_id) REFERENCES public.tools(tool_id);


--
-- Name: orders fk_projects_admins; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_projects_admins FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: orders fk_projects_category1; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_projects_category1 FOREIGN KEY (category_id) REFERENCES public.product_categories(category_id) ON UPDATE CASCADE;


--
-- Name: project_tools fk_projecttools_projects1; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_tools
    ADD CONSTRAINT fk_projecttools_projects1 FOREIGN KEY (project_id) REFERENCES public.orders(order_id) ON UPDATE CASCADE;


--
-- Name: testimonials fk_roles_users100; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.testimonials
    ADD CONSTRAINT fk_roles_users100 FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE;


--
-- Name: courses fk_roles_users1000; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT fk_roles_users1000 FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE;


--
-- Name: job_applications fk_status_id; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.job_applications
    ADD CONSTRAINT fk_status_id FOREIGN KEY (status_id) REFERENCES public.job_app_statuses(status_id) ON UPDATE CASCADE;


--
-- Name: todos fk_todos_projects1; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.todos
    ADD CONSTRAINT fk_todos_projects1 FOREIGN KEY (project_id) REFERENCES public.orders(order_id);


--
-- Name: custom_offers fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.custom_offers
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: notifications notifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: user_roles user_roles_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(role_id);


--
-- Name: user_roles user_roles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: verification_tokens verification_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.verification_tokens
    ADD CONSTRAINT verification_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: neondb_owner
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

