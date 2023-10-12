--
-- PostgreSQL database dump
--

-- Dumped from database version 14.3
-- Dumped by pg_dump version 14.6 (Debian 14.6-1.pgdg110+1)

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

--
-- Name: courtlistener; Type: DATABASE; Schema: -; Owner: django
--

CREATE DATABASE courtlistener WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.UTF-8';


ALTER DATABASE courtlistener OWNER TO django;

\connect courtlistener

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
-- Name: audio_audio; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.audio_audio (
    id integer NOT NULL,
    source character varying(10) NOT NULL,
    case_name_short text NOT NULL,
    case_name text NOT NULL,
    case_name_full text NOT NULL,
    judges text,
    date_created timestamp with time zone NOT NULL,
    date_modified timestamp with time zone NOT NULL,
    sha1 character varying(40) NOT NULL,
    download_url character varying(500),
    local_path_mp3 character varying(100) NOT NULL,
    local_path_original_file character varying(100) NOT NULL,
    duration smallint,
    processing_complete boolean NOT NULL,
    date_blocked date,
    blocked boolean NOT NULL,
    docket_id integer,
    stt_google_response text NOT NULL,
    stt_status smallint NOT NULL,
    filepath_ia character varying(1000) NOT NULL,
    ia_upload_failure_count smallint
);


ALTER TABLE public.audio_audio OWNER TO django;

--
-- Name: audio_audio_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.audio_audio_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.audio_audio_id_seq OWNER TO django;

--
-- Name: audio_audio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.audio_audio_id_seq OWNED BY public.audio_audio.id;


--
-- Name: audio_audio_panel; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.audio_audio_panel (
    id integer NOT NULL,
    audio_id integer NOT NULL,
    person_id integer NOT NULL
);


ALTER TABLE public.audio_audio_panel OWNER TO django;

--
-- Name: audio_audio_panel_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.audio_audio_panel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.audio_audio_panel_id_seq OWNER TO django;

--
-- Name: audio_audio_panel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.audio_audio_panel_id_seq OWNED BY public.audio_audio_panel.id;


--
-- Name: people_db_abarating; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.people_db_abarating (
    id integer NOT NULL,
    date_created timestamp with time zone NOT NULL,
    date_modified timestamp with time zone NOT NULL,
    rating character varying(5) NOT NULL,
    person_id integer,
    year_rated smallint,
    CONSTRAINT people_db_abarating_year_rated_check CHECK ((year_rated >= 0))
);


ALTER TABLE public.people_db_abarating OWNER TO django;

--
-- Name: people_db_abarating_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.people_db_abarating_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.people_db_abarating_id_seq OWNER TO django;

--
-- Name: people_db_abarating_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.people_db_abarating_id_seq OWNED BY public.people_db_abarating.id;


--
-- Name: people_db_attorney; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.people_db_attorney (
    id integer NOT NULL,
    date_created timestamp with time zone NOT NULL,
    date_modified timestamp with time zone NOT NULL,
    name text NOT NULL,
    contact_raw text NOT NULL,
    phone character varying(20) NOT NULL,
    fax character varying(20) NOT NULL,
    email character varying(254) NOT NULL
);


ALTER TABLE public.people_db_attorney OWNER TO django;

--
-- Name: people_db_attorney_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.people_db_attorney_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.people_db_attorney_id_seq OWNER TO django;

--
-- Name: people_db_attorney_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.people_db_attorney_id_seq OWNED BY public.people_db_attorney.id;


--
-- Name: people_db_attorneyorganization; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.people_db_attorneyorganization (
    id integer NOT NULL,
    date_created timestamp with time zone NOT NULL,
    date_modified timestamp with time zone NOT NULL,
    lookup_key text NOT NULL,
    name text NOT NULL,
    address1 text NOT NULL,
    address2 text NOT NULL,
    city text NOT NULL,
    state character varying(2) NOT NULL,
    zip_code character varying(10) NOT NULL
);


ALTER TABLE public.people_db_attorneyorganization OWNER TO django;

--
-- Name: people_db_attorneyorganization_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.people_db_attorneyorganization_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.people_db_attorneyorganization_id_seq OWNER TO django;

--
-- Name: people_db_attorneyorganization_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.people_db_attorneyorganization_id_seq OWNED BY public.people_db_attorneyorganization.id;


--
-- Name: people_db_attorneyorganizationassociation; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.people_db_attorneyorganizationassociation (
    id integer NOT NULL,
    attorney_id integer NOT NULL,
    attorney_organization_id integer NOT NULL,
    docket_id integer NOT NULL
);


ALTER TABLE public.people_db_attorneyorganizationassociation OWNER TO django;

--
-- Name: people_db_attorneyorganizationassociation_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.people_db_attorneyorganizationassociation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.people_db_attorneyorganizationassociation_id_seq OWNER TO django;

--
-- Name: people_db_attorneyorganizationassociation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.people_db_attorneyorganizationassociation_id_seq OWNED BY public.people_db_attorneyorganizationassociation.id;


--
-- Name: people_db_criminalcomplaint; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.people_db_criminalcomplaint (
    id integer NOT NULL,
    name text NOT NULL,
    disposition text NOT NULL,
    party_type_id integer NOT NULL
);


ALTER TABLE public.people_db_criminalcomplaint OWNER TO django;

--
-- Name: people_db_criminalcomplaint_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.people_db_criminalcomplaint_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.people_db_criminalcomplaint_id_seq OWNER TO django;

--
-- Name: people_db_criminalcomplaint_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.people_db_criminalcomplaint_id_seq OWNED BY public.people_db_criminalcomplaint.id;


--
-- Name: people_db_criminalcount; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.people_db_criminalcount (
    id integer NOT NULL,
    name text NOT NULL,
    disposition text NOT NULL,
    status smallint NOT NULL,
    party_type_id integer NOT NULL
);


ALTER TABLE public.people_db_criminalcount OWNER TO django;

--
-- Name: people_db_criminalcount_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.people_db_criminalcount_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.people_db_criminalcount_id_seq OWNER TO django;

--
-- Name: people_db_criminalcount_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.people_db_criminalcount_id_seq OWNED BY public.people_db_criminalcount.id;


--
-- Name: people_db_education; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.people_db_education (
    id integer NOT NULL,
    date_created timestamp with time zone NOT NULL,
    date_modified timestamp with time zone NOT NULL,
    degree_detail character varying(100) NOT NULL,
    degree_year smallint,
    person_id integer,
    school_id integer NOT NULL,
    degree_level character varying(4) NOT NULL,
    CONSTRAINT people_db_education_degree_year_check CHECK ((degree_year >= 0))
);


ALTER TABLE public.people_db_education OWNER TO django;

--
-- Name: people_db_education_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.people_db_education_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.people_db_education_id_seq OWNER TO django;

--
-- Name: people_db_education_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.people_db_education_id_seq OWNED BY public.people_db_education.id;


--
-- Name: people_db_party; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.people_db_party (
    id integer NOT NULL,
    date_created timestamp with time zone NOT NULL,
    date_modified timestamp with time zone NOT NULL,
    name text NOT NULL,
    extra_info text NOT NULL
);


ALTER TABLE public.people_db_party OWNER TO django;

--
-- Name: people_db_party_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.people_db_party_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.people_db_party_id_seq OWNER TO django;

--
-- Name: people_db_party_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.people_db_party_id_seq OWNED BY public.people_db_party.id;


--
-- Name: people_db_partytype; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.people_db_partytype (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    docket_id integer NOT NULL,
    party_id integer NOT NULL,
    date_terminated date,
    extra_info text NOT NULL,
    highest_offense_level_opening text NOT NULL,
    highest_offense_level_terminated text NOT NULL
);


ALTER TABLE public.people_db_partytype OWNER TO django;

--
-- Name: people_db_partytype_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.people_db_partytype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.people_db_partytype_id_seq OWNER TO django;

--
-- Name: people_db_partytype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.people_db_partytype_id_seq OWNED BY public.people_db_partytype.id;


--
-- Name: people_db_person; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.people_db_person (
    id integer NOT NULL,
    date_created timestamp with time zone NOT NULL,
    date_modified timestamp with time zone NOT NULL,
    fjc_id integer,
    slug character varying(158) NOT NULL,
    name_first character varying(50) NOT NULL,
    name_middle character varying(50) NOT NULL,
    name_last character varying(50) NOT NULL,
    name_suffix character varying(5) NOT NULL,
    date_dob date,
    date_granularity_dob character varying(15) NOT NULL,
    date_dod date,
    date_granularity_dod character varying(15) NOT NULL,
    dob_city character varying(50) NOT NULL,
    dob_state character varying(2) NOT NULL,
    dod_city character varying(50) NOT NULL,
    dod_state character varying(2) NOT NULL,
    gender character varying(2) NOT NULL,
    is_alias_of_id integer,
    religion character varying(30) NOT NULL,
    has_photo boolean NOT NULL,
    ftm_total_received double precision,
    ftm_eid character varying(30),
    date_completed timestamp with time zone,
    dob_country character varying(50) NOT NULL,
    dod_country character varying(50) NOT NULL
);


ALTER TABLE public.people_db_person OWNER TO django;

--
-- Name: people_db_person_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.people_db_person_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.people_db_person_id_seq OWNER TO django;

--
-- Name: people_db_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.people_db_person_id_seq OWNED BY public.people_db_person.id;


--
-- Name: people_db_person_race; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.people_db_person_race (
    id integer NOT NULL,
    person_id integer NOT NULL,
    race_id integer NOT NULL
);


ALTER TABLE public.people_db_person_race OWNER TO django;

--
-- Name: people_db_person_race_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.people_db_person_race_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.people_db_person_race_id_seq OWNER TO django;

--
-- Name: people_db_person_race_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.people_db_person_race_id_seq OWNED BY public.people_db_person_race.id;


--
-- Name: people_db_politicalaffiliation; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.people_db_politicalaffiliation (
    id integer NOT NULL,
    date_created timestamp with time zone NOT NULL,
    date_modified timestamp with time zone NOT NULL,
    political_party character varying(5) NOT NULL,
    source character varying(5) NOT NULL,
    date_start date,
    date_granularity_start character varying(15) NOT NULL,
    date_end date,
    date_granularity_end character varying(15) NOT NULL,
    person_id integer
);


ALTER TABLE public.people_db_politicalaffiliation OWNER TO django;

--
-- Name: people_db_politicalaffiliation_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.people_db_politicalaffiliation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.people_db_politicalaffiliation_id_seq OWNER TO django;

--
-- Name: people_db_politicalaffiliation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.people_db_politicalaffiliation_id_seq OWNED BY public.people_db_politicalaffiliation.id;


--
-- Name: people_db_position; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.people_db_position (
    id integer NOT NULL,
    position_type character varying(20),
    job_title character varying(100) NOT NULL,
    organization_name character varying(120),
    date_created timestamp with time zone NOT NULL,
    date_modified timestamp with time zone NOT NULL,
    date_nominated date,
    date_elected date,
    date_recess_appointment date,
    date_referred_to_judicial_committee date,
    date_judicial_committee_action date,
    date_hearing date,
    date_confirmation date,
    date_start date,
    date_granularity_start character varying(15) NOT NULL,
    date_retirement date,
    date_termination date,
    date_granularity_termination character varying(15) NOT NULL,
    judicial_committee_action character varying(20) NOT NULL,
    nomination_process character varying(20) NOT NULL,
    voice_vote boolean,
    votes_yes integer,
    votes_no integer,
    how_selected character varying(20) NOT NULL,
    termination_reason character varying(25) NOT NULL,
    court_id character varying(15),
    person_id integer,
    school_id integer,
    appointer_id integer,
    predecessor_id integer,
    supervisor_id integer,
    vote_type character varying(2) NOT NULL,
    votes_no_percent double precision,
    votes_yes_percent double precision,
    location_city character varying(50) NOT NULL,
    location_state character varying(2) NOT NULL,
    has_inferred_values boolean NOT NULL,
    sector smallint,
    CONSTRAINT people_db_position_votes_no_check CHECK ((votes_no >= 0)),
    CONSTRAINT people_db_position_votes_yes_check CHECK ((votes_yes >= 0))
);


ALTER TABLE public.people_db_position OWNER TO django;

--
-- Name: people_db_position_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.people_db_position_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.people_db_position_id_seq OWNER TO django;

--
-- Name: people_db_position_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.people_db_position_id_seq OWNED BY public.people_db_position.id;


--
-- Name: people_db_race; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.people_db_race (
    id integer NOT NULL,
    race character varying(5) NOT NULL
);


ALTER TABLE public.people_db_race OWNER TO django;

--
-- Name: people_db_race_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.people_db_race_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.people_db_race_id_seq OWNER TO django;

--
-- Name: people_db_race_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.people_db_race_id_seq OWNED BY public.people_db_race.id;


--
-- Name: people_db_retentionevent; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.people_db_retentionevent (
    id integer NOT NULL,
    date_created timestamp with time zone NOT NULL,
    date_modified timestamp with time zone NOT NULL,
    retention_type character varying(10) NOT NULL,
    date_retention date NOT NULL,
    votes_yes integer,
    votes_no integer,
    unopposed boolean,
    won boolean,
    position_id integer,
    votes_no_percent double precision,
    votes_yes_percent double precision,
    CONSTRAINT people_db_retentionevent_votes_no_check CHECK ((votes_no >= 0)),
    CONSTRAINT people_db_retentionevent_votes_yes_check CHECK ((votes_yes >= 0))
);


