--
-- PostgreSQL database dump
--

-- Dumped from database version 10.3
-- Dumped by pg_dump version 10.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.subtype DROP CONSTRAINT IF EXISTS subtype_fk;
ALTER TABLE IF EXISTS ONLY public.plans DROP CONSTRAINT IF EXISTS plans_fk;
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS orderstatusfk;
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS ordersclientfk;
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS orders_ordertypes_id_fk;
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS orders_fk1;
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS orders_fk;
ALTER TABLE IF EXISTS ONLY public.options DROP CONSTRAINT IF EXISTS options_fk;
ALTER TABLE IF EXISTS ONLY public.clients DROP CONSTRAINT IF EXISTS clients_fk;
DROP TRIGGER IF EXISTS update_user_date_oncreate ON public.users;
DROP INDEX IF EXISTS public.users_id_uindex;
DROP INDEX IF EXISTS public.sidebarmenuitems_id_uindex;
DROP INDEX IF EXISTS public.ordertypes_id_uindex;
DROP INDEX IF EXISTS public.orders_id_uindex;
DROP INDEX IF EXISTS public.order_status_id_uindex;
DROP INDEX IF EXISTS public.clients_id_uindex;
ALTER TABLE IF EXISTS ONLY public.whereclientfrom DROP CONSTRAINT IF EXISTS whereclientfrom_pkey;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY public.test DROP CONSTRAINT IF EXISTS test_pkey;
ALTER TABLE IF EXISTS ONLY public.t1 DROP CONSTRAINT IF EXISTS t1_pkey;
ALTER TABLE IF EXISTS ONLY public.subtype DROP CONSTRAINT IF EXISTS subtype_pkey;
ALTER TABLE IF EXISTS ONLY public.sidebarmenuitems DROP CONSTRAINT IF EXISTS sidebarmenuitems_pkey;
ALTER TABLE IF EXISTS ONLY public.plans DROP CONSTRAINT IF EXISTS plans_pkey;
ALTER TABLE IF EXISTS ONLY public.ordertypes DROP CONSTRAINT IF EXISTS ordertypes_pkey;
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS orders_pkey;
ALTER TABLE IF EXISTS ONLY public.order_status DROP CONSTRAINT IF EXISTS order_status_pkey;
ALTER TABLE IF EXISTS ONLY public.options DROP CONSTRAINT IF EXISTS options_pkey;
ALTER TABLE IF EXISTS ONLY public.clients DROP CONSTRAINT IF EXISTS clients_id_pk;
ALTER TABLE IF EXISTS public.whereclientfrom ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.test ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sidebarmenuitems ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.ordertypes ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.orders ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.order_status ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.clients ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.whereclientfrom_id_seq;
DROP TABLE IF EXISTS public.whereclientfrom;
DROP VIEW IF EXISTS public.view;
DROP SEQUENCE IF EXISTS public.users_id_seq;
DROP TABLE IF EXISTS public.users;
DROP SEQUENCE IF EXISTS public.testseq;
DROP SEQUENCE IF EXISTS public.test_id_seq;
DROP TABLE IF EXISTS public.test;
DROP TABLE IF EXISTS public.t1;
DROP SEQUENCE IF EXISTS public.subtype_id_seq;
DROP TABLE IF EXISTS public.subtype;
DROP SEQUENCE IF EXISTS public.sidebarmenuitems_id_seq;
DROP TABLE IF EXISTS public.sidebarmenuitems;
DROP SEQUENCE IF EXISTS public.plans_id_seq;
DROP TABLE IF EXISTS public.plans;
DROP SEQUENCE IF EXISTS public.ordertypes_id_seq;
DROP TABLE IF EXISTS public.ordertypes;
DROP SEQUENCE IF EXISTS public.orders_id_seq;
DROP TABLE IF EXISTS public.orders;
DROP SEQUENCE IF EXISTS public.order_status_id_seq;
DROP TABLE IF EXISTS public.order_status;
DROP SEQUENCE IF EXISTS public.options_id_seq;
DROP TABLE IF EXISTS public.options;
DROP SEQUENCE IF EXISTS public.clients_id_seq;
DROP TABLE IF EXISTS public.clients;
DROP TABLE IF EXISTS public."Test";
DROP FUNCTION IF EXISTS public.userid(login character varying, pwd character varying);
DROP FUNCTION IF EXISTS public.usercheck(login character varying, pwd character varying);
DROP FUNCTION IF EXISTS public.update_user_created_date();
DROP FUNCTION IF EXISTS public.onlylogincheck(login character varying);
DROP FUNCTION IF EXISTS public.onlyemailcheck(email character varying);
DROP FUNCTION IF EXISTS public.get_sidebarmenu3(v1 integer);
DROP FUNCTION IF EXISTS public.get_sidebarmenu2(v1 integer);
DROP FUNCTION IF EXISTS public.get_plans_2(id integer);
DROP FUNCTION IF EXISTS public.get_plans();
DROP FUNCTION IF EXISTS public.get_options_for_plan(plan_id integer);
DROP FUNCTION IF EXISTS public.gao4();
DROP FUNCTION IF EXISTS public.gao3();
DROP FUNCTION IF EXISTS public.gao2();
DROP FUNCTION IF EXISTS public.gao(userid bigint);
DROP TYPE IF EXISTS public.compfoo;
DROP EXTENSION IF EXISTS adminpack;
DROP EXTENSION IF EXISTS plpgsql;
DROP SCHEMA IF EXISTS public;
--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- Name: compfoo; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.compfoo AS (
	id integer,
	username character varying
);


