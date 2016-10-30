--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.0
-- Dumped by pg_dump version 9.6.1

-- Started on 2016-10-30 14:46:14 PDT

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE IF EXISTS cppc;
--
-- TOC entry 2156 (class 1262 OID 16384)
-- Name: cppc; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE cppc WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE cppc OWNER TO postgres;

\connect cppc

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12393)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2157 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 188 (class 1259 OID 16434)
-- Name: interaction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE interaction (
    id integer NOT NULL,
    user1 integer,
    user2 integer,
    "timestamp" timestamp with time zone,
    seen boolean,
    seenat timestamp with time zone,
    accepted boolean
);


ALTER TABLE interaction OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 16410)
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE reviews (
    id integer NOT NULL,
    reviewer_userid integer,
    reviewee_userid integer,
    stars integer,
    content text
);


ALTER TABLE reviews OWNER TO postgres;

--
-- TOC entry 186 (class 1259 OID 16400)
-- Name: schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE schedule (
    id integer NOT NULL,
    dayofweek integer,
    arrive time without time zone,
    depart time without time zone,
    userid integer
);


ALTER TABLE schedule OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 16389)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE users (
    id integer NOT NULL,
    cppuser character varying(16),
    fullname character varying(32),
    altemail character varying(100),
    addressline1 character varying(100),
    addressline2 character varying(100),
    city character varying(32),
    zip integer,
    "timestamp" timestamp with time zone,
    salt character varying(32),
    passhash character varying(32),
    verified boolean,
    profilecomplete boolean,
    picture bytea,
    maxdist integer,
    drivingpref integer
);


ALTER TABLE users OWNER TO postgres;

--
-- TOC entry 2151 (class 0 OID 16434)
-- Dependencies: 188
-- Data for Name: interaction; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY interaction (id, user1, user2, "timestamp", seen, seenat, accepted) FROM stdin;
\.


--
-- TOC entry 2150 (class 0 OID 16410)
-- Dependencies: 187
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY reviews (id, reviewer_userid, reviewee_userid, stars, content) FROM stdin;
\.


--
-- TOC entry 2149 (class 0 OID 16400)
-- Dependencies: 186
-- Data for Name: schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY schedule (id, dayofweek, arrive, depart, userid) FROM stdin;
\.


--
-- TOC entry 2148 (class 0 OID 16389)
-- Dependencies: 185
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users (id, cppuser, fullname, altemail, addressline1, addressline2, city, zip, "timestamp", salt, passhash, verified, profilecomplete, picture, maxdist, drivingpref) FROM stdin;
\.


--
-- TOC entry 2018 (class 2606 OID 16396)
-- Name: users id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT id_pk PRIMARY KEY (id);


--
-- TOC entry 2025 (class 2606 OID 16438)
-- Name: interaction interactionid_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY interaction
    ADD CONSTRAINT interactionid_pk PRIMARY KEY (id);


--
-- TOC entry 2023 (class 2606 OID 16417)
-- Name: reviews reviewid_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reviews
    ADD CONSTRAINT reviewid_pk PRIMARY KEY (id);


--
-- TOC entry 2021 (class 2606 OID 16404)
-- Name: schedule schedid_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY schedule
    ADD CONSTRAINT schedid_pk PRIMARY KEY (id);


--
-- TOC entry 2019 (class 1259 OID 16433)
-- Name: fki_sched_userid_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_sched_userid_fk ON schedule USING btree (userid);


--
-- TOC entry 2029 (class 2606 OID 16439)
-- Name: interaction interaction_user1_userid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY interaction
    ADD CONSTRAINT interaction_user1_userid_fk FOREIGN KEY (user1) REFERENCES users(id);


--
-- TOC entry 2030 (class 2606 OID 16444)
-- Name: interaction interaction_user2_userid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY interaction
    ADD CONSTRAINT interaction_user2_userid_fk FOREIGN KEY (user2) REFERENCES users(id);


--
-- TOC entry 2028 (class 2606 OID 16423)
-- Name: reviews reviews_reviewee_userid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reviews
    ADD CONSTRAINT reviews_reviewee_userid_fk FOREIGN KEY (reviewee_userid) REFERENCES users(id);


--
-- TOC entry 2027 (class 2606 OID 16418)
-- Name: reviews reviews_reviewer_userid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reviews
    ADD CONSTRAINT reviews_reviewer_userid_fk FOREIGN KEY (reviewer_userid) REFERENCES users(id);


--
-- TOC entry 2026 (class 2606 OID 16428)
-- Name: schedule sched_userid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY schedule
    ADD CONSTRAINT sched_userid_fk FOREIGN KEY (userid) REFERENCES users(id);


-- Completed on 2016-10-30 14:46:14 PDT

--
-- PostgreSQL database dump complete
--
