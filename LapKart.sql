--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1 (Ubuntu 14.1-2.pgdg20.04+1)
-- Dumped by pg_dump version 14.1 (Ubuntu 14.1-2.pgdg20.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: accounts_account; Type: TABLE; Schema: public; Owner: ameer
--

CREATE TABLE public.accounts_account (
    id bigint NOT NULL,
    password character varying(128) NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    phone_number character varying(15) NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    last_login timestamp with time zone NOT NULL,
    is_admin boolean NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    is_superadmin boolean NOT NULL
);


ALTER TABLE public.accounts_account OWNER TO ameer;

--
-- Name: accounts_account_id_seq; Type: SEQUENCE; Schema: public; Owner: ameer
--

CREATE SEQUENCE public.accounts_account_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_account_id_seq OWNER TO ameer;

--
-- Name: accounts_account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ameer
--

ALTER SEQUENCE public.accounts_account_id_seq OWNED BY public.accounts_account.id;


--
-- Name: accounts_address; Type: TABLE; Schema: public; Owner: ameer
--

CREATE TABLE public.accounts_address (
    id bigint NOT NULL,
    last_name character varying(50) NOT NULL,
    pincode character varying(10) NOT NULL,
    email character varying(200) NOT NULL,
    city character varying(20) NOT NULL,
    first_name character varying(50) NOT NULL,
    state character varying(20) NOT NULL,
    user_id bigint NOT NULL,
    address_line_1 character varying(100) NOT NULL,
    address_line_2 character varying(100) NOT NULL,
    country character varying(20) NOT NULL,
    phone_number character varying(15) NOT NULL,
    address_type character varying(50),
    "default" boolean NOT NULL
);


ALTER TABLE public.accounts_address OWNER TO ameer;

--
-- Name: accounts_address_id_seq; Type: SEQUENCE; Schema: public; Owner: ameer
--

CREATE SEQUENCE public.accounts_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_address_id_seq OWNER TO ameer;

--
-- Name: accounts_address_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ameer
--

ALTER SEQUENCE public.accounts_address_id_seq OWNED BY public.accounts_address.id;


--
-- Name: accounts_userprofile; Type: TABLE; Schema: public; Owner: ameer
--

CREATE TABLE public.accounts_userprofile (
    id bigint NOT NULL,
    profile_picture character varying(100) NOT NULL,
    user_id bigint NOT NULL,
    address_line_1 character varying(100) NOT NULL,
    address_line_2 character varying(100) NOT NULL,
    city character varying(20) NOT NULL,
    country character varying(20) NOT NULL,
    state character varying(20) NOT NULL
);


ALTER TABLE public.accounts_userprofile OWNER TO ameer;

--
-- Name: accounts_userprofile_id_seq; Type: SEQUENCE; Schema: public; Owner: ameer
--

CREATE SEQUENCE public.accounts_userprofile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_userprofile_id_seq OWNER TO ameer;

--
-- Name: accounts_userprofile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ameer
--

ALTER SEQUENCE public.accounts_userprofile_id_seq OWNED BY public.accounts_userprofile.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: ameer
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO ameer;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: ameer
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO ameer;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ameer
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: ameer
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO ameer;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: ameer
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO ameer;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ameer
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: ameer
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO ameer;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: ameer
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO ameer;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ameer
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: brands_brand; Type: TABLE; Schema: public; Owner: ameer
--

CREATE TABLE public.brands_brand (
    id bigint NOT NULL,
    brand_name character varying(50) NOT NULL,
    slug character varying(100) NOT NULL,
    description text NOT NULL,
    logo character varying(100) NOT NULL
);


ALTER TABLE public.brands_brand OWNER TO ameer;

--
-- Name: brands_brand_id_seq; Type: SEQUENCE; Schema: public; Owner: ameer
--

CREATE SEQUENCE public.brands_brand_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.brands_brand_id_seq OWNER TO ameer;

--
-- Name: brands_brand_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ameer
--

ALTER SEQUENCE public.brands_brand_id_seq OWNED BY public.brands_brand.id;


--
-- Name: cart_cart; Type: TABLE; Schema: public; Owner: ameer
--

CREATE TABLE public.cart_cart (
    id bigint NOT NULL,
    cart_id character varying(250) NOT NULL,
    date_added date NOT NULL
);


ALTER TABLE public.cart_cart OWNER TO ameer;

--
-- Name: cart_cart_id_seq; Type: SEQUENCE; Schema: public; Owner: ameer
--

CREATE SEQUENCE public.cart_cart_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cart_cart_id_seq OWNER TO ameer;

--
-- Name: cart_cart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ameer
--

ALTER SEQUENCE public.cart_cart_id_seq OWNED BY public.cart_cart.id;


--
-- Name: cart_cartitem; Type: TABLE; Schema: public; Owner: ameer
--

CREATE TABLE public.cart_cartitem (
    id bigint NOT NULL,
    quantity integer NOT NULL,
    is_active boolean NOT NULL,
    cart_id bigint,
    user_id bigint,
    product_id bigint NOT NULL
);


ALTER TABLE public.cart_cartitem OWNER TO ameer;

--
-- Name: cart_cartitem_id_seq; Type: SEQUENCE; Schema: public; Owner: ameer
--

CREATE SEQUENCE public.cart_cartitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cart_cartitem_id_seq OWNER TO ameer;

--
-- Name: cart_cartitem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ameer
--

ALTER SEQUENCE public.cart_cartitem_id_seq OWNED BY public.cart_cartitem.id;


--
-- Name: cart_cartitem_variations; Type: TABLE; Schema: public; Owner: ameer
--

CREATE TABLE public.cart_cartitem_variations (
    id bigint NOT NULL,
    cartitem_id bigint NOT NULL,
    variation_id bigint NOT NULL
);


ALTER TABLE public.cart_cartitem_variations OWNER TO ameer;

--
-- Name: cart_cartitem_variations_id_seq; Type: SEQUENCE; Schema: public; Owner: ameer
--

CREATE SEQUENCE public.cart_cartitem_variations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cart_cartitem_variations_id_seq OWNER TO ameer;

--
-- Name: cart_cartitem_variations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ameer
--

ALTER SEQUENCE public.cart_cartitem_variations_id_seq OWNED BY public.cart_cartitem_variations.id;


--
-- Name: category_category; Type: TABLE; Schema: public; Owner: ameer
--

CREATE TABLE public.category_category (
    id bigint NOT NULL,
    category_name character varying(50) NOT NULL,
    slug character varying(100) NOT NULL,
    cat_image character varying(100) NOT NULL
);


ALTER TABLE public.category_category OWNER TO ameer;

--
-- Name: category_category_id_seq; Type: SEQUENCE; Schema: public; Owner: ameer
--

CREATE SEQUENCE public.category_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.category_category_id_seq OWNER TO ameer;

--
-- Name: category_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ameer
--

ALTER SEQUENCE public.category_category_id_seq OWNED BY public.category_category.id;


--
-- Name: coupon_coupon; Type: TABLE; Schema: public; Owner: ameer
--

CREATE TABLE public.coupon_coupon (
    id bigint NOT NULL,
    coupon_name character varying(25) NOT NULL,
    code character varying(25) NOT NULL,
    coupon_limit integer NOT NULL,
    valid_from date NOT NULL,
    valid_to date NOT NULL,
    discount integer NOT NULL,
    active boolean NOT NULL
);


ALTER TABLE public.coupon_coupon OWNER TO ameer;

--
-- Name: coupon_coupon_id_seq; Type: SEQUENCE; Schema: public; Owner: ameer
--

CREATE SEQUENCE public.coupon_coupon_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.coupon_coupon_id_seq OWNER TO ameer;

--
-- Name: coupon_coupon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ameer
--

ALTER SEQUENCE public.coupon_coupon_id_seq OWNED BY public.coupon_coupon.id;


--
-- Name: coupon_reviewcoupon; Type: TABLE; Schema: public; Owner: ameer
--

CREATE TABLE public.coupon_reviewcoupon (
    id bigint NOT NULL,
    coupon_id bigint NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.coupon_reviewcoupon OWNER TO ameer;

--
-- Name: coupon_reviewcoupon_id_seq; Type: SEQUENCE; Schema: public; Owner: ameer
--

CREATE SEQUENCE public.coupon_reviewcoupon_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.coupon_reviewcoupon_id_seq OWNER TO ameer;

--
-- Name: coupon_reviewcoupon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ameer
--

ALTER SEQUENCE public.coupon_reviewcoupon_id_seq OWNED BY public.coupon_reviewcoupon.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: ameer
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id bigint NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO ameer;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: ameer
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO ameer;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ameer
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: ameer
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO ameer;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: ameer
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO ameer;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ameer
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: ameer
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO ameer;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: ameer
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO ameer;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ameer
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: ameer
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO ameer;

--
-- Name: offer_brandoffer; Type: TABLE; Schema: public; Owner: ameer
--

CREATE TABLE public.offer_brandoffer (
    id bigint NOT NULL,
    discount integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    is_valid boolean NOT NULL,
    brand_name_id bigint NOT NULL
);


ALTER TABLE public.offer_brandoffer OWNER TO ameer;

--
-- Name: offer_brandoffer_id_seq; Type: SEQUENCE; Schema: public; Owner: ameer
--

CREATE SEQUENCE public.offer_brandoffer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.offer_brandoffer_id_seq OWNER TO ameer;

--
-- Name: offer_brandoffer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ameer
--

ALTER SEQUENCE public.offer_brandoffer_id_seq OWNED BY public.offer_brandoffer.id;


--
-- Name: offer_categoryoffer; Type: TABLE; Schema: public; Owner: ameer
--

CREATE TABLE public.offer_categoryoffer (
    id bigint NOT NULL,
    discount integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    is_valid boolean NOT NULL,
    category_name_id bigint NOT NULL
);


ALTER TABLE public.offer_categoryoffer OWNER TO ameer;

--
-- Name: offer_categoryoffer_id_seq; Type: SEQUENCE; Schema: public; Owner: ameer
--

CREATE SEQUENCE public.offer_categoryoffer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.offer_categoryoffer_id_seq OWNER TO ameer;

--
-- Name: offer_categoryoffer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ameer
--

ALTER SEQUENCE public.offer_categoryoffer_id_seq OWNED BY public.offer_categoryoffer.id;


--
-- Name: offer_productoffer; Type: TABLE; Schema: public; Owner: ameer
--

CREATE TABLE public.offer_productoffer (
    id bigint NOT NULL,
    discount integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    is_valid boolean NOT NULL,
    product_name_id bigint NOT NULL
);


ALTER TABLE public.offer_productoffer OWNER TO ameer;

--
-- Name: offer_productoffer_id_seq; Type: SEQUENCE; Schema: public; Owner: ameer
--

CREATE SEQUENCE public.offer_productoffer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.offer_productoffer_id_seq OWNER TO ameer;

--
-- Name: offer_productoffer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ameer
--

ALTER SEQUENCE public.offer_productoffer_id_seq OWNED BY public.offer_productoffer.id;


--
-- Name: orders_order; Type: TABLE; Schema: public; Owner: ameer
--

CREATE TABLE public.orders_order (
    id bigint NOT NULL,
    order_number character varying(50) NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    phone_number character varying(15) NOT NULL,
    email character varying(50) NOT NULL,
    address_line_1 character varying(50) NOT NULL,
    address_line_2 character varying(50) NOT NULL,
    country character varying(50) NOT NULL,
    state character varying(50) NOT NULL,
    city character varying(50) NOT NULL,
    order_note character varying(100) NOT NULL,
    order_total double precision NOT NULL,
    status character varying(10) NOT NULL,
    ip character varying(20) NOT NULL,
    is_ordered boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    payment_id bigint,
    user_id bigint,
    pincode integer NOT NULL,
    tax double precision NOT NULL
);


ALTER TABLE public.orders_order OWNER TO ameer;

--
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: ameer
--

CREATE SEQUENCE public.orders_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_order_id_seq OWNER TO ameer;

--
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ameer
--

ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders_order.id;


--
-- Name: orders_orderproduct; Type: TABLE; Schema: public; Owner: ameer
--

CREATE TABLE public.orders_orderproduct (
    id bigint NOT NULL,
    quantity integer NOT NULL,
    product_price double precision NOT NULL,
    ordered boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    order_id bigint NOT NULL,
    payment_id bigint,
    product_id bigint NOT NULL,
    user_id bigint NOT NULL,
    status character varying(50) NOT NULL
);


ALTER TABLE public.orders_orderproduct OWNER TO ameer;

--
-- Name: orders_orderproduct_id_seq; Type: SEQUENCE; Schema: public; Owner: ameer
--

CREATE SEQUENCE public.orders_orderproduct_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_orderproduct_id_seq OWNER TO ameer;

--
-- Name: orders_orderproduct_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ameer
--

ALTER SEQUENCE public.orders_orderproduct_id_seq OWNED BY public.orders_orderproduct.id;


--
-- Name: orders_orderproduct_variations; Type: TABLE; Schema: public; Owner: ameer
--

CREATE TABLE public.orders_orderproduct_variations (
    id bigint NOT NULL,
    orderproduct_id bigint NOT NULL,
    variation_id bigint NOT NULL
);


ALTER TABLE public.orders_orderproduct_variations OWNER TO ameer;

--
-- Name: orders_orderproduct_variations_id_seq; Type: SEQUENCE; Schema: public; Owner: ameer
--

CREATE SEQUENCE public.orders_orderproduct_variations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_orderproduct_variations_id_seq OWNER TO ameer;

--
-- Name: orders_orderproduct_variations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ameer
--

ALTER SEQUENCE public.orders_orderproduct_variations_id_seq OWNED BY public.orders_orderproduct_variations.id;


--
-- Name: orders_payment; Type: TABLE; Schema: public; Owner: ameer
--

CREATE TABLE public.orders_payment (
    id bigint NOT NULL,
    payment_id character varying(100) NOT NULL,
    payment_method character varying(100) NOT NULL,
    amount_paid character varying(100) NOT NULL,
    status character varying(100) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.orders_payment OWNER TO ameer;

--
-- Name: orders_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: ameer
--

CREATE SEQUENCE public.orders_payment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_payment_id_seq OWNER TO ameer;

--
-- Name: orders_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ameer
--

ALTER SEQUENCE public.orders_payment_id_seq OWNED BY public.orders_payment.id;


--
-- Name: store_banners; Type: TABLE; Schema: public; Owner: ameer
--

CREATE TABLE public.store_banners (
    id bigint NOT NULL,
    image character varying(100) NOT NULL,
    alt_text character varying(200) NOT NULL,
    product_id bigint NOT NULL,
    is_active boolean NOT NULL
);


ALTER TABLE public.store_banners OWNER TO ameer;

--
-- Name: store_banners_id_seq; Type: SEQUENCE; Schema: public; Owner: ameer
--

CREATE SEQUENCE public.store_banners_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.store_banners_id_seq OWNER TO ameer;

--
-- Name: store_banners_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ameer
--

ALTER SEQUENCE public.store_banners_id_seq OWNED BY public.store_banners.id;


--
-- Name: store_product; Type: TABLE; Schema: public; Owner: ameer
--

CREATE TABLE public.store_product (
    id bigint NOT NULL,
    product_name character varying(200) NOT NULL,
    slug character varying(200) NOT NULL,
    description text NOT NULL,
    images character varying(100),
    is_available boolean NOT NULL,
    created_date timestamp with time zone NOT NULL,
    modified_date timestamp with time zone NOT NULL,
    category_id bigint NOT NULL,
    images1 character varying(100),
    images2 character varying(100),
    images3 character varying(100),
    price integer NOT NULL,
    stock integer NOT NULL,
    brand_name_id bigint
);


ALTER TABLE public.store_product OWNER TO ameer;

--
-- Name: store_product_id_seq; Type: SEQUENCE; Schema: public; Owner: ameer
--

CREATE SEQUENCE public.store_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.store_product_id_seq OWNER TO ameer;

--
-- Name: store_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ameer
--

ALTER SEQUENCE public.store_product_id_seq OWNED BY public.store_product.id;


--
-- Name: store_reviewrating; Type: TABLE; Schema: public; Owner: ameer
--

CREATE TABLE public.store_reviewrating (
    id bigint NOT NULL,
    subject character varying(100) NOT NULL,
    review text NOT NULL,
    ip character varying(20) NOT NULL,
    status boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    product_id bigint NOT NULL,
    user_id bigint NOT NULL,
    rating double precision NOT NULL
);


ALTER TABLE public.store_reviewrating OWNER TO ameer;

--
-- Name: store_reviewrating_id_seq; Type: SEQUENCE; Schema: public; Owner: ameer
--

CREATE SEQUENCE public.store_reviewrating_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.store_reviewrating_id_seq OWNER TO ameer;

--
-- Name: store_reviewrating_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ameer
--

ALTER SEQUENCE public.store_reviewrating_id_seq OWNED BY public.store_reviewrating.id;


--
-- Name: store_variation; Type: TABLE; Schema: public; Owner: ameer
--

CREATE TABLE public.store_variation (
    id bigint NOT NULL,
    is_active boolean NOT NULL,
    created_date date NOT NULL,
    product_id bigint NOT NULL,
    variation_category character varying(100) NOT NULL,
    variation_value character varying(7) NOT NULL,
    color_name character varying(20) NOT NULL
);


ALTER TABLE public.store_variation OWNER TO ameer;

--
-- Name: store_variation_id_seq; Type: SEQUENCE; Schema: public; Owner: ameer
--

CREATE SEQUENCE public.store_variation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.store_variation_id_seq OWNER TO ameer;

--
-- Name: store_variation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ameer
--

ALTER SEQUENCE public.store_variation_id_seq OWNED BY public.store_variation.id;


--
-- Name: accounts_account id; Type: DEFAULT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.accounts_account ALTER COLUMN id SET DEFAULT nextval('public.accounts_account_id_seq'::regclass);


--
-- Name: accounts_address id; Type: DEFAULT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.accounts_address ALTER COLUMN id SET DEFAULT nextval('public.accounts_address_id_seq'::regclass);


--
-- Name: accounts_userprofile id; Type: DEFAULT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.accounts_userprofile ALTER COLUMN id SET DEFAULT nextval('public.accounts_userprofile_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: brands_brand id; Type: DEFAULT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.brands_brand ALTER COLUMN id SET DEFAULT nextval('public.brands_brand_id_seq'::regclass);


--
-- Name: cart_cart id; Type: DEFAULT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.cart_cart ALTER COLUMN id SET DEFAULT nextval('public.cart_cart_id_seq'::regclass);


--
-- Name: cart_cartitem id; Type: DEFAULT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.cart_cartitem ALTER COLUMN id SET DEFAULT nextval('public.cart_cartitem_id_seq'::regclass);


--
-- Name: cart_cartitem_variations id; Type: DEFAULT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.cart_cartitem_variations ALTER COLUMN id SET DEFAULT nextval('public.cart_cartitem_variations_id_seq'::regclass);


--
-- Name: category_category id; Type: DEFAULT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.category_category ALTER COLUMN id SET DEFAULT nextval('public.category_category_id_seq'::regclass);


--
-- Name: coupon_coupon id; Type: DEFAULT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.coupon_coupon ALTER COLUMN id SET DEFAULT nextval('public.coupon_coupon_id_seq'::regclass);


--
-- Name: coupon_reviewcoupon id; Type: DEFAULT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.coupon_reviewcoupon ALTER COLUMN id SET DEFAULT nextval('public.coupon_reviewcoupon_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: offer_brandoffer id; Type: DEFAULT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.offer_brandoffer ALTER COLUMN id SET DEFAULT nextval('public.offer_brandoffer_id_seq'::regclass);


--
-- Name: offer_categoryoffer id; Type: DEFAULT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.offer_categoryoffer ALTER COLUMN id SET DEFAULT nextval('public.offer_categoryoffer_id_seq'::regclass);


--
-- Name: offer_productoffer id; Type: DEFAULT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.offer_productoffer ALTER COLUMN id SET DEFAULT nextval('public.offer_productoffer_id_seq'::regclass);


--
-- Name: orders_order id; Type: DEFAULT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.orders_order ALTER COLUMN id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);


--
-- Name: orders_orderproduct id; Type: DEFAULT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.orders_orderproduct ALTER COLUMN id SET DEFAULT nextval('public.orders_orderproduct_id_seq'::regclass);


--
-- Name: orders_orderproduct_variations id; Type: DEFAULT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.orders_orderproduct_variations ALTER COLUMN id SET DEFAULT nextval('public.orders_orderproduct_variations_id_seq'::regclass);


--
-- Name: orders_payment id; Type: DEFAULT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.orders_payment ALTER COLUMN id SET DEFAULT nextval('public.orders_payment_id_seq'::regclass);


--
-- Name: store_banners id; Type: DEFAULT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.store_banners ALTER COLUMN id SET DEFAULT nextval('public.store_banners_id_seq'::regclass);


--
-- Name: store_product id; Type: DEFAULT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.store_product ALTER COLUMN id SET DEFAULT nextval('public.store_product_id_seq'::regclass);


--
-- Name: store_reviewrating id; Type: DEFAULT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.store_reviewrating ALTER COLUMN id SET DEFAULT nextval('public.store_reviewrating_id_seq'::regclass);


--
-- Name: store_variation id; Type: DEFAULT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.store_variation ALTER COLUMN id SET DEFAULT nextval('public.store_variation_id_seq'::regclass);


--
-- Data for Name: accounts_account; Type: TABLE DATA; Schema: public; Owner: ameer
--

COPY public.accounts_account (id, password, first_name, last_name, username, email, phone_number, date_joined, last_login, is_admin, is_staff, is_active, is_superadmin) FROM stdin;
2	pbkdf2_sha256$260000$7p4NPQd4lyxacQ31kYQPk6$Im13fcKYVy8lBc1+QNW9Vokv7KiaX+djtwhiKp7zFEo=	Anuragha	Menon	sreerag	sreerag@gmail.com	9539872431	2021-12-10 18:19:50.698339+05:30	2021-12-10 18:20:34.831967+05:30	f	f	t	f
1	pbkdf2_sha256$260000$qGLJhl1R9ARZF1jOWH4QKu$vCoKzUQmtIPtf+w/8isASvJzjyT4HtJK0ETKcAi0hsM=	Ameer	Amr	Ameer Amr	pameeramrp@gmail.com		2021-12-10 18:13:20.355599+05:30	2021-12-11 12:32:57.675649+05:30	t	t	t	t
\.


--
-- Data for Name: accounts_address; Type: TABLE DATA; Schema: public; Owner: ameer
--

COPY public.accounts_address (id, last_name, pincode, email, city, first_name, state, user_id, address_line_1, address_line_2, country, phone_number, address_type, "default") FROM stdin;
\.


--
-- Data for Name: accounts_userprofile; Type: TABLE DATA; Schema: public; Owner: ameer
--

COPY public.accounts_userprofile (id, profile_picture, user_id, address_line_1, address_line_2, city, country, state) FROM stdin;
1	default/default-image.png	2					
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: ameer
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: ameer
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: ameer
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add session	5	add_session
18	Can change session	5	change_session
19	Can delete session	5	delete_session
20	Can view session	5	view_session
21	Can add account	6	add_account
22	Can change account	6	change_account
23	Can delete account	6	delete_account
24	Can view account	6	view_account
25	Can add address	7	add_address
26	Can change address	7	change_address
27	Can delete address	7	delete_address
28	Can view address	7	view_address
29	Can add user profile	8	add_userprofile
30	Can change user profile	8	change_userprofile
31	Can delete user profile	8	delete_userprofile
32	Can view user profile	8	view_userprofile
33	Can add category	9	add_category
34	Can change category	9	change_category
35	Can delete category	9	delete_category
36	Can view category	9	view_category
37	Can add product	10	add_product
38	Can change product	10	change_product
39	Can delete product	10	delete_product
40	Can view product	10	view_product
41	Can add variation	11	add_variation
42	Can change variation	11	change_variation
43	Can delete variation	11	delete_variation
44	Can view variation	11	view_variation
45	Can add review rating	12	add_reviewrating
46	Can change review rating	12	change_reviewrating
47	Can delete review rating	12	delete_reviewrating
48	Can view review rating	12	view_reviewrating
49	Can add banners	13	add_banners
50	Can change banners	13	change_banners
51	Can delete banners	13	delete_banners
52	Can view banners	13	view_banners
53	Can add brand	14	add_brand
54	Can change brand	14	change_brand
55	Can delete brand	14	delete_brand
56	Can view brand	14	view_brand
57	Can add cart	15	add_cart
58	Can change cart	15	change_cart
59	Can delete cart	15	delete_cart
60	Can view cart	15	view_cart
61	Can add cart item	16	add_cartitem
62	Can change cart item	16	change_cartitem
63	Can delete cart item	16	delete_cartitem
64	Can view cart item	16	view_cartitem
65	Can add order	17	add_order
66	Can change order	17	change_order
67	Can delete order	17	delete_order
68	Can view order	17	view_order
69	Can add payment	18	add_payment
70	Can change payment	18	change_payment
71	Can delete payment	18	delete_payment
72	Can view payment	18	view_payment
73	Can add order product	19	add_orderproduct
74	Can change order product	19	change_orderproduct
75	Can delete order product	19	delete_orderproduct
76	Can view order product	19	view_orderproduct
77	Can add product offer	20	add_productoffer
78	Can change product offer	20	change_productoffer
79	Can delete product offer	20	delete_productoffer
80	Can view product offer	20	view_productoffer
81	Can add category offer	21	add_categoryoffer
82	Can change category offer	21	change_categoryoffer
83	Can delete category offer	21	delete_categoryoffer
84	Can view category offer	21	view_categoryoffer
85	Can add brand offer	22	add_brandoffer
86	Can change brand offer	22	change_brandoffer
87	Can delete brand offer	22	delete_brandoffer
88	Can view brand offer	22	view_brandoffer
89	Can add coupon	23	add_coupon
90	Can change coupon	23	change_coupon
91	Can delete coupon	23	delete_coupon
92	Can view coupon	23	view_coupon
93	Can add review coupon	24	add_reviewcoupon
94	Can change review coupon	24	change_reviewcoupon
95	Can delete review coupon	24	delete_reviewcoupon
96	Can view review coupon	24	view_reviewcoupon
\.


--
-- Data for Name: brands_brand; Type: TABLE DATA; Schema: public; Owner: ameer
--

COPY public.brands_brand (id, brand_name, slug, description, logo) FROM stdin;
1	Apple	apple	asdf	photos/brands/apple_air_m1_lg.jpeg
\.


--
-- Data for Name: cart_cart; Type: TABLE DATA; Schema: public; Owner: ameer
--

COPY public.cart_cart (id, cart_id, date_added) FROM stdin;
\.


--
-- Data for Name: cart_cartitem; Type: TABLE DATA; Schema: public; Owner: ameer
--

COPY public.cart_cartitem (id, quantity, is_active, cart_id, user_id, product_id) FROM stdin;
2	1	t	\N	2	1
3	1	t	\N	1	1
\.


--
-- Data for Name: cart_cartitem_variations; Type: TABLE DATA; Schema: public; Owner: ameer
--

COPY public.cart_cartitem_variations (id, cartitem_id, variation_id) FROM stdin;
2	3	2
\.


--
-- Data for Name: category_category; Type: TABLE DATA; Schema: public; Owner: ameer
--

COPY public.category_category (id, category_name, slug, cat_image) FROM stdin;
1	Business Laptops	business-laptops	photos/categories/apple_mcbook_air_m1_ze3AIo8.jpg
\.


--
-- Data for Name: coupon_coupon; Type: TABLE DATA; Schema: public; Owner: ameer
--

COPY public.coupon_coupon (id, coupon_name, code, coupon_limit, valid_from, valid_to, discount, active) FROM stdin;
1	WEEK100	WEEK100	10	2021-12-10	2021-12-15	100	t
\.


--
-- Data for Name: coupon_reviewcoupon; Type: TABLE DATA; Schema: public; Owner: ameer
--

COPY public.coupon_reviewcoupon (id, coupon_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: ameer
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: ameer
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	accounts	account
7	accounts	address
8	accounts	userprofile
9	category	category
10	store	product
11	store	variation
12	store	reviewrating
13	store	banners
14	brands	brand
15	cart	cart
16	cart	cartitem
17	orders	order
18	orders	payment
19	orders	orderproduct
20	offer	productoffer
21	offer	categoryoffer
22	offer	brandoffer
23	coupon	coupon
24	coupon	reviewcoupon
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: ameer
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	accounts	0001_initial	2021-12-10 10:56:10.265066+05:30
2	accounts	0002_auto_20211113_2258	2021-12-10 10:56:10.281222+05:30
3	accounts	0003_alter_account_phone_number	2021-12-10 10:56:10.297217+05:30
4	accounts	0004_address	2021-12-10 10:56:10.318506+05:30
5	accounts	0005_userprofile	2021-12-10 10:56:10.337605+05:30
6	accounts	0006_alter_userprofile_phone	2021-12-10 10:56:10.353756+05:30
7	accounts	0007_auto_20211125_1101	2021-12-10 10:56:10.418219+05:30
8	accounts	0008_auto_20211126_1125	2021-12-10 10:56:10.542149+05:30
9	accounts	0009_auto_20211126_1133	2021-12-10 10:56:10.562096+05:30
10	accounts	0010_auto_20211126_1410	2021-12-10 10:56:10.577537+05:30
11	accounts	0011_auto_20211126_1551	2021-12-10 10:56:10.597443+05:30
12	contenttypes	0001_initial	2021-12-10 10:56:10.613286+05:30
13	admin	0001_initial	2021-12-10 10:56:10.644893+05:30
14	admin	0002_logentry_remove_auto_add	2021-12-10 10:56:10.653732+05:30
15	admin	0003_logentry_add_action_flag_choices	2021-12-10 10:56:10.667987+05:30
16	contenttypes	0002_remove_content_type_name	2021-12-10 10:56:10.694004+05:30
17	auth	0001_initial	2021-12-10 10:56:10.770304+05:30
18	auth	0002_alter_permission_name_max_length	2021-12-10 10:56:10.7858+05:30
19	auth	0003_alter_user_email_max_length	2021-12-10 10:56:10.797565+05:30
20	auth	0004_alter_user_username_opts	2021-12-10 10:56:10.805608+05:30
21	auth	0005_alter_user_last_login_null	2021-12-10 10:56:10.817176+05:30
22	auth	0006_require_contenttypes_0002	2021-12-10 10:56:10.820342+05:30
23	auth	0007_alter_validators_add_error_messages	2021-12-10 10:56:10.834572+05:30
24	auth	0008_alter_user_username_max_length	2021-12-10 10:56:10.84662+05:30
25	auth	0009_alter_user_last_name_max_length	2021-12-10 10:56:10.859762+05:30
26	auth	0010_alter_group_name_max_length	2021-12-10 10:56:10.878899+05:30
27	auth	0011_update_proxy_permissions	2021-12-10 10:56:10.896951+05:30
28	auth	0012_alter_user_first_name_max_length	2021-12-10 10:56:10.909024+05:30
29	brands	0001_initial	2021-12-10 10:56:10.931365+05:30
30	category	0001_initial	2021-12-10 10:56:10.952544+05:30
31	category	0002_alter_category_slug	2021-12-10 10:56:10.959776+05:30
32	store	0001_initial	2021-12-10 10:56:10.991576+05:30
33	store	0002_productgallery	2021-12-10 10:56:11.010708+05:30
34	store	0003_alter_productgallery_options	2021-12-10 10:56:11.019114+05:30
35	store	0004_auto_20211119_0855	2021-12-10 10:56:11.054733+05:30
36	store	0005_variation	2021-12-10 10:56:11.07468+05:30
37	store	0006_auto_20211122_0508	2021-12-10 10:56:11.11348+05:30
38	store	0007_auto_20211122_0708	2021-12-10 10:56:11.147139+05:30
39	store	0008_auto_20211122_1108	2021-12-10 10:56:11.165137+05:30
40	store	0009_auto_20211122_1408	2021-12-10 10:56:11.181183+05:30
41	cart	0001_initial	2021-12-10 10:56:11.232647+05:30
42	cart	0002_remove_cartitem_product	2021-12-10 10:56:11.252823+05:30
43	cart	0003_auto_20211122_1614	2021-12-10 10:56:11.350907+05:30
44	category	0003_alter_category_options	2021-12-10 10:56:11.360239+05:30
45	coupon	0001_initial	2021-12-10 10:56:11.41735+05:30
46	coupon	0002_auto_20211203_1909	2021-12-10 10:56:11.445114+05:30
47	coupon	0003_alter_coupon_active	2021-12-10 10:56:11.453024+05:30
48	store	0010_auto_20211123_0520	2021-12-10 10:56:11.522139+05:30
49	store	0011_alter_variation_variation_value	2021-12-10 10:56:11.558365+05:30
50	store	0012_variation_color_name	2021-12-10 10:56:11.573629+05:30
51	store	0013_reviewrating	2021-12-10 10:56:11.621609+05:30
52	store	0014_reviewrating_rating	2021-12-10 10:56:11.645123+05:30
53	offer	0001_initial	2021-12-10 10:56:11.787314+05:30
54	offer	0002_auto_20211129_1349	2021-12-10 10:56:11.883372+05:30
55	orders	0001_initial	2021-12-10 10:56:12.057461+05:30
56	orders	0002_order_pin	2021-12-10 10:56:12.086767+05:30
57	orders	0003_order_tax	2021-12-10 10:56:12.114069+05:30
58	orders	0004_auto_20211126_1236	2021-12-10 10:56:12.158169+05:30
59	orders	0005_rename_pin_order_pincode	2021-12-10 10:56:12.180824+05:30
60	orders	0006_rename_phone_order_phone_number	2021-12-10 10:56:12.210439+05:30
61	orders	0007_auto_20211126_1538	2021-12-10 10:56:12.260861+05:30
62	orders	0008_orderproduct_status	2021-12-10 10:56:12.291356+05:30
63	orders	0009_alter_orderproduct_status	2021-12-10 10:56:12.322355+05:30
64	orders	0010_alter_order_order_number	2021-12-10 10:56:12.344341+05:30
65	sessions	0001_initial	2021-12-10 10:56:12.363788+05:30
66	store	0015_product_brand_name	2021-12-10 10:56:12.414402+05:30
67	store	0016_remove_product_brand_name	2021-12-10 10:56:12.459116+05:30
68	store	0017_product_brand_name	2021-12-10 10:56:12.506401+05:30
69	store	0018_remove_product_brand_name	2021-12-10 10:56:12.551985+05:30
70	store	0019_product_brand_name	2021-12-10 10:56:12.593307+05:30
71	store	0020_alter_product_brand_name	2021-12-10 10:56:12.636644+05:30
72	store	0021_banners	2021-12-10 10:56:12.686297+05:30
73	store	0022_alter_banners_image	2021-12-10 10:56:12.710588+05:30
74	store	0023_alter_banners_image	2021-12-10 10:56:12.733929+05:30
75	store	0024_delete_banners	2021-12-10 10:56:12.742973+05:30
76	store	0025_banners	2021-12-10 10:56:12.794442+05:30
77	store	0026_banners_category	2021-12-10 10:56:12.84481+05:30
78	store	0027_remove_banners_category	2021-12-10 10:56:12.89259+05:30
79	store	0028_banners_is_active	2021-12-10 10:56:12.913593+05:30
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: ameer
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
3yn1vrxegbosvpwn8zkgdu6ix4jg2m1o	eyJrZXkiOiJ2YWx1ZSJ9:1mvkIL:KHOn3tLX51aKM1dvIBrqaiuOh7zqctH7y7mI-DcrS5g	2021-12-24 23:36:57.951999+05:30
kkcr19j8g7v0ee1qil28r2wvadwzmc8u	.eJxVjcsOwiAQRf-FdUOAWkCX7v2G5gJT6wsMLSZq_Hdp0oUmdzP3cebNepR57MtEuT8FtmOSNb-eg79QXIJwRjwm7lOc88nxpcLXdOKHFOi6X7t_gBHTWNcIzm6d1qZTRpL0Al3nnA6KoLYWwxAI3rQeLSkY2lhpjfR2CNoN2BAq9ELPCnrgWqheGa-U73j2uKUSZ7azqtWdEFw0LOVQP8dyc5TrRAkl5SL2-QJ0QU4t:1mvyQC:bwQaQbdFJN3DyXBdAuknX0_EWVZgbDCn-3eDTSZDeYk	2021-12-25 14:42:00.037073+05:30
\.


--
-- Data for Name: offer_brandoffer; Type: TABLE DATA; Schema: public; Owner: ameer
--

COPY public.offer_brandoffer (id, discount, created_at, updated_at, is_valid, brand_name_id) FROM stdin;
\.


--
-- Data for Name: offer_categoryoffer; Type: TABLE DATA; Schema: public; Owner: ameer
--

COPY public.offer_categoryoffer (id, discount, created_at, updated_at, is_valid, category_name_id) FROM stdin;
\.


--
-- Data for Name: offer_productoffer; Type: TABLE DATA; Schema: public; Owner: ameer
--

COPY public.offer_productoffer (id, discount, created_at, updated_at, is_valid, product_name_id) FROM stdin;
1	5	2021-12-10 23:37:59.96021+05:30	2021-12-10 23:37:59.960239+05:30	t	1
\.


--
-- Data for Name: orders_order; Type: TABLE DATA; Schema: public; Owner: ameer
--

COPY public.orders_order (id, order_number, first_name, last_name, phone_number, email, address_line_1, address_line_2, country, state, city, order_note, order_total, status, ip, is_ordered, created_at, updated_at, payment_id, user_id, pincode, tax) FROM stdin;
1	202112111	Anuragha	Menon	07485963214	Anugraha@gmail.com	Hilite city,palazhi	calicut	India	kerala	Calicut		82365	New	127.0.0.1	f	2021-12-11 14:40:50.256396+05:30	2021-12-11 14:40:50.979491+05:30	\N	1	673645	1615
2	202112112	Anuragha	Menon	07485963214	Anugraha@gmail.com	Hilite city,palazhi	calicut	India	kerala	Calicut		82365	New	127.0.0.1	f	2021-12-11 14:41:01.162449+05:30	2021-12-11 14:41:01.630232+05:30	\N	1	673645	1615
\.


--
-- Data for Name: orders_orderproduct; Type: TABLE DATA; Schema: public; Owner: ameer
--

COPY public.orders_orderproduct (id, quantity, product_price, ordered, created_at, updated_at, order_id, payment_id, product_id, user_id, status) FROM stdin;
\.


--
-- Data for Name: orders_orderproduct_variations; Type: TABLE DATA; Schema: public; Owner: ameer
--

COPY public.orders_orderproduct_variations (id, orderproduct_id, variation_id) FROM stdin;
\.


--
-- Data for Name: orders_payment; Type: TABLE DATA; Schema: public; Owner: ameer
--

COPY public.orders_payment (id, payment_id, payment_method, amount_paid, status, created_at, user_id) FROM stdin;
\.


--
-- Data for Name: store_banners; Type: TABLE DATA; Schema: public; Owner: ameer
--

COPY public.store_banners (id, image, alt_text, product_id, is_active) FROM stdin;
\.


--
-- Data for Name: store_product; Type: TABLE DATA; Schema: public; Owner: ameer
--

COPY public.store_product (id, product_name, slug, description, images, is_available, created_date, modified_date, category_id, images1, images2, images3, price, stock, brand_name_id) FROM stdin;
1	Apple Macbook	apple-macbook-air-m1	Stylish & Portable Thin and Light Laptop\r\n13.3 inch Quad LED Backlit IPS Display (227 PPI, 400 nits Brightness, Wide Colour (P3), True Tone Technology)\r\nLight Laptop without	photos/products/mac_2019_7Yx8CJY.jpg	t	2021-12-10 18:16:04.399352+05:30	2021-12-10 19:40:19.928274+05:30	1	photos/products/mac_2019_IZ2xr1h.jpg	photos/products/mac_2019_4iw5QhB.jpg	photos/products/mac_2019_v192P0E.jpg	85000	50	1
\.


--
-- Data for Name: store_reviewrating; Type: TABLE DATA; Schema: public; Owner: ameer
--

COPY public.store_reviewrating (id, subject, review, ip, status, created_at, updated_at, product_id, user_id, rating) FROM stdin;
\.


--
-- Data for Name: store_variation; Type: TABLE DATA; Schema: public; Owner: ameer
--

COPY public.store_variation (id, is_active, created_date, product_id, variation_category, variation_value, color_name) FROM stdin;
2	t	2021-12-10	1	color	#000000	Black
\.


--
-- Name: accounts_account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameer
--

SELECT pg_catalog.setval('public.accounts_account_id_seq', 2, true);


--
-- Name: accounts_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameer
--

SELECT pg_catalog.setval('public.accounts_address_id_seq', 1, false);


--
-- Name: accounts_userprofile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameer
--

SELECT pg_catalog.setval('public.accounts_userprofile_id_seq', 1, true);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameer
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameer
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameer
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 96, true);


--
-- Name: brands_brand_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameer
--

SELECT pg_catalog.setval('public.brands_brand_id_seq', 1, true);


--
-- Name: cart_cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameer
--

SELECT pg_catalog.setval('public.cart_cart_id_seq', 1, false);


--
-- Name: cart_cartitem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameer
--

SELECT pg_catalog.setval('public.cart_cartitem_id_seq', 3, true);


--
-- Name: cart_cartitem_variations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameer
--

SELECT pg_catalog.setval('public.cart_cartitem_variations_id_seq', 2, true);


--
-- Name: category_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameer
--

SELECT pg_catalog.setval('public.category_category_id_seq', 1, true);


--
-- Name: coupon_coupon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameer
--

SELECT pg_catalog.setval('public.coupon_coupon_id_seq', 1, true);


--
-- Name: coupon_reviewcoupon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameer
--

SELECT pg_catalog.setval('public.coupon_reviewcoupon_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameer
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameer
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 24, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameer
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 79, true);


--
-- Name: offer_brandoffer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameer
--

SELECT pg_catalog.setval('public.offer_brandoffer_id_seq', 1, false);


--
-- Name: offer_categoryoffer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameer
--

SELECT pg_catalog.setval('public.offer_categoryoffer_id_seq', 1, false);


--
-- Name: offer_productoffer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameer
--

SELECT pg_catalog.setval('public.offer_productoffer_id_seq', 1, true);


--
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameer
--

SELECT pg_catalog.setval('public.orders_order_id_seq', 2, true);


--
-- Name: orders_orderproduct_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameer
--

SELECT pg_catalog.setval('public.orders_orderproduct_id_seq', 1, false);


--
-- Name: orders_orderproduct_variations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameer
--

SELECT pg_catalog.setval('public.orders_orderproduct_variations_id_seq', 1, false);


--
-- Name: orders_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameer
--

SELECT pg_catalog.setval('public.orders_payment_id_seq', 1, false);


--
-- Name: store_banners_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameer
--

SELECT pg_catalog.setval('public.store_banners_id_seq', 1, false);


--
-- Name: store_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameer
--

SELECT pg_catalog.setval('public.store_product_id_seq', 3, true);


--
-- Name: store_reviewrating_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameer
--

SELECT pg_catalog.setval('public.store_reviewrating_id_seq', 1, false);


--
-- Name: store_variation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ameer
--

SELECT pg_catalog.setval('public.store_variation_id_seq', 2, true);


--
-- Name: accounts_account accounts_account_email_key; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.accounts_account
    ADD CONSTRAINT accounts_account_email_key UNIQUE (email);


--
-- Name: accounts_account accounts_account_pkey; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.accounts_account
    ADD CONSTRAINT accounts_account_pkey PRIMARY KEY (id);


--
-- Name: accounts_account accounts_account_username_key; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.accounts_account
    ADD CONSTRAINT accounts_account_username_key UNIQUE (username);


--
-- Name: accounts_address accounts_address_pkey; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.accounts_address
    ADD CONSTRAINT accounts_address_pkey PRIMARY KEY (id);


--
-- Name: accounts_userprofile accounts_userprofile_pkey; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.accounts_userprofile
    ADD CONSTRAINT accounts_userprofile_pkey PRIMARY KEY (id);


--
-- Name: accounts_userprofile accounts_userprofile_user_id_key; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.accounts_userprofile
    ADD CONSTRAINT accounts_userprofile_user_id_key UNIQUE (user_id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: brands_brand brands_brand_brand_name_key; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.brands_brand
    ADD CONSTRAINT brands_brand_brand_name_key UNIQUE (brand_name);


--
-- Name: brands_brand brands_brand_pkey; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.brands_brand
    ADD CONSTRAINT brands_brand_pkey PRIMARY KEY (id);


--
-- Name: brands_brand brands_brand_slug_key; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.brands_brand
    ADD CONSTRAINT brands_brand_slug_key UNIQUE (slug);


--
-- Name: cart_cart cart_cart_pkey; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.cart_cart
    ADD CONSTRAINT cart_cart_pkey PRIMARY KEY (id);


--
-- Name: cart_cartitem cart_cartitem_pkey; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.cart_cartitem
    ADD CONSTRAINT cart_cartitem_pkey PRIMARY KEY (id);


--
-- Name: cart_cartitem_variations cart_cartitem_variations_cartitem_id_variation_id_be938c53_uniq; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.cart_cartitem_variations
    ADD CONSTRAINT cart_cartitem_variations_cartitem_id_variation_id_be938c53_uniq UNIQUE (cartitem_id, variation_id);


--
-- Name: cart_cartitem_variations cart_cartitem_variations_pkey; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.cart_cartitem_variations
    ADD CONSTRAINT cart_cartitem_variations_pkey PRIMARY KEY (id);


--
-- Name: category_category category_category_category_name_key; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.category_category
    ADD CONSTRAINT category_category_category_name_key UNIQUE (category_name);


--
-- Name: category_category category_category_pkey; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.category_category
    ADD CONSTRAINT category_category_pkey PRIMARY KEY (id);


--
-- Name: category_category category_category_slug_key; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.category_category
    ADD CONSTRAINT category_category_slug_key UNIQUE (slug);


--
-- Name: coupon_coupon coupon_coupon_code_key; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.coupon_coupon
    ADD CONSTRAINT coupon_coupon_code_key UNIQUE (code);


--
-- Name: coupon_coupon coupon_coupon_pkey; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.coupon_coupon
    ADD CONSTRAINT coupon_coupon_pkey PRIMARY KEY (id);


--
-- Name: coupon_reviewcoupon coupon_reviewcoupon_pkey; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.coupon_reviewcoupon
    ADD CONSTRAINT coupon_reviewcoupon_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: offer_brandoffer offer_brandoffer_brand_name_id_6ee12e65_uniq; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.offer_brandoffer
    ADD CONSTRAINT offer_brandoffer_brand_name_id_6ee12e65_uniq UNIQUE (brand_name_id);


--
-- Name: offer_brandoffer offer_brandoffer_pkey; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.offer_brandoffer
    ADD CONSTRAINT offer_brandoffer_pkey PRIMARY KEY (id);


--
-- Name: offer_categoryoffer offer_categoryoffer_category_name_id_2ef01155_uniq; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.offer_categoryoffer
    ADD CONSTRAINT offer_categoryoffer_category_name_id_2ef01155_uniq UNIQUE (category_name_id);


--
-- Name: offer_categoryoffer offer_categoryoffer_pkey; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.offer_categoryoffer
    ADD CONSTRAINT offer_categoryoffer_pkey PRIMARY KEY (id);


--
-- Name: offer_productoffer offer_productoffer_pkey; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.offer_productoffer
    ADD CONSTRAINT offer_productoffer_pkey PRIMARY KEY (id);


--
-- Name: offer_productoffer offer_productoffer_product_name_id_f2738b93_uniq; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.offer_productoffer
    ADD CONSTRAINT offer_productoffer_product_name_id_f2738b93_uniq UNIQUE (product_name_id);


--
-- Name: orders_order orders_order_pkey; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.orders_order
    ADD CONSTRAINT orders_order_pkey PRIMARY KEY (id);


--
-- Name: orders_orderproduct orders_orderproduct_pkey; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.orders_orderproduct
    ADD CONSTRAINT orders_orderproduct_pkey PRIMARY KEY (id);


--
-- Name: orders_orderproduct_variations orders_orderproduct_vari_orderproduct_id_variatio_8c028ee7_uniq; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.orders_orderproduct_variations
    ADD CONSTRAINT orders_orderproduct_vari_orderproduct_id_variatio_8c028ee7_uniq UNIQUE (orderproduct_id, variation_id);


--
-- Name: orders_orderproduct_variations orders_orderproduct_variations_pkey; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.orders_orderproduct_variations
    ADD CONSTRAINT orders_orderproduct_variations_pkey PRIMARY KEY (id);


--
-- Name: orders_payment orders_payment_pkey; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.orders_payment
    ADD CONSTRAINT orders_payment_pkey PRIMARY KEY (id);


--
-- Name: store_banners store_banners_pkey; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.store_banners
    ADD CONSTRAINT store_banners_pkey PRIMARY KEY (id);


--
-- Name: store_product store_product_pkey; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.store_product
    ADD CONSTRAINT store_product_pkey PRIMARY KEY (id);


--
-- Name: store_product store_product_product_name_key; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.store_product
    ADD CONSTRAINT store_product_product_name_key UNIQUE (product_name);


--
-- Name: store_product store_product_slug_key; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.store_product
    ADD CONSTRAINT store_product_slug_key UNIQUE (slug);


--
-- Name: store_reviewrating store_reviewrating_pkey; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.store_reviewrating
    ADD CONSTRAINT store_reviewrating_pkey PRIMARY KEY (id);


--
-- Name: store_variation store_variation_pkey; Type: CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.store_variation
    ADD CONSTRAINT store_variation_pkey PRIMARY KEY (id);


--
-- Name: accounts_account_email_348850e2_like; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX accounts_account_email_348850e2_like ON public.accounts_account USING btree (email varchar_pattern_ops);


--
-- Name: accounts_account_username_b5f69a28_like; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX accounts_account_username_b5f69a28_like ON public.accounts_account USING btree (username varchar_pattern_ops);


--
-- Name: accounts_address_user_id_c8c74ddf; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX accounts_address_user_id_c8c74ddf ON public.accounts_address USING btree (user_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: brands_brand_brand_name_04b61c43_like; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX brands_brand_brand_name_04b61c43_like ON public.brands_brand USING btree (brand_name varchar_pattern_ops);


--
-- Name: brands_brand_slug_9eee961a_like; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX brands_brand_slug_9eee961a_like ON public.brands_brand USING btree (slug varchar_pattern_ops);


--
-- Name: cart_cartitem_cart_id_370ad265; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX cart_cartitem_cart_id_370ad265 ON public.cart_cartitem USING btree (cart_id);


--
-- Name: cart_cartitem_product_id_b24e265a; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX cart_cartitem_product_id_b24e265a ON public.cart_cartitem USING btree (product_id);


--
-- Name: cart_cartitem_user_id_292943b8; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX cart_cartitem_user_id_292943b8 ON public.cart_cartitem USING btree (user_id);


--
-- Name: cart_cartitem_variations_cartitem_id_00884474; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX cart_cartitem_variations_cartitem_id_00884474 ON public.cart_cartitem_variations USING btree (cartitem_id);


--
-- Name: cart_cartitem_variations_variation_id_14becd55; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX cart_cartitem_variations_variation_id_14becd55 ON public.cart_cartitem_variations USING btree (variation_id);


--
-- Name: category_category_category_name_1aa3ee61_like; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX category_category_category_name_1aa3ee61_like ON public.category_category USING btree (category_name varchar_pattern_ops);


--
-- Name: category_category_slug_4f83d5f6_like; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX category_category_slug_4f83d5f6_like ON public.category_category USING btree (slug varchar_pattern_ops);


--
-- Name: coupon_coupon_code_2c51cdb0_like; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX coupon_coupon_code_2c51cdb0_like ON public.coupon_coupon USING btree (code varchar_pattern_ops);


--
-- Name: coupon_reviewcoupon_coupon_id_3ebd5ee3; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX coupon_reviewcoupon_coupon_id_3ebd5ee3 ON public.coupon_reviewcoupon USING btree (coupon_id);


--
-- Name: coupon_reviewcoupon_user_id_66723770; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX coupon_reviewcoupon_user_id_66723770 ON public.coupon_reviewcoupon USING btree (user_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: orders_order_payment_id_46928ccc; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX orders_order_payment_id_46928ccc ON public.orders_order USING btree (payment_id);


--
-- Name: orders_order_user_id_e9b59eb1; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX orders_order_user_id_e9b59eb1 ON public.orders_order USING btree (user_id);


--
-- Name: orders_orderproduct_order_id_5022a3e2; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX orders_orderproduct_order_id_5022a3e2 ON public.orders_orderproduct USING btree (order_id);


--
-- Name: orders_orderproduct_payment_id_492ed997; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX orders_orderproduct_payment_id_492ed997 ON public.orders_orderproduct USING btree (payment_id);


--
-- Name: orders_orderproduct_product_id_4d6ac024; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX orders_orderproduct_product_id_4d6ac024 ON public.orders_orderproduct USING btree (product_id);


--
-- Name: orders_orderproduct_user_id_1e7a7ab7; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX orders_orderproduct_user_id_1e7a7ab7 ON public.orders_orderproduct USING btree (user_id);


--
-- Name: orders_orderproduct_variations_orderproduct_id_0f116a3b; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX orders_orderproduct_variations_orderproduct_id_0f116a3b ON public.orders_orderproduct_variations USING btree (orderproduct_id);


--
-- Name: orders_orderproduct_variations_variation_id_5dfd0e51; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX orders_orderproduct_variations_variation_id_5dfd0e51 ON public.orders_orderproduct_variations USING btree (variation_id);


--
-- Name: orders_payment_user_id_cfa9f321; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX orders_payment_user_id_cfa9f321 ON public.orders_payment USING btree (user_id);


--
-- Name: store_banners_product_id_c74a2738; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX store_banners_product_id_c74a2738 ON public.store_banners USING btree (product_id);


--
-- Name: store_product_brand_name_id_f482299c; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX store_product_brand_name_id_f482299c ON public.store_product USING btree (brand_name_id);


--
-- Name: store_product_category_id_574bae65; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX store_product_category_id_574bae65 ON public.store_product USING btree (category_id);


--
-- Name: store_product_product_name_9d4b879d_like; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX store_product_product_name_9d4b879d_like ON public.store_product USING btree (product_name varchar_pattern_ops);


--
-- Name: store_product_slug_6de8ee4b_like; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX store_product_slug_6de8ee4b_like ON public.store_product USING btree (slug varchar_pattern_ops);


--
-- Name: store_reviewrating_product_id_2e1974d6; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX store_reviewrating_product_id_2e1974d6 ON public.store_reviewrating USING btree (product_id);


--
-- Name: store_reviewrating_user_id_da0ed849; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX store_reviewrating_user_id_da0ed849 ON public.store_reviewrating USING btree (user_id);


--
-- Name: store_variation_product_id_e4f08cbc; Type: INDEX; Schema: public; Owner: ameer
--

CREATE INDEX store_variation_product_id_e4f08cbc ON public.store_variation USING btree (product_id);


--
-- Name: accounts_address accounts_address_user_id_c8c74ddf_fk_accounts_account_id; Type: FK CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.accounts_address
    ADD CONSTRAINT accounts_address_user_id_c8c74ddf_fk_accounts_account_id FOREIGN KEY (user_id) REFERENCES public.accounts_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_userprofile accounts_userprofile_user_id_92240672_fk_accounts_account_id; Type: FK CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.accounts_userprofile
    ADD CONSTRAINT accounts_userprofile_user_id_92240672_fk_accounts_account_id FOREIGN KEY (user_id) REFERENCES public.accounts_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cart_cartitem cart_cartitem_cart_id_370ad265_fk_cart_cart_id; Type: FK CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.cart_cartitem
    ADD CONSTRAINT cart_cartitem_cart_id_370ad265_fk_cart_cart_id FOREIGN KEY (cart_id) REFERENCES public.cart_cart(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cart_cartitem cart_cartitem_product_id_b24e265a_fk_store_product_id; Type: FK CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.cart_cartitem
    ADD CONSTRAINT cart_cartitem_product_id_b24e265a_fk_store_product_id FOREIGN KEY (product_id) REFERENCES public.store_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cart_cartitem cart_cartitem_user_id_292943b8_fk_accounts_account_id; Type: FK CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.cart_cartitem
    ADD CONSTRAINT cart_cartitem_user_id_292943b8_fk_accounts_account_id FOREIGN KEY (user_id) REFERENCES public.accounts_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cart_cartitem_variations cart_cartitem_variat_cartitem_id_00884474_fk_cart_cart; Type: FK CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.cart_cartitem_variations
    ADD CONSTRAINT cart_cartitem_variat_cartitem_id_00884474_fk_cart_cart FOREIGN KEY (cartitem_id) REFERENCES public.cart_cartitem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cart_cartitem_variations cart_cartitem_variat_variation_id_14becd55_fk_store_var; Type: FK CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.cart_cartitem_variations
    ADD CONSTRAINT cart_cartitem_variat_variation_id_14becd55_fk_store_var FOREIGN KEY (variation_id) REFERENCES public.store_variation(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: coupon_reviewcoupon coupon_reviewcoupon_coupon_id_3ebd5ee3_fk_coupon_coupon_id; Type: FK CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.coupon_reviewcoupon
    ADD CONSTRAINT coupon_reviewcoupon_coupon_id_3ebd5ee3_fk_coupon_coupon_id FOREIGN KEY (coupon_id) REFERENCES public.coupon_coupon(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: coupon_reviewcoupon coupon_reviewcoupon_user_id_66723770_fk_accounts_account_id; Type: FK CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.coupon_reviewcoupon
    ADD CONSTRAINT coupon_reviewcoupon_user_id_66723770_fk_accounts_account_id FOREIGN KEY (user_id) REFERENCES public.accounts_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_accounts_account_id; Type: FK CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_accounts_account_id FOREIGN KEY (user_id) REFERENCES public.accounts_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offer_brandoffer offer_brandoffer_brand_name_id_6ee12e65_fk_brands_brand_id; Type: FK CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.offer_brandoffer
    ADD CONSTRAINT offer_brandoffer_brand_name_id_6ee12e65_fk_brands_brand_id FOREIGN KEY (brand_name_id) REFERENCES public.brands_brand(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offer_categoryoffer offer_categoryoffer_category_name_id_2ef01155_fk_category_; Type: FK CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.offer_categoryoffer
    ADD CONSTRAINT offer_categoryoffer_category_name_id_2ef01155_fk_category_ FOREIGN KEY (category_name_id) REFERENCES public.category_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offer_productoffer offer_productoffer_product_name_id_f2738b93_fk_store_product_id; Type: FK CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.offer_productoffer
    ADD CONSTRAINT offer_productoffer_product_name_id_f2738b93_fk_store_product_id FOREIGN KEY (product_name_id) REFERENCES public.store_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_order orders_order_payment_id_46928ccc_fk_orders_payment_id; Type: FK CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.orders_order
    ADD CONSTRAINT orders_order_payment_id_46928ccc_fk_orders_payment_id FOREIGN KEY (payment_id) REFERENCES public.orders_payment(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_order orders_order_user_id_e9b59eb1_fk_accounts_account_id; Type: FK CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.orders_order
    ADD CONSTRAINT orders_order_user_id_e9b59eb1_fk_accounts_account_id FOREIGN KEY (user_id) REFERENCES public.accounts_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_orderproduct_variations orders_orderproduct__orderproduct_id_0f116a3b_fk_orders_or; Type: FK CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.orders_orderproduct_variations
    ADD CONSTRAINT orders_orderproduct__orderproduct_id_0f116a3b_fk_orders_or FOREIGN KEY (orderproduct_id) REFERENCES public.orders_orderproduct(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_orderproduct_variations orders_orderproduct__variation_id_5dfd0e51_fk_store_var; Type: FK CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.orders_orderproduct_variations
    ADD CONSTRAINT orders_orderproduct__variation_id_5dfd0e51_fk_store_var FOREIGN KEY (variation_id) REFERENCES public.store_variation(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_orderproduct orders_orderproduct_order_id_5022a3e2_fk_orders_order_id; Type: FK CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.orders_orderproduct
    ADD CONSTRAINT orders_orderproduct_order_id_5022a3e2_fk_orders_order_id FOREIGN KEY (order_id) REFERENCES public.orders_order(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_orderproduct orders_orderproduct_payment_id_492ed997_fk_orders_payment_id; Type: FK CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.orders_orderproduct
    ADD CONSTRAINT orders_orderproduct_payment_id_492ed997_fk_orders_payment_id FOREIGN KEY (payment_id) REFERENCES public.orders_payment(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_orderproduct orders_orderproduct_product_id_4d6ac024_fk_store_product_id; Type: FK CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.orders_orderproduct
    ADD CONSTRAINT orders_orderproduct_product_id_4d6ac024_fk_store_product_id FOREIGN KEY (product_id) REFERENCES public.store_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_orderproduct orders_orderproduct_user_id_1e7a7ab7_fk_accounts_account_id; Type: FK CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.orders_orderproduct
    ADD CONSTRAINT orders_orderproduct_user_id_1e7a7ab7_fk_accounts_account_id FOREIGN KEY (user_id) REFERENCES public.accounts_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_payment orders_payment_user_id_cfa9f321_fk_accounts_account_id; Type: FK CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.orders_payment
    ADD CONSTRAINT orders_payment_user_id_cfa9f321_fk_accounts_account_id FOREIGN KEY (user_id) REFERENCES public.accounts_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: store_banners store_banners_product_id_c74a2738_fk_store_product_id; Type: FK CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.store_banners
    ADD CONSTRAINT store_banners_product_id_c74a2738_fk_store_product_id FOREIGN KEY (product_id) REFERENCES public.store_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: store_product store_product_brand_name_id_f482299c_fk_brands_brand_id; Type: FK CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.store_product
    ADD CONSTRAINT store_product_brand_name_id_f482299c_fk_brands_brand_id FOREIGN KEY (brand_name_id) REFERENCES public.brands_brand(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: store_product store_product_category_id_574bae65_fk_category_category_id; Type: FK CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.store_product
    ADD CONSTRAINT store_product_category_id_574bae65_fk_category_category_id FOREIGN KEY (category_id) REFERENCES public.category_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: store_reviewrating store_reviewrating_product_id_2e1974d6_fk_store_product_id; Type: FK CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.store_reviewrating
    ADD CONSTRAINT store_reviewrating_product_id_2e1974d6_fk_store_product_id FOREIGN KEY (product_id) REFERENCES public.store_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: store_reviewrating store_reviewrating_user_id_da0ed849_fk_accounts_account_id; Type: FK CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.store_reviewrating
    ADD CONSTRAINT store_reviewrating_user_id_da0ed849_fk_accounts_account_id FOREIGN KEY (user_id) REFERENCES public.accounts_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: store_variation store_variation_product_id_e4f08cbc_fk_store_product_id; Type: FK CONSTRAINT; Schema: public; Owner: ameer
--

ALTER TABLE ONLY public.store_variation
    ADD CONSTRAINT store_variation_product_id_e4f08cbc_fk_store_product_id FOREIGN KEY (product_id) REFERENCES public.store_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