ALTER TYPE public.compfoo OWNER TO postgres;

--
-- Name: gao(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.gao(userid bigint DEFAULT 2) RETURNS TABLE(id integer, client json, order_short_name character varying, order_info character varying, order_cost integer, order_create_date timestamp without time zone, order_deadline timestamp without time zone, order_type integer, sub_type integer, plan integer, order_status json)
    LANGUAGE sql
    AS $_$
   Select orders.id, (select row_to_json(t) from (select clients.id, clients.name from clients where clients.id = orders.client) t) as Rr,
   orders.order_short_name, orders.order_info, orders.order_cost, orders.order_create_date, orders.order_deadline, 
   orders.order_type, orders.order_sub_type, orders.order_plan, 
   (select row_to_json(s) from (select order_status.id, order_status.status from order_status where order_status.id = orders.order_status) s) as Status 
   From orders 
   where orders.user_id = $1;
$_$;


ALTER FUNCTION public.gao(userid bigint) OWNER TO postgres;

--
-- Name: gao2(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.gao2() RETURNS json
    LANGUAGE sql
    AS $$
      select row_to_json(dd) from (Select orders.id, (select row_to_json(t) from (select clients.id, clients.name from clients where clients.id = orders.client) t) as Rr,
   orders.order_short_name, orders.order_info, orders.order_cost, orders.order_create_date, orders.order_deadline, orders.order_type, orders.order_status 
   From orders 
   where orders.user_id = 2) as dd;
$$;


ALTER FUNCTION public.gao2() OWNER TO postgres;

--
-- Name: gao3(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.gao3() RETURNS public.compfoo
    LANGUAGE plpgsql
    AS $$
DECLARE
  result compfoo;
BEGIN
  SELECT orders.id, orders.order_short_name INTO result.id, result.username FROM orders;
  return result ;
END
$$;


ALTER FUNCTION public.gao3() OWNER TO postgres;

--
-- Name: gao4(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.gao4() RETURNS SETOF json
    LANGUAGE sql
    AS $$
      select row_to_json(dd) from (Select orders.id, (select row_to_json(t) from (select clients.id, clients.name from clients where clients.id = orders.client) t) as Rr,
   orders.order_short_name, orders.order_info, orders.order_cost, orders.order_create_date, orders.order_deadline, orders.order_type, 
   (select row_to_json(s) from (select order_status.id, order_status.status from order_status where order_status.id = orders.order_status) s) as orderstatus 
   From orders 
   where orders.user_id = 2) as dd;
$$;


ALTER FUNCTION public.gao4() OWNER TO postgres;

--
-- Name: get_options_for_plan(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_options_for_plan(plan_id integer DEFAULT 2) RETURNS TABLE(json json)
    LANGUAGE sql
    AS $_$
SELECT json_agg(r.*) as tags FROM (Select p.id, p.optionname From options p where p.plan_id=$1) AS r;
$_$;


ALTER FUNCTION public.get_options_for_plan(plan_id integer) OWNER TO postgres;

--
-- Name: get_plans(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_plans() RETURNS TABLE(plan character varying, json json)
    LANGUAGE sql
    AS $$
Select  pl.plan_name, (SELECT json_agg(r.*) as tags
FROM (Select p.id, p.optionname From options p INNER JOIN plans pu on p.plan_id = pu.id) AS r) as Rr 
 From plans pl INNER JOIN options op on pl.id = op.plan_id group by pl.plan_name;
 
 
 
 /* 
 
 , (SELECT json_agg(r.*) as tags
FROM (select options.id, options.optionname, options.plan_id from options, plans where options.plan_id = plans.id) AS r) as Rr
 
  */
$$;


ALTER FUNCTION public.get_plans() OWNER TO postgres;

--
-- Name: get_plans_2(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_plans_2(id integer DEFAULT 1) RETURNS TABLE(id integer, plan character varying, cost integer, parent_subtype_id integer, json json)
    LANGUAGE sql
    AS $_$
Select  pl.id, pl.plan_name, pl.cost, pl.parent_subtype_id, (Select * From get_options_for_plan(pl.id)) as r From plans pl where pl.parent_subtype_id=$1;
$_$;


ALTER FUNCTION public.get_plans_2(id integer) OWNER TO postgres;

--
-- Name: get_sidebarmenu2(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_sidebarmenu2(v1 integer) RETURNS TABLE(id integer, elementid integer, note character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN

   Select sidebarmenuitems.id, sidebarmenuitems.elementid, sidebarmenuitems.note
   From sidebarmenuitems 
   where sidebarmenuitems.user = v1;
   RETURN NEXT;
END; $$;


ALTER FUNCTION public.get_sidebarmenu2(v1 integer) OWNER TO postgres;

--
-- Name: get_sidebarmenu3(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_sidebarmenu3(v1 integer) RETURNS TABLE(i integer, e character varying)
    LANGUAGE sql
    AS $$    
   Select id, elementid From sidebarmenuitems where sidebarmenuitems.user = v1
$$;


ALTER FUNCTION public.get_sidebarmenu3(v1 integer) OWNER TO postgres;

--
-- Name: onlyemailcheck(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.onlyemailcheck(email character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
DECLARE
tmp integer;
BEGIN
SELECT count(*) INTO tmp FROM users WHERE users.email = $1;

IF tmp>0 THEN
      RETURN TRUE;
   ELSE
      RETURN FALSE;
   END IF;
END;
$_$;


ALTER FUNCTION public.onlyemailcheck(email character varying) OWNER TO postgres;

--
-- Name: onlylogincheck(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.onlylogincheck(login character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
DECLARE
tmp integer;
BEGIN
SELECT count(*) INTO tmp FROM users WHERE users.login = $1;

IF tmp>0 THEN
      RETURN TRUE;
   ELSE
      RETURN FALSE;
   END IF;
END;
$_$;


ALTER FUNCTION public.onlylogincheck(login character varying) OWNER TO postgres;

--
-- Name: update_user_created_date(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_user_created_date() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
 IF TG_OP='INSERT' THEN
       NEW.datecreated = now();
    END IF;
 RETURN NEW;
 END;
$$;


ALTER FUNCTION public.update_user_created_date() OWNER TO postgres;

--
-- Name: usercheck(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.usercheck(login character varying, pwd character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
DECLARE
tmp integer;
BEGIN
SELECT count(*) INTO tmp FROM users WHERE users.login = $1 AND users.pwd=$2;

IF tmp>0 THEN
      RETURN TRUE;
   ELSE
      RETURN FALSE;
   END IF;
END;
$_$;


ALTER FUNCTION public.usercheck(login character varying, pwd character varying) OWNER TO postgres;

--
-- Name: userid(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.userid(login character varying, pwd character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
tmp integer;
BEGIN
SELECT users.id INTO tmp FROM users WHERE users.login = $1 AND users.pwd=$2;
      RETURN tmp;
END;
$_$;


ALTER FUNCTION public.userid(login character varying, pwd character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: Test; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Test" (
    id numeric,
    name character varying
);


ALTER TABLE public."Test" OWNER TO postgres;

--
-- Name: clients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clients (
    id integer NOT NULL,
    name character varying(255),
    phone character varying(11),
    email character varying(128),
    date_created timestamp without time zone,
    birthday timestamp without time zone,
    clientfrom character varying(128),
    user_id bigint,
    client_url character varying(512),
    whereclientfrom bigint
);


ALTER TABLE public.clients OWNER TO postgres;

--
-- Name: TABLE clients; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.clients IS 'КЛИЕНТЫ';


--
-- Name: COLUMN clients.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.clients.id IS 'ID КЛИЕНТА';


--
-- Name: COLUMN clients.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.clients.name IS 'ИМЯ КЛИЕНТА';


--
-- Name: COLUMN clients.phone; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.clients.phone IS 'ТЕЛЕФОН';


--
-- Name: COLUMN clients.email; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.clients.email IS 'ПОЧТА';


--
-- Name: COLUMN clients.date_created; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.clients.date_created IS 'ДАТА СОЗДАНИЯ КЛИЕНТА';


--
-- Name: COLUMN clients.birthday; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.clients.birthday IS 'ДАТА РОЖДЕНИЯ';


--
-- Name: COLUMN clients.clientfrom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.clients.clientfrom IS 'источник клиента';


--
-- Name: COLUMN clients.user_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.clients.user_id IS 'id юзера';


--
-- Name: COLUMN clients.client_url; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.clients.client_url IS 'Ссылка на любой профиль клиента: vk, insta.... все, что угодно.';


--
-- Name: COLUMN clients.whereclientfrom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.clients.whereclientfrom IS 'Откуда клиент';


--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.clients_id_seq OWNER TO postgres;

--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clients_id_seq OWNED BY public.clients.id;


--
-- Name: options; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.options (
    id integer DEFAULT nextval(('public.options_id_seq'::text)::regclass) NOT NULL,
    optionname character varying(255),
    plan_id integer
);


ALTER TABLE public.options OWNER TO postgres;

--
-- Name: COLUMN options.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.options.id IS 'id опции';


--
-- Name: COLUMN options.optionname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.options.optionname IS 'Имя опции';


--
-- Name: COLUMN options.plan_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.options.plan_id IS 'id плана';


--
-- Name: options_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.options_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.options_id_seq OWNER TO postgres;

--
-- Name: order_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_status (
    id integer NOT NULL,
    status character varying(255),
    user_id integer
);


ALTER TABLE public.order_status OWNER TO postgres;

--
-- Name: order_status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_status_id_seq OWNER TO postgres;

--
-- Name: order_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_status_id_seq OWNED BY public.order_status.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    client integer,
    order_short_name character varying(255),
    order_info character varying(1024),
    order_type integer,
    order_cost integer,
    order_create_date timestamp without time zone,
    order_deadline timestamp without time zone,
    order_status integer,
    user_id bigint NOT NULL,
    order_sub_type integer,
    order_plan integer
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: COLUMN orders.client; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.orders.client IS 'client id';


--
-- Name: COLUMN orders.order_short_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.orders.order_short_name IS 'КОРОТКОЕ НАЗВАНИЕ ЗАКАЗА';


--
-- Name: COLUMN orders.order_info; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.orders.order_info IS 'order full information';


--
-- Name: COLUMN orders.order_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.orders.order_type IS 'ТИП ЗАКАЗА';


--
-- Name: COLUMN orders.order_cost; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.orders.order_cost IS 'СТОИМОСТЬ ЗАКАЗА';


--
-- Name: COLUMN orders.order_create_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.orders.order_create_date IS 'ДАТА И ВРЕМЯ СОЗДАНИЯ';


--
-- Name: COLUMN orders.order_deadline; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.orders.order_deadline IS 'ДАТА СДАЧИ';


--
-- Name: COLUMN orders.order_status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.orders.order_status IS 'СТАТУС';


--
-- Name: COLUMN orders.user_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.orders.user_id IS 'юзер, к которому привязан заказ';


--
-- Name: COLUMN orders.order_sub_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.orders.order_sub_type IS 'Подтип заказа';


--
-- Name: COLUMN orders.order_plan; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.orders.order_plan IS 'План заказа';


--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: ordertypes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ordertypes (
    id integer NOT NULL,
    type character varying(128),
    user_id bigint
);


ALTER TABLE public.ordertypes OWNER TO postgres;

--
-- Name: TABLE ordertypes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.ordertypes IS 'типы заказов';


--
-- Name: ordertypes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ordertypes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ordertypes_id_seq OWNER TO postgres;

--
-- Name: ordertypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ordertypes_id_seq OWNED BY public.ordertypes.id;


--
-- Name: plans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.plans (
    id integer DEFAULT nextval(('public.plans_id_seq'::text)::regclass) NOT NULL,
    plan_name character varying(255) NOT NULL,
    is_per_hour boolean,
    parent_subtype_id integer,
    cost integer,
    description character varying(1024)
);
ALTER TABLE ONLY public.plans ALTER COLUMN id SET STATISTICS 0;


ALTER TABLE public.plans OWNER TO postgres;

--
-- Name: COLUMN plans.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.plans.id IS 'id плана';


--
-- Name: COLUMN plans.plan_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.plans.plan_name IS 'собственно название плана';


--
-- Name: COLUMN plans.is_per_hour; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.plans.is_per_hour IS 'столбец для определения: это тариф почасовой оплаты или нет';


--
-- Name: COLUMN plans.cost; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.plans.cost IS 'Собственно, ценник';


--
-- Name: COLUMN plans.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.plans.description IS 'Какое-то описание плана';


--
-- Name: plans_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.plans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.plans_id_seq OWNER TO postgres;

--
-- Name: sidebarmenuitems; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sidebarmenuitems (
    id integer NOT NULL,
    elementid character varying,
    action character varying(255),
    text character varying(1024),
    note character varying(1024),
    "user" integer,
    icon character varying(128)
);


ALTER TABLE public.sidebarmenuitems OWNER TO postgres;

--
-- Name: TABLE sidebarmenuitems; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sidebarmenuitems IS 'элементы меню сайдбара';


--
-- Name: COLUMN sidebarmenuitems.elementid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sidebarmenuitems.elementid IS 'ну типа кодовое имя элемента';


--
-- Name: COLUMN sidebarmenuitems.action; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sidebarmenuitems.action IS 'ТИПА ЭКШН';


--
-- Name: COLUMN sidebarmenuitems.text; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sidebarmenuitems.text IS 'СОБСТВЕННО ИМЕНОВАНИЕ ЭЛЕМЕНТА';


--
-- Name: COLUMN sidebarmenuitems.note; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sidebarmenuitems.note IS 'ОПИСАНИЕ ЭЛЕМЕНТА';


--
-- Name: COLUMN sidebarmenuitems."user"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sidebarmenuitems."user" IS 'userid';


--
-- Name: COLUMN sidebarmenuitems.icon; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sidebarmenuitems.icon IS 'css style name for icon';


--
-- Name: sidebarmenuitems_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sidebarmenuitems_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sidebarmenuitems_id_seq OWNER TO postgres;

--
-- Name: sidebarmenuitems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sidebarmenuitems_id_seq OWNED BY public.sidebarmenuitems.id;


--
-- Name: subtype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subtype (
    id integer DEFAULT nextval(('public.subtype_id_seq'::text)::regclass) NOT NULL,
    parent_type_id integer,
    subtype_name character varying(255)
);


ALTER TABLE public.subtype OWNER TO postgres;

--
-- Name: COLUMN subtype.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.subtype.id IS 'id субтипа (тип - это фото или видео, а субтип это: фотосессия, свадьба';


--
-- Name: COLUMN subtype.subtype_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.subtype.subtype_name IS 'имя субтипа';


--
-- Name: subtype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subtype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.subtype_id_seq OWNER TO postgres;

--
-- Name: t1; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t1 (
    id bigint NOT NULL,
    "J" json
);


ALTER TABLE public.t1 OWNER TO postgres;

--
-- Name: test; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.test (
    id bigint NOT NULL,
    name character varying(255)
);


ALTER TABLE public.test OWNER TO postgres;

--
-- Name: test_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.test_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.test_id_seq OWNER TO postgres;

--
-- Name: test_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.test_id_seq OWNED BY public.test.id;


--
-- Name: testseq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.testseq
    START WITH 17
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.testseq OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(512),
    login character varying(128) NOT NULL,
    pwd character varying(6) NOT NULL,
    email character varying(512),
    datecreated timestamp(0) without time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view AS
 SELECT ordertypes.type AS ordertypescount,
    count(ordertypes.type) AS test
   FROM (public.ordertypes
     LEFT JOIN public.orders ON ((ordertypes.id = orders.order_type)))
  WHERE (orders.user_id = 2)
  GROUP BY ordertypes.type;


ALTER TABLE public.view OWNER TO postgres;

--
-- Name: whereclientfrom; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.whereclientfrom (
    id bigint NOT NULL,
    source character varying(512) NOT NULL,
    userid bigint
);
ALTER TABLE ONLY public.whereclientfrom ALTER COLUMN id SET STATISTICS 0;


ALTER TABLE public.whereclientfrom OWNER TO postgres;

--
-- Name: COLUMN whereclientfrom.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.whereclientfrom.id IS 'id';


--
-- Name: COLUMN whereclientfrom.source; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.whereclientfrom.source IS 'источник клиента';


--
-- Name: COLUMN whereclientfrom.userid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.whereclientfrom.userid IS 'user id';


--
-- Name: whereclientfrom_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.whereclientfrom_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.whereclientfrom_id_seq OWNER TO postgres;

--
-- Name: whereclientfrom_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.whereclientfrom_id_seq OWNED BY public.whereclientfrom.id;


--
-- Name: clients id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients ALTER COLUMN id SET DEFAULT nextval('public.clients_id_seq'::regclass);


--
-- Name: order_status id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_status ALTER COLUMN id SET DEFAULT nextval('public.order_status_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: ordertypes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordertypes ALTER COLUMN id SET DEFAULT nextval('public.ordertypes_id_seq'::regclass);


--
-- Name: sidebarmenuitems id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sidebarmenuitems ALTER COLUMN id SET DEFAULT nextval('public.sidebarmenuitems_id_seq'::regclass);


--
-- Name: test id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test ALTER COLUMN id SET DEFAULT nextval('public.test_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: whereclientfrom id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.whereclientfrom ALTER COLUMN id SET DEFAULT nextval('public.whereclientfrom_id_seq'::regclass);


--
-- Data for Name: Test; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Test" VALUES (1, 'Anton');
INSERT INTO public."Test" VALUES (2, 'Olga');
INSERT INTO public."Test" VALUES (NULL, '11111');
INSERT INTO public."Test" VALUES (NULL, 'Юляшка');
INSERT INTO public."Test" VALUES (NULL, 'Юляшенька Панферова');
INSERT INTO public."Test" VALUES (NULL, 'Юляшенька Панферова в черненьких чулочках');
INSERT INTO public."Test" VALUES (NULL, 'Anton');
INSERT INTO public."Test" VALUES (NULL, 'Настенька');
INSERT INTO public."Test" VALUES (11, 'Vasya');
INSERT INTO public."Test" VALUES (11, 'Vasya');
INSERT INTO public."Test" VALUES (NULL, 'Юляшенька Панферова в черненьких чулочках');


--
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.clients VALUES (1, 'Наталия Какая-то', '', '', '2017-03-18 00:00:00', '1981-06-22 00:00:00', NULL, 2, NULL, 1);
INSERT INTO public.clients VALUES (2, 'Антоха', '1', '1', '2017-03-14 00:00:00', '2017-03-14 00:00:00', NULL, 2, NULL, 1);
INSERT INTO public.clients VALUES (6, 'Наталья', '1', '1', '2018-07-03 00:00:00', NULL, NULL, 2, NULL, 1);
INSERT INTO public.clients VALUES (11, 'Артем Шумилов', '', 'ashumilov@it-claim.ru', '2018-09-06 00:00:00', NULL, NULL, 2, NULL, 4);


--
-- Data for Name: options; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.options VALUES (6, 'Съемка в студии до 3 часов', 3);
INSERT INTO public.options VALUES (7, 'Доставка готового заказа', 3);
INSERT INTO public.options VALUES (3, '121 фотографий в глубокой ретуши', 2);
INSERT INTO public.options VALUES (9, 'Почасовая оплата', 5);
INSERT INTO public.options VALUES (26, 'Почасовая оплата', 6);
INSERT INTO public.options VALUES (27, 'Пиписька', 7);
INSERT INTO public.options VALUES (28, 'Почасовая оплата', 8);
INSERT INTO public.options VALUES (1, 'Какая-то опция. Надо узнавать', 9);


--
-- Data for Name: order_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.order_status VALUES (2, 'Назначена дата съемки', 2);
INSERT INTO public.order_status VALUES (1, 'Предварительный интерес', 2);
INSERT INTO public.order_status VALUES (3, 'Материал отдан заказчику', 2);
INSERT INTO public.order_status VALUES (7, 'Договориться не получилось. Заказчик отказался', 2);


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.orders VALUES (1, 1, 'Фотосессия Иры и Пети', 'Фотосессия Иры и Пети в Коломенском', 13, 10000, '2018-07-04 00:00:00', '2017-03-18 00:00:00', 3, 2, NULL, NULL);
INSERT INTO public.orders VALUES (48, 6, 'Свадьба Дмитрия и Натальи', 'Свадьба в студии Кросс. 2 часа', 13, 10000, '2018-07-02 00:00:00', '2017-03-18 00:00:00', 3, 2, 6, 8);
INSERT INTO public.orders VALUES (63, 11, 'Несостоявшаяся фотосессия для Артема', 'Несостоявшаяся фотосессия для Артема разработчика Каптчи', 13, 35000, '2018-09-06 00:00:00', NULL, 7, 2, 7, 9);


--
-- Data for Name: ordertypes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ordertypes VALUES (1, 'Фотосессия Love Story', 2);
INSERT INTO public.ordertypes VALUES (13, 'Фотосъемка', 2);
INSERT INTO public.ordertypes VALUES (14, 'Видеосъемка', 2);


--
-- Data for Name: plans; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.plans VALUES (3, 'Gold', false, 3, 25000, NULL);
INSERT INTO public.plans VALUES (2, 'Эконом', false, 2, 20000, 'Какое-то описание');
INSERT INTO public.plans VALUES (5, 'Почасовая оплата', true, 2, 5000, NULL);
INSERT INTO public.plans VALUES (6, 'Почасовая оплата', true, 3, 20000, 'Какое-то описание');
INSERT INTO public.plans VALUES (7, '1234567', false, 2, 20000, 'Какое-то описание');
INSERT INTO public.plans VALUES (8, 'Почасовая оплата', true, 6, 20000, 'Какое-то описание');
INSERT INTO public.plans VALUES (9, 'Оптимальный', false, 7, 35000, 'Какое-то описание');


--
-- Data for Name: sidebarmenuitems; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sidebarmenuitems VALUES (2, '1', 'orders', '5', 'ЗАКАЗЫ', 2, 'orders');
INSERT INTO public.sidebarmenuitems VALUES (4, '4', 'statuses', '1', 'СТАТУСЫ ЗАКАЗОВ', 2, 'statuses');
INSERT INTO public.sidebarmenuitems VALUES (1, '2', 'clients', '6', 'КЛИЕНТЫ', 2, 'clients');
INSERT INTO public.sidebarmenuitems VALUES (3, '3', 'orderstype', '7', 'ТИПЫ ЗАКАЗОВ', 2, 'types');


--
-- Data for Name: subtype; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.subtype VALUES (3, 14, 'Рекламный ролик');
INSERT INTO public.subtype VALUES (2, 13, 'Фотосессия Love Story');
INSERT INTO public.subtype VALUES (6, 13, 'Свадьба');
INSERT INTO public.subtype VALUES (7, 13, 'Фотосессия для сайтов знакомств');


--
-- Data for Name: t1; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: test; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.test VALUES (1, NULL);
INSERT INTO public.test VALUES (2, NULL);
INSERT INTO public.test VALUES (3, NULL);
INSERT INTO public.test VALUES (4, 'alexey');
INSERT INTO public.test VALUES (5, 'alexey');
INSERT INTO public.test VALUES (6, 'alexey');
INSERT INTO public.test VALUES (7, 'alexey');
INSERT INTO public.test VALUES (8, 'alexey');
INSERT INTO public.test VALUES (9, 'alexey');
INSERT INTO public.test VALUES (10, 'Vvvv');
INSERT INTO public.test VALUES (11, 'Vvvv');
INSERT INTO public.test VALUES (12, 'Vvvv');
INSERT INTO public.test VALUES (13, 'Vvvv');
INSERT INTO public.test VALUES (14, 'Vvvv');
INSERT INTO public.test VALUES (15, 'Antoshka');
INSERT INTO public.test VALUES (0, 'johndoe');


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES (1, 'Admin', 'admin', 'admin', NULL, NULL);
INSERT INTO public.users VALUES (2, '1', '1', '1', NULL, NULL);
INSERT INTO public.users VALUES (11, NULL, '2', '2', '2', '2018-07-26 16:48:43');


--
-- Data for Name: whereclientfrom; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.whereclientfrom VALUES (1, 'Неизвестно', 2);
INSERT INTO public.whereclientfrom VALUES (2, 'Instagram', 2);
INSERT INTO public.whereclientfrom VALUES (3, 'Сарафанное радио', 2);
INSERT INTO public.whereclientfrom VALUES (4, 'VK', 2);
INSERT INTO public.whereclientfrom VALUES (5, 'Сайт. SEO', 2);
INSERT INTO public.whereclientfrom VALUES (6, 'Сайт. Директ', 2);


--
-- Name: clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clients_id_seq', 11, true);


--
-- Name: options_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.options_id_seq', 29, true);


--
-- Name: order_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_status_id_seq', 7, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 63, true);


--
-- Name: ordertypes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ordertypes_id_seq', 16, true);


--
-- Name: plans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plans_id_seq', 9, true);


--
-- Name: sidebarmenuitems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sidebarmenuitems_id_seq', 4, true);


--
-- Name: subtype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subtype_id_seq', 7, true);


--
-- Name: test_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.test_id_seq', 16, true);


--
-- Name: testseq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.testseq', 17, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 11, true);


--
-- Name: whereclientfrom_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.whereclientfrom_id_seq', 6, true);


--
-- Name: clients clients_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_id_pk PRIMARY KEY (id);


--
-- Name: options options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.options
    ADD CONSTRAINT options_pkey PRIMARY KEY (id);


--
-- Name: order_status order_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_status
    ADD CONSTRAINT order_status_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: ordertypes ordertypes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordertypes
    ADD CONSTRAINT ordertypes_pkey PRIMARY KEY (id);


--
-- Name: plans plans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plans
    ADD CONSTRAINT plans_pkey PRIMARY KEY (id);


--
-- Name: sidebarmenuitems sidebarmenuitems_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sidebarmenuitems
    ADD CONSTRAINT sidebarmenuitems_pkey PRIMARY KEY (id);


--
-- Name: subtype subtype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subtype
    ADD CONSTRAINT subtype_pkey PRIMARY KEY (id);


--
-- Name: t1 t1_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t1
    ADD CONSTRAINT t1_pkey PRIMARY KEY (id);


--
-- Name: test test_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test
    ADD CONSTRAINT test_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: whereclientfrom whereclientfrom_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.whereclientfrom
    ADD CONSTRAINT whereclientfrom_pkey PRIMARY KEY (id);


--
-- Name: clients_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX clients_id_uindex ON public.clients USING btree (id);


--
-- Name: order_status_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX order_status_id_uindex ON public.order_status USING btree (id);


--
-- Name: orders_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX orders_id_uindex ON public.orders USING btree (id);


--
-- Name: ordertypes_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ordertypes_id_uindex ON public.ordertypes USING btree (id);


--
-- Name: sidebarmenuitems_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX sidebarmenuitems_id_uindex ON public.sidebarmenuitems USING btree (id);


--
-- Name: users_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX users_id_uindex ON public.users USING btree (id);


--
-- Name: users update_user_date_oncreate; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_user_date_oncreate BEFORE INSERT ON public.users FOR EACH ROW EXECUTE PROCEDURE public.update_user_created_date();


--
-- Name: clients clients_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_fk FOREIGN KEY (whereclientfrom) REFERENCES public.whereclientfrom(id) ON UPDATE SET NULL ON DELETE SET NULL;


--
-- Name: options options_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.options
    ADD CONSTRAINT options_fk FOREIGN KEY (plan_id) REFERENCES public.plans(id);


--
-- Name: orders orders_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_fk FOREIGN KEY (order_sub_type) REFERENCES public.subtype(id);


--
-- Name: orders orders_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_fk1 FOREIGN KEY (order_plan) REFERENCES public.plans(id);


--
-- Name: orders orders_ordertypes_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_ordertypes_id_fk FOREIGN KEY (order_type) REFERENCES public.ordertypes(id) ON UPDATE CASCADE;


--
-- Name: orders ordersclientfk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT ordersclientfk FOREIGN KEY (client) REFERENCES public.clients(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: orders orderstatusfk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orderstatusfk FOREIGN KEY (order_status) REFERENCES public.order_status(id) ON UPDATE CASCADE;


--
-- Name: plans plans_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plans
    ADD CONSTRAINT plans_fk FOREIGN KEY (parent_subtype_id) REFERENCES public.subtype(id);


--
-- Name: subtype subtype_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subtype
    ADD CONSTRAINT subtype_fk FOREIGN KEY (parent_type_id) REFERENCES public.ordertypes(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

