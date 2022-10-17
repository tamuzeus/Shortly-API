--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5 (Ubuntu 14.5-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.5 (Ubuntu 14.5-0ubuntu0.22.04.1)

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
-- Name: links; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.links (
    id integer NOT NULL,
    url text NOT NULL,
    "shortUrl" text,
    "userId" integer NOT NULL,
    "visitCount" integer DEFAULT 0,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: links_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.links_id_seq OWNED BY public.links.id;


--
-- Name: passwords; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.passwords (
    id integer NOT NULL,
    password text NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: passwords_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.passwords_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: passwords_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.passwords_id_seq OWNED BY public.passwords.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sessions (
    id integer NOT NULL,
    "userId" integer NOT NULL,
    hash text NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sessions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sessions_id_seq OWNED BY public.sessions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    "passwordId" integer,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: links id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.links ALTER COLUMN id SET DEFAULT nextval('public.links_id_seq'::regclass);


--
-- Name: passwords id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.passwords ALTER COLUMN id SET DEFAULT nextval('public.passwords_id_seq'::regclass);


--
-- Name: sessions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions ALTER COLUMN id SET DEFAULT nextval('public.sessions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: links; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.links VALUES (4, 'https://www.twitter.com/', 'wuABfJiiSM', 3, 2, '2022-10-16 16:08:55.543997');
INSERT INTO public.links VALUES (5, 'https://www.driven.com/', 'vDy-8WowXH', 3, 1, '2022-10-16 16:12:53.892883');
INSERT INTO public.links VALUES (6, 'https://www.driven.com.br/', 'QgodJbAy9k', 1, 3, '2022-10-17 14:46:18.107373');
INSERT INTO public.links VALUES (7, 'https://www.digimon.com.br/', 'phplilYD4C', 5, 2, '2022-10-17 14:47:55.250673');
INSERT INTO public.links VALUES (8, 'https://github.com', 'ma8NS3i4KV', 5, 2, '2022-10-17 14:49:05.288776');


--
-- Data for Name: passwords; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.passwords VALUES (1, '$2b$10$VqHP6Jn4iQwQT.zyZ7PQ8O6GcyQBh4pI/8mXuytRQBiMw11vH10ni', '2022-10-16 09:42:18.297101');
INSERT INTO public.passwords VALUES (2, '$2b$10$zdtKoWMYjREorvC08AqKDeHwqCSf3vr/6GtHsIDX2QIqZQwvLMtM2', '2022-10-16 11:43:01.481854');
INSERT INTO public.passwords VALUES (3, '$2b$10$3TbP5ek/E0O0bnvUILUqjuNN9vFm9YBLf7m4ZRRQfbVZB94icWfM6', '2022-10-16 11:57:17.176754');
INSERT INTO public.passwords VALUES (4, '$2b$10$8A2cCk1rpVCvUc6NcvAuD.vOvUnlP9u0DvU7SraUnOYGVcU83UWBW', '2022-10-16 16:08:38.911583');
INSERT INTO public.passwords VALUES (5, '$2b$10$x8Gew/2I8Ds9.kcWPMU0r.uql02GvgzJFhL/bH1H0BP.Zuc6ypRFe', '2022-10-17 14:47:36.323176');


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.sessions VALUES (1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6MSwiaWF0IjoxNjY1OTMxMTYwfQ.U20MfFVJFTR_K8bcMkmcX6f6HLSanqLDwKFNFD2xp-A', '2022-10-16 11:39:20.392335');
INSERT INTO public.sessions VALUES (2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6MiwiaWF0IjoxNjY1OTMxMzk4fQ.phV7U2VZMQkk9Cri3ramMwL4h3TdCuPtC01bp7BmMJo', '2022-10-16 11:43:18.703971');
INSERT INTO public.sessions VALUES (3, 3, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6MywiaWF0IjoxNjY1OTMyMjQyfQ.Ckr3yOc_IX2VSfmZ5XH5c7SpFhOeNKjNG7ZXjdOJ_gs', '2022-10-16 11:57:22.644435');
INSERT INTO public.sessions VALUES (4, 3, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6MywiaWF0IjoxNjY1OTMzNDMzfQ.DTTWmaJA097rWzJv2H3fjOH1LbzBmoG6U3j0RyTOjQE', '2022-10-16 12:17:13.174017');
INSERT INTO public.sessions VALUES (5, 4, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6NCwiaWF0IjoxNjY1OTQ3MzI1fQ.rvel5LsZE81ycPtmoO2B79VVQ-MNhMDUvUsiKyKtPSc', '2022-10-16 16:08:45.357435');
INSERT INTO public.sessions VALUES (6, 5, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbiI6NSwiaWF0IjoxNjY2MDI4ODYwfQ.dpTatC9-UO0mc97hICHJD__I8fd3LeJakmu1VJcIztw', '2022-10-17 14:47:40.499189');


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.users VALUES (1, 'Igor', 'ok@sad.com', 1, '2022-10-16 09:42:18.298437');
INSERT INTO public.users VALUES (2, 'Peter Parker', 'new@sad.com', 2, '2022-10-16 11:43:01.491678');
INSERT INTO public.users VALUES (3, 'Teste', 'newz@sad.com', 3, '2022-10-16 11:57:17.187233');
INSERT INTO public.users VALUES (4, 'Jose', 'newzc@sad.com', 4, '2022-10-16 16:08:38.912681');
INSERT INTO public.users VALUES (5, 'NovoNAme', 'newzcz@sad.com', 5, '2022-10-17 14:47:36.333692');


--
-- Name: links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.links_id_seq', 8, true);


--
-- Name: passwords_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.passwords_id_seq', 5, true);


--
-- Name: sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.sessions_id_seq', 6, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 5, true);


--
-- Name: links links_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.links
    ADD CONSTRAINT links_pkey PRIMARY KEY (id);


--
-- Name: passwords passwords_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.passwords
    ADD CONSTRAINT passwords_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: links links_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.links
    ADD CONSTRAINT "links_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id);


--
-- Name: sessions sessions_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT "sessions_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id);


--
-- Name: users users_passwordId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "users_passwordId_fkey" FOREIGN KEY ("passwordId") REFERENCES public.passwords(id);


--
-- PostgreSQL database dump complete
--

