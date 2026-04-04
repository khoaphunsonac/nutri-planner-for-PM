--
-- PostgreSQL database dump
--

\restrict ankZcfpnaSNfpRzSYuug2RgZHJnYmPDVOS2WFQYcjhA5abbLwcnoc496PxfgV9U

-- Dumped from database version 17.8 (a48d9ca)
-- Dumped by pg_dump version 18.3 (Ubuntu 18.3-1.pgdg24.04+1)

-- Started on 2026-04-04 14:54:34 +07

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.user_allergens DROP CONSTRAINT IF EXISTS user_allergens_ibfk_2;
ALTER TABLE IF EXISTS ONLY public.user_allergens DROP CONSTRAINT IF EXISTS user_allergens_ibfk_1;
ALTER TABLE IF EXISTS ONLY public.meals_tags DROP CONSTRAINT IF EXISTS tag_id;
ALTER TABLE IF EXISTS ONLY public.recipe_ingredients DROP CONSTRAINT IF EXISTS recipe_ingredients_ibfk_2;
ALTER TABLE IF EXISTS ONLY public.recipe_ingredients DROP CONSTRAINT IF EXISTS recipe_ingredients_ibfk_1;
ALTER TABLE IF EXISTS ONLY public.meals DROP CONSTRAINT IF EXISTS meals_meal_type_id_foreign;
ALTER TABLE IF EXISTS ONLY public.meals DROP CONSTRAINT IF EXISTS meals_diet_type_id_foreign;
ALTER TABLE IF EXISTS ONLY public.meals_tags DROP CONSTRAINT IF EXISTS meal_id;
ALTER TABLE IF EXISTS ONLY public.meal_allergens DROP CONSTRAINT IF EXISTS meal_allergens_ibfk_2;
ALTER TABLE IF EXISTS ONLY public.meal_allergens DROP CONSTRAINT IF EXISTS meal_allergens_ibfk_1;
ALTER TABLE IF EXISTS ONLY public.feedback DROP CONSTRAINT IF EXISTS feedback_ibfk_1;
DROP INDEX IF EXISTS public.user_allergens_meal_id_index;
DROP INDEX IF EXISTS public.user_allergens_account_id_index;
DROP INDEX IF EXISTS public.recipe_ingredients_meal_id_index;
DROP INDEX IF EXISTS public.recipe_ingredients_ingredient_id_index;
DROP INDEX IF EXISTS public.personal_access_tokens_tokenable_type_tokenable_id_index;
DROP INDEX IF EXISTS public.meals_tags_tag_id_index;
DROP INDEX IF EXISTS public.meals_tags_meal_id_index;
DROP INDEX IF EXISTS public.meals_meal_type_id_index;
DROP INDEX IF EXISTS public.meals_diet_type_id_index;
DROP INDEX IF EXISTS public.meal_allergens_meal_id_index;
DROP INDEX IF EXISTS public.meal_allergens_allergen_id_index;
DROP INDEX IF EXISTS public.feedback_ibfk_1;
ALTER TABLE IF EXISTS ONLY public.user_allergens DROP CONSTRAINT IF EXISTS user_allergens_pkey;
ALTER TABLE IF EXISTS ONLY public.accounts DROP CONSTRAINT IF EXISTS unique_email;
ALTER TABLE IF EXISTS ONLY public.tags DROP CONSTRAINT IF EXISTS tags_pkey;
ALTER TABLE IF EXISTS ONLY public.recipe_ingredients DROP CONSTRAINT IF EXISTS recipe_ingredients_pkey;
ALTER TABLE IF EXISTS ONLY public.personal_access_tokens DROP CONSTRAINT IF EXISTS personal_access_tokens_token_unique;
ALTER TABLE IF EXISTS ONLY public.personal_access_tokens DROP CONSTRAINT IF EXISTS personal_access_tokens_pkey;
ALTER TABLE IF EXISTS ONLY public.password_reset_tokens DROP CONSTRAINT IF EXISTS password_reset_tokens_pkey;
ALTER TABLE IF EXISTS ONLY public.migrations DROP CONSTRAINT IF EXISTS migrations_pkey;
ALTER TABLE IF EXISTS ONLY public.meals_tags DROP CONSTRAINT IF EXISTS meals_tags_pkey;
ALTER TABLE IF EXISTS ONLY public.meals DROP CONSTRAINT IF EXISTS meals_pkey;
ALTER TABLE IF EXISTS ONLY public.meal_type DROP CONSTRAINT IF EXISTS meal_type_pkey;
ALTER TABLE IF EXISTS ONLY public.meal_allergens DROP CONSTRAINT IF EXISTS meal_allergens_pkey;
ALTER TABLE IF EXISTS ONLY public.ingredients DROP CONSTRAINT IF EXISTS ingredients_pkey;
ALTER TABLE IF EXISTS ONLY public.feedback DROP CONSTRAINT IF EXISTS feedback_pkey;
ALTER TABLE IF EXISTS ONLY public.diet_type DROP CONSTRAINT IF EXISTS diet_type_pkey;
ALTER TABLE IF EXISTS ONLY public.contacts DROP CONSTRAINT IF EXISTS contacts_pkey;
ALTER TABLE IF EXISTS ONLY public.allergens DROP CONSTRAINT IF EXISTS allergens_pkey;
ALTER TABLE IF EXISTS ONLY public.accounts DROP CONSTRAINT IF EXISTS accounts_pkey;
ALTER TABLE IF EXISTS public.user_allergens ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.tags ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.recipe_ingredients ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.personal_access_tokens ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.migrations ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.meals_tags ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.meals ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.meal_type ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.meal_allergens ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.ingredients ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.feedback ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.diet_type ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.contacts ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.allergens ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.accounts ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.user_allergens_id_seq;
DROP TABLE IF EXISTS public.user_allergens;
DROP SEQUENCE IF EXISTS public.tags_id_seq;
DROP TABLE IF EXISTS public.tags;
DROP SEQUENCE IF EXISTS public.recipe_ingredients_id_seq;
DROP TABLE IF EXISTS public.recipe_ingredients;
DROP SEQUENCE IF EXISTS public.personal_access_tokens_id_seq;
DROP TABLE IF EXISTS public.personal_access_tokens;
DROP TABLE IF EXISTS public.password_reset_tokens;
DROP SEQUENCE IF EXISTS public.migrations_id_seq;
DROP TABLE IF EXISTS public.migrations;
DROP SEQUENCE IF EXISTS public.meals_tags_id_seq;
DROP TABLE IF EXISTS public.meals_tags;
DROP SEQUENCE IF EXISTS public.meals_id_seq;
DROP TABLE IF EXISTS public.meals;
DROP SEQUENCE IF EXISTS public.meal_type_id_seq;
DROP TABLE IF EXISTS public.meal_type;
DROP SEQUENCE IF EXISTS public.meal_allergens_id_seq;
DROP TABLE IF EXISTS public.meal_allergens;
DROP SEQUENCE IF EXISTS public.ingredients_id_seq;
DROP TABLE IF EXISTS public.ingredients;
DROP SEQUENCE IF EXISTS public.feedback_id_seq;
DROP TABLE IF EXISTS public.feedback;
DROP SEQUENCE IF EXISTS public.diet_type_id_seq;
DROP TABLE IF EXISTS public.diet_type;
DROP SEQUENCE IF EXISTS public.contacts_id_seq;
DROP TABLE IF EXISTS public.contacts;
DROP SEQUENCE IF EXISTS public.allergens_id_seq;
DROP TABLE IF EXISTS public.allergens;
DROP SEQUENCE IF EXISTS public.accounts_id_seq;
DROP TABLE IF EXISTS public.accounts;
DROP TYPE IF EXISTS public.account_role;
DROP SCHEMA IF EXISTS public;
--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- TOC entry 3549 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 876 (class 1247 OID 24577)
-- Name: account_role; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.account_role AS ENUM (
    'user',
    'admin'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 222 (class 1259 OID 40980)
-- Name: accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.accounts (
    id bigint NOT NULL,
    username character varying(100) NOT NULL,
    email character varying(150) NOT NULL,
    password character varying(255) NOT NULL,
    remember_token character varying(255),
    role character varying(255) DEFAULT 'user'::character varying NOT NULL,
    status character varying(20) DEFAULT 'active'::character varying NOT NULL,
    note character varying(255),
    savemeal text,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(0) without time zone NOT NULL,
    deleted_at timestamp(0) without time zone,
    CONSTRAINT accounts_role_check CHECK (((role)::text = ANY ((ARRAY['user'::character varying, 'admin'::character varying])::text[])))
);


--
-- TOC entry 3550 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN accounts.status; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.accounts.status IS 'khoá tài khoản user';


--
-- TOC entry 3551 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN accounts.note; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.accounts.note IS 'lý do bị khoá bên user';


--
-- TOC entry 221 (class 1259 OID 40979)
-- Name: accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3552 (class 0 OID 0)
-- Dependencies: 221
-- Name: accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.accounts_id_seq OWNED BY public.accounts.id;


--
-- TOC entry 224 (class 1259 OID 40995)
-- Name: allergens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.allergens (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 223 (class 1259 OID 40994)
-- Name: allergens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.allergens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3553 (class 0 OID 0)
-- Dependencies: 223
-- Name: allergens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.allergens_id_seq OWNED BY public.allergens.id;


--
-- TOC entry 226 (class 1259 OID 41002)
-- Name: contacts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contacts (
    id bigint NOT NULL,
    name character varying(100),
    email character varying(150),
    message text,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(0) without time zone NOT NULL,
    deleted_at timestamp(0) without time zone
);


--
-- TOC entry 225 (class 1259 OID 41001)
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3554 (class 0 OID 0)
-- Dependencies: 225
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.contacts_id_seq OWNED BY public.contacts.id;


--
-- TOC entry 228 (class 1259 OID 41012)
-- Name: diet_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.diet_type (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


--
-- TOC entry 227 (class 1259 OID 41011)
-- Name: diet_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.diet_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3555 (class 0 OID 0)
-- Dependencies: 227
-- Name: diet_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.diet_type_id_seq OWNED BY public.diet_type.id;


--
-- TOC entry 238 (class 1259 OID 41061)
-- Name: feedback; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.feedback (
    id bigint NOT NULL,
    account_id bigint,
    rating integer,
    comment text,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    CONSTRAINT feedback_chk_1 CHECK (((rating >= 1) AND (rating <= 5)))
);


--
-- TOC entry 237 (class 1259 OID 41060)
-- Name: feedback_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.feedback_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3556 (class 0 OID 0)
-- Dependencies: 237
-- Name: feedback_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.feedback_id_seq OWNED BY public.feedback.id;


--
-- TOC entry 234 (class 1259 OID 41033)
-- Name: ingredients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ingredients (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    unit character varying(20),
    protein double precision,
    carb double precision,
    fat double precision,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


--
-- TOC entry 3557 (class 0 OID 0)
-- Dependencies: 234
-- Name: COLUMN ingredients.protein; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.ingredients.protein IS 'g/100g của ingredients';


--
-- TOC entry 3558 (class 0 OID 0)
-- Dependencies: 234
-- Name: COLUMN ingredients.carb; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.ingredients.carb IS 'g/100g của ingredients';


--
-- TOC entry 3559 (class 0 OID 0)
-- Dependencies: 234
-- Name: COLUMN ingredients.fat; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.ingredients.fat IS 'g/100g của ingredients';


--
-- TOC entry 233 (class 1259 OID 41032)
-- Name: ingredients_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ingredients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3560 (class 0 OID 0)
-- Dependencies: 233
-- Name: ingredients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ingredients_id_seq OWNED BY public.ingredients.id;


--
-- TOC entry 241 (class 1259 OID 41085)
-- Name: meal_allergens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.meal_allergens (
    id bigint NOT NULL,
    meal_id bigint NOT NULL,
    allergen_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


--
-- TOC entry 240 (class 1259 OID 41084)
-- Name: meal_allergens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.meal_allergens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3561 (class 0 OID 0)
-- Dependencies: 240
-- Name: meal_allergens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.meal_allergens_id_seq OWNED BY public.meal_allergens.id;


--
-- TOC entry 230 (class 1259 OID 41019)
-- Name: meal_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.meal_type (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


--
-- TOC entry 229 (class 1259 OID 41018)
-- Name: meal_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.meal_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3562 (class 0 OID 0)
-- Dependencies: 229
-- Name: meal_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.meal_type_id_seq OWNED BY public.meal_type.id;


--
-- TOC entry 236 (class 1259 OID 41040)
-- Name: meals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.meals (
    id bigint NOT NULL,
    name character varying(150) NOT NULL,
    diet_type_id bigint,
    meal_type_id bigint,
    preparation text,
    image_url character varying(255),
    description text,
    created_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


--
-- TOC entry 235 (class 1259 OID 41039)
-- Name: meals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.meals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3563 (class 0 OID 0)
-- Dependencies: 235
-- Name: meals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.meals_id_seq OWNED BY public.meals.id;


--
-- TOC entry 243 (class 1259 OID 41105)
-- Name: meals_tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.meals_tags (
    id bigint NOT NULL,
    meal_id bigint NOT NULL,
    tag_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


--
-- TOC entry 242 (class 1259 OID 41104)
-- Name: meals_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.meals_tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3564 (class 0 OID 0)
-- Dependencies: 242
-- Name: meals_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.meals_tags_id_seq OWNED BY public.meals_tags.id;


--
-- TOC entry 218 (class 1259 OID 40961)
-- Name: migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


--
-- TOC entry 217 (class 1259 OID 40960)
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3565 (class 0 OID 0)
-- Dependencies: 217
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- TOC entry 239 (class 1259 OID 41077)
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


--
-- TOC entry 220 (class 1259 OID 40968)
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.personal_access_tokens (
    id bigint NOT NULL,
    tokenable_type character varying(255) NOT NULL,
    tokenable_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 219 (class 1259 OID 40967)
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3566 (class 0 OID 0)
-- Dependencies: 219
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
-- TOC entry 245 (class 1259 OID 41124)
-- Name: recipe_ingredients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.recipe_ingredients (
    id bigint NOT NULL,
    meal_id bigint NOT NULL,
    ingredient_id bigint NOT NULL,
    quantity double precision,
    total_calo double precision NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


--
-- TOC entry 244 (class 1259 OID 41123)
-- Name: recipe_ingredients_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.recipe_ingredients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3567 (class 0 OID 0)
-- Dependencies: 244
-- Name: recipe_ingredients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.recipe_ingredients_id_seq OWNED BY public.recipe_ingredients.id;


--
-- TOC entry 232 (class 1259 OID 41026)
-- Name: tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tags (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


--
-- TOC entry 231 (class 1259 OID 41025)
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3568 (class 0 OID 0)
-- Dependencies: 231
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tags_id_seq OWNED BY public.tags.id;


--
-- TOC entry 247 (class 1259 OID 41143)
-- Name: user_allergens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_allergens (
    id bigint NOT NULL,
    account_id bigint NOT NULL,
    meal_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


--
-- TOC entry 246 (class 1259 OID 41142)
-- Name: user_allergens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_allergens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3569 (class 0 OID 0)
-- Dependencies: 246
-- Name: user_allergens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_allergens_id_seq OWNED BY public.user_allergens.id;


--
-- TOC entry 3289 (class 2604 OID 40983)
-- Name: accounts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts ALTER COLUMN id SET DEFAULT nextval('public.accounts_id_seq'::regclass);


--
-- TOC entry 3293 (class 2604 OID 40998)
-- Name: allergens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.allergens ALTER COLUMN id SET DEFAULT nextval('public.allergens_id_seq'::regclass);


--
-- TOC entry 3294 (class 2604 OID 41005)
-- Name: contacts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contacts ALTER COLUMN id SET DEFAULT nextval('public.contacts_id_seq'::regclass);


--
-- TOC entry 3296 (class 2604 OID 41015)
-- Name: diet_type id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.diet_type ALTER COLUMN id SET DEFAULT nextval('public.diet_type_id_seq'::regclass);


--
-- TOC entry 3301 (class 2604 OID 41064)
-- Name: feedback id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feedback ALTER COLUMN id SET DEFAULT nextval('public.feedback_id_seq'::regclass);


--
-- TOC entry 3299 (class 2604 OID 41036)
-- Name: ingredients id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ingredients ALTER COLUMN id SET DEFAULT nextval('public.ingredients_id_seq'::regclass);


--
-- TOC entry 3303 (class 2604 OID 41088)
-- Name: meal_allergens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meal_allergens ALTER COLUMN id SET DEFAULT nextval('public.meal_allergens_id_seq'::regclass);


--
-- TOC entry 3297 (class 2604 OID 41022)
-- Name: meal_type id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meal_type ALTER COLUMN id SET DEFAULT nextval('public.meal_type_id_seq'::regclass);


--
-- TOC entry 3300 (class 2604 OID 41043)
-- Name: meals id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meals ALTER COLUMN id SET DEFAULT nextval('public.meals_id_seq'::regclass);


--
-- TOC entry 3304 (class 2604 OID 41108)
-- Name: meals_tags id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meals_tags ALTER COLUMN id SET DEFAULT nextval('public.meals_tags_id_seq'::regclass);


--
-- TOC entry 3287 (class 2604 OID 40964)
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- TOC entry 3288 (class 2604 OID 40971)
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- TOC entry 3305 (class 2604 OID 41127)
-- Name: recipe_ingredients id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recipe_ingredients ALTER COLUMN id SET DEFAULT nextval('public.recipe_ingredients_id_seq'::regclass);


--
-- TOC entry 3298 (class 2604 OID 41029)
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);


--
-- TOC entry 3306 (class 2604 OID 41146)
-- Name: user_allergens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_allergens ALTER COLUMN id SET DEFAULT nextval('public.user_allergens_id_seq'::regclass);


--
-- TOC entry 3518 (class 0 OID 40980)
-- Dependencies: 222
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.accounts (id, username, email, password, remember_token, role, status, note, savemeal, created_at, updated_at, deleted_at) FROM stdin;
2	john	john@example.com	$2y$10$blRnVjkXiAoVmOpfmvA7I.zFVD6sL5k/HtWn1gJfxii0BzUcZMGfa	\N	user	active	\N		2025-07-31 02:41:17	2026-01-28 21:20:10	\N
3	user	test@gmail.com	$2y$10$VS9ho9xSBuNh/C2rF/EOierJZu18kwydzrLMHPTq3C5HRCfgHsfUe	\N	user	active	\N	15-25-20	2025-08-02 06:36:11	2025-08-24 18:00:32	\N
4	user1	user@test.com	$2y$10$PGPaoP74xWYxflPISaUq7e81AdQBCSIcfdUwFgA13Kz1MRZnZrt42	\N	user	inactive	ăn toàn chê	\N	2025-08-04 12:01:45	2025-08-16 20:08:05	\N
5	Bé Lan tốc độ	belan123@gmail.com	$2y$10$y/59oRQfSKmWwYXfjcZZ1.sd89H9I6DNykH8uptwku1DZbP1bBtQu	\N	user	active	\N	19-13-6-1	2025-08-04 13:12:52	2025-08-16 15:25:10	\N
6	Daredevil	daredevil666@gmail.com	$2y$10$2vWZC7Etyt6ag2IVvcnpse2CJ10EcC/FjdrbECckz4MPaiL9QR6ma	\N	user	active	\N	\N	2025-08-04 13:12:52	2025-08-04 15:41:06	2025-08-04 15:41:06
7	Lê Văn Đạt	levandat161@gmail.com	$2y$10$.bpm8Kib7oIJewAyRF2reeteu2E3Kn/4leRBTVbz/vab/FISZfiWa	\N	user	active	\N	\N	2025-08-04 14:22:22	2025-08-16 20:31:13	\N
8	Join Wick	joinwick11@gmail.com	$2y$10$7lU2Y8u/QbL0Ij0CnHnwWe9vtcyxw50DueJF.5TgFN8m/V6LZJKSa	\N	user	inactive	còn nợ 1k 2 năm chưa thấy ho he gì	\N	2025-08-04 15:22:40	2025-08-16 20:31:03	\N
9	Ronaldo	amronaldo123@gmail.com	$2y$10$Njem7.Cl8aQfUrGvUg68Yuvh.l8LJDNARwiaRsBNGprfi0aT3LyDG	\N	user	active	\N	\N	2025-08-05 11:54:24	2025-08-05 11:53:06	\N
10	Messi	immessi@gmail.com	$2y$10$Njem7.Cl8aQfUrGvUg68Yuvh.l8LJDNARwiaRsBNGprfi0aT3LyDG	\N	user	active	\N	\N	2025-08-05 11:55:54	2025-08-05 11:54:40	\N
11	Peter Parker	spiderman666@gmail.com	$2y$10$Njem7.Cl8aQfUrGvUg68Yuvh.l8LJDNARwiaRsBNGprfi0aT3LyDG	\N	user	active	\N	\N	2025-08-12 02:47:31	2025-08-12 02:46:53	\N
13	Nguyễn An	annguyen111@gmail.com	$2y$10$Njem7.Cl8aQfUrGvUg68Yuvh.l8LJDNARwiaRsBNGprfi0aT3LyDG	\N	user	active	\N	\N	2025-08-12 03:18:30	2025-08-12 03:17:14	\N
14	Phong	phong911@gmail.com	$2y$10$Njem7.Cl8aQfUrGvUg68Yuvh.l8LJDNARwiaRsBNGprfi0aT3LyDG	\N	user	active	\N	\N	2025-08-12 09:11:48	2025-08-12 09:11:13	\N
15	Nguyễn Anh	nguyenanh123@gmail.com	$2y$10$Njem7.Cl8aQfUrGvUg68Yuvh.l8LJDNARwiaRsBNGprfi0aT3LyDG	\N	user	active	\N	\N	2025-08-13 02:55:31	2025-08-13 02:53:57	\N
16	Trần Đạt	dattran161@gmail.com	$2y$10$vkoLJJ6CL3gpxd0.MLhdZOX7cVzEkLYnzYHeIhXT8ATvvKkFbVkLC	\N	user	active	\N	\N	2025-08-13 16:09:26	2025-08-13 16:09:26	\N
17	new name	nameisno111@gmail.com	$2y$10$1hzFJug6J2cEgZPImPFOVuDsdNPZDdvVDD9omUTO9wa21XN0hAy.y	\N	user	active	\N	\N	2025-08-13 16:18:51	2025-08-13 16:18:51	\N
18	tôi là ai	toilaai1@gmail.com	$2y$10$OvnzwcDun5QvLdn7rnDiaOMmplVz33t2wdc8ARHpkpM5gTYJRkuoi	\N	user	active	\N	\N	2025-08-13 16:25:21	2025-08-13 16:25:21	\N
19	Maidepgai	Mai123@gmail.com	$2y$10$Mzpgse7SY31p8VSAYfDXyulMvs3.Pzy5IzGWSnBvkgI.LldIQg4fm	\N	user	active	\N	\N	2025-08-13 16:27:45	2025-08-13 16:27:45	\N
20	DTech-333	Da111t@gmail.com	$2y$10$6ega6A4ORM0Z51HroQ72sej0nkwik0rXg6hsYoImrfIZ1dfPNsTG6	\N	user	active	\N	\N	2025-08-13 16:28:25	2025-08-13 16:28:25	\N
21	Join Wick 2	jw666@gmail.com	$2y$10$BKdyBKMyRqIPtfwZhoQVB.aWkfSCjpyATRJrhhRqkkKBmGumATJia	\N	user	active	\N	\N	2025-08-13 16:30:30	2025-08-13 16:30:30	\N
22	tui là user	user123@gmail.com	$2y$10$IUhWJOBEQwaLg2cGHtExFulxtqJ3ti4NPnNcjSZh11jPzUBmLQXee	\N	user	active	\N	\N	2025-08-13 16:31:42	2025-08-13 16:31:42	\N
24	Join Wick 3	jw123@gmail.com	$2y$10$LgbLAJ/HsUlZtMZBNg2lNeS1AaN3P4O7q0tR.ztT4SrHlvFNRXyci	\N	user	active	\N	\N	2025-08-13 16:34:53	2025-08-13 16:34:53	\N
25	Mỹ Nguyên	mnguyn1211@gmai.com	$2y$10$GTUUvHijYSHmnIaNfkm4TOpWu2Hd.m7XQkQCvRj6rK6bMBcgXfYJq	\N	user	active	\N	\N	2025-08-13 16:40:24	2025-08-13 16:40:24	\N
26	Ối zồi ôi	oizoioi11@gmail.com	$2y$10$.whmuHp5G1BYtCojfjla4exU5hIWLE/XkM.62JqVJDZl1RGIzjpoC	\N	user	active	\N	\N	2025-08-13 16:41:09	2025-08-13 16:41:09	\N
27	DTech-tech	dt12@gmail.com.vn	$2y$10$JtuCpiLK9wHgbOc5WFNA..8DjHSEXynjZ.tGd7hasaY1yJCb.5nBu	\N	user	active	\N	\N	2025-08-13 16:51:01	2025-08-13 16:51:01	\N
35	Tú đẹp troai	tudz123456@gmail.com	$2y$10$IMePSbmvmSXLdyn62OOxiu.WUt/r64jTuA8IYEqWRs4Mt9y1yqttK	\N	user	active	\N	\N	2025-08-13 17:31:28	2025-08-13 17:31:28	\N
37	Tú đập trai	tuDepZai123456@gmail.com	$2y$10$Q52.KrLQvHBKOvWdoLNHX.TUEk9wETefhnFtWupugfYqQXam50DxO	\N	user	active	\N	\N	2025-08-13 17:37:47	2025-08-13 17:37:47	\N
40	Tú đẹp trai	tuidapzai123@gmail.com	$2y$10$2GJU1LZC9qLLjHmtbHM89OiySjPDPiqLsghejol6uciX4IY1RW9lu	\N	user	active	\N	\N	2025-08-13 17:54:24	2025-08-13 17:54:24	\N
42	Tú đập trai	tuilatu11@gmail.com	$2y$10$qpP2nT8KpW0vwsAomxeNCe0c/mhJRl6Ax7hlhqatTe328Fhw135xq	\N	user	active	\N	\N	2025-08-13 18:58:20	2025-08-13 18:58:20	\N
43	Tú đập trai	Tulaai11@gmail.com	$2y$10$QT.gqxHWlq0MRn4iOAlKRu3OXPVNMBPbHNXCrptsYr.qAIlbhy3OC	\N	user	active	\N	\N	2025-08-13 19:05:45	2025-08-13 19:05:45	\N
44	Tú đẹp trai	tulai123@gmail.com	$2y$10$h8kTmOz55t85IN.5Euvq.OfgmO14Dw3AFvzs7fgjdH/CkYJOrk77q	\N	user	active	\N	\N	2025-08-13 19:10:08	2025-08-13 19:10:08	\N
45	Tui là user nhé	tuiser@123gmail.com	$2y$10$4hPvrXpA5fmf8RqlRxW0YOZmQiKdYBlveOgYIZtAgjeHbojT74eYS	\N	user	active	\N	\N	2025-08-13 19:16:49	2025-08-13 19:16:49	\N
46	tui là user nhe	tuilauser11@gmail.com	$2y$10$X/EwmKAGDgKHjaMXDLkKx.dswb70NJebI9VY56CGuBsoSfLLILS2G	\N	user	active	\N	\N	2025-08-13 19:17:53	2025-08-13 19:17:53	\N
47	Tú đập trai	tulaai12@gmail.com	$2y$10$KLNJQRxD8FpNfiSh3cXRf.8XGFtxSqN4lN3r4KjQHQJNlIQvJMrjm	\N	user	active	\N	\N	2025-08-13 19:21:20	2025-08-13 19:21:20	\N
49	Tèo em	teo123@gmail.com	$2y$10$jkuVEm36trQL891pEsRP2u41kUQq5TjshiBSLPAtoZxf2zty/kqN2	\N	user	active	\N	\N	2025-08-13 20:32:38	2025-08-13 20:32:38	\N
51	Nguyên Văn A Huyền Thoại	belan1234@gmail.com	$2y$10$BFUf4Iqb8Xuu4RpfI7LQreg7hm1O7f.j2w/OSW4acMXxgRM0E1Rra	\N	user	active	\N	\N	2025-08-13 20:35:52	2025-08-13 20:35:52	\N
52	Tèo anh đẹp trai	teoanh11@gmail.com	$2y$10$3gzkY0pPmNBGHgVd8kAPe.jQ2CR9tW5labZ0GlhkaNu/0eh5nF87u	\N	user	active	\N	\N	2025-08-13 20:50:25	2025-08-13 20:50:25	\N
53	gadafd	ffe@gmail.com	$2y$10$tXIjKkcCCkHC6581Yt25Au70syWJ.5d7zXsvs1OYl4Ln0tS.9YVeO	\N	user	active	\N	\N	2025-08-14 22:41:05	2025-08-14 22:41:05	\N
54	Trần Khoa	henrry@gmail.com	$2y$10$d04zK1GTc0/tFQ9V6oHfGedEUFxB1w8JIYowa0vw1NOjTC2Ayqsby	Cj74eeFVlMW7LhkqzY6tFh3TM98Zfooker2YSDPa1340D7h1VyIYYalXyISQ	user	active	\N	\N	2025-08-14 23:06:08	2025-08-19 23:01:12	\N
55	Harry	harry@gmail.com	$2y$10$RK5T9vqBdkV82NJw0JF1d.TeaMdDoUCqGDAX10YEChBidYuQKlzVC	\N	user	active	\N	\N	2025-08-15 05:09:10	2025-08-15 05:09:10	\N
56	Em là ai	emlai@gmail.com	$2y$10$RgvP8oG.5.HWe/fsdNA6QeiY96sSGGUBm7vTsj6Z.hJxsDgV//GQW	\N	user	active	\N	\N	2025-08-15 11:13:02	2025-08-15 11:13:02	\N
57	newbie	newbie@gmail.com	$2y$10$QjDKZLNsss4sjFnUJ/GELeItOs.1Kq5athdiXEgKVhos8pcO0efqS	\N	user	active	\N	\N	2025-08-15 11:15:08	2025-08-15 11:15:08	\N
58	khách hàng thứ n	khach@gmail.com	$2y$10$6sLJhsdLnxzQDfY.wQD3s.rv9fFGcqBLxFQh9E7CFbPz3SGQAjZia	\N	user	active	\N	\N	2025-08-15 11:19:46	2025-08-15 11:19:46	\N
60	test tên	testname@gmail.com	$2y$10$bJlIrlBP.Sa3vTEu1F8JJeCsYv.H1ceCATvCuR6rD1gfXI3SRxO5G	\N	user	active	\N	\N	2025-08-15 11:39:13	2025-08-15 11:39:13	\N
61	test auth	testtttt@gmail.com	$2y$10$JyGz7B2t8I12eQ71K3m5M.QiBF5MPqelgLgAirrSla08rBrZ6obNu	\N	user	active	\N	\N	2025-08-15 11:42:58	2025-08-15 11:42:58	\N
62	test tạm	test12345555@gmail.com	$2y$10$jsdbPfsOk8IerxzMmfpmwO3zhwhdw.SeU798yImlEy01GZB/IRygq	\N	user	active	\N	\N	2025-08-15 12:24:00	2025-08-15 12:24:00	\N
63	tui test nha	tuidanghoc@gmail.com	$2y$10$GoL8PnRUPH9QgqYbH4aC9uC.2tKZ3GTvFFHWicadBVmZtEZLGdfEi	\N	user	active	\N	\N	2025-08-15 12:28:45	2025-08-15 12:28:45	\N
64	Phong Nguyễn	phong@gmail.com	$2y$10$r5rTOk53syLVYdOd/QGaSeYRgNzIjbiKVWhPfbsYgY1nhVibQ8ME.	\N	user	active	\N	\N	2025-08-15 12:45:00	2025-08-15 12:45:00	\N
65	DTech-333	dtech12@gmail.com	$2y$10$fYa11v3GDe6lsSH0TMpbpebQLeoKGHXrflxSHX2flwP5J7bBJc/cm	\N	user	active	\N	\N	2025-08-15 12:57:04	2025-08-15 12:57:04	\N
66	tui là ai	tuialai88888@gmail.com	$2y$10$wn4bY0d.T1sbr45DOjMBLebEpJcK3Zevw.9ir9r6Sm7Q./CnbOzFO	\N	user	active	\N	\N	2025-08-15 12:58:14	2025-08-15 12:58:14	\N
67	DTech-222	dtech121212@gmail.com	$2y$10$GIqh64QHrzJYLO3ZgQpVO.BBuRNbhjAdtCOGxOMDPhSL1V1vGMa06	\N	user	active	\N	\N	2025-08-15 13:02:56	2025-08-15 13:02:56	\N
69	125aere	nguyenchi2@gmail.com	$2y$10$2vWZC7Etyt6ag2IVvcnpse2CJ10EcC/FjdrbECckz4MPaiL9QR6ma	\N	user	active	\N	1-25-19-20	2025-08-15 13:59:13	2025-08-19 14:42:31	\N
70	gadafddfsdf	ffeee@gmail.com	$2y$10$GG1PDppzhBlLhE68EmLCTuXns0a.6/yQQjDwUPHcxWT5tLTxpjBVO	\N	user	active	\N	\N	2025-08-15 23:41:11	2025-08-15 23:41:11	\N
71	aaaaeee	ffefgewef@gmail.com	$2y$10$2vWZC7Etyt6ag2IVvcnpse2CJ10EcC/FjdrbECckz4MPaiL9QR6ma	\N	user	active	\N	18	2025-08-15 23:41:58	2025-08-16 00:15:41	\N
72	user VIP	vip@gmail.com	$2y$10$KG0H9104jLgFZmMmOgfX1erUmp8jPWLUn0rQs2tCSRZaKbu8AyCby	\N	user	active	\N	\N	2025-08-16 15:55:38	2025-08-16 15:55:38	\N
73	Nhật Nguyễn	nhatnguyen@gmail.com	$2y$10$jgxmisHv8NHsuWsDGiDhw.8pnXR663/fCh9DNHNm5OaQjGrbY6aSW	\N	user	active	\N	\N	2025-08-16 16:54:32	2025-08-16 16:54:32	\N
74	Tui là Ánh	anh@gmail.com	$2y$10$OumV3Okm/br7oOdH92KqTOYBEdIbAYEF27EvkeyVyjTBrmtOhSEBu	\N	user	active	\N	\N	2025-08-16 16:57:35	2025-08-16 16:57:35	\N
75	coder cấp 1	coderrr@gmail.com	$2y$10$0zioEQBjv.agUswrY4d7LezJIx3dEoObsAlyJowEucxIUrt/swo1S	\N	user	active	\N	\N	2025-08-16 17:27:29	2025-08-16 17:27:29	\N
76	Coder cấp 3	code3@gmail.com	$2y$10$nSsTv484xUKl6BDt8bLVIOfjZMOdhOsBcrTvXPRhEullkNiBv3jhS	\N	user	active	\N	\N	2025-08-16 17:33:40	2025-08-16 17:33:40	\N
77	ttd161	ttd161@gmail.com	$2y$10$rdZOX3W15IkfFFksNQNxseh.xS8TNBzTQN0TK7WNNn3jss/dwNekK	\N	user	active	\N	\N	2025-08-16 18:16:17	2025-08-16 21:12:09	\N
78	tchung	tchung@gmail.com	$2y$10$T7K26u7LMncqirPG1s62aeVDW9PgIX3bYBGxHytJxGtW.dJD8p0Ki	\N	user	active	\N	\N	2025-08-16 18:27:26	2025-08-16 18:27:26	\N
79	TTd-161	ngaongo@gmail.com	$2y$10$C8w8ep7y3roLyrZXWuzYyOyB5HW..4.zf5M8/kRrEf/1xQdY8VvJ2	\N	user	active	\N	\N	2025-08-16 18:32:43	2025-08-16 18:32:43	\N
86	newbie1	newbie1@gmail.com	$2y$10$8HJAoVGblv/1tl3A.2.PKeL5g87SdwpIu4og6k.IBjyAapkkbRRKe	\N	user	active	\N	\N	2025-08-16 22:31:46	2025-08-16 22:31:46	\N
87	newbie2	newbie2@gmail.com	$2y$10$lRWDeFIGThcmxYGulecZIuSOu34LVdPZfl3SuPSsVK9s/Dri.QoAm	\N	user	active	\N	\N	2025-08-16 22:33:39	2025-08-16 23:08:30	\N
88	newbie3	new3@gmail.com	$2y$10$ETgSKfQuEvc5GZkLvp7v2u/99wA0m68uzLYzhyvpup/Cb8UFmO2va	\N	user	active	\N	\N	2025-08-16 23:11:59	2025-08-17 09:37:07	\N
89	newbie4	bie4@gmail.com	$2y$10$CnAlh.BMna4/5H7ASXX2T.DTD9lzCWbkjuz5NkahnK6uXfGHI.Usa	\N	user	active	\N	19-25-23-29-26	2025-08-17 09:57:07	2025-08-25 09:31:58	\N
90	2112	12125@gmail.com	$2y$10$2Hf3lHtQ/VqB4AgJmkaLY.wx/LlZ2nUDx.2blJWtwMRO28QYPj4Fe	\N	user	active	\N		2025-08-18 09:57:00	2025-08-18 09:58:16	\N
91	Dattt	trtdat161@gmail.com	$2y$10$s3P4xKNNZjG/Cpt2rrF3Xuz5QKkHZCLOd/setlk56hkz/rXhExtbi		user	active	\N	24-25-17-16-18	2025-08-18 12:41:52	2025-08-21 11:00:04	\N
92	abcd	abc@gmail.com	$2y$10$MjCndZ1FasZVKZrbzG43guGcDQaSuMi//dv0PQPX2qinxcshV5Xvm	\N	user	active	\N	23-24	2025-08-19 13:09:45	2026-01-27 10:09:13	\N
93	huongdt	dipthanhhong1020@gmail.com	$2y$10$/dwzCqr/G6IgFpyLFESoCu7FWEa9.ODnojAsFjhynH9XKfw8j3o8S	\N	user	active	\N	\N	2025-08-19 22:41:42	2025-08-19 22:41:42	\N
94	huongdt	ddd@gmail.com	$2y$10$c.piNpL3I3mCqHhpwUPn6ONJg1tG5jAAkAYVcRl6aKhhaQTBuGcV.	\N	user	active	\N	\N	2025-08-19 23:01:24	2025-08-19 23:01:24	\N
95	minhkhang	abcdef@gmail.com	$2y$10$ggWKpFpKccHMFNIZ6UMhxeMkOUMRlrnNtCmKrlZtqLtTCXGyCb0FG	\N	user	inactive	\N		2025-08-20 11:54:19	2025-08-22 15:10:34	\N
96	Sập database	sapdb@gmail.com	$2y$10$vqjgYrk8hBNIWJw1v7Bmg.CVaFDBKYvH9uX.wcnINaWDQrHnT.Yo.	\N	user	active	spam	\N	2025-08-21 14:12:31	2025-08-25 08:34:29	\N
97	Trần Đăng Khoa	khoa.trandang020704@gmail.com	$2y$10$2z/tz9uu6VoTUtjJHL61e.t2/WbPAvgb.KxCdribqEBisYPiKUSPC	\N	user	active	spam	\N	2025-08-21 15:39:39	2025-08-25 08:34:20	\N
98	khangminh	trandangkhoa020704444@gmail.com	$2y$10$YQraFz5RHjUBgqdnnjyceOiMQ/DldD/NevxiF.2coQAsiwhs9pmFa	\N	user	active	spam	23-22	2025-08-22 13:50:02	2025-08-25 08:34:14	\N
99	minhkhangg	khang@gmail.com	$2y$10$e8C7kalRjvwnBtOUFwjP.O22nPFUoSNy3BgGp/rSFD.Ls19ON4F4C	\N	user	inactive	spam	22	2025-08-22 15:00:48	2025-08-23 15:49:46	\N
100	minhkhang	khang123@gmail.com	$2y$10$fHsvOUov2IpG4cPxUZyx6e4kX4mxViur4ddbIaxgxX82W5SMeXv7.	\N	user	inactive	spam	\N	2025-08-24 19:00:01	2025-08-25 09:34:08	\N
101	Hang	hang123@gmail.com	$2y$10$ir28TvMuWkCMcnL99yAxtOUoRz/G0wPkj0BcTc6OgZGPNAvfAEXvu	\N	user	active	\N	\N	2025-08-25 08:42:26	2025-08-25 08:42:26	\N
102	hoang	hoangba@gmail.com	$2y$10$CCv0NUL94HUAy8Qr/pt6RuxBpR6tBLkkChdnMTqRTo.//DCJnM0Ve	\N	user	active	\N	\N	2025-08-25 08:43:25	2025-08-25 08:43:25	\N
103	lenhan	nhannguyen@gmail.com	$2y$10$8XsqTa/uATlOzIS0S8Vp4.fVsr8dsZbkI5Hu3403m0xBLXcKSWiZW	\N	user	active	\N	\N	2025-08-25 08:44:53	2025-08-25 08:44:53	\N
104	ducnha	nhanguyen@gmail.com	$2y$10$XUyNDHgLZtg5Q7WtJXu7eeVoVcFq6jSo6rwEX6tJ390Ic6IEE9rWG	\N	user	active	\N	\N	2025-08-25 08:48:38	2025-08-25 08:48:38	\N
105	minhkhang	minhkhang@gmail.com	$2y$10$tEr0.j2ggJ0KrjEqHL.NS.2Cfq5japIJKjbX8HV3ejHcskWYr7GI.	\N	user	active	\N	\N	2025-08-25 09:26:19	2025-08-25 09:26:19	\N
106	abcd	trandangkhoa0207044444444@gmail.com	$2y$10$zWsq1OtkIaAKOEIprrTtmeJ80e2Reih/teJhF9X0irN1uyD76c5HS	\N	user	active	\N	\N	2025-08-25 09:47:51	2025-08-25 09:47:51	\N
107	Tran dang khoa	ptaauth21@gmail.com	$2y$10$N4gmKD1AzIgeBhczIE.jfetOivicj9iJ0pnk9qjtHpZwCnEMrQ.JK	\N	user	active	\N	\N	2025-08-25 09:52:24	2025-08-25 09:52:24	\N
108	Tran dang khoa	kh@gmail.com	$2y$10$zRAcgX7QYGj1KIP./pxrLeqzE0bCOxIHkRran0ovKZknv/LSVpOga	\N	user	active	\N	\N	2025-08-25 09:54:03	2025-08-25 09:54:03	\N
109	john	trandangkhoa02070444@gmail.com	$2y$10$V8TI3OumPtuMgrN33w7uXe8PN1kojYRS5l2xAXJ2iO9H7XQra6m2G	\N	user	active	\N	\N	2025-08-25 09:59:22	2025-08-25 09:59:22	\N
110	chonguyen	nguyen@gmail.com	$2y$10$Aag2pWk.pPVP6WFs5o7BuO7WAZ/xr9oVVfEEIeHbqFMsdZ3kyCvAa	\N	user	active	\N	\N	2025-08-31 20:57:58	2025-08-31 20:57:58	\N
111	khangg	khang11@gmail.com	$2y$10$sxVGAXlGbUMnVl.dcJhP3OWmf/9OcekZyZg/Uobnp3IJOhvR5PL3G	\N	user	active	\N	\N	2025-10-15 14:19:11	2025-10-15 14:19:11	\N
112	abcd	a@gmail.com	$2y$10$x9pUu63Gn.X.BjvVderIkOaavp1lf.z14sEBfM/5IaVMhKaqSFz8C	\N	user	active	\N	\N	2026-01-27 09:57:52	2026-01-27 09:57:52	\N
113	khoaaaa	khoaaaa@gmail.com	$2y$10$9PE5hOc1YrROBj1OCl4.leRM.Y4Q5z.41xI8E30QfEPk3vS5rtc8a	\N	user	active	\N	\N	2026-01-28 20:58:36	2026-01-28 20:58:36	\N
1	Admin	trandangkhoa020704@gmail.com	$2y$10$FYdiVzsu5P7hZAVNEq4IvOBbxv2iVeaY7o4aXnyRWYdkUEdHoRiV.	Jn0iOkrYPYQgWC2d6m4yMXGe4IarFXyBGO109xLqyvXrbtFrfjgHdSdauHIA	admin	active	\N	\N	2025-07-31 02:41:17	2025-08-22 20:32:38	\N
114	Dung Hồ	dungho121206@gmail.com	$2y$10$zKvf4TO5ncTUoVOcc35t3.saSw/iUx74/DdM3kGyAlOVjbzzdldqW	\N	user	active	\N	\N	2026-04-04 14:41:04	2026-04-04 14:41:04	\N
\.


--
-- TOC entry 3520 (class 0 OID 40995)
-- Dependencies: 224
-- Data for Name: allergens; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.allergens (id, name, deleted_at, created_at, updated_at) FROM stdin;
1	Đậu phộng	\N	\N	\N
2	Sản phẩm từ sữa	\N	\N	\N
3	Gluten	\N	\N	\N
4	Trứng	\N	\N	\N
5	Hạnh nhân	\N	\N	\N
6	Các loại hạt	\N	\N	\N
7	Cá	\N	\N	\N
8	Yến mạch	\N	1900-02-02 10:32:27	2025-08-05 04:06:55
9	Đậu nành	\N	1900-01-26 00:00:00	\N
10	Lúa mì	\N	1900-01-19 00:00:00	\N
11	Mè	\N	1900-01-03 10:31:48	\N
12	Hải sản có vỏ	2025-08-19 21:40:48	2025-08-01 00:00:00	2025-08-19 21:40:48
13	Mủ cao su	2025-08-18 10:30:29	2025-08-01 10:31:35	2025-08-18 10:30:29
14	Cóc	\N	2025-08-01 10:31:30	\N
15	Mù tạt	\N	2025-08-01 10:31:24	\N
16	Nước ngọt	2025-08-17 17:45:34	2025-08-04 16:03:10	2025-08-17 17:45:34
17	Thanh lọc cơ thể	2025-08-10 08:42:47	2025-08-04 16:04:17	2025-08-04 16:04:17
18	Mì	\N	2025-08-05 03:29:12	2025-08-05 03:29:12
19	Kosher	\N	2025-07-14 17:58:13	2025-08-05 17:58:13
20	xoài	2025-08-06 04:19:29	2025-08-05 19:40:33	2025-08-06 04:19:29
21	cơm	\N	2025-08-05 19:40:33	2025-08-06 04:19:43
22	khoai	2025-08-07 08:49:46	2025-08-07 08:45:15	\N
23	mực	2025-08-18 10:30:16	\N	2025-08-18 10:30:16
24	rau	2025-08-17 17:38:27	2025-08-07 08:46:01	2025-08-17 17:38:27
25	tôm	2025-08-07 08:49:07	\N	\N
26	bào ngư	\N	2025-08-07 08:50:21	\N
27	cua	2025-08-17 13:07:43	\N	\N
28	táo	2025-08-22 00:33:09	\N	2025-08-22 00:33:09
29	thức ăn sống	2025-08-17 13:07:28	\N	\N
30	sữa chua	\N	2025-08-17 17:38:41	2025-08-17 17:38:41
31	12	2025-08-18 10:04:09	\N	\N
32	khoai lang	2025-08-24 16:47:13	2025-08-24 16:47:06	2025-08-24 16:47:13
33	Bơ	\N	2025-08-24 19:53:14	2025-08-24 19:53:14
34	Tỏi	\N	2025-08-24 22:03:35	2025-08-24 22:03:35
35	cá sấu	\N	2025-08-25 09:37:01	2025-08-25 09:37:01
\.


--
-- TOC entry 3522 (class 0 OID 41002)
-- Dependencies: 226
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.contacts (id, name, email, message, created_at, updated_at, deleted_at) FROM stdin;
1	Nguyễn Văn A	a.nguyen@example.com	Tôi muốn biết lịch ăn uống hàng tuần.	2025-08-07 08:15:00	2025-08-22 14:24:31	2025-08-22 14:24:31
2	Trần Thị B	b.tran@example.com	Làm sao để thay đổi gói đăng ký?	2025-08-07 09:30:00	2025-08-22 14:24:55	2025-08-22 14:24:55
3	Lê Văn C	c.le@example.com	Tôi quên mật khẩu, cần hỗ trợ.	2025-08-07 10:45:00	2025-08-22 14:24:55	\N
4	Phạm Thị D	d.pham@example.com	Tôi muốn hủy tài khoản.	2025-08-07 13:00:00	2025-08-22 14:24:55	\N
5	Hoàng Minh E	e.hoang@example.com	Làm sao để xem hóa đơn của tôi?	2025-08-07 14:15:00	2025-08-22 14:24:55	\N
6	Đỗ Thị F	f.do@example.com	Chế độ ăn này có phù hợp với người tiểu đường không?	2025-08-07 15:30:00	2025-08-13 10:23:59	\N
7	@@@	trandangkhoa020704@gmail.com	<script>alert('hello')</script>	2025-08-17 13:09:45	2025-08-17 22:00:25	2025-08-17 22:00:25
8	123	123@gmail.com	bsdgjhsdfuhg	2025-08-17 15:11:02	2025-08-17 22:00:21	2025-08-17 22:00:21
9	1234	1234@gmail.com	jhsdbvjhdsg	2025-08-17 15:14:39	2025-08-17 22:00:17	2025-08-17 22:00:17
10	Nguyễn Vương	vuong123@gmail.com	Tôi muốn hỏi xem các món ăn ở đây có món giúp tăng chiều cao không	2025-08-20 09:44:12	2025-08-20 09:44:12	\N
11	Nguyễn Văn	van123@gmail.com	ok á nha	2025-08-20 09:50:57	2025-08-20 09:50:57	\N
12	bvsdv	abc@gmail.com	gqegfhyv	2025-08-20 09:58:51	2025-08-20 09:58:51	\N
13	ưehfgui	1234@gmail.com	ygwygf	2025-08-20 10:05:36	2025-08-20 10:05:36	\N
14	ghj	1234@gmail.com	nsjgnjsbn	2025-08-20 10:07:02	2025-08-24 19:59:35	2025-08-24 19:59:35
15	Nguyễn Văn A	nguyen123@gmail.com	hhhhhhhhhhh	2025-08-20 10:32:44	2025-08-20 10:32:44	\N
16	bvsdvbgdf	abc@gmail.com	fsdfse	2025-08-20 11:22:42	2025-08-22 15:20:34	2025-08-22 15:20:34
17	Minh Khang	abc@gmail.com	Tui mún giảm cân	2025-08-20 12:01:21	2025-08-20 12:01:21	\N
18	Trần Đăng Khoa	khoa@gmail.com	Web đẹp phết á nha	2025-08-21 15:26:09	2025-08-21 15:26:09	\N
19	Nguyễn Khắc Anh Khoa	khoa123@gmail.com	Tối muốn tìm hiểu cách dùng trang web này	2025-08-22 13:48:02	2025-08-23 01:28:23	2025-08-23 01:28:23
20	Lê Khắc Anh Khoa	khoa123@gmail.com	Tìm hiểu sâu về web này	2025-08-22 14:58:07	2025-08-22 14:58:07	\N
21	Tran Dang Khoa	trankhoa@gmail.com	abcde	2025-08-23 15:47:29	2025-08-23 15:47:29	\N
22	Lê Khắc Anh Khoa	anhkhoa@gmail.com	Hiểu sâu hơn về trang web này	2025-08-24 18:58:01	2025-08-24 18:58:01	\N
23	Lê Khắc Anh Khoa	anhkhoa@gmail.com	Tìm hiểu sâu hơn về web	2025-08-25 09:24:49	2025-08-25 09:24:49	\N
\.


--
-- TOC entry 3524 (class 0 OID 41012)
-- Dependencies: 228
-- Data for Name: diet_type; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.diet_type (id, name, created_at, updated_at, deleted_at) FROM stdin;
1	Ăn chay	2025-08-14 11:20:04	\N	\N
2	Thuần chay 	2025-08-21 11:20:23	2025-08-05 05:50:16	\N
3	Keto	2025-08-01 11:20:34	\N	\N
4	Không gluten	2025-08-30 11:20:40	\N	\N
5	Ít tinh bột	2025-08-20 11:20:50	\N	\N
6	Paleo	2025-08-27 11:20:55	\N	\N
7	Cho người tiểu đường	2025-08-20 11:21:00	\N	\N
8	Nhiều đạm	2025-08-04 11:21:05	2025-08-05 05:48:27	\N
9	Ít béo 	2025-08-02 11:21:10	2025-08-05 05:47:29	\N
10	Địa Trung Hải	2025-08-08 11:21:17	2025-08-20 11:08:27	2025-08-20 11:08:27
11	Nhiều tinh bột	2025-08-05 06:45:39	2025-08-05 06:53:39	\N
12	Giữ dáng	2025-08-05 06:54:10	2025-08-06 05:42:00	\N
13	Cân bằng dinh dưỡng	2025-08-01 11:21:28	\N	\N
14	nhiều cơm	2025-08-04 11:21:32	2025-08-17 13:26:12	2025-08-17 13:26:12
15	Cheat day	2025-09-09 11:21:36	2025-08-23 15:50:48	\N
16	Thanh lọc cơ thể	2025-08-22 11:21:48	\N	\N
17	Chay	2025-08-22 15:16:48	2025-08-22 15:16:48	\N
18	Ăn kiêng	2025-08-24 19:24:04	2025-08-24 19:24:04	\N
19	món mặn	2025-08-25 09:35:38	2025-08-25 09:35:38	\N
\.


--
-- TOC entry 3534 (class 0 OID 41061)
-- Dependencies: 238
-- Data for Name: feedback; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.feedback (id, account_id, rating, comment, created_at, updated_at, deleted_at) FROM stdin;
1	2	5	Really liked the vegan smoothie!	2025-07-31 02:41:17	\N	\N
2	2	4	The chicken salad was tasty and healthy.	2025-07-31 02:41:17	\N	\N
3	3	3	cũng tạm ăn được 	2025-08-04 09:54:15	\N	\N
4	5	5	đồ ăn fitfood ăn vào đạp xe đến trường nhanh gấp đôi	2025-08-04 13:16:39	\N	\N
5	2	4	aaaaaa	2025-08-10 08:38:35	\N	\N
7	\N	5	Món ăn rất đa dạng và phong phú	2025-08-16 12:12:57	\N	\N
10	90	5	12122121	2025-08-18 10:13:08	\N	\N
11	2	5	ghuyt	2025-08-18 10:17:49	\N	\N
12	2	3	5 sao	2025-08-18 10:18:55	\N	\N
13	2	5	xuất sắc	2025-08-18 10:41:59	\N	\N
14	4	1	ôjjhj	2025-08-18 12:28:36	\N	\N
15	4	5	quá ok	2025-08-19 09:25:49	\N	\N
16	4	5	jvsdjhv	2025-08-19 12:40:04	\N	\N
17	\N	5	ijiji	2025-08-19 14:11:52	\N	\N
18	2	5	kalalalala	2025-08-19 14:29:22	\N	\N
19	2	4	kakakakaka llalala	2025-08-19 14:29:37	\N	\N
20	2	5	quá ngon luôn	2025-08-19 14:31:09	\N	\N
21	3	2	dvfvsdsf	2025-08-20 11:22:17	\N	\N
22	2	5	tuyệt vòiii	2025-08-20 12:00:28	\N	\N
23	2	4	hahahaha	2025-08-21 08:25:58	\N	\N
24	2	5	oke dos	2025-08-21 09:02:25	\N	\N
25	98	5	Tuyệt vời cảm ơn	2025-08-22 14:04:42	\N	\N
26	2	5	Tuyệt vời	2025-08-23 15:48:24	\N	\N
27	2	5	ngon quá	2025-08-24 21:53:49	\N	\N
\.


--
-- TOC entry 3530 (class 0 OID 41033)
-- Dependencies: 234
-- Data for Name: ingredients; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ingredients (id, name, unit, protein, carb, fat, created_at, updated_at, deleted_at) FROM stdin;
1	Ức gà chín	gram	31	0	3.6	2025-08-18 15:56:38	2025-08-21 16:40:29	\N
2	Rau Xà lách	gram	1.4	2.9	0.2	2025-08-18 15:56:38	2025-08-03 06:15:50	\N
3	Rau chân vịt	gram	2.9	3.6	0.4	2025-08-18 15:56:38	2025-08-04 03:06:41	\N
4	Chuối	gram	1.3	27	0.3	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
5	Hạnh nhân	gram	0.4	0.3	2.7	2025-08-18 15:56:38	2025-08-03 14:52:47	\N
6	Trứng	gram	13	1.2	11	2025-08-18 15:56:38	2025-08-03 14:59:28	\N
7	Hạt diêm mạch	gram	4.4	21	1.9	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
8	Cà rốt	gram	0.9	10	0.2	2025-08-18 15:56:38	2025-08-03 14:59:09	\N
9	Măng tây	gram	2.2	3.9	0.3	2025-08-18 15:56:38	2025-08-03 15:09:23	\N
10	Táo	gram	13.8	0.4	0.2	2025-08-18 15:56:38	2025-08-03 15:06:09	\N
11	Cá hồi	gram	20	0	13	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
12	Nho	gram	17.1	0.6	0.2	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
13	Bánh phở 	gram	1.6	25	0.3	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
14	Thịt bò	gram	26	0	15	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
15	Tỏi	gram	2.8	6.6	0.4	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
16	Yến mạch	gram	13	68	7	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
17	Sữa hạnh nhân	gram	21	22	49	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
18	Bơ	gram	2	9	15	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
19	Bánh mì nguyên cám	gram	12	44	2.2	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
20	Gừng	gram	1.8	18	0.8	2025-08-18 15:56:38	2025-08-05 05:48:16	\N
21	Nước tương 	gram	0.8	1	0	2025-08-18 15:56:38	2025-08-05 05:48:05	\N
23	Ức gà	gram	26	5	2	2025-08-02 16:43:53	2025-08-05 05:47:53	\N
24	Gạo	gram	2.7	28	0.3	2025-08-05 05:43:19	2025-08-05 05:43:19	\N
25	Gạo lức	gram	2.7	28	0.3	2025-08-05 05:43:36	2025-08-21 20:16:07	\N
26	Bông cải xanh	gram	100	100	100	2025-08-06 03:08:41	2025-08-06 03:09:29	\N
27	Bia 333	gram	0.5	7.6	0	2025-08-13 12:16:39	2025-08-21 19:18:18	\N
28	Thịt heo	gram	27	0	14	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
29	Thịt vịt	gram	19	0	28	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
30	Cá ngừ	gram	24	0	1	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
31	Tôm	gram	20	0	1	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
32	Mực	gram	16	3	1	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
33	Đậu hũ	gram	8	2	4	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
34	Nấm hương	gram	3	7	0.5	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
35	Khoai tây	gram	2	17	0.1	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
36	Khoai lang	gram	1.5	20	0.1	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
37	Bắp ngọt	gram	1	7	0.1	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
38	Bí đỏ	gram	1	7	0.1	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
39	Cà tím	gram	1	6	0.2	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
40	Dưa leo	gram	0.7	4	0.1	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
41	Cam	gram	0.9	12	2	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
42	Lê	gram	0.4	15	0.1	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
43	Nghêu	gram	24	5	2	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
44	Hàu	gram	9	5	2.5	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
45	Rau muống	gram	3	3	0.5	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
46	Đậu que	gram	1.8	7	0.2	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
47	Bông cải trắng	gram	2	5	0.3	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
48	Thịt dê	gram	25	0	6	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
49	Cá thu	gram	22	0	12	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
50	Cá basa	gram	17	0	5	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
51	Cá trích	gram	20	0	11	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
52	Cá mòi	gram	21	0	10	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
53	Sò huyết	gram	15	4	1	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
54	Hến	gram	12	3	1	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
55	Ốc	gram	12	4	1	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
56	Cua	gram	19	0	1	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
57	Ghẹ	gram	18	0	1	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
58	Rau cải ngọt	gram	2.5	3	0.2	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
59	Rau cải thìa	gram	1.5	2	0.2	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
60	Rau mồng tơi	gram	2	3	0.2	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
61	Rau dền 	gram	2	4	0.3	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
62	Đậu bắp	gram	2	7	0.2	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
63	Nấm rơm	gram	3	4	0.3	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
64	Nấm kim châm	gram	2.7	5	0.3	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
65	Nấm mỡ	gram	2.7	5	0.3	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
66	Khoai môn	gram	1.5	27	0.2	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
67	Khoai mỡ	gram	2	27	0.2	2025-08-18 15:56:38	2025-08-18 15:56:38	\N
68	cá sấu hoả tiễn	gram	12	12	0.3	2025-08-18 22:49:34	2025-08-21 20:58:08	2025-08-08 10:43:52
69	Sữa tươi	gram	3.2	4.8	3.3	2025-08-21 16:00:46	2025-08-21 16:00:46	\N
70	Sữa chua không đường	gram	3.5	4.7	3.3	2025-08-21 16:08:02	2025-08-21 16:08:02	\N
71	Bơ đậu phộng	gram	25	20	50	2025-08-21 16:20:33	2025-08-21 16:20:33	\N
72	Bacon	gram	38	1.4	42	2025-08-21 16:23:13	2025-08-22 14:10:16	\N
73	Whey Protein	gram	80	9	7	2025-08-21 16:25:47	2025-08-21 20:18:33	\N
74	Cơm trắng	gram	2.4	28	0.3	2025-08-21 16:33:14	2025-08-21 20:18:00	\N
75	Dầu ăn	gram	0	0	100	2025-08-21 16:35:00	2025-08-21 20:17:43	\N
76	Dầu olive	gram	0	0	100	2025-08-21 16:36:28	2025-08-21 20:17:32	\N
77	Cá sấu chiên giòn	gram	100	50	0	2025-08-22 14:09:11	2025-08-22 14:09:11	\N
78	cá sấu	gram	100	50	10	2025-08-22 15:11:52	2025-08-22 15:11:52	\N
79	bánh mì giòn	gram	10	25	15	2025-08-24 19:16:07	2025-08-24 19:16:07	\N
80	Bánh mì	gram	10	50	50	2025-08-24 19:43:37	2025-08-24 19:43:37	\N
81	Gà	gram	50	15	15	2025-08-24 21:56:57	2025-08-24 21:56:57	\N
82	Mật ong	gram	10	20	20	2025-08-24 21:57:47	2025-08-24 21:57:47	\N
83	Thịt đà điểu	gram	100	2	2	2025-08-25 10:06:47	2025-08-25 10:06:47	\N
\.


--
-- TOC entry 3537 (class 0 OID 41085)
-- Dependencies: 241
-- Data for Name: meal_allergens; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.meal_allergens (id, meal_id, allergen_id, created_at, updated_at, deleted_at) FROM stdin;
2	1	4	\N	\N	\N
3	4	6	\N	\N	\N
4	5	7	\N	\N	\N
5	6	6	\N	\N	\N
6	8	3	\N	\N	\N
7	9	3	\N	\N	\N
8	10	8	\N	\N	\N
9	2	2	\N	\N	\N
10	7	2	\N	\N	\N
12	6	3	\N	\N	\N
16	12	1	\N	\N	\N
17	5	18	\N	\N	\N
20	10	26	\N	\N	\N
21	3	21	\N	\N	\N
24	20	10	\N	\N	\N
25	7	1	\N	\N	\N
26	6	1	\N	\N	\N
30	8	29	\N	\N	\N
31	20	3	\N	\N	\N
32	20	7	\N	\N	\N
33	20	14	\N	\N	\N
34	20	15	\N	\N	\N
35	15	15	\N	\N	\N
36	18	15	\N	\N	\N
37	8	15	\N	\N	\N
40	18	30	\N	\N	\N
41	12	30	\N	\N	\N
42	6	19	\N	\N	\N
43	24	7	\N	\N	\N
44	28	7	\N	\N	\N
45	7	32	\N	\N	\N
46	29	4	\N	\N	\N
47	30	4	\N	\N	\N
48	30	33	\N	\N	\N
49	31	34	\N	\N	\N
50	32	35	\N	\N	\N
51	33	6	\N	\N	\N
\.


--
-- TOC entry 3526 (class 0 OID 41019)
-- Dependencies: 230
-- Data for Name: meal_type; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.meal_type (id, name, created_at, updated_at, deleted_at) FROM stdin;
1	Bữa sáng	2025-08-06 10:51:16	2025-08-25 10:08:21	2025-08-25 10:08:21
2	Bữa trưa	2025-08-21 10:51:23	2025-08-18 11:23:40	2025-08-18 11:23:40
3	Bữa chiều	2025-08-05 10:51:29	\N	\N
4	Bữa tối	2025-08-05 10:51:32	2025-08-17 22:03:31	\N
5	Bữa khuya	2025-08-13 00:32:10	2025-08-18 00:33:10	\N
6	Bữa ăn nhẹ	2025-08-20 00:32:27	2025-08-18 00:32:56	\N
7	Sinh tố	2025-08-20 13:09:39	2025-08-05 13:09:43	\N
8	mljdfh	\N	\N	2025-08-15 10:43:33
9	Bữa ăn nặng	\N	\N	2025-08-15 10:48:00
10	jwrghj	\N	\N	2025-08-15 11:31:50
11	Bữa ăn nặng	2025-08-15 11:49:20	2025-08-17 22:02:36	2025-08-17 22:02:36
12	buổi xế	2025-08-15 23:04:21	2025-08-15 23:04:28	2025-08-15 23:04:28
13	Bữa ăn khuya	2025-08-17 22:19:48	2025-08-23 11:27:43	2025-08-23 11:27:43
14	Bữa ăn nhiều calo	2025-08-17 22:20:06	2025-08-17 22:20:06	\N
15	Bữa ăn ít calo	2025-08-17 22:20:18	2025-08-17 22:20:18	\N
16	Bữa ăn chính	2025-08-17 22:20:30	2025-08-17 22:20:30	\N
17	Bữa ăn phụ	2025-08-17 22:20:43	2025-08-18 11:02:36	\N
18	Bữa ăn thiếu calo	2025-08-18 00:33:38	2025-08-23 02:12:09	\N
19	Bữa 4	2025-08-21 14:23:23	2025-08-21 14:29:43	2025-08-21 14:29:43
20	Breakfast	2025-08-23 15:50:18	2025-08-23 15:50:18	\N
\.


--
-- TOC entry 3532 (class 0 OID 41040)
-- Dependencies: 236
-- Data for Name: meals; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.meals (id, name, diet_type_id, meal_type_id, preparation, image_url, description, created_at, updated_at, deleted_at) FROM stdin;
1	Trứng bác rau chân vịt	16	1	B1: Đập 2 quả trứng gà vào bát, đánh đều.\\nB2: Cho một ít rau chân vịt cắt nhỏ vào trộn đều.\\nB3: Làm nóng chảo, thêm dầu ăn, đổ hỗn hợp vào.\\n Đảo nhẹ tay 2–3 phút cho đến khi chín.	1755337185_68a051e18d4ac.jpg	Món ăn sáng đơn giản, nhanh và giàu protein, phù hợp người ăn chay có trứng sữa.	2025-08-01 17:28:55	2025-08-22 21:25:05	\N
3	Tô ngũ cốc quinoa với rau	18	4	B1: Nấu quinoa với nước theo tỉ lệ 1:2 trong 15 phút.\\nB2: Xào cà rốt, bí đỏ, đậu hà lan với dầu oliu.\\nB3: Trộn quinoa và rau củ, rắc mè đen.	1755337137_68a051b16d8c3.jpg	Bữa tối nhẹ nhàng, đầy đủ chất xơ và đạm thực vật.	2025-08-01 17:35:42	2025-08-24 19:48:31	\N
4	Sinh tố chuối hạnh nhân	15	7	B1: Lột vỏ 1 quả chuối, cắt khoanh.\\nB2: Cho vào máy xay cùng 200ml sữa hạnh nhân.\\nB3: Thêm vài viên đá, xay mịn 30 giây.	1755337124_68a051a47f510.jpg	Sinh tố mát lạnh cho bữa sáng hoặc bữa phụ.	2025-08-01 17:37:04	2025-08-23 15:50:49	\N
5	Cá hồi nướng măng tây	3	4	B1: Ướp cá hồi với muối, tiêu, chanh.\\nB2: Đặt cá và măng tây lên khay nướng.\\nB3: Nướng 200°C trong 15–20 phút.	1755337110_68a05196b737a.jpg	Bữa tối lành mạnh, giàu chất béo tốt.	2025-08-01 17:37:55	2025-08-16 16:38:30	\N
6	Táo chấm bơ đậu phộng	16	6	B1: Gọt vỏ 1 quả táo, cắt lát mỏng.\\nB2: Quét một ít bơ đậu phộng lên từng lát táo.	1755337099_68a0518b45472.jpg	Ăn nhẹ đơn giản, phù hợp người tiểu đường.	2025-08-01 17:39:47	2025-08-22 21:25:05	\N
7	Bánh mì nguyên hạt phết bơ	16	3	B1: Nướng 1 lát bánh mì nguyên cám.\\nB2: Nghiền nửa quả bơ với ít muối và tiêu.\\nB3: Phết bơ lên bánh mì, thêm mè đen.	1755337085_68a0517d92733.jpg	Món ăn chiều nhẹ nhàng, no lâu.	2025-08-01 17:41:12	2025-08-22 21:25:05	\N
8	Phở Gà	8	1	B1: Luộc gà lấy nước dùng, lọc cặn.\\nB2: Luộc bánh phở, xếp vào tô.\\nB3: Thêm thịt gà xé, rau thơm, chan nước dùng.	1755337074_68a0517218050.jpg	Phở nước dùng trong ngọt từ xương gà, thịt gà mềm thơm, sợi phở mềm ăn kèm hành tươi, rau thơm và chanh ớt.	2025-08-01 17:42:24	2025-08-16 16:37:54	\N
9	Bò xào bông cải xanh	8	14	B1: Cắt lát thịt bò mỏng, ướp gừng, tỏi, nước tương.\\nB2: Luộc sơ bông cải.\\nB3: Xào bò, sau đó cho bông cải vào đảo nhanh.	1755337035_68a0514b4ead1.jpg	Thịt bò mềm xào cùng bông cải xanh giòn, tỏi thơm, nêm nếm đậm đà, giàu dinh dưỡng và dễ chế biến.	2025-08-01 17:43:48	2025-08-21 16:22:52	\N
10	Cháo yến mạch hạnh nhân	18	5	B1: Nấu ½ cốc yến mạch với 1 cốc sữa hạnh nhân.\\nB2: Thêm hạt hạnh nhân, mật ong nếu thích.\\nB3: Ăn khi còn ấm.	1755337008_68a051306eccc.jpg	Bữa khuya nhẹ nhàng, dễ tiêu hoá, hỗ trợ giấc ngủ.	2025-08-01 17:44:45	2025-08-24 19:48:31	\N
11	Cánh gà chiên nước mắm	16	1	Mua gà\\nLàm  sạch gà\\nChiên gà	1755336762_68a0503a6924a.jpg	 Món ăn đậm đà hương vị với cánh gà vàng giòn rụm, thấm đều sốt nước mắm chua ngọt hài hòa. Thịt gà mềm bên trong, da giòn bên ngoài, kết hợp cùng tỏi, ớt, chanh tạo nên vị cay nồng, chua dịu, ngọt đậm đà. Ăn kèm cơm nóng hoặc rau sống đều hấp dẫn, phù hợp cho bữa cơm gia đình hay tiệc nhẹ.	2025-08-05 16:06:52	2025-08-22 21:25:05	\N
12	Bánh Crepe Chuối và Bơ Lạc	16	1	B1: Bột crepe: Trộn 100g bột mì, 1 trứng, 150ml sữa, 1 thìa dầu ăn.\\nB2: Rán bánh: Đổ bột vào chảo chống dính, lật đều 2 mặt trong 2 phút.\\nB3: Nhân: Phết bơ đậu phộng, xếp chuối, cuộn lại.	1755336697_68a04ff949f19.jpg	Món bánh mỏng nhẹ thơm ngon với lớp vỏ crepe vàng óng, nhân chuối chín ngọt tự nhiên, rưới sốt caramel hoặc mật ong, điểm xuyến hạt óc chó giòn tan.	2025-08-05 16:09:23	2025-08-22 21:25:05	\N
13	Bún Thịt Nướng Chả Giò	13	2	B1: Ướp thịt: Thịt heo ướp tỏi, mật ong, nước mắm 30 phút, nướng than hoa.\\nB2: Chả giò: Cuốn nhân tôm thịt, chiên giòn.\\nB3: Trình bày: Xếp bún, rau, thịt, chả giò, rắc đậu phộng.	1755336362_68a04eaad83ee.jpg	Món bún truyền thống với thịt nướng thơm lừng, chả giò giòn rụm, kèm rau sống tươi và nước mắm chua ngọt đậm đà.	2025-08-10 20:34:00	2025-08-22 21:56:14	\N
14	Súp Bí Đỏ Hạt Diêm Mạch	2	3	B1: Hấp bí: Bí đỏ cắt nhỏ hấp chín, xay nhuyễn với nước dùng.\\nB2: Nấu quinoa: Luộc chín 20g quinoa trong 10 phút.\\nB3: Hoàn thành: Đun súp bí, thêm quinoa, nêm gia vị.	1755336345_68a04e993ec81.jpg	Súp ngọt tự nhiên từ bí đỏ, hạt quinoa dai dai giàu protein.	2025-08-10 20:34:53	2025-08-16 16:25:45	\N
15	Cà Ri Gà Nước Dừa	3	4	B1: Xào gia vị: Phi hành tỏi, cho bột cà ri vào đảo thơm.\\nB2: Nấu gà: Cho gà vào xào săn, thêm nước dừa, khoai tây, ninh 20 phút.	1755336332_68a04e8c91241.jpg	Món cà ri thơm ngon với thịt gà mềm, hòa quyện cùng nước dừa béo ngậy và gia vị đậm đà. Hương vị đặc trưng của nghệ, sả và lá chanh tạo nên món ăn hấp dẫn, ăn kèm bánh mì hoặc cơm nóng đều tuyệt vời.	2025-08-10 20:35:45	2025-08-16 16:25:32	\N
16	Bánh Mì Nướng Phô Mai và Tỏi	11	5	B1: Phết bơ tỏi: Trộn bơ mềm + tỏi băm + ngò.\\nB2: Nướng: Phết lên bánh mì, rắc phô mai, nướng 5 phút ở 180°C.	1755938201_68a97d99e1ff9.jpg	Giòn thơm từ tỏi, béo ngậy từ phô mai, hoàn hảo cho đêm muộn.	2025-08-10 20:36:54	2025-08-23 15:36:41	\N
17	Khoai Lang Lắc Phô Mai	15	6	B1: Cắt khoai: Khoai lang cắt que, ngâm nước muối 10 phút.\\nB2: Nướng: Xếp khoai lên khay, phun dầu, nướng 25 phút ở 200°C.\\nB3: Lắc phô mai: Trộn khoai nóng với phô mai bột.	1755938048_68a97d000e422.jpg	Khoai Lang Lắc Phô Mai - Món ăn vặt hấp dẫn từ khoai lang vàng ươm, bùi béo, kết hợp với phô mai béo ngậy, thêm chút vị mặn ngọt hài hòa, giòn rụm khó cưỡng.	2025-08-10 20:37:58	2025-08-23 15:50:49	\N
18	Dứa Dừa Bạc Hà	16	7	B1: Xay: 100g dứa + 50ml nước cốt dừa + 5 lá bạc hà + đá.\\nB2: Hoàn thành: Rót ra ly, thêm dừa nạo.	1755336239_68a04e2fe005f.jpg	Món giải khát thanh mát kết hợp vị ngọt tự nhiên của dứa, béo ngậy từ nước cốt dừa và hương thơm tươi mát của lá bạc hà. Hoàn hảo cho ngày hè nóng bức, giúp giải nhiệt và bổ sung năng lượng.	2025-08-10 20:39:06	2025-08-22 21:25:05	\N
2	Cơm sườn	\N	\N	\N	\N	\N	2026-04-04 00:00:00	\N	2026-04-04 00:00:00
19	Khâu nhục	13	1	Muối cải\\nNgâm cải muối khô\\nSơ chế thịt ba chỉ\\nƯớp và chiên thịt\\nKho thịt với cải muối\\nHấp thịt với cải muối\\nHoàn thành\\nThành phẩm	1755336113_68a04db13b83a.jpg	Khâu nhục là món thịt kho có nguồn gốc từ Quảng Đông, Trung Quốc. Khâu nhục được du nhập vào Bắc Việt qua sự biến tấu của người dân tộc Tày, Nùng, Ngái, qua thời gian đã trở thành món ăn Đặc sản nổi tiếng của huyện Tiên Yên, Quảng Ninh và Lạng Sơn, được dùng trong những dịp gia đình có chuyện vui như lễ Tết, ...	2025-08-11 03:03:58	2025-08-22 21:56:14	\N
20	Sinh tố lúa mạch	1	1	Gom tiền\\nĐến tập hóa, siêu thị gần nhất\\nTìm loại lúa mạch phù hợp với giá tiền\\nthanh toán\\nvề nhà\\nkhui ra\\nYô~~~~~~	1755336064_68a04d8050a38.png	Sinh tố lúa mạch là một thức uống bổ dưỡng và thơm ngon, được làm từ lúa mạch kết hợp với các loại trái cây, sữa, và các nguyên liệu khác. Món này không chỉ cung cấp năng lượng mà còn có nhiều lợi ích cho sức khỏe như cải thiện tiêu hóa, làm đẹp da và hỗ trợ giảm cân.	2025-08-12 16:12:57	2025-08-24 19:35:08	\N
21	Salad ức gà	12	6	B1:Rửa sạch rau và cà rốt.\\nB2:Luộc/nướng ức gà chín.\\nB3:Thái lát bơ. B4:Trộn tất cả với sốt dầu giấm.	1755584699_68a418bb2d564.jpg	Salad ức gà là món ăn nhẹ nhàng, thanh mát nhưng vẫn đảm bảo đầy đủ dinh dưỡng, rất được ưa chuộng trong thực đơn lành mạnh. Nguyên liệu chính là ức gà được luộc hoặc áp chảo chín mềm, xé sợi hoặc cắt lát mỏng, kết hợp cùng các loại rau củ tươi giòn như xà lách, cà chua bi, dưa leo, bắp ngọt, cà rốt… Tất cả hòa quyện với nước sốt chua ngọt hoặc sốt mè rang, tạo nên hương vị hài hòa, dễ ăn và không gây ngán.	2025-08-18 16:38:42	2025-08-19 13:24:59	\N
22	Phở bò	8	1	B1:Hầm xương bò làm nước dùng.\\nB2:Luộc bánh phở.\\nB3:Thái thịt bò lát mỏng.\\nB4:Chan nước dùng vào tô với bánh phở và thịt.	1755584538_68a4181a837f3.jpg	Phở bò là một trong những món ăn truyền thống nổi tiếng nhất của ẩm thực Việt Nam, được xem như “linh hồn” của bữa sáng và cũng là niềm tự hào với bạn bè quốc tế. Món ăn nổi bật với phần nước dùng trong, ngọt thanh, được ninh từ xương bò trong nhiều giờ liền, hòa quyện cùng hương thơm của quế, hồi, gừng và hành nướng. Chính sự kết hợp tinh tế này tạo nên vị nước phở đậm đà, dậy mùi đặc trưng khó lẫn.	2025-08-18 16:42:37	2025-08-19 13:22:18	\N
23	Cơm gà	13	16	B1:Luộc gà với gừng.\\nB2:Nấu cơm bằng nước luộc gà.\\nB3:Xé gà thành sợi.\\nB4:Ăn kèm dưa leo và cơm.	1755584135_68a41687f4130.jpg	Cơm gà là một món ăn quen thuộc nhưng luôn tạo được sức hấp dẫn nhờ sự kết hợp hài hòa giữa hạt cơm dẻo thơm và thịt gà mềm ngọt. Thịt gà được luộc hoặc hấp chín vừa tới, giữ được độ ngọt tự nhiên, sau đó xé hoặc chặt miếng. Phần cơm thường được nấu cùng nước luộc gà và chút mỡ hành để hạt cơm vàng óng, thơm béo và đậm đà hương vị. Khi bày ra đĩa, cơm gà thường ăn kèm với rau sống, dưa leo, thêm chén nước chấm chua ngọt hoặc gừng giã để làm nổi bật vị ngon.	2025-08-18 16:46:41	2025-08-22 21:56:14	\N
24	Cá hồi nướng	8	3	B1:Rửa sạch cá hồi và măng tây.\\nB2:Ướp cá hồi với muối, tiêu, nước chanh. B3:Nướng 10–15 phút.\\nB4:Ăn kèm măng tây nướng.	1755583768_68a41518b6c11.jpg	Cá hồi nướng là một món ăn sang trọng, giàu dinh dưỡng và được nhiều người ưa chuộng bởi hương vị thơm ngon, hấp dẫn. Miếng cá hồi tươi được tẩm ướp với các loại gia vị như muối, tiêu, tỏi, chanh hoặc thảo mộc, sau đó nướng chín vàng đều, giữ trọn vị ngọt tự nhiên và độ béo ngậy đặc trưng. Khi vừa chín tới, cá hồi mềm, mọng nước, lớp ngoài hơi giòn, tỏa ra hương thơm quyến rũ khiến thực khách khó lòng cưỡng lại.	2025-08-18 16:57:42	2025-08-19 13:09:28	\N
25	Sinh tố chuối	12	17	B1:Bóc vỏ chuối.\\nB2:Cho chuối và sữa hạnh nhân vào máy xay.\\nB3:Xay nhuyễn.\\nB4:Đổ ra ly và thưởng thức.	1755583510_68a414163ad97.png	Sinh tố chuối là một thức uống mát lạnh, thơm ngon và rất giàu dinh dưỡng, thường được nhiều người lựa chọn cho bữa sáng nhanh gọn hoặc làm món giải khát trong những ngày nắng nóng. Với nguyên liệu chính là chuối chín, sinh tố mang vị ngọt tự nhiên, béo ngậy khi kết hợp cùng sữa tươi hoặc sữa chua, tạo nên hương vị dịu nhẹ, dễ uống và phù hợp với mọi lứa tuổi.	2025-08-18 16:59:49	2025-08-19 13:07:35	\N
26	Canh bí đỏ tôm	13	5	B1:Gọt vỏ bí đỏ, cắt miếng vừa ăn.\\nB2:Rửa sạch tôm, lột vỏ, băm nhuyễn một nửa.\\nB3:Phi hành, xào tôm băm cho thơm.\\nB4:Thêm nước, cho bí đỏ vào nấu mềm.\\nB5: Cho tôm còn lại vào, nêm gia vị vừa ăn.	1755583373_68a4138d6b0fc.png	Canh bí đỏ tôm là một món ăn dân dã, quen thuộc trong bữa cơm gia đình Việt Nam, vừa thơm ngon lại bổ dưỡng. Món ăn được nấu từ những miếng bí đỏ chín mềm, ngọt tự nhiên, kết hợp cùng vị tươi ngọt của tôm, tạo nên hương vị hài hòa, dễ ăn và hấp dẫn. Nước canh trong, ngọt thanh, dậy mùi thơm nhẹ của hành ngò, khiến người thưởng thức cảm thấy ấm lòng và ngon miệng.	2025-08-18 17:02:54	2025-09-24 15:55:37	2025-09-24 15:55:37
27	Cá sấu chiên giòn	16	3	Chiên cá sấu\\nBới cơm	1755846796_68a8188c3ea34.jpg	\N	2025-08-22 14:13:16	2025-08-22 22:23:10	2025-08-22 22:23:10
28	Cá Sấu Luộc	1	3	Lột da cá sấu\\nLuộc 1 tiếng	1755875918_68a88a4e0d929.jpg	\N	2025-08-22 15:19:06	2025-08-22 22:23:06	2025-08-22 22:23:06
29	Bánh mì trứng giòn	18	1	Lấy bánh mì, nướng giòn\\nPhết bơ tươi\\nChiên trứng	1756087227_68abc3bb8e211.png	Một bữa sáng đơn giản	2025-08-24 19:29:52	2025-08-25 20:16:55	2025-08-25 20:16:55
30	Bánh mì trứng bơ	18	1	Bánh mì\\nChiên trứng\\nPhết bơ	1756087202_68abc3a2ba46d.jpg	Một bữa sáng đơn giản	2025-08-24 19:55:52	2025-08-25 20:16:53	2025-08-25 20:16:53
31	Gà tẩm mật ong và tỏi	13	6	Ướp gà\\nChiên	1756087190_68abc39675fe1.jpg	Món ăn tuyệt vời	2025-08-24 22:09:37	2025-08-25 20:16:44	2025-08-25 20:16:44
32	cá sấu áp chảo	19	3	ướp cá sấu\\náp chảo\\nbỏ ra dĩa	1756089613_68abcd0d46ca8.jpg	Thịt cá sấu trắng ngọt, mềm thịt, áp chảo nhanh giữ ẩm, ngon lạ vị – món protein thuần, ít béo, dành cho bữa tối độc đáo.	2025-08-25 09:40:13	2025-08-25 20:16:42	2025-08-25 20:16:42
33	Đà điểu chiên dòn	6	1	\N	1756091251_68abd37390b39.jpg	\N	2025-08-25 10:07:31	2025-08-25 20:16:39	2025-08-25 20:16:39
\.


--
-- TOC entry 3539 (class 0 OID 41105)
-- Dependencies: 243
-- Data for Name: meals_tags; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.meals_tags (id, meal_id, tag_id, created_at, updated_at, deleted_at) FROM stdin;
2	1	2	\N	\N	\N
3	2	2	2025-06-08 16:25:09	\N	\N
4	2	4	\N	\N	\N
5	3	5	2024-11-18 16:25:13	\N	\N
6	3	9	\N	\N	\N
7	4	5	\N	\N	\N
8	4	6	\N	\N	\N
10	5	8	\N	\N	\N
11	5	3	2015-08-02 16:25:20	\N	\N
12	6	3	\N	\N	\N
13	6	4	\N	\N	\N
14	7	9	\N	\N	\N
16	8	7	\N	\N	\N
17	8	2	\N	\N	\N
18	9	2	\N	\N	\N
19	9	3	2025-02-02 16:33:33	\N	\N
20	10	5	2018-08-09 16:33:49	\N	\N
21	10	9	\N	\N	\N
22	10	10	\N	\N	\N
24	12	1	\N	\N	\N
27	8	21	\N	\N	\N
28	9	21	\N	\N	\N
29	12	19	\N	\N	\N
30	7	20	\N	\N	\N
35	8	24	\N	\N	\N
43	1	23	\N	\N	\N
45	4	13	\N	\N	\N
48	3	36	\N	\N	\N
49	2	37	\N	\N	\N
51	8	41	\N	\N	\N
52	9	35	\N	\N	\N
57	19	2	\N	\N	\N
59	20	6	\N	\N	\N
64	9	42	\N	\N	\N
65	13	44	\N	\N	\N
67	5	43	\N	\N	\N
68	5	45	\N	\N	\N
69	12	37	\N	\N	\N
70	23	7	\N	\N	\N
71	20	14	\N	\N	\N
72	24	2	\N	\N	\N
73	27	4	\N	\N	\N
74	27	8	\N	\N	\N
75	27	13	\N	\N	\N
76	28	1	\N	\N	\N
77	22	2	\N	\N	\N
78	29	1	\N	\N	\N
81	11	42	\N	\N	\N
82	23	42	\N	\N	\N
83	31	1	\N	\N	\N
85	32	1	\N	\N	\N
86	32	2	\N	\N	\N
87	33	6	\N	\N	\N
\.


--
-- TOC entry 3514 (class 0 OID 40961)
-- Dependencies: 218
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.migrations (id, migration, batch) FROM stdin;
1	2019_12_14_000001_create_personal_access_tokens_table	1
2	2025_01_01_000001_create_accounts_table	1
3	2025_01_01_000002_create_allergens_table	1
4	2025_01_01_000003_create_contacts_table	1
5	2025_01_01_000004_create_diet_type_table	1
6	2025_01_01_000005_create_meal_type_table	1
7	2025_01_01_000006_create_tags_table	1
8	2025_01_01_000007_create_ingredients_table	1
9	2025_01_01_000008_create_meals_table	1
10	2025_01_01_000009_create_feedback_table	1
11	2025_01_01_000010_create_password_reset_tokens_table	1
12	2025_01_01_000011_create_meal_allergens_table	1
13	2025_01_01_000012_create_meals_tags_table	1
14	2025_01_01_000013_create_recipe_ingredients_table	1
15	2025_01_01_000014_create_user_allergens_table	1
\.


--
-- TOC entry 3535 (class 0 OID 41077)
-- Dependencies: 239
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
a@gmail.com	$2y$10$meLHR9VZ7eyyXq0ncR/99uwSzGusoS8xI87m5CWOppzfWdeVykUba	2026-01-27 10:17:36
dipthanhhong1020@gmail.com	$2y$10$Dp1hTk9nc5g/cZIAhp.O7OTiEtib278XpJFxvtGrpACSQ73ie1qAW	2025-08-19 23:19:36
john@example.com	$2y$10$1dCNRMAdVARBco75w4A4k.OxHPbzmB.vKowiuHKd5ZmLYi9vu.dQS	2025-08-19 22:39:47
trandangkhoa020704@gmail.com	$2y$10$AYpXIYRHnkCmlsKPQaCEKusHoIEGCipu4ybhKzWpaiESqvrEwGlqe	2026-03-14 21:03:55
trandangkhoa020704+1@gmail.com	$2y$10$Q9KB1utvRgI7.JklHYJnremYdFtdRvILqMpV7OYaAFcKhx2OMVp2G	2025-08-25 10:00:13
\.


--
-- TOC entry 3516 (class 0 OID 40968)
-- Dependencies: 220
-- Data for Name: personal_access_tokens; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.personal_access_tokens (id, tokenable_type, tokenable_id, name, token, abilities, last_used_at, expires_at, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 3541 (class 0 OID 41124)
-- Dependencies: 245
-- Data for Name: recipe_ingredients; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.recipe_ingredients (id, meal_id, ingredient_id, quantity, total_calo, created_at, updated_at, deleted_at) FROM stdin;
6	1	6	100	140	\N	\N	2025-08-11 09:05:32
7	1	3	50	12	\N	\N	2025-08-11 09:05:32
8	2	1	150	280	\N	\N	2025-08-11 09:05:17
9	2	2	70	10	\N	\N	2025-08-11 09:05:17
10	3	7	100	120	\N	\N	2025-08-11 09:05:02
11	3	8	50	20	\N	\N	2025-08-11 09:05:02
12	4	4	1	89	\N	\N	2025-08-11 09:04:43
13	4	10	200	50	\N	\N	2025-08-11 09:04:43
14	5	11	200	280	\N	\N	2025-08-11 09:04:26
15	5	9	80	25	\N	\N	2025-08-11 09:04:26
16	12	13	100	109.1	\N	\N	2025-08-11 13:50:52
17	11	1	100	156.4	\N	\N	2025-08-06 14:26:01
18	11	1	100	156.4	\N	\N	2025-08-07 08:35:53
19	11	1	100	156.4	\N	\N	2025-08-11 09:02:45
20	19	1	100	156.4	\N	\N	2025-08-11 03:04:47
21	19	1	100	156.4	\N	\N	2025-08-11 03:05:00
22	19	1	100	156.4	\N	\N	2025-08-11 03:05:17
23	19	1	100	156.4	\N	\N	2025-08-11 17:34:50
24	11	1	100	156.4	\N	\N	2025-08-13 10:06:12
25	5	11	200	394	\N	\N	2025-08-13 10:07:47
26	5	9	80	21.68	\N	\N	2025-08-13 10:07:47
27	4	4	1	1.16	\N	\N	2025-08-13 10:08:05
28	4	10	200	117.2	\N	\N	2025-08-13 10:08:05
29	3	7	100	118.7	\N	\N	2025-08-13 10:08:27
30	3	8	50	22.7	\N	\N	2025-08-13 10:08:27
31	2	1	150	234.6	\N	\N	2025-08-13 10:08:47
32	2	2	70	13.3	\N	\N	2025-08-13 10:08:47
33	1	6	100	155.8	\N	\N	2025-08-13 10:09:00
34	1	3	50	14.8	\N	\N	2025-08-13 10:09:00
35	12	13	100	109.1	\N	\N	2025-08-13 10:06:02
36	19	1	100	156.4	\N	\N	2025-08-11 17:36:58
37	19	1	100	156.4	\N	\N	2025-08-11 17:37:11
38	20	15	100	41.2	\N	\N	2025-08-13 10:03:46
39	19	1	100	156.4	\N	\N	2025-08-13 10:04:03
40	20	15	100	41.2	\N	\N	2025-08-13 12:17:17
41	19	1	100	156.4	\N	\N	2025-08-13 10:04:15
42	19	1	100	156.4	\N	\N	2025-08-13 21:09:13
43	12	13	100	109.1	\N	\N	2025-08-16 02:50:01
44	11	1	100	156.4	\N	\N	2025-08-15 00:02:39
45	5	11	200	394	\N	\N	2025-08-16 02:51:25
46	5	9	80	21.68	\N	\N	2025-08-16 02:51:25
47	4	4	1	1.16	\N	\N	2025-08-16 02:51:49
48	4	10	200	117.2	\N	\N	2025-08-16 02:51:49
49	3	7	100	118.7	\N	\N	2025-08-16 02:52:00
50	3	8	50	22.7	\N	\N	2025-08-16 02:52:00
51	2	1	150	234.6	\N	\N	2025-08-16 02:52:14
52	2	2	70	13.3	\N	\N	2025-08-16 02:52:14
53	1	6	100	155.8	\N	\N	2025-08-16 02:52:26
54	1	3	50	14.8	\N	\N	2025-08-16 02:52:26
55	20	27	100	1700	\N	\N	2025-08-13 21:00:15
56	18	2	100	19	\N	\N	2025-08-16 02:48:38
57	20	27	100	170	\N	\N	2025-08-13 23:47:07
58	19	1	10	15.64	\N	\N	2025-08-13 23:10:56
59	19	1	10	15.64	\N	\N	2025-08-13 23:48:20
60	20	27	100	170	\N	\N	2025-08-15 01:12:43
61	19	1	10	15.64	\N	\N	2025-08-13 23:48:41
62	19	1	10	15.64	\N	\N	2025-08-15 11:46:26
63	11	1	100	156.4	\N	\N	2025-08-16 02:50:15
64	20	27	100	170	\N	\N	2025-08-15 10:51:01
65	20	27	10	17	\N	\N	2025-08-15 10:58:33
66	20	27	5	8.5	\N	\N	2025-08-15 11:58:17
67	19	1	11	17.2	\N	\N	2025-08-16 02:48:27
68	20	27	5	8.5	\N	\N	2025-08-15 22:07:48
69	20	27	5	8.5	\N	\N	2025-08-16 02:47:59
70	20	27	5	8.5	\N	\N	2025-08-16 16:20:26
71	19	1	11	17.2	\N	\N	2025-08-16 16:21:53
72	18	2	100	19	\N	\N	2025-08-16 16:24:00
73	12	13	100	109.1	\N	\N	2025-08-16 16:31:37
74	11	1	100	156.4	\N	\N	2025-08-16 16:32:42
75	5	11	200	394	\N	\N	2025-08-16 16:38:30
76	5	9	80	21.68	\N	\N	2025-08-16 16:38:30
77	4	4	1	1.16	\N	\N	2025-08-16 16:38:44
78	4	10	200	117.2	\N	\N	2025-08-16 16:38:44
79	3	7	100	118.7	\N	\N	2025-08-16 16:38:57
80	3	8	50	22.7	\N	\N	2025-08-16 16:38:57
81	2	1	150	234.6	\N	\N	2025-08-16 16:39:23
82	2	2	70	13.3	\N	\N	2025-08-16 16:39:23
83	1	6	100	155.8	\N	\N	2025-08-16 16:39:45
84	1	3	50	14.8	\N	\N	2025-08-16 16:39:45
85	20	27	5	8.5	\N	\N	2025-08-16 16:21:04
86	20	27	5	8.5	\N	\N	2025-08-21 19:20:18
87	19	1	11	17.2	\N	\N	2025-08-19 13:25:19
88	18	2	100	19	\N	\N	\N
89	12	13	100	109.1	\N	\N	\N
90	11	1	100	156.4	\N	\N	\N
91	5	11	200	394	\N	\N	\N
92	5	9	80	21.68	\N	\N	\N
93	4	4	1	1.16	\N	\N	\N
94	4	10	200	117.2	\N	\N	\N
95	3	7	100	118.7	\N	\N	\N
96	3	8	50	22.7	\N	\N	\N
97	2	1	150	234.6	\N	\N	2025-08-21 20:09:40
98	2	2	70	13.3	\N	\N	2025-08-21 20:09:40
99	1	6	100	155.8	\N	\N	\N
100	1	3	50	14.8	\N	\N	\N
101	22	14	100	120	\N	\N	2025-08-19 13:22:18
102	21	1	50	88.8	\N	\N	2025-08-19 13:24:59
103	24	11	20	12.3	\N	\N	2025-08-19 13:09:28
104	23	1	60	10	\N	\N	2025-08-19 13:15:36
105	26	31	10	23.2	\N	\N	2025-08-19 13:02:53
106	26	31	10	8.9	\N	\N	2025-08-19 13:06:35
107	26	31	10	8.9	\N	\N	2025-08-21 16:52:11
108	24	11	20	39.4	\N	\N	2025-08-21 16:53:17
109	23	1	60	93.84	\N	\N	\N
110	22	14	100	239	\N	\N	2025-08-23 15:52:09
111	21	1	50	78.2	\N	\N	\N
112	19	1	11	17.2	\N	\N	2025-08-21 16:45:06
113	25	4	100	115.9	\N	\N	\N
114	25	69	100	61.7	\N	\N	\N
115	25	70	100	62.5	\N	\N	\N
116	6	10	100	58.6	\N	\N	\N
117	6	71	100	630	\N	\N	\N
118	19	28	150	351	\N	\N	2025-08-21 16:46:21
119	19	28	150	351	\N	\N	\N
120	19	66	100	115.8	\N	\N	\N
121	19	75	10	90	\N	\N	\N
122	26	31	100	89	\N	\N	2025-08-27 09:06:44
123	26	38	200	65.8	\N	\N	2025-08-27 09:06:44
124	24	11	200	394	\N	\N	2025-08-21 20:12:32
125	20	27	500	162	\N	\N	\N
126	2	1	150	234.6	\N	\N	\N
127	2	2	70	13.3	\N	\N	\N
128	24	11	200	394	\N	\N	2025-08-22 14:01:02
129	24	11	200	394	\N	\N	\N
130	28	78	100	690	\N	\N	2025-08-22 21:24:41
131	28	78	100	690	\N	\N	2025-08-22 22:18:38
132	28	78	100	690	\N	\N	\N
133	16	19	100	243.8	\N	\N	2025-08-23 15:36:41
134	16	69	100	61.7	\N	\N	2025-08-23 15:36:41
135	16	19	100	243.8	\N	\N	\N
136	16	69	100	61.7	\N	\N	\N
137	22	14	100	239	\N	\N	\N
138	22	13	200	218.2	\N	\N	\N
139	29	79	10	27.5	\N	\N	2025-08-24 19:32:13
140	29	6	50	77.9	\N	\N	2025-08-24 19:32:13
141	29	79	10	27.5	\N	\N	2025-08-24 19:33:26
142	29	6	50	77.9	\N	\N	2025-08-24 19:33:26
143	29	18	50	89.5	\N	\N	2025-08-24 19:33:26
144	29	79	10	27.5	\N	\N	2025-08-25 09:00:27
145	29	6	50	77.9	\N	\N	2025-08-25 09:00:27
146	29	18	50	89.5	\N	\N	2025-08-25 09:00:27
147	30	80	100	690	\N	\N	2025-08-24 19:56:29
148	30	18	100	179	\N	\N	2025-08-24 19:56:29
149	30	6	100	155.8	\N	\N	2025-08-24 19:56:29
150	30	80	100	690	\N	\N	2025-08-24 20:32:14
151	30	18	100	179	\N	\N	2025-08-24 20:32:14
152	30	6	100	155.8	\N	\N	2025-08-24 20:32:14
153	30	80	100	690	\N	\N	2025-08-24 21:41:30
154	30	18	100	179	\N	\N	2025-08-24 21:41:30
155	30	6	100	155.8	\N	\N	2025-08-24 21:41:30
156	30	80	2	13.8	\N	\N	2025-08-25 09:00:02
157	30	18	10	17.9	\N	\N	2025-08-25 09:00:02
158	30	6	5	7.79	\N	\N	2025-08-25 09:00:02
159	31	81	50	197.5	\N	\N	2025-08-24 22:10:30
160	31	82	15	45	\N	\N	2025-08-24 22:10:30
161	31	15	30	12.36	\N	\N	2025-08-24 22:10:30
162	31	81	50	197.5	\N	\N	2025-08-25 08:59:51
163	31	82	15	45	\N	\N	2025-08-25 08:59:51
164	31	15	30	12.36	\N	\N	2025-08-25 08:59:51
165	31	81	50	197.5	\N	\N	\N
166	31	82	15	45	\N	\N	\N
167	31	15	30	12.36	\N	\N	\N
168	30	80	2	13.8	\N	\N	\N
169	30	18	10	17.9	\N	\N	\N
170	30	6	5	7.79	\N	\N	\N
171	29	79	10	27.5	\N	\N	\N
172	29	6	50	77.9	\N	\N	\N
173	29	18	50	89.5	\N	\N	\N
174	32	78	30	207	\N	\N	\N
175	33	83	150	639	\N	\N	\N
176	26	31	100	89	\N	\N	\N
177	26	38	200	65.8	\N	\N	\N
\.


--
-- TOC entry 3528 (class 0 OID 41026)
-- Dependencies: 232
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.tags (id, name, created_at, updated_at, deleted_at) FROM stdin;
1	Nhanh	2025-06-02 18:13:12	\N	\N
2	Giàu đạm	2025-06-10 18:13:06	\N	\N
3	Ít tinh bột	2025-08-05 18:12:53	\N	\N
4	Không gluten	2025-08-14 18:12:56	\N	\N
5	Thuần chay	2025-07-08 18:12:59	\N	\N
6	Smoothie	2025-08-01 18:13:03	\N	\N
7	Truyền thống	2025-08-08 18:13:15	\N	\N
8	Axit béo tốt	2024-09-19 18:13:18	\N	\N
9	Chất xơ	2025-03-04 18:13:23	\N	\N
10	Tốt cho giấc ngủ	2025-03-03 18:13:27	\N	\N
11	Keto	2025-07-07 18:13:30	2025-08-21 14:25:03	2025-08-21 14:25:03
12	Ít béo	2025-06-03 18:16:28	\N	\N
13	High-Protein	2025-08-05 18:16:26	\N	\N
14	Ít đường	2025-03-06 18:13:34	\N	\N
15	Cho người tiểu đường	2025-08-06 18:16:09	2025-08-18 12:03:34	2025-08-18 12:03:34
16	Hạt mè	2025-05-05 18:13:37	2025-08-19 21:40:57	2025-08-19 21:40:57
17	Sesame	2025-08-01 18:16:11	\N	2025-08-05 10:03:40
18	Tuyệt cú mèo	2024-09-03 16:40:08	2025-08-22 23:05:53	2025-08-22 23:05:53
19	hết chỗ chê	2025-07-01 18:15:58	\N	\N
20	Trẻ em thích	2025-05-04 18:13:41	\N	\N
21	Atkins	2025-08-04 16:39:58	2025-08-24 19:51:00	2025-08-24 19:51:00
22	Halal (Hồi giáo)	2025-06-02 18:16:14	\N	2025-08-17 13:32:55
23	Ăn vặt	2025-05-05 16:40:03	\N	\N
24	Không sữa động vật	2025-06-03 18:16:18	2025-08-19 21:41:09	2025-08-19 21:41:09
27	ngon xoắn lưỡi	2025-05-12 18:11:04	\N	2025-08-07 04:56:43
29	đói	2025-07-03 18:16:21	\N	2025-08-07 02:10:08
30	không thể cưỡng nổi	2025-05-06 18:11:01	\N	2025-08-07 02:13:19
34	tuyệt vời	2025-07-16 18:15:32	\N	2025-08-10 08:47:36
35	đỉnh của chóp	2025-08-05 18:11:08	\N	\N
36	quá chill	2025-07-03 18:10:57	\N	\N
37	sao tránh được	2025-08-02 18:15:24	\N	\N
38	bánh tráng	2025-08-06 18:10:43	\N	2025-08-17 13:32:06
39	bánh	2025-08-03 18:15:19	\N	2025-08-07 06:05:10
40	ngon bá cháy	2025-04-15 18:13:45	2025-08-17 18:18:36	2025-08-17 18:18:36
41	quá đã	2025-04-15 18:10:48	\N	\N
42	quá đỉnh	2025-06-02 18:14:48	\N	\N
43	Món ăn gây nghiện	2025-05-06 18:10:53	\N	\N
44	gây ngán	2025-06-03 18:13:49	\N	2025-08-17 13:44:11
45	ô mai gót	2025-08-17 18:20:45	2025-08-17 18:20:45	\N
46	tuyệt	2025-08-24 16:46:45	2025-08-24 16:46:51	2025-08-24 16:46:51
47	Ăn nhanh	2025-08-24 19:50:28	2025-08-25 08:42:02	2025-08-25 08:42:02
\.


--
-- TOC entry 3543 (class 0 OID 41143)
-- Dependencies: 247
-- Data for Name: user_allergens; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_allergens (id, account_id, meal_id, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- TOC entry 3570 (class 0 OID 0)
-- Dependencies: 221
-- Name: accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.accounts_id_seq', 114, true);


--
-- TOC entry 3571 (class 0 OID 0)
-- Dependencies: 223
-- Name: allergens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.allergens_id_seq', 35, true);


--
-- TOC entry 3572 (class 0 OID 0)
-- Dependencies: 225
-- Name: contacts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.contacts_id_seq', 23, true);


--
-- TOC entry 3573 (class 0 OID 0)
-- Dependencies: 227
-- Name: diet_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.diet_type_id_seq', 19, true);


--
-- TOC entry 3574 (class 0 OID 0)
-- Dependencies: 237
-- Name: feedback_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.feedback_id_seq', 27, true);


--
-- TOC entry 3575 (class 0 OID 0)
-- Dependencies: 233
-- Name: ingredients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ingredients_id_seq', 83, true);


--
-- TOC entry 3576 (class 0 OID 0)
-- Dependencies: 240
-- Name: meal_allergens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.meal_allergens_id_seq', 51, true);


--
-- TOC entry 3577 (class 0 OID 0)
-- Dependencies: 229
-- Name: meal_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.meal_type_id_seq', 20, true);


--
-- TOC entry 3578 (class 0 OID 0)
-- Dependencies: 235
-- Name: meals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.meals_id_seq', 33, true);


--
-- TOC entry 3579 (class 0 OID 0)
-- Dependencies: 242
-- Name: meals_tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.meals_tags_id_seq', 87, true);


--
-- TOC entry 3580 (class 0 OID 0)
-- Dependencies: 217
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.migrations_id_seq', 15, true);


--
-- TOC entry 3581 (class 0 OID 0)
-- Dependencies: 219
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.personal_access_tokens_id_seq', 1, false);


--
-- TOC entry 3582 (class 0 OID 0)
-- Dependencies: 244
-- Name: recipe_ingredients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.recipe_ingredients_id_seq', 177, true);


--
-- TOC entry 3583 (class 0 OID 0)
-- Dependencies: 231
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tags_id_seq', 47, true);


--
-- TOC entry 3584 (class 0 OID 0)
-- Dependencies: 246
-- Name: user_allergens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_allergens_id_seq', 1, false);


--
-- TOC entry 3317 (class 2606 OID 40991)
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- TOC entry 3321 (class 2606 OID 41000)
-- Name: allergens allergens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.allergens
    ADD CONSTRAINT allergens_pkey PRIMARY KEY (id);


--
-- TOC entry 3323 (class 2606 OID 41010)
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- TOC entry 3325 (class 2606 OID 41017)
-- Name: diet_type diet_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.diet_type
    ADD CONSTRAINT diet_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3338 (class 2606 OID 41069)
-- Name: feedback feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_pkey PRIMARY KEY (id);


--
-- TOC entry 3331 (class 2606 OID 41038)
-- Name: ingredients ingredients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ingredients
    ADD CONSTRAINT ingredients_pkey PRIMARY KEY (id);


--
-- TOC entry 3344 (class 2606 OID 41090)
-- Name: meal_allergens meal_allergens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meal_allergens
    ADD CONSTRAINT meal_allergens_pkey PRIMARY KEY (id);


--
-- TOC entry 3327 (class 2606 OID 41024)
-- Name: meal_type meal_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meal_type
    ADD CONSTRAINT meal_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3335 (class 2606 OID 41047)
-- Name: meals meals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meals
    ADD CONSTRAINT meals_pkey PRIMARY KEY (id);


--
-- TOC entry 3347 (class 2606 OID 41110)
-- Name: meals_tags meals_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meals_tags
    ADD CONSTRAINT meals_tags_pkey PRIMARY KEY (id);


--
-- TOC entry 3310 (class 2606 OID 40966)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3340 (class 2606 OID 41083)
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- TOC entry 3312 (class 2606 OID 40975)
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 3314 (class 2606 OID 40978)
-- Name: personal_access_tokens personal_access_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);


--
-- TOC entry 3352 (class 2606 OID 41129)
-- Name: recipe_ingredients recipe_ingredients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recipe_ingredients
    ADD CONSTRAINT recipe_ingredients_pkey PRIMARY KEY (id);


--
-- TOC entry 3329 (class 2606 OID 41031)
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- TOC entry 3319 (class 2606 OID 40993)
-- Name: accounts unique_email; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT unique_email UNIQUE (email);


--
-- TOC entry 3356 (class 2606 OID 41148)
-- Name: user_allergens user_allergens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_allergens
    ADD CONSTRAINT user_allergens_pkey PRIMARY KEY (id);


--
-- TOC entry 3336 (class 1259 OID 41070)
-- Name: feedback_ibfk_1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX feedback_ibfk_1 ON public.feedback USING btree (account_id);


--
-- TOC entry 3341 (class 1259 OID 41092)
-- Name: meal_allergens_allergen_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX meal_allergens_allergen_id_index ON public.meal_allergens USING btree (allergen_id);


--
-- TOC entry 3342 (class 1259 OID 41091)
-- Name: meal_allergens_meal_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX meal_allergens_meal_id_index ON public.meal_allergens USING btree (meal_id);


--
-- TOC entry 3332 (class 1259 OID 41048)
-- Name: meals_diet_type_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX meals_diet_type_id_index ON public.meals USING btree (diet_type_id);


--
-- TOC entry 3333 (class 1259 OID 41049)
-- Name: meals_meal_type_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX meals_meal_type_id_index ON public.meals USING btree (meal_type_id);


--
-- TOC entry 3345 (class 1259 OID 41111)
-- Name: meals_tags_meal_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX meals_tags_meal_id_index ON public.meals_tags USING btree (meal_id);


--
-- TOC entry 3348 (class 1259 OID 41112)
-- Name: meals_tags_tag_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX meals_tags_tag_id_index ON public.meals_tags USING btree (tag_id);


--
-- TOC entry 3315 (class 1259 OID 40976)
-- Name: personal_access_tokens_tokenable_type_tokenable_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);


--
-- TOC entry 3349 (class 1259 OID 41131)
-- Name: recipe_ingredients_ingredient_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX recipe_ingredients_ingredient_id_index ON public.recipe_ingredients USING btree (ingredient_id);


--
-- TOC entry 3350 (class 1259 OID 41130)
-- Name: recipe_ingredients_meal_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX recipe_ingredients_meal_id_index ON public.recipe_ingredients USING btree (meal_id);


--
-- TOC entry 3353 (class 1259 OID 41149)
-- Name: user_allergens_account_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_allergens_account_id_index ON public.user_allergens USING btree (account_id);


--
-- TOC entry 3354 (class 1259 OID 41150)
-- Name: user_allergens_meal_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_allergens_meal_id_index ON public.user_allergens USING btree (meal_id);


--
-- TOC entry 3359 (class 2606 OID 41071)
-- Name: feedback feedback_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_ibfk_1 FOREIGN KEY (account_id) REFERENCES public.accounts(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 3360 (class 2606 OID 41094)
-- Name: meal_allergens meal_allergens_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meal_allergens
    ADD CONSTRAINT meal_allergens_ibfk_1 FOREIGN KEY (meal_id) REFERENCES public.meals(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 3361 (class 2606 OID 41099)
-- Name: meal_allergens meal_allergens_ibfk_2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meal_allergens
    ADD CONSTRAINT meal_allergens_ibfk_2 FOREIGN KEY (allergen_id) REFERENCES public.allergens(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 3362 (class 2606 OID 41113)
-- Name: meals_tags meal_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meals_tags
    ADD CONSTRAINT meal_id FOREIGN KEY (meal_id) REFERENCES public.meals(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3357 (class 2606 OID 41050)
-- Name: meals meals_diet_type_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meals
    ADD CONSTRAINT meals_diet_type_id_foreign FOREIGN KEY (diet_type_id) REFERENCES public.diet_type(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3358 (class 2606 OID 41055)
-- Name: meals meals_meal_type_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meals
    ADD CONSTRAINT meals_meal_type_id_foreign FOREIGN KEY (meal_type_id) REFERENCES public.meal_type(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3364 (class 2606 OID 41132)
-- Name: recipe_ingredients recipe_ingredients_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recipe_ingredients
    ADD CONSTRAINT recipe_ingredients_ibfk_1 FOREIGN KEY (meal_id) REFERENCES public.meals(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 3365 (class 2606 OID 41137)
-- Name: recipe_ingredients recipe_ingredients_ibfk_2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recipe_ingredients
    ADD CONSTRAINT recipe_ingredients_ibfk_2 FOREIGN KEY (ingredient_id) REFERENCES public.ingredients(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 3363 (class 2606 OID 41118)
-- Name: meals_tags tag_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meals_tags
    ADD CONSTRAINT tag_id FOREIGN KEY (tag_id) REFERENCES public.tags(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3366 (class 2606 OID 41151)
-- Name: user_allergens user_allergens_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_allergens
    ADD CONSTRAINT user_allergens_ibfk_1 FOREIGN KEY (account_id) REFERENCES public.accounts(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3367 (class 2606 OID 41156)
-- Name: user_allergens user_allergens_ibfk_2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_allergens
    ADD CONSTRAINT user_allergens_ibfk_2 FOREIGN KEY (meal_id) REFERENCES public.meals(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


-- Completed on 2026-04-04 14:55:42 +07

--
-- PostgreSQL database dump complete
--

\unrestrict ankZcfpnaSNfpRzSYuug2RgZHJnYmPDVOS2WFQYcjhA5abbLwcnoc496PxfgV9U