ALTER TABLE public.people_db_retentionevent OWNER TO django;

--
-- Name: people_db_retentionevent_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.people_db_retentionevent_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.people_db_retentionevent_id_seq OWNER TO django;

--
-- Name: people_db_retentionevent_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.people_db_retentionevent_id_seq OWNED BY public.people_db_retentionevent.id;


--
-- Name: people_db_role; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.people_db_role (
    id integer NOT NULL,
    role smallint,
    date_action date,
    attorney_id integer NOT NULL,
    docket_id integer NOT NULL,
    party_id integer NOT NULL,
    role_raw text NOT NULL
);


ALTER TABLE public.people_db_role OWNER TO django;

--
-- Name: people_db_role_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.people_db_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.people_db_role_id_seq OWNER TO django;

--
-- Name: people_db_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.people_db_role_id_seq OWNED BY public.people_db_role.id;


--
-- Name: people_db_school; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.people_db_school (
    id integer NOT NULL,
    date_created timestamp with time zone NOT NULL,
    date_modified timestamp with time zone NOT NULL,
    name character varying(120) NOT NULL,
    ein integer,
    is_alias_of_id integer
);


ALTER TABLE public.people_db_school OWNER TO django;

--
-- Name: people_db_school_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.people_db_school_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.people_db_school_id_seq OWNER TO django;

--
-- Name: people_db_school_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.people_db_school_id_seq OWNED BY public.people_db_school.id;


--
-- Name: people_db_source; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.people_db_source (
    id integer NOT NULL,
    date_modified timestamp with time zone NOT NULL,
    url character varying(2000) NOT NULL,
    date_accessed date,
    notes text NOT NULL,
    person_id integer,
    date_created timestamp with time zone NOT NULL
);


ALTER TABLE public.people_db_source OWNER TO django;

--
-- Name: people_db_source_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.people_db_source_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.people_db_source_id_seq OWNER TO django;

--
-- Name: people_db_source_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.people_db_source_id_seq OWNED BY public.people_db_source.id;


--
-- Name: search_bankruptcyinformation; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.search_bankruptcyinformation (
    id integer NOT NULL,
    date_created timestamp with time zone NOT NULL,
    date_modified timestamp with time zone NOT NULL,
    date_converted timestamp with time zone,
    date_last_to_file_claims timestamp with time zone,
    date_last_to_file_govt timestamp with time zone,
    date_debtor_dismissed timestamp with time zone,
    chapter character varying(10) NOT NULL,
    trustee_str text NOT NULL,
    docket_id integer NOT NULL
);


ALTER TABLE public.search_bankruptcyinformation OWNER TO django;

--
-- Name: search_bankruptcyinformation_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.search_bankruptcyinformation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.search_bankruptcyinformation_id_seq OWNER TO django;

--
-- Name: search_bankruptcyinformation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.search_bankruptcyinformation_id_seq OWNED BY public.search_bankruptcyinformation.id;


--
-- Name: search_citation; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.search_citation (
    id integer NOT NULL,
    volume smallint NOT NULL,
    reporter text NOT NULL,
    page text NOT NULL,
    type smallint NOT NULL,
    cluster_id integer NOT NULL
);


ALTER TABLE public.search_citation OWNER TO django;

--
-- Name: search_citation_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.search_citation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.search_citation_id_seq OWNER TO django;

--
-- Name: search_citation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.search_citation_id_seq OWNED BY public.search_citation.id;


--
-- Name: search_claim; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.search_claim (
    id integer NOT NULL,
    date_created timestamp with time zone NOT NULL,
    date_modified timestamp with time zone NOT NULL,
    date_claim_modified timestamp with time zone,
    date_original_entered timestamp with time zone,
    date_original_filed timestamp with time zone,
    date_last_amendment_entered timestamp with time zone,
    date_last_amendment_filed timestamp with time zone,
    claim_number character varying(10) NOT NULL,
    creditor_details text NOT NULL,
    creditor_id character varying(50) NOT NULL,
    status character varying(1000) NOT NULL,
    entered_by character varying(1000) NOT NULL,
    filed_by character varying(1000) NOT NULL,
    amount_claimed character varying(100) NOT NULL,
    unsecured_claimed character varying(100) NOT NULL,
    secured_claimed character varying(100) NOT NULL,
    priority_claimed character varying(100) NOT NULL,
    description text NOT NULL,
    remarks text NOT NULL,
    docket_id integer NOT NULL
);


ALTER TABLE public.search_claim OWNER TO django;

--
-- Name: search_claim_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.search_claim_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.search_claim_id_seq OWNER TO django;

--
-- Name: search_claim_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.search_claim_id_seq OWNED BY public.search_claim.id;


--
-- Name: search_claim_tags; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.search_claim_tags (
    id integer NOT NULL,
    claim_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public.search_claim_tags OWNER TO django;

--
-- Name: search_claim_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.search_claim_tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.search_claim_tags_id_seq OWNER TO django;

--
-- Name: search_claim_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.search_claim_tags_id_seq OWNED BY public.search_claim_tags.id;


--
-- Name: search_claimhistory; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.search_claimhistory (
    id integer NOT NULL,
    date_created timestamp with time zone NOT NULL,
    date_modified timestamp with time zone NOT NULL,
    date_upload timestamp with time zone,
    document_number character varying(32) NOT NULL,
    attachment_number smallint,
    pacer_doc_id character varying(32) NOT NULL,
    is_available boolean,
    sha1 character varying(40) NOT NULL,
    page_count integer,
    file_size integer,
    filepath_local character varying(1000) NOT NULL,
    filepath_ia character varying(1000) NOT NULL,
    ia_upload_failure_count smallint,
    thumbnail character varying(100),
    thumbnail_status smallint NOT NULL,
    plain_text text NOT NULL,
    ocr_status smallint,
    is_free_on_pacer boolean,
    is_sealed boolean,
    date_filed date,
    claim_document_type integer NOT NULL,
    description text NOT NULL,
    claim_doc_id character varying(32) NOT NULL,
    pacer_dm_id integer,
    pacer_case_id character varying(100) NOT NULL,
    claim_id integer NOT NULL
);


ALTER TABLE public.search_claimhistory OWNER TO django;

--
-- Name: search_claimhistory_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.search_claimhistory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.search_claimhistory_id_seq OWNER TO django;

--
-- Name: search_claimhistory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.search_claimhistory_id_seq OWNED BY public.search_claimhistory.id;


--
-- Name: search_court; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.search_court (
    id character varying(15) NOT NULL,
    date_modified timestamp with time zone NOT NULL,
    in_use boolean NOT NULL,
    has_opinion_scraper boolean NOT NULL,
    has_oral_argument_scraper boolean NOT NULL,
    "position" double precision NOT NULL,
    citation_string character varying(100) NOT NULL,
    short_name character varying(100) NOT NULL,
    full_name character varying(200) NOT NULL,
    url character varying(500) NOT NULL,
    start_date date,
    end_date date,
    jurisdiction character varying(3) NOT NULL,
    notes text NOT NULL,
    pacer_court_id smallint,
    fjc_court_id character varying(3) NOT NULL,
    pacer_has_rss_feed boolean,
    date_last_pacer_contact timestamp with time zone,
    pacer_rss_entry_types text NOT NULL,
    CONSTRAINT search_court_pacer_court_id_check CHECK ((pacer_court_id >= 0))
);


ALTER TABLE public.search_court OWNER TO django;

--
-- Name: search_docket; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.search_docket (
    id integer NOT NULL,
    date_created timestamp with time zone NOT NULL,
    date_modified timestamp with time zone NOT NULL,
    date_argued date,
    date_reargued date,
    date_reargument_denied date,
    case_name_short text NOT NULL,
    case_name text NOT NULL,
    case_name_full text NOT NULL,
    slug character varying(75) NOT NULL,
    docket_number text,
    date_blocked date,
    blocked boolean NOT NULL,
    court_id character varying(15) NOT NULL,
    date_cert_denied date,
    date_cert_granted date,
    assigned_to_id integer,
    cause character varying(2000) NOT NULL,
    date_filed date,
    date_last_filing date,
    date_terminated date,
    filepath_ia character varying(1000) NOT NULL,
    filepath_local character varying(1000) NOT NULL,
    jurisdiction_type character varying(100) NOT NULL,
    jury_demand character varying(500) NOT NULL,
    nature_of_suit character varying(1000) NOT NULL,
    pacer_case_id character varying(100),
    referred_to_id integer,
    source smallint NOT NULL,
    assigned_to_str text NOT NULL,
    referred_to_str text NOT NULL,
    view_count integer NOT NULL,
    date_last_index timestamp with time zone,
    appeal_from_id character varying(15),
    appeal_from_str text NOT NULL,
    appellate_case_type_information text NOT NULL,
    appellate_fee_status text NOT NULL,
    panel_str text NOT NULL,
    originating_court_information_id integer,
    mdl_status character varying(100) NOT NULL,
    filepath_ia_json character varying(1000) NOT NULL,
    ia_date_first_change timestamp with time zone,
    ia_needs_upload boolean,
    ia_upload_failure_count smallint,
    docket_number_core character varying(20) NOT NULL,
    idb_data_id integer
);


ALTER TABLE public.search_docket OWNER TO django;

--
-- Name: search_docket_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.search_docket_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.search_docket_id_seq OWNER TO django;

--
-- Name: search_docket_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.search_docket_id_seq OWNED BY public.search_docket.id;


--
-- Name: search_docket_panel; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.search_docket_panel (
    id integer NOT NULL,
    docket_id integer NOT NULL,
    person_id integer NOT NULL
);


ALTER TABLE public.search_docket_panel OWNER TO django;

--
-- Name: search_docket_panel_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.search_docket_panel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.search_docket_panel_id_seq OWNER TO django;

--
-- Name: search_docket_panel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.search_docket_panel_id_seq OWNED BY public.search_docket_panel.id;


--
-- Name: search_docket_tags; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.search_docket_tags (
    id integer NOT NULL,
    docket_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public.search_docket_tags OWNER TO django;

--
-- Name: search_docket_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.search_docket_tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.search_docket_tags_id_seq OWNER TO django;

--
-- Name: search_docket_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.search_docket_tags_id_seq OWNED BY public.search_docket_tags.id;


--
-- Name: search_docketentry; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.search_docketentry (
    id integer NOT NULL,
    date_created timestamp with time zone NOT NULL,
    date_modified timestamp with time zone NOT NULL,
    date_filed date,
    entry_number bigint,
    description text NOT NULL,
    docket_id integer NOT NULL,
    pacer_sequence_number integer,
    recap_sequence_number character varying(50) NOT NULL
);


ALTER TABLE public.search_docketentry OWNER TO django;

--
-- Name: search_docketentry_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.search_docketentry_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.search_docketentry_id_seq OWNER TO django;

--
-- Name: search_docketentry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.search_docketentry_id_seq OWNED BY public.search_docketentry.id;


--
-- Name: search_docketentry_tags; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.search_docketentry_tags (
    id integer NOT NULL,
    docketentry_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public.search_docketentry_tags OWNER TO django;

--
-- Name: search_docketentry_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.search_docketentry_tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.search_docketentry_tags_id_seq OWNER TO django;

--
-- Name: search_docketentry_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.search_docketentry_tags_id_seq OWNED BY public.search_docketentry_tags.id;


--
-- Name: search_opinion; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.search_opinion (
    id integer NOT NULL,
    date_created timestamp with time zone NOT NULL,
    date_modified timestamp with time zone NOT NULL,
    type character varying(20) NOT NULL,
    sha1 character varying(40) NOT NULL,
    download_url character varying(500),
    local_path character varying(100) NOT NULL,
    plain_text text NOT NULL,
    html text NOT NULL,
    html_lawbox text NOT NULL,
    html_columbia text NOT NULL,
    html_with_citations text NOT NULL,
    extracted_by_ocr boolean NOT NULL,
    author_id integer,
    cluster_id integer NOT NULL,
    per_curiam boolean NOT NULL,
    page_count integer,
    author_str text NOT NULL,
    joined_by_str text NOT NULL,
    xml_harvard text NOT NULL,
    html_anon_2020 text NOT NULL
);


ALTER TABLE public.search_opinion OWNER TO django;

--
-- Name: search_opinion_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.search_opinion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.search_opinion_id_seq OWNER TO django;

--
-- Name: search_opinion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.search_opinion_id_seq OWNED BY public.search_opinion.id;


--
-- Name: search_opinion_joined_by; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.search_opinion_joined_by (
    id integer NOT NULL,
    opinion_id integer NOT NULL,
    person_id integer NOT NULL
);


ALTER TABLE public.search_opinion_joined_by OWNER TO django;

--
-- Name: search_opinion_joined_by_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.search_opinion_joined_by_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.search_opinion_joined_by_id_seq OWNER TO django;

--
-- Name: search_opinion_joined_by_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.search_opinion_joined_by_id_seq OWNED BY public.search_opinion_joined_by.id;


--
-- Name: search_opinioncluster; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.search_opinioncluster (
    id integer NOT NULL,
    judges text NOT NULL,
    date_created timestamp with time zone NOT NULL,
    date_modified timestamp with time zone NOT NULL,
    date_filed date NOT NULL,
    slug character varying(75),
    case_name_short text NOT NULL,
    case_name text NOT NULL,
    case_name_full text NOT NULL,
    scdb_id character varying(10) NOT NULL,
    source character varying(10) NOT NULL,
    procedural_history text NOT NULL,
    attorneys text NOT NULL,
    nature_of_suit text NOT NULL,
    posture text NOT NULL,
    syllabus text NOT NULL,
    citation_count integer NOT NULL,
    precedential_status character varying(50) NOT NULL,
    date_blocked date,
    blocked boolean NOT NULL,
    docket_id integer NOT NULL,
    scdb_decision_direction integer,
    scdb_votes_majority integer,
    scdb_votes_minority integer,
    date_filed_is_approximate boolean NOT NULL,
    correction text NOT NULL,
    cross_reference text NOT NULL,
    disposition text NOT NULL,
    filepath_json_harvard character varying(1000) NOT NULL,
    headnotes text NOT NULL,
    history text NOT NULL,
    other_dates text NOT NULL,
    summary text NOT NULL
);


ALTER TABLE public.search_opinioncluster OWNER TO django;

--
-- Name: search_opinioncluster_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.search_opinioncluster_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.search_opinioncluster_id_seq OWNER TO django;

--
-- Name: search_opinioncluster_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.search_opinioncluster_id_seq OWNED BY public.search_opinioncluster.id;


--
-- Name: search_opinioncluster_non_participating_judges; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.search_opinioncluster_non_participating_judges (
    id integer NOT NULL,
    opinioncluster_id integer NOT NULL,
    person_id integer NOT NULL
);


ALTER TABLE public.search_opinioncluster_non_participating_judges OWNER TO django;

--
-- Name: search_opinioncluster_non_participating_judges_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.search_opinioncluster_non_participating_judges_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.search_opinioncluster_non_participating_judges_id_seq OWNER TO django;

--
-- Name: search_opinioncluster_non_participating_judges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.search_opinioncluster_non_participating_judges_id_seq OWNED BY public.search_opinioncluster_non_participating_judges.id;


--
-- Name: search_opinioncluster_panel; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.search_opinioncluster_panel (
    id integer NOT NULL,
    opinioncluster_id integer NOT NULL,
    person_id integer NOT NULL
);


ALTER TABLE public.search_opinioncluster_panel OWNER TO django;

--
-- Name: search_opinioncluster_panel_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.search_opinioncluster_panel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.search_opinioncluster_panel_id_seq OWNER TO django;

--
-- Name: search_opinioncluster_panel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.search_opinioncluster_panel_id_seq OWNED BY public.search_opinioncluster_panel.id;


--
-- Name: search_opinionscited; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.search_opinionscited (
    id integer NOT NULL,
    cited_opinion_id integer NOT NULL,
    citing_opinion_id integer NOT NULL,
    depth integer NOT NULL
);


ALTER TABLE public.search_opinionscited OWNER TO django;

--
-- Name: search_opinionscited_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.search_opinionscited_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.search_opinionscited_id_seq OWNER TO django;

--
-- Name: search_opinionscited_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.search_opinionscited_id_seq OWNED BY public.search_opinionscited.id;


--
-- Name: search_originatingcourtinformation; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.search_originatingcourtinformation (
    id integer NOT NULL,
    date_created timestamp with time zone NOT NULL,
    date_modified timestamp with time zone NOT NULL,
    assigned_to_str text NOT NULL,
    court_reporter text NOT NULL,
    date_disposed date,
    date_filed date,
    date_judgment date,
    date_judgment_eod date,
    date_filed_noa date,
    date_received_coa date,
    assigned_to_id integer,
    docket_number text NOT NULL,
    ordering_judge_id integer,
    ordering_judge_str text NOT NULL
);


ALTER TABLE public.search_originatingcourtinformation OWNER TO django;

--
-- Name: search_originatingcourtinformation_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.search_originatingcourtinformation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.search_originatingcourtinformation_id_seq OWNER TO django;

--
-- Name: search_originatingcourtinformation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.search_originatingcourtinformation_id_seq OWNED BY public.search_originatingcourtinformation.id;


--
-- Name: search_parenthetical; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.search_parenthetical (
    id integer NOT NULL,
    text text NOT NULL,
    score double precision NOT NULL,
    described_opinion_id integer NOT NULL,
    describing_opinion_id integer NOT NULL,
    group_id integer
);


ALTER TABLE public.search_parenthetical OWNER TO django;

--
-- Name: search_parenthetical_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.search_parenthetical_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.search_parenthetical_id_seq OWNER TO django;

--
-- Name: search_parenthetical_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.search_parenthetical_id_seq OWNED BY public.search_parenthetical.id;


--
-- Name: search_parentheticalgroup; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.search_parentheticalgroup (
    id integer NOT NULL,
    score double precision NOT NULL,
    size integer NOT NULL,
    opinion_id integer NOT NULL,
    representative_id integer NOT NULL
);


ALTER TABLE public.search_parentheticalgroup OWNER TO django;

--
-- Name: search_parentheticalgroup_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.search_parentheticalgroup_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.search_parentheticalgroup_id_seq OWNER TO django;

--
-- Name: search_parentheticalgroup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.search_parentheticalgroup_id_seq OWNED BY public.search_parentheticalgroup.id;


--
-- Name: search_recapdocument; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.search_recapdocument (
    id integer NOT NULL,
    date_created timestamp with time zone NOT NULL,
    date_modified timestamp with time zone NOT NULL,
    date_upload timestamp with time zone,
    document_type integer NOT NULL,
    document_number character varying(32) NOT NULL,
    attachment_number smallint,
    pacer_doc_id character varying(32) NOT NULL,
    is_available boolean,
    sha1 character varying(40) NOT NULL,
    filepath_local character varying(1000) NOT NULL,
    filepath_ia character varying(1000) NOT NULL,
    docket_entry_id integer NOT NULL,
    description text NOT NULL,
    ocr_status smallint,
    plain_text text NOT NULL,
    page_count integer,
    is_free_on_pacer boolean,
    ia_upload_failure_count smallint,
    file_size integer,
    thumbnail character varying(100),
    thumbnail_status smallint NOT NULL,
    is_sealed boolean
);


ALTER TABLE public.search_recapdocument OWNER TO django;

--
-- Name: search_recapdocument_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.search_recapdocument_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.search_recapdocument_id_seq OWNER TO django;

--
-- Name: search_recapdocument_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.search_recapdocument_id_seq OWNED BY public.search_recapdocument.id;


--
-- Name: search_recapdocument_tags; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.search_recapdocument_tags (
    id integer NOT NULL,
    recapdocument_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public.search_recapdocument_tags OWNER TO django;

--
-- Name: search_recapdocument_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.search_recapdocument_tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.search_recapdocument_tags_id_seq OWNER TO django;

--
-- Name: search_recapdocument_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.search_recapdocument_tags_id_seq OWNED BY public.search_recapdocument_tags.id;


--
-- Name: search_tag; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.search_tag (
    id integer NOT NULL,
    date_created timestamp with time zone NOT NULL,
    date_modified timestamp with time zone NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.search_tag OWNER TO django;

--
-- Name: search_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.search_tag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.search_tag_id_seq OWNER TO django;

--
-- Name: search_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.search_tag_id_seq OWNED BY public.search_tag.id;


--
-- Name: audio_audio id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.audio_audio ALTER COLUMN id SET DEFAULT nextval('public.audio_audio_id_seq'::regclass);


--
-- Name: audio_audio_panel id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.audio_audio_panel ALTER COLUMN id SET DEFAULT nextval('public.audio_audio_panel_id_seq'::regclass);


--
-- Name: people_db_abarating id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_abarating ALTER COLUMN id SET DEFAULT nextval('public.people_db_abarating_id_seq'::regclass);


--
-- Name: people_db_attorney id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_attorney ALTER COLUMN id SET DEFAULT nextval('public.people_db_attorney_id_seq'::regclass);


--
-- Name: people_db_attorneyorganization id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_attorneyorganization ALTER COLUMN id SET DEFAULT nextval('public.people_db_attorneyorganization_id_seq'::regclass);


--
-- Name: people_db_attorneyorganizationassociation id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_attorneyorganizationassociation ALTER COLUMN id SET DEFAULT nextval('public.people_db_attorneyorganizationassociation_id_seq'::regclass);


--
-- Name: people_db_criminalcomplaint id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_criminalcomplaint ALTER COLUMN id SET DEFAULT nextval('public.people_db_criminalcomplaint_id_seq'::regclass);


--
-- Name: people_db_criminalcount id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_criminalcount ALTER COLUMN id SET DEFAULT nextval('public.people_db_criminalcount_id_seq'::regclass);


--
-- Name: people_db_education id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_education ALTER COLUMN id SET DEFAULT nextval('public.people_db_education_id_seq'::regclass);


--
-- Name: people_db_party id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_party ALTER COLUMN id SET DEFAULT nextval('public.people_db_party_id_seq'::regclass);


--
-- Name: people_db_partytype id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_partytype ALTER COLUMN id SET DEFAULT nextval('public.people_db_partytype_id_seq'::regclass);


--
-- Name: people_db_person id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_person ALTER COLUMN id SET DEFAULT nextval('public.people_db_person_id_seq'::regclass);


--
-- Name: people_db_person_race id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_person_race ALTER COLUMN id SET DEFAULT nextval('public.people_db_person_race_id_seq'::regclass);


--
-- Name: people_db_politicalaffiliation id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_politicalaffiliation ALTER COLUMN id SET DEFAULT nextval('public.people_db_politicalaffiliation_id_seq'::regclass);


--
-- Name: people_db_position id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_position ALTER COLUMN id SET DEFAULT nextval('public.people_db_position_id_seq'::regclass);


--
-- Name: people_db_race id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_race ALTER COLUMN id SET DEFAULT nextval('public.people_db_race_id_seq'::regclass);


--
-- Name: people_db_retentionevent id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_retentionevent ALTER COLUMN id SET DEFAULT nextval('public.people_db_retentionevent_id_seq'::regclass);


--
-- Name: people_db_role id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_role ALTER COLUMN id SET DEFAULT nextval('public.people_db_role_id_seq'::regclass);


--
-- Name: people_db_school id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_school ALTER COLUMN id SET DEFAULT nextval('public.people_db_school_id_seq'::regclass);


--
-- Name: people_db_source id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_source ALTER COLUMN id SET DEFAULT nextval('public.people_db_source_id_seq'::regclass);


--
-- Name: search_bankruptcyinformation id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_bankruptcyinformation ALTER COLUMN id SET DEFAULT nextval('public.search_bankruptcyinformation_id_seq'::regclass);


--
-- Name: search_citation id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_citation ALTER COLUMN id SET DEFAULT nextval('public.search_citation_id_seq'::regclass);


--
-- Name: search_claim id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_claim ALTER COLUMN id SET DEFAULT nextval('public.search_claim_id_seq'::regclass);


--
-- Name: search_claim_tags id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_claim_tags ALTER COLUMN id SET DEFAULT nextval('public.search_claim_tags_id_seq'::regclass);


--
-- Name: search_claimhistory id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_claimhistory ALTER COLUMN id SET DEFAULT nextval('public.search_claimhistory_id_seq'::regclass);


--
-- Name: search_docket id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_docket ALTER COLUMN id SET DEFAULT nextval('public.search_docket_id_seq'::regclass);


--
-- Name: search_docket_panel id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_docket_panel ALTER COLUMN id SET DEFAULT nextval('public.search_docket_panel_id_seq'::regclass);


--
-- Name: search_docket_tags id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_docket_tags ALTER COLUMN id SET DEFAULT nextval('public.search_docket_tags_id_seq'::regclass);


--
-- Name: search_docketentry id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_docketentry ALTER COLUMN id SET DEFAULT nextval('public.search_docketentry_id_seq'::regclass);


--
-- Name: search_docketentry_tags id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_docketentry_tags ALTER COLUMN id SET DEFAULT nextval('public.search_docketentry_tags_id_seq'::regclass);


--
-- Name: search_opinion id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_opinion ALTER COLUMN id SET DEFAULT nextval('public.search_opinion_id_seq'::regclass);


--
-- Name: search_opinion_joined_by id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_opinion_joined_by ALTER COLUMN id SET DEFAULT nextval('public.search_opinion_joined_by_id_seq'::regclass);


--
-- Name: search_opinioncluster id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_opinioncluster ALTER COLUMN id SET DEFAULT nextval('public.search_opinioncluster_id_seq'::regclass);


--
-- Name: search_opinioncluster_non_participating_judges id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_opinioncluster_non_participating_judges ALTER COLUMN id SET DEFAULT nextval('public.search_opinioncluster_non_participating_judges_id_seq'::regclass);


--
-- Name: search_opinioncluster_panel id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_opinioncluster_panel ALTER COLUMN id SET DEFAULT nextval('public.search_opinioncluster_panel_id_seq'::regclass);


--
-- Name: search_opinionscited id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_opinionscited ALTER COLUMN id SET DEFAULT nextval('public.search_opinionscited_id_seq'::regclass);


--
-- Name: search_originatingcourtinformation id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_originatingcourtinformation ALTER COLUMN id SET DEFAULT nextval('public.search_originatingcourtinformation_id_seq'::regclass);


--
-- Name: search_parenthetical id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_parenthetical ALTER COLUMN id SET DEFAULT nextval('public.search_parenthetical_id_seq'::regclass);


--
-- Name: search_parentheticalgroup id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_parentheticalgroup ALTER COLUMN id SET DEFAULT nextval('public.search_parentheticalgroup_id_seq'::regclass);


--
-- Name: search_recapdocument id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_recapdocument ALTER COLUMN id SET DEFAULT nextval('public.search_recapdocument_id_seq'::regclass);


--
-- Name: search_recapdocument_tags id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_recapdocument_tags ALTER COLUMN id SET DEFAULT nextval('public.search_recapdocument_tags_id_seq'::regclass);


--
-- Name: search_tag id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_tag ALTER COLUMN id SET DEFAULT nextval('public.search_tag_id_seq'::regclass);


--
-- Name: audio_audio_panel audio_audio_panel_audio_id_judge_id_key; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.audio_audio_panel
    ADD CONSTRAINT audio_audio_panel_audio_id_judge_id_key UNIQUE (audio_id, person_id);


--
-- Name: audio_audio_panel audio_audio_panel_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.audio_audio_panel
    ADD CONSTRAINT audio_audio_panel_pkey PRIMARY KEY (id);


--
-- Name: audio_audio audio_audio_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.audio_audio
    ADD CONSTRAINT audio_audio_pkey PRIMARY KEY (id);


--
-- Name: people_db_abarating people_db_abarating_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_abarating
    ADD CONSTRAINT people_db_abarating_pkey PRIMARY KEY (id);


--
-- Name: people_db_attorney people_db_attorney_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_attorney
    ADD CONSTRAINT people_db_attorney_pkey PRIMARY KEY (id);


--
-- Name: people_db_attorneyorganizationassociation people_db_attorneyorganization_attorney_id_7cda1fb15b747f5_uniq; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_attorneyorganizationassociation
    ADD CONSTRAINT people_db_attorneyorganization_attorney_id_7cda1fb15b747f5_uniq UNIQUE (attorney_id, attorney_organization_id, docket_id);


--
-- Name: people_db_attorneyorganization people_db_attorneyorganization_lookup_key_key; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_attorneyorganization
    ADD CONSTRAINT people_db_attorneyorganization_lookup_key_key UNIQUE (lookup_key);


--
-- Name: people_db_attorneyorganization people_db_attorneyorganization_name_6e4a7d6ba93cb6a6_uniq; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_attorneyorganization
    ADD CONSTRAINT people_db_attorneyorganization_name_6e4a7d6ba93cb6a6_uniq UNIQUE (name, address1, address2, city, state, zip_code);


--
-- Name: people_db_attorneyorganization people_db_attorneyorganization_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_attorneyorganization
    ADD CONSTRAINT people_db_attorneyorganization_pkey PRIMARY KEY (id);


--
-- Name: people_db_attorneyorganizationassociation people_db_attorneyorganizationassociation_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_attorneyorganizationassociation
    ADD CONSTRAINT people_db_attorneyorganizationassociation_pkey PRIMARY KEY (id);


--
-- Name: people_db_criminalcomplaint people_db_criminalcomplaint_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_criminalcomplaint
    ADD CONSTRAINT people_db_criminalcomplaint_pkey PRIMARY KEY (id);


--
-- Name: people_db_criminalcount people_db_criminalcount_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_criminalcount
    ADD CONSTRAINT people_db_criminalcount_pkey PRIMARY KEY (id);


--
-- Name: people_db_education people_db_education_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_education
    ADD CONSTRAINT people_db_education_pkey PRIMARY KEY (id);


--
-- Name: people_db_party people_db_party_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_party
    ADD CONSTRAINT people_db_party_pkey PRIMARY KEY (id);


--
-- Name: people_db_partytype people_db_partytype_docket_id_345b40b72c694865_uniq; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_partytype
    ADD CONSTRAINT people_db_partytype_docket_id_345b40b72c694865_uniq UNIQUE (docket_id, party_id, name);


--
-- Name: people_db_partytype people_db_partytype_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_partytype
    ADD CONSTRAINT people_db_partytype_pkey PRIMARY KEY (id);


--
-- Name: people_db_person people_db_person_fjc_id_key; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_person
    ADD CONSTRAINT people_db_person_fjc_id_key UNIQUE (fjc_id);


--
-- Name: people_db_person people_db_person_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_person
    ADD CONSTRAINT people_db_person_pkey PRIMARY KEY (id);


--
-- Name: people_db_person_race people_db_person_race_person_id_race_id_key; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_person_race
    ADD CONSTRAINT people_db_person_race_person_id_race_id_key UNIQUE (person_id, race_id);


--
-- Name: people_db_person_race people_db_person_race_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_person_race
    ADD CONSTRAINT people_db_person_race_pkey PRIMARY KEY (id);


--
-- Name: people_db_politicalaffiliation people_db_politicalaffiliation_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_politicalaffiliation
    ADD CONSTRAINT people_db_politicalaffiliation_pkey PRIMARY KEY (id);


--
-- Name: people_db_position people_db_position_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_position
    ADD CONSTRAINT people_db_position_pkey PRIMARY KEY (id);


--
-- Name: people_db_race people_db_race_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_race
    ADD CONSTRAINT people_db_race_pkey PRIMARY KEY (id);


--
-- Name: people_db_race people_db_race_race_50897822747d246e_uniq; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_race
    ADD CONSTRAINT people_db_race_race_50897822747d246e_uniq UNIQUE (race);


--
-- Name: people_db_retentionevent people_db_retentionevent_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_retentionevent
    ADD CONSTRAINT people_db_retentionevent_pkey PRIMARY KEY (id);


--
-- Name: people_db_role people_db_role_party_id_73709a165082400a_uniq; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_role
    ADD CONSTRAINT people_db_role_party_id_73709a165082400a_uniq UNIQUE (party_id, attorney_id, role, docket_id, date_action);


--
-- Name: people_db_role people_db_role_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_role
    ADD CONSTRAINT people_db_role_pkey PRIMARY KEY (id);


--
-- Name: people_db_school people_db_school_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_school
    ADD CONSTRAINT people_db_school_pkey PRIMARY KEY (id);


--
-- Name: people_db_source people_db_source_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_source
    ADD CONSTRAINT people_db_source_pkey PRIMARY KEY (id);


--
-- Name: search_bankruptcyinformation search_bankruptcyinformation_docket_id_key; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_bankruptcyinformation
    ADD CONSTRAINT search_bankruptcyinformation_docket_id_key UNIQUE (docket_id);


--
-- Name: search_bankruptcyinformation search_bankruptcyinformation_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_bankruptcyinformation
    ADD CONSTRAINT search_bankruptcyinformation_pkey PRIMARY KEY (id);


--
-- Name: search_citation search_citation_cluster_id_7a668830aad411f5_uniq; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_citation
    ADD CONSTRAINT search_citation_cluster_id_7a668830aad411f5_uniq UNIQUE (cluster_id, volume, reporter, page);


--
-- Name: search_citation search_citation_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_citation
    ADD CONSTRAINT search_citation_pkey PRIMARY KEY (id);


--
-- Name: search_claim search_claim_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_claim
    ADD CONSTRAINT search_claim_pkey PRIMARY KEY (id);


--
-- Name: search_claim_tags search_claim_tags_claim_id_tag_id_2f236693_uniq; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_claim_tags
    ADD CONSTRAINT search_claim_tags_claim_id_tag_id_2f236693_uniq UNIQUE (claim_id, tag_id);


--
-- Name: search_claim_tags search_claim_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_claim_tags
    ADD CONSTRAINT search_claim_tags_pkey PRIMARY KEY (id);


--
-- Name: search_claimhistory search_claimhistory_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_claimhistory
    ADD CONSTRAINT search_claimhistory_pkey PRIMARY KEY (id);


--
-- Name: search_court search_court_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_court
    ADD CONSTRAINT search_court_pkey PRIMARY KEY (id);


--
-- Name: search_court search_court_position_key; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_court
    ADD CONSTRAINT search_court_position_key UNIQUE ("position");


--
-- Name: search_docket search_docket_docket_number_7642c6c6dbd04704_uniq; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_docket
    ADD CONSTRAINT search_docket_docket_number_7642c6c6dbd04704_uniq UNIQUE (docket_number, pacer_case_id, court_id);


--
-- Name: search_docket search_docket_idb_data_id_key; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_docket
    ADD CONSTRAINT search_docket_idb_data_id_key UNIQUE (idb_data_id);


--
-- Name: search_docket search_docket_originating_court_id_key; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_docket
    ADD CONSTRAINT search_docket_originating_court_id_key UNIQUE (originating_court_information_id);


--
-- Name: search_docket_panel search_docket_panel_docket_id_person_id_key; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_docket_panel
    ADD CONSTRAINT search_docket_panel_docket_id_person_id_key UNIQUE (docket_id, person_id);


--
-- Name: search_docket_panel search_docket_panel_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_docket_panel
    ADD CONSTRAINT search_docket_panel_pkey PRIMARY KEY (id);


--
-- Name: search_docket search_docket_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_docket
    ADD CONSTRAINT search_docket_pkey PRIMARY KEY (id);


--
-- Name: search_docket_tags search_docket_tags_docket_id_tag_id_key; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_docket_tags
    ADD CONSTRAINT search_docket_tags_docket_id_tag_id_key UNIQUE (docket_id, tag_id);


--
-- Name: search_docket_tags search_docket_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_docket_tags
    ADD CONSTRAINT search_docket_tags_pkey PRIMARY KEY (id);


--
-- Name: search_docketentry search_docketentry_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_docketentry
    ADD CONSTRAINT search_docketentry_pkey PRIMARY KEY (id);


--
-- Name: search_docketentry_tags search_docketentry_tags_docketentry_id_tag_id_key; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_docketentry_tags
    ADD CONSTRAINT search_docketentry_tags_docketentry_id_tag_id_key UNIQUE (docketentry_id, tag_id);


--
-- Name: search_docketentry_tags search_docketentry_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_docketentry_tags
    ADD CONSTRAINT search_docketentry_tags_pkey PRIMARY KEY (id);


--
-- Name: search_opinion_joined_by search_opinion_joined_by_opinion_id_judge_id_key; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_opinion_joined_by
    ADD CONSTRAINT search_opinion_joined_by_opinion_id_judge_id_key UNIQUE (opinion_id, person_id);


--
-- Name: search_opinion_joined_by search_opinion_joined_by_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_opinion_joined_by
    ADD CONSTRAINT search_opinion_joined_by_pkey PRIMARY KEY (id);


--
-- Name: search_opinion search_opinion_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_opinion
    ADD CONSTRAINT search_opinion_pkey PRIMARY KEY (id);


--
-- Name: search_opinioncluster_non_participating_judges search_opinioncluster_non_partic_opinioncluster_id_judge_id_key; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_opinioncluster_non_participating_judges
    ADD CONSTRAINT search_opinioncluster_non_partic_opinioncluster_id_judge_id_key UNIQUE (opinioncluster_id, person_id);


--
-- Name: search_opinioncluster_non_participating_judges search_opinioncluster_non_participating_judges_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_opinioncluster_non_participating_judges
    ADD CONSTRAINT search_opinioncluster_non_participating_judges_pkey PRIMARY KEY (id);


--
-- Name: search_opinioncluster_panel search_opinioncluster_panel_opinioncluster_id_judge_id_key; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_opinioncluster_panel
    ADD CONSTRAINT search_opinioncluster_panel_opinioncluster_id_judge_id_key UNIQUE (opinioncluster_id, person_id);


--
-- Name: search_opinioncluster_panel search_opinioncluster_panel_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_opinioncluster_panel
    ADD CONSTRAINT search_opinioncluster_panel_pkey PRIMARY KEY (id);


--
-- Name: search_opinioncluster search_opinioncluster_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_opinioncluster
    ADD CONSTRAINT search_opinioncluster_pkey PRIMARY KEY (id);


--
-- Name: search_opinionscited search_opinionscited_citing_opinion_id_7165e96b2aed974f_uniq; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_opinionscited
    ADD CONSTRAINT search_opinionscited_citing_opinion_id_7165e96b2aed974f_uniq UNIQUE (citing_opinion_id, cited_opinion_id);


--
-- Name: search_opinionscited search_opinionscited_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_opinionscited
    ADD CONSTRAINT search_opinionscited_pkey PRIMARY KEY (id);


--
-- Name: search_originatingcourtinformation search_originatingcourtinformation_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_originatingcourtinformation
    ADD CONSTRAINT search_originatingcourtinformation_pkey PRIMARY KEY (id);


--
-- Name: search_parenthetical search_parenthetical_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_parenthetical
    ADD CONSTRAINT search_parenthetical_pkey PRIMARY KEY (id);


--
-- Name: search_parentheticalgroup search_parentheticalgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_parentheticalgroup
    ADD CONSTRAINT search_parentheticalgroup_pkey PRIMARY KEY (id);


--
-- Name: search_recapdocument search_recapdocument_docket_entry_id_37b2f4ece60cde00_uniq; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_recapdocument
    ADD CONSTRAINT search_recapdocument_docket_entry_id_37b2f4ece60cde00_uniq UNIQUE (docket_entry_id, document_number, attachment_number);


--
-- Name: search_recapdocument search_recapdocument_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_recapdocument
    ADD CONSTRAINT search_recapdocument_pkey PRIMARY KEY (id);


--
-- Name: search_recapdocument_tags search_recapdocument_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_recapdocument_tags
    ADD CONSTRAINT search_recapdocument_tags_pkey PRIMARY KEY (id);


--
-- Name: search_recapdocument_tags search_recapdocument_tags_recapdocument_id_tag_id_key; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_recapdocument_tags
    ADD CONSTRAINT search_recapdocument_tags_recapdocument_id_tag_id_key UNIQUE (recapdocument_id, tag_id);


--
-- Name: search_tag search_tag_name_key; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_tag
    ADD CONSTRAINT search_tag_name_key UNIQUE (name);


--
-- Name: search_tag search_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_tag
    ADD CONSTRAINT search_tag_pkey PRIMARY KEY (id);


--
-- Name: audio_audio_03b47046; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX audio_audio_03b47046 ON public.audio_audio USING btree (local_path_original_file);


--
-- Name: audio_audio_0b869b2f; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX audio_audio_0b869b2f ON public.audio_audio USING btree (date_blocked);


--
-- Name: audio_audio_1427d4ab; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX audio_audio_1427d4ab ON public.audio_audio USING btree (docket_id);


--
-- Name: audio_audio_1cbcfc0f; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX audio_audio_1cbcfc0f ON public.audio_audio USING btree (download_url);


--
-- Name: audio_audio_41ddbca9; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX audio_audio_41ddbca9 ON public.audio_audio USING btree (local_path_mp3);


--
-- Name: audio_audio_5fdb3d66; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX audio_audio_5fdb3d66 ON public.audio_audio USING btree (date_modified);


--
-- Name: audio_audio_61326117; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX audio_audio_61326117 ON public.audio_audio USING btree (blocked);


--
-- Name: audio_audio_74a89174; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX audio_audio_74a89174 ON public.audio_audio USING btree (sha1);


--
-- Name: audio_audio_c69e55a4; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX audio_audio_c69e55a4 ON public.audio_audio USING btree (date_created);


--
-- Name: audio_audio_download_url_44408fffeee4f71b_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX audio_audio_download_url_44408fffeee4f71b_like ON public.audio_audio USING btree (download_url varchar_pattern_ops);


--
-- Name: audio_audio_local_path_mp3_11f796e4872a9bad_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX audio_audio_local_path_mp3_11f796e4872a9bad_like ON public.audio_audio USING btree (local_path_mp3 varchar_pattern_ops);


--
-- Name: audio_audio_local_path_original_file_102ce483dde8495d_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX audio_audio_local_path_original_file_102ce483dde8495d_like ON public.audio_audio USING btree (local_path_original_file varchar_pattern_ops);


--
-- Name: audio_audio_panel_26f6023f; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX audio_audio_panel_26f6023f ON public.audio_audio_panel USING btree (audio_id);


--
-- Name: audio_audio_panel_e7c5d788; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX audio_audio_panel_e7c5d788 ON public.audio_audio_panel USING btree (person_id);


--
-- Name: audio_audio_sha1_2510d5a8f56f35d4_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX audio_audio_sha1_2510d5a8f56f35d4_like ON public.audio_audio USING btree (sha1 varchar_pattern_ops);


--
-- Name: people_db_abarating_5fdb3d66; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_abarating_5fdb3d66 ON public.people_db_abarating USING btree (date_modified);


--
-- Name: people_db_abarating_a8452ca7; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_abarating_a8452ca7 ON public.people_db_abarating USING btree (person_id);


--
-- Name: people_db_abarating_c69e55a4; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_abarating_c69e55a4 ON public.people_db_abarating USING btree (date_created);


--
-- Name: people_db_attorney_5fdb3d66; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_attorney_5fdb3d66 ON public.people_db_attorney USING btree (date_modified);


--
-- Name: people_db_attorney_b068931c; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_attorney_b068931c ON public.people_db_attorney USING btree (name);


--
-- Name: people_db_attorney_c69e55a4; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_attorney_c69e55a4 ON public.people_db_attorney USING btree (date_created);


--
-- Name: people_db_attorney_name_46d318a02757f6dd_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_attorney_name_46d318a02757f6dd_like ON public.people_db_attorney USING btree (name text_pattern_ops);


--
-- Name: people_db_attorneyorganization_0c0ae404; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_attorneyorganization_0c0ae404 ON public.people_db_attorneyorganization USING btree (zip_code);


--
-- Name: people_db_attorneyorganization_4ed5d2ea; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_attorneyorganization_4ed5d2ea ON public.people_db_attorneyorganization USING btree (city);


--
-- Name: people_db_attorneyorganization_5fdb3d66; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_attorneyorganization_5fdb3d66 ON public.people_db_attorneyorganization USING btree (date_modified);


--
-- Name: people_db_attorneyorganization_81e70cb1; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_attorneyorganization_81e70cb1 ON public.people_db_attorneyorganization USING btree (address1);


--
-- Name: people_db_attorneyorganization_9ed39e2e; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_attorneyorganization_9ed39e2e ON public.people_db_attorneyorganization USING btree (state);


--
-- Name: people_db_attorneyorganization_address1_403814857b548870_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_attorneyorganization_address1_403814857b548870_like ON public.people_db_attorneyorganization USING btree (address1 text_pattern_ops);


--
-- Name: people_db_attorneyorganization_address2_403814857b4403d3_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_attorneyorganization_address2_403814857b4403d3_like ON public.people_db_attorneyorganization USING btree (address2 text_pattern_ops);


--
-- Name: people_db_attorneyorganization_b068931c; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_attorneyorganization_b068931c ON public.people_db_attorneyorganization USING btree (name);


--
-- Name: people_db_attorneyorganization_c69e55a4; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_attorneyorganization_c69e55a4 ON public.people_db_attorneyorganization USING btree (date_created);


--
-- Name: people_db_attorneyorganization_city_2a5498a19c997008_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_attorneyorganization_city_2a5498a19c997008_like ON public.people_db_attorneyorganization USING btree (city text_pattern_ops);


--
-- Name: people_db_attorneyorganization_f669f8e9; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_attorneyorganization_f669f8e9 ON public.people_db_attorneyorganization USING btree (address2);


--
-- Name: people_db_attorneyorganization_lookup_key_4723770634841e39_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_attorneyorganization_lookup_key_4723770634841e39_like ON public.people_db_attorneyorganization USING btree (lookup_key text_pattern_ops);


--
-- Name: people_db_attorneyorganization_name_eddcefc5b671344_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_attorneyorganization_name_eddcefc5b671344_like ON public.people_db_attorneyorganization USING btree (name text_pattern_ops);


--
-- Name: people_db_attorneyorganization_state_18fe99f5bf671255_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_attorneyorganization_state_18fe99f5bf671255_like ON public.people_db_attorneyorganization USING btree (state varchar_pattern_ops);


--
-- Name: people_db_attorneyorganization_zip_code_66632293e4093e4e_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_attorneyorganization_zip_code_66632293e4093e4e_like ON public.people_db_attorneyorganization USING btree (zip_code varchar_pattern_ops);


--
-- Name: people_db_attorneyorganizationassociation_1427d4ab; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_attorneyorganizationassociation_1427d4ab ON public.people_db_attorneyorganizationassociation USING btree (docket_id);


--
-- Name: people_db_attorneyorganizationassociation_9f99f769; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_attorneyorganizationassociation_9f99f769 ON public.people_db_attorneyorganizationassociation USING btree (attorney_id);


--
-- Name: people_db_attorneyorganizationassociation_a2c8783d; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_attorneyorganizationassociation_a2c8783d ON public.people_db_attorneyorganizationassociation USING btree (attorney_organization_id);


--
-- Name: people_db_criminalcomplaint_4edc179c; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_criminalcomplaint_4edc179c ON public.people_db_criminalcomplaint USING btree (party_type_id);


--
-- Name: people_db_criminalcount_4edc179c; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_criminalcount_4edc179c ON public.people_db_criminalcount USING btree (party_type_id);


--
-- Name: people_db_education_5fc7164b; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_education_5fc7164b ON public.people_db_education USING btree (school_id);


--
-- Name: people_db_education_5fdb3d66; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_education_5fdb3d66 ON public.people_db_education USING btree (date_modified);


--
-- Name: people_db_education_a8452ca7; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_education_a8452ca7 ON public.people_db_education USING btree (person_id);


--
-- Name: people_db_education_c69e55a4; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_education_c69e55a4 ON public.people_db_education USING btree (date_created);


--
-- Name: people_db_party_5fdb3d66; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_party_5fdb3d66 ON public.people_db_party USING btree (date_modified);


--
-- Name: people_db_party_b068931c; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_party_b068931c ON public.people_db_party USING btree (name);


--
-- Name: people_db_party_bb2cb5a6; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_party_bb2cb5a6 ON public.people_db_party USING btree (extra_info);


--
-- Name: people_db_party_c69e55a4; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_party_c69e55a4 ON public.people_db_party USING btree (date_created);


--
-- Name: people_db_party_extra_info_7a50cbcc44fd5d7a_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_party_extra_info_7a50cbcc44fd5d7a_like ON public.people_db_party USING btree (extra_info text_pattern_ops);


--
-- Name: people_db_party_name_3d12b76fe7f0ae1c_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_party_name_3d12b76fe7f0ae1c_like ON public.people_db_party USING btree (name text_pattern_ops);


--
-- Name: people_db_partytype_1427d4ab; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_partytype_1427d4ab ON public.people_db_partytype USING btree (docket_id);


--
-- Name: people_db_partytype_2c662395; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_partytype_2c662395 ON public.people_db_partytype USING btree (party_id);


--
-- Name: people_db_partytype_b068931c; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_partytype_b068931c ON public.people_db_partytype USING btree (name);


--
-- Name: people_db_partytype_bb2cb5a6; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_partytype_bb2cb5a6 ON public.people_db_partytype USING btree (extra_info);


--
-- Name: people_db_partytype_name_4cb81702de26fee8_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_partytype_name_4cb81702de26fee8_like ON public.people_db_partytype USING btree (name varchar_pattern_ops);


--
-- Name: people_db_person_2dbcba41; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_person_2dbcba41 ON public.people_db_person USING btree (slug);


--
-- Name: people_db_person_3c6ec45e; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_person_3c6ec45e ON public.people_db_person USING btree (is_alias_of_id);


--
-- Name: people_db_person_5fdb3d66; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_person_5fdb3d66 ON public.people_db_person USING btree (date_modified);


--
-- Name: people_db_person_c69e55a4; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_person_c69e55a4 ON public.people_db_person USING btree (date_created);


--
-- Name: people_db_person_c943ec03; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_person_c943ec03 ON public.people_db_person USING btree (name_last);


--
-- Name: people_db_person_e489b049; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_person_e489b049 ON public.people_db_person USING btree (ftm_total_received);


--
-- Name: people_db_person_name_last_2c38f190d58b7eba_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_person_name_last_2c38f190d58b7eba_like ON public.people_db_person USING btree (name_last varchar_pattern_ops);


--
-- Name: people_db_person_race_3f2f3687; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_person_race_3f2f3687 ON public.people_db_person_race USING btree (race_id);


--
-- Name: people_db_person_race_a8452ca7; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_person_race_a8452ca7 ON public.people_db_person_race USING btree (person_id);


--
-- Name: people_db_person_slug_10074d278f243e42_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_person_slug_10074d278f243e42_like ON public.people_db_person USING btree (slug varchar_pattern_ops);


--
-- Name: people_db_politicalaffiliation_5fdb3d66; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_politicalaffiliation_5fdb3d66 ON public.people_db_politicalaffiliation USING btree (date_modified);


--
-- Name: people_db_politicalaffiliation_a8452ca7; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_politicalaffiliation_a8452ca7 ON public.people_db_politicalaffiliation USING btree (person_id);


--
-- Name: people_db_politicalaffiliation_c69e55a4; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_politicalaffiliation_c69e55a4 ON public.people_db_politicalaffiliation USING btree (date_created);


--
-- Name: people_db_position_0ce67364; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_position_0ce67364 ON public.people_db_position USING btree (date_start);


--
-- Name: people_db_position_1301727a; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_position_1301727a ON public.people_db_position USING btree (date_elected);


--
-- Name: people_db_position_22b8ff35; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_position_22b8ff35 ON public.people_db_position USING btree (appointer_id);


--
-- Name: people_db_position_2a1c0b55; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_position_2a1c0b55 ON public.people_db_position USING btree (date_confirmation);


--
-- Name: people_db_position_43e12164; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_position_43e12164 ON public.people_db_position USING btree (date_judicial_committee_action);


--
-- Name: people_db_position_5fc7164b; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_position_5fc7164b ON public.people_db_position USING btree (school_id);


--
-- Name: people_db_position_5fdb3d66; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_position_5fdb3d66 ON public.people_db_position USING btree (date_modified);


--
-- Name: people_db_position_7a183bc6; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_position_7a183bc6 ON public.people_db_position USING btree (date_recess_appointment);


--
-- Name: people_db_position_7a46e69c; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_position_7a46e69c ON public.people_db_position USING btree (court_id);


--
-- Name: people_db_position_a2289cae; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_position_a2289cae ON public.people_db_position USING btree (date_referred_to_judicial_committee);


--
-- Name: people_db_position_a7ad19f8; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_position_a7ad19f8 ON public.people_db_position USING btree (date_nominated);


--
-- Name: people_db_position_a8452ca7; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_position_a8452ca7 ON public.people_db_position USING btree (person_id);


--
-- Name: people_db_position_a9962d2d; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_position_a9962d2d ON public.people_db_position USING btree (date_retirement);


--
-- Name: people_db_position_b070f947; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_position_b070f947 ON public.people_db_position USING btree (predecessor_id);


--
-- Name: people_db_position_c69e55a4; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_position_c69e55a4 ON public.people_db_position USING btree (date_created);


--
-- Name: people_db_position_court_id_7141eee9b516a894_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_position_court_id_7141eee9b516a894_like ON public.people_db_position USING btree (court_id varchar_pattern_ops);


--
-- Name: people_db_position_d32bfe21; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_position_d32bfe21 ON public.people_db_position USING btree (date_termination);


--
-- Name: people_db_position_eae0a89e; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_position_eae0a89e ON public.people_db_position USING btree (supervisor_id);


--
-- Name: people_db_position_ed551732; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_position_ed551732 ON public.people_db_position USING btree (date_hearing);


--
-- Name: people_db_retentionevent_4e6b5ce9; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_retentionevent_4e6b5ce9 ON public.people_db_retentionevent USING btree (date_retention);


--
-- Name: people_db_retentionevent_5fdb3d66; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_retentionevent_5fdb3d66 ON public.people_db_retentionevent USING btree (date_modified);


--
-- Name: people_db_retentionevent_bce5bd07; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_retentionevent_bce5bd07 ON public.people_db_retentionevent USING btree (position_id);


--
-- Name: people_db_retentionevent_c69e55a4; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_retentionevent_c69e55a4 ON public.people_db_retentionevent USING btree (date_created);


--
-- Name: people_db_role_1427d4ab; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_role_1427d4ab ON public.people_db_role USING btree (docket_id);


--
-- Name: people_db_role_29a7e964; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_role_29a7e964 ON public.people_db_role USING btree (role);


--
-- Name: people_db_role_2c662395; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_role_2c662395 ON public.people_db_role USING btree (party_id);


--
-- Name: people_db_role_9f99f769; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_role_9f99f769 ON public.people_db_role USING btree (attorney_id);


--
-- Name: people_db_school_3c6ec45e; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_school_3c6ec45e ON public.people_db_school USING btree (is_alias_of_id);


--
-- Name: people_db_school_5fdb3d66; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_school_5fdb3d66 ON public.people_db_school USING btree (date_modified);


--
-- Name: people_db_school_b068931c; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_school_b068931c ON public.people_db_school USING btree (name);


--
-- Name: people_db_school_c69e55a4; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_school_c69e55a4 ON public.people_db_school USING btree (date_created);


--
-- Name: people_db_school_ffef75ef; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_school_ffef75ef ON public.people_db_school USING btree (ein);


--
-- Name: people_db_school_name_55359da037ff6cd5_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_school_name_55359da037ff6cd5_like ON public.people_db_school USING btree (name varchar_pattern_ops);


--
-- Name: people_db_source_5fdb3d66; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_source_5fdb3d66 ON public.people_db_source USING btree (date_modified);


--
-- Name: people_db_source_a8452ca7; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_source_a8452ca7 ON public.people_db_source USING btree (person_id);


--
-- Name: people_db_source_c69e55a4; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX people_db_source_c69e55a4 ON public.people_db_source USING btree (date_created);


--
-- Name: search_bankruptcyinformation_date_created_60f180b0; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_bankruptcyinformation_date_created_60f180b0 ON public.search_bankruptcyinformation USING btree (date_created);


--
-- Name: search_bankruptcyinformation_date_modified_c1b76dd9; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_bankruptcyinformation_date_modified_c1b76dd9 ON public.search_bankruptcyinformation USING btree (date_modified);


--
-- Name: search_citation_966557f0; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_citation_966557f0 ON public.search_citation USING btree (reporter);


--
-- Name: search_citation_a97b1c12; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_citation_a97b1c12 ON public.search_citation USING btree (cluster_id);


--
-- Name: search_citation_reporter_1b48f47a0886ffdd_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_citation_reporter_1b48f47a0886ffdd_like ON public.search_citation USING btree (reporter text_pattern_ops);


--
-- Name: search_citation_volume_251bc1d270a8abee_idx; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_citation_volume_251bc1d270a8abee_idx ON public.search_citation USING btree (volume, reporter);


--
-- Name: search_citation_volume_ae340b5b02e8912_idx; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_citation_volume_ae340b5b02e8912_idx ON public.search_citation USING btree (volume, reporter, page);


--
-- Name: search_claim_claim_number_263236b3; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_claim_claim_number_263236b3 ON public.search_claim USING btree (claim_number);


--
-- Name: search_claim_claim_number_263236b3_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_claim_claim_number_263236b3_like ON public.search_claim USING btree (claim_number varchar_pattern_ops);


--
-- Name: search_claim_date_created_8c2e998c; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_claim_date_created_8c2e998c ON public.search_claim USING btree (date_created);


--
-- Name: search_claim_date_modified_f38130a2; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_claim_date_modified_f38130a2 ON public.search_claim USING btree (date_modified);


--
-- Name: search_claim_docket_id_b37171a9; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_claim_docket_id_b37171a9 ON public.search_claim USING btree (docket_id);


--
-- Name: search_claim_tags_claim_id_2cf554b5; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_claim_tags_claim_id_2cf554b5 ON public.search_claim_tags USING btree (claim_id);


--
-- Name: search_claim_tags_tag_id_73b6bd4d; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_claim_tags_tag_id_73b6bd4d ON public.search_claim_tags USING btree (tag_id);


--
-- Name: search_claimhistory_claim_id_e130e572; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_claimhistory_claim_id_e130e572 ON public.search_claimhistory USING btree (claim_id);


--
-- Name: search_claimhistory_date_created_586d545e; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_claimhistory_date_created_586d545e ON public.search_claimhistory USING btree (date_created);


--
-- Name: search_claimhistory_date_modified_5f6ec339; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_claimhistory_date_modified_5f6ec339 ON public.search_claimhistory USING btree (date_modified);


--
-- Name: search_claimhistory_document_number_6316c155; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_claimhistory_document_number_6316c155 ON public.search_claimhistory USING btree (document_number);


--
-- Name: search_claimhistory_document_number_6316c155_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_claimhistory_document_number_6316c155_like ON public.search_claimhistory USING btree (document_number varchar_pattern_ops);


--
-- Name: search_claimhistory_is_free_on_pacer_81332a2c; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_claimhistory_is_free_on_pacer_81332a2c ON public.search_claimhistory USING btree (is_free_on_pacer);


--
-- Name: search_court_5fdb3d66; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_court_5fdb3d66 ON public.search_court USING btree (date_modified);


--
-- Name: search_court_id_28e1a61bd5ca39cc_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_court_id_28e1a61bd5ca39cc_like ON public.search_court USING btree (id varchar_pattern_ops);


--
-- Name: search_dock_court_i_a043ae_idx; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_dock_court_i_a043ae_idx ON public.search_docket USING btree (court_id, id);


--
-- Name: search_docket_02c1725c; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_docket_02c1725c ON public.search_docket USING btree (assigned_to_id);


--
-- Name: search_docket_0b869b2f; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_docket_0b869b2f ON public.search_docket USING btree (date_blocked);


--
-- Name: search_docket_34894a03; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_docket_34894a03 ON public.search_docket USING btree (pacer_case_id);


--
-- Name: search_docket_5fdb3d66; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_docket_5fdb3d66 ON public.search_docket USING btree (date_modified);


--
-- Name: search_docket_64cdae4d; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_docket_64cdae4d ON public.search_docket USING btree (referred_to_id);


--
-- Name: search_docket_695b63bb; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_docket_695b63bb ON public.search_docket USING btree (appeal_from_id);


--
-- Name: search_docket_6c91ba55; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_docket_6c91ba55 ON public.search_docket USING btree (docket_number_core);


--
-- Name: search_docket_7a46e69c; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_docket_7a46e69c ON public.search_docket USING btree (court_id);


--
-- Name: search_docket_c69e55a4; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_docket_c69e55a4 ON public.search_docket USING btree (date_created);


--
-- Name: search_docket_court_id_2d2438b2594e74ba_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_docket_court_id_2d2438b2594e74ba_like ON public.search_docket USING btree (court_id varchar_pattern_ops);


--
-- Name: search_docket_docket_number_4af29e98dca38326_uniq; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_docket_docket_number_4af29e98dca38326_uniq ON public.search_docket USING btree (docket_number);


--
-- Name: search_docket_docket_number_core_713b7b04e01f11d7_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_docket_docket_number_core_713b7b04e01f11d7_like ON public.search_docket USING btree (docket_number_core varchar_pattern_ops);


--
-- Name: search_docket_panel_1427d4ab; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_docket_panel_1427d4ab ON public.search_docket_panel USING btree (docket_id);


--
-- Name: search_docket_panel_a8452ca7; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_docket_panel_a8452ca7 ON public.search_docket_panel USING btree (person_id);


--
-- Name: search_docket_tags_1427d4ab; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_docket_tags_1427d4ab ON public.search_docket_tags USING btree (docket_id);


--
-- Name: search_docket_tags_76f094bc; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_docket_tags_76f094bc ON public.search_docket_tags USING btree (tag_id);


--
-- Name: search_docketentry_1427d4ab; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_docketentry_1427d4ab ON public.search_docketentry USING btree (docket_id);


--
-- Name: search_docketentry_5fdb3d66; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_docketentry_5fdb3d66 ON public.search_docketentry USING btree (date_modified);


--
-- Name: search_docketentry_c69e55a4; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_docketentry_c69e55a4 ON public.search_docketentry USING btree (date_created);


--
-- Name: search_docketentry_recap_sequence_number_1c82e51988e2d89f_idx; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_docketentry_recap_sequence_number_1c82e51988e2d89f_idx ON public.search_docketentry USING btree (recap_sequence_number, entry_number);


--
-- Name: search_docketentry_tags_76f094bc; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_docketentry_tags_76f094bc ON public.search_docketentry_tags USING btree (tag_id);


--
-- Name: search_docketentry_tags_b02d089e; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_docketentry_tags_b02d089e ON public.search_docketentry_tags USING btree (docketentry_id);


--
-- Name: search_opinion_1cbcfc0f; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_opinion_1cbcfc0f ON public.search_opinion USING btree (download_url);


--
-- Name: search_opinion_4f331e2f; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_opinion_4f331e2f ON public.search_opinion USING btree (author_id);


--
-- Name: search_opinion_5fdb3d66; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_opinion_5fdb3d66 ON public.search_opinion USING btree (date_modified);


--
-- Name: search_opinion_71485e76; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_opinion_71485e76 ON public.search_opinion USING btree (local_path);


--
-- Name: search_opinion_74a89174; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_opinion_74a89174 ON public.search_opinion USING btree (sha1);


--
-- Name: search_opinion_a97b1c12; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_opinion_a97b1c12 ON public.search_opinion USING btree (cluster_id);


--
-- Name: search_opinion_bded6737; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_opinion_bded6737 ON public.search_opinion USING btree (extracted_by_ocr);


--
-- Name: search_opinion_c69e55a4; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_opinion_c69e55a4 ON public.search_opinion USING btree (date_created);


--
-- Name: search_opinion_download_url_3b11b165f23bc568_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_opinion_download_url_3b11b165f23bc568_like ON public.search_opinion USING btree (download_url varchar_pattern_ops);


--
-- Name: search_opinion_joined_by_8a09c46f; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_opinion_joined_by_8a09c46f ON public.search_opinion_joined_by USING btree (opinion_id);


--
-- Name: search_opinion_joined_by_e7c5d788; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_opinion_joined_by_e7c5d788 ON public.search_opinion_joined_by USING btree (person_id);


--
-- Name: search_opinion_local_path_63290b39b28ef927_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_opinion_local_path_63290b39b28ef927_like ON public.search_opinion USING btree (local_path varchar_pattern_ops);


--
-- Name: search_opinion_sha1_5887dd5d3475ad17_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_opinion_sha1_5887dd5d3475ad17_like ON public.search_opinion USING btree (sha1 varchar_pattern_ops);


--
-- Name: search_opinioncluster_0b869b2f; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_opinioncluster_0b869b2f ON public.search_opinioncluster USING btree (date_blocked);


--
-- Name: search_opinioncluster_1427d4ab; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_opinioncluster_1427d4ab ON public.search_opinioncluster USING btree (docket_id);


--
-- Name: search_opinioncluster_5fdb3d66; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_opinioncluster_5fdb3d66 ON public.search_opinioncluster USING btree (date_modified);


--
-- Name: search_opinioncluster_61326117; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_opinioncluster_61326117 ON public.search_opinioncluster USING btree (blocked);


--
-- Name: search_opinioncluster_98cc5f59; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_opinioncluster_98cc5f59 ON public.search_opinioncluster USING btree (date_filed);


--
-- Name: search_opinioncluster_c69e55a4; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_opinioncluster_c69e55a4 ON public.search_opinioncluster USING btree (date_created);


--
-- Name: search_opinioncluster_d91c83eb; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_opinioncluster_d91c83eb ON public.search_opinioncluster USING btree (citation_count);


--
-- Name: search_opinioncluster_e0fd3ccf; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_opinioncluster_e0fd3ccf ON public.search_opinioncluster USING btree (scdb_id);


--
-- Name: search_opinioncluster_f796c05b; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_opinioncluster_f796c05b ON public.search_opinioncluster USING btree (precedential_status);


--
-- Name: search_opinioncluster_filepath_json_harvard_4b8057d0; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_opinioncluster_filepath_json_harvard_4b8057d0 ON public.search_opinioncluster USING btree (filepath_json_harvard);


--
-- Name: search_opinioncluster_filepath_json_harvard_4b8057d0_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_opinioncluster_filepath_json_harvard_4b8057d0_like ON public.search_opinioncluster USING btree (filepath_json_harvard varchar_pattern_ops);


--
-- Name: search_opinioncluster_non_participating_judges_49bb60ae; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_opinioncluster_non_participating_judges_49bb60ae ON public.search_opinioncluster_non_participating_judges USING btree (opinioncluster_id);


--
-- Name: search_opinioncluster_non_participating_judges_e7c5d788; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_opinioncluster_non_participating_judges_e7c5d788 ON public.search_opinioncluster_non_participating_judges USING btree (person_id);


--
-- Name: search_opinioncluster_panel_49bb60ae; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_opinioncluster_panel_49bb60ae ON public.search_opinioncluster_panel USING btree (opinioncluster_id);


--
-- Name: search_opinioncluster_panel_e7c5d788; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_opinioncluster_panel_e7c5d788 ON public.search_opinioncluster_panel USING btree (person_id);


--
-- Name: search_opinioncluster_precedential_status_2bdec6e2dedba28b_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_opinioncluster_precedential_status_2bdec6e2dedba28b_like ON public.search_opinioncluster USING btree (precedential_status varchar_pattern_ops);


--
-- Name: search_opinioncluster_supreme_court_db_id_4297061ed6ba336_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_opinioncluster_supreme_court_db_id_4297061ed6ba336_like ON public.search_opinioncluster USING btree (scdb_id varchar_pattern_ops);


--
-- Name: search_opinionscited_5b8b69a0; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_opinionscited_5b8b69a0 ON public.search_opinionscited USING btree (citing_opinion_id);


--
-- Name: search_opinionscited_740050e6; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_opinionscited_740050e6 ON public.search_opinionscited USING btree (cited_opinion_id);


--
-- Name: search_opinionscited_depth_46bacaef; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_opinionscited_depth_46bacaef ON public.search_opinionscited USING btree (depth);


--
-- Name: search_originatingcourtinformation_02c1725c; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_originatingcourtinformation_02c1725c ON public.search_originatingcourtinformation USING btree (assigned_to_id);


--
-- Name: search_originatingcourtinformation_09a6c128; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_originatingcourtinformation_09a6c128 ON public.search_originatingcourtinformation USING btree (ordering_judge_id);


--
-- Name: search_originatingcourtinformation_5fdb3d66; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_originatingcourtinformation_5fdb3d66 ON public.search_originatingcourtinformation USING btree (date_modified);


--
-- Name: search_originatingcourtinformation_c69e55a4; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_originatingcourtinformation_c69e55a4 ON public.search_originatingcourtinformation USING btree (date_created);


--
-- Name: search_pare_score_16f118_idx; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_pare_score_16f118_idx ON public.search_parentheticalgroup USING btree (score);


--
-- Name: search_parenthetical_described_opinion_id_ddd408db; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_parenthetical_described_opinion_id_ddd408db ON public.search_parenthetical USING btree (described_opinion_id);


--
-- Name: search_parenthetical_describing_opinion_id_07864494; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_parenthetical_describing_opinion_id_07864494 ON public.search_parenthetical USING btree (describing_opinion_id);


--
-- Name: search_parenthetical_group_id_00a7def3; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_parenthetical_group_id_00a7def3 ON public.search_parenthetical USING btree (group_id);


--
-- Name: search_parenthetical_score_cab0b2a1; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_parenthetical_score_cab0b2a1 ON public.search_parenthetical USING btree (score);


--
-- Name: search_parentheticalgroup_opinion_id_fd6bb935; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_parentheticalgroup_opinion_id_fd6bb935 ON public.search_parentheticalgroup USING btree (opinion_id);


--
-- Name: search_parentheticalgroup_representative_id_00e5a857; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_parentheticalgroup_representative_id_00e5a857 ON public.search_parentheticalgroup USING btree (representative_id);


--
-- Name: search_recapdocument_1dec38a6; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_recapdocument_1dec38a6 ON public.search_recapdocument USING btree (is_free_on_pacer);


--
-- Name: search_recapdocument_40d913b2; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_recapdocument_40d913b2 ON public.search_recapdocument USING btree (docket_entry_id);


--
-- Name: search_recapdocument_5fdb3d66; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_recapdocument_5fdb3d66 ON public.search_recapdocument USING btree (date_modified);


--
-- Name: search_recapdocument_c69e55a4; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_recapdocument_c69e55a4 ON public.search_recapdocument USING btree (date_created);


--
-- Name: search_recapdocument_document_number_6f825e81ddd11fde_uniq; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_recapdocument_document_number_6f825e81ddd11fde_uniq ON public.search_recapdocument USING btree (document_number);


--
-- Name: search_recapdocument_document_type_303cccac79571217_idx; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_recapdocument_document_type_303cccac79571217_idx ON public.search_recapdocument USING btree (document_type, document_number, attachment_number);


--
-- Name: search_recapdocument_filepath_local_7dc6b0e53ccf753_uniq; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_recapdocument_filepath_local_7dc6b0e53ccf753_uniq ON public.search_recapdocument USING btree (filepath_local);


--
-- Name: search_recapdocument_pacer_doc_id_12ec9c122839e6aa_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_recapdocument_pacer_doc_id_12ec9c122839e6aa_like ON public.search_recapdocument USING btree (pacer_doc_id varchar_pattern_ops);


--
-- Name: search_recapdocument_tags_76f094bc; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_recapdocument_tags_76f094bc ON public.search_recapdocument_tags USING btree (tag_id);


--
-- Name: search_recapdocument_tags_fae26ff6; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_recapdocument_tags_fae26ff6 ON public.search_recapdocument_tags USING btree (recapdocument_id);


--
-- Name: search_tag_5fdb3d66; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_tag_5fdb3d66 ON public.search_tag USING btree (date_modified);


--
-- Name: search_tag_c69e55a4; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_tag_c69e55a4 ON public.search_tag USING btree (date_created);


--
-- Name: search_tag_name_30c16b352387258b_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX search_tag_name_30c16b352387258b_like ON public.search_tag USING btree (name varchar_pattern_ops);


--
-- Name: search_docket a2a62b7d002101ae4c4663cdd1dfc075; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_docket
    ADD CONSTRAINT a2a62b7d002101ae4c4663cdd1dfc075 FOREIGN KEY (originating_court_information_id) REFERENCES public.search_originatingcourtinformation(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: audio_audio audio_audio_docket_id_625f3642919f8934_fk_search_docket_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.audio_audio
    ADD CONSTRAINT audio_audio_docket_id_625f3642919f8934_fk_search_docket_id FOREIGN KEY (docket_id) REFERENCES public.search_docket(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: audio_audio_panel audio_audio_pa_person_id_afbf0404cefafcc_fk_people_db_person_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.audio_audio_panel
    ADD CONSTRAINT audio_audio_pa_person_id_afbf0404cefafcc_fk_people_db_person_id FOREIGN KEY (person_id) REFERENCES public.people_db_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: audio_audio_panel audio_audio_panel_audio_id_536de9ffa9ea04fa_fk_audio_audio_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.audio_audio_panel
    ADD CONSTRAINT audio_audio_panel_audio_id_536de9ffa9ea04fa_fk_audio_audio_id FOREIGN KEY (audio_id) REFERENCES public.audio_audio(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: people_db_attorneyorganizationassociation ef7a9c8bc08ab662925cfaa332ca9777; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_attorneyorganizationassociation
    ADD CONSTRAINT ef7a9c8bc08ab662925cfaa332ca9777 FOREIGN KEY (attorney_organization_id) REFERENCES public.people_db_attorneyorganization(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_opinioncluster_non_participating_judges opinioncluster_id_3d4a71240680b64c_fk_search_opinioncluster_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_opinioncluster_non_participating_judges
    ADD CONSTRAINT opinioncluster_id_3d4a71240680b64c_fk_search_opinioncluster_id FOREIGN KEY (opinioncluster_id) REFERENCES public.search_opinioncluster(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_opinioncluster_panel opinioncluster_id_7cdb36cb8a6ff7a7_fk_search_opinioncluster_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_opinioncluster_panel
    ADD CONSTRAINT opinioncluster_id_7cdb36cb8a6ff7a7_fk_search_opinioncluster_id FOREIGN KEY (opinioncluster_id) REFERENCES public.search_opinioncluster(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: people_db_position people_d_appointer_id_7c550f3cea4ba6cd_fk_people_db_position_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_position
    ADD CONSTRAINT people_d_appointer_id_7c550f3cea4ba6cd_fk_people_db_position_id FOREIGN KEY (appointer_id) REFERENCES public.people_db_position(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: people_db_school people_d_is_alias_of_id_331b4e3cdac3b6f9_fk_people_db_school_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_school
    ADD CONSTRAINT people_d_is_alias_of_id_331b4e3cdac3b6f9_fk_people_db_school_id FOREIGN KEY (is_alias_of_id) REFERENCES public.people_db_school(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: people_db_person people_d_is_alias_of_id_53a6eb8a5fb97b64_fk_people_db_person_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_person
    ADD CONSTRAINT people_d_is_alias_of_id_53a6eb8a5fb97b64_fk_people_db_person_id FOREIGN KEY (is_alias_of_id) REFERENCES public.people_db_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: people_db_position people_d_predecessor_id_36032dfa6a12d44c_fk_people_db_person_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_position
    ADD CONSTRAINT people_d_predecessor_id_36032dfa6a12d44c_fk_people_db_person_id FOREIGN KEY (predecessor_id) REFERENCES public.people_db_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: people_db_attorneyorganizationassociation people_db__attorney_id_1f7b59b220e86ae_fk_people_db_attorney_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_attorneyorganizationassociation
    ADD CONSTRAINT people_db__attorney_id_1f7b59b220e86ae_fk_people_db_attorney_id FOREIGN KEY (attorney_id) REFERENCES public.people_db_attorney(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: people_db_role people_db__attorney_id_1fd94ceb4f0ff93_fk_people_db_attorney_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_role
    ADD CONSTRAINT people_db__attorney_id_1fd94ceb4f0ff93_fk_people_db_attorney_id FOREIGN KEY (attorney_id) REFERENCES public.people_db_attorney(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: people_db_abarating people_db_aba_person_id_79eb41c300a4a376_fk_people_db_person_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_abarating
    ADD CONSTRAINT people_db_aba_person_id_79eb41c300a4a376_fk_people_db_person_id FOREIGN KEY (person_id) REFERENCES public.people_db_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: people_db_attorneyorganizationassociation people_db_attorn_docket_id_50e2b6b752e16618_fk_search_docket_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_attorneyorganizationassociation
    ADD CONSTRAINT people_db_attorn_docket_id_50e2b6b752e16618_fk_search_docket_id FOREIGN KEY (docket_id) REFERENCES public.search_docket(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: people_db_education people_db_edu_person_id_688c3a0acdae53a1_fk_people_db_person_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_education
    ADD CONSTRAINT people_db_edu_person_id_688c3a0acdae53a1_fk_people_db_person_id FOREIGN KEY (person_id) REFERENCES public.people_db_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: people_db_education people_db_edu_school_id_33cc463e2249bc4a_fk_people_db_school_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_education
    ADD CONSTRAINT people_db_edu_school_id_33cc463e2249bc4a_fk_people_db_school_id FOREIGN KEY (school_id) REFERENCES public.people_db_school(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: people_db_partytype people_db_party_party_id_1a614faa135be115_fk_people_db_party_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_partytype
    ADD CONSTRAINT people_db_party_party_id_1a614faa135be115_fk_people_db_party_id FOREIGN KEY (party_id) REFERENCES public.people_db_party(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: people_db_partytype people_db_partyt_docket_id_30c09cafa20f361a_fk_search_docket_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_partytype
    ADD CONSTRAINT people_db_partyt_docket_id_30c09cafa20f361a_fk_search_docket_id FOREIGN KEY (docket_id) REFERENCES public.search_docket(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: people_db_person_race people_db_per_person_id_2483201f22b91c44_fk_people_db_person_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_person_race
    ADD CONSTRAINT people_db_per_person_id_2483201f22b91c44_fk_people_db_person_id FOREIGN KEY (person_id) REFERENCES public.people_db_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: people_db_person_race people_db_person__race_id_12bc59b989c779ea_fk_people_db_race_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_person_race
    ADD CONSTRAINT people_db_person__race_id_12bc59b989c779ea_fk_people_db_race_id FOREIGN KEY (race_id) REFERENCES public.people_db_race(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: people_db_politicalaffiliation people_db_pol_person_id_7bca4351a3adeccb_fk_people_db_person_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_politicalaffiliation
    ADD CONSTRAINT people_db_pol_person_id_7bca4351a3adeccb_fk_people_db_person_id FOREIGN KEY (person_id) REFERENCES public.people_db_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: people_db_position people_db_pos_person_id_796c042ecbe82b71_fk_people_db_person_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_position
    ADD CONSTRAINT people_db_pos_person_id_796c042ecbe82b71_fk_people_db_person_id FOREIGN KEY (person_id) REFERENCES public.people_db_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: people_db_position people_db_pos_school_id_3cd91cb4ec26941a_fk_people_db_school_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_position
    ADD CONSTRAINT people_db_pos_school_id_3cd91cb4ec26941a_fk_people_db_school_id FOREIGN KEY (school_id) REFERENCES public.people_db_school(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: people_db_position people_db_position_court_id_7141eee9b516a894_fk_search_court_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_position
    ADD CONSTRAINT people_db_position_court_id_7141eee9b516a894_fk_search_court_id FOREIGN KEY (court_id) REFERENCES public.search_court(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: people_db_retentionevent people_db_position_id_7aa450ceb6309890_fk_people_db_position_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_retentionevent
    ADD CONSTRAINT people_db_position_id_7aa450ceb6309890_fk_people_db_position_id FOREIGN KEY (position_id) REFERENCES public.people_db_position(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: people_db_role people_db_role_docket_id_43aa88e5be806103_fk_search_docket_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_role
    ADD CONSTRAINT people_db_role_docket_id_43aa88e5be806103_fk_search_docket_id FOREIGN KEY (docket_id) REFERENCES public.search_docket(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: people_db_role people_db_role_party_id_cc149ce69f8a224_fk_people_db_party_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_role
    ADD CONSTRAINT people_db_role_party_id_cc149ce69f8a224_fk_people_db_party_id FOREIGN KEY (party_id) REFERENCES public.people_db_party(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: people_db_source people_db_sou_person_id_547e18a17ea79ec1_fk_people_db_person_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_source
    ADD CONSTRAINT people_db_sou_person_id_547e18a17ea79ec1_fk_people_db_person_id FOREIGN KEY (person_id) REFERENCES public.people_db_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: people_db_position people_db_supervisor_id_5e670092b0c8d684_fk_people_db_person_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_position
    ADD CONSTRAINT people_db_supervisor_id_5e670092b0c8d684_fk_people_db_person_id FOREIGN KEY (supervisor_id) REFERENCES public.people_db_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: people_db_criminalcount people_party_type_id_3cd2208b7ab7f97f_fk_people_db_partytype_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_criminalcount
    ADD CONSTRAINT people_party_type_id_3cd2208b7ab7f97f_fk_people_db_partytype_id FOREIGN KEY (party_type_id) REFERENCES public.people_db_partytype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: people_db_criminalcomplaint people_party_type_id_54695b07d9d95d41_fk_people_db_partytype_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.people_db_criminalcomplaint
    ADD CONSTRAINT people_party_type_id_54695b07d9d95d41_fk_people_db_partytype_id FOREIGN KEY (party_type_id) REFERENCES public.people_db_partytype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_docket s_idb_data_id_7696e442c56d310_fk_recap_fjcintegrateddatabase_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_docket
    ADD CONSTRAINT s_idb_data_id_7696e442c56d310_fk_recap_fjcintegrateddatabase_id FOREIGN KEY (idb_data_id) REFERENCES public.recap_fjcintegrateddatabase(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_recapdocument_tags se_recapdocument_id_3a0831353b326f45_fk_search_recapdocument_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_recapdocument_tags
    ADD CONSTRAINT se_recapdocument_id_3a0831353b326f45_fk_search_recapdocument_id FOREIGN KEY (recapdocument_id) REFERENCES public.search_recapdocument(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_recapdocument searc_docket_entry_id_186f592b9e384e1e_fk_search_docketentry_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_recapdocument
    ADD CONSTRAINT searc_docket_entry_id_186f592b9e384e1e_fk_search_docketentry_id FOREIGN KEY (docket_entry_id) REFERENCES public.search_docketentry(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_originatingcourtinformation searc_ordering_judge_id_143dbe040e3c8895_fk_people_db_person_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_originatingcourtinformation
    ADD CONSTRAINT searc_ordering_judge_id_143dbe040e3c8895_fk_people_db_person_id FOREIGN KEY (ordering_judge_id) REFERENCES public.people_db_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_opinionscited search__citing_opinion_id_3b336c39ca8491ca_fk_search_opinion_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_opinionscited
    ADD CONSTRAINT search__citing_opinion_id_3b336c39ca8491ca_fk_search_opinion_id FOREIGN KEY (citing_opinion_id) REFERENCES public.search_opinion(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_opinion search__cluster_id_48646dd68699f5d6_fk_search_opinioncluster_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_opinion
    ADD CONSTRAINT search__cluster_id_48646dd68699f5d6_fk_search_opinioncluster_id FOREIGN KEY (cluster_id) REFERENCES public.search_opinioncluster(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_bankruptcyinformation search_bankruptcyinf_docket_id_91fa3275_fk_search_do; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_bankruptcyinformation
    ADD CONSTRAINT search_bankruptcyinf_docket_id_91fa3275_fk_search_do FOREIGN KEY (docket_id) REFERENCES public.search_docket(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_citation search_c_cluster_id_c4f8720fbbbd050_fk_search_opinioncluster_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_citation
    ADD CONSTRAINT search_c_cluster_id_c4f8720fbbbd050_fk_search_opinioncluster_id FOREIGN KEY (cluster_id) REFERENCES public.search_opinioncluster(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_claim search_claim_docket_id_b37171a9_fk_search_docket_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_claim
    ADD CONSTRAINT search_claim_docket_id_b37171a9_fk_search_docket_id FOREIGN KEY (docket_id) REFERENCES public.search_docket(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_claim_tags search_claim_tags_claim_id_2cf554b5_fk_search_claim_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_claim_tags
    ADD CONSTRAINT search_claim_tags_claim_id_2cf554b5_fk_search_claim_id FOREIGN KEY (claim_id) REFERENCES public.search_claim(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_claim_tags search_claim_tags_tag_id_73b6bd4d_fk_search_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_claim_tags
    ADD CONSTRAINT search_claim_tags_tag_id_73b6bd4d_fk_search_tag_id FOREIGN KEY (tag_id) REFERENCES public.search_tag(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_claimhistory search_claimhistory_claim_id_e130e572_fk_search_claim_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_claimhistory
    ADD CONSTRAINT search_claimhistory_claim_id_e130e572_fk_search_claim_id FOREIGN KEY (claim_id) REFERENCES public.search_claim(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_docket search_d_referred_to_id_7dfd6952e8d18b8c_fk_people_db_person_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_docket
    ADD CONSTRAINT search_d_referred_to_id_7dfd6952e8d18b8c_fk_people_db_person_id FOREIGN KEY (referred_to_id) REFERENCES public.people_db_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_docket search_do_assigned_to_id_185a002e3102ceb_fk_people_db_person_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_docket
    ADD CONSTRAINT search_do_assigned_to_id_185a002e3102ceb_fk_people_db_person_id FOREIGN KEY (assigned_to_id) REFERENCES public.people_db_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_docket search_docke_appeal_from_id_71fecce427985eaf_fk_search_court_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_docket
    ADD CONSTRAINT search_docke_appeal_from_id_71fecce427985eaf_fk_search_court_id FOREIGN KEY (appeal_from_id) REFERENCES public.search_court(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_docket_panel search_docket__person_id_a216895387ce4ca_fk_people_db_person_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_docket_panel
    ADD CONSTRAINT search_docket__person_id_a216895387ce4ca_fk_people_db_person_id FOREIGN KEY (person_id) REFERENCES public.people_db_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_docket search_docket_court_id_2d2438b2594e74ba_fk_search_court_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_docket
    ADD CONSTRAINT search_docket_court_id_2d2438b2594e74ba_fk_search_court_id FOREIGN KEY (court_id) REFERENCES public.search_court(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_docket_panel search_docket_pa_docket_id_6c92125a7941d19b_fk_search_docket_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_docket_panel
    ADD CONSTRAINT search_docket_pa_docket_id_6c92125a7941d19b_fk_search_docket_id FOREIGN KEY (docket_id) REFERENCES public.search_docket(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_docket_tags search_docket_ta_docket_id_22afc0b36b1bbca3_fk_search_docket_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_docket_tags
    ADD CONSTRAINT search_docket_ta_docket_id_22afc0b36b1bbca3_fk_search_docket_id FOREIGN KEY (docket_id) REFERENCES public.search_docket(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_docket_tags search_docket_tags_tag_id_2f90416e21d2a5cc_fk_search_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_docket_tags
    ADD CONSTRAINT search_docket_tags_tag_id_2f90416e21d2a5cc_fk_search_tag_id FOREIGN KEY (tag_id) REFERENCES public.search_tag(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_docketentry search_docketentr_docket_id_77c155ebbf826b3_fk_search_docket_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_docketentry
    ADD CONSTRAINT search_docketentr_docket_id_77c155ebbf826b3_fk_search_docket_id FOREIGN KEY (docket_id) REFERENCES public.search_docket(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_docketentry_tags search_docketentry_id_48bcebf60f001801_fk_search_docketentry_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_docketentry_tags
    ADD CONSTRAINT search_docketentry_id_48bcebf60f001801_fk_search_docketentry_id FOREIGN KEY (docketentry_id) REFERENCES public.search_docketentry(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_docketentry_tags search_docketentry_tag_tag_id_6d9cf14285cf89c9_fk_search_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_docketentry_tags
    ADD CONSTRAINT search_docketentry_tag_tag_id_6d9cf14285cf89c9_fk_search_tag_id FOREIGN KEY (tag_id) REFERENCES public.search_tag(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_originatingcourtinformation search_o_assigned_to_id_1cc909cf580febcc_fk_people_db_person_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_originatingcourtinformation
    ADD CONSTRAINT search_o_assigned_to_id_1cc909cf580febcc_fk_people_db_person_id FOREIGN KEY (assigned_to_id) REFERENCES public.people_db_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_opinionscited search_op_cited_opinion_id_69ef5d07ce27b76_fk_search_opinion_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_opinionscited
    ADD CONSTRAINT search_op_cited_opinion_id_69ef5d07ce27b76_fk_search_opinion_id FOREIGN KEY (cited_opinion_id) REFERENCES public.search_opinion(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_opinioncluster_non_participating_judges search_opinio_person_id_5b0da1008e3e4e3b_fk_people_db_person_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_opinioncluster_non_participating_judges
    ADD CONSTRAINT search_opinio_person_id_5b0da1008e3e4e3b_fk_people_db_person_id FOREIGN KEY (person_id) REFERENCES public.people_db_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_opinion_joined_by search_opinio_person_id_5e482e9ee34284bc_fk_people_db_person_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_opinion_joined_by
    ADD CONSTRAINT search_opinio_person_id_5e482e9ee34284bc_fk_people_db_person_id FOREIGN KEY (person_id) REFERENCES public.people_db_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_opinioncluster_panel search_opinio_person_id_70c55c02599cc568_fk_people_db_person_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_opinioncluster_panel
    ADD CONSTRAINT search_opinio_person_id_70c55c02599cc568_fk_people_db_person_id FOREIGN KEY (person_id) REFERENCES public.people_db_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_opinion_joined_by search_opinion__opinion_id_d92788377db9348_fk_search_opinion_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_opinion_joined_by
    ADD CONSTRAINT search_opinion__opinion_id_d92788377db9348_fk_search_opinion_id FOREIGN KEY (opinion_id) REFERENCES public.search_opinion(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_opinion search_opinion_author_id_a44f4b76b64d99c_fk_people_db_person_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_opinion
    ADD CONSTRAINT search_opinion_author_id_a44f4b76b64d99c_fk_people_db_person_id FOREIGN KEY (author_id) REFERENCES public.people_db_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_opinioncluster search_opinioncl_docket_id_14b37923614c0da0_fk_search_docket_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_opinioncluster
    ADD CONSTRAINT search_opinioncl_docket_id_14b37923614c0da0_fk_search_docket_id FOREIGN KEY (docket_id) REFERENCES public.search_docket(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_parenthetical search_parenthetical_described_opinion_id_ddd408db_fk_search_op; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_parenthetical
    ADD CONSTRAINT search_parenthetical_described_opinion_id_ddd408db_fk_search_op FOREIGN KEY (described_opinion_id) REFERENCES public.search_opinion(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_parenthetical search_parenthetical_describing_opinion_i_07864494_fk_search_op; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_parenthetical
    ADD CONSTRAINT search_parenthetical_describing_opinion_i_07864494_fk_search_op FOREIGN KEY (describing_opinion_id) REFERENCES public.search_opinion(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_parenthetical search_parenthetical_group_id_00a7def3_fk_search_pa; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_parenthetical
    ADD CONSTRAINT search_parenthetical_group_id_00a7def3_fk_search_pa FOREIGN KEY (group_id) REFERENCES public.search_parentheticalgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_parentheticalgroup search_parenthetical_opinion_id_fd6bb935_fk_search_op; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_parentheticalgroup
    ADD CONSTRAINT search_parenthetical_opinion_id_fd6bb935_fk_search_op FOREIGN KEY (opinion_id) REFERENCES public.search_opinion(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_parentheticalgroup search_parenthetical_representative_id_00e5a857_fk_search_pa; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_parentheticalgroup
    ADD CONSTRAINT search_parenthetical_representative_id_00e5a857_fk_search_pa FOREIGN KEY (representative_id) REFERENCES public.search_parenthetical(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: search_recapdocument_tags search_recapdocument_t_tag_id_1a152aa24561fa85_fk_search_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.search_recapdocument_tags
    ADD CONSTRAINT search_recapdocument_t_tag_id_1a152aa24561fa85_fk_search_tag_id FOREIGN KEY (tag_id) REFERENCES public.search_tag(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

