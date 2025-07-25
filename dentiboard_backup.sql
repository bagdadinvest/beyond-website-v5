--
-- PostgreSQL database dump
--

-- Dumped from database version 15.12 (Ubuntu 15.12-1.pgdg20.04+1)
-- Dumped by pg_dump version 15.12 (Ubuntu 15.12-1.pgdg20.04+1)

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: account_emailaddress; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_emailaddress (
    id bigint NOT NULL,
    verified boolean,
    "primary" boolean,
    user_id bigint,
    email text
);


ALTER TABLE public.account_emailaddress OWNER TO postgres;

--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_emailaddress_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_emailaddress_id_seq OWNER TO postgres;

--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_emailaddress_id_seq OWNED BY public.account_emailaddress.id;


--
-- Name: account_emailconfirmation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_emailconfirmation (
    id bigint NOT NULL,
    created timestamp with time zone,
    sent timestamp with time zone,
    key text,
    email_address_id bigint
);


ALTER TABLE public.account_emailconfirmation OWNER TO postgres;

--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_emailconfirmation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_emailconfirmation_id_seq OWNER TO postgres;

--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_emailconfirmation_id_seq OWNED BY public.account_emailconfirmation.id;


--
-- Name: actstream_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.actstream_action (
    id bigint NOT NULL,
    actor_object_id text,
    verb text,
    description text,
    target_object_id text,
    action_object_object_id text,
    "timestamp" timestamp with time zone,
    public boolean,
    action_object_content_type_id bigint,
    actor_content_type_id bigint,
    target_content_type_id bigint
);


ALTER TABLE public.actstream_action OWNER TO postgres;

--
-- Name: actstream_action_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.actstream_action_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.actstream_action_id_seq OWNER TO postgres;

--
-- Name: actstream_action_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.actstream_action_id_seq OWNED BY public.actstream_action.id;


--
-- Name: actstream_follow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.actstream_follow (
    id bigint NOT NULL,
    object_id text,
    actor_only boolean,
    started timestamp with time zone,
    content_type_id bigint,
    user_id bigint,
    flag text
);


ALTER TABLE public.actstream_follow OWNER TO postgres;

--
-- Name: actstream_follow_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.actstream_follow_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.actstream_follow_id_seq OWNER TO postgres;

--
-- Name: actstream_follow_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.actstream_follow_id_seq OWNED BY public.actstream_follow.id;


--
-- Name: apps_accommodation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apps_accommodation (
    id bigint NOT NULL,
    treatment_plan_id bigint,
    user_id bigint,
    duration_of_stay integer,
    hotel_id bigint
);


ALTER TABLE public.apps_accommodation OWNER TO postgres;

--
-- Name: apps_accommodation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.apps_accommodation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.apps_accommodation_id_seq OWNER TO postgres;

--
-- Name: apps_accommodation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.apps_accommodation_id_seq OWNED BY public.apps_accommodation.id;


--
-- Name: apps_appointment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apps_appointment (
    id bigint NOT NULL,
    date timestamp with time zone,
    duration bigint,
    doctor_id bigint,
    patient_id bigint
);


ALTER TABLE public.apps_appointment OWNER TO postgres;

--
-- Name: apps_appointment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.apps_appointment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.apps_appointment_id_seq OWNER TO postgres;

--
-- Name: apps_appointment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.apps_appointment_id_seq OWNED BY public.apps_appointment.id;


--
-- Name: apps_contact; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apps_contact (
    id bigint NOT NULL,
    first_name text,
    last_name text,
    email text,
    message text
);


ALTER TABLE public.apps_contact OWNER TO postgres;

--
-- Name: apps_contact_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.apps_contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.apps_contact_id_seq OWNER TO postgres;

--
-- Name: apps_contact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.apps_contact_id_seq OWNED BY public.apps_contact.id;


--
-- Name: apps_emailtemplate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apps_emailtemplate (
    id bigint NOT NULL,
    name text,
    subject text,
    body text
);


ALTER TABLE public.apps_emailtemplate OWNER TO postgres;

--
-- Name: apps_emailtemplate_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.apps_emailtemplate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.apps_emailtemplate_id_seq OWNER TO postgres;

--
-- Name: apps_emailtemplate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.apps_emailtemplate_id_seq OWNED BY public.apps_emailtemplate.id;


--
-- Name: apps_emergencycontact; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apps_emergencycontact (
    id bigint NOT NULL,
    first_name text,
    last_name text,
    phone_number text,
    relationship text
);


ALTER TABLE public.apps_emergencycontact OWNER TO postgres;

--
-- Name: apps_emergencycontact_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.apps_emergencycontact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.apps_emergencycontact_id_seq OWNER TO postgres;

--
-- Name: apps_emergencycontact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.apps_emergencycontact_id_seq OWNED BY public.apps_emergencycontact.id;


--
-- Name: apps_flightreservation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apps_flightreservation (
    id bigint NOT NULL,
    arrival_date date,
    arrival_hour time without time zone,
    arrival_flight_number text,
    departure_date date,
    departure_hour time without time zone,
    departure_flight_number text,
    user_id bigint
);


ALTER TABLE public.apps_flightreservation OWNER TO postgres;

--
-- Name: apps_flightreservation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.apps_flightreservation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.apps_flightreservation_id_seq OWNER TO postgres;

--
-- Name: apps_flightreservation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.apps_flightreservation_id_seq OWNED BY public.apps_flightreservation.id;


--
-- Name: apps_homepage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apps_homepage (
    page_ptr_id bigint NOT NULL,
    intro text
);


ALTER TABLE public.apps_homepage OWNER TO postgres;

--
-- Name: apps_hospital; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apps_hospital (
    id bigint NOT NULL,
    name text,
    address text,
    city text,
    state text,
    zipcode text
);


ALTER TABLE public.apps_hospital OWNER TO postgres;

--
-- Name: apps_hospital_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.apps_hospital_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.apps_hospital_id_seq OWNER TO postgres;

--
-- Name: apps_hospital_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.apps_hospital_id_seq OWNED BY public.apps_hospital.id;


--
-- Name: apps_hospitalstay; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apps_hospitalstay (
    id bigint NOT NULL,
    admission timestamp with time zone,
    discharge timestamp with time zone,
    hospital_id bigint,
    patient_id bigint
);


ALTER TABLE public.apps_hospitalstay OWNER TO postgres;

--
-- Name: apps_hospitalstay_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.apps_hospitalstay_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.apps_hospitalstay_id_seq OWNER TO postgres;

--
-- Name: apps_hospitalstay_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.apps_hospitalstay_id_seq OWNED BY public.apps_hospitalstay.id;


--
-- Name: apps_hotel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apps_hotel (
    id bigint NOT NULL,
    name text,
    address text,
    room_type text,
    price_per_night numeric,
    amenities text,
    availability boolean,
    rating real
);


ALTER TABLE public.apps_hotel OWNER TO postgres;

--
-- Name: apps_hotel_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.apps_hotel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.apps_hotel_id_seq OWNER TO postgres;

--
-- Name: apps_hotel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.apps_hotel_id_seq OWNED BY public.apps_hotel.id;


--
-- Name: apps_insurance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apps_insurance (
    id bigint NOT NULL,
    policy_number text,
    company text
);


ALTER TABLE public.apps_insurance OWNER TO postgres;

--
-- Name: apps_insurance_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.apps_insurance_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.apps_insurance_id_seq OWNER TO postgres;

--
-- Name: apps_insurance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.apps_insurance_id_seq OWNED BY public.apps_insurance.id;


--
-- Name: apps_medicalfile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apps_medicalfile (
    id bigint NOT NULL,
    file text,
    upload_timestamp timestamp with time zone,
    medical_information_id bigint,
    user_id bigint
);


ALTER TABLE public.apps_medicalfile OWNER TO postgres;

--
-- Name: apps_medicalfile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.apps_medicalfile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.apps_medicalfile_id_seq OWNER TO postgres;

--
-- Name: apps_medicalfile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.apps_medicalfile_id_seq OWNED BY public.apps_medicalfile.id;


--
-- Name: apps_medicalinformation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apps_medicalinformation (
    id bigint NOT NULL,
    medications text,
    allergies text,
    medical_conditions text,
    family_history text,
    additional_info text,
    insurance_id bigint,
    sex text
);


ALTER TABLE public.apps_medicalinformation OWNER TO postgres;

--
-- Name: apps_medicalinformation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.apps_medicalinformation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.apps_medicalinformation_id_seq OWNER TO postgres;

--
-- Name: apps_medicalinformation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.apps_medicalinformation_id_seq OWNED BY public.apps_medicalinformation.id;


--
-- Name: apps_message; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apps_message (
    id bigint NOT NULL,
    body text,
    date timestamp with time zone,
    group_id bigint,
    sender_id bigint
);


ALTER TABLE public.apps_message OWNER TO postgres;

--
-- Name: apps_message_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.apps_message_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.apps_message_id_seq OWNER TO postgres;

--
-- Name: apps_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.apps_message_id_seq OWNED BY public.apps_message.id;


--
-- Name: apps_message_read_members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apps_message_read_members (
    id bigint NOT NULL,
    message_id bigint,
    user_id bigint
);


ALTER TABLE public.apps_message_read_members OWNER TO postgres;

--
-- Name: apps_message_read_members_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.apps_message_read_members_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.apps_message_read_members_id_seq OWNER TO postgres;

--
-- Name: apps_message_read_members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.apps_message_read_members_id_seq OWNED BY public.apps_message_read_members.id;


--
-- Name: apps_messagegroup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apps_messagegroup (
    id bigint NOT NULL,
    name text
);


ALTER TABLE public.apps_messagegroup OWNER TO postgres;

--
-- Name: apps_messagegroup_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.apps_messagegroup_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.apps_messagegroup_id_seq OWNER TO postgres;

--
-- Name: apps_messagegroup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.apps_messagegroup_id_seq OWNED BY public.apps_messagegroup.id;


--
-- Name: apps_messagegroup_members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apps_messagegroup_members (
    id bigint NOT NULL,
    messagegroup_id bigint,
    user_id bigint
);


ALTER TABLE public.apps_messagegroup_members OWNER TO postgres;

--
-- Name: apps_messagegroup_members_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.apps_messagegroup_members_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.apps_messagegroup_members_id_seq OWNER TO postgres;

--
-- Name: apps_messagegroup_members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.apps_messagegroup_members_id_seq OWNED BY public.apps_messagegroup_members.id;


--
-- Name: apps_patientschedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apps_patientschedule (
    id bigint NOT NULL,
    notes text,
    accommodation_id bigint,
    appointment_id bigint,
    flight_reservation_id bigint,
    hospital_id bigint,
    user_id bigint
);


ALTER TABLE public.apps_patientschedule OWNER TO postgres;

--
-- Name: apps_patientschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.apps_patientschedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.apps_patientschedule_id_seq OWNER TO postgres;

--
-- Name: apps_patientschedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.apps_patientschedule_id_seq OWNED BY public.apps_patientschedule.id;


--
-- Name: apps_prescription; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apps_prescription (
    id bigint NOT NULL,
    name text,
    dosage text,
    directions text,
    prescribed timestamp with time zone,
    active boolean,
    patient_id bigint
);


ALTER TABLE public.apps_prescription OWNER TO postgres;

--
-- Name: apps_prescription_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.apps_prescription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.apps_prescription_id_seq OWNER TO postgres;

--
-- Name: apps_prescription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.apps_prescription_id_seq OWNED BY public.apps_prescription.id;


--
-- Name: apps_referral; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apps_referral (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    referrer_id bigint,
    referred_id bigint,
    code text
);


ALTER TABLE public.apps_referral OWNER TO postgres;

--
-- Name: apps_referral_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.apps_referral_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.apps_referral_id_seq OWNER TO postgres;

--
-- Name: apps_referral_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.apps_referral_id_seq OWNED BY public.apps_referral.id;


--
-- Name: apps_subscription; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apps_subscription (
    id bigint NOT NULL,
    email text
);


ALTER TABLE public.apps_subscription OWNER TO postgres;

--
-- Name: apps_subscription_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.apps_subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.apps_subscription_id_seq OWNER TO postgres;

--
-- Name: apps_subscription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.apps_subscription_id_seq OWNED BY public.apps_subscription.id;


--
-- Name: apps_treatmentplan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apps_treatmentplan (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    doctor_id bigint,
    patient_id bigint,
    total_price numeric,
    final_discount_percentage numeric,
    subtotal numeric,
    discount_amount numeric
);


ALTER TABLE public.apps_treatmentplan OWNER TO postgres;

--
-- Name: apps_treatmentplan_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.apps_treatmentplan_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.apps_treatmentplan_id_seq OWNER TO postgres;

--
-- Name: apps_treatmentplan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.apps_treatmentplan_id_seq OWNED BY public.apps_treatmentplan.id;


--
-- Name: apps_treatmentplanitem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apps_treatmentplanitem (
    id bigint NOT NULL,
    quantity integer,
    treatment_plan_id bigint,
    product_id bigint,
    discount_percentage numeric
);


ALTER TABLE public.apps_treatmentplanitem OWNER TO postgres;

--
-- Name: apps_treatmentplanitem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.apps_treatmentplanitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.apps_treatmentplanitem_id_seq OWNER TO postgres;

--
-- Name: apps_treatmentplanitem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.apps_treatmentplanitem_id_seq OWNED BY public.apps_treatmentplanitem.id;


--
-- Name: apps_treatmentproduct; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apps_treatmentproduct (
    id bigint NOT NULL,
    name text,
    slug text,
    category text,
    description text,
    price numeric,
    is_active boolean,
    image text,
    max_discount_percentage numeric
);


ALTER TABLE public.apps_treatmentproduct OWNER TO postgres;

--
-- Name: apps_treatmentproduct_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.apps_treatmentproduct_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.apps_treatmentproduct_id_seq OWNER TO postgres;

--
-- Name: apps_treatmentproduct_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.apps_treatmentproduct_id_seq OWNED BY public.apps_treatmentproduct.id;


--
-- Name: apps_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apps_user (
    id bigint NOT NULL,
    password text,
    last_login timestamp with time zone,
    is_superuser boolean,
    username text,
    first_name text,
    last_name text,
    email text,
    is_staff boolean,
    is_active boolean,
    date_joined timestamp with time zone,
    phone_number text,
    thumbnail text,
    emergency_contact_id bigint,
    medical_information_id bigint,
    referral_code text,
    referred_by text,
    thread_id text,
    beyondblog_profileid text,
    is_online boolean,
    last_login_time timestamp with time zone,
    last_logout_time timestamp with time zone,
    nationality text,
    date_of_birth date
);


ALTER TABLE public.apps_user OWNER TO postgres;

--
-- Name: apps_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apps_user_groups (
    id bigint NOT NULL,
    user_id bigint,
    group_id bigint
);


ALTER TABLE public.apps_user_groups OWNER TO postgres;

--
-- Name: apps_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.apps_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.apps_user_groups_id_seq OWNER TO postgres;

--
-- Name: apps_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.apps_user_groups_id_seq OWNED BY public.apps_user_groups.id;


--
-- Name: apps_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.apps_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.apps_user_id_seq OWNER TO postgres;

--
-- Name: apps_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.apps_user_id_seq OWNED BY public.apps_user.id;


--
-- Name: apps_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apps_user_user_permissions (
    id bigint NOT NULL,
    user_id bigint,
    permission_id bigint
);


ALTER TABLE public.apps_user_user_permissions OWNER TO postgres;

--
-- Name: apps_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.apps_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.apps_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: apps_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.apps_user_user_permissions_id_seq OWNED BY public.apps_user_user_permissions.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id bigint NOT NULL,
    name text
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id bigint,
    permission_id bigint
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id bigint NOT NULL,
    content_type_id bigint,
    codename text,
    name text
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: authtoken_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authtoken_token (
    key character varying(40) NOT NULL,
    created timestamp with time zone NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.authtoken_token OWNER TO postgres;

--
-- Name: baton_batontheme; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.baton_batontheme (
    name text,
    theme text,
    active boolean,
    id bigint NOT NULL
);


ALTER TABLE public.baton_batontheme OWNER TO postgres;

--
-- Name: baton_batontheme_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.baton_batontheme_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.baton_batontheme_id_seq OWNER TO postgres;

--
-- Name: baton_batontheme_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.baton_batontheme_id_seq OWNED BY public.baton_batontheme.id;


--
-- Name: blog_comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.blog_comments (
    id bigint NOT NULL,
    comment_post text,
    date timestamp with time zone,
    author_id bigint,
    commented_image_id bigint
);


ALTER TABLE public.blog_comments OWNER TO postgres;

--
-- Name: blog_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.blog_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blog_comments_id_seq OWNER TO postgres;

--
-- Name: blog_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.blog_comments_id_seq OWNED BY public.blog_comments.id;


--
-- Name: blog_image; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.blog_image (
    id bigint NOT NULL,
    image text,
    image_caption text,
    tag_someone text,
    date timestamp with time zone,
    imageuploader_profile_id bigint
);


ALTER TABLE public.blog_image OWNER TO postgres;

--
-- Name: blog_image_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.blog_image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blog_image_id_seq OWNER TO postgres;

--
-- Name: blog_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.blog_image_id_seq OWNED BY public.blog_image.id;


--
-- Name: blog_image_image_likes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.blog_image_image_likes (
    id bigint NOT NULL,
    image_id bigint,
    profile_id bigint
);


ALTER TABLE public.blog_image_image_likes OWNER TO postgres;

--
-- Name: blog_image_image_likes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.blog_image_image_likes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blog_image_image_likes_id_seq OWNER TO postgres;

--
-- Name: blog_image_image_likes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.blog_image_image_likes_id_seq OWNED BY public.blog_image_image_likes.id;


--
-- Name: blog_profile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.blog_profile (
    id bigint NOT NULL,
    first_name text,
    last_name text,
    bio text,
    profile_pic text,
    profile_avatar text,
    date timestamp with time zone,
    beyondblog_profileid text,
    user_id bigint
);


ALTER TABLE public.blog_profile OWNER TO postgres;

--
-- Name: blog_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.blog_profile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blog_profile_id_seq OWNER TO postgres;

--
-- Name: blog_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.blog_profile_id_seq OWNED BY public.blog_profile.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id bigint NOT NULL,
    action_time timestamp with time zone,
    object_id text,
    object_repr text,
    change_message text,
    content_type_id bigint,
    user_id bigint,
    action_flag smallint
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_celery_results_chordcounter; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_celery_results_chordcounter (
    id bigint NOT NULL,
    sub_tasks text,
    count integer,
    group_id text
);


ALTER TABLE public.django_celery_results_chordcounter OWNER TO postgres;

--
-- Name: django_celery_results_chordcounter_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_celery_results_chordcounter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_celery_results_chordcounter_id_seq OWNER TO postgres;

--
-- Name: django_celery_results_chordcounter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_celery_results_chordcounter_id_seq OWNED BY public.django_celery_results_chordcounter.id;


--
-- Name: django_celery_results_groupresult; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_celery_results_groupresult (
    id bigint NOT NULL,
    group_id text,
    date_created timestamp with time zone,
    date_done timestamp with time zone,
    content_type text,
    content_encoding text,
    result text
);


ALTER TABLE public.django_celery_results_groupresult OWNER TO postgres;

--
-- Name: django_celery_results_groupresult_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_celery_results_groupresult_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_celery_results_groupresult_id_seq OWNER TO postgres;

--
-- Name: django_celery_results_groupresult_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_celery_results_groupresult_id_seq OWNED BY public.django_celery_results_groupresult.id;


--
-- Name: django_celery_results_taskresult; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_celery_results_taskresult (
    id bigint NOT NULL,
    task_id text,
    status text,
    content_type text,
    content_encoding text,
    result text,
    date_done timestamp with time zone,
    traceback text,
    meta text,
    task_args text,
    task_kwargs text,
    task_name text,
    date_created timestamp with time zone,
    worker text,
    periodic_task_name text
);


ALTER TABLE public.django_celery_results_taskresult OWNER TO postgres;

--
-- Name: django_celery_results_taskresult_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_celery_results_taskresult_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_celery_results_taskresult_id_seq OWNER TO postgres;

--
-- Name: django_celery_results_taskresult_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_celery_results_taskresult_id_seq OWNED BY public.django_celery_results_taskresult.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id bigint NOT NULL,
    app_label text,
    model text
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app text,
    name text,
    applied timestamp with time zone
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_openai_assistant_openaitask; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_openai_assistant_openaitask (
    assistantid text,
    runid text,
    threadid text,
    status text,
    created_at timestamp with time zone,
    completed_at timestamp with time zone,
    response text,
    completioncall text,
    tools text,
    meta text
);


ALTER TABLE public.django_openai_assistant_openaitask OWNER TO postgres;

--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key text NOT NULL,
    session_data text,
    expire_date timestamp with time zone
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_site (
    id bigint NOT NULL,
    name text,
    domain text
);


ALTER TABLE public.django_site OWNER TO postgres;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_site_id_seq OWNER TO postgres;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_site_id_seq OWNED BY public.django_site.id;


--
-- Name: gram_comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gram_comments (
    id bigint NOT NULL,
    comment_post text,
    date timestamp with time zone,
    author_id bigint,
    commented_image_id bigint
);


ALTER TABLE public.gram_comments OWNER TO postgres;

--
-- Name: gram_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gram_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gram_comments_id_seq OWNER TO postgres;

--
-- Name: gram_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gram_comments_id_seq OWNED BY public.gram_comments.id;


--
-- Name: gram_image; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gram_image (
    id bigint NOT NULL,
    image text,
    image_caption text,
    tag_someone text,
    date timestamp with time zone,
    imageuploader_profile_id bigint
);


ALTER TABLE public.gram_image OWNER TO postgres;

--
-- Name: gram_image_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gram_image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gram_image_id_seq OWNER TO postgres;

--
-- Name: gram_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gram_image_id_seq OWNED BY public.gram_image.id;


--
-- Name: gram_image_image_likes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gram_image_image_likes (
    id bigint NOT NULL,
    image_id bigint,
    profile_id bigint
);


ALTER TABLE public.gram_image_image_likes OWNER TO postgres;

--
-- Name: gram_image_image_likes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gram_image_image_likes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gram_image_image_likes_id_seq OWNER TO postgres;

--
-- Name: gram_image_image_likes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gram_image_image_likes_id_seq OWNED BY public.gram_image_image_likes.id;


--
-- Name: gram_profile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gram_profile (
    id bigint NOT NULL,
    first_name text,
    last_name text,
    bio text,
    profile_pic text,
    profile_avatar text,
    date timestamp with time zone,
    user_id bigint,
    beyondblog_profileid text
);


ALTER TABLE public.gram_profile OWNER TO postgres;

--
-- Name: gram_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gram_profile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gram_profile_id_seq OWNER TO postgres;

--
-- Name: gram_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gram_profile_id_seq OWNED BY public.gram_profile.id;


--
-- Name: jet_django_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jet_django_token (
    id bigint NOT NULL,
    project text,
    token text,
    date_add timestamp with time zone
);


ALTER TABLE public.jet_django_token OWNER TO postgres;

--
-- Name: jet_django_token_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jet_django_token_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jet_django_token_id_seq OWNER TO postgres;

--
-- Name: jet_django_token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jet_django_token_id_seq OWNED BY public.jet_django_token.id;


--
-- Name: leads_lead; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.leads_lead (
    id bigint NOT NULL,
    name character varying(255),
    email character varying(254),
    phone character varying(15),
    source character varying(50),
    message text,
    created_at timestamp with time zone NOT NULL,
    last_updated timestamp with time zone NOT NULL,
    status character varying(50),
    country character varying(2)
);


ALTER TABLE public.leads_lead OWNER TO postgres;

--
-- Name: leads_lead_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.leads_lead ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.leads_lead_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: leads_leadhistory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.leads_leadhistory (
    id bigint NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    action character varying(255),
    lead_id bigint,
    user_id bigint
);


ALTER TABLE public.leads_leadhistory OWNER TO postgres;

--
-- Name: leads_leadhistory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.leads_leadhistory ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.leads_leadhistory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: leads_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.leads_note (
    id bigint NOT NULL,
    content text,
    created_at timestamp with time zone NOT NULL,
    lead_id bigint,
    user_id bigint
);


ALTER TABLE public.leads_note OWNER TO postgres;

--
-- Name: leads_note_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.leads_note ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.leads_note_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: socialaccount_socialaccount; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.socialaccount_socialaccount (
    id bigint NOT NULL,
    provider text,
    uid text,
    last_login timestamp with time zone,
    date_joined timestamp with time zone,
    user_id bigint,
    extra_data text
);


ALTER TABLE public.socialaccount_socialaccount OWNER TO postgres;

--
-- Name: socialaccount_socialaccount_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.socialaccount_socialaccount_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.socialaccount_socialaccount_id_seq OWNER TO postgres;

--
-- Name: socialaccount_socialaccount_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.socialaccount_socialaccount_id_seq OWNED BY public.socialaccount_socialaccount.id;


--
-- Name: socialaccount_socialapp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.socialaccount_socialapp (
    id bigint NOT NULL,
    provider text,
    name text,
    client_id text,
    secret text,
    key text,
    provider_id text,
    settings text
);


ALTER TABLE public.socialaccount_socialapp OWNER TO postgres;

--
-- Name: socialaccount_socialapp_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.socialaccount_socialapp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.socialaccount_socialapp_id_seq OWNER TO postgres;

--
-- Name: socialaccount_socialapp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.socialaccount_socialapp_id_seq OWNED BY public.socialaccount_socialapp.id;


--
-- Name: socialaccount_socialapp_sites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.socialaccount_socialapp_sites (
    id bigint NOT NULL,
    socialapp_id bigint,
    site_id bigint
);


ALTER TABLE public.socialaccount_socialapp_sites OWNER TO postgres;

--
-- Name: socialaccount_socialapp_sites_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.socialaccount_socialapp_sites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.socialaccount_socialapp_sites_id_seq OWNER TO postgres;

--
-- Name: socialaccount_socialapp_sites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.socialaccount_socialapp_sites_id_seq OWNED BY public.socialaccount_socialapp_sites.id;


--
-- Name: socialaccount_socialtoken; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.socialaccount_socialtoken (
    id bigint NOT NULL,
    token text,
    token_secret text,
    expires_at timestamp with time zone,
    account_id bigint,
    app_id bigint
);


ALTER TABLE public.socialaccount_socialtoken OWNER TO postgres;

--
-- Name: socialaccount_socialtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.socialaccount_socialtoken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.socialaccount_socialtoken_id_seq OWNER TO postgres;

--
-- Name: socialaccount_socialtoken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.socialaccount_socialtoken_id_seq OWNED BY public.socialaccount_socialtoken.id;


--
-- Name: taggit_tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.taggit_tag (
    id bigint NOT NULL,
    name text,
    slug text
);


ALTER TABLE public.taggit_tag OWNER TO postgres;

--
-- Name: taggit_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.taggit_tag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.taggit_tag_id_seq OWNER TO postgres;

--
-- Name: taggit_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.taggit_tag_id_seq OWNED BY public.taggit_tag.id;


--
-- Name: taggit_taggeditem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.taggit_taggeditem (
    id bigint NOT NULL,
    object_id bigint,
    content_type_id bigint,
    tag_id bigint
);


ALTER TABLE public.taggit_taggeditem OWNER TO postgres;

--
-- Name: taggit_taggeditem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.taggit_taggeditem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.taggit_taggeditem_id_seq OWNER TO postgres;

--
-- Name: taggit_taggeditem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.taggit_taggeditem_id_seq OWNED BY public.taggit_taggeditem.id;


--
-- Name: wagtailadmin_admin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailadmin_admin (
    id bigint NOT NULL
);


ALTER TABLE public.wagtailadmin_admin OWNER TO postgres;

--
-- Name: wagtailadmin_admin_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wagtailadmin_admin_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailadmin_admin_id_seq OWNER TO postgres;

--
-- Name: wagtailadmin_admin_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wagtailadmin_admin_id_seq OWNED BY public.wagtailadmin_admin.id;


--
-- Name: wagtailadmin_editingsession; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailadmin_editingsession (
    id bigint NOT NULL,
    object_id text,
    last_seen_at timestamp with time zone,
    content_type_id bigint,
    user_id bigint,
    is_editing boolean
);


ALTER TABLE public.wagtailadmin_editingsession OWNER TO postgres;

--
-- Name: wagtailadmin_editingsession_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wagtailadmin_editingsession_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailadmin_editingsession_id_seq OWNER TO postgres;

--
-- Name: wagtailadmin_editingsession_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wagtailadmin_editingsession_id_seq OWNED BY public.wagtailadmin_editingsession.id;


--
-- Name: wagtailcore_collection; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailcore_collection (
    id bigint NOT NULL,
    path text,
    depth integer,
    numchild integer,
    name text
);


ALTER TABLE public.wagtailcore_collection OWNER TO postgres;

--
-- Name: wagtailcore_collection_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wagtailcore_collection_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_collection_id_seq OWNER TO postgres;

--
-- Name: wagtailcore_collection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wagtailcore_collection_id_seq OWNED BY public.wagtailcore_collection.id;


--
-- Name: wagtailcore_collectionviewrestriction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailcore_collectionviewrestriction (
    id bigint NOT NULL,
    restriction_type text,
    password text,
    collection_id bigint
);


ALTER TABLE public.wagtailcore_collectionviewrestriction OWNER TO postgres;

--
-- Name: wagtailcore_collectionviewrestriction_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailcore_collectionviewrestriction_groups (
    id bigint NOT NULL,
    collectionviewrestriction_id bigint,
    group_id bigint
);


ALTER TABLE public.wagtailcore_collectionviewrestriction_groups OWNER TO postgres;

--
-- Name: wagtailcore_collectionviewrestriction_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wagtailcore_collectionviewrestriction_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_collectionviewrestriction_groups_id_seq OWNER TO postgres;

--
-- Name: wagtailcore_collectionviewrestriction_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wagtailcore_collectionviewrestriction_groups_id_seq OWNED BY public.wagtailcore_collectionviewrestriction_groups.id;


--
-- Name: wagtailcore_collectionviewrestriction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wagtailcore_collectionviewrestriction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_collectionviewrestriction_id_seq OWNER TO postgres;

--
-- Name: wagtailcore_collectionviewrestriction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wagtailcore_collectionviewrestriction_id_seq OWNED BY public.wagtailcore_collectionviewrestriction.id;


--
-- Name: wagtailcore_comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailcore_comment (
    id bigint NOT NULL,
    text text,
    contentpath text,
    "position" text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    resolved_at timestamp with time zone,
    page_id bigint,
    resolved_by_id bigint,
    user_id bigint,
    revision_created_id bigint
);


ALTER TABLE public.wagtailcore_comment OWNER TO postgres;

--
-- Name: wagtailcore_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wagtailcore_comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_comment_id_seq OWNER TO postgres;

--
-- Name: wagtailcore_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wagtailcore_comment_id_seq OWNED BY public.wagtailcore_comment.id;


--
-- Name: wagtailcore_commentreply; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailcore_commentreply (
    id bigint NOT NULL,
    text text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    comment_id bigint,
    user_id bigint
);


ALTER TABLE public.wagtailcore_commentreply OWNER TO postgres;

--
-- Name: wagtailcore_commentreply_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wagtailcore_commentreply_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_commentreply_id_seq OWNER TO postgres;

--
-- Name: wagtailcore_commentreply_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wagtailcore_commentreply_id_seq OWNED BY public.wagtailcore_commentreply.id;


--
-- Name: wagtailcore_groupapprovaltask; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailcore_groupapprovaltask (
    task_ptr_id bigint NOT NULL
);


ALTER TABLE public.wagtailcore_groupapprovaltask OWNER TO postgres;

--
-- Name: wagtailcore_groupapprovaltask_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailcore_groupapprovaltask_groups (
    id bigint NOT NULL,
    groupapprovaltask_id bigint,
    group_id bigint
);


ALTER TABLE public.wagtailcore_groupapprovaltask_groups OWNER TO postgres;

--
-- Name: wagtailcore_groupapprovaltask_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wagtailcore_groupapprovaltask_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_groupapprovaltask_groups_id_seq OWNER TO postgres;

--
-- Name: wagtailcore_groupapprovaltask_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wagtailcore_groupapprovaltask_groups_id_seq OWNED BY public.wagtailcore_groupapprovaltask_groups.id;


--
-- Name: wagtailcore_groupcollectionpermission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailcore_groupcollectionpermission (
    id bigint NOT NULL,
    collection_id bigint,
    group_id bigint,
    permission_id bigint
);


ALTER TABLE public.wagtailcore_groupcollectionpermission OWNER TO postgres;

--
-- Name: wagtailcore_groupcollectionpermission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wagtailcore_groupcollectionpermission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_groupcollectionpermission_id_seq OWNER TO postgres;

--
-- Name: wagtailcore_groupcollectionpermission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wagtailcore_groupcollectionpermission_id_seq OWNED BY public.wagtailcore_groupcollectionpermission.id;


--
-- Name: wagtailcore_grouppagepermission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailcore_grouppagepermission (
    id bigint NOT NULL,
    group_id bigint,
    page_id bigint,
    permission_id bigint
);


ALTER TABLE public.wagtailcore_grouppagepermission OWNER TO postgres;

--
-- Name: wagtailcore_grouppagepermission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wagtailcore_grouppagepermission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_grouppagepermission_id_seq OWNER TO postgres;

--
-- Name: wagtailcore_grouppagepermission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wagtailcore_grouppagepermission_id_seq OWNED BY public.wagtailcore_grouppagepermission.id;


--
-- Name: wagtailcore_locale; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailcore_locale (
    id bigint NOT NULL,
    language_code text
);


ALTER TABLE public.wagtailcore_locale OWNER TO postgres;

--
-- Name: wagtailcore_locale_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wagtailcore_locale_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_locale_id_seq OWNER TO postgres;

--
-- Name: wagtailcore_locale_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wagtailcore_locale_id_seq OWNED BY public.wagtailcore_locale.id;


--
-- Name: wagtailcore_modellogentry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailcore_modellogentry (
    id bigint NOT NULL,
    label text,
    action text,
    "timestamp" timestamp with time zone,
    content_changed boolean,
    deleted boolean,
    object_id text,
    content_type_id bigint,
    user_id bigint,
    uuid text,
    revision_id bigint,
    data text
);


ALTER TABLE public.wagtailcore_modellogentry OWNER TO postgres;

--
-- Name: wagtailcore_modellogentry_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wagtailcore_modellogentry_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_modellogentry_id_seq OWNER TO postgres;

--
-- Name: wagtailcore_modellogentry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wagtailcore_modellogentry_id_seq OWNED BY public.wagtailcore_modellogentry.id;


--
-- Name: wagtailcore_page; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailcore_page (
    id bigint NOT NULL,
    path text,
    depth integer,
    numchild integer,
    title text,
    slug text,
    live boolean,
    has_unpublished_changes boolean,
    url_path text,
    seo_title text,
    show_in_menus boolean,
    search_description text,
    go_live_at timestamp with time zone,
    expire_at timestamp with time zone,
    expired boolean,
    content_type_id bigint,
    owner_id bigint,
    locked boolean,
    latest_revision_created_at timestamp with time zone,
    first_published_at timestamp with time zone,
    live_revision_id bigint,
    last_published_at timestamp with time zone,
    draft_title text,
    locked_at timestamp with time zone,
    locked_by_id bigint,
    locale_id bigint,
    translation_key text,
    alias_of_id bigint,
    latest_revision_id bigint
);


ALTER TABLE public.wagtailcore_page OWNER TO postgres;

--
-- Name: wagtailcore_page_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wagtailcore_page_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_page_id_seq OWNER TO postgres;

--
-- Name: wagtailcore_page_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wagtailcore_page_id_seq OWNED BY public.wagtailcore_page.id;


--
-- Name: wagtailcore_pagelogentry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailcore_pagelogentry (
    id bigint NOT NULL,
    label text,
    action text,
    "timestamp" timestamp with time zone,
    content_changed boolean,
    deleted boolean,
    content_type_id bigint,
    page_id bigint,
    revision_id bigint,
    user_id bigint,
    uuid text,
    data text
);


ALTER TABLE public.wagtailcore_pagelogentry OWNER TO postgres;

--
-- Name: wagtailcore_pagelogentry_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wagtailcore_pagelogentry_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_pagelogentry_id_seq OWNER TO postgres;

--
-- Name: wagtailcore_pagelogentry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wagtailcore_pagelogentry_id_seq OWNED BY public.wagtailcore_pagelogentry.id;


--
-- Name: wagtailcore_pagesubscription; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailcore_pagesubscription (
    id bigint NOT NULL,
    comment_notifications boolean,
    page_id bigint,
    user_id bigint
);


ALTER TABLE public.wagtailcore_pagesubscription OWNER TO postgres;

--
-- Name: wagtailcore_pagesubscription_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wagtailcore_pagesubscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_pagesubscription_id_seq OWNER TO postgres;

--
-- Name: wagtailcore_pagesubscription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wagtailcore_pagesubscription_id_seq OWNED BY public.wagtailcore_pagesubscription.id;


--
-- Name: wagtailcore_pageviewrestriction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailcore_pageviewrestriction (
    id bigint NOT NULL,
    password text,
    page_id bigint,
    restriction_type text
);


ALTER TABLE public.wagtailcore_pageviewrestriction OWNER TO postgres;

--
-- Name: wagtailcore_pageviewrestriction_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailcore_pageviewrestriction_groups (
    id bigint NOT NULL,
    pageviewrestriction_id bigint,
    group_id bigint
);


ALTER TABLE public.wagtailcore_pageviewrestriction_groups OWNER TO postgres;

--
-- Name: wagtailcore_pageviewrestriction_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wagtailcore_pageviewrestriction_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_pageviewrestriction_groups_id_seq OWNER TO postgres;

--
-- Name: wagtailcore_pageviewrestriction_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wagtailcore_pageviewrestriction_groups_id_seq OWNED BY public.wagtailcore_pageviewrestriction_groups.id;


--
-- Name: wagtailcore_pageviewrestriction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wagtailcore_pageviewrestriction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_pageviewrestriction_id_seq OWNER TO postgres;

--
-- Name: wagtailcore_pageviewrestriction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wagtailcore_pageviewrestriction_id_seq OWNED BY public.wagtailcore_pageviewrestriction.id;


--
-- Name: wagtailcore_referenceindex; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailcore_referenceindex (
    id bigint NOT NULL,
    object_id text,
    to_object_id text,
    model_path text,
    content_path text,
    content_path_hash text,
    base_content_type_id bigint,
    content_type_id bigint,
    to_content_type_id bigint
);


ALTER TABLE public.wagtailcore_referenceindex OWNER TO postgres;

--
-- Name: wagtailcore_referenceindex_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wagtailcore_referenceindex_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_referenceindex_id_seq OWNER TO postgres;

--
-- Name: wagtailcore_referenceindex_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wagtailcore_referenceindex_id_seq OWNED BY public.wagtailcore_referenceindex.id;


--
-- Name: wagtailcore_revision; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailcore_revision (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    approved_go_live_at timestamp with time zone,
    user_id bigint,
    content text,
    object_id text,
    content_type_id bigint,
    base_content_type_id bigint,
    object_str text
);


ALTER TABLE public.wagtailcore_revision OWNER TO postgres;

--
-- Name: wagtailcore_revision_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wagtailcore_revision_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_revision_id_seq OWNER TO postgres;

--
-- Name: wagtailcore_revision_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wagtailcore_revision_id_seq OWNED BY public.wagtailcore_revision.id;


--
-- Name: wagtailcore_site; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailcore_site (
    id bigint NOT NULL,
    hostname text,
    port bigint,
    is_default_site boolean,
    root_page_id bigint,
    site_name text
);


ALTER TABLE public.wagtailcore_site OWNER TO postgres;

--
-- Name: wagtailcore_site_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wagtailcore_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_site_id_seq OWNER TO postgres;

--
-- Name: wagtailcore_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wagtailcore_site_id_seq OWNED BY public.wagtailcore_site.id;


--
-- Name: wagtailcore_task; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailcore_task (
    id bigint NOT NULL,
    name text,
    active boolean,
    content_type_id bigint
);


ALTER TABLE public.wagtailcore_task OWNER TO postgres;

--
-- Name: wagtailcore_task_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wagtailcore_task_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_task_id_seq OWNER TO postgres;

--
-- Name: wagtailcore_task_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wagtailcore_task_id_seq OWNED BY public.wagtailcore_task.id;


--
-- Name: wagtailcore_taskstate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailcore_taskstate (
    id bigint NOT NULL,
    status text,
    started_at timestamp with time zone,
    finished_at timestamp with time zone,
    content_type_id bigint,
    task_id bigint,
    workflow_state_id bigint,
    finished_by_id bigint,
    comment text,
    revision_id bigint
);


ALTER TABLE public.wagtailcore_taskstate OWNER TO postgres;

--
-- Name: wagtailcore_taskstate_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wagtailcore_taskstate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_taskstate_id_seq OWNER TO postgres;

--
-- Name: wagtailcore_taskstate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wagtailcore_taskstate_id_seq OWNED BY public.wagtailcore_taskstate.id;


--
-- Name: wagtailcore_uploadedfile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailcore_uploadedfile (
    id bigint NOT NULL,
    file text,
    for_content_type_id bigint,
    uploaded_by_user_id bigint
);


ALTER TABLE public.wagtailcore_uploadedfile OWNER TO postgres;

--
-- Name: wagtailcore_uploadedfile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wagtailcore_uploadedfile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_uploadedfile_id_seq OWNER TO postgres;

--
-- Name: wagtailcore_uploadedfile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wagtailcore_uploadedfile_id_seq OWNED BY public.wagtailcore_uploadedfile.id;


--
-- Name: wagtailcore_workflow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailcore_workflow (
    id bigint NOT NULL,
    name text,
    active boolean
);


ALTER TABLE public.wagtailcore_workflow OWNER TO postgres;

--
-- Name: wagtailcore_workflow_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wagtailcore_workflow_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_workflow_id_seq OWNER TO postgres;

--
-- Name: wagtailcore_workflow_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wagtailcore_workflow_id_seq OWNED BY public.wagtailcore_workflow.id;


--
-- Name: wagtailcore_workflowcontenttype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailcore_workflowcontenttype (
    content_type_id bigint NOT NULL,
    workflow_id bigint
);


ALTER TABLE public.wagtailcore_workflowcontenttype OWNER TO postgres;

--
-- Name: wagtailcore_workflowpage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailcore_workflowpage (
    page_id bigint NOT NULL,
    workflow_id bigint
);


ALTER TABLE public.wagtailcore_workflowpage OWNER TO postgres;

--
-- Name: wagtailcore_workflowstate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailcore_workflowstate (
    id bigint NOT NULL,
    status text,
    created_at timestamp with time zone,
    current_task_state_id bigint,
    requested_by_id bigint,
    workflow_id bigint,
    object_id text,
    base_content_type_id bigint,
    content_type_id bigint
);


ALTER TABLE public.wagtailcore_workflowstate OWNER TO postgres;

--
-- Name: wagtailcore_workflowstate_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wagtailcore_workflowstate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_workflowstate_id_seq OWNER TO postgres;

--
-- Name: wagtailcore_workflowstate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wagtailcore_workflowstate_id_seq OWNED BY public.wagtailcore_workflowstate.id;


--
-- Name: wagtailcore_workflowtask; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailcore_workflowtask (
    id bigint NOT NULL,
    sort_order bigint,
    task_id bigint,
    workflow_id bigint
);


ALTER TABLE public.wagtailcore_workflowtask OWNER TO postgres;

--
-- Name: wagtailcore_workflowtask_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wagtailcore_workflowtask_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_workflowtask_id_seq OWNER TO postgres;

--
-- Name: wagtailcore_workflowtask_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wagtailcore_workflowtask_id_seq OWNED BY public.wagtailcore_workflowtask.id;


--
-- Name: wagtaildocs_document; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtaildocs_document (
    id bigint NOT NULL,
    title text,
    file text,
    created_at timestamp with time zone,
    uploaded_by_user_id bigint,
    collection_id bigint,
    file_size integer,
    file_hash text
);


ALTER TABLE public.wagtaildocs_document OWNER TO postgres;

--
-- Name: wagtaildocs_document_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wagtaildocs_document_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtaildocs_document_id_seq OWNER TO postgres;

--
-- Name: wagtaildocs_document_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wagtaildocs_document_id_seq OWNED BY public.wagtaildocs_document.id;


--
-- Name: wagtailembeds_embed; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailembeds_embed (
    id bigint NOT NULL,
    url text,
    max_width smallint,
    type text,
    html text,
    title text,
    author_name text,
    provider_name text,
    width bigint,
    height bigint,
    last_updated timestamp with time zone,
    hash text,
    thumbnail_url text,
    cache_until timestamp with time zone
);


ALTER TABLE public.wagtailembeds_embed OWNER TO postgres;

--
-- Name: wagtailembeds_embed_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wagtailembeds_embed_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailembeds_embed_id_seq OWNER TO postgres;

--
-- Name: wagtailembeds_embed_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wagtailembeds_embed_id_seq OWNED BY public.wagtailembeds_embed.id;


--
-- Name: wagtailforms_formsubmission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailforms_formsubmission (
    id bigint NOT NULL,
    submit_time timestamp with time zone,
    page_id bigint,
    form_data text
);


ALTER TABLE public.wagtailforms_formsubmission OWNER TO postgres;

--
-- Name: wagtailforms_formsubmission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wagtailforms_formsubmission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailforms_formsubmission_id_seq OWNER TO postgres;

--
-- Name: wagtailforms_formsubmission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wagtailforms_formsubmission_id_seq OWNED BY public.wagtailforms_formsubmission.id;


--
-- Name: wagtailimages_image; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailimages_image (
    id bigint NOT NULL,
    title text,
    width bigint,
    height bigint,
    created_at timestamp with time zone,
    focal_point_x integer,
    focal_point_y integer,
    focal_point_width integer,
    focal_point_height integer,
    uploaded_by_user_id bigint,
    file_size integer,
    collection_id bigint,
    file_hash text,
    file text
);


ALTER TABLE public.wagtailimages_image OWNER TO postgres;

--
-- Name: wagtailimages_image_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wagtailimages_image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailimages_image_id_seq OWNER TO postgres;

--
-- Name: wagtailimages_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wagtailimages_image_id_seq OWNED BY public.wagtailimages_image.id;


--
-- Name: wagtailimages_rendition; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailimages_rendition (
    id bigint NOT NULL,
    width bigint,
    height bigint,
    focal_point_key text,
    filter_spec text,
    image_id bigint,
    file text
);


ALTER TABLE public.wagtailimages_rendition OWNER TO postgres;

--
-- Name: wagtailimages_rendition_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wagtailimages_rendition_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailimages_rendition_id_seq OWNER TO postgres;

--
-- Name: wagtailimages_rendition_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wagtailimages_rendition_id_seq OWNED BY public.wagtailimages_rendition.id;


--
-- Name: wagtailredirects_redirect; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailredirects_redirect (
    id bigint NOT NULL,
    old_path text,
    is_permanent boolean,
    redirect_link text,
    redirect_page_id bigint,
    site_id bigint,
    automatically_created boolean,
    created_at timestamp with time zone,
    redirect_page_route_path text
);


ALTER TABLE public.wagtailredirects_redirect OWNER TO postgres;

--
-- Name: wagtailredirects_redirect_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wagtailredirects_redirect_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailredirects_redirect_id_seq OWNER TO postgres;

--
-- Name: wagtailredirects_redirect_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wagtailredirects_redirect_id_seq OWNED BY public.wagtailredirects_redirect.id;


--
-- Name: wagtailsearch_indexentry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailsearch_indexentry (
    id bigint NOT NULL,
    object_id text,
    title_norm real,
    content_type_id bigint,
    autocomplete text,
    body text,
    title text
);


ALTER TABLE public.wagtailsearch_indexentry OWNER TO postgres;

--
-- Name: wagtailsearch_indexentry_fts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailsearch_indexentry_fts (
    autocomplete text,
    body text,
    title text
);


ALTER TABLE public.wagtailsearch_indexentry_fts OWNER TO postgres;

--
-- Name: wagtailsearch_indexentry_fts_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailsearch_indexentry_fts_config (
    k text NOT NULL,
    v text
);


ALTER TABLE public.wagtailsearch_indexentry_fts_config OWNER TO postgres;

--
-- Name: wagtailsearch_indexentry_fts_content; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailsearch_indexentry_fts_content (
    id bigint NOT NULL,
    c0 text,
    c1 text,
    c2 text
);


ALTER TABLE public.wagtailsearch_indexentry_fts_content OWNER TO postgres;

--
-- Name: wagtailsearch_indexentry_fts_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailsearch_indexentry_fts_data (
    id bigint NOT NULL,
    block bytea
);


ALTER TABLE public.wagtailsearch_indexentry_fts_data OWNER TO postgres;

--
-- Name: wagtailsearch_indexentry_fts_docsize; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailsearch_indexentry_fts_docsize (
    id bigint NOT NULL,
    sz bytea
);


ALTER TABLE public.wagtailsearch_indexentry_fts_docsize OWNER TO postgres;

--
-- Name: wagtailsearch_indexentry_fts_idx; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailsearch_indexentry_fts_idx (
    segid text NOT NULL,
    term text NOT NULL,
    pgno text
);


ALTER TABLE public.wagtailsearch_indexentry_fts_idx OWNER TO postgres;

--
-- Name: wagtailsearch_indexentry_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wagtailsearch_indexentry_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailsearch_indexentry_id_seq OWNER TO postgres;

--
-- Name: wagtailsearch_indexentry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wagtailsearch_indexentry_id_seq OWNED BY public.wagtailsearch_indexentry.id;


--
-- Name: wagtailusers_userprofile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wagtailusers_userprofile (
    id bigint NOT NULL,
    submitted_notifications boolean,
    approved_notifications boolean,
    rejected_notifications boolean,
    user_id bigint,
    preferred_language text,
    current_time_zone text,
    avatar text,
    updated_comments_notifications boolean,
    dismissibles text,
    theme text,
    density text
);


ALTER TABLE public.wagtailusers_userprofile OWNER TO postgres;

--
-- Name: wagtailusers_userprofile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wagtailusers_userprofile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailusers_userprofile_id_seq OWNER TO postgres;

--
-- Name: wagtailusers_userprofile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wagtailusers_userprofile_id_seq OWNED BY public.wagtailusers_userprofile.id;


--
-- Name: account_emailaddress id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_emailaddress ALTER COLUMN id SET DEFAULT nextval('public.account_emailaddress_id_seq'::regclass);


--
-- Name: account_emailconfirmation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_emailconfirmation ALTER COLUMN id SET DEFAULT nextval('public.account_emailconfirmation_id_seq'::regclass);


--
-- Name: actstream_action id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actstream_action ALTER COLUMN id SET DEFAULT nextval('public.actstream_action_id_seq'::regclass);


--
-- Name: actstream_follow id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actstream_follow ALTER COLUMN id SET DEFAULT nextval('public.actstream_follow_id_seq'::regclass);


--
-- Name: apps_accommodation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_accommodation ALTER COLUMN id SET DEFAULT nextval('public.apps_accommodation_id_seq'::regclass);


--
-- Name: apps_appointment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_appointment ALTER COLUMN id SET DEFAULT nextval('public.apps_appointment_id_seq'::regclass);


--
-- Name: apps_contact id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_contact ALTER COLUMN id SET DEFAULT nextval('public.apps_contact_id_seq'::regclass);


--
-- Name: apps_emailtemplate id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_emailtemplate ALTER COLUMN id SET DEFAULT nextval('public.apps_emailtemplate_id_seq'::regclass);


--
-- Name: apps_emergencycontact id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_emergencycontact ALTER COLUMN id SET DEFAULT nextval('public.apps_emergencycontact_id_seq'::regclass);


--
-- Name: apps_flightreservation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_flightreservation ALTER COLUMN id SET DEFAULT nextval('public.apps_flightreservation_id_seq'::regclass);


--
-- Name: apps_hospital id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_hospital ALTER COLUMN id SET DEFAULT nextval('public.apps_hospital_id_seq'::regclass);


--
-- Name: apps_hospitalstay id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_hospitalstay ALTER COLUMN id SET DEFAULT nextval('public.apps_hospitalstay_id_seq'::regclass);


--
-- Name: apps_hotel id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_hotel ALTER COLUMN id SET DEFAULT nextval('public.apps_hotel_id_seq'::regclass);


--
-- Name: apps_insurance id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_insurance ALTER COLUMN id SET DEFAULT nextval('public.apps_insurance_id_seq'::regclass);


--
-- Name: apps_medicalfile id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_medicalfile ALTER COLUMN id SET DEFAULT nextval('public.apps_medicalfile_id_seq'::regclass);


--
-- Name: apps_medicalinformation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_medicalinformation ALTER COLUMN id SET DEFAULT nextval('public.apps_medicalinformation_id_seq'::regclass);


--
-- Name: apps_message id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_message ALTER COLUMN id SET DEFAULT nextval('public.apps_message_id_seq'::regclass);


--
-- Name: apps_message_read_members id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_message_read_members ALTER COLUMN id SET DEFAULT nextval('public.apps_message_read_members_id_seq'::regclass);


--
-- Name: apps_messagegroup id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_messagegroup ALTER COLUMN id SET DEFAULT nextval('public.apps_messagegroup_id_seq'::regclass);


--
-- Name: apps_messagegroup_members id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_messagegroup_members ALTER COLUMN id SET DEFAULT nextval('public.apps_messagegroup_members_id_seq'::regclass);


--
-- Name: apps_patientschedule id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_patientschedule ALTER COLUMN id SET DEFAULT nextval('public.apps_patientschedule_id_seq'::regclass);


--
-- Name: apps_prescription id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_prescription ALTER COLUMN id SET DEFAULT nextval('public.apps_prescription_id_seq'::regclass);


--
-- Name: apps_referral id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_referral ALTER COLUMN id SET DEFAULT nextval('public.apps_referral_id_seq'::regclass);


--
-- Name: apps_subscription id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_subscription ALTER COLUMN id SET DEFAULT nextval('public.apps_subscription_id_seq'::regclass);


--
-- Name: apps_treatmentplan id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_treatmentplan ALTER COLUMN id SET DEFAULT nextval('public.apps_treatmentplan_id_seq'::regclass);


--
-- Name: apps_treatmentplanitem id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_treatmentplanitem ALTER COLUMN id SET DEFAULT nextval('public.apps_treatmentplanitem_id_seq'::regclass);


--
-- Name: apps_treatmentproduct id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_treatmentproduct ALTER COLUMN id SET DEFAULT nextval('public.apps_treatmentproduct_id_seq'::regclass);


--
-- Name: apps_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_user ALTER COLUMN id SET DEFAULT nextval('public.apps_user_id_seq'::regclass);


--
-- Name: apps_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_user_groups ALTER COLUMN id SET DEFAULT nextval('public.apps_user_groups_id_seq'::regclass);


--
-- Name: apps_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.apps_user_user_permissions_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: baton_batontheme id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.baton_batontheme ALTER COLUMN id SET DEFAULT nextval('public.baton_batontheme_id_seq'::regclass);


--
-- Name: blog_comments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blog_comments ALTER COLUMN id SET DEFAULT nextval('public.blog_comments_id_seq'::regclass);


--
-- Name: blog_image id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blog_image ALTER COLUMN id SET DEFAULT nextval('public.blog_image_id_seq'::regclass);


--
-- Name: blog_image_image_likes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blog_image_image_likes ALTER COLUMN id SET DEFAULT nextval('public.blog_image_image_likes_id_seq'::regclass);


--
-- Name: blog_profile id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blog_profile ALTER COLUMN id SET DEFAULT nextval('public.blog_profile_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_celery_results_chordcounter id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_celery_results_chordcounter ALTER COLUMN id SET DEFAULT nextval('public.django_celery_results_chordcounter_id_seq'::regclass);


--
-- Name: django_celery_results_groupresult id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_celery_results_groupresult ALTER COLUMN id SET DEFAULT nextval('public.django_celery_results_groupresult_id_seq'::regclass);


--
-- Name: django_celery_results_taskresult id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_celery_results_taskresult ALTER COLUMN id SET DEFAULT nextval('public.django_celery_results_taskresult_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: django_site id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_site ALTER COLUMN id SET DEFAULT nextval('public.django_site_id_seq'::regclass);


--
-- Name: gram_comments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gram_comments ALTER COLUMN id SET DEFAULT nextval('public.gram_comments_id_seq'::regclass);


--
-- Name: gram_image id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gram_image ALTER COLUMN id SET DEFAULT nextval('public.gram_image_id_seq'::regclass);


--
-- Name: gram_image_image_likes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gram_image_image_likes ALTER COLUMN id SET DEFAULT nextval('public.gram_image_image_likes_id_seq'::regclass);


--
-- Name: gram_profile id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gram_profile ALTER COLUMN id SET DEFAULT nextval('public.gram_profile_id_seq'::regclass);


--
-- Name: jet_django_token id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jet_django_token ALTER COLUMN id SET DEFAULT nextval('public.jet_django_token_id_seq'::regclass);


--
-- Name: socialaccount_socialaccount id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialaccount ALTER COLUMN id SET DEFAULT nextval('public.socialaccount_socialaccount_id_seq'::regclass);


--
-- Name: socialaccount_socialapp id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialapp ALTER COLUMN id SET DEFAULT nextval('public.socialaccount_socialapp_id_seq'::regclass);


--
-- Name: socialaccount_socialapp_sites id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites ALTER COLUMN id SET DEFAULT nextval('public.socialaccount_socialapp_sites_id_seq'::regclass);


--
-- Name: socialaccount_socialtoken id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialtoken ALTER COLUMN id SET DEFAULT nextval('public.socialaccount_socialtoken_id_seq'::regclass);


--
-- Name: taggit_tag id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taggit_tag ALTER COLUMN id SET DEFAULT nextval('public.taggit_tag_id_seq'::regclass);


--
-- Name: taggit_taggeditem id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taggit_taggeditem ALTER COLUMN id SET DEFAULT nextval('public.taggit_taggeditem_id_seq'::regclass);


--
-- Name: wagtailadmin_admin id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailadmin_admin ALTER COLUMN id SET DEFAULT nextval('public.wagtailadmin_admin_id_seq'::regclass);


--
-- Name: wagtailadmin_editingsession id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailadmin_editingsession ALTER COLUMN id SET DEFAULT nextval('public.wagtailadmin_editingsession_id_seq'::regclass);


--
-- Name: wagtailcore_collection id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_collection ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_collection_id_seq'::regclass);


--
-- Name: wagtailcore_collectionviewrestriction id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_collectionviewrestriction ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_collectionviewrestriction_id_seq'::regclass);


--
-- Name: wagtailcore_collectionviewrestriction_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_collectionviewrestriction_groups ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_collectionviewrestriction_groups_id_seq'::regclass);


--
-- Name: wagtailcore_comment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_comment ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_comment_id_seq'::regclass);


--
-- Name: wagtailcore_commentreply id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_commentreply ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_commentreply_id_seq'::regclass);


--
-- Name: wagtailcore_groupapprovaltask_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_groupapprovaltask_groups ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_groupapprovaltask_groups_id_seq'::regclass);


--
-- Name: wagtailcore_groupcollectionpermission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_groupcollectionpermission ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_groupcollectionpermission_id_seq'::regclass);


--
-- Name: wagtailcore_grouppagepermission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_grouppagepermission ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_grouppagepermission_id_seq'::regclass);


--
-- Name: wagtailcore_locale id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_locale ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_locale_id_seq'::regclass);


--
-- Name: wagtailcore_modellogentry id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_modellogentry ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_modellogentry_id_seq'::regclass);


--
-- Name: wagtailcore_page id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_page ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_page_id_seq'::regclass);


--
-- Name: wagtailcore_pagelogentry id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_pagelogentry ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_pagelogentry_id_seq'::regclass);


--
-- Name: wagtailcore_pagesubscription id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_pagesubscription ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_pagesubscription_id_seq'::regclass);


--
-- Name: wagtailcore_pageviewrestriction id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_pageviewrestriction ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_pageviewrestriction_id_seq'::regclass);


--
-- Name: wagtailcore_pageviewrestriction_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_pageviewrestriction_groups ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_pageviewrestriction_groups_id_seq'::regclass);


--
-- Name: wagtailcore_referenceindex id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_referenceindex ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_referenceindex_id_seq'::regclass);


--
-- Name: wagtailcore_revision id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_revision ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_revision_id_seq'::regclass);


--
-- Name: wagtailcore_site id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_site ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_site_id_seq'::regclass);


--
-- Name: wagtailcore_task id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_task ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_task_id_seq'::regclass);


--
-- Name: wagtailcore_taskstate id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_taskstate ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_taskstate_id_seq'::regclass);


--
-- Name: wagtailcore_uploadedfile id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_uploadedfile ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_uploadedfile_id_seq'::regclass);


--
-- Name: wagtailcore_workflow id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_workflow ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_workflow_id_seq'::regclass);


--
-- Name: wagtailcore_workflowstate id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_workflowstate ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_workflowstate_id_seq'::regclass);


--
-- Name: wagtailcore_workflowtask id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_workflowtask ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_workflowtask_id_seq'::regclass);


--
-- Name: wagtaildocs_document id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtaildocs_document ALTER COLUMN id SET DEFAULT nextval('public.wagtaildocs_document_id_seq'::regclass);


--
-- Name: wagtailembeds_embed id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailembeds_embed ALTER COLUMN id SET DEFAULT nextval('public.wagtailembeds_embed_id_seq'::regclass);


--
-- Name: wagtailforms_formsubmission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailforms_formsubmission ALTER COLUMN id SET DEFAULT nextval('public.wagtailforms_formsubmission_id_seq'::regclass);


--
-- Name: wagtailimages_image id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailimages_image ALTER COLUMN id SET DEFAULT nextval('public.wagtailimages_image_id_seq'::regclass);


--
-- Name: wagtailimages_rendition id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailimages_rendition ALTER COLUMN id SET DEFAULT nextval('public.wagtailimages_rendition_id_seq'::regclass);


--
-- Name: wagtailredirects_redirect id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailredirects_redirect ALTER COLUMN id SET DEFAULT nextval('public.wagtailredirects_redirect_id_seq'::regclass);


--
-- Name: wagtailsearch_indexentry id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailsearch_indexentry ALTER COLUMN id SET DEFAULT nextval('public.wagtailsearch_indexentry_id_seq'::regclass);


--
-- Name: wagtailusers_userprofile id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailusers_userprofile ALTER COLUMN id SET DEFAULT nextval('public.wagtailusers_userprofile_id_seq'::regclass);


--
-- Data for Name: account_emailaddress; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_emailaddress (id, verified, "primary", user_id, email) FROM stdin;
1	f	f	49	hasta36@bc.com
2	t	t	50	rayemej389@biscoine.com
3	t	t	51	vekeg66648@almaxen.com
4	f	f	52	rebexi1401@foraro.com
5	f	f	53	bekafe2652@alientex.com
6	f	f	54	yihibe5690@eixdeal.com
7	f	f	55	kibinaj111@almaxen.com
8	f	f	56	rexar22705@luvnish.com
9	t	t	57	gobete6254@almaxen.com
10	f	f	58	tifavop258@luvnish.com
11	f	f	59	test@bc.com
12	f	f	60	test1@bc.com
13	f	f	61	hasta56@bc.com
14	f	f	62	qacenugo@jollyfree.com
15	f	f	63	tugijup.jotediv@rungel.net
16	t	t	64	qomediqi.evahufo@gotgel.org
17	t	t	65	fivigeha.ufurehi@gotgel.org
18	t	t	66	jagal67445@luvnish.com
19	f	f	67	maltefagna@gufum.com
20	f	f	68	asca@fvdf.fr
21	f	f	69	ac@dfb.cm
22	f	f	70	ascasc@gm.com
23	t	t	71	lotfikanouni4@gmail.com
24	f	f	73	kanouni.xsotfixsx.prot@gmail.com
25	f	f	74	asc@efw.com
26	f	f	75	sdfrf@ferf.fr
27	f	f	76	docdoc@fo.cf
28	f	f	77	arananada@gmail.com
29	f	f	78	melekdjemouai@gmail.com
30	f	f	79	jgwelkfj@kwergn.com
31	f	f	82	kanouni.lotfi.protxx@gmail.com
41	f	f	92	kanouni.loteffi.prot@gmail.com
42	f	f	93	fekanouni.lotfi.prot@gmail.com
43	f	f	94	loffu@gm.fj
44	f	f	95	dentidelilhealthgroup@outlook.com
45	f	f	96	lof@gm.fj
46	f	f	97	lofrgerg@erg.vu
47	f	f	98	lofaf@gwse.gh
49	f	f	102	lo@f.com
50	f	f	103	kanouni.losctfi.prot@gmail.com
51	f	f	104	sdvsd@sgascsdf.fr
52	t	t	111	lona2023.io51023@gmail.com
53	t	t	113	medtouradmin@bagdadinvest.com
\.


--
-- Data for Name: account_emailconfirmation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_emailconfirmation (id, created, sent, key, email_address_id) FROM stdin;
\.


--
-- Data for Name: actstream_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.actstream_action (id, actor_object_id, verb, description, target_object_id, action_object_object_id, "timestamp", public, action_object_content_type_id, actor_content_type_id, target_content_type_id) FROM stdin;
1	1	test action	\N	\N	\N	2024-08-28 16:17:20.193504+00	t	\N	6	\N
2	2	edited profile	Profile ID: 2	2	\N	2024-08-28 16:39:01.984968+00	t	\N	6	6
3	2	edited patient profile	Profile ID: 2	2	\N	2024-08-28 16:39:01.999964+00	t	\N	6	6
4	2	exported patient information	Patient ID: 2	2	\N	2024-08-28 16:39:02.018968+00	t	\N	6	6
5	2	released test results	Patient ID: 2	2	\N	2024-08-28 16:39:02.036194+00	t	\N	6	6
6	2	transferred patient	Patient ID: 2	2	\N	2024-08-28 16:39:02.052776+00	t	\N	6	6
7	2	extended patient stay	Patient ID: 2	2	\N	2024-08-28 16:39:02.077304+00	t	\N	6	6
8	2	discharged patient	Patient ID: 2	2	\N	2024-08-28 16:39:02.092305+00	t	\N	6	6
9	2	uploaded update to patient profile	Profile ID: 2	2	\N	2024-08-28 16:39:02.108705+00	t	\N	6	6
10	2	edited profile	Profile ID: 2	2	\N	2024-08-28 16:39:02.139464+00	t	\N	6	6
11	2	edited patient profile	Profile ID: 2	2	\N	2024-08-28 16:39:02.156904+00	t	\N	6	6
12	2	exported patient information	Patient ID: 2	2	\N	2024-08-28 16:39:02.176335+00	t	\N	6	6
13	2	released test results	Patient ID: 2	2	\N	2024-08-28 16:39:02.191336+00	t	\N	6	6
14	2	transferred patient	Patient ID: 2	2	\N	2024-08-28 16:39:02.209787+00	t	\N	6	6
15	2	extended patient stay	Patient ID: 2	2	\N	2024-08-28 16:39:02.224787+00	t	\N	6	6
16	2	discharged patient	Patient ID: 2	2	\N	2024-08-28 16:39:02.241142+00	t	\N	6	6
17	2	uploaded update to patient profile	Profile ID: 2	2	\N	2024-08-28 16:39:02.255762+00	t	\N	6	6
18	2	logged in	\N	\N	\N	2024-08-28 16:39:02.275526+00	t	\N	6	\N
19	2	edited profile	Profile ID: 2	2	\N	2024-08-28 16:39:02.304141+00	t	\N	6	6
20	2	edited patient profile	Profile ID: 2	2	\N	2024-08-28 16:39:02.339414+00	t	\N	6	6
21	2	exported patient information	Patient ID: 2	2	\N	2024-08-28 16:39:02.366645+00	t	\N	6	6
22	2	released test results	Patient ID: 2	2	\N	2024-08-28 16:39:02.389152+00	t	\N	6	6
23	2	transferred patient	Patient ID: 2	2	\N	2024-08-28 16:39:02.404895+00	t	\N	6	6
24	2	extended patient stay	Patient ID: 2	2	\N	2024-08-28 16:39:02.426931+00	t	\N	6	6
25	2	discharged patient	Patient ID: 2	2	\N	2024-08-28 16:39:02.440932+00	t	\N	6	6
26	2	uploaded update to patient profile	Profile ID: 2	2	\N	2024-08-28 16:39:02.458939+00	t	\N	6	6
27	2	edited profile	Profile ID: 2	2	\N	2024-08-28 16:39:02.486472+00	t	\N	6	6
28	2	edited patient profile	Profile ID: 2	2	\N	2024-08-28 16:39:02.503057+00	t	\N	6	6
29	2	exported patient information	Patient ID: 2	2	\N	2024-08-28 16:39:02.523068+00	t	\N	6	6
30	2	released test results	Patient ID: 2	2	\N	2024-08-28 16:39:02.538599+00	t	\N	6	6
31	2	transferred patient	Patient ID: 2	2	\N	2024-08-28 16:39:02.557669+00	t	\N	6	6
32	2	extended patient stay	Patient ID: 2	2	\N	2024-08-28 16:39:02.576483+00	t	\N	6	6
33	2	discharged patient	Patient ID: 2	2	\N	2024-08-28 16:39:02.590497+00	t	\N	6	6
34	2	uploaded update to patient profile	Profile ID: 2	2	\N	2024-08-28 16:39:02.609741+00	t	\N	6	6
35	2	logged in	\N	\N	\N	2024-08-28 16:39:02.624253+00	t	\N	6	\N
36	2	logged out	\N	\N	\N	2024-08-28 16:45:37.96111+00	t	\N	6	\N
37	2	logged in	\N	\N	\N	2024-08-28 16:45:48.026482+00	t	\N	6	\N
38	2	logged in	\N	\N	\N	2024-08-28 16:45:48.071913+00	t	\N	6	\N
39	2	logged out	\N	\N	\N	2024-08-28 16:46:45.564867+00	t	\N	6	\N
40	10	logged in	\N	\N	\N	2024-08-28 16:47:10.270076+00	t	\N	6	\N
41	10	logged in	\N	\N	\N	2024-08-28 16:47:10.310441+00	t	\N	6	\N
42	10	logged out	\N	\N	\N	2024-08-28 16:52:58.863109+00	t	\N	6	\N
43	2	logged in	\N	\N	\N	2024-08-28 16:53:56.148729+00	t	\N	6	\N
44	2	logged in	\N	\N	\N	2024-08-28 16:53:56.188612+00	t	\N	6	\N
45	2	logged in	\N	\N	\N	2024-08-28 16:53:56.25686+00	t	\N	6	\N
46	2	logged in	\N	\N	\N	2024-08-28 16:53:56.29473+00	t	\N	6	\N
47	2	logged out	\N	\N	\N	2024-08-28 16:55:11.052686+00	t	\N	6	\N
48	10	logged in	\N	\N	\N	2024-08-28 16:55:28.166913+00	t	\N	6	\N
49	10	logged in	\N	\N	\N	2024-08-28 16:55:28.226074+00	t	\N	6	\N
50	33	logged in	\N	\N	\N	2024-08-28 16:56:16.281874+00	t	\N	6	\N
51	33	logged in	\N	\N	\N	2024-08-28 16:56:16.323003+00	t	\N	6	\N
52	10	logged out	\N	\N	\N	2024-08-28 16:56:44.566469+00	t	\N	6	\N
53	2	logged in	\N	\N	\N	2024-08-28 17:11:15.264092+00	t	\N	6	\N
54	2	logged in	\N	\N	\N	2024-08-28 17:11:15.310048+00	t	\N	6	\N
55	2	logged out	\N	\N	\N	2024-08-28 17:13:06.49664+00	t	\N	6	\N
56	2	logged in	\N	\N	\N	2024-08-28 17:21:07.266385+00	t	\N	6	\N
57	2	logged out	\N	\N	\N	2024-08-28 17:21:19.499789+00	t	\N	6	\N
58	2	logged in	\N	\N	\N	2024-08-28 18:06:04.958787+00	t	\N	6	\N
59	33	logged out as Patient	\N	\N	\N	2024-08-28 20:17:39.164921+00	t	\N	6	\N
60	8	logged in as No Group	\N	\N	\N	2024-08-28 20:17:57.057469+00	t	\N	6	\N
61	8	logged out as No Group	\N	\N	\N	2024-08-28 20:28:22.268038+00	t	\N	6	\N
62	8	logged in as No Group	\N	\N	\N	2024-08-28 20:28:55.074875+00	t	\N	6	\N
63	8	sent message as No Group	\N	9	\N	2024-08-28 20:32:44.94468+00	t	\N	6	13
64	8	logged out as No Group	\N	\N	\N	2024-08-28 20:39:44.557235+00	t	\N	6	\N
65	73	admitted to hospital as No Group	\N	3	\N	2024-08-28 20:50:48.576923+00	t	\N	6	9
66	73	logged in as Patient	\N	\N	\N	2024-08-28 20:50:48.746282+00	t	\N	6	\N
67	74	admitted to hospital as No Group	\N	3	\N	2024-08-28 21:00:04.881379+00	t	\N	6	9
68	74	logged in as Patient	\N	\N	\N	2024-08-28 21:00:05.018731+00	t	\N	6	\N
69	74	logged in as Patient	\N	\N	\N	2024-08-28 21:03:12.305993+00	t	\N	6	\N
70	75	signed up via referral as No Group	\N	74	\N	2024-08-28 21:04:13.314588+00	t	\N	6	6
71	75	admitted to hospital as No Group	\N	3	\N	2024-08-28 21:04:13.346583+00	t	\N	6	9
72	75	logged in as Patient	\N	\N	\N	2024-08-28 21:04:13.482769+00	t	\N	6	\N
73	75	logged in as Patient	\N	\N	\N	2024-08-28 21:04:53.673779+00	t	\N	6	\N
74	76	admitted to hospital as No Group	\N	4	\N	2024-08-28 21:16:37.315708+00	t	\N	6	9
75	76	logged in as Patient	\N	\N	\N	2024-08-28 21:16:37.44162+00	t	\N	6	\N
76	76	logged in as Doctor	\N	\N	\N	2024-08-28 21:28:47.515539+00	t	\N	6	\N
77	1	logged in as Corporate	\N	\N	\N	2024-08-28 23:47:31.355328+00	t	\N	6	\N
78	1	logged in as Corporate	\N	\N	\N	2024-08-29 01:47:25.316287+00	t	\N	6	\N
79	10	logged in as No Group	\N	\N	\N	2024-08-29 04:53:41.25476+00	t	\N	6	\N
80	10	logged out as No Group	\N	\N	\N	2024-08-29 04:55:35.759146+00	t	\N	6	\N
81	17	logged in as No Group	\N	\N	\N	2024-08-29 04:55:46.374033+00	t	\N	6	\N
82	17	logged out as No Group	\N	\N	\N	2024-08-29 05:00:35.045444+00	t	\N	6	\N
83	46	logged in as Patient	\N	\N	\N	2024-08-29 05:01:03.009663+00	t	\N	6	\N
84	46	logged out as Patient	\N	\N	\N	2024-08-29 05:05:18.070571+00	t	\N	6	\N
85	59	logged in as Patient	\N	\N	\N	2024-08-29 05:05:23.922954+00	t	\N	6	\N
86	59	uploaded medical file as Patient	File uploaded: docs/users/patient/59/zoom-logo-2_Qm1pc0a.jpg	\N	\N	2024-08-29 06:06:11.028702+00	t	\N	6	\N
87	74	logged in as Doctor	\N	\N	\N	2024-08-29 08:17:22.259005+00	t	\N	6	\N
88	74	logged out as Doctor	\N	\N	\N	2024-08-29 08:24:42.200818+00	t	\N	6	\N
89	74	logged in as Doctor	\N	\N	\N	2024-08-29 08:25:18.376623+00	t	\N	6	\N
90	74	logged in as Doctor	\N	\N	\N	2024-08-29 08:36:52.280204+00	t	\N	6	\N
91	59	logged out as Patient	\N	\N	\N	2024-08-29 09:04:11.73807+00	t	\N	6	\N
92	40	logged in as Corporate	\N	\N	\N	2024-08-29 09:05:26.701022+00	t	\N	6	\N
93	76	logged in as Doctor	\N	\N	\N	2024-08-29 10:06:50.558325+00	t	\N	6	\N
94	40	logged in as Corporate	\N	\N	\N	2024-08-29 10:44:16.155563+00	t	\N	6	\N
95	40	logged in as Corporate	\N	\N	\N	2024-08-29 11:09:58.717054+00	t	\N	6	\N
96	72	logged in as No Group	\N	\N	\N	2024-08-29 11:36:44.14229+00	t	\N	6	\N
97	72	logged out as No Group	\N	\N	\N	2024-08-29 11:37:32.227724+00	t	\N	6	\N
98	68	logged in as Patient	\N	\N	\N	2024-08-29 11:39:21.643501+00	t	\N	6	\N
99	68	logged out as Patient	\N	\N	\N	2024-08-29 11:46:50.814377+00	t	\N	6	\N
100	60	logged in as Corporate	\N	\N	\N	2024-08-29 11:47:09.458291+00	t	\N	6	\N
101	1	logged out as Corporate	\N	\N	\N	2024-08-29 14:45:01.374459+00	t	\N	6	\N
102	1	logged in as Corporate	\N	\N	\N	2024-08-29 14:45:13.636781+00	t	\N	6	\N
103	52	logged in as Corporate	\N	\N	\N	2024-08-29 14:45:58.255526+00	t	\N	6	\N
104	76	logged in as Doctor	\N	\N	\N	2024-08-29 19:19:25.138422+00	t	\N	6	\N
105	76	sent message as Doctor	\N	10	\N	2024-08-29 19:20:18.284454+00	t	\N	6	13
106	76	logged in as Doctor	\N	\N	\N	2024-08-29 20:50:43.05765+00	t	\N	6	\N
107	74	logged in as Doctor	\N	\N	\N	2024-08-29 23:07:13.759986+00	t	\N	6	\N
108	72	logged in as No Group	\N	\N	\N	2024-08-31 08:57:29.705584+00	t	\N	6	\N
109	72	logged in as No Group	\N	\N	\N	2024-08-31 09:56:27.900252+00	t	\N	6	\N
110	72	logged out as No Group	\N	\N	\N	2024-08-31 09:56:37.444161+00	t	\N	6	\N
111	76	logged in as Doctor	\N	\N	\N	2024-08-31 09:56:55.546769+00	t	\N	6	\N
112	76	logged out as Doctor	\N	\N	\N	2024-08-31 18:26:30.307736+00	t	\N	6	\N
113	1	logged in as Corporate	\N	\N	\N	2024-08-31 18:26:53.962985+00	t	\N	6	\N
114	2	logged in as Patient	\N	\N	\N	2024-09-01 10:32:34.275514+00	t	\N	6	\N
115	2	uploaded medical file as Patient	File uploaded: docs/users/patient/2/1900838.png	\N	\N	2024-09-01 10:33:30.441887+00	t	\N	6	\N
116	2	uploaded medical file as Patient	File uploaded: docs/users/patient/2/1900838_iQ7tNgC.png	\N	\N	2024-09-01 12:29:47.190966+00	t	\N	6	\N
117	2	uploaded medical file as Patient	File uploaded: docs/users/patient/2/1900838_QtHQPhW.png	\N	\N	2024-09-01 12:29:47.172115+00	t	\N	6	\N
118	2	uploaded medical file as Patient	File uploaded: docs/users/patient/2/file_8ad86e6d-6396-4987-a541-80b.jpg	\N	\N	2024-09-01 12:33:02.743203+00	t	\N	6	\N
119	2	uploaded medical file as Patient	File uploaded: docs/users/patient/2/Screenshot_2024-09-01_171744.png	\N	\N	2024-09-01 14:20:16.814616+00	t	\N	6	\N
120	2	uploaded medical file as Patient	File uploaded: docs/users/patient/2/Screenshot_2024-09-01_121301.png	\N	\N	2024-09-01 14:46:39.518572+00	t	\N	6	\N
121	2	admitted to hospital as Patient	\N	3	\N	2024-09-01 14:50:33.049296+00	t	\N	6	9
122	60	logged in as Corporate	\N	\N	\N	2024-09-01 18:39:22.841434+00	t	\N	6	\N
123	1	logged in as Corporate	\N	\N	\N	2024-09-03 16:48:03.933282+00	t	\N	6	\N
124	74	logged in as Doctor	\N	\N	\N	2024-09-03 16:49:45.96296+00	t	\N	6	\N
125	27	logged in as Patient	\N	\N	\N	2024-09-03 16:54:07.38336+00	t	\N	6	\N
126	27	uploaded medical file as Patient	File uploaded: docs/users/patient/27/1900838.png	\N	\N	2024-09-03 16:54:55.858634+00	t	\N	6	\N
127	27	logged out as Patient	\N	\N	\N	2024-09-03 17:16:30.950352+00	t	\N	6	\N
128	39	logged in as Doctor	\N	\N	\N	2024-09-03 17:16:57.253337+00	t	\N	6	\N
129	48	logged in as Patient	\N	\N	\N	2024-09-03 17:18:40.162611+00	t	\N	6	\N
130	48	uploaded medical file as Patient	File uploaded: docs/users/patient/48/1900838.png	\N	\N	2024-09-03 17:19:47.831022+00	t	\N	6	\N
131	48	logged out as Patient	\N	\N	\N	2024-09-03 19:29:49.521158+00	t	\N	6	\N
132	29	logged in as Patient	\N	\N	\N	2024-09-03 19:30:03.667519+00	t	\N	6	\N
133	29	uploaded medical file as Patient	File uploaded: docs/users/patient/29/1900838.png	\N	\N	2024-09-03 19:31:38.004807+00	t	\N	6	\N
134	29	viewed their treatment plans	\N	29	\N	2024-09-03 19:33:22.046115+00	t	\N	6	6
135	29	viewed their treatment plans	\N	29	\N	2024-09-03 19:33:27.041088+00	t	\N	6	6
137	29	viewed their treatment plans	\N	29	\N	2024-09-03 19:41:45.69603+00	t	\N	6	6
138	29	viewed their treatment plans	\N	29	\N	2024-09-03 19:44:57.634414+00	t	\N	6	6
139	29	viewed their treatment plans	\N	29	\N	2024-09-03 19:47:30.392579+00	t	\N	6	6
140	1	logged in as Corporate	\N	\N	\N	2024-09-03 22:01:00.213106+00	t	\N	6	\N
141	27	logged in as Patient	\N	\N	\N	2024-09-03 22:02:15.579763+00	t	\N	6	\N
142	27	viewed their treatment plans	\N	27	\N	2024-09-03 22:02:21.519803+00	t	\N	6	6
143	27	viewed their treatment plans	\N	27	\N	2024-09-03 22:04:59.035128+00	t	\N	6	6
144	27	viewed their treatment plans	\N	27	\N	2024-09-03 22:20:14.170828+00	t	\N	6	6
145	27	viewed their treatment plans	\N	27	\N	2024-09-03 22:34:07.714798+00	t	\N	6	6
146	27	viewed their treatment plans	\N	27	\N	2024-09-03 22:37:26.46548+00	t	\N	6	6
147	27	viewed their treatment plans	\N	27	\N	2024-09-03 22:40:52.819502+00	t	\N	6	6
148	27	viewed their treatment plans	\N	27	\N	2024-09-03 22:43:25.390554+00	t	\N	6	6
149	27	viewed their treatment plans	\N	27	\N	2024-09-03 22:44:27.121681+00	t	\N	6	6
150	1	logged in as Corporate	\N	\N	\N	2024-09-03 23:15:47.958737+00	t	\N	6	\N
151	77	admitted to hospital as No Group	\N	3	\N	2024-09-03 23:16:53.148738+00	t	\N	6	9
152	77	logged in as Patient	\N	\N	\N	2024-09-03 23:16:53.302304+00	t	\N	6	\N
153	78	admitted to hospital as No Group	\N	3	\N	2024-09-03 23:19:03.724349+00	t	\N	6	9
154	78	logged in as Patient	\N	\N	\N	2024-09-03 23:19:03.831395+00	t	\N	6	\N
155	77	logged in as Patient	\N	\N	\N	2024-09-03 23:22:02.95246+00	t	\N	6	\N
156	77	viewed their treatment plans	\N	77	\N	2024-09-03 23:23:10.965952+00	t	\N	6	6
157	78	logged in as Patient	\N	\N	\N	2024-09-03 23:24:47.510228+00	t	\N	6	\N
158	77	logged in as Patient	\N	\N	\N	2024-09-03 23:25:07.71007+00	t	\N	6	\N
159	69	logged in as Patient	\N	\N	\N	2024-09-03 23:25:47.943704+00	t	\N	6	\N
160	78	logged out as Doctor	\N	\N	\N	2024-09-03 23:27:26.352599+00	t	\N	6	\N
161	78	logged in as Doctor	\N	\N	\N	2024-09-03 23:27:34.601973+00	t	\N	6	\N
162	77	uploaded medical file as Patient	File uploaded: docs/users/patient/77/images.jpeg	\N	\N	2024-09-03 23:29:02.956606+00	t	\N	6	\N
163	77	uploaded medical file as Patient	File uploaded: docs/users/patient/77/images_MOVyFJV.jpeg	\N	\N	2024-09-03 23:29:09.813357+00	t	\N	6	\N
164	77	uploaded medical file as Patient	File uploaded: docs/users/patient/77/images_Q9ZqVip.jpeg	\N	\N	2024-09-03 23:29:21.595484+00	t	\N	6	\N
166	79	signed up via referral as No Group	\N	77	\N	2024-09-03 23:34:29.579318+00	t	\N	6	6
167	79	admitted to hospital as No Group	\N	5	\N	2024-09-03 23:34:29.644534+00	t	\N	6	9
168	79	logged in as Patient	\N	\N	\N	2024-09-03 23:34:29.812297+00	t	\N	6	\N
169	77	logged in as Patient	\N	\N	\N	2024-09-03 23:34:39.329899+00	t	\N	6	\N
170	77	viewed their treatment plans	\N	77	\N	2024-09-03 23:44:37.747526+00	t	\N	6	6
171	82	admitted to hospital as No Group	\N	3	\N	2024-09-04 01:07:29.403503+00	t	\N	6	9
172	82	logged in as Patient	\N	\N	\N	2024-09-04 01:07:29.539407+00	t	\N	6	\N
173	82	logged in as Patient	\N	\N	\N	2024-09-04 01:07:56.847149+00	t	\N	6	\N
174	82	viewed their treatment plans	\N	82	\N	2024-09-04 01:11:48.011955+00	t	\N	6	6
175	82	viewed their treatment plans	\N	82	\N	2024-09-04 01:27:56.626497+00	t	\N	6	6
176	82	viewed their treatment plans	\N	82	\N	2024-09-04 01:28:56.771234+00	t	\N	6	6
177	72	logged in as No Group	\N	\N	\N	2024-09-04 02:12:45.047727+00	t	\N	6	\N
178	72	uploaded medical file as No Group	File uploaded: docs/users/patient/72/treatment_plans_lukas.schmidtgmail.com_3.pdf	\N	\N	2024-09-04 02:17:31.501463+00	t	\N	6	\N
179	72	logged out as No Group	\N	\N	\N	2024-09-04 02:17:39.967445+00	t	\N	6	\N
180	76	logged in as Doctor	\N	\N	\N	2024-09-04 02:18:46.174667+00	t	\N	6	\N
181	80	logged in as No Group	\N	\N	\N	2024-09-04 08:58:46.951347+00	t	\N	6	\N
182	73	logged in as Patient	\N	\N	\N	2024-09-04 09:33:07.697993+00	t	\N	6	\N
183	73	logged out as Patient	\N	\N	\N	2024-09-04 09:36:09.084638+00	t	\N	6	\N
184	75	logged in as Patient	\N	\N	\N	2024-09-04 09:36:16.916223+00	t	\N	6	\N
185	75	logged in as Patient	\N	\N	\N	2024-09-04 09:51:51.289838+00	t	\N	6	\N
186	75	viewed their treatment plans	\N	75	\N	2024-09-04 09:55:20.10941+00	t	\N	6	6
187	75	viewed their treatment plans	\N	75	\N	2024-09-04 09:55:25.93792+00	t	\N	6	6
188	75	viewed their treatment plans	\N	75	\N	2024-09-04 09:55:41.828569+00	t	\N	6	6
189	80	logged in as No Group	\N	\N	\N	2024-09-04 14:57:38.95905+00	t	\N	6	\N
190	80	logged out as No Group	\N	\N	\N	2024-09-04 15:44:00.185828+00	t	\N	6	\N
191	27	logged in as Patient	\N	\N	\N	2024-09-04 15:44:18.312329+00	t	\N	6	\N
192	27	viewed their treatment plans	\N	27	\N	2024-09-04 15:44:32.760604+00	t	\N	6	6
195	1	olarak giriş yaptı Corporate	\N	\N	\N	2024-09-05 06:56:36.205527+00	t	\N	6	\N
196	76	olarak giriş yaptı Doctor	\N	\N	\N	2024-09-05 06:56:59.657155+00	t	\N	6	\N
201	8	logged in as Doctor	\N	\N	\N	2024-09-05 11:16:10.674211+00	t	\N	6	\N
204	54	olarak giriş yaptı Patient	\N	\N	\N	2024-09-05 11:22:58.123071+00	t	\N	6	\N
205	54	Tıbbi dosya olarak yüklendi Patient	Dosya yüklendi: docs/users/patient/54/1.mp4	\N	\N	2024-09-05 11:25:18.364897+00	t	\N	6	\N
207	54	tedavi planlarını inceledi	\N	54	\N	2024-09-05 11:25:59.528183+00	t	\N	6	6
208	54	tedavi planlarını inceledi	\N	54	\N	2024-09-05 11:27:11.189438+00	t	\N	6	6
209	54	tedavi planlarını inceledi	\N	54	\N	2024-09-05 11:27:13.880701+00	t	\N	6	6
210	54	tedavi planlarını inceledi	\N	54	\N	2024-09-05 11:31:03.921586+00	t	\N	6	6
211	54	tedavi planlarını inceledi	\N	54	\N	2024-09-05 11:33:49.160527+00	t	\N	6	6
212	1	logged in as Corporate	\N	\N	\N	2024-09-05 13:33:57.851842+00	t	\N	6	\N
213	1	logged in as Corporate	\N	\N	\N	2024-09-05 18:40:28.804191+00	t	\N	6	\N
214	1	logged in as Corporate	\N	\N	\N	2024-09-06 17:05:52.453211+00	t	\N	6	\N
215	1	logged in as Corporate	\N	\N	\N	2024-09-09 12:53:47.333801+00	t	\N	6	\N
216	1	logged in as Corporate	\N	\N	\N	2024-09-12 21:48:54.945988+00	t	\N	6	\N
217	67	logged in as Patient	\N	\N	\N	2024-09-12 21:50:05.273467+00	t	\N	6	\N
218	62	logged in as Patient	\N	\N	\N	2024-09-12 22:58:13.495907+00	t	\N	6	\N
234	1	logged in as Corporate	\N	\N	\N	2024-09-15 06:53:09.337862+00	t	\N	6	\N
235	84	deleted medical file as No Group	File deleted: docs/users/patient/84/1.mp4	\N	\N	2024-09-15 06:53:39.444949+00	t	\N	6	\N
236	57	logged in as Patient	\N	\N	\N	2024-09-15 06:54:25.721798+00	t	\N	6	\N
237	57	uploaded medical file as Patient	File uploaded: docs/users/patient/57/klinigimiz.png	\N	\N	2024-09-15 06:55:18.603533+00	t	\N	6	\N
238	1	logged in as Corporate	\N	\N	\N	2024-09-15 06:55:35.882046+00	t	\N	6	\N
239	71	logged in as Patient	\N	\N	\N	2024-09-15 07:53:30.294623+00	t	\N	6	\N
240	67	logged in as Patient	\N	\N	\N	2024-09-15 08:20:52.101021+00	t	\N	6	\N
241	68	logged in as Patient	\N	\N	\N	2024-09-15 08:36:21.665986+00	t	\N	6	\N
242	65	logged in as Patient	\N	\N	\N	2024-09-15 09:40:51.751616+00	t	\N	6	\N
243	66	logged in as Patient	\N	\N	\N	2024-09-15 09:45:44.077921+00	t	\N	6	\N
244	92	admitted to hospital as No Group	\N	3	\N	2024-09-16 22:18:58.457126+00	t	\N	6	9
245	92	logged in as Patient	\N	\N	\N	2024-09-16 22:18:58.568172+00	t	\N	6	\N
246	93	admitted to hospital as No Group	\N	3	\N	2024-09-16 22:22:58.217722+00	t	\N	6	9
247	93	logged in as Patient	\N	\N	\N	2024-09-16 22:22:58.315265+00	t	\N	6	\N
248	73	logged in as Patient	\N	\N	\N	2024-09-21 01:16:16.93613+00	t	\N	6	\N
249	73	uploaded medical file as Patient	File uploaded: docs/users/patient/73/Screenshot_20240917_014359_Instagram.jpg	\N	\N	2024-09-21 01:17:13.239907+00	t	\N	6	\N
250	78	Connecté en tant que Doctor	\N	\N	\N	2024-09-21 07:24:34.649688+00	t	\N	6	\N
251	94	admitted to hospital as No Group	\N	3	\N	2024-09-30 21:01:37.083186+00	t	\N	6	9
252	94	logged in as Patient	\N	\N	\N	2024-09-30 21:01:37.181922+00	t	\N	6	\N
253	95	admitted to hospital as No Group	\N	3	\N	2024-10-02 02:12:57.74611+00	t	\N	6	9
254	95	logged in as Patient	\N	\N	\N	2024-10-02 02:12:57.857613+00	t	\N	6	\N
255	96	admitted to hospital as No Group	\N	3	\N	2024-10-02 02:17:50.080454+00	t	\N	6	9
256	96	logged in as Patient	\N	\N	\N	2024-10-02 02:17:50.176648+00	t	\N	6	\N
257	97	admitted to hospital as No Group	\N	3	\N	2024-10-02 02:18:12.082247+00	t	\N	6	9
258	97	logged in as Patient	\N	\N	\N	2024-10-02 02:18:12.177887+00	t	\N	6	\N
259	98	admitted to hospital as No Group	\N	3	\N	2024-10-02 02:18:56.164583+00	t	\N	6	9
260	98	logged in as Patient	\N	\N	\N	2024-10-02 02:18:56.273298+00	t	\N	6	\N
261	1	logged in as Corporate	\N	\N	\N	2024-10-02 02:22:17.570779+00	t	\N	6	\N
262	95	logged in as Patient	\N	\N	\N	2024-10-02 02:23:26.606046+00	t	\N	6	\N
263	95	uploaded medical file as Patient	File uploaded: docs/users/patient/95/test-mic.wav	\N	\N	2024-10-02 02:24:55.545324+00	t	\N	6	\N
264	95	logged in as Patient	\N	\N	\N	2024-10-02 02:27:44.295539+00	t	\N	6	\N
265	1	logged in as Corporate	\N	\N	\N	2024-10-05 21:49:36.856174+00	t	\N	6	\N
266	1	logged out as Corporate	\N	\N	\N	2024-10-05 21:58:09.190859+00	t	\N	6	\N
267	1	logged in as Corporate	\N	\N	\N	2024-10-06 09:33:13.243808+00	t	\N	6	\N
268	1	logged out as Corporate	\N	\N	\N	2024-10-06 09:43:05.462656+00	t	\N	6	\N
269	1	logged in as Corporate	\N	\N	\N	2024-10-06 10:29:56.07146+00	t	\N	6	\N
270	1	Connecté en tant que Corporate	\N	\N	\N	2024-10-14 06:19:57.866528+00	t	\N	6	\N
271	1	logged in as Corporate	\N	\N	\N	2024-10-14 07:07:23.8214+00	t	\N	6	\N
272	1	logged in as Corporate	\N	\N	\N	2024-10-14 07:09:33.787796+00	t	\N	6	\N
277	1	logged in as Corporate	\N	\N	\N	2024-10-21 19:15:19.255068+00	t	\N	6	\N
279	102	admitted to hospital as No Group	\N	3	\N	2024-10-25 21:28:19.009097+00	t	\N	6	9
280	102	logged in as Patient	\N	\N	\N	2024-10-25 21:28:19.1184+00	t	\N	6	\N
281	103	admitted to hospital as No Group	\N	3	\N	2024-10-25 22:14:33.796634+00	t	\N	6	9
282	103	logged in as Patient	\N	\N	\N	2024-10-25 22:14:33.934201+00	t	\N	6	\N
283	103	logged in as Patient	\N	\N	\N	2024-10-25 22:17:26.485905+00	t	\N	6	\N
284	104	admitted to hospital as No Group	\N	3	\N	2024-10-25 23:44:46.044948+00	t	\N	6	9
285	104	logged in as Patient	\N	\N	\N	2024-10-25 23:44:46.148641+00	t	\N	6	\N
286	104	logged in as Patient	\N	\N	\N	2024-10-25 23:49:02.189887+00	t	\N	6	\N
287	104	logged out as Patient	\N	\N	\N	2024-10-25 23:54:19.43192+00	t	\N	6	\N
288	105	admitted to hospital as No Group	\N	3	\N	2024-10-25 23:54:47.436512+00	t	\N	6	9
289	105	logged in as Patient	\N	\N	\N	2024-10-25 23:54:47.532228+00	t	\N	6	\N
290	1	logged in as Corporate	\N	\N	\N	2024-10-26 09:14:02.402351+00	t	\N	6	\N
291	1	logged out as Corporate	\N	\N	\N	2024-10-26 09:21:45.555943+00	t	\N	6	\N
292	1	logged in as Corporate	\N	\N	\N	2024-10-26 09:45:42.460831+00	t	\N	6	\N
295	106	admitted to hospital as No Group	\N	3	\N	2024-10-26 11:04:06.402946+00	t	\N	6	9
296	106	logged in as Patient	\N	\N	\N	2024-10-26 11:04:06.511723+00	t	\N	6	\N
299	107	admitted to hospital as No Group	\N	3	\N	2024-10-26 17:03:44.414129+00	t	\N	6	9
300	107	logged in as Patient	\N	\N	\N	2024-10-26 17:03:44.505674+00	t	\N	6	\N
303	1	logged in as Corporate	\N	\N	\N	2024-11-01 11:11:12.39462+00	t	\N	6	\N
304	1	logged out as Corporate	\N	\N	\N	2024-11-01 11:17:37.454058+00	t	\N	6	\N
308	108	admitted to hospital as No Group	\N	3	\N	2024-11-06 19:39:36.992375+00	t	\N	6	9
309	108	logged in as Patient	\N	\N	\N	2024-11-06 19:39:37.094645+00	t	\N	6	\N
310	108	logged out as Patient	\N	\N	\N	2024-11-06 19:41:17.14194+00	t	\N	6	\N
311	109	admitted to hospital as No Group	\N	3	\N	2024-11-06 19:42:53.428554+00	t	\N	6	9
312	109	logged in as Patient	\N	\N	\N	2024-11-06 19:42:53.519843+00	t	\N	6	\N
313	110	admitted to hospital as No Group	\N	3	\N	2024-11-06 19:56:04.435634+00	t	\N	6	9
314	110	logged in as Patient	\N	\N	\N	2024-11-06 19:56:04.541077+00	t	\N	6	\N
318	1	logged in as Corporate	\N	\N	\N	2024-11-07 05:29:56.326933+00	t	\N	6	\N
319	1	logged in as Corporate	\N	\N	\N	2024-11-07 06:22:50.991129+00	t	\N	6	\N
320	1	logged in as Corporate	\N	\N	\N	2024-11-07 06:25:46.184207+00	t	\N	6	\N
321	1	logged in as Corporate	\N	\N	\N	2024-11-09 00:45:29.248342+00	t	\N	6	\N
325	1	Connecté en tant que Corporate	\N	\N	\N	2024-11-10 15:31:14.812609+00	t	\N	6	\N
326	99	fichier médical supprimé en tant que Aucun groupe	Fichier supprimé: docs/users/patient/99/broken-tooth.gif	\N	\N	2024-11-10 15:32:11.681859+00	t	\N	6	\N
327	1	déconnecté en tant que Corporate	\N	\N	\N	2024-11-10 15:32:23.270232+00	t	\N	6	\N
328	1	logged out as Corporate	\N	\N	\N	2024-11-10 20:22:37.9919+00	t	\N	6	\N
329	1	Connecté en tant que Corporate	\N	\N	\N	2024-11-10 20:27:49.95252+00	t	\N	6	\N
330	1	déconnecté en tant que Corporate	\N	\N	\N	2024-11-10 20:29:31.727701+00	t	\N	6	\N
331	1	logged in as Corporate	\N	\N	\N	2024-11-10 20:32:44.484603+00	t	\N	6	\N
332	1	logged out as Corporate	\N	\N	\N	2024-11-10 20:32:52.875531+00	t	\N	6	\N
333	1	logged out as Corporate	\N	\N	\N	2024-11-10 20:33:30.617898+00	t	\N	6	\N
334	111	logged in as No Group	\N	\N	\N	2024-11-10 20:37:53.361087+00	t	\N	6	\N
335	112	admitted to hospital as No Group	\N	3	\N	2024-11-10 20:50:38.172936+00	t	\N	6	9
336	112	logged in as Patient	\N	\N	\N	2024-11-10 20:50:38.292151+00	t	\N	6	\N
337	112	logged out as Patient	\N	\N	\N	2024-11-10 20:51:12.576039+00	t	\N	6	\N
338	113	logged in as No Group	\N	\N	\N	2024-11-10 20:53:57.844247+00	t	\N	6	\N
339	1	Connecté en tant que Corporate	\N	\N	\N	2024-11-10 20:58:19.850148+00	t	\N	6	\N
340	1	Connecté en tant que Corporate	\N	\N	\N	2024-11-10 20:58:20.213774+00	t	\N	6	\N
341	1	déconnecté en tant que Corporate	\N	\N	\N	2024-11-10 20:59:15.552104+00	t	\N	6	\N
342	1	logged in as Corporate	\N	\N	\N	2024-11-10 21:00:07.480527+00	t	\N	6	\N
343	1	logged out as Corporate	\N	\N	\N	2024-11-10 21:00:12.199332+00	t	\N	6	\N
344	111	logged in as No Group	\N	\N	\N	2024-11-10 21:00:23.415445+00	t	\N	6	\N
345	111	logged out as No Group	\N	\N	\N	2024-11-10 21:00:34.374974+00	t	\N	6	\N
346	111	logged in as No Group	\N	\N	\N	2024-11-10 21:00:34.433743+00	t	\N	6	\N
347	114	admitted to hospital as No Group	\N	3	\N	2024-11-11 18:19:59.709375+00	t	\N	6	9
348	114	logged in as Patient	\N	\N	\N	2024-11-11 18:19:59.80847+00	t	\N	6	\N
349	1	Connecté en tant que Corporate	\N	\N	\N	2024-11-13 18:14:22.786838+00	t	\N	6	\N
350	1	logged in as Corporate	\N	\N	\N	2024-11-13 20:25:09.538995+00	t	\N	6	\N
351	1	logged out as Corporate	\N	\N	\N	2024-11-13 20:50:16.721501+00	t	\N	6	\N
352	115	admitted to hospital as No Group	\N	3	\N	2024-11-13 21:47:15.93368+00	t	\N	6	9
353	115	logged in as Patient	\N	\N	\N	2024-11-13 21:47:16.052176+00	t	\N	6	\N
354	1	logged in as Corporate	\N	\N	\N	2024-11-13 22:36:57.017021+00	t	\N	6	\N
355	114	logged in as Patient	\N	\N	\N	2024-11-13 22:45:31.787869+00	t	\N	6	\N
356	114	logged out as Patient	\N	\N	\N	2024-11-14 14:49:24.417244+00	t	\N	6	\N
357	116	admitted to hospital as No Group	\N	3	\N	2024-11-14 14:50:56.503081+00	t	\N	6	9
358	116	logged in as Patient	\N	\N	\N	2024-11-14 14:50:56.589969+00	t	\N	6	\N
359	116	uploaded medical file as Patient	File uploaded: docs/users/patient/116/Screenshot_20241114_032508_Instagram.jpg	\N	\N	2024-11-14 14:51:28.217543+00	t	\N	6	\N
360	117	logged in as Patient	\N	\N	\N	2024-11-14 15:15:10.880607+00	t	\N	6	\N
361	117	logged out as Patient	\N	\N	\N	2024-11-14 15:16:09.798095+00	t	\N	6	\N
362	118	logged in as Patient	\N	\N	\N	2024-11-14 18:23:27.484457+00	t	\N	6	\N
363	118	logged in as Patient	\N	\N	\N	2024-11-14 18:24:04.054377+00	t	\N	6	\N
364	118	logged in as Patient	\N	\N	\N	2024-11-14 18:24:08.114461+00	t	\N	6	\N
365	1	logged in as Corporate	\N	\N	\N	2024-11-14 19:19:46.415758+00	t	\N	6	\N
366	119	logged in as Patient	\N	\N	\N	2024-11-14 20:55:39.243416+00	t	\N	6	\N
368	117	logged in as Patient	\N	\N	\N	2024-11-15 00:10:34.458099+00	t	\N	6	\N
369	117	viewed their treatment plans	\N	117	\N	2024-11-15 00:14:23.631364+00	t	\N	6	6
370	117	viewed their treatment plans	\N	117	\N	2024-11-15 00:20:51.397964+00	t	\N	6	6
371	117	viewed their treatment plans	\N	117	\N	2024-11-15 00:25:36.878635+00	t	\N	6	6
372	117	viewed their treatment plans	\N	117	\N	2024-11-15 00:25:39.423821+00	t	\N	6	6
373	117	viewed their treatment plans	\N	117	\N	2024-11-15 03:03:20.060398+00	t	\N	6	6
374	117	viewed their treatment plans	\N	117	\N	2024-11-15 03:06:39.049654+00	t	\N	6	6
375	117	viewed their treatment plans	\N	117	\N	2024-11-15 03:13:37.514126+00	t	\N	6	6
376	117	viewed their treatment plans	\N	117	\N	2024-11-15 03:13:54.514455+00	t	\N	6	6
377	117	logged in as Patient	\N	\N	\N	2024-11-15 03:18:41.769992+00	t	\N	6	\N
378	117	logged in as Patient	\N	\N	\N	2024-11-15 03:18:46.072579+00	t	\N	6	\N
379	117	viewed their treatment plans	\N	117	\N	2024-11-15 03:18:59.098442+00	t	\N	6	6
380	117	viewed their treatment plans	\N	117	\N	2024-11-15 03:20:28.445038+00	t	\N	6	6
381	117	viewed their treatment plans	\N	117	\N	2024-11-15 03:21:19.245867+00	t	\N	6	6
382	117	viewed their treatment plans	\N	117	\N	2024-11-15 03:21:28.094199+00	t	\N	6	6
383	117	viewed their treatment plans	\N	117	\N	2024-11-15 03:22:02.235914+00	t	\N	6	6
384	117	viewed their treatment plans	\N	117	\N	2024-11-15 04:26:55.545867+00	t	\N	6	6
385	117	viewed their treatment plans	\N	117	\N	2024-11-15 04:36:28.460578+00	t	\N	6	6
386	117	viewed their treatment plans	\N	117	\N	2024-11-15 04:46:15.114441+00	t	\N	6	6
387	117	viewed their treatment plans	\N	117	\N	2024-11-15 04:46:36.063804+00	t	\N	6	6
388	117	viewed their treatment plans	\N	117	\N	2024-11-15 05:10:53.271853+00	t	\N	6	6
389	117	viewed their treatment plans	\N	117	\N	2024-11-15 05:11:21.284842+00	t	\N	6	6
390	117	viewed their treatment plans	\N	117	\N	2024-11-15 05:12:11.554962+00	t	\N	6	6
391	117	viewed their treatment plans	\N	117	\N	2024-11-15 05:12:33.753769+00	t	\N	6	6
392	119	logged out as Doctor	\N	\N	\N	2024-11-15 05:14:56.8981+00	t	\N	6	\N
393	117	logged in as Patient	\N	\N	\N	2024-11-15 05:15:41.526423+00	t	\N	6	\N
394	117	viewed their treatment plans	\N	117	\N	2024-11-15 05:16:20.970054+00	t	\N	6	6
395	117	viewed their treatment plans	\N	117	\N	2024-11-15 05:17:45.574332+00	t	\N	6	6
396	117	viewed their treatment plans	\N	117	\N	2024-11-15 05:17:48.396796+00	t	\N	6	6
397	117	viewed their treatment plans	\N	117	\N	2024-11-15 05:19:57.210905+00	t	\N	6	6
398	117	viewed their treatment plans	\N	117	\N	2024-11-15 05:20:29.419656+00	t	\N	6	6
399	117	viewed their treatment plans	\N	117	\N	2024-11-15 05:21:23.761961+00	t	\N	6	6
400	117	viewed their treatment plans	\N	117	\N	2024-11-15 05:21:25.901282+00	t	\N	6	6
401	118	logged in as Patient	\N	\N	\N	2024-11-15 17:47:03.801132+00	t	\N	6	\N
402	118	logged in as Patient	\N	\N	\N	2024-11-15 17:47:07.20099+00	t	\N	6	\N
403	118	viewed their treatment plans	\N	118	\N	2024-11-15 17:50:51.89465+00	t	\N	6	6
404	118	viewed their treatment plans	\N	118	\N	2024-11-15 17:56:02.848782+00	t	\N	6	6
405	114	logged in as Patient	\N	\N	\N	2024-11-15 19:38:33.404778+00	t	\N	6	\N
406	1	logged in as Corporate	\N	\N	\N	2024-11-15 19:39:26.598157+00	t	\N	6	\N
407	1	logged in as Corporate	\N	\N	\N	2024-11-15 19:39:29.823765+00	t	\N	6	\N
408	1	logged in as Corporate	\N	\N	\N	2024-11-15 19:39:37.663002+00	t	\N	6	\N
409	1	logged in as Corporate	\N	\N	\N	2024-11-15 19:39:37.979889+00	t	\N	6	\N
410	118	viewed their treatment plans	\N	118	\N	2024-11-15 20:25:57.374494+00	t	\N	6	6
411	114	logged in as Patient	\N	\N	\N	2024-11-15 20:35:53.483767+00	t	\N	6	\N
412	1	logged in as Corporate	\N	\N	\N	2024-11-15 20:54:57.061079+00	t	\N	6	\N
413	1	logged in as Corporate	\N	\N	\N	2024-11-15 20:55:04.891021+00	t	\N	6	\N
414	118	logged in as Patient	\N	\N	\N	2024-11-17 16:25:58.230023+00	t	\N	6	\N
415	118	logged in as Patient	\N	\N	\N	2024-11-17 16:26:00.717695+00	t	\N	6	\N
416	1	logged in as Corporate	\N	\N	\N	2024-11-20 15:06:58.061531+00	t	\N	6	\N
417	1	logged in as Corporate	\N	\N	\N	2024-12-03 23:54:02.699396+00	t	\N	6	\N
418	1	logged in as Corporate	\N	\N	\N	2024-12-04 14:59:06.441078+00	t	\N	6	\N
419	1	logged in as Corporate	\N	\N	\N	2024-12-04 14:59:07.842239+00	t	\N	6	\N
420	1	logged in as Corporate	\N	\N	\N	2024-12-09 21:28:11.115481+00	t	\N	6	\N
421	1	logged in as Corporate	\N	\N	\N	2024-12-09 21:28:52.123865+00	t	\N	6	\N
422	1	logged in as Corporate	\N	\N	\N	2024-12-09 21:31:23.339891+00	t	\N	6	\N
423	1	logged in as Corporate	\N	\N	\N	2024-12-09 21:58:17.154998+00	t	\N	6	\N
424	1	logged in as Corporate	\N	\N	\N	2024-12-09 22:11:04.411537+00	t	\N	6	\N
425	1	logged in as Corporate	\N	\N	\N	2024-12-09 22:36:44.353775+00	t	\N	6	\N
426	114	logged in as Patient	\N	\N	\N	2024-12-09 22:38:43.494507+00	t	\N	6	\N
427	119	logged in as Doctor	\N	\N	\N	2024-12-09 22:48:43.712642+00	t	\N	6	\N
428	1	logged in as Corporate	\N	\N	\N	2024-12-09 23:06:52.376679+00	t	\N	6	\N
429	1	logged in as Corporate	\N	\N	\N	2024-12-09 23:11:46.640075+00	t	\N	6	\N
430	114	logged in as Patient	\N	\N	\N	2024-12-13 10:15:20.296932+00	t	\N	6	\N
431	114	logged out as Patient	\N	\N	\N	2024-12-13 10:15:39.915252+00	t	\N	6	\N
432	1	logged in as Corporate	\N	\N	\N	2024-12-13 10:23:03.721812+00	t	\N	6	\N
433	1	logged in as Corporate	\N	\N	\N	2024-12-13 11:55:32.214262+00	t	\N	6	\N
434	114	logged in as Patient	\N	\N	\N	2024-12-13 20:56:21.389329+00	t	\N	6	\N
435	1	logged in as Corporate	\N	\N	\N	2024-12-13 20:56:53.432466+00	t	\N	6	\N
436	1	logged in as Corporate	\N	\N	\N	2024-12-13 21:50:52.160591+00	t	\N	6	\N
437	1	logged in as Corporate	\N	\N	\N	2024-12-14 00:49:29.961236+00	t	\N	6	\N
438	1	logged in as Corporate	\N	\N	\N	2024-12-14 12:07:02.831135+00	t	\N	6	\N
439	114	logged in as Patient	\N	\N	\N	2024-12-14 13:30:28.847052+00	t	\N	6	\N
440	114	logged out as Patient	\N	\N	\N	2024-12-14 13:30:39.939316+00	t	\N	6	\N
441	1	logged in as Corporate	\N	\N	\N	2024-12-14 13:31:13.491115+00	t	\N	6	\N
442	1	logged in as Corporate	\N	\N	\N	2024-12-15 13:42:32.664827+00	t	\N	6	\N
443	1	logged in as Corporate	\N	\N	\N	2024-12-15 15:19:12.25552+00	t	\N	6	\N
444	1	logged in as Corporate	\N	\N	\N	2024-12-15 15:19:13.088919+00	t	\N	6	\N
445	1	logged out as Corporate	\N	\N	\N	2024-12-16 14:24:35.009468+00	t	\N	6	\N
446	120	logged in as Patient	\N	\N	\N	2024-12-16 14:30:39.289123+00	t	\N	6	\N
447	1	logged in as Corporate	\N	\N	\N	2024-12-17 03:35:33.260063+00	t	\N	6	\N
448	1	logged in as Corporate	\N	\N	\N	2024-12-17 21:34:58.192712+00	t	\N	6	\N
449	121	logged in as Patient	\N	\N	\N	2024-12-18 07:57:57.598715+00	t	\N	6	\N
450	1	logged in as Corporate	\N	\N	\N	2024-12-18 13:41:27.863472+00	t	\N	6	\N
451	1	logged in as Corporate	\N	\N	\N	2024-12-18 13:45:37.381146+00	t	\N	6	\N
452	1	logged in as Corporate	\N	\N	\N	2024-12-22 13:49:32.980427+00	t	\N	6	\N
453	1	logged out as Corporate	\N	\N	\N	2024-12-22 20:22:51.672131+00	t	\N	6	\N
454	1	logged in as Corporate	\N	\N	\N	2024-12-22 20:27:45.925903+00	t	\N	6	\N
455	1	logged out as Corporate	\N	\N	\N	2024-12-22 22:02:05.796711+00	t	\N	6	\N
456	122	logged in as No Group	\N	\N	\N	2024-12-22 22:02:48.896267+00	t	\N	6	\N
457	1	logged out as Corporate	\N	\N	\N	2024-12-22 23:27:26.324937+00	t	\N	6	\N
458	3	logged in as Patient	\N	\N	\N	2024-12-22 23:27:43.595107+00	t	\N	6	\N
459	122	logged out as No Group	\N	\N	\N	2024-12-24 19:31:29.659545+00	t	\N	6	\N
460	1	logged in as Corporate	\N	\N	\N	2024-12-24 19:32:24.820052+00	t	\N	6	\N
461	1	logged in as Corporate	\N	\N	\N	2024-12-24 19:32:29.259272+00	t	\N	6	\N
462	1	logged out as Corporate	\N	\N	\N	2024-12-24 19:33:11.121759+00	t	\N	6	\N
463	123	logged in as Patient	\N	\N	\N	2024-12-24 19:33:49.401963+00	t	\N	6	\N
464	1	logged in as Corporate	\N	\N	\N	2024-12-25 13:59:21.429109+00	t	\N	6	\N
465	1	logged in as Corporate	\N	\N	\N	2024-12-25 13:59:23.052053+00	t	\N	6	\N
466	1	logged in as Corporate	\N	\N	\N	2024-12-25 13:59:26.430549+00	t	\N	6	\N
467	1	logged in as Corporate	\N	\N	\N	2024-12-25 13:59:29.806488+00	t	\N	6	\N
468	1	logged in as Corporate	\N	\N	\N	2024-12-25 13:59:37.03789+00	t	\N	6	\N
469	1	logged in as Corporate	\N	\N	\N	2024-12-25 13:59:38.120183+00	t	\N	6	\N
470	1	logged in as Corporate	\N	\N	\N	2024-12-25 13:59:38.597334+00	t	\N	6	\N
471	1	logged in as Corporate	\N	\N	\N	2024-12-25 13:59:40.322174+00	t	\N	6	\N
472	1	logged in as Corporate	\N	\N	\N	2024-12-25 13:59:40.742262+00	t	\N	6	\N
473	1	logged in as Corporate	\N	\N	\N	2024-12-25 13:59:41.275192+00	t	\N	6	\N
474	1	logged in as Corporate	\N	\N	\N	2024-12-25 13:59:41.751857+00	t	\N	6	\N
475	1	logged in as Corporate	\N	\N	\N	2024-12-25 13:59:42.486646+00	t	\N	6	\N
476	1	logged in as Corporate	\N	\N	\N	2024-12-25 13:59:43.306261+00	t	\N	6	\N
477	1	logged out as Corporate	\N	\N	\N	2024-12-27 07:41:37.795126+00	t	\N	6	\N
478	1	logged in as Corporate	\N	\N	\N	2024-12-27 08:02:40.72311+00	t	\N	6	\N
479	1	logged out as Corporate	\N	\N	\N	2024-12-27 08:18:48.356477+00	t	\N	6	\N
480	114	logged in as Patient	\N	\N	\N	2024-12-28 13:54:15.86644+00	t	\N	6	\N
481	124	logged in as Patient	\N	\N	\N	2024-12-29 13:57:36.488192+00	t	\N	6	\N
482	1	logged in as Corporate	\N	\N	\N	2024-12-29 14:00:56.085318+00	t	\N	6	\N
483	124	consulté leurs plans de traitement	\N	124	\N	2024-12-29 14:06:29.917936+00	t	\N	6	6
484	124	consulté leurs plans de traitement	\N	124	\N	2024-12-29 14:07:57.434424+00	t	\N	6	6
485	125	logged in as Patient	\N	\N	\N	2024-12-29 14:09:30.911092+00	t	\N	6	\N
486	1	logged in as Corporate	\N	\N	\N	2024-12-29 15:20:31.679849+00	t	\N	6	\N
487	124	عرض خطط العلاج الخاصة بهم	\N	124	\N	2024-12-29 21:03:46.679105+00	t	\N	6	6
488	1	logged in as Corporate	\N	\N	\N	2024-12-30 12:03:25.405144+00	t	\N	6	\N
489	1	logged in as Corporate	\N	\N	\N	2024-12-30 12:03:29.043749+00	t	\N	6	\N
490	1	logged in as Corporate	\N	\N	\N	2024-12-30 12:03:31.03618+00	t	\N	6	\N
491	1	logged in as Corporate	\N	\N	\N	2024-12-30 12:03:34.963697+00	t	\N	6	\N
492	1	logged in as Corporate	\N	\N	\N	2024-12-30 12:03:38.677719+00	t	\N	6	\N
493	1	logged in as Corporate	\N	\N	\N	2024-12-30 12:03:53.083873+00	t	\N	6	\N
494	1	logged in as Corporate	\N	\N	\N	2024-12-30 12:03:55.368085+00	t	\N	6	\N
495	1	logged in as Corporate	\N	\N	\N	2024-12-30 12:04:10.970385+00	t	\N	6	\N
496	114	logged in as Patient	\N	\N	\N	2024-12-31 02:45:54.488003+00	t	\N	6	\N
497	114	logged in as Patient	\N	\N	\N	2024-12-31 02:45:58.643058+00	t	\N	6	\N
498	1	logged out as Corporate	\N	\N	\N	2024-12-31 17:19:47.502677+00	t	\N	6	\N
499	1	logged in as Corporate	\N	\N	\N	2024-12-31 17:37:30.697659+00	t	\N	6	\N
500	1	logged out as Corporate	\N	\N	\N	2024-12-31 20:48:23.108919+00	t	\N	6	\N
501	114	logged in as Patient	\N	\N	\N	2025-01-05 08:40:51.690062+00	t	\N	6	\N
502	114	logged out as Patient	\N	\N	\N	2025-01-05 08:45:50.534055+00	t	\N	6	\N
503	126	logged in as Patient	\N	\N	\N	2025-01-16 16:59:50.80722+00	t	\N	6	\N
504	127	logged in as Patient	\N	\N	\N	2025-01-16 19:31:23.253405+00	t	\N	6	\N
505	127	logged in as Patient	\N	\N	\N	2025-01-16 19:32:10.669815+00	t	\N	6	\N
506	127	logged in as Patient	\N	\N	\N	2025-01-16 19:32:14.099462+00	t	\N	6	\N
507	114	logged in as Patient	\N	\N	\N	2025-01-17 16:28:22.177649+00	t	\N	6	\N
508	114	logged in as Patient	\N	\N	\N	2025-01-18 02:01:58.101425+00	t	\N	6	\N
509	114	logged in as Patient	\N	\N	\N	2025-01-18 10:53:22.922726+00	t	\N	6	\N
510	114	logged out as Patient	\N	\N	\N	2025-01-18 11:41:27.471447+00	t	\N	6	\N
511	114	logged in as Patient	\N	\N	\N	2025-01-18 12:45:09.570897+00	t	\N	6	\N
512	128	logged in as Patient	\N	\N	\N	2025-01-21 00:20:08.632692+00	t	\N	6	\N
513	128	logged in as Patient	\N	\N	\N	2025-01-21 00:25:36.024692+00	t	\N	6	\N
514	128	logged in as Patient	\N	\N	\N	2025-01-21 00:25:40.925817+00	t	\N	6	\N
515	128	logged in as Patient	\N	\N	\N	2025-01-21 00:25:43.716774+00	t	\N	6	\N
516	114	logged in as Patient	\N	\N	\N	2025-01-21 00:28:54.231097+00	t	\N	6	\N
517	1	logged in as Corporate	\N	\N	\N	2025-02-01 13:04:42.909571+00	t	\N	6	\N
518	1	logged in as Corporate	\N	\N	\N	2025-02-01 13:06:41.523425+00	t	\N	6	\N
519	1	logged in as Corporate	\N	\N	\N	2025-02-01 13:06:51.770832+00	t	\N	6	\N
520	1	logged in as Corporate	\N	\N	\N	2025-02-01 13:06:52.50087+00	t	\N	6	\N
521	1	logged in as Corporate	\N	\N	\N	2025-02-02 21:55:38.807406+00	t	\N	6	\N
522	1	logged in as Corporate	\N	\N	\N	2025-02-02 21:55:38.854378+00	t	\N	6	\N
523	1	logged in as Corporate	\N	\N	\N	2025-02-02 21:55:40.186699+00	t	\N	6	\N
524	129	logged in as Patient	\N	\N	\N	2025-02-10 16:14:31.352821+00	t	\N	6	\N
525	1	logged out as Corporate	\N	\N	\N	2025-02-10 16:15:00.63868+00	t	\N	6	\N
526	1	logged in as Corporate	\N	\N	\N	2025-02-10 16:15:20.397243+00	t	\N	6	\N
527	1	logged in as Corporate	\N	\N	\N	2025-02-10 16:15:47.96939+00	t	\N	6	\N
528	130	logged in as Patient	\N	\N	\N	2025-02-10 16:21:54.687364+00	t	\N	6	\N
529	131	logged in as Patient	\N	\N	\N	2025-02-21 17:38:38.352492+00	t	\N	6	\N
530	132	logged in as Patient	\N	\N	\N	2025-02-22 17:24:10.771463+00	t	\N	6	\N
531	133	logged in as Patient	\N	\N	\N	2025-02-23 11:18:07.663099+00	t	\N	6	\N
532	134	logged in as Patient	\N	\N	\N	2025-02-24 05:49:01.164954+00	t	\N	6	\N
533	1	logged in as Corporate	\N	\N	\N	2025-02-24 16:48:01.033035+00	t	\N	6	\N
534	135	logged in as Patient	\N	\N	\N	2025-02-24 16:54:01.666875+00	t	\N	6	\N
535	136	logged in as Patient	\N	\N	\N	2025-02-25 06:39:39.108336+00	t	\N	6	\N
536	114	logged in as Patient	\N	\N	\N	2025-02-25 07:29:17.106968+00	t	\N	6	\N
537	114	logged out as Patient	\N	\N	\N	2025-02-25 07:29:23.87008+00	t	\N	6	\N
538	137	logged in as Patient	\N	\N	\N	2025-02-25 14:35:49.655554+00	t	\N	6	\N
539	1	logged in as Corporate	\N	\N	\N	2025-02-25 14:45:59.449077+00	t	\N	6	\N
540	1	logged in as Corporate	\N	\N	\N	2025-02-25 15:20:46.870845+00	t	\N	6	\N
541	1	logged in as Corporate	\N	\N	\N	2025-02-25 15:20:51.622553+00	t	\N	6	\N
542	1	logged in as Corporate	\N	\N	\N	2025-02-25 15:20:53.043491+00	t	\N	6	\N
543	138	logged in as Patient	\N	\N	\N	2025-02-26 07:29:36.139903+00	t	\N	6	\N
544	139	logged in as Patient	\N	\N	\N	2025-02-28 04:52:05.948324+00	t	\N	6	\N
545	140	logged in as Patient	\N	\N	\N	2025-03-01 15:06:26.791396+00	t	\N	6	\N
546	142	logged in as Patient	\N	\N	\N	2025-03-02 10:34:33.820631+00	t	\N	6	\N
547	143	logged in as Patient	\N	\N	\N	2025-03-03 02:18:48.842538+00	t	\N	6	\N
548	144	logged in as Patient	\N	\N	\N	2025-03-04 03:07:55.12819+00	t	\N	6	\N
549	145	logged in as Patient	\N	\N	\N	2025-03-05 04:18:44.120214+00	t	\N	6	\N
550	146	logged in as Patient	\N	\N	\N	2025-03-06 05:58:28.434131+00	t	\N	6	\N
551	148	logged in as Patient	\N	\N	\N	2025-03-08 08:23:47.845562+00	t	\N	6	\N
552	149	logged in as Patient	\N	\N	\N	2025-03-09 05:19:15.720127+00	t	\N	6	\N
553	1	logged in as Corporate	\N	\N	\N	2025-03-09 17:30:16.371884+00	t	\N	6	\N
554	1	logged in as Corporate	\N	\N	\N	2025-03-09 17:30:20.262911+00	t	\N	6	\N
555	1	logged in as Corporate	\N	\N	\N	2025-03-09 22:34:17.717892+00	t	\N	6	\N
556	1	logged in as Corporate	\N	\N	\N	2025-03-09 23:03:41.598389+00	t	\N	6	\N
557	1	logged in as Corporate	\N	\N	\N	2025-03-09 23:03:42.721643+00	t	\N	6	\N
558	1	logged in as Corporate	\N	\N	\N	2025-03-10 08:39:54.822408+00	t	\N	6	\N
559	151	logged in as Patient	\N	\N	\N	2025-03-10 16:19:07.171258+00	t	\N	6	\N
560	1	logged out as Corporate	\N	\N	\N	2025-03-11 04:54:12.733366+00	t	\N	6	\N
561	114	logged in as Patient	\N	\N	\N	2025-03-11 04:54:28.516835+00	t	\N	6	\N
562	114	logged in as Patient	\N	\N	\N	2025-03-11 04:54:31.122768+00	t	\N	6	\N
563	152	logged in as Patient	\N	\N	\N	2025-03-12 12:35:09.694116+00	t	\N	6	\N
564	153	logged in as Patient	\N	\N	\N	2025-03-13 21:12:43.19522+00	t	\N	6	\N
565	154	logged in as Patient	\N	\N	\N	2025-03-14 20:11:35.305116+00	t	\N	6	\N
566	155	logged in as Patient	\N	\N	\N	2025-03-15 15:08:17.232124+00	t	\N	6	\N
567	156	logged in as Patient	\N	\N	\N	2025-03-16 09:31:24.40297+00	t	\N	6	\N
568	157	logged in as Patient	\N	\N	\N	2025-03-17 04:08:59.525772+00	t	\N	6	\N
569	158	logged in as Patient	\N	\N	\N	2025-03-17 12:58:58.806861+00	t	\N	6	\N
570	159	logged in as Patient	\N	\N	\N	2025-03-18 10:46:28.908316+00	t	\N	6	\N
571	160	logged in as Patient	\N	\N	\N	2025-03-19 20:12:29.235921+00	t	\N	6	\N
572	161	logged in as Patient	\N	\N	\N	2025-03-21 06:14:43.294276+00	t	\N	6	\N
573	162	logged in as Patient	\N	\N	\N	2025-03-21 22:38:18.713161+00	t	\N	6	\N
574	163	logged in as Patient	\N	\N	\N	2025-03-22 12:24:31.84293+00	t	\N	6	\N
575	164	logged in as Patient	\N	\N	\N	2025-03-23 18:46:30.811698+00	t	\N	6	\N
576	165	logged in as Patient	\N	\N	\N	2025-03-24 12:10:37.902442+00	t	\N	6	\N
577	166	logged in as Patient	\N	\N	\N	2025-03-25 16:47:32.491896+00	t	\N	6	\N
578	167	logged in as Patient	\N	\N	\N	2025-03-26 00:40:40.011719+00	t	\N	6	\N
\.


--
-- Data for Name: actstream_follow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.actstream_follow (id, object_id, actor_only, started, content_type_id, user_id, flag) FROM stdin;
\.


--
-- Data for Name: apps_accommodation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apps_accommodation (id, treatment_plan_id, user_id, duration_of_stay, hotel_id) FROM stdin;
1	4	118	7	2
2	3	118	7	2
3	6	117	6	1
\.


--
-- Data for Name: apps_appointment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apps_appointment (id, date, duration, doctor_id, patient_id) FROM stdin;
1	2024-11-19 10:00:00+00	180	119	118
\.


--
-- Data for Name: apps_contact; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apps_contact (id, first_name, last_name, email, message) FROM stdin;
\.


--
-- Data for Name: apps_emailtemplate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apps_emailtemplate (id, name, subject, body) FROM stdin;
1	Welcome Email	Welcome to our service!	Hello {username}, welcome to our service!
2	Password Reset	Password Reset Request	Click the link to reset your password: {reset_link}
\.


--
-- Data for Name: apps_emergencycontact; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apps_emergencycontact (id, first_name, last_name, phone_number, relationship) FROM stdin;
1	LOTFI	KANOUNI	05380546393	Manager
\.


--
-- Data for Name: apps_flightreservation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apps_flightreservation (id, arrival_date, arrival_hour, arrival_flight_number, departure_date, departure_hour, departure_flight_number, user_id) FROM stdin;
1	2024-11-18	14:25:00	TK-18	2024-11-28	18:30:00	TK-17	118
\.


--
-- Data for Name: apps_homepage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apps_homepage (page_ptr_id, intro) FROM stdin;
\.


--
-- Data for Name: apps_hospital; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apps_hospital (id, name, address, city, state, zipcode) FROM stdin;
3	DENTAL SERVICES	SERVICES	ISTANBUK	TÜRKIYE	00
4	ESTHTIC SURGERIES	SERVICES	ISTANBUL	TÜRKIYE	00
5	GASTRICS	Weight Loss	ISTANBUL	TÜRKIYE	00
6	HAIR RESTORATION	SERVICES	ISTANBUK	TÜRKIYE	00
7	INTERNAL SURGERIES	SERVICES	ISTANBUL	TÜRKIYE	00
\.


--
-- Data for Name: apps_hospitalstay; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apps_hospitalstay (id, admission, discharge, hospital_id, patient_id) FROM stdin;
6	2024-07-20 20:54:38.241663+00	\N	5	12
7	2024-07-20 21:17:08.331518+00	\N	3	13
8	2024-07-20 21:19:38.776575+00	\N	3	14
9	2024-07-21 04:32:46.389016+00	\N	3	15
10	2024-07-21 04:38:46.064939+00	\N	6	18
11	2024-07-21 06:14:58.7806+00	\N	7	22
12	2024-07-21 06:34:51.727669+00	\N	3	23
13	2024-07-21 06:35:40.161501+00	\N	3	24
14	2024-07-21 06:36:52.778753+00	\N	3	25
15	2024-07-21 06:38:07.463496+00	\N	3	26
16	2024-07-21 07:06:55.703872+00	\N	3	27
17	2024-07-21 07:10:02.439806+00	\N	6	28
18	2024-07-21 07:23:32.369562+00	\N	3	29
19	2024-07-21 07:24:10.152594+00	\N	3	30
20	2024-07-21 08:16:18.829538+00	\N	5	31
21	2024-07-21 08:18:13.71778+00	\N	3	32
22	2024-07-21 08:20:49.977865+00	\N	3	33
23	2024-07-21 09:35:28.195561+00	\N	3	36
24	2024-07-21 09:39:01.99458+00	\N	4	38
25	2024-07-25 08:08:07.087246+00	\N	6	39
26	2024-07-29 23:10:59.899583+00	\N	3	40
32	2024-08-06 04:16:06.392894+00	\N	3	46
33	2024-08-06 04:22:06.42978+00	\N	3	47
34	2024-08-06 04:28:29.543271+00	\N	3	48
35	2024-08-06 04:29:39.212606+00	\N	3	49
36	2024-08-06 04:35:13.385847+00	\N	3	50
37	2024-08-06 04:42:22.558423+00	\N	3	51
38	2024-08-06 04:57:00.983895+00	\N	3	52
39	2024-08-06 05:31:02.328699+00	\N	3	53
40	2024-08-06 05:40:05.510775+00	\N	3	54
41	2024-08-06 05:42:44.664388+00	\N	3	55
42	2024-08-06 08:08:24.477964+00	\N	3	56
43	2024-08-06 08:16:51.056773+00	\N	3	57
44	2024-08-06 12:16:49.560217+00	\N	3	58
45	2024-08-06 12:20:30.343554+00	\N	3	59
46	2024-08-06 12:22:15.216922+00	\N	3	60
47	2024-08-09 00:21:55.194718+00	\N	3	61
48	2024-08-09 03:46:09.140772+00	\N	5	62
49	2024-08-09 04:19:14.108675+00	\N	3	63
50	2024-08-09 04:21:03.581763+00	\N	3	64
51	2024-08-09 04:35:27.276735+00	\N	3	65
52	2024-08-09 06:21:49.431509+00	\N	3	66
53	2024-08-09 07:09:48.24378+00	\N	3	67
54	2024-08-19 14:40:52.694088+00	\N	3	68
55	2024-08-19 15:34:49.55483+00	\N	3	69
56	2024-08-22 03:45:49.940108+00	\N	3	70
57	2024-08-22 03:52:06.564123+00	\N	3	71
58	2024-08-28 20:50:48.568763+00	\N	3	73
59	2024-08-28 21:00:04.856971+00	\N	3	74
60	2024-08-28 21:04:13.330579+00	\N	3	75
61	2024-08-28 21:16:37.301002+00	\N	4	76
62	2024-09-01 14:50:33.030345+00	\N	3	2
63	2024-09-03 23:16:53.133789+00	\N	3	77
64	2024-09-03 23:19:03.711783+00	\N	3	78
65	2024-09-03 23:34:29.593349+00	\N	5	79
66	2024-09-04 01:07:29.383113+00	\N	3	82
76	2024-09-16 22:18:58.439551+00	\N	3	92
77	2024-09-16 22:22:58.206489+00	\N	3	93
78	2024-09-30 21:01:37.068019+00	\N	3	94
79	2024-10-02 02:12:57.730489+00	\N	3	95
80	2024-10-02 02:17:50.066123+00	\N	3	96
81	2024-10-02 02:18:12.068386+00	\N	3	97
82	2024-10-02 02:18:56.151387+00	\N	3	98
84	2024-10-25 21:28:18.997185+00	\N	3	102
85	2024-10-25 22:14:33.774128+00	\N	3	103
86	2024-10-25 23:44:46.031691+00	\N	3	104
87	2024-10-25 23:54:47.422448+00	\N	3	105
88	2024-10-26 11:04:06.387478+00	\N	3	106
89	2024-10-26 17:03:44.40215+00	\N	3	107
90	2024-11-06 19:39:36.978135+00	\N	3	108
91	2024-11-06 19:42:53.414933+00	\N	3	109
92	2024-11-06 19:56:04.41991+00	\N	3	110
93	2024-11-10 20:50:38.161205+00	\N	3	112
94	2024-11-11 18:19:59.695198+00	\N	3	114
95	2024-11-13 21:47:15.921776+00	\N	3	115
96	2024-11-14 14:50:56.49163+00	\N	3	116
97	2024-11-14 15:15:05.655694+00	\N	3	117
98	2024-11-14 18:23:18.987335+00	\N	3	118
99	2024-11-14 20:55:31.471646+00	\N	3	119
100	2024-12-16 14:30:36.390671+00	\N	3	120
101	2024-12-18 07:57:54.684648+00	\N	3	121
102	2024-12-24 19:33:42.124058+00	\N	3	123
103	2024-12-29 13:57:28.210158+00	\N	3	124
104	2024-12-29 14:09:21.563345+00	\N	3	125
105	2025-01-16 16:59:45.089192+00	\N	3	126
106	2025-01-16 19:31:15.653509+00	\N	3	127
107	2025-01-21 00:19:59.752185+00	\N	3	128
108	2025-02-10 16:14:28.276936+00	\N	3	129
109	2025-02-10 16:21:51.505661+00	\N	3	130
110	2025-02-24 16:53:58.642885+00	\N	3	135
111	2025-02-25 14:35:46.723906+00	\N	3	137
112	2025-03-17 12:58:55.852275+00	\N	4	158
\.


--
-- Data for Name: apps_hotel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apps_hotel (id, name, address, room_type, price_per_night, amenities, availability, rating) FROM stdin;
1	Bekdas Hotel Deluxe & Spa	Mimar Kemalettin, Derin Kuyu Sk. No:4, 34130 Fatih/İstanbul	Double	55		t	4
2	EYFEL HOTEL	Balabanağa, EYFEL HOTEL, Kurultay Sk. 19 A No:19, Fatih	Double	60		t	4
\.


--
-- Data for Name: apps_insurance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apps_insurance (id, policy_number, company) FROM stdin;
1		
2		
3		
4		
5		
6	default_policy	default_company
7	default_policy	default_company
8	default_policy	default_company
9	default_policy	default_company
10	default_policy	default_company
11	default_policy	default_company
12	default_policy	default_company
13	default_policy	default_company
14	\N	\N
15	\N	\N
16	\N	\N
17	\N	\N
18	\N	\N
19	\N	\N
20	\N	\N
21	\N	\N
22	\N	\N
23	\N	\N
24	\N	\N
25	\N	\N
26	\N	\N
27	\N	\N
28	\N	\N
29	\N	\N
30	\N	\N
31	\N	\N
32	\N	\N
33	\N	\N
34	\N	\N
35	\N	\N
36	None	None
37	\N	\N
38	None	None
39	\N	\N
40	\N	\N
41	\N	\N
42	\N	\N
43	\N	\N
44	\N	\N
45	\N	\N
46	\N	\N
47	\N	\N
48	\N	\N
49	\N	\N
50	\N	\N
51	\N	\N
52	\N	\N
53	\N	\N
54	\N	\N
55	\N	\N
56	\N	\N
57	None	None
58	\N	\N
59	\N	\N
60	\N	\N
61	\N	\N
62	\N	\N
63	\N	\N
64	\N	\N
65	\N	\N
66	\N	\N
67	\N	\N
68	\N	\N
69	\N	\N
70	\N	\N
71	\N	\N
72	\N	\N
73	\N	\N
74	\N	\N
75	\N	\N
76	\N	\N
77	\N	\N
78	\N	\N
79	\N	\N
80	\N	\N
81	\N	\N
82	\N	\N
83	\N	\N
84	\N	\N
85	\N	\N
86	\N	\N
87	\N	\N
88	\N	\N
89	\N	\N
90	\N	\N
91	\N	\N
92	\N	\N
93	None	None
94	\N	\N
95	\N	\N
96	\N	\N
97	\N	\N
98	\N	\N
99	\N	\N
100	\N	\N
101	\N	\N
102	\N	\N
103	\N	\N
104	\N	\N
105	\N	\N
106	\N	\N
107	\N	\N
108	\N	\N
109	\N	\N
110	\N	\N
111	\N	\N
112	\N	\N
113	\N	\N
114	\N	\N
115	\N	\N
116	\N	\N
117	\N	\N
118	\N	\N
119	\N	\N
120	\N	\N
121	None	None
122	\N	\N
123	\N	\N
124	\N	\N
125	\N	\N
126	\N	\N
127	None	None
128	\N	\N
129	\N	\N
130	\N	\N
131	\N	\N
132	\N	\N
133	\N	\N
134	\N	\N
135	\N	\N
136	\N	\N
137	\N	\N
138	\N	\N
139	\N	\N
140	\N	\N
141	\N	\N
142	\N	\N
143	\N	\N
144	\N	\N
145	\N	\N
146	\N	\N
147	\N	\N
148	\N	\N
149	\N	\N
150	\N	\N
151	\N	\N
152	\N	\N
153	\N	\N
154	\N	\N
155	\N	\N
156	\N	\N
157	\N	\N
158	\N	\N
159	\N	\N
160	\N	\N
161	\N	\N
162	\N	\N
163	\N	\N
164	\N	\N
165	\N	\N
166	\N	\N
167	\N	\N
168	\N	\N
169	\N	\N
170	\N	\N
171	\N	\N
172	\N	\N
173	\N	\N
174	\N	\N
175	\N	\N
\.


--
-- Data for Name: apps_medicalfile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apps_medicalfile (id, file, upload_timestamp, medical_information_id, user_id) FROM stdin;
1	docs/users/patient/59/zoom-logo-2_Qm1pc0a.jpg	2024-08-29 06:06:10.954381+00	\N	59
2	docs/users/patient/2/1900838.png	2024-09-01 10:33:30.423113+00	\N	2
3	docs/users/patient/2/1900838_QtHQPhW.png	2024-09-01 12:29:47.136667+00	\N	2
4	docs/users/patient/2/1900838_iQ7tNgC.png	2024-09-01 12:29:47.140135+00	\N	2
5	docs/users/patient/2/file_8ad86e6d-6396-4987-a541-80b.jpg	2024-09-01 12:33:02.703181+00	\N	2
6	docs/users/patient/2/Screenshot_2024-09-01_171744.png	2024-09-01 14:20:16.782102+00	\N	2
7	docs/users/patient/2/Screenshot_2024-09-01_121301.png	2024-09-01 14:46:39.474267+00	\N	2
8	docs/users/patient/27/1900838.png	2024-09-03 16:54:55.823486+00	\N	27
9	docs/users/patient/48/1900838.png	2024-09-03 17:19:47.81504+00	\N	48
10	docs/users/patient/29/1900838.png	2024-09-03 19:31:37.987408+00	\N	29
11	docs/users/patient/77/images.jpeg	2024-09-03 23:29:02.934937+00	\N	77
12	docs/users/patient/77/images_MOVyFJV.jpeg	2024-09-03 23:29:09.788809+00	\N	77
13	docs/users/patient/77/images_Q9ZqVip.jpeg	2024-09-03 23:29:21.56196+00	\N	77
14	docs/users/patient/72/treatment_plans_lukas.schmidtgmail.com_3.pdf	2024-09-04 02:17:31.481234+00	\N	72
16	docs/users/patient/54/1.mp4	2024-09-05 11:25:18.341996+00	\N	54
17	docs/users/patient/57/klinigimiz.png	2024-09-15 06:55:18.591146+00	\N	57
18	docs/users/patient/73/Screenshot_20240917_014359_Instagram.jpg	2024-09-21 01:17:13.223839+00	\N	73
19	docs/users/patient/95/test-mic.wav	2024-10-02 02:24:55.530977+00	\N	95
21	docs/users/patient/116/Screenshot_20241114_032508_Instagram.jpg	2024-11-14 14:51:28.207673+00	\N	116
22	docs/users/patient/118/CBCT_report.pdf	2024-11-14 18:25:35.734561+00	\N	118
23	docs/users/patient/118/CBCT_report_ymzxPvZ.pdf	2024-11-14 18:25:43.313782+00	\N	118
24	docs/users/patient/117/WhatsApp_Image_2024-11-13_at_19.54.41.jpeg	2024-11-15 00:10:46.497661+00	\N	117
25	docs/users/patient/121/K0011-03_V01-BLX_Implant_System.png	2024-12-18 08:23:14.659904+00	\N	121
26	docs/users/patient/3/1.png	2024-12-22 23:27:54.031498+00	\N	3
27	docs/users/patient/124/20241228_134640.jpg	2024-12-29 13:58:43.142785+00	\N	124
28	docs/users/patient/114/shortvutd.kksrc	2025-01-18 10:53:47.183186+00	\N	114
29	docs/users/patient/137/cscs.txt	2025-02-25 14:44:53.606104+00	\N	137
\.


--
-- Data for Name: apps_medicalinformation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apps_medicalinformation (id, medications, allergies, medical_conditions, family_history, additional_info, insurance_id, sex) FROM stdin;
1		amoxivilin				1	Female
2						2	
3						3	
4						4	
5						5	
6	\N	\N	\N	\N	\N	6	
7	\N	\N	\N	\N	\N	7	
8	\N	\N	\N	\N	\N	8	
9	\N	\N	\N	\N	\N	9	
10	\N	\N	\N	\N	\N	10	
11	\N	\N	\N	\N	\N	11	
12	\N	\N	\N	\N	\N	12	
13	\N	\N	\N	\N	\N	13	
14	\N	\N	\N	\N	\N	15	\N
15	\N	\N	\N	\N	\N	16	\N
16	\N	\N	\N	\N	\N	17	\N
17	\N	\N	\N	\N	\N	18	\N
18	\N	\N	\N	\N	\N	19	\N
19	\N	\N	\N	\N	\N	21	\N
20	\N	\N	\N	\N	\N	22	\N
21	\N	\N	\N	\N	\N	23	\N
22	\N	\N	\N	\N	\N	24	\N
23	\N	\N	\N	\N	\N	25	\N
24	\N	\N	\N	\N	\N	26	\N
25	\N	\N	\N	\N	\N	27	\N
26	\N	\N	\N	\N	\N	28	\N
27	\N	\N	\N	\N	\N	29	\N
28	\N	\N	\N	\N	\N	30	\N
29	\N	\N	\N	\N	\N	31	\N
30	\N	\N	\N	\N	\N	32	\N
31	\N	\N	\N	\N	\N	33	\N
32	\N	\N	\N	\N	\N	34	\N
33	\N	\N	\N	\N	\N	35	\N
34	None	None	None	None	None	36	
35	\N	\N	\N	\N	\N	37	\N
36	None	None	None	None	None	38	Female
37	\N	\N	\N	\N	\N	39	\N
38	\N	\N	\N	\N	\N	40	\N
39	\N	\N	\N	\N	\N	41	\N
40	\N	\N	\N	\N	\N	42	\N
41	\N	\N	\N	\N	\N	43	\N
42	\N	\N	\N	\N	\N	44	\N
43	\N	\N	\N	\N	\N	45	\N
44	\N	\N	\N	\N	\N	46	\N
45	\N	\N	\N	\N	\N	47	\N
46	\N	\N	\N	\N	\N	48	\N
47	\N	\N	\N	\N	\N	49	\N
48	\N	\N	\N	\N	\N	50	\N
49	\N	\N	\N	\N	\N	51	\N
50	\N	\N	\N	\N	\N	52	\N
51	\N	\N	\N	\N	\N	53	\N
52	\N	\N	\N	\N	\N	54	\N
53	\N	\N	\N	\N	\N	55	\N
54	\N	\N	\N	\N	\N	56	\N
55	None	None	None	None	None	57	Male
56	\N	\N	\N	\N	\N	58	\N
57	\N	\N	\N	\N	\N	59	\N
58	\N	\N	\N	\N	\N	60	\N
59	\N	\N	\N	\N	\N	61	\N
60	\N	\N	\N	\N	\N	62	\N
61	\N	\N	\N	\N	\N	63	\N
62	\N	\N	\N	\N	\N	64	\N
63	\N	\N	\N	\N	\N	65	\N
64	\N	\N	\N	\N	\N	66	\N
65	\N	\N	\N	\N	\N	67	\N
66	\N	\N	\N	\N	\N	68	\N
67	\N	\N	\N	\N	\N	69	\N
68	\N	\N	\N	\N	\N	70	\N
69	\N	\N	\N	\N	\N	71	\N
70	\N	\N	\N	\N	\N	72	\N
71	\N	\N	\N	\N	\N	73	\N
72	\N	\N	\N	\N	\N	74	\N
73	\N	\N	\N	\N	\N	75	\N
74	\N	\N	\N	\N	\N	76	\N
75	\N	\N	\N	\N	\N	77	\N
76	\N	\N	\N	\N	\N	78	\N
77	\N	\N	\N	\N	\N	79	\N
78	\N	\N	\N	\N	\N	80	\N
79	\N	\N	\N	\N	\N	81	\N
80	\N	\N	\N	\N	\N	82	\N
81	\N	\N	\N	\N	\N	83	\N
82	\N	\N	\N	\N	\N	84	\N
83	\N	\N	\N	\N	\N	85	\N
84	\N	\N	\N	\N	\N	86	\N
85	\N	\N	\N	\N	\N	87	\N
86	\N	\N	\N	\N	\N	88	\N
87	\N	\N	\N	\N	\N	89	\N
88	\N	\N	\N	\N	\N	90	\N
89	\N	\N	\N	\N	\N	91	\N
90	\N	\N	\N	\N	\N	92	\N
91	None	None	None	None	None	93	Male
92	\N	\N	\N	\N	\N	94	\N
93	\N	\N	\N	\N	\N	95	\N
94	\N	\N	\N	\N	\N	96	\N
95	\N	\N	\N	\N	\N	97	\N
96	\N	\N	\N	\N	\N	98	\N
97	\N	\N	\N	\N	\N	99	\N
98	\N	\N	\N	\N	\N	100	\N
99	\N	\N	\N	\N	\N	101	\N
100	\N	\N	\N	\N	\N	102	\N
101	\N	\N	\N	\N	\N	103	\N
102	\N	\N	\N	\N	\N	104	\N
103	\N	\N	\N	\N	\N	105	\N
104	\N	\N	\N	\N	\N	106	\N
105	\N	\N	\N	\N	\N	107	\N
106	\N	\N	\N	\N	\N	108	\N
107	\N	\N	\N	\N	\N	109	\N
108	\N	\N	\N	\N	\N	110	\N
109	\N	\N	\N	\N	\N	111	\N
110	\N	\N	\N	\N	\N	112	\N
111	\N	\N	\N	\N	\N	113	\N
112	\N	\N	\N	\N	\N	114	\N
113	\N	\N	\N	\N	\N	115	\N
114	\N	\N	\N	\N	\N	116	\N
115	\N	\N	\N	\N	\N	117	\N
116	\N	\N	\N	\N	\N	118	\N
117	\N	\N	\N	\N	\N	119	\N
118	\N	\N	\N	\N	\N	120	\N
119	None	None	None	None	None	121	
120	\N	\N	\N	\N	\N	122	\N
121	\N	\N	\N	\N	\N	123	\N
122	\N	\N	\N	\N	\N	124	\N
123	\N	\N	\N	\N	\N	125	\N
124	\N	\N	\N	\N	\N	126	\N
125	Tjorn insulin - \r\nSyngardy 12.5/1000mg\r\nsandoz Rosuvastatin 10 mg \r\nperindoplamine  5 mg		diabetes	Diabetes	None	127	Female
126	\N	\N	\N	\N	\N	128	\N
127	\N	\N	\N	\N	\N	129	\N
128	\N	\N	\N	\N	\N	130	\N
129	\N	\N	\N	\N	\N	131	\N
130	\N	\N	\N	\N	\N	132	\N
131	\N	\N	\N	\N	\N	133	\N
132	\N	\N	\N	\N	\N	134	\N
133	\N	\N	\N	\N	\N	135	\N
134	\N	\N	\N	\N	\N	136	\N
135	\N	\N	\N	\N	\N	137	\N
136	\N	\N	\N	\N	\N	138	\N
137	\N	\N	\N	\N	\N	139	\N
138	\N	\N	\N	\N	\N	140	\N
139	\N	\N	\N	\N	\N	141	\N
140	\N	\N	\N	\N	\N	142	\N
141	\N	\N	\N	\N	\N	143	\N
142	\N	\N	\N	\N	\N	144	\N
143	\N	\N	\N	\N	\N	145	\N
144	\N	\N	\N	\N	\N	146	\N
145	\N	\N	\N	\N	\N	147	\N
146	\N	\N	\N	\N	\N	148	\N
147	\N	\N	\N	\N	\N	149	\N
148	\N	\N	\N	\N	\N	150	\N
149	\N	\N	\N	\N	\N	151	\N
150	\N	\N	\N	\N	\N	152	\N
151	\N	\N	\N	\N	\N	153	\N
152	\N	\N	\N	\N	\N	154	\N
153	\N	\N	\N	\N	\N	155	\N
154	\N	\N	\N	\N	\N	156	\N
155	\N	\N	\N	\N	\N	157	\N
156	\N	\N	\N	\N	\N	158	\N
157	\N	\N	\N	\N	\N	159	\N
158	\N	\N	\N	\N	\N	160	\N
159	\N	\N	\N	\N	\N	161	\N
160	\N	\N	\N	\N	\N	162	\N
161	\N	\N	\N	\N	\N	163	\N
162	\N	\N	\N	\N	\N	164	\N
163	\N	\N	\N	\N	\N	165	\N
164	\N	\N	\N	\N	\N	166	\N
165	\N	\N	\N	\N	\N	167	\N
166	\N	\N	\N	\N	\N	168	\N
167	\N	\N	\N	\N	\N	169	\N
168	\N	\N	\N	\N	\N	170	\N
169	\N	\N	\N	\N	\N	171	\N
170	\N	\N	\N	\N	\N	172	\N
171	\N	\N	\N	\N	\N	173	\N
172	\N	\N	\N	\N	\N	174	\N
173	\N	\N	\N	\N	\N	175	\N
\.


--
-- Data for Name: apps_message; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apps_message (id, body, date, group_id, sender_id) FROM stdin;
1	23	2024-07-19 01:30:37.297148+00	1	4
2	ss	2024-07-19 01:35:53.628085+00	2	4
3	ss	2024-07-19 01:35:53.735413+00	3	4
4	11	2024-07-19 01:41:59.383835+00	4	4
5	12211221	2024-07-19 02:49:16.876735+00	5	3
6	123	2024-07-21 07:53:48.718188+00	6	10
7	TEST1	2024-07-25 08:09:49.368601+00	7	3
8	OK	2024-07-25 08:12:22.514262+00	8	3
9	xx	2024-08-28 20:32:44.928654+00	9	8
10	good news..	2024-08-29 19:20:18.248248+00	10	76
11	Hi Dr Naci i will be arriving in turkey on the 18th Monday . I have an appointment booked with you by lofti kanouni. \r\nI am only intrested in tearment option 1 all on 6 not option 2 \r\nI would like to recieve my invoice with the reduction in tickets that i paid for .\r\nplease advise\r\n1. share your certification  from ministry of tourism \r\n2. hotel confirmation =7 days I would need that\r\n3. implants used 4 treatment plan with price reduction -11480 first visit 8400-2160 euros 6234 euros\r\n  5 NO CASH PAYMENT only credit card due to lots of scams happening there\r\n	2024-11-15 18:54:16.436969+00	11	118
\.


--
-- Data for Name: apps_message_read_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apps_message_read_members (id, message_id, user_id) FROM stdin;
\.


--
-- Data for Name: apps_messagegroup; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apps_messagegroup (id, name) FROM stdin;
1	test
2	test
3	test
4	test1
5	teest
6	123
7	TEST1
8	OK
9	Nurse
10	congratulations!
11	All on 6 treatment plan 
\.


--
-- Data for Name: apps_messagegroup_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apps_messagegroup_members (id, messagegroup_id, user_id) FROM stdin;
1	1	4
2	1	3
3	2	4
4	2	2
5	3	4
6	3	2
7	4	4
8	4	2
9	5	3
10	5	4
11	6	10
12	6	14
13	7	3
14	7	39
15	8	3
16	8	39
17	9	8
18	9	39
19	10	76
20	10	32
21	11	118
22	11	119
\.


--
-- Data for Name: apps_patientschedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apps_patientschedule (id, notes, accommodation_id, appointment_id, flight_reservation_id, hospital_id, user_id) FROM stdin;
1		2	1	1	3	118
2		3	1	1	3	117
\.


--
-- Data for Name: apps_prescription; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apps_prescription (id, name, dosage, directions, prescribed, active, patient_id) FROM stdin;
1	DOLIPRANE	200 MG	MORNING AND EVENING	2024-07-17 13:12:08+00	t	2
\.


--
-- Data for Name: apps_referral; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apps_referral (id, created_at, referrer_id, referred_id, code) FROM stdin;
1	2024-07-21 04:32:46.359618+00	3	\N	ab6c91a8c0
2	2024-07-21 04:38:46.043506+00	15	\N	4152f3f731
3	2024-07-21 06:14:58.75048+00	2	22	3c5c3a06ca
4	2024-07-21 06:35:40.138746+00	17	24	0d03e598b0
5	2024-07-21 06:36:52.751525+00	17	25	0d03e598b0
6	2024-07-21 06:38:07.438988+00	3	26	ab6c91a8c0
7	2024-07-21 07:06:55.678195+00	2	27	3c5c3a06ca
8	2024-07-21 07:06:55.797913+00	2	27	3c5c3a06ca
9	2024-07-21 07:10:02.412006+00	2	28	3c5c3a06ca
10	2024-07-21 07:10:02.51764+00	2	28	3c5c3a06ca
11	2024-07-21 07:23:32.346294+00	2	29	3c5c3a06ca
12	2024-07-21 07:24:10.13155+00	2	30	3c5c3a06ca
13	2024-07-21 08:18:13.694162+00	2	32	3c5c3a06ca
14	2024-07-21 08:20:49.953621+00	28	33	50b6279ac6
15	2024-07-21 09:35:28.164677+00	34	36	e38ebf5471
16	2024-07-21 09:38:08.987225+00	34	37	e38ebf5471
17	2024-07-21 09:39:01.982678+00	34	38	e38ebf5471
18	2024-08-28 21:04:13.306577+00	74	75	51810ed8f6
19	2024-09-03 23:34:29.560538+00	77	79	61dd1a8ed2
\.


--
-- Data for Name: apps_subscription; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apps_subscription (id, email) FROM stdin;
\.


--
-- Data for Name: apps_treatmentplan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apps_treatmentplan (id, created_at, updated_at, doctor_id, patient_id, total_price, final_discount_percentage, subtotal, discount_amount) FROM stdin;
3	2024-11-14 22:34:17.964068+00	2024-11-14 23:59:13.499206+00	119	118	11479.72	0	12056	576.28
4	2024-11-14 23:36:26.868963+00	2024-11-15 00:04:17.26086+00	119	118	17500.34	0	18568	1067.66
6	2024-11-15 00:14:10.511991+00	2024-11-15 03:21:56.674658+00	119	117	11453.2	0	12056	602.8
7	2024-11-15 03:06:15.115553+00	2024-11-15 03:06:32.331234+00	119	117	450	0	450	0
8	2024-12-29 14:04:38.623739+00	2024-12-29 14:04:38.644741+00	119	124	0	5	0	0
\.


--
-- Data for Name: apps_treatmentplanitem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apps_treatmentplanitem (id, quantity, treatment_plan_id, product_id, discount_percentage) FROM stdin;
7	12	3	6	12
8	28	3	9	50
9	2	3	7	100
10	1	3	8	100
11	4	4	10	10
12	8	4	6	12
13	28	4	9	50
16	12	6	6	12
17	28	6	9	50
18	2	6	7	100
19	1	7	8	0
20	2	7	7	0
21	6	8	11	10.0
22	20	8	9	0.0
\.


--
-- Data for Name: apps_treatmentproduct; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apps_treatmentproduct (id, name, slug, category, description, price, is_active, image, max_discount_percentage) FROM stdin;
1	BEGO Semados  RSX Pro	bego-semados-rsx-pro	Implants	4.1 L11.5, 1 unit	350	t	products/2024/08/29/file_8ad86e6d-6396-4987-a541-80b.jpg	35
2	IMPLANCE Bone Level	implance-bone-level	Implants	ø3.3\r\nLength (mm)\r\n8.0\r\n10.0\r\n12.0\r\n14.0	250	t	products/2024/08/29/Screenshot_2024-08-29_040629.png	35
3	IVOCLAR IPS e.max	ivoclar-ips-emax	Crowns	IPS e.max\r\nZirCAD Prime	190	t	products/2024/08/29/Screenshot_2024-08-29_041003.png	35
4	Philips Zoom! WhiteSpeed	philips-zoom-whitespeed	Additional Services	Chairside Whitening	120	t	products/2024/08/29/zoom-logo-2.jpg	35
5	Root Canal & Endodontics	root-canal-endodontics	Dental Procedures	-	90	t	products/2024/08/29/images.png	35
6	Straumann® BLX BLT	straumann-blx-blt	Implants	Straumann® BLX Implants (Bone Level X) or Bone Level Tapered (BLT) Implants	850	t	products/2024/11/14/0613308.jpg	15
7	Sinus lifting	sinus-lifting	Dental Procedures		150	t		100
8	bone graft	bone-graft	Dental Procedures		150	t		100
9	Zirconium Crowns with Titanium Bases	zirconium-crowns-with-titanium-bases	Crowns	Zirconium Crowns with Titanium Bases	220	t	products/2024/11/14/Zahntechnischer-Tipp-Verwendung-Titanbasen.jpg	50
10	Straumann® Zygomatic Implants	straumann-zygomatic-implants	Implants	Straumann® Zygomatic Implant, ZAGA™ Flat / Round	2640	t	products/2024/11/14/chzc550.jpg	10
11	BEGO Implant	bego-implant	Implants		300	t		20
12	BEGO (ALL ON **) Implant	bego-all-on-implant	Implants		800	t		15
14	VIDALI Zirconium Crowns	vidali-zirconium-crowns	Crowns		270	t		30
15	TEK TEK Zirconium Crowns	tek-tek-zirconium-crowns	Crowns		260	t		25
16	Veneer Laminated	veneer-laminated	Crowns		220	t		30
17	E-Max Crowns	e-max-crowns	Crowns		300	t		25
18	Abutment	abutment	Implants		100	t		20
19	Alveoplasti	alveoplasti	Dental Procedures		150	t		20
20	Diş Çekimi (Cerrahi)	dis-cekimi-cerrahi	Dental Procedures		200	t		25
21	Daimi Protez	daimi-protez	Dental Procedures		500	t		20
22	Detartraj	detartraj	Dental Procedures		100	t		15
23	Polisaj	polisaj	Dental Procedures		120	t		15
24	Dolgu	dolgu	Dental Procedures		80	t		10
25	Estetik Dolgu	estetik-dolgu	Dental Procedures		150	t		15
26	Post Fiber	post-fiber	Dental Procedures		180	t		20
27	Gece Plağı	gece-plagi	Dental Procedures		130	t		20
28	Geçici Protez (Alt)	gecici-protez-alt	Dental Procedures		250	t		20
29	Geçici Protez (Alt+Üst)	gecici-protez-alt-ust	Dental Procedures		400	t		20
30	Geçici Protez (Üst)	gecici-protez-ust	Dental Procedures		250	t		20
31	Geçici Sabit	gecici-sabit	Dental Procedures		300	t		20
32	Gingivectomy	gingivectomy	Dental Procedures		350	t		25
36	Kanal Yenileme	kanal-yenileme	Dental Procedures		200	t		20
37	Kanal Tedavisi	kanal-tedavisi	Dental Procedures		220	t		20
42	Sedasyon	sedasyon	Medical Procedures		500	t		15
40	PRF	prf	Dental Procedures		250	f		20
35	Kanal Temizlime	kanal-temizlime	Dental Procedures		60	t		20
45	Zoom Bleaching	zoom-bleaching	Dental Procedures		600	f		25
44	Bone Greft + PRF	bone-greft-prf	Dental Procedures		850	f		20
43	Sinus Lift + Greft Membran	sinus-lift-greft-membran	Dental Procedures		800	f		20
41	RAMUS	ramus	Dental Procedures		300	f		20
39	PMMA	pmma	Dental Procedures		200	f		15
38	Kist Temizleme	kist-temizleme	Dental Procedures		300	f		20
34	Kan Test	kan-test	Dental Procedures		150	f		10
33	HIV	hiv	Dental Procedures		400	f		10
13	Zirconium Crowns	zirconium-crowns	Crowns		130	t		25
\.


--
-- Data for Name: apps_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apps_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, phone_number, thumbnail, emergency_contact_id, medical_information_id, referral_code, referred_by, thread_id, beyondblog_profileid, is_online, last_login_time, last_logout_time, nationality, date_of_birth) FROM stdin;
2	pbkdf2_sha256$720000$heAoolwlX8PVijenUgAAxH$aLKtRbMi07u3uMdXfQ79UBGV0Sc+OuKF0aMo2ejSwNY=	2024-09-01 10:32:34+00	f	zeynep.kaya@gmail.com	Zeynep	Kaya	zeynep.kaya@gmail.com	f	t	2024-07-14 07:55:06+00	0538054639323	profile_pictures/avatar_11_oIsRpma.jpg	\N	1	3c5c3a06ca				t	2024-09-01 10:32:34+00	2024-08-28 18:10:04+00	TR	2010-01-01
4	pbkdf2_sha256$600000$R3b3P2bnLBALUsaN1kjzL2$HWkfhFKB+c3izzGOlC7TBbH+vOLP3nE8erGoSDXu5xc=	2024-07-26 22:03:06+00	f	mehmet.aydin@beyondboard.me	Dr.Mehmet	Aydın	mehmet.aydin@beyondboard.me	t	t	2024-07-19 01:13:22+00	05380546393112	profile_pictures/Profile-PNG-Photo.png	1	3					t	2024-08-18 03:18:54+00	\N	TR	2006-01-01
5	pbkdf2_sha256$150000$ITgwccIHZ3CP$lPaBLBj/5aQzgtW03whEPZ3fH8b4s4wUVwUkdR75dkM=	2024-07-19 01:19:27+00	f	ayse.demir@gmail.com	Ayşe	Demir	ayse.demir@gmail.com	f	t	2024-07-19 01:19:05+00	05380546393232	profile_pictures/Profile-PNG-Photo.png	\N	4					t	2024-08-18 03:18:54+00	\N	TR	2008-01-01
6	pbkdf2_sha256$600000$l88WMBoxtskE14FjTcV9F6$7/RKzz0PW718nM7DSKdLyF+aeG0DaWBxcvEuI8PEjQo=	2024-07-19 15:44:17+00	f	selin.koc@gmail.com	Selin	Koç	selin.koc@gmail.com	f	t	2024-07-19 13:22:11+00	5421812843	profile_pictures/Profile-PNG-Photo.png	\N	5					f	\N	\N	TR	1991-01-01
7	pbkdf2_sha256$720000$iT8muvedjp5JNOpePHqUoP$8y2/GAs/dzXVOschMpI7aTTVGq8n/G5tCFy30pGzi+w=	2024-08-18 03:40:49+00	f	can.gursoy@gmail.com	Can	Gürsoy	can.gursoy@gmail.com	f	t	2024-07-20 20:00:58+00	0538054639323	profile_pictures/Profile-PNG-Photo.png	1	14					f	\N	\N	TR	2009-04-15
8	pbkdf2_sha256$870000$h4bgjw8FfVEBRDoUqD8xpH$NoLHmPtkLXWWh1HxiMFMQLEkgkm5WGbU/eGfL5k+5Ag=	2024-09-05 11:16:10.62952+00	f	ayla.tekin@beyondboard.me	Ayla	Tekin	ayla.tekin@beyondboard.me	t	t	2024-07-20 20:08:31+00	0538054639323	profile_pictures/Profile-PNG-Photo.png	\N	15					t	2024-09-05 11:16:10.653806+00	2024-08-28 20:39:44+00	TR	2008-09-19
9	pbkdf2_sha256$600000$XMAJO3Q8aRpRDHGiLb4P5f$fMvqlvISWAlBYkB/Kn4djkqZqOdkefJEHZ4BWfi6glQ=	2024-07-20 20:26:25+00	f	sarah.evans@gmail.com	Sarah	Evans	sarah.evans@gmail.com	f	t	2024-07-20 20:25:13+00	0538054639312	profile_pictures/Profile-PNG-Photo.png	\N	16					f	\N	\N	TR	2008-08-18
10	pbkdf2_sha256$720000$TQ8W6nw4jh6rIkHz17FMs6$e3+xzz43t1I1IXsyYhKdIQqCKR1Glko1+baVyNwF9Wk=	2024-08-29 04:53:41+00	f	victoria.green@gmail.com	Victoria	Green	victoria.green@gmail.com	f	t	2024-07-20 20:30:49+00	0538054639323	profile_pictures/Profile-PNG-Photo.png	\N	17					f	2024-08-29 04:53:41+00	2024-08-29 04:55:35+00	TR	2011-08-12
11	pbkdf2_sha256$600000$YKSlbAgSWFbqXhRQB3xCQo$dRZfFlV8iYdJFK7PvJM2keQI70kuzoJQ/OfEDKMzLXg=	\N	f	william.carter@beyondboard.me	William	Carter	william.carter@beyondboard.me	f	t	2024-07-20 20:32:53+00	0538054639323	profile_pictures/Profile-PNG-Photo.png	\N	18					f	\N	\N	TR	2010-09-15
12	pbkdf2_sha256$600000$P7Z7gjOrfr7h9HaHvhWtLx$ECs7Byivjwgb5oGH6duGKjp0ovn4dIywhus4LowWNwg=	2024-07-20 20:54:38+00	f	matthew.lewis@gmail.com	Matthew	Lewis	matthew.lewis@gmail.com	f	t	2024-07-20 20:54:37+00	0538054639323	profile_pictures/Profile-PNG-Photo.png	\N	19					f	\N	\N	TR	2008-07-17
13	pbkdf2_sha256$600000$SWX31HsRUaLSbRhSn60Zqw$6Tcm2zTDviTCuWk2hdtzHOEkhM8PMg4//c4CWUJiSYI=	2024-07-20 21:17:08+00	f	zara.ahmed@gmail.com	Zara	Ahmed	zara.ahmed@gmail.com	f	t	2024-07-20 21:17:07+00	05380546393213	profile_pictures/Profile-PNG-Photo.png	\N	20					f	\N	\N	TR	2002-09-15
14	pbkdf2_sha256$720000$06ellINkPgIX8jKWQC1EbZ$VLnQ1rhqTuooUSul1c3ok0sxeJXCKCNB1dnc/Ru7Ytk=	2024-08-09 00:05:10+00	f	efe.tas@gmail.com	Efe	Taş	efe.tas@gmail.com	f	t	2024-07-20 21:19:38+00	38054639345	profile_pictures/Profile-PNG-Photo.png	\N	21					f	\N	\N	TR	2011-09-17
15	pbkdf2_sha256$600000$tpBZUhnNBDQajDSPGKTHvB$i7aODjDs9lN9lWklFnwsVmw28eSznsBvVIMBnf+DTx0=	2024-07-21 04:33:25+00	f	aylin.erdem@gmail.com	Aylin	Erdem	aylin.erdem@gmail.com	f	t	2024-07-21 04:32:45+00	0538054639323	profile_pictures/Profile-PNG-Photo.png	\N	22	4152f3f731	3			f	\N	\N	GB	2007-09-17
16	pbkdf2_sha256$600000$6DMc7BPtT05j6OevUAiTjJ$2vUFIoivl8uexzu0xdZ87883xd569nNMothI1pVJhLs=	\N	f	catherine.dubois@gmail.com	Catherine	Dubois	catherine.dubois@gmail.com	f	t	2024-07-21 04:35:21+00	0538054639323	profile_pictures/Profile-PNG-Photo.png	\N	23					f	\N	\N	GB	2003-08-17
17	pbkdf2_sha256$720000$I7xbpdXW3FpiBYl2oSrUvU$TH6NY0UbYBehwEbzDdB0t4F8smtxpQ8dwniq//ZPLQg=	2024-08-29 04:55:46+00	f	rania.khalil@gmail.com	Rania	Khalil	rania.khalil@gmail.com	f	t	2024-07-21 04:36:09+00	05380546393	profile_pictures/Profile-PNG-Photo.png	\N	24	0d03e598b0				f	2024-08-29 04:55:46+00	2024-08-29 05:00:35+00	PK	2007-09-20
18	pbkdf2_sha256$600000$eJcUQREdjDOa6aQd5OKB5a$ws1kecx3TYhWG+vzvYp0GrVQ8o4bF0Pum4sPSZdNgZw=	\N	f	ahmet.duman@gmail.com	Ahmet	Duman	ahmet.duman@gmail.com	f	t	2024-07-21 04:38:45+00	05380546393123	profile_pictures/Profile-PNG-Photo.png	\N	25	67928e02c3	15			f	\N	\N	TR	2008-06-17
19	pbkdf2_sha256$600000$VWb9X41ikSqSk1YW34vvbZ$dPjAGJcYhUBiynXlweIPTPVOg1D2XFjyrSlneJ1GHjk=	\N	f	kerem.guler@gmail.com	Kerem	Güler	kerem.guler@gmail.com	f	t	2024-07-21 04:39:59+00	05380546393123	profile_pictures/Profile-PNG-Photo.png	\N	26					f	\N	\N	TR	2008-06-17
20	pbkdf2_sha256$720000$Zk17qgsYXlND75rfqaICVH$rQ5yyXN/A6cxS8bdZXXr8QFZT7EPqW5gyfrm0rWp3bE=	2024-08-18 03:46:06+00	f	murat.ozmen@gmail.com	Murat	Özmen	murat.ozmen@gmail.com	f	t	2024-07-21 04:55:47+00	05380546393	profile_pictures/Profile-PNG-Photo.png	\N	27					t	2024-08-18 03:46:06+00	\N	FR	2004-09-01
21	pbkdf2_sha256$600000$V38dwyRqcb3MQWDEwVExvO$VNpfkzIjLE1yLRA8L9TBknGEkBGbSfkhXb1II4/M+W0=	2024-07-21 07:41:16+00	f	hulya.cetin@gmail.com	Hülya	Çetin	hulya.cetin@gmail.com	f	t	2024-07-21 06:11:21+00	0538054639323	profile_pictures/Profile-PNG-Photo.png	\N	28					f	\N	\N	EG	2007-11-01
22	pbkdf2_sha256$600000$gHYthrMmTuKnLSp3WwS9cc$uBTaenu0VcS6PjYVZmDyMkt+volpGOij5u+0E91XuFI=	\N	f	serkan.kara@gmail.com	Serkan	Kara	serkan.kara@gmail.com	f	t	2024-07-21 06:14:58+00	0538054639323	profile_pictures/Profile-PNG-Photo.png	\N	29	9121bbcb87	2			f	\N	\N	TR	2007-11-01
23	pbkdf2_sha256$600000$6yqAUlm5V09c5bYNfUB7GS$Va6TFlKyvXfYQiI4LpBCeF0N1Y79zpcYhZhTNMrcPjU=	2024-07-21 06:34:51+00	f	volkan.ozcan@gmail.com	Volkan	Özcan	volkan.ozcan@gmail.com	f	t	2024-07-21 06:34:51+00	0538054639323	profile_pictures/Profile-PNG-Photo.png	\N	30	750c0578f3				f	\N	\N	TR	2004-10-21
24	pbkdf2_sha256$600000$HKATCGyvfjTGC9hOzF8JM7$WvEl57iGB7XNGzNfK+HGXsWJt8Kmj8qgq9JSHqhVkRU=	\N	f	melike.arslan@gmail.com	Melike	Arslan	melike.arslan@gmail.com	f	t	2024-07-21 06:35:39+00	0538054639323	profile_pictures/Profile-PNG-Photo.png	\N	31	6ea8c27929	17			f	\N	\N	TR	2004-10-21
25	pbkdf2_sha256$600000$F7lUuLgM6EX2RkF8Zfi5IU$/xczKXUMBsE5dWSdY3X3aYgPKkzQ3Dz8OBT1XFaHa4E=	2024-07-21 07:42:32+00	f	sibel.dogan@gmail.com	Sibel	Doğan	sibel.dogan@gmail.com	f	t	2024-07-21 06:36:52+00	0538054639323	profile_pictures/Profile-PNG-Photo.png	\N	32	41e6b7c71f	17			f	\N	\N	TR	2004-10-21
26	pbkdf2_sha256$600000$EalEioHWdEgOZqdVpNSPpL$Dg3atlYnXRG0ZmB0xXAspwtfutouJ1gC/sYTltNl3AY=	\N	f	arda.koc@gmail.com	Arda	Koç	arda.koc@gmail.com	f	t	2024-07-21 06:38:07+00	0538054639323	profile_pictures/Profile-PNG-Photo.png	\N	33	cbfc893a66	3			f	\N	\N	TR	2004-10-21
122	pbkdf2_sha256$720000$4HIqk0yKb95HqGYO3JBXt1$8j3ZJxlXb4igld6sYOTQZ356V0eATt5smel4OlFs3pU=	2024-12-22 22:02:42.67883+00	t	nada				t	t	2024-12-22 22:01:44.531626+00			\N	\N	\N	\N	\N	\N	f	2024-12-22 22:02:46.598378+00	2024-12-24 19:31:28.266625+00	\N	\N
123	pbkdf2_sha256$720000$eUtG80FaNj9wJ2eXPAS7Kn$krq03C/yDI1IfN1ehr11mtp3z4+TGS3UyWqORVQfA/c=	2024-12-24 19:33:43.453054+00	f	lofasac@fd.xty	Esteticium	Transplant	lofasac@fd.xty	f	t	2024-12-24 19:33:37.615492+00	05380546393	profile_pictures/Profile-PNG-Photo_TgnuShi.png	\N	129	2e5611578d	\N	\N	\N	t	2024-12-24 19:33:47.158657+00	\N	\N	\N
27	pbkdf2_sha256$720000$MdmFc7tpbGFhE5AQyAxc67$X7J3U91M35mve5a3OzEA7D59c2ebr9V+VZFpvSWg0nM=	2024-09-04 15:44:18.260852+00	f	lukas.schmidt@gmail.com	Lukas	Schmidt	lukas.schmidt@gmail.com	f	t	2024-07-21 07:06:55+00	0538054639323	profile_pictures/avatar_12.jpg	\N	34	aba03cbc9c	2			t	2024-09-04 15:44:18.295193+00	2024-09-03 17:16:30+00	TR	1996-07-18
28	pbkdf2_sha256$600000$mSBb4TCq0ZCQSrSjhnpkiM$3hmMg7zRUa+7tLVX+EgW50aqnc3eVnRXINS1MAV7MH8=	2024-07-21 07:10:02+00	f	orhan.tekin@gmail.com	Orhan	Tekin	orhan.tekin@gmail.com	f	t	2024-07-21 07:10:01+00	05380546393222	profile_pictures/Profile-PNG-Photo.png	\N	35	50b6279ac6	2			f	\N	\N	TR	2007-07-18
29	pbkdf2_sha256$720000$feNKDyhTjpGf56SugwUG5h$8k8+3Tms9rU7DmeTWB8BuddWaAvlMJWkJW4cROWmWPE=	2024-09-03 19:30:03+00	f	zahra.akgun@gmail.com	Zahra	Akgün	zahra.akgun@gmail.com	f	t	2024-07-21 07:23:31+00	0538054639334	profile_pictures/avatar_13.jpg	\N	36	41d3c17abc	2			t	2024-09-03 19:30:03+00	\N	TR	1995-07-08
30	pbkdf2_sha256$600000$L52l12obDjXLcCipZp10FC$P0bruH7hO4VchljaLuM8I6o6URbzNDdA3ztLjzDg2dM=	2024-07-21 07:24:10+00	f	timur.yalcin@gmail.com	Timur	Yalçın	timur.yalcin@gmail.com	f	t	2024-07-21 07:24:09+00	053805463933422	profile_pictures/Profile-PNG-Photo.png	\N	37	9a72d2f1fb	2			f	\N	\N	DE	2007-10-17
31	pbkdf2_sha256$600000$l9z8tY2orV8ZOER2wrOIuH$c9kdW6tkSDM0cMxlDGPblPeXFQ16T66wAOSD4YHcTcA=	2024-07-26 08:28:00+00	f	julia.schultz@gmail.com	Julia	Schultz	julia.schultz@gmail.com	f	t	2024-07-21 08:16:18+00	05380546393123	profile_pictures/Profile-PNG-Photo.png	\N	38	bc9b811cd5				f	\N	\N	TR	2008-11-18
32	pbkdf2_sha256$600000$ERkuzTFOL0kozKg1Npq1EN$yVr4Xa7uASgcDzK/PAmwdxg+2H9zVZ7cxGxzqTu7Mz8=	2024-07-21 08:18:13+00	f	anna.weber@gmail.com	Anna	Weber	anna.weber@gmail.com	f	t	2024-07-21 08:18:13+00	21323423434	profile_pictures/Profile-PNG-Photo.png	\N	39	8bbc5698c6	2			f	\N	\N	TR	2004-04-01
33	pbkdf2_sha256$720000$OOXpF1PXJWoTLUlUeVdRCJ$ik2hbkdpQ+EVibNkX65XrppdOIE4UVHLsSpmMk76JmA=	2024-08-28 16:56:16+00	f	burak.kaplan@gmail.com	Burak	Kaplan	burak.kaplan@gmail.com	f	t	2024-07-21 08:20:49+00	05380546393244	profile_pictures/Profile-PNG-Photo.png	\N	40	157c7ecbbd	28			f	2024-08-28 16:56:16+00	2024-08-28 20:17:39+00	TR	2005-06-01
34	pbkdf2_sha256$600000$2x7YcMqCpM51l6Zx6oDaCf$WdfO9uWrlTZKiz701Ytzq+f/F1EBoD1PwJrQIxxsuD8=	2024-07-21 09:32:11+00	f	eren.yucel@gmail.com	Eren	Yücel	eren.yucel@gmail.com	f	t	2024-07-21 09:28:23+00	0538054639334	profile_pictures/Profile-PNG-Photo.png	\N	41	e38ebf5471				f	\N	\N	TR	2008-08-17
35	pbkdf2_sha256$720000$YhVWREtzwf0GINtwXUA4xa$cvxM0bDYZzoWwDhjDbw+xJJEYoXNdlxiNGmigY1N5ys=	2024-08-23 01:21:18+00	f	sami.tan@gmail.com	Sami	Tan	sami.tan@gmail.com	f	t	2024-07-21 09:32:50+00	12334543234	profile_pictures/Profile-PNG-Photo.png	\N	42					f	\N	\N	DE	2016-09-01
36	pbkdf2_sha256$600000$UHVBROhIfAabJjl5OTiua9$THIIgdpSjAqH5A/rv54HDa5+F73UQlRyhLaz2TjoBS0=	\N	f	fatih.aslan@gmail.com	Fatih	Aslan	fatih.aslan@gmail.com	f	t	2024-07-21 09:35:27+00	123353446	profile_pictures/Profile-PNG-Photo.png	\N	43	956f2a0186	34			f	\N	\N	DE	2009-05-01
37	pbkdf2_sha256$720000$Stsm2D8nK6sNv3YhOLS7rE$KYJt2AUnojYsZ6tjXreZwfWl7rDv0Z61M/IbYGOT6iU=	2024-08-02 15:55:44+00	f	mehmet.guven@gmail.com	Mehmet	Güven	mehmet.guven@gmail.com	f	t	2024-07-21 09:38:08+00	123353446	profile_pictures/Profile-PNG-Photo.png	\N	44					f	\N	\N	TR	2009-05-01
38	pbkdf2_sha256$600000$jdfuySuFiLWcXlLKqs2di1$4lD1XMI9+Fw03VL4VIQbYceB6c8+OfhzgU45OmGLX28=	2024-07-21 09:39:02+00	f	zeynep.karaman@gmail.com	Zeynep	Karaman	zeynep.karaman@gmail.com	f	t	2024-07-21 09:39:01+00	123353446	profile_pictures/Profile-PNG-Photo.png	\N	45	17e8fd83d1	34			f	\N	\N	TR	2009-05-01
39	pbkdf2_sha256$720000$0LGKwhbKelFpg3On6FxIFi$ZSAu/4GFwJMF8QcqmhQEQ+yAKLfeUs5y0YxcgdQD2LI=	2024-09-03 17:16:57+00	f	ayla.aydin@beyondboard.me	Ayla	Aydın	ayla.aydin@beyondboard.me	t	t	2024-07-25 08:08:06+00	2346344675	profile_pictures/Profile-PNG-Photo.png	1	46	9648f555d8				t	2024-09-03 17:16:57+00	\N	TR	2012-03-07
40	pbkdf2_sha256$720000$SbsMbuoskp8uO7f63vpt1N$xx0qX3PI19DGeCghg/g6wVR5iDjrKJapv8TiUkOkZ50=	2024-08-29 10:44:16+00	f	murat.can@beyondboard.me	Murat	Can	murat.can@beyondboard.me	t	t	2024-07-29 23:10:59+00	123454633	profile_pictures/Profile-PNG-Photo.png	1	47	9acafc5a49				t	2024-08-29 10:44:16+00	\N	TR	2024-01-01
46	pbkdf2_sha256$720000$6YfKdllM9I6ASoxtStMQo4$lwsAuchQAQm0uGOdb81rhFZNAm0/vFEAgXjz43fVfL0=	2024-08-29 05:01:02+00	f	sarah.thompson@gmail.com	Sarah	Thompson	sarah.thompson@gmail.com	f	t	2024-08-06 04:16:06+00	345345345	profile_pictures/Profile-PNG-Photo.png	\N	53					f	2024-08-29 05:01:02+00	2024-08-29 05:05:18+00	TR	2024-09-17
47	pbkdf2_sha256$720000$juZlvkr8QDG9a4e15sTn1q$Zh1EyWnc6UQMhHsjSsd9cLL1bKP7vens3I4AHrsM+RQ=	2024-08-06 04:22:06+00	f	jack.robinson@gmail.com	Jack	Robinson	jack.robinson@gmail.com	f	t	2024-08-06 04:22:06+00	053805463933	profile_pictures/Profile-PNG-Photo.png	\N	54	271fc7c1b3				f	\N	\N	GB	2024-01-01
48	pbkdf2_sha256$720000$KMSp4Bhms69NnETrgsM7ut$oJBL8qvOTzZU3BW/T3hcxxd/qFlggA+jLSHtKg+NAbg=	2024-09-03 17:18:40+00	f	cem.yildirim@gmail.com	Cem	Yıldırım	cem.yildirim@gmail.com	f	t	2024-08-06 04:28:29+00	43534534	profile_pictures/avatar_10.jpg	\N	55	539111351f				f	2024-09-03 17:18:40+00	2024-09-03 19:29:49+00	US	1991-05-17
49	pbkdf2_sha256$720000$rZcmEjxabvfHqmMYD5H1Ax$mj8TczbbNFPS2NJ9oDySb7astfoL27OaPBuMlsthhzM=	2024-08-06 04:29:39+00	f	deniz.ozdemir@gmail.com	Deniz	Özdemir	deniz.ozdemir@gmail.com	f	t	2024-08-06 04:29:38+00	34445345	profile_pictures/Profile-PNG-Photo.png	\N	56	42af2e688f				f	\N	\N	TR	2024-01-01
50	pbkdf2_sha256$720000$KYU7ZDKO0ikRIrNvHQgB8I$6ihZImQf/GymjhWbBKRe0M3H2LU7OW2z8hRLfbWOLKk=	2024-08-06 04:38:15+00	f	alex.walker@gmail.com	Alex	Walker	alex.walker@gmail.com	f	t	2024-08-06 04:35:13+00	24534643	profile_pictures/Profile-PNG-Photo.png	\N	57	16bec229db				f	\N	\N	TR	2024-01-01
51	pbkdf2_sha256$720000$DzZmWg4fAL4iAo3eqsSJQL$xnMETMgcmtS2ZhI/cIwU0cHnh/ySMzZozp2fKa/Tvbs=	2024-08-06 04:42:22+00	f	isabella.russo@gmail.com	Isabella	Russo	isabella.russo@gmail.com	f	t	2024-08-06 04:42:22+00	345654435	profile_pictures/Profile-PNG-Photo.png	\N	58	a99bc3152e				f	\N	\N	GB	2024-01-01
52	pbkdf2_sha256$720000$ttqABuNeiKdhZFddOxoFr5$lA8nDdQbONntSG8kN4gNADtgIRYu6B3n+bwrguQCy2E=	2024-08-29 14:45:58+00	f	leila.ozturk@beyondboard.me	Leila	Ozturk	leila.ozturk@beyondboard.me	t	t	2024-08-06 04:57:00+00	2323342342	profile_pictures/Profile-PNG-Photo.png	\N	59	22ad22e30b				t	2024-08-29 14:45:58+00	\N	IT	2024-01-01
53	pbkdf2_sha256$720000$dF8RZdEEDRIeYCRD71O7mG$GRzANCFlcfyFJ1SCztUWpmdJZr3UIEJ/u5jssjbRurk=	2024-08-06 05:31:02+00	f	lucas.hansen@gmail.com	Lucas	Hansen	lucas.hansen@gmail.com	f	t	2024-08-06 05:31:01+00	053805346393	profile_pictures/Profile-PNG-Photo.png	\N	60	d78381f80d				f	\N	\N	TR	2024-01-01
54	pbkdf2_sha256$870000$XvIQbVUm9Ck9jwfJlUsemR$I6x7IpfUaHaXI2R2g12rWqqZ2xn80svKpx3lRk6r4Ck=	2024-09-05 11:22:58.080873+00	f	yasmin.aljabari@gmail.com	Yasmin	Al-Jabari	yasmin.aljabari@gmail.com	f	t	2024-08-06 05:40:05+00	23233423	profile_pictures/Profile-PNG-Photo.png	\N	61	82aac60d92				t	2024-09-05 11:22:58.102482+00	\N	DK	2024-01-01
55	pbkdf2_sha256$720000$RD678DyvHhuUEVyR1uE6ZN$kDM31nKd1YSiX7zDlig0Gr/bAM1UScWAZH/NPVkVJEc=	2024-08-06 05:42:44+00	f	david.anderson@gmail.com	David	Anderson	david.anderson@gmail.com	f	t	2024-08-06 05:42:44+00	2343234	profile_pictures/Profile-PNG-Photo.png	\N	62	f63e15e197				f	\N	\N	AE	2024-01-01
56	pbkdf2_sha256$720000$qjNb2w7LV7he0m4p5TdbR0$lm2xiMpIfyUvhe6wVvbtPE/jhSG+flcAQxSxYTtw2GE=	2024-08-06 08:08:24+00	f	lara.smith@gmail.com	Lara	Smith	lara.smith@gmail.com	f	t	2024-08-06 08:08:23+00	2353234	profile_pictures/Profile-PNG-Photo.png	\N	63	8f4cb705b6				f	\N	\N	US	2024-01-01
57	pbkdf2_sha256$720000$vy0zcbFfMwdN4S0R7JCYH8$IW6mQoLssSy5ET7jJi55XoABGACKkBA+SdkxBrO+3tc=	2024-09-15 06:54:25.695548+00	f	merve.kaya@gmail.com	Merve	Kaya	merve.kaya@gmail.com	f	t	2024-08-06 08:16:50+00	3434534	profile_pictures/Profile-PNG-Photo.png	\N	64	86d21b4a2a				t	2024-09-15 06:54:25.708808+00	\N	TR	2024-01-01
58	pbkdf2_sha256$720000$a38cqT2iFV7X5jMWWB4hOt$Ug8RdWe+XtCsFFfCrqm6Po+RjvIvYH7YDgHr3ar/DP4=	2024-08-06 12:16:49+00	f	ahmed.elmasry@gmail.com	Ahmed	Elmasry	ahmed.elmasry@gmail.com	f	t	2024-08-06 12:16:49+00	0538054639323	profile_pictures/Profile-PNG-Photo.png	\N	65	6cab915bc4				f	\N	\N	EG	2024-01-01
59	pbkdf2_sha256$720000$HuCjk5f6JjLwl1Vfotsu92$3Czd6R4vZqvfsUaDw8Sh/y2/y7ncTURNjpNOquZusFE=	2024-08-29 05:05:23+00	f	hannah.martin@gmail.com	Hannah	Martin	hannah.martin@gmail.com	f	t	2024-08-06 12:20:30+00	12345436	profile_pictures/Profile-PNG-Photo.png	\N	66	ac64d7fa78				f	2024-08-29 05:05:23+00	2024-08-29 09:04:11+00	GB	2024-01-01
60	pbkdf2_sha256$720000$3ntBblvl1JAe3z6gFYJcTu$MBXhGZ701iJKQ+vl7OgdRbiJSQFNjlJvq/UfartL+CU=	2024-09-01 18:39:22+00	f	emily.white@beyondboard.me	Emily	White	emily.white@beyondboard.me	t	t	2024-08-06 12:22:14+00	12345436	profile_pictures/Profile-PNG-Photo.png	\N	67	83b531aafc				t	2024-09-01 18:39:22+00	\N	US	2024-01-01
61	pbkdf2_sha256$720000$MFEjNgwtcpIa6PfTFGEvMY$fncht6XNIofo4OXd0ltT37rz3nlVHo7iQcd7roAF05A=	2024-08-09 00:21:55+00	f	michael.brown@gmail.com	Michael	Brown	michael.brown@gmail.com	f	t	2024-08-09 00:21:54+00	0538054639323	profile_pictures/Profile-PNG-Photo.png	\N	68	a48865af3c				f	\N	\N	US	2024-01-01
62	pbkdf2_sha256$720000$JjvSFIZRu3lyWWKqZ4sWi0$rdfPOK6FC9BaAiDCXDKQbqVFlmjfN44kfvTEzO18ivk=	2024-09-12 22:58:13.465383+00	f	huseyin.altin@gmail.com	Huseyin	Altın	huseyin.altin@gmail.com	f	t	2024-08-09 03:46:08+00	5306377731234	profile_pictures/Profile-PNG-Photo.png	\N	69	b11b9c82bb				t	2024-09-12 22:58:13.48052+00	\N	TR	2024-01-01
63	pbkdf2_sha256$720000$Y9r2K2UQA9mY5LlPVsCJhV$h8zpGpGkW07HPwrw2ULRvN/byM8nAsWo8wgv2pNLAoY=	2024-08-09 04:19:14+00	f	kenan.sahin@gmail.com	Kenan	Şahin	kenan.sahin@gmail.com	f	t	2024-08-09 04:19:13+00	5306377731323	profile_pictures/Profile-PNG-Photo.png	\N	70	6a953e8b76				f	\N	\N	TR	2024-01-01
64	pbkdf2_sha256$720000$eXKlugPu47dl0T0mLSIDq2$X7OlbYQfTuD7Tp5uldL/k6GHMwThyb3K6LXvxCFJTwI=	2024-08-09 04:21:03+00	f	nina.petrova@gmail.com	Nina	Petrova	nina.petrova@gmail.com	f	t	2024-08-09 04:21:03+00	53063777313233	profile_pictures/Profile-PNG-Photo.png	\N	71	e8de4cec0f				f	\N	\N	RU	2024-01-01
65	pbkdf2_sha256$720000$OulKCMWTdQd07cxyYNApiJ$mXqZ34bgMgsKFjHUXQChjQOpU/49fE81taOvlZ6+drM=	2024-09-15 09:40:51.722055+00	f	farah.hassan@gmail.com	Farah	Hassan	farah.hassan@gmail.com	f	t	2024-08-09 04:35:26+00	05380546393323	profile_pictures/Profile-PNG-Photo.png	\N	72	ae06b78970				t	2024-09-15 09:40:51.737608+00	\N	EG	2024-01-01
66	pbkdf2_sha256$720000$Fnlr0RMcwzrsKKX1QCRnpT$34Y7/I5C0DMDGhwwbBRzW9HJ2cbhbxKbbVHR3mEkXvg=	2024-09-15 09:45:44.050424+00	f	maria.sanchez@gmail.com	Maria	Sanchez	maria.sanchez@gmail.com	f	t	2024-08-09 06:21:49+00	530637773112	profile_pictures/Profile-PNG-Photo.png	\N	73	b89f2d3537				t	2024-09-15 09:45:44.064688+00	\N	ES	2024-01-01
67	pbkdf2_sha256$720000$imFsu03abKtruQpgq2knQX$Kppd12VZ7a3j6KSdf/lWgmBUtmCZismsYGfEYFB/BfA=	2024-09-15 08:20:52.043067+00	f	mustafa.aksoy@gmail.com	Mustafa	Aksoy	mustafa.aksoy@gmail.com	f	t	2024-08-09 07:09:47+00	05380546393234	profile_pictures/Profile-PNG-Photo.png	\N	74	beb5ec90a5				t	2024-09-15 08:20:52.082719+00	\N	TR	2024-01-01
68	pbkdf2_sha256$720000$lrWOWbzcPTM5QSuGSuj2zR$c6tS1l8n112rdk7u72cft8sLzXMw6w/b8wANx0GrRDY=	2024-09-15 08:36:21.622723+00	f	carlos.ramirez@gmail.com	Carlos	Ramirez	carlos.ramirez@gmail.com	f	t	2024-08-19 14:40:52+00	34534535	profile_pictures/Profile-PNG-Photo.png	\N	75	d577638458				t	2024-09-15 08:36:21.649241+00	2024-08-29 11:46:50+00	MX	2024-01-01
69	pbkdf2_sha256$720000$aCDMuqLfWKrW3zG4I7naiJ$OpaTSc2mbTSQGlvthzdCVvVJe4430jujzF942wTtkc8=	2024-09-03 23:25:47+00	f	sophie.mueller@gmail.com	Sophie	Müller	sophie.mueller@gmail.com	f	t	2024-08-19 15:34:49+00	1234365	profile_pictures/Profile-PNG-Photo.png	\N	76	78905ba520				t	2024-09-03 23:25:47+00	\N	DE	2024-01-01
70	pbkdf2_sha256$720000$ML3DpTbuRPD5eFCSpV7TRn$E29OzUfBAR3ZbweaOHAl+kf4yeIB6hwTi0QRStNYPYc=	2024-08-22 03:45:50+00	f	amina.bashir@gmail.com	Amina	Bashir	amina.bashir@gmail.com	f	t	2024-08-22 03:45:49+00	23534634	profile_pictures/Profile-PNG-Photo.png	\N	77	e771a92bdb				t	2024-08-22 03:45:50+00	\N	NG	2024-01-01
71	pbkdf2_sha256$720000$SzOvkwNwE6AjEyiyyqxXQz$7jjVGY7FpwATJAQCR3pPDEy+Qf1bnWrd0ElGG6Gj3po=	2024-09-15 07:53:30.264478+00	f	elif.demir@gmail.com	Elif	Demir	elif.demir@gmail.com	f	t	2024-08-22 03:52:06+00	3453434	profile_pictures/Profile-PNG-Photo.png	\N	78	07fc8d09a0				t	2024-09-15 07:53:30.282753+00	\N	TR	2024-01-13
72	pbkdf2_sha256$720000$4EdFaN19XmlQNEJUJKHBxK$677EHRxa2OWic8+VEYj1rHYIC/RQaXJc4Om/xp++dqA=	2024-09-04 02:12:45+00	f	fatma.korkmaz@gmail.com	Fatma	Korkmaz	fatma.korkmaz@gmail.com	f	t	2024-08-28 16:29:32+00	05380546393	profile_pictures/Profile-PNG-Photo.png	\N	79					f	2024-09-04 02:12:45+00	2024-09-04 02:17:39+00	TR	2024-04-06
73	pbkdf2_sha256$720000$J12lfhhPinlY8XR9Renc8E$AQTIi93yQilUnyTVUqyqEfww+vyZ7BDXVg/pcnQ3kok=	2024-09-21 01:16:16.896893+00	f	lotfi.kanouni@gmail.com	Lotfi	Kanouni	lotfi.kanouni@gmail.com	f	t	2024-08-28 20:50:48+00	052338320546393	profile_pictures/Profile-PNG-Photo.png	\N	82	1cea1adaf2				t	2024-09-21 01:16:16.923308+00	2024-09-04 09:36:09+00	DZ	2024-01-01
74	pbkdf2_sha256$720000$PUNgrIwa1EmmJS8Uh8Ks1W$QMrnthWMg9+AnFniUZ24lknhNcfForrgt5y3vBmXJGU=	2024-09-03 16:49:45+00	f	emma.johnson@beyondboard.me	Emma	Johnson	emma.johnson@beyondboard.me	t	t	2024-08-28 21:00:04+00	432534643	profile_pictures/Profile-PNG-Photo.png	1	83	51810ed8f6				t	2024-09-03 16:49:45+00	2024-08-29 08:24:42+00	US	2010-01-01
75	pbkdf2_sha256$720000$opr7GK9p5urGIUdBcy1jUH$Hv6Pg8vOFwXiGCzXWx1P7of7bwJ8ApQK5jUNBg0oKMo=	2024-09-04 09:51:51+00	f	ali.yilmaz@gmail.com	Ali	Yılmaz	ali.yilmaz@gmail.com	f	t	2024-08-28 21:04:12+00	45454634	profile_pictures/Profile-PNG-Photo.png	\N	84	5c29541dfc	74			t	2024-09-04 09:51:51+00	\N	TR	2009-01-01
76	pbkdf2_sha256$870000$wux6doOZWcUWUjMYqNfBM5$fCx/4T4XazFd0W0vafhiuf57xAbCLyZS8wnES5yRzKg=	2024-09-05 06:56:59.621166+00	f	john.doe@beyondboard.me	John	Doe	john.doe@beyondboard.me	t	t	2024-08-28 21:16:37+00	23454554	profile_pictures/Profile-PNG-Photo.png	1	85	89602781d2				t	2024-09-05 06:56:59.640775+00	2024-08-31 18:26:30+00	US	2014-01-01
77	pbkdf2_sha256$720000$jMEUb4RPKbVa6ONX8RMiS7$rx/kOIXz3CG+6r6pqYJC3sIPa3FIP+bVpquIO2Iwy2A=	2024-09-03 23:34:39+00	f	arananada@gmail.com	Nada	Arana	arananada@gmail.com	f	t	2024-09-03 23:16:52+00	557122413		1	86	61dd1a8ed2				t	2024-09-03 23:34:39+00	\N	IN	1998-01-01
78	pbkdf2_sha256$720000$yvLyWJgw8n3xEZvf98lRlR$UPPvvQ6Xg4y3QPq/VjOtxLlMEZ7/EMp0Dl6d3+MvWs4=	2024-09-21 07:24:34.619574+00	f	melekdjemouai@gmail.com	Melek	Djemouai	melekdjemouai@gmail.com	t	t	2024-09-03 23:19:03+00	5380474085	profile_pictures/IMG_20240830_190613_780.jpg	1	87	551fb3b42a				t	2024-09-21 07:24:34.638087+00	2024-09-03 23:27:26+00	DZ	1997-07-04
79	pbkdf2_sha256$720000$1MV2Byxj3oxh67J4huO3LF$dZBV97Osrj6qyVucG6epCZohwfIbcM1cUNpSLDPa8+0=	2024-09-03 23:34:29+00	f	jgwelkfj@kwergn.com	reference tesrt	test	jgwelkfj@kwergn.com	f	t	2024-09-03 23:34:29+00	2342385823		\N	88	9f531cea29	77			t	2024-09-03 23:34:29+00	\N	KW	2010-01-01
80	pbkdf2_sha256$720000$Alwl8uQzLvXeSZSckr3wao$oi51rZYjHTOxxKmSYDDVtmvXl+hzy+ZB483+4Wo1mUE=	2024-09-04 14:57:38.839798+00	f	johnsmith@gmail.com	john	smith	johnsmith@gmail.com	f	t	2024-09-04 01:00:22+00	53463634		\N	89					f	2024-09-04 14:57:38.908951+00	2024-09-04 15:44:00.12241+00	US	2005-01-01
81	pbkdf2_sha256$720000$mmbatc6duHCf6gGwinTAom$kwAiDV0r8TaRzbMasUZxnOYPo/91tNguxs9LG5kysnE=	\N	f	johnsmithxx@gmail.com	john	smith	johnsmithxx@gmail.com	f	t	2024-09-04 01:01:19+00	53463634		\N	90					f	\N	\N	US	2006-01-01
82	pbkdf2_sha256$720000$Iji6dQzSQ29z8gs7k4vTHl$mEe+/C2SVbl89zRn9gnS857iTBLkFTJIxgAz7iPH/wE=	2024-09-04 01:07:56+00	f	kanouni.lotfi.protxx@gmail.com	LOTFI	KANOUNI	kanouni.lotfi.protxx@gmail.com	f	t	2024-09-04 01:07:29+00	05380546393	profile_pictures/Profile_2.jpg	\N	91	33e0905a9f				t	2024-09-04 01:07:56+00	\N	DZ	1975-01-01
92	pbkdf2_sha256$720000$CnKGwp5WiQsYifnvR7e93k$ZPFnQOCEDumleboeK6+RrHSkdb2K/znkKVmqBV4ATCM=	2024-09-16 22:18:58.535986+00	f	kanouni.loteffi.prot@gmail.com	LOTFIfe	KANOUNIef	kanouni.loteffi.prot@gmail.com	f	t	2024-09-16 22:18:58.016047+00	05380546393	profile_pictures/Profile-PNG-Photo_HWCsjBw.png	\N	101	\N	\N	\N	\N	t	2024-09-16 22:18:58.560678+00	\N	\N	2007-01-01
93	pbkdf2_sha256$720000$aGjOOoW2kmWaUvv7QhewY7$MxqqJw01OX9lOqjr1Nb6sPRuX9ldhCrrKEBlyQBzqYI=	2024-09-16 22:22:58.277704+00	f	fekanouni.lotfi.prot@gmail.com	LOTFIf	KANOUNIef	fekanouni.lotfi.prot@gmail.com	f	t	2024-09-16 22:22:57.840358+00	05380546393	profile_pictures/Profile-PNG-Photo_Bs7lyKe.png	\N	102	\N	\N	\N	\N	t	2024-09-16 22:22:58.300013+00	\N	\N	2024-01-01
94	pbkdf2_sha256$720000$ZNZjLjS0PSXJIgAU3NzhhY$U4l2/6MSrQpY2+RqaaB+8u2JgJgsJ4y5dmWK93zWOks=	2024-09-30 21:01:37.157964+00	f	loffu@gm.fj	ii	KANOUNIii	loffu@gm.fj	f	t	2024-09-30 21:01:36.427529+00	530637773145	profile_pictures/Profile-PNG-Photo_iUGvTlo.png	\N	103	\N	\N	\N	\N	t	2024-09-30 21:01:37.170277+00	\N	\N	2024-01-01
95	pbkdf2_sha256$720000$SQMIfdz52fJx15eezedpcf$X6xq0iYknZYv/i/awHitRq3KPnucw8SCDfl9SGuUEts=	2024-10-02 02:27:44.267088+00	f	dentidelilhealthgroup@outlook.com	LOTFI	KANOUNI	dentidelilhealthgroup@outlook.com	f	t	2024-10-02 02:12:57.250765+00	5306377731	profile_pictures/Profile-PNG-Photo_0ItHSgp.png	\N	104	\N	\N	\N	\N	t	2024-10-02 02:27:44.28453+00	\N	\N	2024-01-01
96	pbkdf2_sha256$720000$qx0oWZRAul7uNZtZxTouqi$yV95MkN8Ul84oCzywOttDtEr/VzrNkj/cfwJfS1zHUs=	2024-10-02 02:17:50.15213+00	f	lof@gm.fj	LOTFI	KANOUNI	lof@gm.fj	f	t	2024-10-02 02:17:49.58961+00	5306377731	profile_pictures/Profile-PNG-Photo_9wIaVl6.png	\N	105	\N	\N	\N	\N	t	2024-10-02 02:17:50.165701+00	\N	\N	2024-01-01
97	pbkdf2_sha256$720000$8FZUr3ZlMKbOEsdrW7XE5n$NClFuBm8XdI6Ge+CXKxJ3+mORIvsuTfvxhtV6xVVfJg=	2024-10-02 02:18:12.150368+00	f	lofrgerg@erg.vu	LOTFI	KANOUNI	lofrgerg@erg.vu	f	t	2024-10-02 02:18:11.592374+00	5306377731	profile_pictures/Profile-PNG-Photo_GEsvbsl.png	\N	106	\N	\N	\N	\N	t	2024-10-02 02:18:12.163698+00	\N	\N	2024-01-01
98	pbkdf2_sha256$720000$QlXyxNzjnbQ0Bzi08T7vJb$T17br7dvMF2AiNYST5b59IYyZXsiDkKYDtJxwt9m700=	2024-10-02 02:18:56.245378+00	f	lofaf@gwse.gh	LOTFIef	KANOUNIef	lofaf@gwse.gh	f	t	2024-10-02 02:18:55.52473+00	53063377731	profile_pictures/Profile-PNG-Photo_f8ItVuH.png	\N	107	\N	\N	\N	\N	t	2024-10-02 02:18:56.260106+00	\N	\N	2024-01-01
100	pbkdf2_sha256$720000$gybgF7NowYrBSvzkUg7nN7$/zMaVvRfbm8v4yfdKGJ60tC1T69a+lf/gH9nyxo4Nfc=	\N	f	lotfikanosxsuni4@gmail.com	LOTsxFI	KANOsxUNI	lotfikanosxsuni4@gmail.com	f	t	2024-10-25 21:27:46.336852+00	05380546393		\N	109	\N	\N	\N	\N	f	\N	\N	\N	2024-01-01
101	pbkdf2_sha256$720000$QZ26kTQO2dBnj3FQ0d05Da$SCgRMU4atpmW6s5WYHb/dPPLcRu3+LcmjimZjrikZdo=	\N	f	dfg@erg.cm	LOTFI	KANOUNI	dfg@erg.cm	f	t	2024-10-25 21:28:03.90016+00	05380546393		\N	110	\N	\N	\N	\N	f	\N	\N	\N	2024-01-01
102	pbkdf2_sha256$720000$CwR06H54JMU4LeOWHwE98y$ggm1IvviO9glfvQo9zxXNBfVUM1n64slpO/tRHYCrzM=	2024-10-25 21:28:19.074917+00	f	lo@f.com	LOTFI	KANOUNI	lo@f.com	f	t	2024-10-25 21:28:18.246123+00	05380546393	profile_pictures/Profile-PNG-Photo_UaDhjOj.png	\N	111	\N	\N	\N	\N	t	2024-10-25 21:28:19.108177+00	\N	\N	2024-01-01
103	pbkdf2_sha256$720000$IKl0dZUuanfR01RkOL0k7L$qYfyYh4l6yqDIYxI/viPRkRlOMUJRrhG/n4MIArT9dk=	2024-10-25 22:17:26.463221+00	f	kanouni.losctfi.prot@gmail.com	LOTFIsc	KANOUNIsc	kanouni.losctfi.prot@gmail.com	f	t	2024-10-25 22:14:33.05811+00	05380546393	profile_pictures/Profile-PNG-Photo_QPmpaiJ.png	\N	112	\N	\N	\N	\N	t	2024-10-25 22:17:26.476088+00	\N	\N	2024-01-01
104	pbkdf2_sha256$720000$NzDYe1tebKANr81HTyGS3z$OePtkShF+uFOT6W6pN89JW3Xs3KxRSov9pk8z9kWF+Q=	2024-10-25 23:49:02.165634+00	f	sdvsd@sgascsdf.fr	LOTFI	KANOUNI	sdvsd@sgascsdf.fr	f	t	2024-10-25 23:44:45.473218+00	05380546393	profile_pictures/Profile-PNG-Photo_0wm6lPF.png	\N	113	\N	\N	\N	\N	f	2024-10-25 23:49:02.178086+00	2024-10-25 23:54:19.422258+00	\N	2024-01-01
105	pbkdf2_sha256$720000$FN8zVodl0XXonDfQ9XfnyE$Z9AMZt9596pCht/I97aREf2zn4xLnefvI9dzk04zySY=	2024-10-25 23:54:47.508111+00	f	kanouni.lotfi.pscsrot@gmail.com	LOTFI	KANOUNI	kanouni.lotfi.pscsrot@gmail.com	f	t	2024-10-25 23:54:46.623865+00	05380546393	profile_pictures/Profile-PNG-Photo_tqD1miQ.png	\N	114	\N	\N	\N	\N	t	2024-10-25 23:54:47.518833+00	\N	\N	2024-01-01
106	pbkdf2_sha256$720000$FWuI2tHHgRlurzZfsukDtL$9Jru/RSCrb175poyQVEaRI2xL00jRRiNMk1Jxavw8bk=	2024-10-26 11:04:06.47472+00	f	aslofa@sc.cl	Esteticium	Transplant	aslofa@sc.cl	f	t	2024-10-26 11:04:05.686293+00	22334564	profile_pictures/Profile-PNG-Photo_eeLP7nx.png	\N	115	\N	\N	\N	\N	t	2024-10-26 11:04:06.499484+00	\N	\N	2024-01-01
107	pbkdf2_sha256$720000$QmouShT25SvuqjsIEHIB88$PEZmXF1RNhPl2O7apKw7z24OC1lCMhBjAjqOJ7FWFg8=	2024-10-26 17:03:44.482096+00	f	lotfikanodduni4@gmail.com	lotfi	hhh	lotfikanodduni4@gmail.com	f	t	2024-10-26 17:03:43.456839+00	90455380546393	profile_pictures/Profile-PNG-Photo_UsEHYt4.png	\N	116	\N	\N	\N	\N	t	2024-10-26 17:03:44.494155+00	\N	\N	2024-01-01
108	pbkdf2_sha256$720000$TjN6h5rkVHnRKhsavf9LKw$zKUOdyup0Dklk6JmCLkhg5csZfgIy8aG/9mzCQDrHs8=	2024-11-06 19:39:37.069562+00	f	u687pl+680mdrcc3pg44@sharklasers.com	aymen 	tizani	u687pl+680mdrcc3pg44@sharklasers.com	f	t	2024-11-06 19:39:35.706265+00	0538054639334	profile_pictures/Profile-PNG-Photo_xeag88y.png	\N	117	\N	\N	\N	\N	f	2024-11-06 19:39:37.082231+00	2024-11-06 19:41:17.12695+00	\N	2024-01-01
109	pbkdf2_sha256$720000$rKL64fi51mBIEjAdVMye58$I2WMg3xXJs9jr6MRo00kfG7irp8w2o9doNHNpofHsRc=	2024-11-06 19:42:53.496026+00	f	lofa@guerrillamail.info	faysel 	merad	lofa@guerrillamail.info	f	t	2024-11-06 19:42:52.648116+00	1234324563423	profile_pictures/Profile-PNG-Photo_2nxVBSv.png	\N	118	\N	\N	\N	\N	t	2024-11-06 19:42:53.510025+00	\N	\N	2024-01-01
110	pbkdf2_sha256$720000$C5CpkGgJWIVGoqZsLI9aFq$qEMDvTuPBNseq4vGUtWfFwTVGsrA4j99nueZpXy31jg=	2024-11-06 19:56:04.513774+00	f	regaya6916@cironex.com	Lamin	Zidan	regaya6916@cironex.com	f	t	2024-11-06 19:56:03.782257+00	053805546393	profile_pictures/17309230887328206253559055558758.jpg	\N	119	\N	\N	\N	\N	t	2024-11-06 19:56:04.527586+00	\N	AF	2024-01-01
111	!cpi2BNC7VBBAnz3DtW0Q8jRNgomjqYgD1IoGwfeq	2024-11-10 21:00:34.409556+00	f	lotfi	Lotfi	Kano	lona2023.io51023@gmail.com	f	t	2024-11-10 20:37:53.243+00			\N	\N	\N	\N	\N	\N	t	2024-11-10 21:00:34.420814+00	2024-11-10 21:00:34.355216+00	\N	\N
112	pbkdf2_sha256$720000$XlDS6PqAetz30dC4Yrvh3C$gyLPQ+aXhXDXeO/Kp4ZHYCy2rqcpasmAXxaFytLI/Qk=	2024-11-10 20:50:38.254965+00	f	asc@sdf.cy	LOTFI	KANOUNI	asc@sdf.cy	f	t	2024-11-10 20:50:37.68084+00	05380546393	profile_pictures/Profile-PNG-Photo_9IoXWNG.png	\N	120	\N	\N	\N	\N	f	2024-11-10 20:50:38.266961+00	2024-11-10 20:51:12.549174+00	\N	\N
113	!s8TnjHJEp5wAN5vjjymV0zRBDL0GrDef2gg25sG5	2024-11-10 20:53:57.820829+00	f	lotfi7	LOTFI	KANOUNI	medtouradmin@bagdadinvest.com	f	t	2024-11-10 20:53:57.756448+00			\N	\N	\N	\N	\N	\N	t	2024-11-10 20:53:57.832387+00	\N	\N	\N
115	pbkdf2_sha256$720000$Dep18TkZbXVnSPhaboVtN9$xOGyfvjzfGfKDOsEF9LWwUDfhvI0hOYyGBJeQokJlUQ=	2024-11-13 21:47:16.026971+00	f	hf@f.vk	LOTFI	KANOUNI	hf@f.vk	f	t	2024-11-13 21:47:14.882014+00	053809546393	profile_pictures/Profile-PNG-Photo_19LS1SS.png	\N	122	\N	\N	\N	\N	t	2024-11-13 21:47:16.040012+00	\N	\N	\N
116	pbkdf2_sha256$720000$Qfg6TBgpWf0ZwmzsEQRU4O$8a2ETHdFk6V01/bhS+feWU1YnHFn3lOX2djg9Q5XQLg=	2024-11-14 14:50:56.566088+00	f	kanouni.lssotfi.prot@gmail.com	LOTFIs	KANOUNIs	kanouni.lssotfi.prot@gmail.com	f	t	2024-11-14 14:50:55.61027+00	05380546393	profile_pictures/Profile-PNG-Photo_bAsqmYG.png	\N	123	b0297734ee	\N	\N	\N	t	2024-11-14 14:50:56.57943+00	\N	\N	\N
117	pbkdf2_sha256$720000$7FJUxKmik4QNnxv2dmtxh3$UgBb5I8a5QCyrHXWO0dXRGVXgM6phIoQ0ccy65hCSt0=	2024-11-15 05:15:32.753962+00	f	lotfikassnouni4@gmail.com	lotfi	nadine	lotfikassnouni4@gmail.com	f	t	2024-11-14 15:15:01.961483+00	45645645	profile_pictures/Profile-PNG-Photo_sqYCVF8.png	\N	124	637dfb0a01	\N	\N	\N	t	2024-11-15 05:15:39.29291+00	2024-11-14 15:16:08.516463+00	\N	\N
118	pbkdf2_sha256$720000$lZPvHi6ZiueJsLY4GtZ4u4$TiCGGKz0K7aRQj8cvtliS7y5RjskhujweBwLG+a3UxQ=	2024-11-17 16:25:55.555011+00	f	shazna.imtiaz@gmail.com	shazna	imtiaz	shazna.imtiaz@gmail.com	f	t	2024-11-14 18:23:15.502328+00	6475270927	profile_pictures/Profile-PNG-Photo_pJoo4sX.png	\N	125	fdfb8c99c1	\N	\N	\N	t	2024-11-17 16:25:59.286211+00	\N	\N	\N
119	pbkdf2_sha256$720000$oYbMy8w8CNp8jI2hdRqSAr$gzZA64DUg2FopvY+0xYDjrmAnjob9TEPd1gKoO5GfHs=	2024-12-09 22:48:13.470573+00	f	naci.canpolat@dentiboard.me	Naci	Canpolat	naci.canpolat@dentiboard.me	t	t	2024-11-14 20:55:26+00	905356464323	profile_pictures/Profile-PNG-Photo_HrMC0ga.png	1	126	91afc65a70	\N	\N	\N	t	2024-12-09 22:48:33.636634+00	2024-11-15 05:14:54.691386+00	\N	\N
120	pbkdf2_sha256$720000$2odEfGRhfRhGvvi3GdxN3A$0HFVrJjJOX0LEpNiR9tSKW08rGzT+3CIyf7Jg9Kp8/o=	2024-12-16 14:30:37.134208+00	f	nacicanpolat446@gmail.com	Lotfi	Kano	nacicanpolat446@gmail.com	f	t	2024-12-16 14:30:33.511872+00	5380546393	profile_pictures/Profile-PNG-Photo_uBbCvxX.png	\N	127	b1720585fa	\N	\N	\N	t	2024-12-16 14:30:38.557459+00	\N	\N	\N
1	pbkdf2_sha256$720000$pupeEnSFpfxORqFUQvpihq$1AN1WbMCrP9BgQz07gekLsDu689Ajcxle96QpAnqc/I=	2025-03-10 08:39:52.627861+00	t	LOFA	lotfi	kanouni	lofa@bc.com	t	t	2024-07-13 21:36:33+00	53839473384	profile_pictures/Profile-PNG-Photo.png	1	\N					f	2025-03-10 08:39:54.097518+00	2025-03-11 04:54:11.953095+00	DZ	1994-12-12
114	pbkdf2_sha256$720000$5DU1ePKizAuvl9ZTiI8bWS$2uBby0z/gfbCWZ1H8oVY8z79UJ3eWZ6P+dxNi2JAQlI=	2025-03-11 04:54:28.989962+00	f	lotfikanouni4@gmail.com	Lotfi	Kanouni	lotfikanouni4@gmail.com	f	t	2024-11-11 18:19:58.59527+00	053805463973	profile_pictures/Profile-PNG-Photo_wjOk3Zv.png	\N	121	\N	\N	\N	\N	t	2025-03-11 04:54:30.41806+00	2025-02-25 07:29:23.145267+00	\N	\N
121	pbkdf2_sha256$720000$7CqG1lWZiDgjG73eZdhj9W$FXNDta4DJ51qfbJnhgG1KSFaG7rBxqmSx2HAJ1H6cxs=	2024-12-18 07:57:55.422767+00	f	lofassdsd@sf.vh	LOTFIsds	KANOUNIsd	lofassdsd@sf.vh	f	t	2024-12-18 07:57:51.658779+00	905380546393	profile_pictures/Profile-PNG-Photo_A9bkeLV.png	\N	128	508ac99f11	\N	\N	\N	t	2024-12-18 07:57:56.876417+00	\N	\N	\N
3	pbkdf2_sha256$720000$kxqFOen4muOPfKbQxnKgiR$IbzPe+NxNHKdlvYuh5xeveyOQZjbw3I95WOQ4nEycJA=	2024-12-22 23:27:36.49489+00	f	hakan.yilmaz@gmail.com	Hakan	Yılmaz	hakan.yilmaz@gmail.com	f	t	2024-07-14 07:56:28+00	0538054639312	profile_pictures/WhatsApp_Image_2024-07-17_at_17.55.20.jpeg	1	2	ab6c91a8c0				t	2024-12-22 23:27:41.258172+00	\N	TR	2016-01-01
131	!akNqTzsDZZJuqRZIaNPeMi7ByHCOA1SycCSy3OGB	2025-02-21 17:38:36.128852+00	f	zambriaa@gmail.com	htEPktOjPN	OaFHNmGV	zambriaa@gmail.com	f	t	2025-02-21 17:38:34.523945+00	4459137180	profile_pictures/Profile-PNG-Photo_D8GfCqK.png	\N	137	3db0cb3c62	\N	\N	\N	t	2025-02-21 17:38:37.629055+00	\N	\N	\N
124	pbkdf2_sha256$720000$wgN4T5sXTjX8DhHDHdsVUI$UGuFuedYv5r9fgY9WQixFYhAgKv2a/doMKfF+3gLBiM=	2024-12-29 13:57:30.533499+00	f	ali67@gmail.com	Kanouni	Ali	ali67@gmail.com	f	t	2024-12-29 13:57:22.74304+00	661481858	profile_pictures/Profile-PNG-Photo_HFuLRrU.png	\N	130	d3f3349a1a	\N	\N	\N	t	2024-12-29 13:57:34.205967+00	\N	\N	\N
138	!KrE7eoLDC62QvE4myTSEDohFj9ZWlG4sgVevWmiv	2025-02-26 07:29:33.972054+00	f	utolewo891@gmail.com	VcxBMDKIlmXn	GSTkuRGcrb	utolewo891@gmail.com	f	t	2025-02-26 07:29:32.48333+00	3891538126	profile_pictures/Profile-PNG-Photo_mBrg0oz.png	\N	144	786bad7d23	\N	\N	\N	t	2025-02-26 07:29:35.442971+00	\N	\N	\N
135	pbkdf2_sha256$720000$z8XjUxahk5mVV7Ummobzh8$4q/svxfi9sgoEgbs/Y4XBCQmFKQls13ELBkxjZsXiyo=	2025-02-24 16:53:59.409269+00	f	tester@g.cm	test	test	tester@g.cm	f	t	2025-02-24 16:53:55.6999+00	5675467546	profile_pictures/Profile-PNG-Photo_Y4FROJI.png	\N	141	4badea4d32	\N	\N	\N	t	2025-02-24 16:54:00.891837+00	\N	\N	\N
125	pbkdf2_sha256$720000$gH7lPQs8NrFbgZ353MaPwz$b+sgjKgCh6E9GHMDtJnFlPhlZNXW7QfLkFfhfvWSwYM=	2024-12-29 14:09:22.927331+00	f	ref@hf.com	Referebxe	De qli	ref@hf.com	f	t	2024-12-29 14:09:17.272921+00	56166476	profile_pictures/Profile-PNG-Photo_9GUKaVj.png	\N	131	047f84a54c	\N	\N	\N	t	2024-12-29 14:09:28.51696+00	\N	\N	\N
132	!fTowfktKTruthsu98VjBINFaq2vkDoSpBUxW2sS4	2025-02-22 17:24:08.599017+00	f	wutonid36@gmail.com	gZCioecJEPuK	RwlicXLxhjWSAsZ	wutonid36@gmail.com	f	t	2025-02-22 17:24:07.025678+00	9754008660	profile_pictures/Profile-PNG-Photo_gGKt9Ne.png	\N	138	76101a4ecb	\N	\N	\N	t	2025-02-22 17:24:10.047935+00	\N	\N	\N
128	pbkdf2_sha256$720000$77GOlKRv8ivvlpOVSZu7om$IKoCW3m8QQuxV7Cvsj5BLO4EI0UI0RdsLZr7yhJmjps=	2025-01-21 00:25:34.479685+00	f	mashok2001@hotmail.com	Mashok	kale	mashok2001@hotmail.com	f	t	2025-01-21 00:19:54.304955+00	534	profile_pictures/Profile-PNG-Photo_8hy0xsL.png	\N	134	4d215549f6	\N	\N	\N	t	2025-01-21 00:25:40.105866+00	\N	\N	\N
126	pbkdf2_sha256$720000$zXKENy3S1nMrAOWLeDPt3h$ziWhN7ajn6FOYSsOptN9YQIMiFFke3Z3irbGcsmNYtA=	2025-01-16 16:59:46.257405+00	f	admin@dentidelil-international.com	lofa	test	admin@dentidelil-international.com	f	t	2025-01-16 16:59:41.167077+00	45645455	profile_pictures/Profile-PNG-Photo_bC3DXfk.png	\N	132	4c4e8cec14	\N	\N	\N	t	2025-01-16 16:59:48.621977+00	\N	\N	\N
129	pbkdf2_sha256$720000$cuvGZdOozmPBsJqEFK8VVP$ts7ZPSAF0/MRzwilPQJ+98JjdgdLK+bDagu/KwYBSR4=	2025-02-10 16:14:29.082111+00	f	kanouni.lotfi.prot@gmail.com	LOTFIss	KANOUNIsdssccs	kanouni.lotfi.prot@gmail.com	f	t	2025-02-10 16:14:25.173238+00	05380546393	profile_pictures/Profile-PNG-Photo_VBEeg0S.png	\N	135	4aefcb10cf	\N	\N	\N	t	2025-02-10 16:14:30.604427+00	\N	\N	\N
143	!RIKH0WDqp1NVWnBFqYlAbzAAOikGMh8zspy8KUf5	2025-03-03 02:18:46.71856+00	f	alishakaa1988@gmail.com	nvFpukZNikGH	HTgbqeKBWuZUNCF	alishakaa1988@gmail.com	f	t	2025-03-03 02:18:45.185229+00	5739597511	profile_pictures/Profile-PNG-Photo_rYlKhwa.png	\N	149	628bf29a20	\N	\N	\N	t	2025-03-03 02:18:48.13281+00	\N	\N	\N
133	!zUmVRQ65zNy8B1peuOXTMGAIOF6gybix2X1cOzn0	2025-02-23 11:18:05.435335+00	f	jngkqkwbdic@yahoo.com	ORjByEnxfAwJ	GotrwMTDWQFpMy	jngkqkwbdic@yahoo.com	f	t	2025-02-23 11:18:03.91493+00	6394801104	profile_pictures/Profile-PNG-Photo_5RZvgfu.png	\N	139	8f0b207b33	\N	\N	\N	t	2025-02-23 11:18:06.904546+00	\N	\N	\N
127	pbkdf2_sha256$720000$jRc9QOikBFYHlMhrSPdYe9$X4h+NUlIYohvLjnunmuPYug4gFLF+kn794SyWBgIRKI=	2025-01-16 19:32:08.857801+00	f	samuelpopp33@gmail.com	Samuel 	Popp 	samuelpopp33@gmail.com	f	t	2025-01-16 19:31:10.070861+00	9047380049	profile_pictures/Profile-PNG-Photo_hNkIXZD.png	\N	133	5979c130cc	\N	\N	\N	t	2025-01-16 19:32:12.682218+00	\N	\N	\N
136	!0ATNgBgg3gF9XPWz8siIwL9Rwh0PX9D5YkI6qZij	2025-02-25 06:39:36.404145+00	f	senagyh@yahoo.com	AfMqiYUMv	dMyuWmRzk	senagyh@yahoo.com	f	t	2025-02-25 06:39:34.216896+00	4432265970	profile_pictures/Profile-PNG-Photo_AUI2qgV.png	\N	142	03299381d0	\N	\N	\N	t	2025-02-25 06:39:38.193022+00	\N	\N	\N
139	!DnvbYNDMusDmbGtr6qbN6osKF79qhmEA6wILAJWL	2025-02-28 04:52:03.667617+00	f	ermfkxebcdcbfjuo@yahoo.com	yyHyVwMOJiCYox	ksMYyAbNwKgJe	ermfkxebcdcbfjuo@yahoo.com	f	t	2025-02-28 04:52:01.893965+00	4645739335	profile_pictures/Profile-PNG-Photo_XRL2r2y.png	\N	145	5cc1ed562c	\N	\N	\N	t	2025-02-28 04:52:05.19681+00	\N	\N	\N
134	!PTKFjGvC0IJgh3Xcn7MfciWScOBi0aCO9botSz0W	2025-02-24 05:48:58.982234+00	f	abraxasuyecho@gmail.com	hqlVcPiwopTR	RKGrmDWIfukhy	abraxasuyecho@gmail.com	f	t	2025-02-24 05:48:57.479302+00	6012094984	profile_pictures/Profile-PNG-Photo_2D5vzzk.png	\N	140	63dd6924c9	\N	\N	\N	t	2025-02-24 05:49:00.404641+00	\N	\N	\N
130	pbkdf2_sha256$720000$JWsCxrzJLWKZyJPRQ1Bn2g==$m9rB4XVmT7K38b3VQFNopZ+hKHpWv8ceaITtFwPBCHI=	2025-02-10 16:21:52+00	f	calebtarh@gmail.com	caleb	tarh	calebtarh@gmail.com	f	t	2025-02-10 16:21:48+00	05010878801	profile_pictures/Profile-PNG-Photo_rPGP8BI.png	1	136	8d64115351	\N	\N	\N	t	2025-02-10 16:21:53+00	\N	\N	\N
137	pbkdf2_sha256$720000$qoiG0NiTALoTfbolmjyLpz$b+OYBQJbcrwFWaxnGBbCeKlw3f9HlD0Hevn1XAe/Eq0=	2025-02-25 14:35:47.464328+00	f	info@gmail.com	Test 1	Test	info@gmail.com	f	t	2025-02-25 14:35:43.404081+00	05380546393	profile_pictures/Profile-PNG-Photo_ui98kZz.png	\N	143	a3daaed7d1	\N	\N	\N	t	2025-02-25 14:35:48.942159+00	\N	\N	\N
142	!w7ShNRHNcbvj52w49eXnJx32jaXtVpPbBUO9UZfi	2025-03-02 10:34:31.606684+00	f	venonnavaldezoq8@gmail.com	jJDPpAdSrZsl	TgaIhRAiwZ	venonnavaldezoq8@gmail.com	f	t	2025-03-02 10:34:29.926044+00	3767347040	profile_pictures/Profile-PNG-Photo_9SnbTuo.png	\N	148	45ffc12d41	\N	\N	\N	t	2025-03-02 10:34:33.064771+00	\N	\N	\N
140	!zOimfuL9hJLEvYH1NA6xXmAaQ9VRJOt6R153zO8M	2025-03-01 15:06:24.50694+00	f	hansenbernardw37@gmail.com	YfCUJRpOBh	qOeQIrBJiw	hansenbernardw37@gmail.com	f	t	2025-03-01 15:06:22.813832+00	4339618120	profile_pictures/Profile-PNG-Photo_J3lb0ba.png	\N	146	e084283e93	\N	\N	\N	t	2025-03-01 15:06:26.036474+00	\N	\N	\N
141	pbkdf2_sha256$720000$cBZ4Gph8JQ0JOrpyYxytEJ$9+bOFexaG2Dh5GAVi4jof9vwMvA4jBjLtEvtRNMU7FE=	\N	f	cykesdyc@do-not-respond.me	Hello	TestUser	cykesdyc@do-not-respond.me	f	t	2025-03-02 10:08:20.331574+00	68636637474		\N	147	\N	\N	\N	\N	f	\N	\N	\N	\N
146	!IlHmrgoxdocKyJwUZkQNUXUjMHRvRZuyPj4xqQOO	2025-03-06 05:58:26.24904+00	f	russodaimonds@gmail.com	nYpRnmRSKmUOmoo	LbkMXTnX	russodaimonds@gmail.com	f	t	2025-03-06 05:58:24.771357+00	9371636230	profile_pictures/Profile-PNG-Photo_SIIthuK.png	\N	152	6e3dc47361	\N	\N	\N	t	2025-03-06 05:58:27.702287+00	\N	\N	\N
147	pbkdf2_sha256$720000$qoO5MEcpW5G6wCFLHii4hy$9ZMPeOK1LsHq6OxUj0If2rlGd5+ViE5jREYpoCGPDfc=	\N	f	mprhzqiw@do-not-respond.me	Hello	MyName	mprhzqiw@do-not-respond.me	f	t	2025-03-07 01:35:39.193051+00	13498317981		\N	153	\N	\N	\N	\N	f	\N	\N	\N	\N
144	!bk9MjkIxyHocOAvEpdAxo2n3gE17Wo6Wmrg6HijB	2025-03-04 03:07:52.954979+00	f	dewsnampusi@yahoo.com	bSJfKUaQTCyoS	AgSHbNXgA	dewsnampusi@yahoo.com	f	t	2025-03-04 03:07:51.443836+00	2758574124	profile_pictures/Profile-PNG-Photo_ZYPOmJf.png	\N	150	770c63e8a1	\N	\N	\N	t	2025-03-04 03:07:54.411534+00	\N	\N	\N
145	!eSvt2X3vKN11iFduV56FYQiuZen5PpRHHKaCxunA	2025-03-05 04:18:41.975157+00	f	fletcherosmynd47@gmail.com	RvfeYKrWWbbqg	HWBPYHgyJthE	fletcherosmynd47@gmail.com	f	t	2025-03-05 04:18:40.438154+00	7607924031	profile_pictures/Profile-PNG-Photo_BZEkFgp.png	\N	151	1a493d550e	\N	\N	\N	t	2025-03-05 04:18:43.42512+00	\N	\N	\N
148	!YVLHSKCQgStHAY9cSSiUtsBFcFlTzHo2KmxgHskU	2025-03-08 08:23:45.67407+00	f	almiagattadahalli@yahoo.com	fuCAaksuVgrwUp	vMQUdVhXxqGT	almiagattadahalli@yahoo.com	f	t	2025-03-08 08:23:44.156357+00	4228239313	profile_pictures/Profile-PNG-Photo_VCNchCK.png	\N	154	dfd85b0e47	\N	\N	\N	t	2025-03-08 08:23:47.112792+00	\N	\N	\N
150	pbkdf2_sha256$720000$q8dRc4OOqrw4pNw7TH3No6$etvn066Y/NHyta06Y67tjnaNO7JpeWAVemvwlGSdiYw=	\N	f	pazapz@mailbox.in.ua	* * * Win Free Cash Instantly: http://hawaiiexplorerapp.com/uploads/coxy66.php?3kydq * * * hs=17333b2f11817618d5682865e41c2f30*	jyr7d8	pazapz@mailbox.in.ua	f	t	2025-03-09 09:45:49.974619+00	264233499862		\N	156	\N	\N	\N	\N	f	\N	\N	\N	\N
149	!yN6aEAplJxXg7M7ospmOvw0mk3JufOUtyQA5aPVx	2025-03-09 05:19:13.557593+00	f	lavpateluj46@gmail.com	HpikYlTgUjDR	pEPaHyzZq	lavpateluj46@gmail.com	f	t	2025-03-09 05:19:12.032421+00	5767287704	profile_pictures/Profile-PNG-Photo_feKuGFg.png	\N	155	1dcd4ed410	\N	\N	\N	t	2025-03-09 05:19:14.994114+00	\N	\N	\N
166	!bzHAr5o9KlwLdB28uoZCscqDREMV1qxh9eWs1IdP	2025-03-25 16:47:30.165986+00	f	greiemd2004@gmail.com	HskWcSLuoS	PHCkbNeoPONR	greiemd2004@gmail.com	f	t	2025-03-25 16:47:28.62912+00	2683849829	profile_pictures/Profile-PNG-Photo_1GN0SzS.png	\N	172	9185ede6fc	\N	\N	\N	t	2025-03-25 16:47:31.637298+00	\N	\N	\N
160	!W195QRTTwNgvTuLKDtk4BLzAIBFo6PjDuh64R31T	2025-03-19 20:12:27.03564+00	f	lmacdonaldv@gmail.com	mDjHwLYQH	fWwptnznWv	lmacdonaldv@gmail.com	f	t	2025-03-19 20:12:25.507049+00	3766561271	profile_pictures/Profile-PNG-Photo_tEzByfr.png	\N	166	49c9885ab6	\N	\N	\N	t	2025-03-19 20:12:28.519848+00	\N	\N	\N
151	!lapofPtKJeiz7tCqIvac7nrrfB1PcHMEOcbryMpz	2025-03-10 16:19:05.013305+00	f	yorklarissa1991@gmail.com	ukRQfTwEJBX	atMSgEJUGPZbqSe	yorklarissa1991@gmail.com	f	t	2025-03-10 16:19:03.441377+00	9079932557	profile_pictures/Profile-PNG-Photo_LGJvdQi.png	\N	157	dd108c2894	\N	\N	\N	t	2025-03-10 16:19:06.439156+00	\N	\N	\N
157	!Nxhm3BX63hxi1x6UhUEezExv28aL8iC6z9ECCbNb	2025-03-17 04:08:57.326922+00	f	cooelisv3@gmail.com	kRBmmwSnEKHsGY	ReIIioumuh	cooelisv3@gmail.com	f	t	2025-03-17 04:08:55.792667+00	3924625751	profile_pictures/Profile-PNG-Photo_3RkoHDM.png	\N	163	43e6eb1ec2	\N	\N	\N	t	2025-03-17 04:08:58.814781+00	\N	\N	\N
152	!Ob465ovepXtU2QYuju3YGUhNwpSa6PZ0XtjeIHWR	2025-03-12 12:35:07.494469+00	f	trnpyshynki@yahoo.com	AAhpzNnYEvLU	MmsKeFqwYXuBiJJ	trnpyshynki@yahoo.com	f	t	2025-03-12 12:35:06.031556+00	7587652439	profile_pictures/Profile-PNG-Photo_9RGSbhe.png	\N	158	98b1623124	\N	\N	\N	t	2025-03-12 12:35:08.984517+00	\N	\N	\N
164	!00cCvv2wwL4zvrGlvpfnj1qzfbbA1w7ycvs2WV56	2025-03-23 18:46:27.906599+00	f	lorenthomas1997@gmail.com	WwCiBVAT	jJDStQxRaCNgDX	lorenthomas1997@gmail.com	f	t	2025-03-23 18:46:26.2346+00	2455892925	profile_pictures/Profile-PNG-Photo_z0U6cOj.png	\N	170	7e3b3b6614	\N	\N	\N	t	2025-03-23 18:46:29.505389+00	\N	\N	\N
153	!0Hf6NCzoFP3wZaQALgSUP8wUhYZQaK2E1tD8DELI	2025-03-13 21:12:41.046902+00	f	djordjinaajr53@gmail.com	QJwcJIOmd	PeHbwodaxM	djordjinaajr53@gmail.com	f	t	2025-03-13 21:12:39.549736+00	5206072605	profile_pictures/Profile-PNG-Photo_zFqYBVV.png	\N	159	6c7b4e02be	\N	\N	\N	t	2025-03-13 21:12:42.468463+00	\N	\N	\N
158	pbkdf2_sha256$720000$W7UUI05LP1EhuMLhWGIz2l$lC4Gsv5pRidBHDXFuIroZDMGR0IU8Okv6Yz52JOEXCU=	2025-03-17 12:58:56.630715+00	f	e.xp.an.s.e.uy.o.ra.cle.7.1@gmail.com	Apple Inc. 2025. All rights reserved. Apple Inc. 2025. All rights reserved.\r\n 3737119 https://t.me/ grandbooksommer !	Apple Inc. 2025. All rights reserved. Apple Inc. 2025. All rights reserved.\r\n 3737119 https://t.me/ grandbooksommer !	e.xp.an.s.e.uy.o.ra.cle.7.1@gmail.com	f	t	2025-03-17 12:58:53.871372+00	.2025...2025..3737119.	profile_pictures/Profile-PNG-Photo_xlYDLZD.png	\N	164	725e4f6ee0	\N	\N	\N	t	2025-03-17 12:58:58.067109+00	\N	\N	\N
161	!0usZQOYWNOJpzUO6ZLjvABXB2u7Kgk8k3cquyOAy	2025-03-21 06:14:41.102874+00	f	persgloverl@gmail.com	bPHGhfKQuQxVHVL	mWbkKgCywegZw	persgloverl@gmail.com	f	t	2025-03-21 06:14:39.476225+00	3189222484	profile_pictures/Profile-PNG-Photo_EDECYYy.png	\N	167	269adee704	\N	\N	\N	t	2025-03-21 06:14:42.546727+00	\N	\N	\N
154	!jdBxXdIjHUpAhfeCbbQktvSTQ30F6QqVDPHjdcWO	2025-03-14 20:11:33.160392+00	f	j1glnifg8pyotjh@yahoo.com	aKCLyuOXEIBIRrM	RdXSNOeLCzFvXg	j1glnifg8pyotjh@yahoo.com	f	t	2025-03-14 20:11:31.641192+00	8499483117	profile_pictures/Profile-PNG-Photo_YTwTaqJ.png	\N	160	afde30fb9e	\N	\N	\N	t	2025-03-14 20:11:34.605465+00	\N	\N	\N
159	!Qoe6TyI3hQUMeZmj1uqHhVHG7U4fc4SjpVbIHD3r	2025-03-18 10:46:26.709767+00	f	caseyhymberto88@gmail.com	beMOTbmxQq	GvoUqJFd	caseyhymberto88@gmail.com	f	t	2025-03-18 10:46:25.204355+00	2715677505	profile_pictures/Profile-PNG-Photo_qoTC5M5.png	\N	165	ffaa3d53f5	\N	\N	\N	t	2025-03-18 10:46:28.169361+00	\N	\N	\N
155	!KxTn4xxHBdci8DddzpSQutX0ujhBB3cUOVyoyZ3s	2025-03-15 15:08:14.98154+00	f	richardshanacc4@gmail.com	bgAsjnfHjODRnG	zodtDCFQj	richardshanacc4@gmail.com	f	t	2025-03-15 15:08:13.383031+00	7710155194	profile_pictures/Profile-PNG-Photo_lya7PlO.png	\N	161	9f93b3a81a	\N	\N	\N	t	2025-03-15 15:08:16.472562+00	\N	\N	\N
156	!WFfcHYnHUgz7Ov2B78kDLDMLovPQdSjeKmaUK7ZU	2025-03-16 09:31:22.153744+00	f	duratri6@gmail.com	QzCLECEHWTvxQr	PJOpclOHyEgoljN	duratri6@gmail.com	f	t	2025-03-16 09:31:20.476534+00	8358216459	profile_pictures/Profile-PNG-Photo_061uJZv.png	\N	162	1cb0ca7abc	\N	\N	\N	t	2025-03-16 09:31:23.608297+00	\N	\N	\N
167	!JRpJBRWVYcRqNBDEwfaznlqekUfgAHSgJFM7gffW	2025-03-26 00:40:37.823146+00	f	tsavagecr2@gmail.com	mzknbDcKQjR	WLeOFhrxtfH	tsavagecr2@gmail.com	f	t	2025-03-26 00:40:36.249148+00	7675189176	profile_pictures/Profile-PNG-Photo_57VUC8Y.png	\N	173	cf8a0bb81e	\N	\N	\N	t	2025-03-26 00:40:39.30155+00	\N	\N	\N
162	!pXs67cpsohQoBF98Sd5kTeSdVaNWOh4Ly6LNm8B3	2025-03-21 22:38:16.564361+00	f	rjustinlp20@gmail.com	kOUzziYpgY	PJwqNXaj	rjustinlp20@gmail.com	f	t	2025-03-21 22:38:15.04721+00	7305872344	profile_pictures/Profile-PNG-Photo_vYMWnk2.png	\N	168	8908c7b658	\N	\N	\N	t	2025-03-21 22:38:18.001851+00	\N	\N	\N
165	!LiKlm7d9Ap0NeZ30RXbqVLjjtAFW2sIH6tUpVJOe	2025-03-24 12:10:35.618091+00	f	reveriee40yarn40@gmail.com	iIvqXnGmFtw	YJLABoIIBnq	reveriee40yarn40@gmail.com	f	t	2025-03-24 12:10:33.970535+00	2942144282	profile_pictures/Profile-PNG-Photo_NLv1oks.png	\N	171	a72633d684	\N	\N	\N	t	2025-03-24 12:10:37.132398+00	\N	\N	\N
163	!ORXu95afRfY9gX5WQrm7ajEYkk7uUtpxeosVE1Ip	2025-03-22 12:24:29.681406+00	f	jascof1982@gmail.com	gOFHtPIOoj	oEtopgaB	jascof1982@gmail.com	f	t	2025-03-22 12:24:28.159977+00	4663508525	profile_pictures/Profile-PNG-Photo_iSFOsjJ.png	\N	169	98dce8374c	\N	\N	\N	t	2025-03-22 12:24:31.12034+00	\N	\N	\N
\.


--
-- Data for Name: apps_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apps_user_groups (id, user_id, group_id) FROM stdin;
1	2	1
2	3	1
4	5	1
5	4	2
6	6	1
7	12	1
8	13	1
9	14	1
10	15	1
11	18	1
12	22	1
13	23	1
15	25	1
16	26	1
17	27	1
18	28	1
19	29	1
20	30	1
21	31	1
22	32	1
23	33	1
27	39	2
29	40	4
30	1	4
36	46	1
37	47	1
38	48	1
39	49	1
40	50	1
41	51	1
43	53	1
44	54	1
45	55	1
46	56	1
47	57	1
48	58	1
49	59	1
51	61	1
52	62	1
53	63	1
54	64	1
55	65	1
56	66	1
57	67	1
58	68	1
59	69	1
60	70	1
61	71	1
62	7	1
63	73	1
65	75	1
67	76	2
68	74	2
69	60	4
70	52	4
71	38	2
72	36	2
73	24	2
74	8	2
75	77	1
77	78	2
78	79	1
79	82	1
89	92	1
90	93	1
91	94	1
92	95	1
93	96	1
94	97	1
95	98	1
97	102	1
98	103	1
99	104	1
100	105	1
101	106	1
102	107	1
103	108	1
104	109	1
105	110	1
106	112	1
107	114	1
108	115	1
109	116	1
110	117	1
111	118	1
113	119	2
114	120	1
115	121	1
116	123	1
117	124	1
118	125	1
119	126	1
120	127	1
121	128	1
122	129	1
123	130	1
124	131	1
125	132	1
126	133	1
127	134	1
128	135	1
129	136	1
130	137	1
131	138	1
132	139	1
133	140	1
134	142	1
135	143	1
136	144	1
137	145	1
138	146	1
139	148	1
140	149	1
141	151	1
142	152	1
143	153	1
144	154	1
145	155	1
146	156	1
147	157	1
148	158	1
149	159	1
150	160	1
151	161	1
152	162	1
153	163	1
154	164	1
155	165	1
156	166	1
157	167	1
\.


--
-- Data for Name: apps_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apps_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
1	Patient
2	Doctor
3	Nurse
4	Corporate
5	Moderators
6	Editors
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
1	1	32
2	1	36
3	1	37
4	1	38
5	1	39
6	1	40
7	1	41
8	1	42
9	1	43
10	1	44
11	1	48
12	1	52
13	1	53
14	1	54
15	1	55
16	1	56
17	1	57
18	1	58
19	1	60
20	1	65
21	1	68
22	2	28
23	2	32
24	2	36
25	2	40
26	2	45
27	2	46
28	2	48
29	2	52
30	2	53
31	2	54
32	2	55
33	2	56
34	2	57
35	2	58
36	2	60
37	2	61
38	2	62
39	2	64
40	2	66
41	2	68
42	3	32
43	3	64
44	3	68
45	3	36
46	3	40
47	3	48
48	3	53
49	3	56
50	3	57
51	3	60
52	3	61
53	2	49
54	2	50
55	2	51
56	1	49
57	1	50
58	1	51
59	4	1
60	4	2
61	4	3
62	4	4
63	4	5
64	4	6
65	4	7
66	4	8
67	4	9
68	4	10
69	4	11
70	4	12
71	4	13
72	4	14
73	4	15
74	4	16
75	4	17
76	4	18
77	4	19
78	4	20
79	4	21
80	4	22
81	4	23
82	4	24
83	4	25
84	4	26
85	4	27
86	4	28
87	4	29
88	4	30
89	4	31
90	4	32
91	4	33
92	4	34
93	4	35
94	4	36
95	4	37
96	4	38
97	4	39
98	4	40
99	4	41
100	4	42
101	4	43
102	4	44
103	4	45
104	4	46
105	4	47
106	4	48
107	4	49
108	4	50
109	4	51
110	4	52
111	4	53
112	4	54
113	4	55
114	4	56
115	4	57
116	4	58
117	4	59
118	4	60
119	4	61
120	4	62
121	4	63
122	4	64
123	4	65
124	4	66
125	4	67
126	4	68
131	4	73
132	4	74
133	4	75
134	4	76
135	4	77
136	4	78
137	4	79
138	4	80
139	4	81
140	4	82
141	4	83
142	4	84
143	4	85
144	4	86
145	4	87
146	4	88
147	4	89
148	4	90
149	4	91
150	4	92
151	6	145
152	5	145
153	6	248
154	6	246
155	6	247
156	5	248
157	5	246
158	5	247
159	6	249
160	5	249
161	6	250
162	6	251
163	6	252
164	5	250
165	5	251
166	5	252
167	6	253
168	5	253
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, content_type_id, codename, name) FROM stdin;
1	1	add_logentry	Can add log entry
2	1	change_logentry	Can change log entry
3	1	delete_logentry	Can delete log entry
4	1	view_logentry	Can view log entry
5	2	add_permission	Can add permission
6	2	change_permission	Can change permission
7	2	delete_permission	Can delete permission
8	2	view_permission	Can view permission
9	3	add_group	Can add group
10	3	change_group	Can change group
11	3	delete_group	Can delete group
12	3	view_group	Can view group
13	4	add_contenttype	Can add content type
14	4	change_contenttype	Can change content type
15	4	delete_contenttype	Can delete content type
16	4	view_contenttype	Can view content type
17	5	add_session	Can add session
18	5	change_session	Can change session
19	5	delete_session	Can delete session
20	5	view_session	Can view session
21	6	add_user	Can add user
22	6	change_user	Can change user
23	6	delete_user	Can delete user
24	6	view_user	Can view user
25	7	add_contact	Can add contact
26	7	change_contact	Can change contact
27	7	delete_contact	Can delete contact
28	7	view_contact	Can view contact
29	8	add_emergencycontact	Can add emergency contact
30	8	change_emergencycontact	Can change emergency contact
31	8	delete_emergencycontact	Can delete emergency contact
32	8	view_emergencycontact	Can view emergency contact
33	9	add_hospital	Can add hospital
34	9	change_hospital	Can change hospital
35	9	delete_hospital	Can delete hospital
36	9	view_hospital	Can view hospital
37	10	add_insurance	Can add insurance
38	10	change_insurance	Can change insurance
39	10	delete_insurance	Can delete insurance
40	10	view_insurance	Can view insurance
41	11	add_subscription	Can add subscription
42	11	change_subscription	Can change subscription
43	11	delete_subscription	Can delete subscription
44	11	view_subscription	Can view subscription
45	12	add_prescription	Can add prescription
46	12	change_prescription	Can change prescription
47	12	delete_prescription	Can delete prescription
48	12	view_prescription	Can view prescription
49	13	add_messagegroup	Can add message group
50	13	change_messagegroup	Can change message group
51	13	delete_messagegroup	Can delete message group
52	13	view_messagegroup	Can view message group
53	14	add_message	Can add message
54	14	change_message	Can change message
55	14	delete_message	Can delete message
56	14	view_message	Can view message
57	15	add_medicalinformation	Can add medical information
58	15	change_medicalinformation	Can change medical information
59	15	delete_medicalinformation	Can delete medical information
60	15	view_medicalinformation	Can view medical information
61	16	add_hospitalstay	Can add hospital stay
62	16	change_hospitalstay	Can change hospital stay
63	16	delete_hospitalstay	Can delete hospital stay
64	16	view_hospitalstay	Can view hospital stay
65	17	add_appointment	Can add appointment
66	17	change_appointment	Can change appointment
67	17	delete_appointment	Can delete appointment
68	17	view_appointment	Can view appointment
73	19	add_referral	Can add referral
74	19	change_referral	Can change referral
75	19	delete_referral	Can delete referral
76	19	view_referral	Can view referral
77	20	add_taskresult	Can add task result
78	20	change_taskresult	Can change task result
79	20	delete_taskresult	Can delete task result
80	20	view_taskresult	Can view task result
81	21	add_chordcounter	Can add chord counter
82	21	change_chordcounter	Can change chord counter
83	21	delete_chordcounter	Can delete chord counter
84	21	view_chordcounter	Can view chord counter
85	22	add_groupresult	Can add group result
86	22	change_groupresult	Can change group result
87	22	delete_groupresult	Can delete group result
88	22	view_groupresult	Can view group result
89	23	add_openaitask	Can add openai task
90	23	change_openaitask	Can change openai task
91	23	delete_openaitask	Can delete openai task
92	23	view_openaitask	Can view openai task
93	24	add_profile	Can add profile
94	24	change_profile	Can change profile
95	24	delete_profile	Can delete profile
96	24	view_profile	Can view profile
97	25	add_image	Can add image
98	25	change_image	Can change image
99	25	delete_image	Can delete image
100	25	view_image	Can view image
101	26	add_comments	Can add comments
102	26	change_comments	Can change comments
103	26	delete_comments	Can delete comments
104	26	view_comments	Can view comments
105	27	add_comments	Can add comments
106	27	change_comments	Can change comments
107	27	delete_comments	Can delete comments
108	27	view_comments	Can view comments
109	28	add_image	Can add image
110	28	change_image	Can change image
111	28	delete_image	Can delete image
112	28	view_image	Can view image
113	29	add_profile	Can add profile
114	29	change_profile	Can change profile
115	29	delete_profile	Can delete profile
116	29	view_profile	Can view profile
117	30	add_site	Can add site
118	30	change_site	Can change site
119	30	delete_site	Can delete site
120	30	view_site	Can view site
121	31	add_emailaddress	Can add email address
122	31	change_emailaddress	Can change email address
123	31	delete_emailaddress	Can delete email address
124	31	view_emailaddress	Can view email address
125	32	add_emailconfirmation	Can add email confirmation
126	32	change_emailconfirmation	Can change email confirmation
127	32	delete_emailconfirmation	Can delete email confirmation
128	32	view_emailconfirmation	Can view email confirmation
129	33	add_socialaccount	Can add social account
130	33	change_socialaccount	Can change social account
131	33	delete_socialaccount	Can delete social account
132	33	view_socialaccount	Can view social account
133	34	add_socialapp	Can add social application
134	34	change_socialapp	Can change social application
135	34	delete_socialapp	Can delete social application
136	34	view_socialapp	Can view social application
137	35	add_socialtoken	Can add social application token
138	35	change_socialtoken	Can change social application token
139	35	delete_socialtoken	Can delete social application token
140	35	view_socialtoken	Can view social application token
141	36	add_emailtemplate	Can add email template
142	36	change_emailtemplate	Can change email template
143	36	delete_emailtemplate	Can delete email template
144	36	view_emailtemplate	Can view email template
145	38	access_admin	Can access Wagtail admin
146	40	add_locale	Can add locale
147	40	change_locale	Can change locale
148	40	delete_locale	Can delete locale
149	40	view_locale	Can view locale
150	41	add_site	Can add site
151	41	change_site	Can change site
152	41	delete_site	Can delete site
153	41	view_site	Can view site
154	42	add_modellogentry	Can add model log entry
155	42	change_modellogentry	Can change model log entry
156	42	delete_modellogentry	Can delete model log entry
157	42	view_modellogentry	Can view model log entry
158	43	add_collectionviewrestriction	Can add collection view restriction
159	43	change_collectionviewrestriction	Can change collection view restriction
160	43	delete_collectionviewrestriction	Can delete collection view restriction
161	43	view_collectionviewrestriction	Can view collection view restriction
162	44	add_collection	Can add collection
163	44	change_collection	Can change collection
164	44	delete_collection	Can delete collection
165	44	view_collection	Can view collection
166	45	add_groupcollectionpermission	Can add group collection permission
167	45	change_groupcollectionpermission	Can change group collection permission
168	45	delete_groupcollectionpermission	Can delete group collection permission
169	45	view_groupcollectionpermission	Can view group collection permission
170	46	add_uploadedfile	Can add uploaded file
171	46	change_uploadedfile	Can change uploaded file
172	46	delete_uploadedfile	Can delete uploaded file
173	46	view_uploadedfile	Can view uploaded file
174	47	add_referenceindex	Can add reference index
175	47	change_referenceindex	Can change reference index
176	47	delete_referenceindex	Can delete reference index
177	47	view_referenceindex	Can view reference index
178	37	add_page	Can add page
179	37	change_page	Can change page
180	37	delete_page	Can delete page
181	37	view_page	Can view page
182	37	bulk_delete_page	Delete pages with children
183	37	lock_page	Lock/unlock pages you've locked
184	37	publish_page	Publish any page
185	37	unlock_page	Unlock any page
186	48	add_revision	Can add revision
187	48	change_revision	Can change revision
188	48	delete_revision	Can delete revision
344	86	add_token	Can add Token
189	48	view_revision	Can view revision
190	49	add_grouppagepermission	Can add group page permission
191	49	change_grouppagepermission	Can change group page permission
192	49	delete_grouppagepermission	Can delete group page permission
193	49	view_grouppagepermission	Can view group page permission
194	50	add_pageviewrestriction	Can add page view restriction
195	50	change_pageviewrestriction	Can change page view restriction
196	50	delete_pageviewrestriction	Can delete page view restriction
197	50	view_pageviewrestriction	Can view page view restriction
198	51	add_workflowpage	Can add workflow page
199	51	change_workflowpage	Can change workflow page
200	51	delete_workflowpage	Can delete workflow page
201	51	view_workflowpage	Can view workflow page
202	52	add_workflowcontenttype	Can add workflow content type
203	52	change_workflowcontenttype	Can change workflow content type
204	52	delete_workflowcontenttype	Can delete workflow content type
205	52	view_workflowcontenttype	Can view workflow content type
206	53	add_workflowtask	Can add workflow task order
207	53	change_workflowtask	Can change workflow task order
208	53	delete_workflowtask	Can delete workflow task order
209	53	view_workflowtask	Can view workflow task order
210	54	add_task	Can add task
211	54	change_task	Can change task
212	54	delete_task	Can delete task
213	54	view_task	Can view task
214	55	add_workflow	Can add workflow
215	55	change_workflow	Can change workflow
216	55	delete_workflow	Can delete workflow
217	55	view_workflow	Can view workflow
218	39	add_groupapprovaltask	Can add Group approval task
219	39	change_groupapprovaltask	Can change Group approval task
220	39	delete_groupapprovaltask	Can delete Group approval task
221	39	view_groupapprovaltask	Can view Group approval task
222	56	add_workflowstate	Can add Workflow state
223	56	change_workflowstate	Can change Workflow state
224	56	delete_workflowstate	Can delete Workflow state
225	56	view_workflowstate	Can view Workflow state
226	57	add_taskstate	Can add Task state
227	57	change_taskstate	Can change Task state
228	57	delete_taskstate	Can delete Task state
229	57	view_taskstate	Can view Task state
230	58	add_pagelogentry	Can add page log entry
231	58	change_pagelogentry	Can change page log entry
232	58	delete_pagelogentry	Can delete page log entry
233	58	view_pagelogentry	Can view page log entry
234	59	add_comment	Can add comment
235	59	change_comment	Can change comment
236	59	delete_comment	Can delete comment
237	59	view_comment	Can view comment
238	60	add_commentreply	Can add comment reply
239	60	change_commentreply	Can change comment reply
240	60	delete_commentreply	Can delete comment reply
241	60	view_commentreply	Can view comment reply
242	61	add_pagesubscription	Can add page subscription
243	61	change_pagesubscription	Can change page subscription
244	61	delete_pagesubscription	Can delete page subscription
245	61	view_pagesubscription	Can view page subscription
246	62	add_document	Can add document
247	62	change_document	Can change document
248	62	delete_document	Can delete document
249	62	choose_document	Can choose document
250	63	add_image	Can add image
251	63	change_image	Can change image
252	63	delete_image	Can delete image
253	63	choose_image	Can choose image
254	64	add_formsubmission	Can add form submission
255	64	change_formsubmission	Can change form submission
256	64	delete_formsubmission	Can delete form submission
257	64	view_formsubmission	Can view form submission
258	65	add_redirect	Can add redirect
259	65	change_redirect	Can change redirect
260	65	delete_redirect	Can delete redirect
261	65	view_redirect	Can view redirect
262	66	add_embed	Can add embed
263	66	change_embed	Can change embed
264	66	delete_embed	Can delete embed
265	66	view_embed	Can view embed
266	67	add_userprofile	Can add user profile
267	67	change_userprofile	Can change user profile
268	67	delete_userprofile	Can delete user profile
269	67	view_userprofile	Can view user profile
270	62	view_document	Can view document
271	63	view_image	Can view image
272	68	add_rendition	Can add rendition
273	68	change_rendition	Can change rendition
274	68	delete_rendition	Can delete rendition
275	68	view_rendition	Can view rendition
276	69	add_indexentry	Can add index entry
277	69	change_indexentry	Can change index entry
278	69	delete_indexentry	Can delete index entry
279	69	view_indexentry	Can view index entry
284	71	add_editingsession	Can add editing session
285	71	change_editingsession	Can change editing session
286	71	delete_editingsession	Can delete editing session
287	71	view_editingsession	Can view editing session
288	72	add_tag	Can add tag
289	72	change_tag	Can change tag
290	72	delete_tag	Can delete tag
291	72	view_tag	Can view tag
292	73	add_taggeditem	Can add tagged item
293	73	change_taggeditem	Can change tagged item
294	73	delete_taggeditem	Can delete tagged item
295	73	view_taggeditem	Can view tagged item
296	74	add_homepage	Can add home page
297	74	change_homepage	Can change home page
298	74	delete_homepage	Can delete home page
299	74	view_homepage	Can view home page
300	75	add_action	Can add action
301	75	change_action	Can change action
302	75	delete_action	Can delete action
303	75	view_action	Can view action
304	76	add_follow	Can add follow
305	76	change_follow	Can change follow
306	76	delete_follow	Can delete follow
307	76	view_follow	Can view follow
308	77	add_treatmentplanitem	Can add treatment plan item
309	77	change_treatmentplanitem	Can change treatment plan item
310	77	delete_treatmentplanitem	Can delete treatment plan item
311	77	view_treatmentplanitem	Can view treatment plan item
312	78	add_treatmentplan	Can add treatment plan
313	78	change_treatmentplan	Can change treatment plan
314	78	delete_treatmentplan	Can delete treatment plan
315	78	view_treatmentplan	Can view treatment plan
316	79	add_treatmentproduct	Can add treatment product
317	79	change_treatmentproduct	Can change treatment product
318	79	delete_treatmentproduct	Can delete treatment product
319	79	view_treatmentproduct	Can view treatment product
320	80	add_medicalfile	Can add medical file
321	80	change_medicalfile	Can change medical file
322	80	delete_medicalfile	Can delete medical file
323	80	view_medicalfile	Can view medical file
324	81	add_patientschedule	Can add Patient Schedule
325	81	change_patientschedule	Can change Patient Schedule
326	81	delete_patientschedule	Can delete Patient Schedule
327	81	view_patientschedule	Can view Patient Schedule
328	82	add_flightreservation	Can add Flight Reservation
329	82	change_flightreservation	Can change Flight Reservation
330	82	delete_flightreservation	Can delete Flight Reservation
331	82	view_flightreservation	Can view Flight Reservation
332	83	add_accommodation	Can add Accommodation
333	83	change_accommodation	Can change Accommodation
334	83	delete_accommodation	Can delete Accommodation
335	83	view_accommodation	Can view Accommodation
336	84	add_hotel	Can add Hotel
337	84	change_hotel	Can change Hotel
338	84	delete_hotel	Can delete Hotel
339	84	view_hotel	Can view Hotel
340	85	add_batontheme	Can add admin theme
341	85	change_batontheme	Can change admin theme
342	85	delete_batontheme	Can delete admin theme
343	85	view_batontheme	Can view admin theme
345	86	change_token	Can change Token
346	86	delete_token	Can delete Token
347	86	view_token	Can view Token
348	87	add_tokenproxy	Can add Token
349	87	change_tokenproxy	Can change Token
350	87	delete_tokenproxy	Can delete Token
351	87	view_tokenproxy	Can view Token
352	88	add_lead	Can add lead
353	88	change_lead	Can change lead
354	88	delete_lead	Can delete lead
355	88	view_lead	Can view lead
356	89	add_leadhistory	Can add lead history
357	89	change_leadhistory	Can change lead history
358	89	delete_leadhistory	Can delete lead history
359	89	view_leadhistory	Can view lead history
360	90	add_note	Can add note
361	90	change_note	Can change note
362	90	delete_note	Can delete note
363	90	view_note	Can view note
\.


--
-- Data for Name: authtoken_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authtoken_token (key, created, user_id) FROM stdin;
\.


--
-- Data for Name: baton_batontheme; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.baton_batontheme (name, theme, active, id) FROM stdin;
\.


--
-- Data for Name: blog_comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.blog_comments (id, comment_post, date, author_id, commented_image_id) FROM stdin;
\.


--
-- Data for Name: blog_image; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.blog_image (id, image, image_caption, tag_someone, date, imageuploader_profile_id) FROM stdin;
\.


--
-- Data for Name: blog_image_image_likes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.blog_image_image_likes (id, image_id, profile_id) FROM stdin;
\.


--
-- Data for Name: blog_profile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.blog_profile (id, first_name, last_name, bio, profile_pic, profile_avatar, date, beyondblog_profileid, user_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, change_message, content_type_id, user_id, action_flag) FROM stdin;
1	2024-07-13 21:38:24.980271+00	1	Patient	[{"added": {}}]	3	1	1
2	2024-07-13 21:39:58.729314+00	2	Nurse	[{"added": {}}]	3	1	1
3	2024-07-13 21:40:22.301818+00	2	Doctor	[{"changed": {"fields": ["name"]}}]	3	1	2
4	2024-07-13 21:40:56.476146+00	3	Nurse	[{"added": {}}]	3	1	1
5	2024-07-13 21:42:16.447703+00	1	DentAslan ağız ve diş sağlığı polikliniği with Söğütlü Çeşme, Halkalı Cd no:261/b	[{"added": {}}]	9	1	1
6	2024-07-13 21:42:57.574696+00	2	Esteticium Hair Transplant with Aşık Veysel, Esenkent Mahallesi, Süleyman Demirel Cd. No:34	[{"added": {}}]	9	1	1
7	2024-07-13 21:43:18.490873+00	1	LOTFI is Manager of him/her	[{"added": {}}]	8	1	1
8	2024-07-14 07:55:07.096823+00	2	<User:  patient1>		6	2	1
9	2024-07-14 07:55:07.108423+00	1	Sex: , Insurance:  with , Medications: , Allergies: , Medical Conditions: , Family History: , Additional Info: 		15	2	1
10	2024-07-14 07:55:07.121421+00	1	 with 		10	2	1
11	2024-07-14 07:55:07.144405+00	2	<User:  patient1>		6	2	1
12	2024-07-14 07:56:28.374394+00	3	<User:  patient2>		6	3	1
13	2024-07-14 07:56:28.386419+00	2	Sex: , Insurance:  with , Medications: , Allergies: , Medical Conditions: , Family History: , Additional Info: 		15	3	1
14	2024-07-14 07:56:28.396992+00	2	 with 		10	3	1
15	2024-07-14 07:56:28.418368+00	3	<User:  patient2>		6	3	1
16	2024-07-17 13:12:11.750649+00	1	DOLIPRANE for  patient1	[{"added": {}}]	12	1	1
17	2024-07-19 01:13:23.388418+00	4	<User:  Doctor2>		6	4	1
18	2024-07-19 01:13:23.400606+00	3	Sex: , Insurance:  with , Medications: , Allergies: , Medical Conditions: , Family History: , Additional Info: 		15	4	1
19	2024-07-19 01:13:23.410101+00	3	 with 		10	4	1
20	2024-07-19 01:13:23.431367+00	4	<User:  Doctor2>		6	4	1
21	2024-07-19 01:19:05.386519+00	5	<User:  doc3>		6	5	1
22	2024-07-19 01:19:05.396519+00	4	Sex: , Insurance:  with , Medications: , Allergies: , Medical Conditions: , Family History: , Additional Info: 		15	5	1
23	2024-07-19 01:19:05.406521+00	4	 with 		10	5	1
24	2024-07-19 01:19:05.428944+00	5	<User:  doc3>		6	5	1
25	2024-07-19 01:22:25.148978+00	4	 Doctor2	[{"changed": {"fields": ["groups", "emergency_contact"]}}]	6	1	2
26	2024-07-19 01:30:17.289686+00	3	Sex: , Insurance:  with , Medications: , Allergies: , Medical Conditions: , Family History: , Additional Info: 	Changed fields.	15	4	2
27	2024-07-19 01:30:17.317873+00	4	<User:  Doctor2>	Changed fields.	6	4	2
28	2024-07-19 01:30:37.308328+00	1	<MessageGroup: MessageGroup object (1)>		13	4	1
29	2024-07-19 01:35:53.640346+00	2	<MessageGroup: MessageGroup object (2)>		13	4	1
30	2024-07-19 01:35:53.752396+00	3	<MessageGroup: MessageGroup object (3)>		13	4	1
31	2024-07-19 01:41:59.397967+00	4	<MessageGroup: MessageGroup object (4)>		13	4	1
32	2024-07-19 02:49:16.89076+00	5	<MessageGroup: MessageGroup object (5)>		13	3	1
33	2024-07-19 03:35:19.915091+00	2	Doctor	[{"changed": {"fields": ["permissions"]}}]	3	1	2
34	2024-07-19 03:35:51.025092+00	1	Patient	[{"changed": {"fields": ["permissions"]}}]	3	1	2
35	2024-07-19 13:22:12.56648+00	6	<User:  Adam>		6	6	1
36	2024-07-19 13:22:12.582492+00	5	Sex: , Insurance:  with , Medications: , Allergies: , Medical Conditions: , Family History: , Additional Info: 		15	6	1
37	2024-07-19 13:22:12.597353+00	5	 with 		10	6	1
38	2024-07-19 13:22:12.623869+00	6	<User:  Adam>		6	6	1
39	2024-07-19 19:18:59.876721+00	3	DENTAL with DENTAL SERVICES	[{"added": {}}]	9	1	1
40	2024-07-19 19:19:53.260492+00	3	DENTAL with SERVICES	[{"changed": {"fields": ["Address"]}}]	9	1	2
41	2024-07-19 19:20:27.430014+00	4	ESTHTIC SURGERIES with SERVICES	[{"added": {}}]	9	1	1
42	2024-07-19 19:20:59.105654+00	5	GASTRICS with Weight Loss	[{"added": {}}]	9	1	1
43	2024-07-19 19:21:04.340703+00	4	ESTHTIC SURGERIES with SERVICES	[{"changed": {"fields": ["City"]}}]	9	1	2
44	2024-07-19 19:21:45.965224+00	6	HAIR RESTORATION with SERVICES	[{"added": {}}]	9	1	1
45	2024-07-19 19:22:13.764385+00	3	DENTAL SERVICES with SERVICES	[{"changed": {"fields": ["Name"]}}]	9	1	2
46	2024-07-19 19:22:48.141295+00	2	Esteticium Hair Transplant with Aşık Veysel, Esenkent Mahallesi, Süleyman Demirel Cd. No:34		9	1	3
47	2024-07-19 19:22:50.574807+00	1	DentAslan ağız ve diş sağlığı polikliniği with Söğütlü Çeşme, Halkalı Cd no:261/b	[]	9	1	2
48	2024-07-19 19:22:53.614732+00	1	DentAslan ağız ve diş sağlığı polikliniği with Söğütlü Çeşme, Halkalı Cd no:261/b		9	1	3
49	2024-07-19 19:23:15.014443+00	7	INTERNAL SURGERIES with SERVICES	[{"added": {}}]	9	1	1
50	2024-07-20 15:32:42.539858+00	3	 patient2	[{"changed": {"fields": ["Emergency contact"]}}]	6	1	2
51	2024-07-20 15:36:01.720014+00	3	 patient2	[{"changed": {"fields": ["Thumbnail"]}}]	6	1	2
52	2024-07-20 20:54:38.253795+00	12	<User:  hasta8>		6	12	1
53	2024-07-20 20:54:38.266123+00	19	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	12	1
54	2024-07-20 20:54:38.277674+00	21	None with None		10	12	1
55	2024-07-20 20:54:38.32526+00	12	<User:  hasta8>		6	12	1
56	2024-07-20 21:17:08.344941+00	13	<User:  hasta9>		6	13	1
57	2024-07-20 21:17:08.35796+00	20	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	13	1
58	2024-07-20 21:17:08.37058+00	22	None with None		10	13	1
59	2024-07-20 21:17:08.42828+00	13	<User:  hasta9>		6	13	1
60	2024-07-20 21:19:38.792171+00	14	<User:  hasta10>		6	14	1
61	2024-07-20 21:19:38.805956+00	21	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	14	1
62	2024-07-20 21:19:38.816649+00	23	None with None		10	14	1
63	2024-07-20 21:19:38.866234+00	14	<User:  hasta10>		6	14	1
64	2024-07-21 04:32:46.404175+00	15	<User:  hasta11>		6	15	1
65	2024-07-21 04:32:46.417539+00	22	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	15	1
66	2024-07-21 04:32:46.430507+00	24	None with None		10	15	1
67	2024-07-21 04:38:46.076352+00	18	<User:  hasta13>		6	18	1
68	2024-07-21 04:38:46.086381+00	25	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	18	1
69	2024-07-21 04:38:46.097326+00	27	None with None		10	18	1
70	2024-07-21 06:14:58.795443+00	22	<User:  reftest>		6	22	1
71	2024-07-21 06:14:58.8097+00	29	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	22	1
72	2024-07-21 06:14:58.821289+00	31	None with None		10	22	1
73	2024-07-21 06:34:51.740224+00	23	<User:  reftest16>		6	23	1
74	2024-07-21 06:34:51.752676+00	30	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	23	1
75	2024-07-21 06:34:51.763883+00	32	None with None		10	23	1
76	2024-07-21 06:34:51.826931+00	23	<User:  reftest16>		6	23	1
77	2024-07-21 06:35:40.170708+00	24	<User:  reftest16>		6	24	1
78	2024-07-21 06:35:40.182713+00	31	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	24	1
79	2024-07-21 06:35:40.193247+00	33	None with None		10	24	1
80	2024-07-21 06:36:52.796819+00	25	<User:  reftest18>		6	25	1
81	2024-07-21 06:36:52.807905+00	32	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	25	1
82	2024-07-21 06:36:52.819247+00	34	None with None		10	25	1
83	2024-07-21 06:38:07.472552+00	26	<User:  reftest19>		6	26	1
84	2024-07-21 06:38:07.482102+00	33	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	26	1
85	2024-07-21 06:38:07.493844+00	35	None with None		10	26	1
86	2024-07-21 07:06:55.717373+00	27	<User:  test19>		6	27	1
87	2024-07-21 07:06:55.732297+00	34	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	27	1
88	2024-07-21 07:06:55.74573+00	36	None with None		10	27	1
89	2024-07-21 07:06:55.853139+00	27	<User:  test19>		6	27	1
90	2024-07-21 07:10:02.452029+00	28	<User:  test22>		6	28	1
91	2024-07-21 07:10:02.46687+00	35	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	28	1
92	2024-07-21 07:10:02.478645+00	37	None with None		10	28	1
93	2024-07-21 07:10:02.570555+00	28	<User:  test22>		6	28	1
94	2024-07-21 07:23:32.382077+00	29	<User:  test21>		6	29	1
95	2024-07-21 07:23:32.394002+00	36	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	29	1
96	2024-07-21 07:23:32.406314+00	38	None with None		10	29	1
97	2024-07-21 07:23:32.469326+00	29	<User:  test21>		6	29	1
98	2024-07-21 07:24:10.162601+00	30	<User:  test22>		6	30	1
99	2024-07-21 07:24:10.174184+00	37	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	30	1
100	2024-07-21 07:24:10.18322+00	39	None with None		10	30	1
101	2024-07-21 07:24:10.260964+00	30	<User:  test22>		6	30	1
102	2024-07-21 07:53:48.734545+00	6	<MessageGroup: MessageGroup object (6)>		13	10	1
103	2024-07-21 08:16:18.842334+00	31	<User:  hasta22>		6	31	1
104	2024-07-21 08:16:18.876335+00	38	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	31	1
105	2024-07-21 08:16:18.890257+00	40	None with None		10	31	1
106	2024-07-21 08:16:18.946454+00	31	<User:  hasta22>		6	31	1
107	2024-07-21 08:18:13.728479+00	32	<User:  hasta23>		6	32	1
108	2024-07-21 08:18:13.739713+00	39	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	32	1
109	2024-07-21 08:18:13.764204+00	41	None with None		10	32	1
110	2024-07-21 08:18:13.824395+00	32	<User:  hasta23>		6	32	1
111	2024-07-21 08:20:49.991085+00	33	<User:  hasta25>		6	33	1
112	2024-07-21 08:20:50.005092+00	40	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	33	1
113	2024-07-21 08:20:50.015077+00	42	None with None		10	33	1
114	2024-07-21 08:20:50.078572+00	33	<User:  hasta25>		6	33	1
115	2024-07-21 09:35:28.208156+00	36	<User:  hasta28>		6	36	1
116	2024-07-21 09:35:28.220626+00	43	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	36	1
117	2024-07-21 09:35:28.233547+00	45	None with None		10	36	1
118	2024-07-21 09:39:02.011853+00	38	<User:  hasta30>		6	38	1
119	2024-07-21 09:39:02.025727+00	45	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	38	1
120	2024-07-21 09:39:02.04044+00	47	None with None		10	38	1
121	2024-07-21 09:39:02.108394+00	38	<User:  hasta30>		6	38	1
122	2024-07-25 08:08:07.104355+00	39	<User:  doctor1>		6	39	1
123	2024-07-25 08:08:07.119703+00	46	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	39	1
124	2024-07-25 08:08:07.136289+00	48	None with None		10	39	1
125	2024-07-25 08:08:07.214576+00	39	<User:  doctor1>		6	39	1
126	2024-07-25 08:09:22.38937+00	39	 doctor1	[{"changed": {"fields": ["Groups", "Emergency contact"]}}]	6	1	2
127	2024-07-25 08:09:49.38304+00	7	<MessageGroup: MessageGroup object (7)>		13	3	1
128	2024-07-25 08:12:22.530231+00	8	<MessageGroup: MessageGroup object (8)>		13	3	1
129	2024-07-28 18:40:12.25777+00	4	Corporate	[{"added": {}}]	3	1	1
209	2024-08-09 03:46:09.158127+00	62	<User:  qacenugo>		6	62	1
130	2024-07-28 18:41:50.099123+00	39	 doctor1	[{"changed": {"fields": ["Staff status"]}}]	6	1	2
131	2024-07-29 23:10:59.910887+00	40	<User:  corporate>		6	40	1
132	2024-07-29 23:10:59.923428+00	47	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	40	1
133	2024-07-29 23:10:59.934497+00	49	None with None		10	40	1
134	2024-07-29 23:11:00.002378+00	40	<User:  corporate>		6	40	1
135	2024-07-29 23:11:29.64058+00	40	 corporate	[{"changed": {"fields": ["Groups", "Emergency contact"]}}]	6	1	2
136	2024-07-29 23:11:44.930069+00	40	 corporate	[{"changed": {"fields": ["Staff status"]}}]	6	1	2
137	2024-07-31 18:12:27.818229+00	1	 lotfi	[{"changed": {"fields": ["Groups", "Emergency contact"]}}]	6	1	2
153	2024-08-06 04:22:06.459584+00	47	<User:  hasta34>		6	47	1
154	2024-08-06 04:22:06.475823+00	54	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	47	1
155	2024-08-06 04:22:06.493203+00	56	None with None		10	47	1
156	2024-08-06 04:22:06.566771+00	47	<User:  hasta34>		6	47	1
157	2024-08-06 04:28:29.557543+00	48	<User:  HASTA35>		6	48	1
158	2024-08-06 04:28:29.570464+00	55	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	48	1
159	2024-08-06 04:28:29.582946+00	57	None with None		10	48	1
160	2024-08-06 04:29:39.225497+00	49	<User:  HASTA36>		6	49	1
161	2024-08-06 04:29:39.236992+00	56	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	49	1
162	2024-08-06 04:29:39.2491+00	58	None with None		10	49	1
163	2024-08-06 04:29:39.351578+00	49	<User:  HASTA36>		6	49	1
164	2024-08-06 04:35:13.40398+00	50	<User:  hasta37>		6	50	1
165	2024-08-06 04:35:13.420088+00	57	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	50	1
166	2024-08-06 04:35:13.451756+00	59	None with None		10	50	1
167	2024-08-06 04:35:13.578693+00	50	<User:  hasta37>		6	50	1
168	2024-08-06 04:42:22.573574+00	51	<User:  tester>		6	51	1
169	2024-08-06 04:42:22.587675+00	58	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	51	1
170	2024-08-06 04:42:22.602157+00	60	None with None		10	51	1
171	2024-08-06 04:42:24.393579+00	51	<User:  tester>		6	51	1
172	2024-08-06 04:57:00.995243+00	52	<User:  lotficasc>		6	52	1
173	2024-08-06 04:57:01.008765+00	59	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	52	1
174	2024-08-06 04:57:01.021443+00	61	None with None		10	52	1
175	2024-08-06 04:57:01.919498+00	52	<User:  lotficasc>		6	52	1
176	2024-08-06 05:31:02.343141+00	53	<User:  LOTFIt>		6	53	1
177	2024-08-06 05:31:02.365266+00	60	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	53	1
178	2024-08-06 05:31:02.378085+00	62	None with None		10	53	1
179	2024-08-06 05:31:03.778199+00	53	<User:  LOTFIt>		6	53	1
180	2024-08-06 05:40:05.524002+00	54	<User:  hasta38>		6	54	1
181	2024-08-06 05:40:05.540928+00	61	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	54	1
182	2024-08-06 05:40:05.555911+00	63	None with None		10	54	1
183	2024-08-06 05:42:44.678516+00	55	<User:  hasta55>		6	55	1
184	2024-08-06 05:42:44.693107+00	62	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	55	1
185	2024-08-06 05:42:44.705787+00	64	None with None		10	55	1
186	2024-08-06 08:08:24.495628+00	56	<User:  lofa>		6	56	1
187	2024-08-06 08:08:24.513317+00	63	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	56	1
188	2024-08-06 08:08:24.528655+00	65	None with None		10	56	1
189	2024-08-06 08:08:32.604132+00	56	<User:  lofa>		6	56	1
190	2024-08-06 08:16:51.074712+00	57	<User:  edde>		6	57	1
191	2024-08-06 08:16:51.092617+00	64	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	57	1
192	2024-08-06 08:16:51.108226+00	66	None with None		10	57	1
193	2024-08-06 08:16:53.019601+00	57	<User:  edde>		6	57	1
194	2024-08-06 12:16:49.572211+00	58	<User:  asgrr>		6	58	1
195	2024-08-06 12:16:49.588063+00	65	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	58	1
196	2024-08-06 12:16:49.601821+00	67	None with None		10	58	1
197	2024-08-06 12:16:53.95191+00	58	<User:  asgrr>		6	58	1
198	2024-08-06 12:20:30.35797+00	59	<User:  lotfi>		6	59	1
199	2024-08-06 12:20:30.374997+00	66	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	59	1
200	2024-08-06 12:20:30.388705+00	68	None with None		10	59	1
201	2024-08-06 12:22:15.230852+00	60	<User:  lotfi>		6	60	1
202	2024-08-06 12:22:15.242857+00	67	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	60	1
203	2024-08-06 12:22:15.254849+00	69	None with None		10	60	1
204	2024-08-06 12:22:15.348464+00	60	<User:  lotfi>		6	60	1
205	2024-08-09 00:21:55.207219+00	61	<User:  hasta56>		6	61	1
206	2024-08-09 00:21:55.221028+00	68	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	61	1
207	2024-08-09 00:21:55.232619+00	70	None with None		10	61	1
208	2024-08-09 00:21:55.343607+00	61	<User:  hasta56>		6	61	1
210	2024-08-09 03:46:09.170557+00	69	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	62	1
211	2024-08-09 03:46:09.183565+00	71	None with None		10	62	1
212	2024-08-09 03:46:09.306938+00	62	<User:  qacenugo>		6	62	1
213	2024-08-09 04:19:14.122173+00	63	<User:  tugijup>		6	63	1
214	2024-08-09 04:19:14.137967+00	70	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	63	1
215	2024-08-09 04:19:14.148966+00	72	None with None		10	63	1
216	2024-08-09 04:19:14.26502+00	63	<User:  tugijup>		6	63	1
217	2024-08-09 04:21:03.598078+00	64	<User:  qomediqi>		6	64	1
218	2024-08-09 04:21:03.611233+00	71	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	64	1
219	2024-08-09 04:21:03.62562+00	73	None with None		10	64	1
220	2024-08-09 04:21:05.463583+00	64	<User:  qomediqi>		6	64	1
221	2024-08-09 04:35:27.290247+00	65	<User:  fivigeha>		6	65	1
222	2024-08-09 04:35:27.304988+00	72	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	65	1
223	2024-08-09 04:35:27.317992+00	74	None with None		10	65	1
224	2024-08-09 04:35:28.270059+00	65	<User:  fivigeha>		6	65	1
225	2024-08-09 06:21:49.445647+00	66	<User:  jagal67445>		6	66	1
226	2024-08-09 06:21:49.457462+00	73	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	66	1
227	2024-08-09 06:21:49.468934+00	75	None with None		10	66	1
228	2024-08-09 06:21:50.595064+00	66	<User:  jagal67445>		6	66	1
229	2024-08-09 07:09:48.259991+00	67	<User:  maltefagna>		6	67	1
230	2024-08-09 07:09:48.277931+00	74	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	67	1
231	2024-08-09 07:09:48.295894+00	76	None with None		10	67	1
232	2024-08-09 07:09:49.700856+00	67	<User:  maltefagna>		6	67	1
233	2024-08-19 14:40:52.709593+00	68	<User:  wgsdg>		6	68	1
234	2024-08-19 14:40:52.744203+00	75	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	68	1
235	2024-08-19 14:40:52.756376+00	77	None with None		10	68	1
236	2024-08-19 14:40:54.799224+00	68	<User:  wgsdg>		6	68	1
237	2024-08-19 15:34:49.572685+00	69	<User:  sdfesf>		6	69	1
238	2024-08-19 15:34:49.589172+00	76	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	69	1
239	2024-08-19 15:34:49.60137+00	78	None with None		10	69	1
240	2024-08-19 15:34:51.047819+00	69	<User:  sdfesf>		6	69	1
241	2024-08-21 10:14:36.864459+00	45	 LOTFIcdc		6	1	3
242	2024-08-21 10:14:36.898378+00	44	 alaa		6	1	3
243	2024-08-21 10:14:36.913287+00	43	 LOTFI		6	1	3
244	2024-08-21 10:14:36.927257+00	42	 test2		6	1	3
245	2024-08-21 10:14:36.932298+00	41	 test1		6	1	3
246	2024-08-21 10:20:47.762023+00	1	beyondboard-me.azurewebsites.net	[{"changed": {"fields": ["Domain name", "Display name"]}}]	30	1	2
247	2024-08-22 03:45:49.966628+00	70	<User:  Aasc>		6	70	1
248	2024-08-22 03:45:49.994059+00	77	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	70	1
249	2024-08-22 03:45:50.007152+00	79	None with None		10	70	1
250	2024-08-22 03:45:52.105157+00	70	<User:  Aasc>		6	70	1
251	2024-08-22 03:52:06.577228+00	71	<User:  lotf>		6	71	1
252	2024-08-22 03:52:06.588564+00	78	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	71	1
253	2024-08-22 03:52:06.602875+00	80	None with None		10	71	1
254	2024-08-22 03:52:08.110815+00	71	<User:  lotf>		6	71	1
255	2024-08-28 20:27:36.968705+00	7	 hasta3	[{"changed": {"fields": ["Groups", "Emergency contact"]}}]	6	1	2
256	2024-08-28 20:32:44.968665+00	9	<MessageGroup: MessageGroup object (9)>		13	8	1
257	2024-08-28 20:50:48.601154+00	73	<User:  LOTFIde>		6	73	1
258	2024-08-28 20:50:48.609882+00	82	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	73	1
259	2024-08-28 20:50:48.625495+00	84	None with None		10	73	1
260	2024-08-28 21:00:04.897374+00	74	<User:  aasc>		6	74	1
261	2024-08-28 21:00:04.913753+00	83	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	74	1
262	2024-08-28 21:00:04.930146+00	85	None with None		10	74	1
263	2024-08-28 21:00:09.706634+00	74	<User:  aasc>		6	74	1
264	2024-08-28 21:04:13.36259+00	75	<User:  ergreferfer>		6	75	1
265	2024-08-28 21:04:13.370672+00	84	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	75	1
266	2024-08-28 21:04:13.387193+00	86	None with None		10	75	1
267	2024-08-28 21:04:15.35122+00	75	<User:  ergreferfer>		6	75	1
268	2024-08-28 21:16:37.330002+00	76	<User:  docdoc>		6	76	1
269	2024-08-28 21:16:37.343028+00	85	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	76	1
270	2024-08-28 21:16:37.353801+00	87	None with None		10	76	1
271	2024-08-28 21:16:40.894015+00	76	<User:  docdoc>		6	76	1
272	2024-08-28 21:25:39.822005+00	76	 docdoc	[{"changed": {"fields": ["Groups", "Emergency contact"]}}]	6	1	2
273	2024-08-28 21:26:20.676064+00	2	Doctor	[]	3	1	2
274	2024-08-29 01:02:58.86812+00	1	BEGO Semados  RSX Pro	[{"added": {}}]	79	1	1
275	2024-08-29 01:06:56.325026+00	2	IMPLANCE Bone Level	[{"added": {}}]	79	1	1
276	2024-08-29 01:11:12.477388+00	3	IVOCLAR IPS e.max	[{"added": {}}]	79	1	1
277	2024-08-29 01:14:52.053272+00	4	Philips Zoom! WhiteSpeed	[{"added": {}}]	79	1	1
278	2024-08-29 01:16:24.56149+00	5	Root Canal & Endodontics	[{"added": {}}]	79	1	1
279	2024-08-29 01:17:09.449556+00	1	Treatment Plan for patient1 test by Dr. doc3 test	[{"added": {}}, {"added": {"name": "treatment plan item", "object": "5 x BEGO Semados  RSX Pro for Treatment Plan for patient1 test by Dr. doc3 test"}}, {"added": {"name": "treatment plan item", "object": "4 x IVOCLAR IPS e.max for Treatment Plan for patient1 test by Dr. doc3 test"}}]	78	1	1
280	2024-08-29 01:47:58.847003+00	1	Treatment Plan for patient1 test by Dr. doc3 test	[{"added": {"name": "treatment plan item", "object": "1 x Philips Zoom! WhiteSpeed for Treatment Plan for patient1 test by Dr. doc3 test"}}]	78	1	2
281	2024-08-29 01:48:14.179839+00	1	Treatment Plan for patient1 test by Dr. doc3 test	[{"changed": {"fields": ["Discount percentage"]}}]	78	1	2
282	2024-08-29 08:16:41.391825+00	74	 aasc	[{"changed": {"fields": ["Groups", "Emergency contact"]}}]	6	1	2
283	2024-08-29 08:21:00.679756+00	74	 aasc	[{"changed": {"fields": ["Last login", "Last login time"]}}]	6	1	2
284	2024-08-29 08:25:00.677199+00	74	 aasc	[{"changed": {"fields": ["Staff status"]}}]	6	1	2
285	2024-08-29 10:06:41.955786+00	76	 docdoc	[{"changed": {"fields": ["Staff status"]}}]	6	1	2
286	2024-08-29 11:21:45.177345+00	76	 John	update through import_export	6	1	2
287	2024-08-29 11:21:45.208246+00	75	 Ali	update through import_export	6	1	2
288	2024-08-29 11:21:45.220845+00	74	 Emma	update through import_export	6	1	2
289	2024-08-29 11:21:45.231815+00	73	 Lotfi	update through import_export	6	1	2
290	2024-08-29 11:21:45.24304+00	72	 Fatma	update through import_export	6	1	2
291	2024-08-29 11:21:45.254879+00	71	 Elif	update through import_export	6	1	2
292	2024-08-29 11:21:45.266326+00	70	 Amina	update through import_export	6	1	2
293	2024-08-29 11:21:45.278+00	69	 Sophie	update through import_export	6	1	2
294	2024-08-29 11:21:45.286133+00	68	 Carlos	update through import_export	6	1	2
295	2024-08-29 11:21:45.300023+00	67	 Mustafa	update through import_export	6	1	2
296	2024-08-29 11:21:45.310934+00	66	 Maria	update through import_export	6	1	2
297	2024-08-29 11:21:45.322696+00	65	 Farah	update through import_export	6	1	2
298	2024-08-29 11:21:45.334599+00	64	 Nina	update through import_export	6	1	2
299	2024-08-29 11:21:45.346604+00	63	 Kenan	update through import_export	6	1	2
300	2024-08-29 11:21:45.359355+00	62	 Huseyin	update through import_export	6	1	2
301	2024-08-29 11:21:45.375349+00	61	 Michael	update through import_export	6	1	2
302	2024-08-29 11:21:45.387974+00	60	 Emily	update through import_export	6	1	2
303	2024-08-29 11:21:45.399662+00	59	 Hannah	update through import_export	6	1	2
304	2024-08-29 11:21:45.410508+00	58	 Ahmed	update through import_export	6	1	2
305	2024-08-29 11:21:45.421076+00	57	 Merve	update through import_export	6	1	2
306	2024-08-29 11:21:45.432872+00	56	 Lara	update through import_export	6	1	2
307	2024-08-29 11:21:45.444437+00	55	 David	update through import_export	6	1	2
308	2024-08-29 11:21:45.457327+00	54	 Yasmin	update through import_export	6	1	2
309	2024-08-29 11:21:45.469024+00	53	 Lucas	update through import_export	6	1	2
310	2024-08-29 11:21:45.481644+00	52	 Leila	update through import_export	6	1	2
311	2024-08-29 11:21:45.49403+00	51	 Isabella	update through import_export	6	1	2
312	2024-08-29 11:21:45.509336+00	50	 Alex	update through import_export	6	1	2
313	2024-08-29 11:21:45.52002+00	49	 Deniz	update through import_export	6	1	2
314	2024-08-29 11:21:45.534049+00	48	 Cem	update through import_export	6	1	2
315	2024-08-29 11:21:45.543248+00	47	 Jack	update through import_export	6	1	2
316	2024-08-29 11:21:45.561474+00	46	 Sarah	update through import_export	6	1	2
317	2024-08-29 11:21:45.575959+00	40	 Murat	update through import_export	6	1	2
318	2024-08-29 11:21:45.58884+00	39	 Ayla	update through import_export	6	1	2
319	2024-08-29 11:21:45.601724+00	38	 Zeynep	update through import_export	6	1	2
320	2024-08-29 11:21:45.614911+00	37	 Mehmet	update through import_export	6	1	2
321	2024-08-29 11:21:45.627582+00	36	 Fatih	update through import_export	6	1	2
322	2024-08-29 11:21:45.639003+00	35	 Sami	update through import_export	6	1	2
323	2024-08-29 11:21:45.651517+00	34	 Eren	update through import_export	6	1	2
324	2024-08-29 11:21:45.66378+00	33	 Burak	update through import_export	6	1	2
325	2024-08-29 11:21:45.676881+00	32	 Anna	update through import_export	6	1	2
326	2024-08-29 11:21:45.689377+00	31	 Julia	update through import_export	6	1	2
327	2024-08-29 11:21:45.700518+00	30	 Timur	update through import_export	6	1	2
328	2024-08-29 11:21:45.71144+00	29	 Zahra	update through import_export	6	1	2
329	2024-08-29 11:21:45.725247+00	28	 Orhan	update through import_export	6	1	2
330	2024-08-29 11:21:45.736969+00	27	 Lukas	update through import_export	6	1	2
331	2024-08-29 11:21:45.751726+00	26	 Arda	update through import_export	6	1	2
332	2024-08-29 11:21:45.767629+00	25	 Sibel	update through import_export	6	1	2
333	2024-08-29 11:21:45.779978+00	24	 Melike	update through import_export	6	1	2
334	2024-08-29 11:21:45.79362+00	23	 Volkan	update through import_export	6	1	2
335	2024-08-29 11:21:45.806049+00	22	 Serkan	update through import_export	6	1	2
336	2024-08-29 11:21:45.818045+00	21	 Hülya	update through import_export	6	1	2
337	2024-08-29 11:21:45.831777+00	20	 Murat	update through import_export	6	1	2
338	2024-08-29 11:21:45.84547+00	19	 Kerem	update through import_export	6	1	2
339	2024-08-29 11:21:45.858897+00	18	 Ahmet	update through import_export	6	1	2
340	2024-08-29 11:21:45.870949+00	17	 Rania	update through import_export	6	1	2
341	2024-08-29 11:21:45.884835+00	16	 Catherine	update through import_export	6	1	2
342	2024-08-29 11:21:45.89783+00	15	 Aylin	update through import_export	6	1	2
343	2024-08-29 11:21:45.912428+00	14	 Efe	update through import_export	6	1	2
344	2024-08-29 11:21:45.925706+00	13	 Zara	update through import_export	6	1	2
345	2024-08-29 11:21:45.938088+00	12	 Matthew	update through import_export	6	1	2
346	2024-08-29 11:21:45.951624+00	11	 William	update through import_export	6	1	2
347	2024-08-29 11:21:45.962898+00	10	 Victoria	update through import_export	6	1	2
348	2024-08-29 11:21:45.976659+00	9	 Sarah	update through import_export	6	1	2
349	2024-08-29 11:21:45.99113+00	8	 Ayla	update through import_export	6	1	2
350	2024-08-29 11:21:46.005143+00	7	 Can	update through import_export	6	1	2
351	2024-08-29 11:21:46.016587+00	6	 Selin	update through import_export	6	1	2
352	2024-08-29 11:21:46.028484+00	5	 doc3	update through import_export	6	1	2
353	2024-08-29 11:21:46.04308+00	4	 Doctor2	update through import_export	6	1	2
354	2024-08-29 11:21:46.054801+00	3	 patient2	update through import_export	6	1	2
355	2024-08-29 11:21:46.067935+00	2	 patient1	update through import_export	6	1	2
356	2024-08-29 11:21:46.080626+00	1	 lotfi	update through import_export	6	1	2
357	2024-08-29 11:35:53.29996+00	76	 John	update through import_export	6	1	2
358	2024-08-29 11:35:53.313757+00	75	 Ali	update through import_export	6	1	2
359	2024-08-29 11:35:53.324504+00	74	 Emma	update through import_export	6	1	2
360	2024-08-29 11:35:53.33713+00	73	 Lotfi	update through import_export	6	1	2
361	2024-08-29 11:35:53.347816+00	72	 Fatma	update through import_export	6	1	2
362	2024-08-29 11:35:53.358455+00	71	 Elif	update through import_export	6	1	2
363	2024-08-29 11:35:53.369586+00	70	 Amina	update through import_export	6	1	2
364	2024-08-29 11:35:53.379959+00	69	 Sophie	update through import_export	6	1	2
365	2024-08-29 11:35:53.391126+00	68	 Carlos	update through import_export	6	1	2
366	2024-08-29 11:35:53.403744+00	67	 Mustafa	update through import_export	6	1	2
367	2024-08-29 11:35:53.413945+00	66	 Maria	update through import_export	6	1	2
368	2024-08-29 11:35:53.426348+00	65	 Farah	update through import_export	6	1	2
369	2024-08-29 11:35:53.437122+00	64	 Nina	update through import_export	6	1	2
370	2024-08-29 11:35:53.448571+00	63	 Kenan	update through import_export	6	1	2
371	2024-08-29 11:35:53.457516+00	62	 Huseyin	update through import_export	6	1	2
372	2024-08-29 11:35:53.469629+00	61	 Michael	update through import_export	6	1	2
373	2024-08-29 11:35:53.486449+00	60	 Emily	update through import_export	6	1	2
374	2024-08-29 11:35:53.498627+00	59	 Hannah	update through import_export	6	1	2
375	2024-08-29 11:35:53.509952+00	58	 Ahmed	update through import_export	6	1	2
376	2024-08-29 11:35:53.520819+00	57	 Merve	update through import_export	6	1	2
377	2024-08-29 11:35:53.532881+00	56	 Lara	update through import_export	6	1	2
378	2024-08-29 11:35:53.545547+00	55	 David	update through import_export	6	1	2
379	2024-08-29 11:35:53.557655+00	54	 Yasmin	update through import_export	6	1	2
380	2024-08-29 11:35:53.569994+00	53	 Lucas	update through import_export	6	1	2
381	2024-08-29 11:35:53.581208+00	52	 Leila	update through import_export	6	1	2
382	2024-08-29 11:35:53.592845+00	51	 Isabella	update through import_export	6	1	2
383	2024-08-29 11:35:53.604944+00	50	 Alex	update through import_export	6	1	2
384	2024-08-29 11:35:53.61954+00	49	 Deniz	update through import_export	6	1	2
385	2024-08-29 11:35:53.630808+00	48	 Cem	update through import_export	6	1	2
386	2024-08-29 11:35:53.643336+00	47	 Jack	update through import_export	6	1	2
387	2024-08-29 11:35:53.655912+00	46	 Sarah	update through import_export	6	1	2
388	2024-08-29 11:35:53.669568+00	40	 Murat	update through import_export	6	1	2
389	2024-08-29 11:35:53.683735+00	39	 Ayla	update through import_export	6	1	2
390	2024-08-29 11:35:53.697552+00	38	 Zeynep	update through import_export	6	1	2
391	2024-08-29 11:35:53.710222+00	37	 Mehmet	update through import_export	6	1	2
392	2024-08-29 11:35:53.724048+00	36	 Fatih	update through import_export	6	1	2
393	2024-08-29 11:35:53.738477+00	35	 Sami	update through import_export	6	1	2
394	2024-08-29 11:35:53.751934+00	34	 Eren	update through import_export	6	1	2
395	2024-08-29 11:35:53.7679+00	33	 Burak	update through import_export	6	1	2
396	2024-08-29 11:35:53.782429+00	32	 Anna	update through import_export	6	1	2
397	2024-08-29 11:35:53.794656+00	31	 Julia	update through import_export	6	1	2
398	2024-08-29 11:35:53.806575+00	30	 Timur	update through import_export	6	1	2
399	2024-08-29 11:35:53.820999+00	29	 Zahra	update through import_export	6	1	2
400	2024-08-29 11:35:53.834234+00	28	 Orhan	update through import_export	6	1	2
401	2024-08-29 11:35:53.846778+00	27	 Lukas	update through import_export	6	1	2
402	2024-08-29 11:35:53.858472+00	26	 Arda	update through import_export	6	1	2
403	2024-08-29 11:35:53.872629+00	25	 Sibel	update through import_export	6	1	2
404	2024-08-29 11:35:53.886271+00	24	 Melike	update through import_export	6	1	2
405	2024-08-29 11:35:53.899406+00	23	 Volkan	update through import_export	6	1	2
406	2024-08-29 11:35:53.912938+00	22	 Serkan	update through import_export	6	1	2
407	2024-08-29 11:35:53.926738+00	21	 Hülya	update through import_export	6	1	2
408	2024-08-29 11:35:53.940933+00	20	 Murat	update through import_export	6	1	2
409	2024-08-29 11:35:53.968812+00	19	 Kerem	update through import_export	6	1	2
410	2024-08-29 11:35:53.985377+00	18	 Ahmet	update through import_export	6	1	2
411	2024-08-29 11:35:54.002895+00	17	 Rania	update through import_export	6	1	2
412	2024-08-29 11:35:54.020751+00	16	 Catherine	update through import_export	6	1	2
413	2024-08-29 11:35:54.038295+00	15	 Aylin	update through import_export	6	1	2
414	2024-08-29 11:35:54.055292+00	14	 Efe	update through import_export	6	1	2
415	2024-08-29 11:35:54.072744+00	13	 Zara	update through import_export	6	1	2
416	2024-08-29 11:35:54.088576+00	12	 Matthew	update through import_export	6	1	2
417	2024-08-29 11:35:54.105437+00	11	 William	update through import_export	6	1	2
418	2024-08-29 11:35:54.1206+00	10	 Victoria	update through import_export	6	1	2
419	2024-08-29 11:35:54.138063+00	9	 Sarah	update through import_export	6	1	2
420	2024-08-29 11:35:54.155344+00	8	 Ayla	update through import_export	6	1	2
421	2024-08-29 11:35:54.1712+00	7	 Can	update through import_export	6	1	2
422	2024-08-29 11:35:54.189022+00	6	 Selin	update through import_export	6	1	2
423	2024-08-29 11:35:54.205089+00	5	 Ayşe	update through import_export	6	1	2
424	2024-08-29 11:35:54.225451+00	4	 Dr.Mehmet	update through import_export	6	1	2
425	2024-08-29 11:35:54.241433+00	3	 Hakan	update through import_export	6	1	2
426	2024-08-29 11:35:54.258519+00	2	 Zeynep	update through import_export	6	1	2
427	2024-08-29 11:35:54.272543+00	1	 lotfi	update through import_export	6	1	2
428	2024-08-29 12:32:48.502777+00	2	Treatment Plan for Zeynep Kaya by Dr. Can Gürsoy	[{"added": {}}, {"added": {"name": "treatment plan item", "object": "5 x BEGO Semados  RSX Pro for Treatment Plan for Zeynep Kaya by Dr. Can G\\u00fcrsoy"}}, {"added": {"name": "treatment plan item", "object": "23 x Philips Zoom! WhiteSpeed for Treatment Plan for Zeynep Kaya by Dr. Can G\\u00fcrsoy"}}]	78	1	1
429	2024-08-29 12:35:04.190385+00	3	Treatment Plan for Zara Ahmed by Dr. Ahmet Duman	[{"added": {}}, {"added": {"name": "treatment plan item", "object": "2 x IMPLANCE Bone Level for Treatment Plan for Zara Ahmed by Dr. Ahmet Duman"}}, {"added": {"name": "treatment plan item", "object": "10 x Root Canal & Endodontics for Treatment Plan for Zara Ahmed by Dr. Ahmet Duman"}}]	78	1	1
430	2024-08-29 12:36:33.907558+00	3	Treatment Plan for Zara Ahmed by Dr. Ahmet Duman	[{"changed": {"fields": ["Discount percentage"]}}]	78	1	2
431	2024-08-29 14:30:04.615775+00	17	Treatment Plan for Zeynep Kaya by Dr. Ayla Tekin	[{"added": {}}, {"added": {"name": "treatment plan item", "object": "10 x Root Canal & Endodontics for Treatment Plan for Zeynep Kaya by Dr. Ayla Tekin"}}, {"added": {"name": "treatment plan item", "object": "2 x BEGO Semados  RSX Pro for Treatment Plan for Zeynep Kaya by Dr. Ayla Tekin"}}]	78	1	1
432	2024-08-29 19:20:18.319286+00	10	<MessageGroup: MessageGroup object (10)>		13	76	1
433	2024-08-29 20:54:47.222223+00	30	Treatment Plan for Can Gürsoy by Dr. lotfi kanouni		78	1	3
434	2024-08-29 21:14:22.819718+00	33	Treatment Plan for Selin Koç by Dr. Sarah Evans	[{"added": {}}, {"added": {"name": "treatment plan item", "object": "4 x BEGO Semados  RSX Pro for Treatment Plan for Selin Ko\\u00e7 by Dr. Sarah Evans"}}, {"added": {"name": "treatment plan item", "object": "3 x Philips Zoom! WhiteSpeed for Treatment Plan for Selin Ko\\u00e7 by Dr. Sarah Evans"}}]	78	1	1
435	2024-09-01 14:50:32.914112+00	1	Sex: , Insurance:  with , Medications: , Allergies: amoxivilin, Medical Conditions: , Family History: , Additional Info: 	Changed fields.	15	2	2
436	2024-09-01 14:50:33.090693+00	2	<User:  Zeynep>	Changed fields.	6	2	2
437	2024-09-01 18:13:26.171351+00	1	Sex: Female, Insurance:  with , Medications: , Allergies: amoxivilin, Medical Conditions: , Family History: , Additional Info: 	Changed fields.	15	2	2
438	2024-09-01 18:13:26.207279+00	2	<User:  Zeynep>	Changed fields.	6	2	2
439	2024-09-01 18:20:44.576058+00	1	Sex: Female, Insurance:  with , Medications: , Allergies: amoxivilin, Medical Conditions: , Family History: , Additional Info: 	Changed fields.	15	2	2
440	2024-09-01 18:20:44.607325+00	2	<User:  Zeynep>	Changed fields.	6	2	2
441	2024-09-01 18:20:45.106131+00	1	Sex: , Insurance:  with , Medications: , Allergies: amoxivilin, Medical Conditions: , Family History: , Additional Info: 	Changed fields.	15	2	2
442	2024-09-01 18:20:45.134769+00	2	<User:  Zeynep>	Changed fields.	6	2	2
443	2024-09-01 18:21:45.39782+00	1	Sex: Female, Insurance:  with , Medications: , Allergies: amoxivilin, Medical Conditions: , Family History: , Additional Info: 	Changed fields.	15	2	2
444	2024-09-01 18:21:45.429043+00	2	<User:  Zeynep>	Changed fields.	6	2	2
445	2024-09-01 18:23:16.490233+00	1	Sex: Female, Insurance:  with , Medications: , Allergies: amoxivilin, Medical Conditions: , Family History: , Additional Info: 	Changed fields.	15	2	2
446	2024-09-01 18:23:16.526087+00	2	<User:  Zeynep>	Changed fields.	6	2	2
447	2024-09-01 18:25:51.877416+00	1	Sex: Female, Insurance:  with , Medications: , Allergies: amoxivilin, Medical Conditions: , Family History: , Additional Info: 	Changed fields.	15	2	2
448	2024-09-01 18:25:51.908382+00	2	<User:  Zeynep>	Changed fields.	6	2	2
449	2024-09-01 18:28:38.889326+00	1	Sex: Female, Insurance:  with , Medications: , Allergies: amoxivilin, Medical Conditions: , Family History: , Additional Info: 	Changed fields.	15	2	2
450	2024-09-01 18:28:38.91783+00	2	<User:  Zeynep>	Changed fields.	6	2	2
451	2024-09-01 18:28:38.984712+00	1	Sex: , Insurance:  with , Medications: , Allergies: amoxivilin, Medical Conditions: , Family History: , Additional Info: 	Changed fields.	15	2	2
452	2024-09-01 18:28:39.019839+00	2	<User:  Zeynep>	Changed fields.	6	2	2
453	2024-09-01 18:28:43.752463+00	1	Sex: Female, Insurance:  with , Medications: , Allergies: amoxivilin, Medical Conditions: , Family History: , Additional Info: 	Changed fields.	15	2	2
454	2024-09-01 18:28:43.785592+00	2	<User:  Zeynep>	Changed fields.	6	2	2
455	2024-09-01 18:31:33.368458+00	1	Sex: Female, Insurance:  with , Medications: , Allergies: amoxivilin, Medical Conditions: , Family History: , Additional Info: 	Changed fields.	15	2	2
456	2024-09-01 18:31:33.39861+00	2	<User:  Zeynep>	Changed fields.	6	2	2
457	2024-09-01 18:31:39.692246+00	1	Sex: Female, Insurance:  with , Medications: , Allergies: amoxivilin, Medical Conditions: , Family History: , Additional Info: 	Changed fields.	15	2	2
458	2024-09-01 18:31:39.724236+00	2	<User:  Zeynep>	Changed fields.	6	2	2
459	2024-09-01 18:36:19.634864+00	1	Sex: , Insurance:  with , Medications: , Allergies: amoxivilin, Medical Conditions: , Family History: , Additional Info: 	Changed fields.	15	2	2
460	2024-09-01 18:36:19.679274+00	2	<User:  Zeynep>	Changed fields.	6	2	2
461	2024-09-01 18:36:19.743207+00	1	Sex: Female, Insurance:  with , Medications: , Allergies: amoxivilin, Medical Conditions: , Family History: , Additional Info: 	Changed fields.	15	2	2
462	2024-09-01 18:36:19.80314+00	2	<User:  Zeynep>	Changed fields.	6	2	2
463	2024-09-01 18:36:56.199247+00	1	Sex: , Insurance:  with , Medications: , Allergies: amoxivilin, Medical Conditions: , Family History: , Additional Info: 	Changed fields.	15	2	2
464	2024-09-01 18:36:56.248446+00	2	<User:  Zeynep>	Changed fields.	6	2	2
465	2024-09-01 18:36:56.432298+00	1	Sex: Female, Insurance:  with , Medications: , Allergies: amoxivilin, Medical Conditions: , Family History: , Additional Info: 	Changed fields.	15	2	2
466	2024-09-01 18:36:56.507695+00	2	<User:  Zeynep>	Changed fields.	6	2	2
467	2024-09-01 18:36:58.107577+00	1	Sex: Female, Insurance:  with , Medications: , Allergies: amoxivilin, Medical Conditions: , Family History: , Additional Info: 	Changed fields.	15	2	2
468	2024-09-01 18:36:58.158718+00	2	<User:  Zeynep>	Changed fields.	6	2	2
469	2024-09-01 19:06:51.851108+00	1	Sex: Female, Insurance:  with , Medications: , Allergies: amoxivilin, Medical Conditions: , Family History: , Additional Info: 	Changed fields.	15	2	2
470	2024-09-01 19:06:51.923265+00	2	<User:  Zeynep>	Changed fields.	6	2	2
471	2024-09-01 19:07:53.499092+00	1	Sex: Female, Insurance:  with , Medications: , Allergies: amoxivilin, Medical Conditions: , Family History: , Additional Info: 	Changed fields.	15	2	2
472	2024-09-01 19:07:53.559863+00	2	<User:  Zeynep>	Changed fields.	6	2	2
473	2024-09-01 19:23:44.027555+00	1	Sex: Female, Insurance:  with , Medications: , Allergies: amoxivilin, Medical Conditions: , Family History: , Additional Info: 	Changed fields.	15	2	2
474	2024-09-01 19:23:44.058828+00	2	<User:  Zeynep>	Changed fields.	6	2	2
475	2024-09-01 19:25:58.968407+00	1	Sex: Female, Insurance:  with , Medications: , Allergies: amoxivilin, Medical Conditions: , Family History: , Additional Info: 	Changed fields.	15	2	2
476	2024-09-01 19:25:59.019042+00	2	<User:  Zeynep>	Changed fields.	6	2	2
477	2024-09-01 19:26:07.762596+00	1	Sex: Female, Insurance:  with , Medications: , Allergies: amoxivilin, Medical Conditions: , Family History: , Additional Info: 	Changed fields.	15	2	2
478	2024-09-01 19:26:07.794261+00	2	<User:  Zeynep>	Changed fields.	6	2	2
479	2024-09-01 19:26:10.914181+00	1	Sex: Female, Insurance:  with , Medications: , Allergies: amoxivilin, Medical Conditions: , Family History: , Additional Info: 	Changed fields.	15	2	2
480	2024-09-01 19:26:10.940067+00	2	<User:  Zeynep>	Changed fields.	6	2	2
481	2024-09-03 16:57:24.993881+00	34	Sex: , Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None	Changed fields.	15	27	2
482	2024-09-03 16:57:25.038589+00	27	<User:  Lukas>	Changed fields.	6	27	2
483	2024-09-03 17:19:25.211751+00	55	Sex: Male, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None	Changed fields.	15	48	2
484	2024-09-03 17:19:25.24654+00	48	<User:  Cem>	Changed fields.	6	48	2
485	2024-09-03 17:53:23.526167+00	59	Treatment Plan for Cem Yıldırım by Dr. Ayla Aydın		78	1	3
486	2024-09-03 17:53:59.274859+00	58	Treatment Plan for Cem Yıldırım by Dr. Ayla Aydın	[{"changed": {"name": "treatment plan item", "object": "8 x Root Canal & Endodontics for Treatment Plan for Cem Y\\u0131ld\\u0131r\\u0131m by Dr. Ayla Ayd\\u0131n", "fields": ["Quantity"]}}]	78	1	2
487	2024-09-03 19:31:08.960788+00	36	Sex: Female, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None	Changed fields.	15	29	2
488	2024-09-03 19:31:09.015139+00	29	<User:  Zahra>	Changed fields.	6	29	2
489	2024-09-03 19:32:29.545096+00	36	Sex: Female, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None	Changed fields.	15	29	2
490	2024-09-03 19:32:29.584848+00	29	<User:  Zahra>	Changed fields.	6	29	2
491	2024-09-03 23:16:53.163412+00	77	<User:  Nada>		6	77	1
492	2024-09-03 23:16:53.215836+00	86	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	77	1
493	2024-09-03 23:16:53.226891+00	88	None with None		10	77	1
494	2024-09-03 23:19:03.735959+00	78	<User:  Melek >		6	78	1
495	2024-09-03 23:19:03.748223+00	87	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	78	1
496	2024-09-03 23:19:03.758844+00	89	None with None		10	78	1
497	2024-09-03 23:26:33.658963+00	78	 Melek	[{"changed": {"fields": ["Groups", "First name", "Last name", "Staff status", "Nationality", "Emergency contact"]}}]	6	1	2
498	2024-09-03 23:34:29.658503+00	79	<User:  reference tesrt>		6	79	1
499	2024-09-03 23:34:29.674405+00	88	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	79	1
500	2024-09-03 23:34:29.708282+00	90	None with None		10	79	1
501	2024-09-03 23:34:31.294551+00	79	<User:  reference tesrt>		6	79	1
502	2024-09-03 23:39:48.475846+00	77	 Nada	[{"changed": {"fields": ["Emergency contact"]}}]	6	1	2
503	2024-09-04 01:07:29.419089+00	82	<User:  LOTFI>		6	82	1
504	2024-09-04 01:07:29.436234+00	91	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	82	1
505	2024-09-04 01:07:29.448809+00	93	None with None		10	82	1
506	2024-09-04 01:07:33.320094+00	82	<User:  LOTFI>		6	82	1
507	2024-09-04 01:11:17.323234+00	91	Sex: Male, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None	Changed fields.	15	82	2
508	2024-09-04 01:11:17.35583+00	82	<User:  LOTFI>	Changed fields.	6	82	2
509	2024-09-04 01:11:37.900849+00	91	Sex: Male, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None	Changed fields.	15	82	2
510	2024-09-04 01:11:37.933949+00	82	<User:  LOTFI>	Changed fields.	6	82	2
511	2024-09-04 13:06:23.619539+00	82	 LOTFI	update through import_export	6	1	2
512	2024-09-04 13:06:23.65111+00	81	 john	update through import_export	6	1	2
513	2024-09-04 13:06:23.664766+00	80	 john	update through import_export	6	1	2
514	2024-09-04 13:06:23.677379+00	79	 reference tesrt	update through import_export	6	1	2
515	2024-09-04 13:06:23.689799+00	78	 Melek	update through import_export	6	1	2
516	2024-09-04 13:06:23.701386+00	77	 Nada	update through import_export	6	1	2
517	2024-09-04 13:06:23.714646+00	76	 John	update through import_export	6	1	2
518	2024-09-04 13:06:23.725917+00	75	 Ali	update through import_export	6	1	2
519	2024-09-04 13:06:23.738774+00	74	 Emma	update through import_export	6	1	2
631	2024-09-15 06:53:39.36511+00	83	 nafrthy		6	1	3
520	2024-09-04 13:06:23.75222+00	73	 Lotfi	update through import_export	6	1	2
521	2024-09-04 13:06:23.767324+00	72	 Fatma	update through import_export	6	1	2
522	2024-09-04 13:06:23.785464+00	71	 Elif	update through import_export	6	1	2
523	2024-09-04 13:06:23.798501+00	70	 Amina	update through import_export	6	1	2
524	2024-09-04 13:06:23.811005+00	69	 Sophie	update through import_export	6	1	2
525	2024-09-04 13:06:23.823669+00	68	 Carlos	update through import_export	6	1	2
526	2024-09-04 13:06:23.835813+00	67	 Mustafa	update through import_export	6	1	2
527	2024-09-04 13:06:23.851064+00	66	 Maria	update through import_export	6	1	2
528	2024-09-04 13:06:23.863554+00	65	 Farah	update through import_export	6	1	2
529	2024-09-04 13:06:23.876608+00	64	 Nina	update through import_export	6	1	2
530	2024-09-04 13:06:23.8883+00	63	 Kenan	update through import_export	6	1	2
531	2024-09-04 13:06:23.901175+00	62	 Huseyin	update through import_export	6	1	2
532	2024-09-04 13:06:23.915321+00	61	 Michael	update through import_export	6	1	2
533	2024-09-04 13:06:23.927045+00	60	 Emily	update through import_export	6	1	2
534	2024-09-04 13:06:23.943556+00	59	 Hannah	update through import_export	6	1	2
535	2024-09-04 13:06:23.956292+00	58	 Ahmed	update through import_export	6	1	2
536	2024-09-04 13:06:23.967472+00	57	 Merve	update through import_export	6	1	2
537	2024-09-04 13:06:23.973557+00	56	 Lara	update through import_export	6	1	2
538	2024-09-04 13:06:23.994427+00	55	 David	update through import_export	6	1	2
539	2024-09-04 13:06:24.008417+00	54	 Yasmin	update through import_export	6	1	2
540	2024-09-04 13:06:24.021876+00	53	 Lucas	update through import_export	6	1	2
541	2024-09-04 13:06:24.034467+00	52	 Leila	update through import_export	6	1	2
542	2024-09-04 13:06:24.048265+00	51	 Isabella	update through import_export	6	1	2
543	2024-09-04 13:06:24.060407+00	50	 Alex	update through import_export	6	1	2
544	2024-09-04 13:06:24.073412+00	49	 Deniz	update through import_export	6	1	2
545	2024-09-04 13:06:24.085348+00	48	 Cem	update through import_export	6	1	2
546	2024-09-04 13:06:24.097789+00	47	 Jack	update through import_export	6	1	2
547	2024-09-04 13:06:24.108312+00	46	 Sarah	update through import_export	6	1	2
548	2024-09-04 13:06:24.121047+00	40	 Murat	update through import_export	6	1	2
549	2024-09-04 13:06:24.133561+00	39	 Ayla	update through import_export	6	1	2
550	2024-09-04 13:06:24.145841+00	38	 Zeynep	update through import_export	6	1	2
551	2024-09-04 13:06:24.157387+00	37	 Mehmet	update through import_export	6	1	2
552	2024-09-04 13:06:24.170049+00	36	 Fatih	update through import_export	6	1	2
553	2024-09-04 13:06:24.183496+00	35	 Sami	update through import_export	6	1	2
554	2024-09-04 13:06:24.200088+00	34	 Eren	update through import_export	6	1	2
555	2024-09-04 13:06:24.215026+00	33	 Burak	update through import_export	6	1	2
556	2024-09-04 13:06:24.226032+00	32	 Anna	update through import_export	6	1	2
557	2024-09-04 13:06:24.238538+00	31	 Julia	update through import_export	6	1	2
558	2024-09-04 13:06:24.25033+00	30	 Timur	update through import_export	6	1	2
559	2024-09-04 13:06:24.261628+00	29	 Zahra	update through import_export	6	1	2
560	2024-09-04 13:06:24.271863+00	28	 Orhan	update through import_export	6	1	2
561	2024-09-04 13:06:24.283374+00	27	 Lukas	update through import_export	6	1	2
562	2024-09-04 13:06:24.295806+00	26	 Arda	update through import_export	6	1	2
563	2024-09-04 13:06:24.306605+00	25	 Sibel	update through import_export	6	1	2
564	2024-09-04 13:06:24.318123+00	24	 Melike	update through import_export	6	1	2
565	2024-09-04 13:06:24.328329+00	23	 Volkan	update through import_export	6	1	2
566	2024-09-04 13:06:24.341518+00	22	 Serkan	update through import_export	6	1	2
567	2024-09-04 13:06:24.355718+00	21	 Hülya	update through import_export	6	1	2
568	2024-09-04 13:06:24.368736+00	20	 Murat	update through import_export	6	1	2
569	2024-09-04 13:06:24.382028+00	19	 Kerem	update through import_export	6	1	2
570	2024-09-04 13:06:24.394956+00	18	 Ahmet	update through import_export	6	1	2
571	2024-09-04 13:06:24.410165+00	17	 Rania	update through import_export	6	1	2
572	2024-09-04 13:06:24.422356+00	16	 Catherine	update through import_export	6	1	2
573	2024-09-04 13:06:24.435389+00	15	 Aylin	update through import_export	6	1	2
574	2024-09-04 13:06:24.449423+00	14	 Efe	update through import_export	6	1	2
575	2024-09-04 13:06:24.461618+00	13	 Zara	update through import_export	6	1	2
576	2024-09-04 13:06:24.477678+00	12	 Matthew	update through import_export	6	1	2
577	2024-09-04 13:06:24.489183+00	11	 William	update through import_export	6	1	2
578	2024-09-04 13:06:24.501851+00	10	 Victoria	update through import_export	6	1	2
579	2024-09-04 13:06:24.517031+00	9	 Sarah	update through import_export	6	1	2
580	2024-09-04 13:06:24.529282+00	8	 Ayla	update through import_export	6	1	2
581	2024-09-04 13:06:24.540594+00	7	 Can	update through import_export	6	1	2
582	2024-09-04 13:06:24.552441+00	6	 Selin	update through import_export	6	1	2
583	2024-09-04 13:06:24.56373+00	5	 Ayşe	update through import_export	6	1	2
584	2024-09-04 13:06:24.574606+00	4	 Dr.Mehmet	update through import_export	6	1	2
585	2024-09-04 13:06:24.586154+00	3	 Hakan	update through import_export	6	1	2
586	2024-09-04 13:06:24.597438+00	2	 Zeynep	update through import_export	6	1	2
587	2024-09-04 13:06:24.610103+00	1	 lotfi	update through import_export	6	1	2
623	2024-09-15 06:53:39.281221+00	91	 sbg		6	1	3
624	2024-09-15 06:53:39.291977+00	90	 ascas		6	1	3
625	2024-09-15 06:53:39.302763+00	89	 asc		6	1	3
626	2024-09-15 06:53:39.313005+00	88	 evfds		6	1	3
627	2024-09-15 06:53:39.323162+00	87	 sdvr		6	1	3
628	2024-09-15 06:53:39.333408+00	86	 JIM		6	1	3
629	2024-09-15 06:53:39.344657+00	85	 test		6	1	3
630	2024-09-15 06:53:39.354902+00	84	 hasta		6	1	3
632	2024-09-16 22:18:58.47367+00	92	<User:  LOTFIfe>		6	92	1
633	2024-09-16 22:18:58.490734+00	101	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	92	1
634	2024-09-16 22:18:58.497638+00	103	None with None		10	92	1
635	2024-09-16 22:22:58.226254+00	93	<User:  LOTFIf>		6	93	1
636	2024-09-16 22:22:58.233925+00	102	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	93	1
637	2024-09-16 22:22:58.248+00	104	None with None		10	93	1
638	2024-09-30 21:01:37.096228+00	94	<User:  ii>		6	94	1
639	2024-09-30 21:01:37.108114+00	103	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	94	1
640	2024-09-30 21:01:37.118438+00	105	None with None		10	94	1
641	2024-10-02 02:12:57.759252+00	95	<User:  LOTFI>		6	95	1
642	2024-10-02 02:12:57.780247+00	104	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	95	1
643	2024-10-02 02:12:57.795192+00	106	None with None		10	95	1
644	2024-10-02 02:17:50.093281+00	96	<User:  LOTFI>		6	96	1
645	2024-10-02 02:17:50.105508+00	105	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	96	1
646	2024-10-02 02:17:50.117281+00	107	None with None		10	96	1
647	2024-10-02 02:18:12.093803+00	97	<User:  LOTFI>		6	97	1
648	2024-10-02 02:18:12.105288+00	106	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	97	1
649	2024-10-02 02:18:12.117527+00	108	None with None		10	97	1
650	2024-10-02 02:18:56.176788+00	98	<User:  LOTFIef>		6	98	1
651	2024-10-02 02:18:56.194563+00	107	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	98	1
652	2024-10-02 02:18:56.20596+00	109	None with None		10	98	1
656	2024-10-25 21:28:19.02087+00	102	<User:  LOTFI>		6	102	1
657	2024-10-25 21:28:19.031498+00	111	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	102	1
658	2024-10-25 21:28:19.044834+00	113	None with None		10	102	1
659	2024-10-25 22:14:33.813916+00	103	<User:  LOTFIsc>		6	103	1
660	2024-10-25 22:14:33.831771+00	112	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	103	1
661	2024-10-25 22:14:33.843032+00	114	None with None		10	103	1
662	2024-10-25 23:44:46.05707+00	104	<User:  LOTFI>		6	104	1
663	2024-10-25 23:44:46.070786+00	113	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	104	1
664	2024-10-25 23:44:46.083278+00	115	None with None		10	104	1
665	2024-10-25 23:54:47.45155+00	105	<User:  LOTFI>		6	105	1
666	2024-10-25 23:54:47.462237+00	114	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	105	1
667	2024-10-25 23:54:47.473462+00	116	None with None		10	105	1
668	2024-10-26 11:04:06.41613+00	106	<User:  Esteticium>		6	106	1
669	2024-10-26 11:04:06.428115+00	115	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	106	1
670	2024-10-26 11:04:06.441077+00	117	None with None		10	106	1
671	2024-10-26 17:03:44.425265+00	107	<User:  lotfi>		6	107	1
672	2024-10-26 17:03:44.43582+00	116	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	107	1
673	2024-10-26 17:03:44.446502+00	118	None with None		10	107	1
674	2024-11-06 19:39:37.005235+00	108	<User:  aymen >		6	108	1
675	2024-11-06 19:39:37.020416+00	117	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	108	1
676	2024-11-06 19:39:37.033278+00	119	None with None		10	108	1
677	2024-11-06 19:42:53.442865+00	109	<User:  faysel >		6	109	1
678	2024-11-06 19:42:53.45338+00	118	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	109	1
679	2024-11-06 19:42:53.463932+00	120	None with None		10	109	1
680	2024-11-06 19:56:04.451516+00	110	<User:  Lamin>		6	110	1
681	2024-11-06 19:56:04.462821+00	119	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	110	1
682	2024-11-06 19:56:04.475016+00	121	None with None		10	110	1
683	2024-11-06 19:58:34.384005+00	119	Sex: , Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None	Changed fields.	15	110	2
684	2024-11-06 19:58:34.407156+00	110	<User:  Lamin>	Changed fields.	6	110	2
685	2024-11-10 15:32:11.576291+00	99	 LOTFI		6	1	3
686	2024-11-10 20:50:38.185309+00	112	<User:  LOTFI>		6	112	1
687	2024-11-10 20:50:38.196214+00	120	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	112	1
688	2024-11-10 20:50:38.207785+00	122	None with None		10	112	1
689	2024-11-11 18:19:59.722861+00	114	<User:  Lotfi>		6	114	1
690	2024-11-11 18:19:59.734491+00	121	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	114	1
691	2024-11-11 18:19:59.746751+00	123	None with None		10	114	1
692	2024-11-13 21:47:15.954427+00	115	<User:  LOTFI>		6	115	1
693	2024-11-13 21:47:15.967232+00	122	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	115	1
694	2024-11-13 21:47:15.991411+00	124	None with None		10	115	1
695	2024-11-14 14:50:56.514978+00	116	<User:  LOTFIs>		6	116	1
696	2024-11-14 14:50:56.525603+00	123	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	116	1
697	2024-11-14 14:50:56.536223+00	125	None with None		10	116	1
698	2024-11-14 15:15:06.857902+00	117	<User:  lotfi>		6	117	1
699	2024-11-14 15:15:06.874358+00	124	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	117	1
700	2024-11-14 15:15:06.891125+00	126	None with None		10	117	1
701	2024-11-14 18:23:20.33252+00	118	<User:  shazna>		6	118	1
702	2024-11-14 18:23:20.367946+00	125	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	118	1
703	2024-11-14 18:23:20.385845+00	127	None with None		10	118	1
704	2024-11-14 19:39:55.272762+00	125	Sex: Female, Insurance: None with None, Medications: Tjorn insulin - \r\nSyngardy 12.5/1000mg\r\nsandoz Rosuvastatin 10 mg \r\nperindoplamine  5 mg, Allergies: , Medical Conditions: diabetes, Family History	Changed fields.	15	118	2
705	2024-11-14 19:39:56.830939+00	118	<User:  shazna>	Changed fields.	6	118	2
706	2024-11-14 19:56:05.706371+00	1	Flight TK-18 on 2024-11-18	[{"added": {}}]	82	1	1
707	2024-11-14 20:42:47.390767+00	1	Bekdas Hotel Deluxe & Spa (Double)	[{"added": {}}]	84	1	1
708	2024-11-14 20:48:52.650236+00	6	Straumann® BLX BLT	[{"added": {}}]	79	1	1
709	2024-11-14 20:49:47.634452+00	7	Sinus lifting	[{"added": {}}]	79	1	1
710	2024-11-14 20:50:10.995911+00	8	bone graft	[{"added": {}}]	79	1	1
711	2024-11-14 20:52:28.022413+00	9	Zirconium Crowns with Titanium Bases	[{"added": {}}]	79	1	1
712	2024-11-14 20:55:32.638286+00	119	<User:  Naci>		6	119	1
713	2024-11-14 20:55:32.651886+00	126	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	119	1
714	2024-11-14 20:55:32.664102+00	128	None with None		10	119	1
715	2024-11-14 20:56:43.991341+00	119	 Naci	[{"changed": {"fields": ["Groups", "Emergency Contact"]}}]	6	1	2
716	2024-11-14 20:57:11.052057+00	119	 Naci	[{"changed": {"fields": ["Staff status"]}}]	6	1	2
717	2024-11-14 21:35:52.440862+00	6	Straumann® BLX BLT	[]	79	1	2
718	2024-11-14 21:36:00.92918+00	9	Zirconium Crowns with Titanium Bases	[]	79	1	2
719	2024-11-14 21:39:25.53273+00	64	Treatment Plan for shazna imtiaz by Dr. Naci Canpolat	[{"added": {"name": "Treatment Plan Item", "object": "28 x Zirconium Crowns with Titanium Bases for Treatment Plan for shazna imtiaz by Dr. Naci Canpolat"}}]	78	1	2
720	2024-11-14 21:52:28.321475+00	64	Treatment Plan for shazna imtiaz by Dr. Naci Canpolat		78	1	3
721	2024-11-14 21:52:28.332968+00	63	Treatment Plan for Yasmin Al-Jabari by Dr. Ayla Tekin		78	1	3
722	2024-11-14 21:52:28.372269+00	61	Treatment Plan for Nada Arana by Dr. Melek Djemouai		78	1	3
723	2024-11-14 21:52:28.387877+00	60	Treatment Plan for Zahra Akgün by Dr. Ayla Aydın		78	1	3
724	2024-11-14 21:52:28.41661+00	58	Treatment Plan for Cem Yıldırım by Dr. Ayla Aydın		78	1	3
725	2024-11-14 21:52:28.434631+00	57	Treatment Plan for Cem Yıldırım by Dr. Ayla Aydın		78	1	3
726	2024-11-14 21:52:28.465103+00	56	Treatment Plan for Cem Yıldırım by Dr. Ayla Aydın		78	1	3
727	2024-11-14 21:52:28.481601+00	55	Treatment Plan for Cem Yıldırım by Dr. Ayla Aydın		78	1	3
728	2024-11-14 21:52:28.493294+00	54	Treatment Plan for Zahra Akgün by Dr. Ayla Aydın		78	1	3
729	2024-11-14 21:52:28.505764+00	53	Treatment Plan for Matthew Lewis by Dr. Emily White		78	1	3
730	2024-11-14 21:52:28.517503+00	52	Treatment Plan for Matthew Lewis by Dr. Emily White		78	1	3
731	2024-11-14 21:52:28.528717+00	51	Treatment Plan for Lukas Schmidt by Dr. Emily White		78	1	3
732	2024-11-14 21:52:28.540348+00	50	Treatment Plan for Lukas Schmidt by Dr. Emily White		78	1	3
733	2024-11-14 21:52:28.551011+00	49	Treatment Plan for Lukas Schmidt by Dr. Emily White		78	1	3
734	2024-11-14 21:52:28.563286+00	48	Treatment Plan for Lukas Schmidt by Dr. Emily White		78	1	3
735	2024-11-14 21:52:28.57501+00	47	Treatment Plan for Lukas Schmidt by Dr. Emily White		78	1	3
736	2024-11-14 21:52:28.586912+00	46	Treatment Plan for Lukas Schmidt by Dr. Emily White		78	1	3
737	2024-11-14 21:52:28.598261+00	45	Treatment Plan for Lukas Schmidt by Dr. Emily White		78	1	3
738	2024-11-14 21:52:28.609679+00	44	Treatment Plan for Ayşe Demir by Dr. Emily White		78	1	3
739	2024-11-14 21:52:28.620505+00	43	Treatment Plan for Ayşe Demir by Dr. Emily White		78	1	3
740	2024-11-14 21:52:28.631822+00	42	Treatment Plan for Ayşe Demir by Dr. Emily White		78	1	3
741	2024-11-14 21:52:28.642072+00	41	Treatment Plan for Ayşe Demir by Dr. Emily White		78	1	3
742	2024-11-14 21:52:28.653571+00	40	Treatment Plan for Kerem Güler by Dr. Emma Johnson		78	1	3
743	2024-11-14 21:52:28.665596+00	39	Treatment Plan for Kerem Güler by Dr. Emma Johnson		78	1	3
744	2024-11-14 21:52:28.677546+00	38	Treatment Plan for Kerem Güler by Dr. Emma Johnson		78	1	3
745	2024-11-14 21:52:28.688775+00	37	Treatment Plan for Kerem Güler by Dr. Emma Johnson		78	1	3
746	2024-11-14 21:52:28.699642+00	36	Treatment Plan for Kerem Güler by Dr. Emma Johnson		78	1	3
747	2024-11-14 21:52:28.709881+00	35	Treatment Plan for Victoria Green by Dr. John Doe		78	1	3
748	2024-11-14 21:52:28.721882+00	34	Treatment Plan for Victoria Green by Dr. John Doe		78	1	3
749	2024-11-14 21:52:28.734392+00	33	Treatment Plan for Selin Koç by Dr. Sarah Evans		78	1	3
750	2024-11-14 21:52:28.746424+00	32	Treatment Plan for Matthew Lewis by Dr. lotfi kanouni		78	1	3
751	2024-11-14 21:52:28.75878+00	31	Treatment Plan for Can Gürsoy by Dr. lotfi kanouni		78	1	3
752	2024-11-14 21:52:28.76929+00	29	Treatment Plan for Can Gürsoy by Dr. lotfi kanouni		78	1	3
753	2024-11-14 21:52:28.784234+00	28	Treatment Plan for Can Gürsoy by Dr. lotfi kanouni		78	1	3
754	2024-11-14 21:52:28.796267+00	27	Treatment Plan for Can Gürsoy by Dr. lotfi kanouni		78	1	3
755	2024-11-14 21:52:28.809971+00	26	Treatment Plan for Can Gürsoy by Dr. lotfi kanouni		78	1	3
756	2024-11-14 21:52:28.825817+00	25	Treatment Plan for Can Gürsoy by Dr. lotfi kanouni		78	1	3
757	2024-11-14 21:52:28.837313+00	24	Treatment Plan for Eren Yücel by Dr. Leila Ozturk		78	1	3
758	2024-11-14 21:52:28.849094+00	23	Treatment Plan for Eren Yücel by Dr. Leila Ozturk		78	1	3
759	2024-11-14 21:52:28.860249+00	22	Treatment Plan for Ahmet Duman by Dr. Leila Ozturk		78	1	3
760	2024-11-14 21:52:28.871901+00	21	Treatment Plan for Ahmet Duman by Dr. Leila Ozturk		78	1	3
761	2024-11-14 21:52:28.882793+00	20	Treatment Plan for Ahmet Duman by Dr. Leila Ozturk		78	1	3
762	2024-11-14 21:52:28.89425+00	19	Treatment Plan for Can Gürsoy by Dr. lotfi kanouni		78	1	3
763	2024-11-14 21:52:28.906238+00	18	Treatment Plan for Can Gürsoy by Dr. lotfi kanouni		78	1	3
764	2024-11-14 21:52:28.917647+00	17	Treatment Plan for Zeynep Kaya by Dr. Ayla Tekin		78	1	3
765	2024-11-14 21:52:28.937988+00	16	Treatment Plan for Catherine Dubois by Dr. Murat Can		78	1	3
766	2024-11-14 21:52:28.950824+00	15	Treatment Plan for William Carter by Dr. Murat Can		78	1	3
767	2024-11-14 21:52:28.961082+00	14	Treatment Plan for William Carter by Dr. Murat Can		78	1	3
768	2024-11-14 21:52:28.971784+00	13	Treatment Plan for Volkan Özcan by Dr. Emily White		78	1	3
769	2024-11-14 21:52:28.982447+00	12	Treatment Plan for Volkan Özcan by Dr. Emily White		78	1	3
770	2024-11-14 21:52:28.993209+00	11	Treatment Plan for Volkan Özcan by Dr. Emily White		78	1	3
771	2024-11-14 21:52:29.007232+00	10	Treatment Plan for Sarah Evans by Dr. Emily White		78	1	3
772	2024-11-14 21:52:29.018785+00	9	Treatment Plan for Sarah Evans by Dr. Emily White		78	1	3
773	2024-11-14 21:52:29.030711+00	8	Treatment Plan for Sarah Evans by Dr. Emily White		78	1	3
774	2024-11-14 21:52:29.042211+00	7	Treatment Plan for Efe Taş by Dr. Emily White		78	1	3
775	2024-11-14 21:52:29.054359+00	6	Treatment Plan for Efe Taş by Dr. Emily White		78	1	3
776	2024-11-14 21:52:29.06651+00	5	Treatment Plan for Efe Taş by Dr. Emily White		78	1	3
777	2024-11-14 21:52:29.08147+00	4	Treatment Plan for Efe Taş by Dr. Emily White		78	1	3
778	2024-11-14 21:52:29.094535+00	3	Treatment Plan for Zara Ahmed by Dr. Ahmet Duman		78	1	3
779	2024-11-14 21:52:29.107061+00	2	Treatment Plan for Zeynep Kaya by Dr. Can Gürsoy		78	1	3
780	2024-11-14 21:52:29.125006+00	1	Treatment Plan for Zeynep Kaya by Dr. Ayşe Demir		78	1	3
781	2024-11-14 22:27:23.073845+00	1	Treatment Plan for lotfi kanouni by Dr. Victoria Green	[{"added": {}}, {"added": {"name": "Treatment Plan Item", "object": "1 x Philips Zoom! WhiteSpeed for Treatment Plan for lotfi kanouni by Dr. Victoria Green"}}, {"added": {"name": "Treatment Plan Item", "object": "1 x Straumann\\u00ae BLX BLT for Treatment Plan for lotfi kanouni by Dr. Victoria Green"}}]	78	1	1
782	2024-11-14 22:28:37.379824+00	2	Treatment Plan for Naci Canpolat by Dr. Naci Canpolat	[{"added": {}}, {"added": {"name": "Treatment Plan Item", "object": "12 x Straumann\\u00ae BLX BLT for Treatment Plan for Naci Canpolat by Dr. Naci Canpolat"}}, {"added": {"name": "Treatment Plan Item", "object": "28 x Zirconium Crowns with Titanium Bases for Treatment Plan for Naci Canpolat by Dr. Naci Canpolat"}}, {"added": {"name": "Treatment Plan Item", "object": "2 x Sinus lifting for Treatment Plan for Naci Canpolat by Dr. Naci Canpolat"}}, {"added": {"name": "Treatment Plan Item", "object": "1 x bone graft for Treatment Plan for Naci Canpolat by Dr. Naci Canpolat"}}]	78	1	1
783	2024-11-14 22:28:53.067818+00	2	Treatment Plan for shazna imtiaz by Dr. Naci Canpolat	[{"changed": {"fields": ["Patient"]}}]	78	1	2
784	2024-11-14 22:29:18.872046+00	2	Treatment Plan for shazna imtiaz by Dr. Naci Canpolat	[{"changed": {"fields": ["Patient"]}}]	78	1	2
785	2024-11-14 22:34:17.9806+00	3	Treatment Plan for shazna imtiaz by Dr. Naci Canpolat	[{"added": {}}, {"added": {"name": "Treatment Plan Item", "object": "12 x Straumann\\u00ae BLX BLT for Treatment Plan for shazna imtiaz by Dr. Naci Canpolat"}}, {"added": {"name": "Treatment Plan Item", "object": "28 x Zirconium Crowns with Titanium Bases for Treatment Plan for shazna imtiaz by Dr. Naci Canpolat"}}, {"added": {"name": "Treatment Plan Item", "object": "2 x Sinus lifting for Treatment Plan for shazna imtiaz by Dr. Naci Canpolat"}}, {"added": {"name": "Treatment Plan Item", "object": "1 x bone graft for Treatment Plan for shazna imtiaz by Dr. Naci Canpolat"}}]	78	1	1
786	2024-11-14 22:34:36.048792+00	3	Treatment Plan for shazna imtiaz by Dr. Naci Canpolat	[]	78	1	2
787	2024-11-14 22:37:03.148121+00	3	Treatment Plan for shazna imtiaz by Dr. Naci Canpolat	[{"changed": {"fields": ["Final Discount Percentage"]}}]	78	1	2
788	2024-11-14 23:33:26.984192+00	10	Straumann® Zygomatic Implants	[{"added": {}}]	79	1	1
789	2024-11-14 23:36:22.779772+00	10	Straumann® Zygomatic Implants	[{"changed": {"fields": ["Max Discount Percentage"]}}]	79	1	2
790	2024-11-14 23:36:26.8839+00	4	Treatment Plan for shazna imtiaz by Dr. Naci Canpolat	[{"added": {}}, {"added": {"name": "Treatment Plan Item", "object": "4 x Straumann\\u00ae Zygomatic Implants for Treatment Plan for shazna imtiaz by Dr. Naci Canpolat"}}, {"added": {"name": "Treatment Plan Item", "object": "8 x Straumann\\u00ae BLX BLT for Treatment Plan for shazna imtiaz by Dr. Naci Canpolat"}}, {"added": {"name": "Treatment Plan Item", "object": "28 x Zirconium Crowns with Titanium Bases for Treatment Plan for shazna imtiaz by Dr. Naci Canpolat"}}]	78	1	1
791	2024-11-14 23:36:41.415896+00	4	Treatment Plan for shazna imtiaz by Dr. Naci Canpolat	[]	78	1	2
792	2024-11-14 23:39:49.847611+00	4	Treatment Plan for shazna imtiaz by Dr. Naci Canpolat	[{"changed": {"fields": ["Final Discount Percentage"]}}]	78	1	2
793	2024-11-14 23:40:06.989519+00	4	Treatment Plan for shazna imtiaz by Dr. Naci Canpolat	[{"changed": {"fields": ["Final Discount Percentage"]}}]	78	1	2
794	2024-11-14 23:57:28.977722+00	5	Treatment Plan for shazna imtiaz by Dr. Naci Canpolat	[{"added": {}}, {"added": {"name": "Treatment Plan Item", "object": "12 x Straumann\\u00ae BLX BLT for Treatment Plan for shazna imtiaz by Dr. Naci Canpolat"}}, {"added": {"name": "Treatment Plan Item", "object": "28 x Zirconium Crowns with Titanium Bases for Treatment Plan for shazna imtiaz by Dr. Naci Canpolat"}}]	78	1	1
795	2024-11-14 23:57:46.646493+00	5	Treatment Plan for shazna imtiaz by Dr. Naci Canpolat	[]	78	1	2
796	2024-11-14 23:58:31.870365+00	2	Treatment Plan for Naci Canpolat by Dr. Naci Canpolat		78	1	3
797	2024-11-14 23:58:31.888311+00	1	Treatment Plan for lotfi kanouni by Dr. Victoria Green		78	1	3
798	2024-11-14 23:59:13.50111+00	3	Treatment Plan for shazna imtiaz by Dr. Naci Canpolat	[{"changed": {"fields": ["Final Discount Percentage"]}}]	78	1	2
799	2024-11-15 00:00:58.667645+00	4	Treatment Plan for shazna imtiaz by Dr. Naci Canpolat	[{"changed": {"fields": ["Discount Amount"]}}]	78	1	2
800	2024-11-15 00:01:19.134311+00	4	Treatment Plan for shazna imtiaz by Dr. Naci Canpolat	[{"changed": {"fields": ["Final Discount Percentage"]}}]	78	1	2
801	2024-11-15 00:01:30.988786+00	4	Treatment Plan for shazna imtiaz by Dr. Naci Canpolat	[]	78	1	2
802	2024-11-15 00:01:56.246997+00	5	Treatment Plan for shazna imtiaz by Dr. Naci Canpolat		78	1	3
803	2024-11-15 00:04:17.261972+00	4	Treatment Plan for shazna imtiaz by Dr. Naci Canpolat	[{"changed": {"fields": ["Final Discount Percentage"]}}]	78	1	2
804	2024-11-15 00:14:10.53322+00	6	Treatment Plan for lotfi nadine by Dr. Naci Canpolat	[{"added": {}}, {"added": {"name": "Treatment Plan Item", "object": "12 x Straumann\\u00ae BLX BLT for Treatment Plan for lotfi nadine by Dr. Naci Canpolat"}}, {"added": {"name": "Treatment Plan Item", "object": "28 x Zirconium Crowns with Titanium Bases for Treatment Plan for lotfi nadine by Dr. Naci Canpolat"}}, {"added": {"name": "Treatment Plan Item", "object": "2 x Sinus lifting for Treatment Plan for lotfi nadine by Dr. Naci Canpolat"}}]	78	1	1
805	2024-11-15 03:06:15.126286+00	7	Treatment Plan for lotfi nadine by Dr. Naci Canpolat	[{"added": {}}, {"added": {"name": "Treatment Plan Item", "object": "1 x bone graft for Treatment Plan for lotfi nadine by Dr. Naci Canpolat"}}, {"added": {"name": "Treatment Plan Item", "object": "2 x Sinus lifting for Treatment Plan for lotfi nadine by Dr. Naci Canpolat"}}]	78	1	1
806	2024-11-15 03:06:32.33347+00	7	Treatment Plan for lotfi nadine by Dr. Naci Canpolat	[]	78	1	2
807	2024-11-15 03:20:21.252443+00	6	Treatment Plan for lotfi nadine by Dr. Naci Canpolat	[]	78	1	2
808	2024-11-15 03:21:06.50868+00	6	Treatment Plan for lotfi nadine by Dr. Naci Canpolat	[{"changed": {"fields": ["Final Discount Percentage"]}}]	78	1	2
809	2024-11-15 03:21:16.416966+00	6	Treatment Plan for lotfi nadine by Dr. Naci Canpolat	[]	78	1	2
810	2024-11-15 03:21:56.675684+00	6	Treatment Plan for lotfi nadine by Dr. Naci Canpolat	[{"changed": {"fields": ["Final Discount Percentage"]}}]	78	1	2
811	2024-11-15 05:24:12.266087+00	1	Bekdas Hotel Deluxe & Spa (7 nights) - shazna imtiaz	[{"added": {}}]	83	1	1
812	2024-11-15 05:24:30.083486+00	2	Bekdas Hotel Deluxe & Spa (7 nights) - shazna imtiaz	[{"added": {}}]	83	1	1
813	2024-11-15 05:25:34.598191+00	3	Bekdas Hotel Deluxe & Spa (6 nights) - lotfi nadine	[{"added": {}}]	83	1	1
814	2024-11-15 05:29:09.397447+00	1	  shazna appointment with  Naci	[{"added": {}}]	17	1	1
815	2024-11-15 05:29:12.760235+00	1	Schedule for shazna imtiaz with appointment on 2024-11-19 10:00:00+00:00	[{"added": {}}]	81	1	1
816	2024-11-15 06:12:34.957057+00	2	Schedule for lotfi nadine with appointment on 2024-11-19 10:00:00+00:00	[{"added": {}}]	81	1	1
817	2024-11-15 18:54:19.556981+00	11	<MessageGroup: MessageGroup object (11)>		13	118	1
818	2024-11-15 19:57:13.352592+00	2	EYFEL HOTEL (Double)	[{"added": {}}]	84	1	1
819	2024-11-15 19:57:48.210688+00	2	EYFEL HOTEL (7 nights) - shazna imtiaz	[{"changed": {"fields": ["Hotel"]}}]	83	1	2
820	2024-11-15 19:57:52.72186+00	1	EYFEL HOTEL (7 nights) - shazna imtiaz	[{"changed": {"fields": ["Hotel"]}}]	83	1	2
821	2024-12-15 19:38:53.290496+00	676	Amara Okafor (LinkedIn)	update through import_export	88	1	2
822	2024-12-15 19:38:53.29831+00	677	Fatima Al-Masri (Website)	update through import_export	88	1	2
823	2024-12-15 19:38:53.302022+00	678	Fatima Al-Masri (Instagram)	update through import_export	88	1	2
824	2024-12-15 19:38:53.309113+00	679	Liam O'Connor (Facebook)	update through import_export	88	1	2
825	2024-12-15 19:38:53.31253+00	680	Fatima Al-Masri (LinkedIn)	update through import_export	88	1	2
826	2024-12-15 19:38:53.315733+00	681	Ivan Petrov (Instagram)	update through import_export	88	1	2
827	2024-12-15 19:38:53.319005+00	682	Aisha Khan (Facebook)	update through import_export	88	1	2
828	2024-12-15 19:38:53.322382+00	683	Hiroshi Tanaka (Facebook)	update through import_export	88	1	2
829	2024-12-15 19:38:53.325569+00	684	Chen Wei (Facebook)	update through import_export	88	1	2
830	2024-12-15 19:38:53.329097+00	685	Sophia Müller (Instagram)	update through import_export	88	1	2
831	2024-12-15 19:38:53.332388+00	686	Aisha Khan (Website)	update through import_export	88	1	2
832	2024-12-15 19:38:53.336304+00	687	Chen Wei (Website)	update through import_export	88	1	2
833	2024-12-15 19:38:53.339709+00	688	Carlos Rodriguez (Facebook)	update through import_export	88	1	2
834	2024-12-15 19:38:53.344874+00	689	Fatima Al-Masri (LinkedIn)	update through import_export	88	1	2
835	2024-12-15 19:38:53.34835+00	690	Carlos Rodriguez (Website)	update through import_export	88	1	2
836	2024-12-15 19:38:53.351846+00	691	Carlos Rodriguez (Website)	update through import_export	88	1	2
837	2024-12-15 19:38:53.355257+00	692	Aisha Khan (Instagram)	update through import_export	88	1	2
838	2024-12-15 19:38:53.358388+00	693	Fatima Al-Masri (Website)	update through import_export	88	1	2
839	2024-12-15 19:38:53.361406+00	694	Sven Johansson (LinkedIn)	update through import_export	88	1	2
840	2024-12-15 19:38:53.364503+00	695	Sophia Müller (Website)	update through import_export	88	1	2
841	2024-12-15 19:38:53.367884+00	696	Fatima Al-Masri (Website)	update through import_export	88	1	2
842	2024-12-15 19:38:53.371484+00	697	Hiroshi Tanaka (Instagram)	update through import_export	88	1	2
843	2024-12-15 19:38:53.374421+00	698	Sven Johansson (Website)	update through import_export	88	1	2
844	2024-12-15 19:38:53.378079+00	699	Ivan Petrov (Facebook)	update through import_export	88	1	2
845	2024-12-15 19:38:53.38123+00	700	Amara Okafor (Instagram)	update through import_export	88	1	2
846	2024-12-15 19:38:53.384373+00	701	Fatima Al-Masri (Facebook)	update through import_export	88	1	2
847	2024-12-15 19:38:53.387752+00	702	Liam O'Connor (LinkedIn)	update through import_export	88	1	2
848	2024-12-15 19:38:53.39084+00	703	Ivan Petrov (Instagram)	update through import_export	88	1	2
849	2024-12-15 19:38:53.394128+00	704	Fatima Al-Masri (Facebook)	update through import_export	88	1	2
850	2024-12-15 19:38:53.397434+00	705	Sophia Müller (Instagram)	update through import_export	88	1	2
851	2024-12-15 19:38:53.400968+00	706	Giulia Rossi (Website)	update through import_export	88	1	2
852	2024-12-15 19:38:53.403972+00	707	Giulia Rossi (Facebook)	update through import_export	88	1	2
853	2024-12-15 19:38:53.407989+00	708	Sven Johansson (Website)	update through import_export	88	1	2
854	2024-12-15 19:38:53.412675+00	709	Aisha Khan (LinkedIn)	update through import_export	88	1	2
855	2024-12-15 19:38:53.41617+00	710	Carlos Rodriguez (LinkedIn)	update through import_export	88	1	2
856	2024-12-15 19:38:53.419613+00	711	Fatima Al-Masri (Instagram)	update through import_export	88	1	2
857	2024-12-15 19:38:53.423113+00	712	Liam O'Connor (Facebook)	update through import_export	88	1	2
858	2024-12-15 19:38:53.426616+00	713	Giulia Rossi (Facebook)	update through import_export	88	1	2
859	2024-12-15 19:38:53.429982+00	714	Aisha Khan (Facebook)	update through import_export	88	1	2
860	2024-12-15 19:38:53.433554+00	715	Liam O'Connor (Facebook)	update through import_export	88	1	2
861	2024-12-15 19:38:53.437248+00	716	Carlos Rodriguez (Website)	update through import_export	88	1	2
862	2024-12-15 19:38:53.440662+00	717	Chen Wei (LinkedIn)	update through import_export	88	1	2
863	2024-12-15 19:38:53.444107+00	718	Sophia Müller (Facebook)	update through import_export	88	1	2
864	2024-12-15 19:38:53.447335+00	719	Liam O'Connor (Facebook)	update through import_export	88	1	2
865	2024-12-15 19:38:53.450881+00	720	Aisha Khan (Facebook)	update through import_export	88	1	2
866	2024-12-15 19:38:53.454563+00	721	Hiroshi Tanaka (LinkedIn)	update through import_export	88	1	2
867	2024-12-15 19:38:53.457666+00	722	Amara Okafor (Website)	update through import_export	88	1	2
868	2024-12-15 19:38:53.461799+00	723	Ahmed Ibrahim (Instagram)	update through import_export	88	1	2
869	2024-12-15 19:38:53.466395+00	724	Carlos Rodriguez (Instagram)	update through import_export	88	1	2
870	2024-12-15 19:38:53.469495+00	725	Ivan Petrov (Instagram)	update through import_export	88	1	2
871	2024-12-15 19:38:53.472632+00	726	Sophia Müller (Instagram)	update through import_export	88	1	2
872	2024-12-15 19:38:53.475883+00	727	Ivan Petrov (LinkedIn)	update through import_export	88	1	2
873	2024-12-15 19:38:53.47917+00	728	Liam O'Connor (LinkedIn)	update through import_export	88	1	2
874	2024-12-15 19:38:53.48254+00	729	Giulia Rossi (Facebook)	update through import_export	88	1	2
875	2024-12-15 19:38:53.486914+00	730	Sophia Müller (Website)	update through import_export	88	1	2
876	2024-12-15 19:38:53.490301+00	731	Amara Okafor (Facebook)	update through import_export	88	1	2
877	2024-12-15 19:38:53.493575+00	732	Sophia Müller (Instagram)	update through import_export	88	1	2
878	2024-12-15 19:38:53.496908+00	733	Hiroshi Tanaka (Instagram)	update through import_export	88	1	2
879	2024-12-15 19:38:53.499987+00	734	Amara Okafor (Website)	update through import_export	88	1	2
880	2024-12-15 19:38:53.503455+00	735	Ahmed Ibrahim (Website)	update through import_export	88	1	2
881	2024-12-15 19:38:53.506821+00	736	Ivan Petrov (Instagram)	update through import_export	88	1	2
882	2024-12-15 19:38:53.50994+00	737	Sven Johansson (Website)	update through import_export	88	1	2
883	2024-12-15 19:38:53.51393+00	738	Chen Wei (LinkedIn)	update through import_export	88	1	2
884	2024-12-15 19:38:53.518203+00	739	Sophia Müller (Instagram)	update through import_export	88	1	2
885	2024-12-15 19:38:53.521752+00	740	Amara Okafor (Instagram)	update through import_export	88	1	2
886	2024-12-15 19:38:53.525356+00	741	Liam O'Connor (Facebook)	update through import_export	88	1	2
887	2024-12-15 19:38:53.528516+00	742	Chen Wei (LinkedIn)	update through import_export	88	1	2
888	2024-12-15 19:38:53.531855+00	743	Liam O'Connor (Facebook)	update through import_export	88	1	2
889	2024-12-15 19:38:53.535233+00	744	Sophia Müller (Facebook)	update through import_export	88	1	2
890	2024-12-15 19:38:53.538333+00	745	Fatima Al-Masri (LinkedIn)	update through import_export	88	1	2
891	2024-12-15 19:38:53.541792+00	746	Hiroshi Tanaka (Facebook)	update through import_export	88	1	2
892	2024-12-15 19:38:53.545309+00	747	Sven Johansson (Instagram)	update through import_export	88	1	2
893	2024-12-15 19:38:53.552727+00	748	Sven Johansson (Instagram)	update through import_export	88	1	2
894	2024-12-15 19:38:53.555991+00	749	Fatima Al-Masri (LinkedIn)	update through import_export	88	1	2
895	2024-12-15 19:38:53.559023+00	750	Aisha Khan (Instagram)	update through import_export	88	1	2
896	2024-12-15 19:38:53.5633+00	751	Liam O'Connor (Website)	update through import_export	88	1	2
897	2024-12-15 19:38:53.566545+00	752	Carlos Rodriguez (Facebook)	update through import_export	88	1	2
898	2024-12-15 19:38:53.56968+00	753	Hiroshi Tanaka (Instagram)	update through import_export	88	1	2
899	2024-12-15 19:38:53.573164+00	754	Liam O'Connor (LinkedIn)	update through import_export	88	1	2
900	2024-12-15 19:38:53.576733+00	755	Aisha Khan (Instagram)	update through import_export	88	1	2
901	2024-12-15 19:38:53.579788+00	756	Ivan Petrov (Instagram)	update through import_export	88	1	2
902	2024-12-15 19:38:53.582987+00	757	Carlos Rodriguez (LinkedIn)	update through import_export	88	1	2
903	2024-12-15 19:38:53.586279+00	758	Amara Okafor (LinkedIn)	update through import_export	88	1	2
904	2024-12-15 19:38:53.589837+00	759	Hiroshi Tanaka (Facebook)	update through import_export	88	1	2
905	2024-12-15 19:38:53.592845+00	760	Amara Okafor (Instagram)	update through import_export	88	1	2
906	2024-12-15 19:38:53.597093+00	761	Sophia Müller (Facebook)	update through import_export	88	1	2
907	2024-12-15 19:38:53.600181+00	762	Amara Okafor (Website)	update through import_export	88	1	2
908	2024-12-15 19:38:53.603439+00	763	Ivan Petrov (LinkedIn)	update through import_export	88	1	2
909	2024-12-15 19:38:53.606995+00	764	Sophia Müller (Instagram)	update through import_export	88	1	2
910	2024-12-15 19:38:53.6102+00	765	Sven Johansson (Instagram)	update through import_export	88	1	2
911	2024-12-15 19:38:53.613487+00	766	Ivan Petrov (LinkedIn)	update through import_export	88	1	2
912	2024-12-15 19:38:53.616707+00	767	Amara Okafor (Instagram)	update through import_export	88	1	2
913	2024-12-15 19:38:53.619843+00	768	Chen Wei (LinkedIn)	update through import_export	88	1	2
914	2024-12-15 19:38:53.623556+00	769	Sven Johansson (Instagram)	update through import_export	88	1	2
915	2024-12-15 19:38:53.627024+00	770	Chen Wei (Website)	update through import_export	88	1	2
1059	2024-12-17 13:03:24.105183+00	684	Chen Wei (Facebook)		88	1	3
916	2024-12-15 19:38:53.630112+00	771	Hiroshi Tanaka (Facebook)	update through import_export	88	1	2
917	2024-12-15 19:38:53.633482+00	772	Aisha Khan (LinkedIn)	update through import_export	88	1	2
918	2024-12-15 19:38:53.636473+00	773	Carlos Rodriguez (LinkedIn)	update through import_export	88	1	2
919	2024-12-15 19:38:53.639694+00	774	Ivan Petrov (Facebook)	update through import_export	88	1	2
920	2024-12-15 19:38:53.643239+00	775	Giulia Rossi (Facebook)	update through import_export	88	1	2
921	2024-12-15 19:38:53.64737+00	776	jeanette ruffat (fb)	new through import_export	88	1	1
922	2024-12-15 19:38:53.650477+00	777	Yousaf Khan (fb)	new through import_export	88	1	1
923	2024-12-15 19:38:53.653515+00	778	menezes Candy (ig)	new through import_export	88	1	1
924	2024-12-15 19:38:53.657105+00	779	Janis E Bianucci (fb)	new through import_export	88	1	1
925	2024-12-15 19:38:53.660239+00	780	Jose Batist (fb)	new through import_export	88	1	1
926	2024-12-15 19:38:53.663397+00	781	Muaiao kiliona (fb)	new through import_export	88	1	1
927	2024-12-15 19:38:53.66636+00	782	stone smyth (fb)	new through import_export	88	1	1
928	2024-12-15 19:38:53.67028+00	783	Angela Liggins (fb)	new through import_export	88	1	1
929	2024-12-15 19:38:53.67369+00	784	George Gawel (fb)	new through import_export	88	1	1
930	2024-12-15 19:38:53.67667+00	785	Joe (fb)	new through import_export	88	1	1
931	2024-12-15 19:38:53.679557+00	786	Joyce March (fb)	new through import_export	88	1	1
932	2024-12-15 19:38:53.688292+00	787	Jana Rozenberga (ig)	new through import_export	88	1	1
933	2024-12-15 19:38:53.691792+00	788	Martina Tura (ig)	new through import_export	88	1	1
934	2024-12-15 19:38:53.695076+00	789	antonio di lauro (fb)	new through import_export	88	1	1
935	2024-12-15 19:38:53.698043+00	790	Mindru Cezar (fb)	new through import_export	88	1	1
936	2024-12-15 19:38:53.702449+00	791	MICHAEL CIRIC (fb)	new through import_export	88	1	1
937	2024-12-15 19:38:53.705761+00	792	Phindile Nxumalo (ig)	new through import_export	88	1	1
938	2024-12-15 19:38:53.70911+00	793	Carmela Della Ripa Bilotto (fb)	new through import_export	88	1	1
939	2024-12-15 19:38:53.712094+00	794	Constantin Bobai__ (fb)	new through import_export	88	1	1
940	2024-12-15 19:38:53.715712+00	795	Gheorghe Zaporojan (fb)	new through import_export	88	1	1
941	2024-12-15 19:38:53.719168+00	796	Shaukat Pervezs (fb)	new through import_export	88	1	1
942	2024-12-15 19:38:53.723391+00	797	Fadia haddad (ig)	new through import_export	88	1	1
943	2024-12-15 19:38:53.726929+00	798	Neculai Gorgovan (fb)	new through import_export	88	1	1
944	2024-12-15 19:38:53.730144+00	799	Crisan Petru Ionel (fb)	new through import_export	88	1	1
945	2024-12-15 19:38:53.733689+00	800	Michaela Argireanu-Ioanidi (fb)	new through import_export	88	1	1
946	2024-12-15 19:38:53.73715+00	801	m (fb)	new through import_export	88	1	1
947	2024-12-15 19:38:53.740375+00	802	_______ ______ (fb)	new through import_export	88	1	1
948	2024-12-15 19:38:53.743735+00	803	Vacca (fb)	new through import_export	88	1	1
949	2024-12-15 19:38:53.747037+00	804	POPESCU CONSTANTINA (fb)	new through import_export	88	1	1
950	2024-12-15 19:38:53.750565+00	805	Annette (Antoinette) Guerrera (fb)	new through import_export	88	1	1
951	2024-12-15 19:38:53.753715+00	806	Ncei Mousavi (fb)	new through import_export	88	1	1
952	2024-12-15 19:38:53.756949+00	807	Ilie Craioveanu (fb)	new through import_export	88	1	1
953	2024-12-15 19:38:53.760025+00	808	Jeana Dinu (fb)	new through import_export	88	1	1
954	2024-12-15 19:38:53.763437+00	809	Neacsu Viorica (fb)	new through import_export	88	1	1
955	2024-12-15 19:38:53.766704+00	810	Savvas Tsestos (fb)	new through import_export	88	1	1
956	2024-12-15 19:38:53.770101+00	811	Savvas Tsestos (fb)	new through import_export	88	1	1
957	2024-12-15 19:38:53.773627+00	812	more.ingormation (fb)	new through import_export	88	1	1
958	2024-12-15 19:38:53.778015+00	813	Helder Margarido (ig)	new through import_export	88	1	1
959	2024-12-15 19:38:53.781381+00	814	Manuel Filipe (fb)	new through import_export	88	1	1
960	2024-12-15 19:38:53.784796+00	815	Yvett Dubnicka (fb)	new through import_export	88	1	1
961	2024-12-15 19:38:53.788251+00	816	Luc Nakken (fb)	new through import_export	88	1	1
962	2024-12-15 19:38:53.791642+00	817	Halide Mahmuto_lu (fb)	new through import_export	88	1	1
963	2024-12-15 19:38:53.794927+00	818	Maria Victoria Villegas (fb)	new through import_export	88	1	1
964	2024-12-15 19:38:53.798417+00	819	Mohamed Aliu Embalo (fb)	new through import_export	88	1	1
965	2024-12-15 19:38:53.809272+00	820	Joaquim Carvalho (fb)	new through import_export	88	1	1
966	2024-12-15 19:38:53.814307+00	821	Jana Rozenberga (ig)	new through import_export	88	1	1
967	2024-12-15 19:38:53.818212+00	822	Joaquim Pop (fb)	new through import_export	88	1	1
968	2024-12-15 19:38:53.822002+00	823	Nina Katsioloudi (fb)	new through import_export	88	1	1
969	2024-12-15 19:38:53.82537+00	824	roo (ig)	new through import_export	88	1	1
970	2024-12-15 19:38:53.8287+00	825	Karin Loubser (fb)	new through import_export	88	1	1
971	2024-12-15 19:38:53.83208+00	826	Dioma Girard (fb)	new through import_export	88	1	1
972	2024-12-15 19:38:53.836163+00	827	Denis Scott akwafei (fb)	new through import_export	88	1	1
973	2024-12-15 19:38:53.839827+00	828	Florinda  Maria do Ros‡rio Serra (fb)	new through import_export	88	1	1
974	2024-12-15 19:38:53.84336+00	829	Greg Santos (fb)	new through import_export	88	1	1
975	2024-12-15 19:38:53.846665+00	830	Dariush Modelis (ig)	new through import_export	88	1	1
976	2024-12-15 19:38:53.850131+00	831	Kaspars _t_ls (fb)	new through import_export	88	1	1
977	2024-12-15 19:38:53.853265+00	832	Jorge Fonte (fb)	new through import_export	88	1	1
978	2024-12-15 19:38:53.856622+00	833	Daniel Roger (fb)	new through import_export	88	1	1
979	2024-12-15 19:38:53.859698+00	834	e Filipe fomos uma gota de l’quido (fb)	new through import_export	88	1	1
980	2024-12-15 19:38:53.86301+00	835	Stefan Sobotka (fb)	new through import_export	88	1	1
981	2024-12-15 19:38:53.866089+00	836	Kiki Kakli (fb)	new through import_export	88	1	1
982	2024-12-15 19:38:53.869726+00	837	Vacca (fb)	new through import_export	88	1	1
983	2024-12-15 19:38:53.873054+00	838	maria F‡tima  Caires entrada 43 port (fb)	new through import_export	88	1	1
984	2024-12-15 19:38:53.876522+00	839	Jo‹o Maria d'Orey (fb)	new through import_export	88	1	1
985	2024-12-15 19:38:53.879895+00	840	________ _____________ (fb)	new through import_export	88	1	1
986	2024-12-15 19:38:53.883276+00	841	Manel Kahavidana (fb)	new through import_export	88	1	1
987	2024-12-15 19:38:53.887406+00	842	________ _______ (ig)	new through import_export	88	1	1
988	2024-12-15 19:38:53.892516+00	843	Joaquim Celorico (fb)	new through import_export	88	1	1
989	2024-12-15 19:38:53.895839+00	844	Antonio Henrique Simao (fb)	new through import_export	88	1	1
990	2024-12-15 19:38:53.899328+00	845	Thomas Ntokas (fb)	new through import_export	88	1	1
991	2024-12-15 19:38:53.902383+00	846	Martti Savikko (fb)	new through import_export	88	1	1
992	2024-12-15 19:38:53.905475+00	847	Ioannis Paterakis (fb)	new through import_export	88	1	1
993	2024-12-16 14:30:37.110841+00	120	<User:  Lotfi>		6	120	1
994	2024-12-16 14:30:37.117074+00	127	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	120	1
995	2024-12-16 14:30:37.120814+00	129	None with None		10	120	1
996	2024-12-17 13:03:23.881336+00	747	Sven Johansson (Instagram)		88	1	3
997	2024-12-17 13:03:23.885824+00	746	Hiroshi Tanaka (Facebook)		88	1	3
998	2024-12-17 13:03:23.88847+00	745	Fatima Al-Masri (LinkedIn)		88	1	3
999	2024-12-17 13:03:23.891458+00	744	Sophia Müller (Facebook)		88	1	3
1000	2024-12-17 13:03:23.894739+00	743	Liam O'Connor (Facebook)		88	1	3
1001	2024-12-17 13:03:23.898182+00	742	Chen Wei (LinkedIn)		88	1	3
1002	2024-12-17 13:03:23.901732+00	741	Liam O'Connor (Facebook)		88	1	3
1003	2024-12-17 13:03:23.904642+00	740	Amara Okafor (Instagram)		88	1	3
1004	2024-12-17 13:03:23.907717+00	739	Sophia Müller (Instagram)		88	1	3
1005	2024-12-17 13:03:23.919148+00	738	Chen Wei (LinkedIn)		88	1	3
1006	2024-12-17 13:03:23.924522+00	737	Sven Johansson (Website)		88	1	3
1007	2024-12-17 13:03:23.927953+00	736	Ivan Petrov (Instagram)		88	1	3
1008	2024-12-17 13:03:23.931191+00	735	Ahmed Ibrahim (Website)		88	1	3
1009	2024-12-17 13:03:23.934676+00	734	Amara Okafor (Website)		88	1	3
1010	2024-12-17 13:03:23.937778+00	733	Hiroshi Tanaka (Instagram)		88	1	3
1011	2024-12-17 13:03:23.940732+00	732	Sophia Müller (Instagram)		88	1	3
1012	2024-12-17 13:03:23.944019+00	731	Amara Okafor (Facebook)		88	1	3
1013	2024-12-17 13:03:23.946994+00	730	Sophia Müller (Website)		88	1	3
1014	2024-12-17 13:03:23.950115+00	729	Giulia Rossi (Facebook)		88	1	3
1015	2024-12-17 13:03:23.953407+00	728	Liam O'Connor (LinkedIn)		88	1	3
1016	2024-12-17 13:03:23.956484+00	727	Ivan Petrov (LinkedIn)		88	1	3
1017	2024-12-17 13:03:23.959912+00	726	Sophia Müller (Instagram)		88	1	3
1018	2024-12-17 13:03:23.962996+00	725	Ivan Petrov (Instagram)		88	1	3
1019	2024-12-17 13:03:23.966085+00	724	Carlos Rodriguez (Instagram)		88	1	3
1020	2024-12-17 13:03:23.969219+00	723	Ahmed Ibrahim (Instagram)		88	1	3
1021	2024-12-17 13:03:23.972373+00	722	Amara Okafor (Website)		88	1	3
1022	2024-12-17 13:03:23.975689+00	721	Hiroshi Tanaka (LinkedIn)		88	1	3
1023	2024-12-17 13:03:23.979375+00	720	Aisha Khan (Facebook)		88	1	3
1024	2024-12-17 13:03:23.982339+00	719	Liam O'Connor (Facebook)		88	1	3
1025	2024-12-17 13:03:23.986308+00	718	Sophia Müller (Facebook)		88	1	3
1026	2024-12-17 13:03:23.989741+00	717	Chen Wei (LinkedIn)		88	1	3
1027	2024-12-17 13:03:23.99302+00	716	Carlos Rodriguez (Website)		88	1	3
1028	2024-12-17 13:03:23.99604+00	715	Liam O'Connor (Facebook)		88	1	3
1029	2024-12-17 13:03:24.000185+00	714	Aisha Khan (Facebook)		88	1	3
1030	2024-12-17 13:03:24.003167+00	713	Giulia Rossi (Facebook)		88	1	3
1031	2024-12-17 13:03:24.006688+00	712	Liam O'Connor (Facebook)		88	1	3
1032	2024-12-17 13:03:24.010153+00	711	Fatima Al-Masri (Instagram)		88	1	3
1033	2024-12-17 13:03:24.01334+00	710	Carlos Rodriguez (LinkedIn)		88	1	3
1034	2024-12-17 13:03:24.016502+00	709	Aisha Khan (LinkedIn)		88	1	3
1035	2024-12-17 13:03:24.019593+00	708	Sven Johansson (Website)		88	1	3
1036	2024-12-17 13:03:24.022999+00	707	Giulia Rossi (Facebook)		88	1	3
1037	2024-12-17 13:03:24.026306+00	706	Giulia Rossi (Website)		88	1	3
1038	2024-12-17 13:03:24.029358+00	705	Sophia Müller (Instagram)		88	1	3
1039	2024-12-17 13:03:24.032606+00	704	Fatima Al-Masri (Facebook)		88	1	3
1040	2024-12-17 13:03:24.035864+00	703	Ivan Petrov (Instagram)		88	1	3
1041	2024-12-17 13:03:24.038979+00	702	Liam O'Connor (LinkedIn)		88	1	3
1042	2024-12-17 13:03:24.042235+00	701	Fatima Al-Masri (Facebook)		88	1	3
1043	2024-12-17 13:03:24.045138+00	700	Amara Okafor (Instagram)		88	1	3
1044	2024-12-17 13:03:24.048184+00	699	Ivan Petrov (Facebook)		88	1	3
1045	2024-12-17 13:03:24.051101+00	698	Sven Johansson (Website)		88	1	3
1046	2024-12-17 13:03:24.054776+00	697	Hiroshi Tanaka (Instagram)		88	1	3
1047	2024-12-17 13:03:24.058179+00	696	Fatima Al-Masri (Website)		88	1	3
1048	2024-12-17 13:03:24.061164+00	695	Sophia Müller (Website)		88	1	3
1049	2024-12-17 13:03:24.064349+00	694	Sven Johansson (LinkedIn)		88	1	3
1050	2024-12-17 13:03:24.070518+00	693	Fatima Al-Masri (Website)		88	1	3
1051	2024-12-17 13:03:24.07436+00	692	Aisha Khan (Instagram)		88	1	3
1052	2024-12-17 13:03:24.077986+00	691	Carlos Rodriguez (Website)		88	1	3
1053	2024-12-17 13:03:24.081323+00	690	Carlos Rodriguez (Website)		88	1	3
1054	2024-12-17 13:03:24.084137+00	689	Fatima Al-Masri (LinkedIn)		88	1	3
1055	2024-12-17 13:03:24.086743+00	688	Carlos Rodriguez (Facebook)		88	1	3
1056	2024-12-17 13:03:24.095557+00	687	Chen Wei (Website)		88	1	3
1057	2024-12-17 13:03:24.098838+00	686	Aisha Khan (Website)		88	1	3
1058	2024-12-17 13:03:24.102063+00	685	Sophia Müller (Instagram)		88	1	3
1060	2024-12-17 13:03:24.108089+00	683	Hiroshi Tanaka (Facebook)		88	1	3
1061	2024-12-17 13:03:24.112522+00	682	Aisha Khan (Facebook)		88	1	3
1062	2024-12-17 13:03:24.115654+00	681	Ivan Petrov (Instagram)		88	1	3
1063	2024-12-17 13:03:24.118637+00	680	Fatima Al-Masri (LinkedIn)		88	1	3
1064	2024-12-17 13:03:24.121795+00	679	Liam O'Connor (Facebook)		88	1	3
1065	2024-12-17 13:03:24.125078+00	678	Fatima Al-Masri (Instagram)		88	1	3
1066	2024-12-17 13:03:24.12839+00	677	Fatima Al-Masri (Website)		88	1	3
1067	2024-12-17 13:03:24.131734+00	676	Amara Okafor (LinkedIn)		88	1	3
1068	2024-12-18 07:57:55.398147+00	121	<User:  LOTFIsds>		6	121	1
1069	2024-12-18 07:57:55.40424+00	128	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	121	1
1070	2024-12-18 07:57:55.408366+00	130	None with None		10	121	1
1071	2024-12-22 13:51:11.759073+00	848	Stoilka Spasova (fb)	[{"added": {}}]	88	1	1
1072	2024-12-22 13:51:35.585096+00	849	Лили Тенекева (fb)	[{"added": {}}]	88	1	1
1073	2024-12-22 13:51:55.673181+00	850	Цвета Манчорова\ttsweta@mail.bg (fb)	[{"added": {}}]	88	1	1
1074	2024-12-22 13:52:33.036818+00	850	Цвета Манчорова (fb)	[{"changed": {"fields": ["Name", "Country"]}}]	88	1	2
1075	2024-12-22 20:04:29.773514+00	851	Lotfi Kanouni (fb)	[{"added": {}}]	88	1	1
1076	2024-12-22 20:21:54.681467+00	851	Lotfi Kanouni (fb)	[]	88	1	2
1077	2024-12-22 20:28:15.705733+00	850	Цвета Манчорова (fb)	[{"changed": {"fields": ["Country"]}}]	88	1	2
1078	2024-12-22 20:28:44.765733+00	849	Лили Тенекева (fb)	[{"changed": {"fields": ["Country"]}}]	88	1	2
1079	2024-12-22 20:28:50.6331+00	848	Stoilka Spasova (fb)	[{"changed": {"fields": ["Country"]}}]	88	1	2
1080	2024-12-23 21:36:39.377414+00	852	Jean Claude Duran (fb)	[{"added": {}}]	88	122	1
1081	2024-12-23 21:37:10.566473+00	853	Nina Fulcheri (fb)	[{"added": {}}]	88	122	1
1082	2024-12-24 19:33:43.434114+00	123	<User:  Esteticium>		6	123	1
1083	2024-12-24 19:33:43.439347+00	129	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	123	1
1084	2024-12-24 19:33:43.443263+00	131	None with None		10	123	1
1085	2024-12-25 14:20:28.46282+00	862	Slavcho Asenov (fb)	new through import_export	88	1	1
1086	2024-12-25 14:20:28.479122+00	861	Иван Димитров (fb)	new through import_export	88	1	1
1087	2024-12-25 14:20:28.482711+00	860	Васка Младенова (fb)	new through import_export	88	1	1
1088	2024-12-25 14:20:28.486141+00	859	Марина Петкова (fb)	new through import_export	88	1	1
1089	2024-12-25 14:20:28.489371+00	858	Илиана Петкова (fb)	new through import_export	88	1	1
1090	2024-12-25 14:20:28.492825+00	857	Блага Туничева Туничева (fb)	new through import_export	88	1	1
1091	2024-12-25 14:20:28.496214+00	856	Ahou Julienne (fb)	new through import_export	88	1	1
1092	2024-12-25 14:20:28.500038+00	855	Marie Vandebroek (fb)	new through import_export	88	1	1
1093	2024-12-25 14:20:28.503203+00	854	Pierre Veschambre (fb)	new through import_export	88	1	1
1094	2024-12-25 14:20:28.506848+00	853	Nina Fulcheri (fb)	update through import_export	88	1	2
1095	2024-12-25 14:20:28.509851+00	852	Jean Claude Duran (fb)	update through import_export	88	1	2
1096	2024-12-25 14:20:28.512813+00	851	Lotfi Kanouni (fb)	update through import_export	88	1	2
1097	2024-12-25 14:20:28.515657+00	850	Цвета Манчорова (fb)	update through import_export	88	1	2
1098	2024-12-25 14:20:28.519005+00	849	Лили Тенекева (fb)	update through import_export	88	1	2
1099	2024-12-25 14:20:28.522317+00	848	Stoilka Spasova (fb)	update through import_export	88	1	2
1100	2024-12-25 14:20:28.525614+00	847	Ioannis Paterakis (fb)	update through import_export	88	1	2
1101	2024-12-25 14:20:28.528166+00	846	Martti Savikko (fb)	update through import_export	88	1	2
1102	2024-12-25 14:20:28.530454+00	845	Thomas Ntokas (fb)	update through import_export	88	1	2
1103	2024-12-25 14:20:28.532951+00	844	Antonio Henrique Simao (fb)	update through import_export	88	1	2
1104	2024-12-25 14:20:28.535683+00	843	Joaquim Celorico (fb)	update through import_export	88	1	2
1105	2024-12-25 14:20:28.539549+00	842	________ _______ (ig)	update through import_export	88	1	2
1106	2024-12-25 14:20:28.542801+00	841	Manel Kahavidana (fb)	update through import_export	88	1	2
1107	2024-12-25 14:20:28.545466+00	840	________ _____________ (fb)	update through import_export	88	1	2
1108	2024-12-25 14:20:28.547772+00	839	Jo‹o Maria d'Orey (fb)	update through import_export	88	1	2
1109	2024-12-25 14:20:28.55011+00	838	maria F‡tima  Caires entrada 43 port (fb)	update through import_export	88	1	2
1110	2024-12-25 14:20:28.55253+00	837	Vacca (fb)	update through import_export	88	1	2
1111	2024-12-25 14:20:28.554705+00	836	Kiki Kakli (fb)	update through import_export	88	1	2
1112	2024-12-25 14:20:28.556993+00	835	Stefan Sobotka (fb)	update through import_export	88	1	2
1113	2024-12-25 14:20:28.559433+00	834	e Filipe fomos uma gota de l’quido (fb)	update through import_export	88	1	2
1114	2024-12-25 14:20:28.561998+00	833	Daniel Roger (fb)	update through import_export	88	1	2
1115	2024-12-25 14:20:28.565767+00	832	Jorge Fonte (fb)	update through import_export	88	1	2
1116	2024-12-25 14:20:28.568376+00	831	Kaspars _t_ls (fb)	update through import_export	88	1	2
1117	2024-12-25 14:20:28.570686+00	830	Dariush Modelis (ig)	update through import_export	88	1	2
1118	2024-12-25 14:20:28.573276+00	829	Greg Santos (fb)	update through import_export	88	1	2
1119	2024-12-25 14:20:28.576092+00	828	Florinda  Maria do Ros‡rio Serra (fb)	update through import_export	88	1	2
1120	2024-12-25 14:20:28.578365+00	827	Denis Scott akwafei (fb)	update through import_export	88	1	2
1121	2024-12-25 14:20:28.580505+00	826	Dioma Girard (fb)	update through import_export	88	1	2
1122	2024-12-25 14:20:28.583242+00	825	Karin Loubser (fb)	update through import_export	88	1	2
1123	2024-12-25 14:20:28.586042+00	823	Nina Katsioloudi (fb)	update through import_export	88	1	2
1124	2024-12-25 14:20:28.588503+00	822	Joaquim Pop (fb)	update through import_export	88	1	2
1125	2024-12-25 14:20:28.590614+00	821	Jana Rozenberga (ig)	update through import_export	88	1	2
1126	2024-12-25 14:20:28.595062+00	820	Joaquim Carvalho (fb)	update through import_export	88	1	2
1127	2024-12-25 14:20:28.598138+00	819	Mohamed Aliu Embalo (fb)	update through import_export	88	1	2
1128	2024-12-25 14:20:28.600347+00	818	Maria Victoria Villegas (fb)	update through import_export	88	1	2
1129	2024-12-25 14:20:28.602803+00	817	Halide Mahmuto_lu (fb)	update through import_export	88	1	2
1130	2024-12-25 14:20:28.605126+00	816	Luc Nakken (fb)	update through import_export	88	1	2
1131	2024-12-25 14:20:28.607589+00	815	Yvett Dubnicka (fb)	update through import_export	88	1	2
1132	2024-12-25 14:20:28.610079+00	814	Manuel Filipe (fb)	update through import_export	88	1	2
1133	2024-12-25 14:20:28.612519+00	813	Helder Margarido (ig)	update through import_export	88	1	2
1134	2024-12-25 14:20:28.61474+00	812	more.ingormation (fb)	update through import_export	88	1	2
1135	2024-12-25 14:20:28.617195+00	811	Savvas Tsestos (fb)	update through import_export	88	1	2
1136	2024-12-25 14:20:28.619421+00	810	Savvas Tsestos (fb)	update through import_export	88	1	2
1137	2024-12-25 14:20:28.622205+00	809	Neacsu Viorica (fb)	update through import_export	88	1	2
1138	2024-12-25 14:20:28.62529+00	808	Jeana Dinu (fb)	update through import_export	88	1	2
1139	2024-12-25 14:20:28.627901+00	807	Ilie Craioveanu (fb)	update through import_export	88	1	2
1140	2024-12-25 14:20:28.630382+00	806	Ncei Mousavi (fb)	update through import_export	88	1	2
1141	2024-12-25 14:20:28.63294+00	805	Annette (Antoinette) Guerrera (fb)	update through import_export	88	1	2
1142	2024-12-25 14:20:28.635535+00	804	POPESCU CONSTANTINA (fb)	update through import_export	88	1	2
1143	2024-12-25 14:20:28.63801+00	803	Vacca (fb)	update through import_export	88	1	2
1144	2024-12-25 14:20:28.64056+00	802	_______ ______ (fb)	update through import_export	88	1	2
1145	2024-12-25 14:20:28.643156+00	801	m (fb)	update through import_export	88	1	2
1146	2024-12-25 14:20:28.645783+00	800	Michaela Argireanu-Ioanidi (fb)	update through import_export	88	1	2
1147	2024-12-25 14:20:28.648245+00	799	Crisan Petru Ionel (fb)	update through import_export	88	1	2
1148	2024-12-25 14:20:28.650654+00	798	Neculai Gorgovan (fb)	update through import_export	88	1	2
1149	2024-12-25 14:20:28.653099+00	797	Fadia haddad (ig)	update through import_export	88	1	2
1150	2024-12-25 14:20:28.655741+00	796	Shaukat Pervezs (fb)	update through import_export	88	1	2
1151	2024-12-25 14:20:28.658007+00	795	Gheorghe Zaporojan (fb)	update through import_export	88	1	2
1152	2024-12-25 14:20:28.660399+00	794	Constantin Bobai__ (fb)	update through import_export	88	1	2
1153	2024-12-25 14:20:28.663069+00	793	Carmela Della Ripa Bilotto (fb)	update through import_export	88	1	2
1154	2024-12-25 14:20:28.66584+00	792	Phindile Nxumalo (ig)	update through import_export	88	1	2
1155	2024-12-25 14:20:28.671067+00	791	MICHAEL CIRIC (fb)	update through import_export	88	1	2
1156	2024-12-25 14:20:28.673584+00	790	Mindru Cezar (fb)	update through import_export	88	1	2
1157	2024-12-25 14:20:28.676024+00	789	antonio di lauro (fb)	update through import_export	88	1	2
1158	2024-12-25 14:20:28.678697+00	788	Martina Tura (ig)	update through import_export	88	1	2
1159	2024-12-25 14:20:28.680996+00	787	Jana Rozenberga (ig)	update through import_export	88	1	2
1160	2024-12-25 14:20:28.683685+00	786	Joyce March (fb)	update through import_export	88	1	2
1161	2024-12-25 14:20:28.685915+00	785	Joe (fb)	update through import_export	88	1	2
1162	2024-12-25 14:20:28.688318+00	784	George Gawel (fb)	update through import_export	88	1	2
1163	2024-12-25 14:20:28.69079+00	783	Angela Liggins (fb)	update through import_export	88	1	2
1164	2024-12-25 14:20:28.69324+00	782	stone smyth (fb)	update through import_export	88	1	2
1165	2024-12-25 14:20:28.696021+00	781	Muaiao kiliona (fb)	update through import_export	88	1	2
1166	2024-12-25 14:20:28.698589+00	780	Jose Batist (fb)	update through import_export	88	1	2
1167	2024-12-25 14:20:28.700947+00	779	Janis E Bianucci (fb)	update through import_export	88	1	2
1168	2024-12-25 14:20:28.703709+00	778	menezes Candy (ig)	update through import_export	88	1	2
1169	2024-12-25 14:20:28.705851+00	777	Yousaf Khan (fb)	update through import_export	88	1	2
1170	2024-12-25 14:20:28.708293+00	776	jeanette ruffat (fb)	update through import_export	88	1	2
1171	2024-12-25 14:20:28.71079+00	775	Giulia Rossi (Facebook)	update through import_export	88	1	2
1172	2024-12-25 14:20:28.713379+00	774	Ivan Petrov (Facebook)	update through import_export	88	1	2
1173	2024-12-25 14:20:28.715836+00	773	Carlos Rodriguez (LinkedIn)	update through import_export	88	1	2
1174	2024-12-25 14:20:28.718347+00	772	Aisha Khan (LinkedIn)	update through import_export	88	1	2
1175	2024-12-25 14:20:28.720424+00	771	Hiroshi Tanaka (Facebook)	update through import_export	88	1	2
1176	2024-12-25 14:20:28.722652+00	770	Chen Wei (Website)	update through import_export	88	1	2
1177	2024-12-25 14:20:28.725255+00	769	Sven Johansson (Instagram)	update through import_export	88	1	2
1178	2024-12-25 14:20:28.727794+00	768	Chen Wei (LinkedIn)	update through import_export	88	1	2
1179	2024-12-25 14:20:28.730608+00	767	Amara Okafor (Instagram)	update through import_export	88	1	2
1180	2024-12-25 14:20:28.733129+00	766	Ivan Petrov (LinkedIn)	update through import_export	88	1	2
1181	2024-12-25 14:20:28.735544+00	765	Sven Johansson (Instagram)	update through import_export	88	1	2
1182	2024-12-25 14:20:28.738132+00	764	Sophia Müller (Instagram)	update through import_export	88	1	2
1183	2024-12-25 14:20:28.740876+00	763	Ivan Petrov (LinkedIn)	update through import_export	88	1	2
1184	2024-12-25 14:20:28.743871+00	762	Amara Okafor (Website)	update through import_export	88	1	2
1185	2024-12-25 14:20:28.74641+00	761	Sophia Müller (Facebook)	update through import_export	88	1	2
1186	2024-12-25 14:20:28.74901+00	760	Amara Okafor (Instagram)	update through import_export	88	1	2
1187	2024-12-25 14:20:28.751634+00	759	Hiroshi Tanaka (Facebook)	update through import_export	88	1	2
1188	2024-12-25 14:20:28.754359+00	758	Amara Okafor (LinkedIn)	update through import_export	88	1	2
1189	2024-12-25 14:20:28.75697+00	757	Carlos Rodriguez (LinkedIn)	update through import_export	88	1	2
1190	2024-12-25 14:20:28.759916+00	756	Ivan Petrov (Instagram)	update through import_export	88	1	2
1191	2024-12-25 14:20:28.762196+00	755	Aisha Khan (Instagram)	update through import_export	88	1	2
1192	2024-12-25 14:20:28.764895+00	754	Liam O'Connor (LinkedIn)	update through import_export	88	1	2
1193	2024-12-25 14:20:28.767404+00	753	Hiroshi Tanaka (Instagram)	update through import_export	88	1	2
1194	2024-12-25 14:20:28.770293+00	752	Carlos Rodriguez (Facebook)	update through import_export	88	1	2
1195	2024-12-25 14:20:28.772977+00	751	Liam O'Connor (Website)	update through import_export	88	1	2
1196	2024-12-25 14:20:28.775924+00	750	Aisha Khan (Instagram)	update through import_export	88	1	2
1197	2024-12-25 14:20:28.778323+00	749	Fatima Al-Masri (LinkedIn)	update through import_export	88	1	2
1198	2024-12-25 14:20:28.780587+00	748	Sven Johansson (Instagram)	update through import_export	88	1	2
1199	2024-12-29 13:57:30.514127+00	124	<User:  Kanouni>		6	124	1
1200	2024-12-29 13:57:30.519635+00	130	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	124	1
1201	2024-12-29 13:57:30.52287+00	132	None with None		10	124	1
1202	2024-12-29 14:04:38.650651+00	8	Treatment Plan for Kanouni Ali by Dr. Naci Canpolat	[{"added": {}}, {"added": {"name": "Treatment Plan Item", "object": "6 x BEGO Implant for Treatment Plan for Kanouni Ali by Dr. Naci Canpolat"}}, {"added": {"name": "Treatment Plan Item", "object": "20 x Zirconium Crowns with Titanium Bases for Treatment Plan for Kanouni Ali by Dr. Naci Canpolat"}}]	78	1	1
1203	2024-12-29 14:09:22.911648+00	125	<User:  Referebxe>		6	125	1
1204	2024-12-29 14:09:22.915368+00	131	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	125	1
1205	2024-12-29 14:09:22.91783+00	133	None with None		10	125	1
1206	2025-01-16 16:59:46.23662+00	126	<User:  lofa>		6	126	1
1207	2025-01-16 16:59:46.242816+00	132	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	126	1
1208	2025-01-16 16:59:46.246485+00	134	None with None		10	126	1
1209	2025-01-16 19:31:17.047306+00	127	<User:  Samuel >		6	127	1
1210	2025-01-16 19:31:17.051779+00	133	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	127	1
1211	2025-01-16 19:31:17.055555+00	135	None with None		10	127	1
1212	2025-01-21 00:20:01.959165+00	128	<User:  Mashok>		6	128	1
1213	2025-01-21 00:20:01.983406+00	134	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	128	1
1214	2025-01-21 00:20:01.987759+00	136	None with None		10	128	1
1215	2025-02-10 16:14:29.061071+00	129	<User:  LOTFIss>		6	129	1
1216	2025-02-10 16:14:29.067638+00	135	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	129	1
1217	2025-02-10 16:14:29.071019+00	137	None with None		10	129	1
1218	2025-02-10 16:21:52.3223+00	130	<User:  caleb >		6	130	1
1219	2025-02-10 16:21:52.329708+00	136	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	130	1
1220	2025-02-10 16:21:52.334841+00	138	None with None		10	130	1
1221	2025-02-21 17:38:36.079529+00	131	<User:  htEPktOjPN>		6	131	1
1222	2025-02-21 17:38:36.090976+00	137	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	131	1
1223	2025-02-21 17:38:36.093928+00	139	None with None		10	131	1
1224	2025-02-22 17:24:08.572786+00	132	<User:  gZCioecJEPuK>		6	132	1
1225	2025-02-22 17:24:08.581803+00	138	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	132	1
1226	2025-02-22 17:24:08.585903+00	140	None with None		10	132	1
1227	2025-02-23 11:18:05.417184+00	133	<User:  ORjByEnxfAwJ>		6	133	1
1228	2025-02-23 11:18:05.422222+00	139	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	133	1
1229	2025-02-23 11:18:05.424853+00	141	None with None		10	133	1
1230	2025-02-24 05:48:58.964713+00	134	<User:  hqlVcPiwopTR>		6	134	1
1231	2025-02-24 05:48:58.969544+00	140	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	134	1
1232	2025-02-24 05:48:58.971952+00	142	None with None		10	134	1
1233	2025-02-24 16:52:05.796653+00	130	 caleb	[{"changed": {"fields": ["Password", "First name", "Emergency Contact"]}}]	6	1	2
1234	2025-02-24 16:53:59.381659+00	135	<User:  test>		6	135	1
1235	2025-02-24 16:53:59.386903+00	141	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	135	1
1236	2025-02-24 16:53:59.390473+00	143	None with None		10	135	1
1237	2025-02-25 06:39:36.380892+00	136	<User:  AfMqiYUMv>		6	136	1
1238	2025-02-25 06:39:36.386747+00	142	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	136	1
1239	2025-02-25 06:39:36.389371+00	144	None with None		10	136	1
1240	2025-02-25 14:35:47.440138+00	137	<User:  Test 1>		6	137	1
1241	2025-02-25 14:35:47.44498+00	143	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	137	1
1242	2025-02-25 14:35:47.447447+00	145	None with None		10	137	1
1243	2025-02-26 07:29:33.952665+00	138	<User:  VcxBMDKIlmXn>		6	138	1
1244	2025-02-26 07:29:33.957193+00	144	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	138	1
1245	2025-02-26 07:29:33.961155+00	146	None with None		10	138	1
1246	2025-02-28 04:52:03.641776+00	139	<User:  yyHyVwMOJiCYox>		6	139	1
1247	2025-02-28 04:52:03.646294+00	145	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	139	1
1248	2025-02-28 04:52:03.655928+00	147	None with None		10	139	1
1249	2025-03-01 15:06:24.475929+00	140	<User:  YfCUJRpOBh>		6	140	1
1250	2025-03-01 15:06:24.481709+00	146	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	140	1
1251	2025-03-01 15:06:24.485998+00	148	None with None		10	140	1
1252	2025-03-02 10:34:31.587263+00	142	<User:  jJDPpAdSrZsl>		6	142	1
1253	2025-03-02 10:34:31.594082+00	148	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	142	1
1254	2025-03-02 10:34:31.596582+00	150	None with None		10	142	1
1255	2025-03-03 02:18:46.679799+00	143	<User:  nvFpukZNikGH>		6	143	1
1256	2025-03-03 02:18:46.687103+00	149	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	143	1
1257	2025-03-03 02:18:46.696708+00	151	None with None		10	143	1
1258	2025-03-04 03:07:52.938102+00	144	<User:  bSJfKUaQTCyoS>		6	144	1
1259	2025-03-04 03:07:52.9429+00	150	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	144	1
1260	2025-03-04 03:07:52.945478+00	152	None with None		10	144	1
1261	2025-03-05 04:18:41.944937+00	145	<User:  RvfeYKrWWbbqg>		6	145	1
1262	2025-03-05 04:18:41.950062+00	151	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	145	1
1263	2025-03-05 04:18:41.953117+00	153	None with None		10	145	1
1264	2025-03-06 05:58:26.230294+00	146	<User:  nYpRnmRSKmUOmoo>		6	146	1
1265	2025-03-06 05:58:26.235236+00	152	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	146	1
1266	2025-03-06 05:58:26.238341+00	154	None with None		10	146	1
1267	2025-03-08 08:23:45.647559+00	148	<User:  fuCAaksuVgrwUp>		6	148	1
1268	2025-03-08 08:23:45.655713+00	154	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	148	1
1269	2025-03-08 08:23:45.659817+00	156	None with None		10	148	1
1270	2025-03-09 05:19:13.540306+00	149	<User:  HpikYlTgUjDR>		6	149	1
1271	2025-03-09 05:19:13.544428+00	155	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	149	1
1272	2025-03-09 05:19:13.546861+00	157	None with None		10	149	1
1273	2025-03-09 22:40:09.466583+00	35	Kanal Temizlime	[{"changed": {"fields": ["Price"]}}]	79	1	2
1274	2025-03-09 22:40:18.905525+00	35	Kanal Temizlime	[]	79	1	2
1275	2025-03-09 23:13:35.112277+00	45	Zoom Bleaching	[{"changed": {"fields": ["Category", "Is Active"]}}]	79	1	2
1276	2025-03-09 23:14:07.217221+00	44	Bone Greft + PRF	[{"changed": {"fields": ["Is Active"]}}]	79	1	2
1277	2025-03-09 23:14:41.972563+00	43	Sinus Lift + Greft Membran	[{"changed": {"fields": ["Is Active"]}}]	79	1	2
1278	2025-03-09 23:15:18.689234+00	41	RAMUS	[{"changed": {"fields": ["Is Active"]}}]	79	1	2
1279	2025-03-09 23:16:21.7748+00	40	PRF	[{"changed": {"fields": ["Is Active"]}}]	79	1	2
1280	2025-03-09 23:19:02.812269+00	41	RAMUS	[]	79	1	2
1281	2025-03-09 23:19:40.857172+00	39	PMMA	[{"changed": {"fields": ["Category", "Is Active"]}}]	79	1	2
1282	2025-03-09 23:19:53.243184+00	38	Kist Temizleme	[{"changed": {"fields": ["Is Active"]}}]	79	1	2
1283	2025-03-09 23:20:14.118556+00	34	Kan Test	[{"changed": {"fields": ["Category", "Is Active"]}}]	79	1	2
1284	2025-03-09 23:20:40.113148+00	33	HIV	[{"changed": {"fields": ["Category", "Is Active"]}}]	79	1	2
1285	2025-03-10 13:34:00.871707+00	13	Zirconium Crowns	[{"changed": {"fields": ["Price"]}}]	79	1	2
1286	2025-03-10 16:19:04.997859+00	151	<User:  ukRQfTwEJBX>		6	151	1
1287	2025-03-10 16:19:05.001914+00	157	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	151	1
1288	2025-03-10 16:19:05.004265+00	159	None with None		10	151	1
1289	2025-03-12 12:35:07.476028+00	152	<User:  AAhpzNnYEvLU>		6	152	1
1290	2025-03-12 12:35:07.481036+00	158	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	152	1
1291	2025-03-12 12:35:07.483817+00	160	None with None		10	152	1
1292	2025-03-13 21:12:41.028208+00	153	<User:  QJwcJIOmd>		6	153	1
1293	2025-03-13 21:12:41.033257+00	159	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	153	1
1294	2025-03-13 21:12:41.035906+00	161	None with None		10	153	1
1295	2025-03-14 20:11:33.134641+00	154	<User:  aKCLyuOXEIBIRrM>		6	154	1
1296	2025-03-14 20:11:33.147944+00	160	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	154	1
1297	2025-03-14 20:11:33.151008+00	162	None with None		10	154	1
1298	2025-03-15 15:08:14.957519+00	155	<User:  bgAsjnfHjODRnG>		6	155	1
1299	2025-03-15 15:08:14.965854+00	161	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	155	1
1300	2025-03-15 15:08:14.968842+00	163	None with None		10	155	1
1301	2025-03-16 09:31:22.137055+00	156	<User:  QzCLECEHWTvxQr>		6	156	1
1302	2025-03-16 09:31:22.141296+00	162	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	156	1
1303	2025-03-16 09:31:22.143587+00	164	None with None		10	156	1
1304	2025-03-17 04:08:57.307123+00	157	<User:  kRBmmwSnEKHsGY>		6	157	1
1305	2025-03-17 04:08:57.311872+00	163	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	157	1
1306	2025-03-17 04:08:57.314938+00	165	None with None		10	157	1
1307	2025-03-17 12:58:56.60355+00	158	<User:  Apple Inc. 2025. All rights reserved. Apple Inc. 2025. All rights reserved.\r\n 3737119 https://t.me/ grandbooksommer !>		6	158	1
1308	2025-03-17 12:58:56.617689+00	164	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	158	1
1309	2025-03-17 12:58:56.620674+00	166	None with None		10	158	1
1310	2025-03-18 10:46:26.684409+00	159	<User:  beMOTbmxQq>		6	159	1
1311	2025-03-18 10:46:26.688925+00	165	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	159	1
1312	2025-03-18 10:46:26.691713+00	167	None with None		10	159	1
1313	2025-03-19 20:12:27.013768+00	160	<User:  mDjHwLYQH>		6	160	1
1314	2025-03-19 20:12:27.018402+00	166	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	160	1
1315	2025-03-19 20:12:27.020811+00	168	None with None		10	160	1
1316	2025-03-21 06:14:41.085688+00	161	<User:  bPHGhfKQuQxVHVL>		6	161	1
1317	2025-03-21 06:14:41.090105+00	167	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	161	1
1318	2025-03-21 06:14:41.092696+00	169	None with None		10	161	1
1319	2025-03-21 22:38:16.537412+00	162	<User:  kOUzziYpgY>		6	162	1
1320	2025-03-21 22:38:16.541922+00	168	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	162	1
1321	2025-03-21 22:38:16.545063+00	170	None with None		10	162	1
1322	2025-03-22 12:24:29.66341+00	163	<User:  gOFHtPIOoj>		6	163	1
1323	2025-03-22 12:24:29.668846+00	169	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	163	1
1324	2025-03-22 12:24:29.671628+00	171	None with None		10	163	1
1325	2025-03-23 18:46:27.886382+00	164	<User:  WwCiBVAT>		6	164	1
1326	2025-03-23 18:46:27.890743+00	170	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	164	1
1327	2025-03-23 18:46:27.894031+00	172	None with None		10	164	1
1328	2025-03-24 12:10:35.602046+00	165	<User:  iIvqXnGmFtw>		6	165	1
1329	2025-03-24 12:10:35.606009+00	171	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	165	1
1330	2025-03-24 12:10:35.608739+00	173	None with None		10	165	1
1331	2025-03-25 16:47:30.149851+00	166	<User:  HskWcSLuoS>		6	166	1
1332	2025-03-25 16:47:30.153814+00	172	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	166	1
1333	2025-03-25 16:47:30.156263+00	174	None with None		10	166	1
1334	2025-03-26 00:40:37.805809+00	167	<User:  mzknbDcKQjR>		6	167	1
1335	2025-03-26 00:40:37.810135+00	173	Sex: None, Insurance: None with None, Medications: None, Allergies: None, Medical Conditions: None, Family History: None, Additional Info: None		15	167	1
1336	2025-03-26 00:40:37.812696+00	175	None with None		10	167	1
\.


--
-- Data for Name: django_celery_results_chordcounter; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_celery_results_chordcounter (id, sub_tasks, count, group_id) FROM stdin;
\.


--
-- Data for Name: django_celery_results_groupresult; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_celery_results_groupresult (id, group_id, date_created, date_done, content_type, content_encoding, result) FROM stdin;
\.


--
-- Data for Name: django_celery_results_taskresult; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_celery_results_taskresult (id, task_id, status, content_type, content_encoding, result, date_done, traceback, meta, task_args, task_kwargs, task_name, date_created, worker, periodic_task_name) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	apps	user
7	apps	contact
8	apps	emergencycontact
9	apps	hospital
10	apps	insurance
11	apps	subscription
12	apps	prescription
13	apps	messagegroup
14	apps	message
15	apps	medicalinformation
16	apps	hospitalstay
17	apps	appointment
19	apps	referral
20	django_celery_results	taskresult
21	django_celery_results	chordcounter
22	django_celery_results	groupresult
23	django_openai_assistant	openaitask
24	blog	profile
25	blog	image
26	blog	comments
27	gram	comments
28	gram	image
29	gram	profile
30	sites	site
31	account	emailaddress
32	account	emailconfirmation
33	socialaccount	socialaccount
34	socialaccount	socialapp
35	socialaccount	socialtoken
36	apps	emailtemplate
37	wagtailcore	page
38	wagtailadmin	admin
39	wagtailcore	groupapprovaltask
40	wagtailcore	locale
41	wagtailcore	site
42	wagtailcore	modellogentry
43	wagtailcore	collectionviewrestriction
44	wagtailcore	collection
45	wagtailcore	groupcollectionpermission
46	wagtailcore	uploadedfile
47	wagtailcore	referenceindex
48	wagtailcore	revision
49	wagtailcore	grouppagepermission
50	wagtailcore	pageviewrestriction
51	wagtailcore	workflowpage
52	wagtailcore	workflowcontenttype
53	wagtailcore	workflowtask
54	wagtailcore	task
55	wagtailcore	workflow
56	wagtailcore	workflowstate
57	wagtailcore	taskstate
58	wagtailcore	pagelogentry
59	wagtailcore	comment
60	wagtailcore	commentreply
61	wagtailcore	pagesubscription
62	wagtaildocs	document
63	wagtailimages	image
64	wagtailforms	formsubmission
65	wagtailredirects	redirect
66	wagtailembeds	embed
67	wagtailusers	userprofile
68	wagtailimages	rendition
69	wagtailsearch	indexentry
71	wagtailadmin	editingsession
72	taggit	tag
73	taggit	taggeditem
74	apps	homepage
75	actstream	action
76	actstream	follow
77	apps	treatmentplanitem
78	apps	treatmentplan
79	apps	treatmentproduct
80	apps	medicalfile
81	apps	patientschedule
82	apps	flightreservation
83	apps	accommodation
84	apps	hotel
85	baton	batontheme
86	authtoken	token
87	authtoken	tokenproxy
88	leads	lead
89	leads	leadhistory
90	leads	note
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2024-07-13 21:35:42.49815+00
2	contenttypes	0002_remove_content_type_name	2024-07-13 21:35:42.524531+00
3	auth	0001_initial	2024-07-13 21:35:42.545123+00
4	auth	0002_alter_permission_name_max_length	2024-07-13 21:35:42.563254+00
5	auth	0003_alter_user_email_max_length	2024-07-13 21:35:42.577622+00
6	auth	0004_alter_user_username_opts	2024-07-13 21:35:42.591568+00
7	auth	0005_alter_user_last_login_null	2024-07-13 21:35:42.609082+00
8	auth	0006_require_contenttypes_0002	2024-07-13 21:35:42.622184+00
9	auth	0007_alter_validators_add_error_messages	2024-07-13 21:35:42.642145+00
10	auth	0008_alter_user_username_max_length	2024-07-13 21:35:42.658653+00
11	auth	0009_alter_user_last_name_max_length	2024-07-13 21:35:42.671725+00
12	auth	0010_alter_group_name_max_length	2024-07-13 21:35:42.689405+00
13	auth	0011_update_proxy_permissions	2024-07-13 21:35:42.703142+00
14	apps	0001_initial	2024-07-13 21:35:42.767196+00
15	admin	0001_initial	2024-07-13 21:35:42.790442+00
16	admin	0002_logentry_remove_auto_add	2024-07-13 21:35:42.811472+00
17	admin	0003_logentry_add_action_flag_choices	2024-07-13 21:35:42.834667+00
18	sessions	0001_initial	2024-07-13 21:35:42.84767+00
19	apps	0002_auto_20240719_0351	2024-07-19 00:51:25.60308+00
20	apps	0003_alter_user_first_name	2024-07-19 05:06:46.218475+00
21	auth	0012_alter_user_first_name_max_length	2024-07-19 05:06:46.244474+00
22	apps	0004_alter_appointment_id_alter_contact_id_and_more	2024-07-19 05:27:43.207982+00
23	apps	0005_medicalinformation_uploaded_files	2024-07-20 15:08:31.665575+00
24	apps	0006_uploadedfile_and_more	2024-07-20 17:16:07.182779+00
25	apps	0007_remove_medicalinformation_uploaded_files_and_more	2024-07-20 17:57:22.152622+00
26	apps	0008_alter_insurance_policy_number	2024-07-20 19:49:33.566958+00
27	apps	0009_alter_insurance_company	2024-07-20 19:58:27.554844+00
28	apps	0010_alter_medicalinformation_sex	2024-07-20 20:00:45.23124+00
29	apps	0011_user_referral_code_user_referred_by_referral	2024-07-21 04:14:39.611614+00
30	apps	0012_alter_user_referred_by	2024-07-21 04:54:32.263225+00
31	apps	0013_referral_referred_alter_user_referred_by	2024-07-21 06:06:54.139664+00
32	apps	0014_alter_referral_code_alter_referral_unique_together	2024-07-21 06:33:36.345551+00
33	apps	0015_alter_referral_unique_together_and_more	2024-07-21 06:59:30.110555+00
34	apps	0016_remove_contact_phone	2024-07-21 17:13:18.866286+00
35	django_celery_results	0001_initial	2024-07-26 02:28:44.85855+00
36	django_celery_results	0002_add_task_name_args_kwargs	2024-07-26 02:28:44.883605+00
37	django_celery_results	0003_auto_20181106_1101	2024-07-26 02:28:44.896593+00
38	django_celery_results	0004_auto_20190516_0412	2024-07-26 02:28:44.944505+00
39	django_celery_results	0005_taskresult_worker	2024-07-26 02:28:44.968516+00
40	django_celery_results	0006_taskresult_date_created	2024-07-26 02:28:45.004673+00
41	django_celery_results	0007_remove_taskresult_hidden	2024-07-26 02:28:45.024303+00
42	django_celery_results	0008_chordcounter	2024-07-26 02:28:45.043959+00
43	django_celery_results	0009_groupresult	2024-07-26 02:28:45.104585+00
44	django_celery_results	0010_remove_duplicate_indices	2024-07-26 02:28:45.119419+00
45	django_celery_results	0011_taskresult_periodic_task_name	2024-07-26 02:28:45.13588+00
46	django_openai_assistant	0001_initial	2024-07-26 10:35:28.671211+00
47	apps	0017_user_thread_id	2024-07-26 16:22:56.618556+00
48	apps	0018_user_beyondblog_profileid	2024-07-30 00:45:50.520336+00
49	blog	0001_initial	2024-07-30 00:45:50.598065+00
50	gram	0001_initial	2024-07-30 04:12:04.993175+00
51	gram	0002_auto_20180726_1315	2024-07-30 04:12:05.091577+00
52	gram	0003_auto_20180726_1450	2024-07-30 04:12:05.178579+00
53	gram	0004_alter_comments_id_alter_image_id_alter_profile_id	2024-07-30 04:12:05.229534+00
54	gram	0005_rename_user_profile_user_and_more	2024-07-30 04:12:05.267599+00
55	gram	0005_auto_20240730_0934	2024-07-30 06:34:34.371939+00
56	account	0001_initial	2024-08-06 02:15:42.092521+00
57	account	0002_email_max_length	2024-08-06 02:15:42.122857+00
58	account	0003_alter_emailaddress_create_unique_verified_email	2024-08-06 02:15:42.160972+00
59	account	0004_alter_emailaddress_drop_unique_email	2024-08-06 02:15:42.192629+00
60	account	0005_emailaddress_idx_upper_email	2024-08-06 02:15:42.215815+00
61	account	0006_emailaddress_lower	2024-08-06 02:15:42.246166+00
62	account	0007_emailaddress_idx_email	2024-08-06 02:15:42.289285+00
63	account	0008_emailaddress_unique_primary_email_fixup	2024-08-06 02:15:42.316276+00
64	account	0009_emailaddress_unique_primary_email	2024-08-06 02:15:42.342896+00
65	sites	0001_initial	2024-08-06 02:15:42.365033+00
66	sites	0002_alter_domain_unique	2024-08-06 02:15:42.384437+00
67	socialaccount	0001_initial	2024-08-06 02:15:42.457007+00
68	socialaccount	0002_token_max_lengths	2024-08-06 02:15:42.502298+00
69	socialaccount	0003_extra_data_default_dict	2024-08-06 02:15:42.523671+00
70	socialaccount	0004_app_provider_id_settings	2024-08-06 02:15:42.568468+00
71	socialaccount	0005_socialtoken_nullable_app	2024-08-06 02:15:42.611228+00
72	socialaccount	0006_alter_socialaccount_extra_data	2024-08-06 02:15:42.653367+00
73	apps	0019_emailtemplate	2024-08-06 11:05:25.374402+00
74	apps	0020_user_is_online_user_last_login_time_and_more	2024-08-18 03:12:14.219263+00
75	jet_django	0001_initial	2024-08-18 07:01:09.601189+00
76	jet_django	0002_auto_20181014_2002	2024-08-18 07:01:09.675759+00
77	jet_django	0003_auto_20191007_2005	2024-08-18 07:01:09.703834+00
78	jet_django	0004_delete_token	2024-08-18 07:03:46.443102+00
79	taggit	0001_initial	2024-08-18 07:16:39.455085+00
80	taggit	0002_auto_20150616_2121	2024-08-18 07:16:39.475281+00
81	taggit	0003_taggeditem_add_unique_index	2024-08-18 07:16:39.497804+00
82	taggit	0004_alter_taggeditem_content_type_alter_taggeditem_tag	2024-08-18 07:16:39.54565+00
83	taggit	0005_auto_20220424_2025	2024-08-18 07:16:39.56757+00
84	taggit	0006_rename_taggeditem_content_type_object_id_taggit_tagg_content_8fc721_idx	2024-08-18 07:16:39.598341+00
85	wagtailcore	0001_initial	2024-08-18 07:16:39.831455+00
86	wagtailcore	0002_initial_data	2024-08-18 07:16:39.841643+00
87	wagtailcore	0003_add_uniqueness_constraint_on_group_page_permission	2024-08-18 07:16:39.852529+00
88	wagtailcore	0004_page_locked	2024-08-18 07:16:39.862181+00
89	wagtailcore	0005_add_page_lock_permission_to_moderators	2024-08-18 07:16:39.872834+00
90	wagtailcore	0006_add_lock_page_permission	2024-08-18 07:16:39.883341+00
91	wagtailcore	0007_page_latest_revision_created_at	2024-08-18 07:16:39.892612+00
92	wagtailcore	0008_populate_latest_revision_created_at	2024-08-18 07:16:39.901606+00
93	wagtailcore	0009_remove_auto_now_add_from_pagerevision_created_at	2024-08-18 07:16:39.910972+00
94	wagtailcore	0010_change_page_owner_to_null_on_delete	2024-08-18 07:16:39.921011+00
95	wagtailcore	0011_page_first_published_at	2024-08-18 07:16:39.93015+00
96	wagtailcore	0012_extend_page_slug_field	2024-08-18 07:16:39.939266+00
97	wagtailcore	0013_update_golive_expire_help_text	2024-08-18 07:16:39.948265+00
98	wagtailcore	0014_add_verbose_name	2024-08-18 07:16:39.957495+00
99	wagtailcore	0015_add_more_verbose_names	2024-08-18 07:16:39.96751+00
100	wagtailcore	0016_change_page_url_path_to_text_field	2024-08-18 07:16:39.976767+00
101	wagtailcore	0017_change_edit_page_permission_description	2024-08-18 07:16:39.994875+00
102	wagtailcore	0018_pagerevision_submitted_for_moderation_index	2024-08-18 07:16:40.034393+00
103	wagtailcore	0019_verbose_names_cleanup	2024-08-18 07:16:40.105381+00
104	wagtailcore	0020_add_index_on_page_first_published_at	2024-08-18 07:16:40.146474+00
105	wagtailcore	0021_capitalizeverbose	2024-08-18 07:16:40.626336+00
106	wagtailcore	0022_add_site_name	2024-08-18 07:16:40.656868+00
107	wagtailcore	0023_alter_page_revision_on_delete_behaviour	2024-08-18 07:16:40.689323+00
108	wagtailcore	0024_collection	2024-08-18 07:16:40.706086+00
109	wagtailcore	0025_collection_initial_data	2024-08-18 07:16:40.741854+00
110	wagtailcore	0026_group_collection_permission	2024-08-18 07:16:40.794261+00
111	wagtailadmin	0001_create_admin_access_permissions	2024-08-18 07:16:40.833934+00
112	wagtailadmin	0002_admin	2024-08-18 07:16:40.845659+00
113	wagtailadmin	0003_admin_managed	2024-08-18 07:16:40.86084+00
114	wagtailadmin	0004_editingsession	2024-08-18 07:16:40.904049+00
115	wagtailadmin	0005_editingsession_is_editing	2024-08-18 07:16:40.943257+00
116	wagtailcore	0027_fix_collection_path_collation	2024-08-18 07:16:40.981416+00
117	wagtailcore	0024_alter_page_content_type_on_delete_behaviour	2024-08-18 07:16:41.013518+00
118	wagtailcore	0028_merge	2024-08-18 07:16:41.024914+00
119	wagtailcore	0029_unicode_slugfield_dj19	2024-08-18 07:16:41.063186+00
120	wagtailcore	0030_index_on_pagerevision_created_at	2024-08-18 07:16:41.167837+00
121	wagtailcore	0031_add_page_view_restriction_types	2024-08-18 07:16:41.22699+00
122	wagtailcore	0032_add_bulk_delete_page_permission	2024-08-18 07:16:41.248447+00
123	wagtailcore	0033_remove_golive_expiry_help_text	2024-08-18 07:16:41.30571+00
124	wagtailcore	0034_page_live_revision	2024-08-18 07:16:41.35885+00
125	wagtailcore	0035_page_last_published_at	2024-08-18 07:16:41.389905+00
126	wagtailcore	0036_populate_page_last_published_at	2024-08-18 07:16:41.432337+00
127	wagtailcore	0037_set_page_owner_editable	2024-08-18 07:16:41.471731+00
128	wagtailcore	0038_make_first_published_at_editable	2024-08-18 07:16:41.512746+00
129	wagtailcore	0039_collectionviewrestriction	2024-08-18 07:16:41.590527+00
130	wagtailcore	0040_page_draft_title	2024-08-18 07:16:41.650872+00
131	wagtailcore	0041_group_collection_permissions_verbose_name_plural	2024-08-18 07:16:41.673058+00
132	wagtailcore	0042_index_on_pagerevision_approved_go_live_at	2024-08-18 07:16:41.712967+00
133	wagtailcore	0043_lock_fields	2024-08-18 07:16:41.777542+00
134	wagtailcore	0044_add_unlock_grouppagepermission	2024-08-18 07:16:41.797014+00
135	wagtailcore	0045_assign_unlock_grouppagepermission	2024-08-18 07:16:41.835164+00
136	wagtailcore	0046_site_name_remove_null	2024-08-18 07:16:41.86455+00
137	wagtailcore	0047_add_workflow_models	2024-08-18 07:16:42.167168+00
138	wagtailcore	0048_add_default_workflows	2024-08-18 07:16:42.230858+00
139	wagtailcore	0049_taskstate_finished_by	2024-08-18 07:16:42.284599+00
140	wagtailcore	0050_workflow_rejected_to_needs_changes	2024-08-18 07:16:42.373522+00
141	wagtailcore	0051_taskstate_comment	2024-08-18 07:16:42.417756+00
142	wagtailcore	0052_pagelogentry	2024-08-18 07:16:42.482897+00
143	wagtailcore	0053_locale_model	2024-08-18 07:16:42.498932+00
144	wagtailcore	0054_initial_locale	2024-08-18 07:16:42.615188+00
145	wagtailcore	0055_page_locale_fields	2024-08-18 07:16:42.70918+00
146	wagtailcore	0056_page_locale_fields_populate	2024-08-18 07:16:42.754369+00
147	wagtailcore	0057_page_locale_fields_notnull	2024-08-18 07:16:42.836922+00
148	wagtailcore	0058_page_alias_of	2024-08-18 07:16:42.888374+00
149	wagtailcore	0059_apply_collection_ordering	2024-08-18 07:16:42.929302+00
150	wagtailcore	0060_fix_workflow_unique_constraint	2024-08-18 07:16:42.994856+00
151	wagtailcore	0061_change_promote_tab_helpt_text_and_verbose_names	2024-08-18 07:16:43.04892+00
152	wagtailcore	0062_comment_models_and_pagesubscription	2024-08-18 07:16:43.234042+00
153	wagtailcore	0063_modellogentry	2024-08-18 07:16:43.286948+00
154	wagtailcore	0064_log_timestamp_indexes	2024-08-18 07:16:43.358112+00
155	wagtailcore	0065_log_entry_uuid	2024-08-18 07:16:43.414225+00
156	wagtailcore	0066_collection_management_permissions	2024-08-18 07:16:43.459113+00
157	wagtailcore	0067_alter_pagerevision_content_json	2024-08-18 07:16:43.53879+00
158	wagtailcore	0068_log_entry_empty_object	2024-08-18 07:16:43.579686+00
159	wagtailcore	0069_log_entry_jsonfield	2024-08-18 07:16:43.7176+00
160	wagtailcore	0070_rename_pagerevision_revision	2024-08-18 07:16:44.422568+00
161	wagtailcore	0071_populate_revision_content_type	2024-08-18 07:16:44.464613+00
162	wagtailcore	0072_alter_revision_content_type_notnull	2024-08-18 07:16:44.557339+00
163	wagtailcore	0073_page_latest_revision	2024-08-18 07:16:44.609075+00
164	wagtailcore	0074_revision_object_str	2024-08-18 07:16:44.72843+00
165	wagtailcore	0075_populate_latest_revision_and_revision_object_str	2024-08-18 07:16:44.804823+00
166	wagtailcore	0076_modellogentry_revision	2024-08-18 07:16:44.882316+00
167	wagtailcore	0077_alter_revision_user	2024-08-18 07:16:44.932593+00
168	wagtailcore	0078_referenceindex	2024-08-18 07:16:45.006135+00
169	wagtailcore	0079_rename_taskstate_page_revision	2024-08-18 07:16:45.058444+00
170	wagtailcore	0080_generic_workflowstate	2024-08-18 07:16:45.373873+00
171	wagtailcore	0081_populate_workflowstate_content_type	2024-08-18 07:16:45.423696+00
172	wagtailcore	0082_alter_workflowstate_content_type_notnull	2024-08-18 07:16:45.56126+00
173	wagtailcore	0083_workflowcontenttype	2024-08-18 07:16:45.627428+00
174	wagtailcore	0084_add_default_page_permissions	2024-08-18 07:16:45.678647+00
175	wagtailcore	0085_add_grouppagepermission_permission	2024-08-18 07:16:45.759016+00
176	wagtailcore	0086_populate_grouppagepermission_permission	2024-08-18 07:16:45.864632+00
177	wagtailcore	0087_alter_grouppagepermission_unique_together_and_more	2024-08-18 07:16:45.984668+00
178	wagtailcore	0088_fix_log_entry_json_timestamps	2024-08-18 07:16:46.156867+00
179	wagtailcore	0089_log_entry_data_json_null_to_object	2024-08-18 07:16:46.201691+00
180	wagtailcore	0090_remove_grouppagepermission_permission_type	2024-08-18 07:16:46.332907+00
181	wagtailcore	0091_remove_revision_submitted_for_moderation	2024-08-18 07:16:46.39961+00
290	authtoken	0001_initial	2024-12-13 10:19:21.491398+00
182	wagtailcore	0092_alter_collectionviewrestriction_password_and_more	2024-08-18 07:16:46.466471+00
183	wagtailcore	0093_uploadedfile	2024-08-18 07:16:46.525209+00
184	wagtailcore	0094_alter_page_locale	2024-08-18 07:16:46.571072+00
185	wagtaildocs	0001_initial	2024-08-18 07:16:46.629002+00
186	wagtaildocs	0002_initial_data	2024-08-18 07:16:46.679945+00
187	wagtaildocs	0003_add_verbose_names	2024-08-18 07:16:46.894728+00
188	wagtaildocs	0004_capitalizeverbose	2024-08-18 07:16:47.078322+00
189	wagtaildocs	0005_document_collection	2024-08-18 07:16:47.137488+00
190	wagtaildocs	0006_copy_document_permissions_to_collections	2024-08-18 07:16:47.194365+00
191	wagtaildocs	0005_alter_uploaded_by_user_on_delete_action	2024-08-18 07:16:47.243804+00
192	wagtaildocs	0007_merge	2024-08-18 07:16:47.254938+00
193	wagtaildocs	0008_document_file_size	2024-08-18 07:16:47.302079+00
194	wagtaildocs	0009_document_verbose_name_plural	2024-08-18 07:16:47.338174+00
195	wagtaildocs	0010_document_file_hash	2024-08-18 07:16:47.467336+00
196	wagtaildocs	0011_add_choose_permissions	2024-08-18 07:16:47.583109+00
197	wagtaildocs	0012_uploadeddocument	2024-08-18 07:16:47.639274+00
198	wagtaildocs	0013_delete_uploadeddocument	2024-08-18 07:16:47.652278+00
199	wagtailembeds	0001_initial	2024-08-18 07:16:47.671279+00
200	wagtailembeds	0002_add_verbose_names	2024-08-18 07:16:47.683409+00
201	wagtailembeds	0003_capitalizeverbose	2024-08-18 07:16:47.73012+00
202	wagtailembeds	0004_embed_verbose_name_plural	2024-08-18 07:16:47.748507+00
203	wagtailembeds	0005_specify_thumbnail_url_max_length	2024-08-18 07:16:47.779508+00
204	wagtailembeds	0006_add_embed_hash	2024-08-18 07:16:47.805358+00
205	wagtailembeds	0007_populate_hash	2024-08-18 07:16:47.854243+00
206	wagtailembeds	0008_allow_long_urls	2024-08-18 07:16:47.917374+00
207	wagtailembeds	0009_embed_cache_until	2024-08-18 07:16:47.947041+00
208	wagtailforms	0001_initial	2024-08-18 07:16:48.007675+00
209	wagtailforms	0002_add_verbose_names	2024-08-18 07:16:48.044052+00
210	wagtailforms	0003_capitalizeverbose	2024-08-18 07:16:48.084104+00
211	wagtailforms	0004_add_verbose_name_plural	2024-08-18 07:16:48.110137+00
212	wagtailforms	0005_alter_formsubmission_form_data	2024-08-18 07:16:48.150736+00
213	wagtailimages	0001_initial	2024-08-18 07:16:48.390032+00
214	wagtailimages	0002_initial_data	2024-08-18 07:16:48.399409+00
215	wagtailimages	0003_fix_focal_point_fields	2024-08-18 07:16:48.408411+00
216	wagtailimages	0004_make_focal_point_key_not_nullable	2024-08-18 07:16:48.420443+00
217	wagtailimages	0005_make_filter_spec_unique	2024-08-18 07:16:48.43115+00
218	wagtailimages	0006_add_verbose_names	2024-08-18 07:16:48.441137+00
219	wagtailimages	0007_image_file_size	2024-08-18 07:16:48.453844+00
220	wagtailimages	0008_image_created_at_index	2024-08-18 07:16:48.463058+00
221	wagtailimages	0009_capitalizeverbose	2024-08-18 07:16:48.471699+00
222	wagtailimages	0010_change_on_delete_behaviour	2024-08-18 07:16:48.481995+00
223	wagtailimages	0011_image_collection	2024-08-18 07:16:48.490603+00
224	wagtailimages	0012_copy_image_permissions_to_collections	2024-08-18 07:16:48.499585+00
225	wagtailimages	0013_make_rendition_upload_callable	2024-08-18 07:16:48.510197+00
226	wagtailimages	0014_add_filter_spec_field	2024-08-18 07:16:48.519206+00
227	wagtailimages	0015_fill_filter_spec_field	2024-08-18 07:16:48.528602+00
228	wagtailimages	0016_deprecate_rendition_filter_relation	2024-08-18 07:16:48.537609+00
229	wagtailimages	0017_reduce_focal_point_key_max_length	2024-08-18 07:16:48.546326+00
230	wagtailimages	0018_remove_rendition_filter	2024-08-18 07:16:48.556313+00
231	wagtailimages	0019_delete_filter	2024-08-18 07:16:48.565291+00
232	wagtailimages	0020_add-verbose-name	2024-08-18 07:16:48.57429+00
233	wagtailimages	0021_image_file_hash	2024-08-18 07:16:48.586994+00
234	wagtailimages	0022_uploadedimage	2024-08-18 07:16:48.644648+00
235	wagtailimages	0023_add_choose_permissions	2024-08-18 07:16:48.776469+00
236	wagtailimages	0024_index_image_file_hash	2024-08-18 07:16:48.830365+00
237	wagtailimages	0025_alter_image_file_alter_rendition_file	2024-08-18 07:16:48.898142+00
238	wagtailimages	0026_delete_uploadedimage	2024-08-18 07:16:48.911047+00
239	wagtailredirects	0001_initial	2024-08-18 07:16:48.973451+00
240	wagtailredirects	0002_add_verbose_names	2024-08-18 07:16:49.033572+00
241	wagtailredirects	0003_make_site_field_editable	2024-08-18 07:16:49.149744+00
242	wagtailredirects	0004_set_unique_on_path_and_site	2024-08-18 07:16:49.197557+00
243	wagtailredirects	0005_capitalizeverbose	2024-08-18 07:16:49.325006+00
244	wagtailredirects	0006_redirect_increase_max_length	2024-08-18 07:16:49.361476+00
245	wagtailredirects	0007_add_autocreate_fields	2024-08-18 07:16:49.440223+00
246	wagtailredirects	0008_add_verbose_name_plural	2024-08-18 07:16:49.463505+00
247	wagtailsearch	0001_initial	2024-08-18 07:16:49.563029+00
248	wagtailsearch	0002_add_verbose_names	2024-08-18 07:16:49.640889+00
249	wagtailsearch	0003_remove_editors_pick	2024-08-18 07:16:49.65423+00
250	wagtailsearch	0004_querydailyhits_verbose_name_plural	2024-08-18 07:16:49.66824+00
251	wagtailsearch	0005_create_indexentry	2024-08-18 07:16:49.807712+00
252	wagtailsearch	0006_customise_indexentry	2024-08-18 07:16:49.916718+00
253	wagtailsearch	0007_delete_editorspick	2024-08-18 07:16:49.93084+00
254	wagtailsearch	0008_remove_query_and_querydailyhits_models	2024-08-18 07:16:49.966198+00
255	wagtailusers	0001_initial	2024-08-18 07:16:50.027719+00
256	wagtailusers	0002_add_verbose_name_on_userprofile	2024-08-18 07:16:50.107728+00
257	wagtailusers	0003_add_verbose_names	2024-08-18 07:16:50.139961+00
258	wagtailusers	0004_capitalizeverbose	2024-08-18 07:16:50.246543+00
259	wagtailusers	0005_make_related_name_wagtail_specific	2024-08-18 07:16:50.292541+00
260	wagtailusers	0006_userprofile_prefered_language	2024-08-18 07:16:50.359406+00
261	wagtailusers	0007_userprofile_current_time_zone	2024-08-18 07:16:50.49427+00
262	wagtailusers	0008_userprofile_avatar	2024-08-18 07:16:50.544548+00
263	wagtailusers	0009_userprofile_verbose_name_plural	2024-08-18 07:16:50.581961+00
264	wagtailusers	0010_userprofile_updated_comments_notifications	2024-08-18 07:16:50.625145+00
265	wagtailusers	0011_userprofile_dismissibles	2024-08-18 07:16:50.673615+00
266	wagtailusers	0012_userprofile_theme	2024-08-18 07:16:50.715816+00
267	wagtailusers	0013_userprofile_density	2024-08-18 07:16:50.763153+00
268	wagtailimages	0001_squashed_0021	2024-08-18 07:16:50.776027+00
269	wagtailcore	0001_squashed_0016_change_page_url_path_to_text_field	2024-08-18 07:16:50.791627+00
270	apps	0021_homepage_alter_emailtemplate_body	2024-08-18 07:18:46.291982+00
271	actstream	0001_initial	2024-08-28 15:14:06.204036+00
272	actstream	0002_remove_action_data	2024-08-28 15:14:06.277409+00
273	actstream	0003_add_follow_flag	2024-08-28 15:14:06.472595+00
274	apps	0022_treatmentproduct_treatmentplan_treatmentplanitem_and_more	2024-08-28 23:46:58.876972+00
275	apps	0023_treatmentplan_discount_percentage_and_more	2024-08-29 01:35:41.617509+00
276	apps	0024_remove_medicalinformation_uploaded_files_and_more	2024-08-29 06:00:35.338424+00
277	apps	0025_treatmentproduct_max_discount_percentage	2024-08-29 10:41:51.683305+00
278	apps	0026_user_nationality_alter_emergencycontact_phone_number_and_more	2024-08-29 12:21:06.462413+00
279	apps	0027_alter_user_nationality	2024-08-31 18:42:08.069869+00
280	apps	0028_alter_appointment_options_alter_contact_options_and_more	2024-09-06 15:14:38.950316+00
281	apps	0029_alter_user_date_of_birth	2024-11-10 20:36:28.68558+00
282	apps	0030_flightreservation_accommodation_patientschedule	2024-11-13 20:43:36.201867+00
283	apps	0031_flightreservation_user	2024-11-14 19:47:34.358882+00
284	apps	0032_hotel_remove_accommodation_address_and_more	2024-11-14 20:14:14.983846+00
285	apps	0033_remove_treatmentplan_discount_percentage_and_more	2024-11-14 22:10:44.696598+00
286	apps	0034_treatmentplan_discount_amount	2024-11-14 23:46:35.571445+00
287	apps	0035_auto_20241114_2350	2024-11-14 23:55:15.360615+00
288	baton	0001_initial	2024-12-04 15:04:38.580419+00
289	baton	0002_alter_batontheme_options_alter_batontheme_active_and_more	2024-12-04 15:04:38.659377+00
291	authtoken	0002_auto_20160226_1747	2024-12-13 10:19:21.941499+00
292	authtoken	0003_tokenproxy	2024-12-13 10:19:21.957509+00
293	authtoken	0004_alter_tokenproxy_options	2024-12-13 10:19:22.001021+00
294	leads	0001_initial	2024-12-13 19:17:45.930282+00
295	leads	0002_lead_status	2024-12-14 00:21:53.495341+00
296	leads	0003_leadhistory	2024-12-14 04:43:55.350287+00
297	leads	0004_note	2024-12-14 05:08:43.159756+00
298	leads	0005_lead_country_alter_lead_email_alter_lead_name_and_more	2024-12-15 19:13:19.983302+00
299	leads	0006_alter_lead_country_alter_lead_source	2024-12-22 17:45:42.200594+00
\.


--
-- Data for Name: django_openai_assistant_openaitask; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_openai_assistant_openaitask (assistantid, runid, threadid, status, created_at, completed_at, response, completioncall, tools, meta) FROM stdin;
asst_xwkSbOAyDS2jns4VQQaQM19x	run_YW08iDgzFqh5tbxdZtXBK4EH	thread_a3Ujv8ACGltz8YsrR69SPIbB	created	2024-07-26 12:17:43.64675+00	\N	\N	app:afterRunFunction		\N
asst_xwkSbOAyDS2jns4VQQaQM19x	run_9GYSW0rSrMbmptxU58R8GrPL	thread_aRtHDNii5VL0WrYNFKRlIGxm	created	2024-07-26 12:19:31.812739+00	\N	\N	app:afterRunFunction		\N
asst_xwkSbOAyDS2jns4VQQaQM19x	run_pHI6cZxvBYcRy7NUPPAOfAjE	thread_TNFmjywU6KOeTW54tmXwzdHG	created	2024-07-26 12:44:39.520749+00	\N	\N	app.after_run_function		\N
asst_xwkSbOAyDS2jns4VQQaQM19x	run_QzmuFNPiiWbEncLw61GcTbht	thread_R3aNzY4rc2Xo64YaE76RzSdT	created	2024-07-26 13:00:24.252232+00	\N	\N	app.after_run_function		\N
asst_xwkSbOAyDS2jns4VQQaQM19x	run_TKhp5q7DkhQTHSfqtLB8MizN	thread_1qAIgBz6MwQXFMD7Aij9VItu	created	2024-07-26 14:14:39.197985+00	\N	\N	apps.test:afterRunFunction		\N
asst_xwkSbOAyDS2jns4VQQaQM19x	run_ozxqtOwszLsrzTZPKHHTDU6j	thread_fmrvwcuQNmkNSBOwaN6BKmGb	created	2024-07-26 14:26:29.458434+00	\N	\N	apps.test:afterRunFunction		\N
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
i9eo1l63vvlj0w9rhjwnpynpq7bmppwe	MmVmZjdlYzE0NGRjY2ZlZmVmMGQyODJiNTBiZTg2MGNhMWJmMDNlYTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkNmFkZGI2ZWMzNmY2MDE4ZTEwZjAyY2U1MmFhYWNiY2MzZmZhNjE0IiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==	2024-07-28 08:01:09.994887+00
8al877vmpcftevw4v6ua8b2u66gqcu7p	MmVmZjdlYzE0NGRjY2ZlZmVmMGQyODJiNTBiZTg2MGNhMWJmMDNlYTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkNmFkZGI2ZWMzNmY2MDE4ZTEwZjAyY2U1MmFhYWNiY2MzZmZhNjE0IiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==	2024-07-28 23:37:13.951874+00
ailm4leztzck50uokgwrrq64y297dwxe	MmVmZjdlYzE0NGRjY2ZlZmVmMGQyODJiNTBiZTg2MGNhMWJmMDNlYTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkNmFkZGI2ZWMzNmY2MDE4ZTEwZjAyY2U1MmFhYWNiY2MzZmZhNjE0IiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==	2024-07-29 19:25:37.425301+00
s5la9as1jg93umuvc2tlv4m78msl4o0r	MmVmZjdlYzE0NGRjY2ZlZmVmMGQyODJiNTBiZTg2MGNhMWJmMDNlYTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkNmFkZGI2ZWMzNmY2MDE4ZTEwZjAyY2U1MmFhYWNiY2MzZmZhNjE0IiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==	2024-07-30 15:10:33.090241+00
o39q18eo1aj8cmevz4to4ctgth14ri0k	MmVmZjdlYzE0NGRjY2ZlZmVmMGQyODJiNTBiZTg2MGNhMWJmMDNlYTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkNmFkZGI2ZWMzNmY2MDE4ZTEwZjAyY2U1MmFhYWNiY2MzZmZhNjE0IiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==	2024-07-30 20:04:44.480843+00
sl41vxuybcitz0ovlri4d3fe2uwiy8c8	MmVmZjdlYzE0NGRjY2ZlZmVmMGQyODJiNTBiZTg2MGNhMWJmMDNlYTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkNmFkZGI2ZWMzNmY2MDE4ZTEwZjAyY2U1MmFhYWNiY2MzZmZhNjE0IiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==	2024-07-31 06:51:40.685701+00
jylgcyjlu1m7a4tw94d21x71p45ojmqf	MmVmZjdlYzE0NGRjY2ZlZmVmMGQyODJiNTBiZTg2MGNhMWJmMDNlYTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkNmFkZGI2ZWMzNmY2MDE4ZTEwZjAyY2U1MmFhYWNiY2MzZmZhNjE0IiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==	2024-07-31 08:39:58.046118+00
c8sie1ytlde3xzrvwpjvbbygv059mqnh	MmVmZjdlYzE0NGRjY2ZlZmVmMGQyODJiNTBiZTg2MGNhMWJmMDNlYTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkNmFkZGI2ZWMzNmY2MDE4ZTEwZjAyY2U1MmFhYWNiY2MzZmZhNjE0IiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==	2024-07-31 12:20:15.015739+00
rmc6bpubk0ea4pcdh1owsh6ppnq7p0v4	MmVmZjdlYzE0NGRjY2ZlZmVmMGQyODJiNTBiZTg2MGNhMWJmMDNlYTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkNmFkZGI2ZWMzNmY2MDE4ZTEwZjAyY2U1MmFhYWNiY2MzZmZhNjE0IiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==	2024-07-31 15:01:10.09263+00
u6ku1hu4g8qr8tat9wb74rn46ptmacog	MmVmZjdlYzE0NGRjY2ZlZmVmMGQyODJiNTBiZTg2MGNhMWJmMDNlYTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkNmFkZGI2ZWMzNmY2MDE4ZTEwZjAyY2U1MmFhYWNiY2MzZmZhNjE0IiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==	2024-07-31 18:10:50.253189+00
900n4y2axsutj1tvle98k1pw1d0w2ixn	MmVmZjdlYzE0NGRjY2ZlZmVmMGQyODJiNTBiZTg2MGNhMWJmMDNlYTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkNmFkZGI2ZWMzNmY2MDE4ZTEwZjAyY2U1MmFhYWNiY2MzZmZhNjE0IiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==	2024-07-31 19:45:54.840864+00
myhf6ncctli08cf66auiyr4zyzcrjebj	MmVmZjdlYzE0NGRjY2ZlZmVmMGQyODJiNTBiZTg2MGNhMWJmMDNlYTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkNmFkZGI2ZWMzNmY2MDE4ZTEwZjAyY2U1MmFhYWNiY2MzZmZhNjE0IiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==	2024-08-01 16:29:35.023843+00
hbs583s6nu7hxoyos1pg3tgigpm2jpg6	MmVmZjdlYzE0NGRjY2ZlZmVmMGQyODJiNTBiZTg2MGNhMWJmMDNlYTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkNmFkZGI2ZWMzNmY2MDE4ZTEwZjAyY2U1MmFhYWNiY2MzZmZhNjE0IiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==	2024-08-01 16:41:51.966663+00
b58h8a6dg7i1vvf7gx4gm28d0z0uu8mx	MmVmZjdlYzE0NGRjY2ZlZmVmMGQyODJiNTBiZTg2MGNhMWJmMDNlYTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkNmFkZGI2ZWMzNmY2MDE4ZTEwZjAyY2U1MmFhYWNiY2MzZmZhNjE0IiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==	2024-08-01 18:06:22.974351+00
uvj3y78d6ncr8vm920n2f2f3uoqjps0t	MmVmZjdlYzE0NGRjY2ZlZmVmMGQyODJiNTBiZTg2MGNhMWJmMDNlYTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkNmFkZGI2ZWMzNmY2MDE4ZTEwZjAyY2U1MmFhYWNiY2MzZmZhNjE0IiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==	2024-08-01 21:13:53.8026+00
htoaav46i5up7om2nhf9ucr0fjpnfsnc	YTU1OTVkYzQzM2Y0N2UwYjc0MjM3ZmNjYmRjZjEzZmQyZTdkNjQ5ODp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJmZWRiNjk1NDZlOGI0NDZjNGE1MmU0OGU5M2RkNzY4N2NmMDQwNDE0IiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==	2024-08-02 01:15:44.852688+00
4oj844y5keu5er6qr9liwni0z5nqp0i2	Y2EwMDcxNDljOGI2ZDg2ZTQwOTVlNTZmMTY4ZDYxNzFhYzMzMmNkYjp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJiMzRkNGExNWI3OWZlMWEwNjczMjEyNGFmMzllZmM3YzM5OTMzZGQ4IiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==	2024-08-02 02:59:01.04988+00
s5yslajd8p6t4rw672wj3l42f6xi3bbg	YTU1OTVkYzQzM2Y0N2UwYjc0MjM3ZmNjYmRjZjEzZmQyZTdkNjQ5ODp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJmZWRiNjk1NDZlOGI0NDZjNGE1MmU0OGU5M2RkNzY4N2NmMDQwNDE0IiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==	2024-08-02 03:36:30.22764+00
rix4roqzb0rvctjugxcmqmjacmb2bdfy	.eJxVjMsOwiAQRf-FtSG0w7NL934DgWFqUQOmtInG-O_apAvd3nPueTEf1mXya6PZ58QG1rPD7xYDXqlsIF1COVeOtSxzjnxT-E4bP9VEt-Pu_gWm0KbvGwAFkpTOaBdHctaBCTrIEZXFBB2JHpTVxtkOFSQxWic02F4ZjIZU3KKNWsu1eHrc8_xkg3h_AGvzPnQ:1sUkSU:UWb5Ibx2efHBZqjyXHVNNXhdZToqsdN73sQl7qmjSPA	2024-08-02 10:03:26.859377+00
jh2bgnn13l34s1jnslexn7yc83et6ux5	.eJxVjMsOwiAQRf-FtSG0w7NL934DgWFqUQOmtInG-O_apAvd3nPueTEf1mXya6PZ58QG1rPD7xYDXqlsIF1COVeOtSxzjnxT-E4bP9VEt-Pu_gWm0KbvGwAFkpTOaBdHctaBCTrIEZXFBB2JHpTVxtkOFSQxWic02F4ZjIZU3KKNWsu1eHrc8_xkg3h_AGvzPnQ:1sUnLW:860UoOmwVj29g8DOxEB_XPy7WjaGITW49ygrbgl3a-4	2024-08-02 13:08:26.4306+00
w6ic54vmbu5obvzey5zcgh89ynwy4ct3	.eJxVjEEOwiAUBe_C2hCgtECX7j0D4cPHogYMtInGeHcl6UI3b_FmMi9i3bYudmtYbQpkJhM5_H7g_BVzB-Hi8rlQX_JaE9Cu0J02eioBb8fd_Qssri09K4EZE7XXAAGCAuURDR-1ltIormPUIgjp9cCkGAfF-HcmMYygOBcYe7Rha6lki497qk8ys_cHd9A-PA:1sUpmL:5p0u2eiFhU0QU_UvlS1YfAY8546qlpu_IAQEF2li-cI	2024-08-02 15:44:17.522956+00
hri04iadeu9z43b74o5cjnqy3cu0t24u	.eJxVjMsOwiAQRf-FtSG0w7NL934DgWFqUQOmtInG-O_apAvd3nPueTEf1mXya6PZ58QG1rPD7xYDXqlsIF1COVeOtSxzjnxT-E4bP9VEt-Pu_gWm0KbvGwAFkpTOaBdHctaBCTrIEZXFBB2JHpTVxtkOFSQxWic02F4ZjIZU3KKNWsu1eHrc8_xkg3h_AGvzPnQ:1sUqwL:mJK3aVcXeQHNyPzp8JTr4DIp7zJYQ_eRG0KRDLV1dIg	2024-08-02 16:58:41.3274+00
py80d8cs2tpeg3db9n1jpxwbw5kuglor	.eJxVjEEOwiAQRe_C2hCg7TC4dO8ZyDBMpWpoUtqV8e7apAvd_vfef6lI21ri1mSJU1ZnZdXpd0vED6k7yHeqt1nzXNdlSnpX9EGbvs5ZnpfD_Tso1Mq3TpAEs5URex7AemfSYDIKhxAMOE8gtg8dsxtgNL3p2PsxABBiIouk3h_e3TeE:1sUrL7:f7w2mOVxZv0YJ6b6C-wGkyKHKuKj2WVauCA7Ij8ynDw	2024-08-02 17:24:17.741389+00
je7o8t9n1ug80s2m65kyi82m6nimlhxe	.eJxVjMsOwiAQRf-FtSG0w7NL934DgWFqUQOmtInG-O_apAvd3nPueTEf1mXya6PZ58QG1rPD7xYDXqlsIF1COVeOtSxzjnxT-E4bP9VEt-Pu_gWm0KbvGwAFkpTOaBdHctaBCTrIEZXFBB2JHpTVxtkOFSQxWic02F4ZjIZU3KKNWsu1eHrc8_xkg3h_AGvzPnQ:1sUrcW:5_1uvAg5ThGZn3GhsO3xg4dq0wC_U5kRm88QZ4yf7yk	2024-08-02 17:42:16.190309+00
mgj7iav8or7av2jx4h5i5hg3b3ojues8	.eJxVjMsOwiAQRf-FtSG0w7NL934DgWFqUQOmtInG-O_apAvd3nPueTEf1mXya6PZ58QG1rPD7xYDXqlsIF1COVeOtSxzjnxT-E4bP9VEt-Pu_gWm0KbvGwAFkpTOaBdHctaBCTrIEZXFBB2JHpTVxtkOFSQxWic02F4ZjIZU3KKNWsu1eHrc8_xkg3h_AGvzPnQ:1sUuWB:YkJ7b2nXD9MMqCkhfszZ0uvX0zOzuQQyRWrnqZ92gyY	2024-08-02 20:47:55.502685+00
78tn5p63qmw8apjrx6yunn84igu4sxre	.eJxVjMsOwiAQRf-FtSG8Cy7d-w1kGAapGkhKuzL-uzbpQrf3nHNfLMK21rgNWuKc2ZlJw06_YwJ8UNtJvkO7dY69rcuc-K7wgw5-7Zmel8P9O6gw6rfWRZoQjNDe-WCTSkVN6EoRiMlaRUJQlhMCKnRCJg0aXNFkjScpig7s_QH7aTf6:1sVHUQ:z4YAWxJ90GdViEg86YfpJ4UhM7C36KjCIRwMjfw-950	2024-08-03 21:19:38.879767+00
5qax32l215jlr0i2p1myhz06jpjf00ek	.eJxVjMsOwiAQRf-FtSG0w7NL934DgWFqUQOmtInG-O_apAvd3nPueTEf1mXya6PZ58QG1rPD7xYDXqlsIF1COVeOtSxzjnxT-E4bP9VEt-Pu_gWm0KbvGwAFkpTOaBdHctaBCTrIEZXFBB2JHpTVxtkOFSQxWic02F4ZjIZU3KKNWsu1eHrc8_xkg3h_AGvzPnQ:1sVI4Z:pwP-QR8knrzBfwmH-_HR5ie7qgo6woQ6DryBlN_-wIU	2024-08-03 21:56:59.934173+00
jq541l19s7jao0eamb8wgil3bszsuqvh	.eJxVjE0OgjAYBe_StWlaKARYuvcMzfdXqZrWUEgwxrsLCQvdvpk3b-VhmUe_FJl8ZDWoWp1-NwS6S9oB3yBds6ac5imi3hV90KIvmeVxPty_wAhl3N4dUg8cWKChCp0Bg5aoEYdiXair1gZX9x0F5g20rWWwEGxlDDYoZPZokVJiTl7WZ5xeajCfL-kqQJA:1sVJ31:UMlKNu6HBUQFrQeai9YiY9dbQoLYsoJaVP1lYkjGtm0	2024-08-03 22:59:27.565795+00
laffgpi9jm8b3ukckk3aa1mt3adoubv5	.eJxVjE0OgjAYBe_StWlaKARYuvcMzfdXqZrWUEgwxrsLCQvdvpk3b-VhmUe_FJl8ZDWoWp1-NwS6S9oB3yBds6ac5imi3hV90KIvmeVxPty_wAhl3N4dUg8cWKChCp0Bg5aoEYdiXair1gZX9x0F5g20rWWwEGxlDDYoZPZokVJiTl7WZ5xeajCfL-kqQJA:1sVJGV:MZCmZA5YYcB73GEwU-Lt4wME3SeCs-svYg4KAnjSko0	2024-08-03 23:13:23.128769+00
zqanmv6yjq8yyy5arkn8hhguhktn64vl	.eJxVjE0OgjAYBe_StWlaKARYuvcMzfdXqZrWUEgwxrsLCQvdvpk3b-VhmUe_FJl8ZDWoWp1-NwS6S9oB3yBds6ac5imi3hV90KIvmeVxPty_wAhl3N4dUg8cWKChCp0Bg5aoEYdiXair1gZX9x0F5g20rWWwEGxlDDYoZPZokVJiTl7WZ5xeajCfL-kqQJA:1sVJ56:Vre51Roh8XYF6KW_jFRk2BXQw2mmri4qRHJD8gCgHwE	2024-08-03 23:01:36.302843+00
2jiea2a1cya203436bht1fz0m3ejmxg0	.eJxVjMsOwiAQRf-FtSG0w7NL934DgWFqUQOmtInG-O_apAvd3nPueTEf1mXya6PZ58QG1rPD7xYDXqlsIF1COVeOtSxzjnxT-E4bP9VEt-Pu_gWm0KbvGwAFkpTOaBdHctaBCTrIEZXFBB2JHpTVxtkOFSQxWic02F4ZjIZU3KKNWsu1eHrc8_xkg3h_AGvzPnQ:1sVJLA:4Wx3QDEPV7AleF2jaa_CTDI_nRO7-0JvK7oENEb0EOg	2024-08-03 23:18:12.241647+00
9x78ybw0tvyyjv10vofqxxzb2um3rihk	.eJxVjE0OgjAYBe_StWlaKARYuvcMzfdXqZrWUEgwxrsLCQvdvpk3b-VhmUe_FJl8ZDWoWp1-NwS6S9oB3yBds6ac5imi3hV90KIvmeVxPty_wAhl3N4dUg8cWKChCp0Bg5aoEYdiXair1gZX9x0F5g20rWWwEGxlDDYoZPZokVJiTl7WZ5xeajCfL-kqQJA:1sVd7N:t64-nKW7buLJFrGcCoChIL9obVB8xKEjMukFZJuL0Jk	2024-08-04 20:25:17.206185+00
eaz3d8d2o91xa355t0an46rrf2ug9tpv	.eJxVjMsOwiAURP-FtSHIo7RduvcbyL1wsagBU9pEY_x3S9KFbmYxc-a8mYN1mdxaaXYpsJH17PDbIfgb5TaEK-RL4b7kZU7IG8L3tfJzCXQ_7eyfYII6bW_UakAZyZIMVnkUaAR4rTQcDYGSAFIA4GA7GfoeOq2jjkpZYUJntmzSSrWmkh09H2l-sVF8vp0kPvs:1sVfpN:uBOG9gYKz_dUsMzTCpZakTtQHnIDuA-quF73_vSUobg	2024-08-04 23:18:53.87858+00
tfhjjohpvejfg0c60bkoh0w1kvgpnzdq	.eJxVjr0OwyAMhN-FOUKQPyUZu_cZkG1MQhtBBYnUquq7l0gZ2sXDfXfnewsD-7aYPXMy3opJNKL61RDozuEA9gZhjpJi2JJHeVjkSbO8Rsvr5fT-FSyQl5IekEawzjJ0VGOrQKEm6rhF1q1r6l67thkHctYW0Pfaggana6WwQyZ1lGbO2cdg-Pnw6SUmVZ2jzFruDjOXRy6JzxcT1Uhs:1sW8NI:76AEOLGdqQRWPLt6Lsbq1qvk-p6A62ylbP4ZgDnbgGI	2024-08-06 05:47:48.407382+00
g2r1esu59mpenoojbduxn83plwsppeeb	.eJxVTrsOgyAU_RdmQ1Dk5di930DgclFagw1o0qbpv1cTh3Y5w3m_iXXbOtmtYrEpkIF0pPnlvIM75kMIN5fHhcKS15I8PSz0VCu9LgHny-n9K5hcnfY058AA-94oaXxEow1XTro-gtAQeIus40JLZXQLggcWtWGS604o8AqFP0or1pqWbPH5SOVFBtacp-y84-ZG3IdiIZ8vZgtGUA:1sW0Td:CJBvntb4j1GJ_NVpDsLdkC0Qr4QZZL1iZrylyTWbR4I	2024-08-05 21:21:49.145357+00
vbeqrhx38htuycw160ybgu5qyzkgnbsj	.eJxVjsEOwiAQRP-Fc0OgFNAevfsNZGGhRRsw0CYa479Lkx70spnsvJ2dNzGwrbPZqi8mIhkJZ6T7XVpwd592B2-QpkxdTmuJlu4IPdxKrxn9cjnYv4AZ6tyumWAhnAJnQmmpggXOQ1NWAkOttBiY6LFXEjQMSmpxdr0TDhE1aOH4sIdWX2vMyfjnI5YXGVl3lDJLmxtMvj0KhXy-g1xGfg:1sW1YR:EQm9VbZesDRcLljLoZFWnxIF3b6n8_1wNlxpzkil5Ro	2024-08-05 22:30:51.189124+00
se5mkcknwk84xlvp5szz9lnkga5rjhqx	.eJxVjsEOwiAQRP-Fc0OgFNAevfsNZGGhRRsw0CYa479Lkx70spnsvJ2dNzGwrbPZqi8mIhkJZ6T7XVpwd592B2-QpkxdTmuJlu4IPdxKrxn9cjnYv4AZ6tyumWAhnAJnQmmpggXOQ1NWAkOttBiY6LFXEjQMSmpxdr0TDhE1aOH4sIdWX2vMyfjnI5YXGVl3lDJLmxtMvj0KhXy-g1xGfg:1sW1gD:kpQIENlsuAJLQdCpf-jISe5WYuzFJnC1c1XlwphBBeg	2024-08-05 22:38:53.812633+00
gjrgn1kw44vo5slj00aqouu1hgrbnxo0	.eJxVjsEOgyAQRP-FsyGgaNRj7_0GsrssSmugEU3aNP33YuKhvexh3szsvIWFfZvtnnm1wYlRNKL61RDozvEA7gZxSpJS3NaA8rDIk2Z5TY6Xy-n9K5ghzyXdIw3gvGNoqUajQKEmatkga-ObutPeNENP3rkCuk470OB1rRS2yKSO0sw5hxQtPx9hfYlRVecou5S7w8TlEUfx-QITxUhn:1sW2Ek:pVPwEAT9PmwyI0xj5qEaGA4Xv7nli0IIjC3_lLembBU	2024-08-05 23:14:34.467192+00
5j2i95hkurgbya63xb4h7eyeutxo6nv9	.eJxVTksOgyAQvQtrQxhAB1123zMQPqPSGmxEkzZN715NXLSbt3j_N7NuW0e7FVpsiqxjUrDql_Qu3CkfSry5PMw8zHldkueHhZ9q4dc50nQ5vX8FoyvjntYGQKDCRoJRBmr0pINB1YoGdRMiaSSoA4JWvQMUBEarIHuqTetR-qO0UClpzpaej7S8WCeq85SddtzcQPsQZfb5AjI_RaU:1sW3SU:jwZoCASy29Xj_BikabIGOyw5fTEJ10X90iVewXwsIFg	2024-08-06 00:32:50.278178+00
inlnxjwjhjh3shpyjpvz7amnmyybpmk9	.eJxVTrsOgyAU_RdmQ1Dk5di930DgclFagw1o0qbpv1cTh3Y5w3m_iXXbOtmtYrEpkIF0pPnlvIM75kMIN5fHhcKS15I8PSz0VCu9LgHny-n9K5hcnfY058AA-94oaXxEow1XTro-gtAQeIus40JLZXQLggcWtWGS604o8AqFP0or1pqWbPH5SOVFBtacp-y84-ZG3IdiIZ8vZgtGUA:1sW2Sd:TW4YfwlVtIrnAb0UZb9Omds2MOM6-eMno7FMoFli_SY	2024-08-05 23:28:55.274495+00
0crrveputn7z2lo0qattsq3pid08vrt2	.eJxVTrsOgyAU_RdmQ1Dk5di930DgclFagw1o0qbpv1cTh3Y5w3m_iXXbOtmtYrEpkIF0pPnlvIM75kMIN5fHhcKS15I8PSz0VCu9LgHny-n9K5hcnfY058AA-94oaXxEow1XTro-gtAQeIus40JLZXQLggcWtWGS604o8AqFP0or1pqWbPH5SOVFBtacp-y84-ZG3IdiIZ8vZgtGUA:1sW2TL:Duit5jhDxk_68PYIdh6XRtkhvur1023K1lxIbbSrFiw	2024-08-05 23:29:39.530621+00
k84zeg7azqnm1skb9asuhdyg4rjagxqb	.eJxVjs0OwiAQhN-Fc0Og_GmP3n0GsrDQog2Y0iYa47tLkx70spnsfDs7b2JhWye71bDYhGQgnJHud-nA30PeHbxBHgv1Ja9LcnRH6OFWei0Y5svB_gVMUKd2zQSL8RQ5E9ooHR1wHptyChgabYRkosdeKzAgtTLi7HsvPCIaMMJzuYfWUGsq2YbnIy0vMrDuKGXnNjcYQ3sUMvl8AYNMRnk:1sW3eL:Onl0byo4CCe2tN1RTUBfo_yEGuPN3_IUz1pgKcT6GPs	2024-08-06 00:45:05.542315+00
675zn0nhe0czknybpi6fja78gv0alkvg	.eJxVjs0OwiAQhN-Fc0Og_GmP3n0GsrDQog2Y0iYa47tLkx70spnsfDs7b2JhWye71bDYhGQgnJHud-nA30PeHbxBHgv1Ja9LcnRH6OFWei0Y5svB_gVMUKd2zQSL8RQ5E9ooHR1wHptyChgabYRkosdeKzAgtTLi7HsvPCIaMMJzuYfWUGsq2YbnIy0vMrDuKGXnNjcYQ3sUMvl8AYNMRnk:1sW3kF:MZLYz0Taf5jo8x0QMKbS4FGNXX1sbpZZJAjJOSy-bz0	2024-08-06 00:51:11.157267+00
49nfptbw6toscv9rle5usiknmav99nop	.eJxVjs0OwiAQhN-Fc0Og_GmP3n0GsrDQog2Y0iYa47tLkx70spnsfDs7b2JhWye71bDYhGQgnJHud-nA30PeHbxBHgv1Ja9LcnRH6OFWei0Y5svB_gVMUKd2zQSL8RQ5E9ooHR1wHptyChgabYRkosdeKzAgtTLi7HsvPCIaMMJzuYfWUGsq2YbnIy0vMrDuKGXnNjcYQ3sUMvl8AYNMRnk:1sW40s:jbj42Jtjou9z6Ca8BoaRozq6H25o-KwGYxOAjf74FUM	2024-08-06 01:08:22.220089+00
9df3v2vdy9gxvejhrw08dqycgagyt83v	.eJxVjMEOgyAQRP-Fc0NA0ajH3vsNZHdZlNZAI5q0afrvxdSLlznMezMf4e4Qx2TnkhuMLAbBUVyEhW2d7JZ5scGVsj53CPTguIP_XlKK6xJQ7oo8aJa35Hi-Hu7pYII8lXWH1IPzjqGhCo0ChZqoYYOsja-rVntT9x155wpoW-1Ag9eVUtggk9pPM-ccUrT8eoblLQb1_QEq0khn:1sW8g9:PjEpV6GltV6jMii5Cqd-i-yBaj2b_uecQ5rQdjMGrhs	2024-08-06 06:07:17.937511+00
s9qpdy3tod06xethaufovowz1futyhfn	.eJxVTrsOgyAU_RdmQygPUcfu_QZygavSGjCgSZum_15MHNrlDOf9Jgb2bTZ7wWyCJwPpSPPLWXAPjIfg7xCnRF2KWw6WHhZ6qoXeksflenr_CmYoc01bKXrLR9TIvRbOMqsYOCkkXBSC4ACcAdhet9x3HbRSjnIUQjPlW1XxKC1YSkjR4HMN-UUG1pynzFJxhwnrEGTy-QKjSUbS:1sW9nI:2J6lqlQtKp_ogQ35vTMRGIg-iRukL0Da0PyBjeSlV58	2024-08-06 07:18:44.165503+00
yrmst2c320k5ngoyl597929cp78m9ycb	.eJxVjMEOgyAQRP-Fc2NA0ajH3vsNZNldlNZAA5q0afrvxdSLlznMezMfQXcIUzRLyQ0mFqOAJC7CwLbOZsucjKdSNufOAj447OC_rzCGNXlb7Up10FzdIvFyPdzTwQx5Luve4gDkiKHF2moJ0irElrVlpV1Td8rpZujRERXQdYpAgVO1lLa1jHI_zZyzj8Hw6-nTW4zy-wMqzkhn:1sWHTV:2WauioVqqMyW4rQPTvsBgN2Tc1amfw9VIbDR7SiZR3s	2024-08-06 15:30:49.082797+00
ynrqqha8t9b0ep5rgdqz7ptjoimzhf75	.eJxVjr0OwyAMhN-FOUKQPyUZu_cZkI1NQhtBBYnUquq7l0gZ2sXDfXfnewsD-7aYPXMynsQkGlH9agj2zuEAdIMwR2lj2JJHeVjkSbO8RuL1cnr_ChbIS0kPaEcgRwydrbFVoFBb23GLrFvX1L12bTMO1hEV0PeaQIPTtVLYIVt1lGbO2cdg-Pnw6SUmVZ2jzFruDjOXR5DE5wsTwUhn:1sWI1X:-JiJG7_GOmNOIyKJeokTTStfICNCB3AKQl7M_VQsU94	2024-08-06 16:05:59.325304+00
1pq3vs64opzi9u0uycf8oimlf8h9sq72	.eJxVjsEOgyAQRP-FsyGgaNRj7_0GsrssSmugEU3aNP33YuKhvexh3szsvIWFfZvtnnm1wYlRNKL61RDozvEA7gZxSpJS3NaA8rDIk2Z5TY6Xy-n9K5ghzyXdIw3gvGNoqUajQKEmatkga-ObutPeNENP3rkCuk470OB1rRS2yKSO0sw5hxQtPx9hfYlRVecou5S7w8TlEUfx-QITxUhn:1sWQQv:lnsqffBv9NZk8oMvZR-J3sZuwkgD1aVXCpLWnyUliYg	2024-08-07 01:04:45.029582+00
ors69mfo0ymz27jlwiybb1nhv226b411	.eJxVjr0OwyAMhN-FOUKQPyUZu_cZkI1NQhtBBYnUquq7l0gZ2sXDfXfnewsD-7aYPXMynsQkGlH9agj2zuEAdIMwR2lj2JJHeVjkSbO8RuL1cnr_ChbIS0kPaEcgRwydrbFVoFBb23GLrFvX1L12bTMO1hEV0PeaQIPTtVLYIVt1lGbO2cdg-Pnw6SUmVZ2jzFruDjOXR5DE5wsTwUhn:1sWJ3P:9K5UcbGOmwsbCpLmvCoyk0QFBCMLJDSnKz65qy7faRU	2024-08-06 17:11:59.751666+00
jqu87pqbcrtr44glcduv87trtllmiwhk	.eJxVjr0OwyAMhN-FOUKQPyUZu_cZkI1NQhtBBYnUquq7l0gZ2sXDfXfnewsD-7aYPXMynsQkGlH9agj2zuEAdIMwR2lj2JJHeVjkSbO8RuL1cnr_ChbIS0kPaEcgRwydrbFVoFBb23GLrFvX1L12bTMO1hEV0PeaQIPTtVLYIVt1lGbO2cdg-Pnw6SUmVZ2jzFruDjOXR5DE5wsTwUhn:1sWJZF:ZYlqlGvRppWWULGKlYV4xkJUXT2yb_aSCumMZkRvXqE	2024-08-06 17:44:53.892893+00
yf9xs6sl6ta1zpll8mvhcl6myqrlx7u7	.eJxVjr0OwyAMhN-FOUKQPyUZu_cZkI1NQhtBBYnUquq7l0gZ2sXDfXfnewsD-7aYPXMynsQkGlH9agj2zuEAdIMwR2lj2JJHeVjkSbO8RuL1cnr_ChbIS0kPaEcgRwydrbFVoFBb23GLrFvX1L12bTMO1hEV0PeaQIPTtVLYIVt1lGbO2cdg-Pnw6SUmVZ2jzFruDjOXR5DE5wsTwUhn:1sWK39:T5xBHPd_DcfS0szphNxb7Ht7orXSEUE00EzEtl_f77I	2024-08-06 18:15:47.854614+00
0hfqb5zaoi30g771l0kouop3np84oo7l	.eJxVjr0OwyAMhN-FOUKQPyUZu_cZkG1MQhtBBYnUquq7l0gZ2sXDfXfnewsD-7aYPXMy3opJNKL61RDozuEA9gZhjpJi2JJHeVjkSbO8Rsvr5fT-FSyQl5IekEawzjJ0VGOrQKEm6rhF1q1r6l67thkHctYW0Pfaggana6WwQyZ1lGbO2cdg-Pnw6SUmVZ2jzFruDjOXRy6JzxcT1Uhs:1sWLIa:5QJzguIAs_RSJ1UPx6sWPl-clM1ta1qJzm8E-rXLggw	2024-08-06 19:35:48.647459+00
6wzze7fefdk61mc7jpdwhlr83loxb7e1	.eJxVjMEOgyAQRP-Fc2NA0ajH3vsNZHdZlNZAA5q0afrvxdSLlznMezMfYe8QpmiWkhtMLEbhkrgIA9s6my1zMt6Wsjl3CPTgsIP_vqIY1uSx2pXqoLm6RcvL9XBPBzPkuax7pAGsswwt1aglSFRELWtkpV1Td8rpZujJWVtA1ykLCpyqpcQWmeR-mjlnH4Ph19Ontxjl9wcumEhs:1sWLdV:ZawaIaMIAOOoJMN5kOtvjULcm_cUISZktZ9rMDgzHcw	2024-08-06 19:57:25.78202+00
sbxm4ldw44qei3lql1lfztuh1pwn78vn	.eJxVjr0OwyAMhN-FOUKQPyUZu_cZkG1MQhtBBYnUquq7l0gZ2sXDfXfnewsD-7aYPXMy3opJNKL61RDozuEA9gZhjpJi2JJHeVjkSbO8Rsvr5fT-FSyQl5IekEawzjJ0VGOrQKEm6rhF1q1r6l67thkHctYW0Pfaggana6WwQyZ1lGbO2cdg-Pnw6SUmVZ2jzFruDjOXRy6JzxcT1Uhs:1sWLgg:uwyp1FOSE-w3l628kVlzXcX-m4n6096W6zAIEwI0vBA	2024-08-06 20:00:42.600785+00
u3l2eys37v9x6taf0571mip2bu4dbsw2	.eJxVTkkOwiAUvQvrhjBIkS7dewbyP0OLNmCgTTTGu9smXejmLd78JhbWZbJrC9UmTwYiJel-SQR3D3lX_A3yWKgreakJ6W6hh9rotfgwXw7vX8EEbdrS6KPuwUDkwgNop4LRBkFGxhWPyPogjO75yYCLUghkgjsTUagzKqYk30tbaC2VbMPzkeqLDKw7Ttl5wxXGsA3FSj5f5k5HQA:1sWYBe:PuTj8yxfVl_aZhT6WtU_B4zspWOpyTQpIZCk_O2xaEM	2024-08-07 09:21:30.128931+00
zmjp03iv4vsme2jvku78zrwmxa9sbiit	.eJxVTrsOwiAU_RfmhiCP0nZ09xvIBS4tasBAm2iM_y5NOuhyhvN-EwPbupitYjHRk4kMpPvlLLgbpl3wV0hzpi6ntURLdws91Eov2eP9fHj_ChaoS0tbKUbLA2rkXgtnmVUMnBQSTgpBcADOAOyoe-6HAXopgwxCaKZ8rxrupRVrjTkZfD5ieZGJdccpc2-4wYxtKBTy-QKjXUbX:1sWYaD:BbaMZmcaA-RKjiOCTB38dOBQNRQpoyTCxY-OqgYQrTQ	2024-08-07 09:46:53.634456+00
ed7fwvcllq61jctifu2texzoytu8vjnx	.eJxVjr0OwyAMhN-FOUKQPyUZu_cZkG1MQhtBBYnUquq7l0gZ2sXDfXfnewsD-7aYPXMy3opJNKL61RDozuEA9gZhjpJi2JJHeVjkSbO8Rsvr5fT-FSyQl5IekEawzjJ0VGOrQKEm6rhF1q1r6l67thkHctYW0Pfaggana6WwQyZ1lGbO2cdg-Pnw6SUmVZ2jzFruDjOXRy6JzxcT1Uhs:1sWkEw:MWgLKjsV_bplZmzChtRZJ2Ih5jHIhasGSsCBw08zKoU	2024-08-07 22:13:42.628668+00
4fw9hksqireyq4k2lbsk8ghjfigy0aad	.eJxVTkkOwiAUvQvrhjBIkS7dewbyP0OLNmCgTTTGu9smXejmLd78JhbWZbJrC9UmTwYiJel-SQR3D3lX_A3yWKgreakJ6W6hh9rotfgwXw7vX8EEbdrS6KPuwUDkwgNop4LRBkFGxhWPyPogjO75yYCLUghkgjsTUagzKqYk30tbaC2VbMPzkeqLDKw7Ttl5wxXGsA3FSj5f5k5HQA:1sXBGI:2yJcxw2SoLuYrrsLxchVvGslmwRK22GHJ0k0dGg6p3g	2024-08-09 03:04:54.610304+00
z7jwu7wrult56q0c17mx91yg3c0qpt8r	.eJxVjsEOgyAQRP-FsyGgaNRj7_0GsrssSmugEU3aNP33YuKhvexh3szsvIWFfZvtnnm1wYlRNKL61RDozvEA7gZxSpJS3NaA8rDIk2Z5TY6Xy-n9K5ghzyXdIw3gvGNoqUajQKEmatkga-ObutPeNENP3rkCuk470OB1rRS2yKSO0sw5hxQtPx9hfYlRVecou5S7w8TlEUfx-QITxUhn:1sXFSt:2wQuSKdv-rxf_Wo7ZlYBaFnYYaf2F2MDH4Fh3Yhc2zg	2024-08-09 07:34:11.753277+00
ke3p9izbb6vd6knxq5e6h7iutzmpurjp	.eJxVjk0OwiAUhO_CuiEPSqF06d4zEH4eLWqogTbRGO9ua7rQzSxmJt_Mixi7LpNZKxaTAhlIy0jzazrrr5j3JFxsHmfq57yU5OheoUda6XkOeDsd3T_AZOv05TIhdPTcd1E4Ab4PABZYrznIIFUrAV0rfdBOMYaCOxU70H2npJWB4w6tWGuas8HHPZUnGaA5TpnbpqsdcRuKhbw_ew1GVQ:1sXGJD:CTvKhnELMQ44hmSYqbH8sj_iI3DDgoHk9mgRBKMPjRo	2024-08-09 08:28:15.1155+00
8kq84sw1iq8pr0lqglq200iaxng7aqp9	.eJxVjEEOwiAQRe_C2hCg7TC4dO8ZyDBMpWpoUtqV8e7apAvd_vfef6lI21ri1mSJU1ZnZdXpd0vED6k7yHeqt1nzXNdlSnpX9EGbvs5ZnpfD_Tso1Mq3TpAEs5URex7AemfSYDIKhxAMOE8gtg8dsxtgNL3p2PsxABBiIouk3h_e3TeE:1sXHyt:SLrpJc8SoL2u_LNlCLVKuPWVbi5F_mew3T7XfvGS5-4	2024-08-09 10:15:23.412477+00
v2stuqx7wzoc1fg3oosxkjxxasaoal5b	.eJxVjsEOgyAQRP-FsyGgaNRj7_0GsrssSmugEU3aNP33YuKhvexh3szsvIWFfZvtnnm1wYlRNKL61RDozvEA7gZxSpJS3NaA8rDIk2Z5TY6Xy-n9K5ghzyXdIw3gvGNoqUajQKEmatkga-ObutPeNENP3rkCuk470OB1rRS2yKSO0sw5hxQtPx9hfYlRVecou5S7w8TlEUfx-QITxUhn:1sXNno:aY0wn7NSYCIR3DVmymX38C552eAT62WAechZt4sKgGI	2024-08-09 16:28:20.935555+00
8ar0gz9sc7xdnkjueuhh66eezn1hpudy	.eJxVTksOgjAQvUvXpKFOC5Sle8_QdDpTqJpiKCQa492FhIVu3uL938L5dRndWnh2iUQvwIjql0Qfbpx3ha4-D5MMU17mhHK3yEMt8jIR38-H969g9GXc0oobS4TURgUniNh4jZa85dgwqdqCsQjaMijsNBCiAR1N22kLIRjT7KWFS0lTdvx8pPkl-ro6Trn7hqsfeBviLD5f6ohHYg:1sXOAA:Vq6SVf4evJro1bncIAXpS7VQNO-B7LTj759w6DzRBNY	2024-08-09 16:51:26.241178+00
p2izme8rjupkvvozcd5b71yxg7gi42ft	.eJxVTksOgjAQvUvXpKFOC5Sle8_QdDpTqJpiKCQa492FhIVu3uL938L5dRndWnh2iUQvwIjql0Qfbpx3ha4-D5MMU17mhHK3yEMt8jIR38-H969g9GXc0oobS4TURgUniNh4jZa85dgwqdqCsQjaMijsNBCiAR1N22kLIRjT7KWFS0lTdvx8pPkl-ro6Trn7hqsfeBviLD5f6ohHYg:1sXOU2:e887M6C45VK9XYfT4dq7szbJlP6Ig1qJV01ZR9jO1Fc	2024-08-09 17:11:58.287962+00
x2152h31rhff6gig3hw0y2zcqnb5glzv	.eJxVTksOgjAQvUvXpKFOC5Sle8_QdDpTqJpiKCQa492FhIVu3uL938L5dRndWnh2iUQvwIjql0Qfbpx3ha4-D5MMU17mhHK3yEMt8jIR38-H969g9GXc0oobS4TURgUniNh4jZa85dgwqdqCsQjaMijsNBCiAR1N22kLIRjT7KWFS0lTdvx8pPkl-ro6Trn7hqsfeBviLD5f6ohHYg:1sXOlN:XDqSOgdN5hdTE2MIpy-nuXvwp9L80Sf5JdtpvnuceIw	2024-08-09 17:29:53.130545+00
ca052negep1g9c59jq9r88wn6pvg9yta	.eJxVjr0OwyAMhN-FOUKQPyUZu_cZkG1MQhtBBYnUquq7l0gZ2sXDfXfnewsD-7aYPXMy3opJNKL61RDozuEA9gZhjpJi2JJHeVjkSbO8Rsvr5fT-FSyQl5IekEawzjJ0VGOrQKEm6rhF1q1r6l67thkHctYW0Pfaggana6WwQyZ1lGbO2cdg-Pnw6SUmVZ2jzFruDjOXRy6JzxcT1Uhs:1sXS5r:uROeLZsn_ljDpaLbZjD2JgONClBEfvJgaV5DqSn6PNk	2024-08-09 21:03:15.310828+00
43m66q39njot8wrxdkxg7cs78vo79lrm	.eJxVTksOgyAQvQtrQxA_gMvuewYyMoPSGmhAkzZN715NXLSbt3j_N7OwrbPdCmUbkA2sVqz6JUdwd4qHgjeIU-IuxTWHkR8WfqqFXxPScjm9fwUzlHlPK-_AaOhRa9m3qjEEXhBhJxFHoQS1KLtGemqEbrVWwniDiqSTdQ-N10dpoVJCipaej5BfbBDVecouO24w0T7kM_t8AdRDRz0:1sXSwU:9RIasT1dgoQ7S_pZuVMGOBvJi7qGGqz_TETl1ziOcNI	2024-08-09 21:57:38.176804+00
vzaa1e2cegrrmuf0jl6cnfjna3l7h7pi	.eJxVjMsOwiAQRf-FtSG0Q3l06d5vIDADFjVgSptojP-uTbrQ7T3nnhdzfl0mt7Y4u0xsZJIdfrfg8RrLBujiy7lyrGWZc-Cbwnfa-KlSvB139y8w-TZ93ymASVpY0EkPdlCdQcLQD0Ted2hlryyiQaRAoDSA12CUiB0kZYSkuEVbbC3X4uLjnucnG8X7A5t7P1U:1sXT1m:2kdIFDrTM9qNxqA-4S8eiA55y2zd1B7Gb5vqfb_1VSg	2024-08-09 22:03:06.122496+00
5et0luyy0cw4nqbz0w16v3cwhr6hr7au	.eJxVjE0OgjAYBe_StWlaKARYuvcMzfdXqZrWUEgwxrsLCQvdvpk3b-VhmUe_FJl8ZDWoWp1-NwS6S9oB3yBds6ac5imi3hV90KIvmeVxPty_wAhl3N4dUg8cWKChCp0Bg5aoEYdiXair1gZX9x0F5g20rWWwEGxlDDYoZPZokVJiTl7WZ5xeajCfL-kqQJA:1sXbSO:hm78Zk6abp28z5-PjsuSrlKmU12ZH9alE1198Yx5geA	2024-08-10 07:03:08.763114+00
7pd0izrwyoz7s86lraxeb7urvrvsww86	.eJxVjMsOwiAQRf-FtSG0w7NL934DgWFqUQOmtInG-O_apAvd3nPueTEf1mXya6PZ58QG1rPD7xYDXqlsIF1COVeOtSxzjnxT-E4bP9VEt-Pu_gWm0KbvGwAFkpTOaBdHctaBCTrIEZXFBB2JHpTVxtkOFSQxWic02F4ZjIZU3KKNWsu1eHrc8_xkg3h_AGvzPnQ:1sXbYQ:cOqwF0A532LgXMRu1wD5XhSoQeDXWUcRsEa0XTv8RXM	2024-08-10 07:09:22.069918+00
t5thleg32zhb2qokksceyf4t3gznp5fl	.eJxVjE0OgjAYBe_StWlaKARYuvcMzfdXqZrWUEgwxrsLCQvdvpk3b-VhmUe_FJl8ZDWoWp1-NwS6S9oB3yBds6ac5imi3hV90KIvmeVxPty_wAhl3N4dUg8cWKChCp0Bg5aoEYdiXair1gZX9x0F5g20rWWwEGxlDDYoZPZokVJiTl7WZ5xeajCfL-kqQJA:1sXlWj:oFNr-gcD426Iz8P9sbhLtEVLMe4cBPF0j58ZnIuQbzc	2024-08-10 17:48:17.212153+00
0gkjrk4x5hp1a9onisciv7bc4emfy2c3	.eJxVjMEOwiAQRP-FsyFLt4B69O43kIUFixowpU00xn-3TXrQ22TmzXsLR_M0uLnF0WUWR6FA7H5LT-EWy7rwlcqlylDLNGYvV0Rua5PnyvF-2tg_wUBtWN6AkNI-KUBjtUmelEpL8pqArbHYA3bcGU2WeqMtHkIXMDCzJYtB9au0xdZyLS4-H3l8iSN8voUiPqI:1sXqoT:tKBQEo5XN_qSlN7rWwuqb4sFsikJg-l9xJ-VIjnw_-I	2024-08-10 23:26:57.662484+00
rx5ftedpzn7a9gfzwd7voxdl66jj3xnc	.eJxVTrsOgyAU_RdmQ3grjt37DQQuF6U12IgmbZr-ezVxaJcznPebOL-to9sqLi5H0hOuSPNLBg93LIcSb74MM4W5rEsO9LDQU630OkecLqf3r2D0ddzTMnFlrWKyM53VQYQkWjApMYCgtUDGMPIWPAgwjAfppTdJolYdcpakPUor1prn4vD5yMuL9Kw5T7lpx80PuA9hIZ8vsNRHDg:1sXqwc:3LSc_MXlitrVYxB8CWrzZVCQ2g4NSVVbFIzm5rcuYzA	2024-08-10 23:35:22.491743+00
wuke9ksm2b0fw7jk7ney20gdb7footxi	.eJxVjEEOwiAQRe_C2pDiAC0u3XsGwjCDRQ2Y0iYa4921SRe6_e_99xI-LPPol8aTzyQOAozY_Y4Y4pXLSugSyrnKWMs8ZZSrIjfa5KkS346b-xcYQxu_b8XWESH1ScEeEtqg0VFwnCyT6hwYh6Adg8JBAyEa0Mn0g3YQozF2jTZuLdfi-XHP01McuvcH128_iw:1sXrZ3:daIy7fpDN0dbg4JTp0q_LZzlk6ESTwY3a3xGQlMmjbQ	2024-08-11 00:15:05.676052+00
3yg0a5rdg73dulst9joxtyq8m19kckdd	.eJxVjMEOwiAQRP-FsyFLt4B69O43kIUFixowpU00xn-3TXrQ22TmzXsLR_M0uLnF0WUWR6FA7H5LT-EWy7rwlcqlylDLNGYvV0Rua5PnyvF-2tg_wUBtWN6AkNI-KUBjtUmelEpL8pqArbHYA3bcGU2WeqMtHkIXMDCzJYtB9au0xdZyLS4-H3l8iSN8voUiPqI:1sXsMl:smyhc2gcsKbdTuvqgJmcsy4J0L4heovTd34TIQ_ynCE	2024-08-11 01:06:27.269764+00
0167xpyp52q0jnpl8f5vjg0ba2te7he1	.eJxVjMEOwiAQRP-FsyFLt4B69O43kIUFixowpU00xn-3TXrQ22TmzXsLR_M0uLnF0WUWR6FA7H5LT-EWy7rwlcqlylDLNGYvV0Rua5PnyvF-2tg_wUBtWN6AkNI-KUBjtUmelEpL8pqArbHYA3bcGU2WeqMtHkIXMDCzJYtB9au0xdZyLS4-H3l8iSN8voUiPqI:1sXscE:elEPqjSMrRTmi9Yfl0uajbB2mFmlfWin0MISBhmojCE	2024-08-11 01:22:26.680101+00
5k54pzfekhg5nas6i5klvu494t8xme3a	.eJxVjE0OgjAYBe_StWlaKARYuvcMzfdXqZrWUEgwxrsLCQvdvpk3b-VhmUe_FJl8ZDWoWp1-NwS6S9oB3yBds6ac5imi3hV90KIvmeVxPty_wAhl3N4dUg8cWKChCp0Bg5aoEYdiXair1gZX9x0F5g20rWWwEGxlDDYoZPZokVJiTl7WZ5xeajCfL-kqQJA:1sXshs:FuPriFZeQtz-aG4DFqPnCDKCQM3MHY92KhvLCUwArQg	2024-08-11 01:28:16.995335+00
o6dhmxhv0pogfrxogjd4bbgraofctpqd	.eJxVjMEOwiAQRP-FsyFLt4B69O43kIUFixowpU00xn-3TXrQ22TmzXsLR_M0uLnF0WUWR6FA7H5LT-EWy7rwlcqlylDLNGYvV0Rua5PnyvF-2tg_wUBtWN6AkNI-KUBjtUmelEpL8pqArbHYA3bcGU2WeqMtHkIXMDCzJYtB9au0xdZyLS4-H3l8iSN8voUiPqI:1sXspg:elU0df8KXl0tn5AftgEZa5u6w4Hoph0Cv6gKpj2MABk	2024-08-11 01:36:20.81777+00
naiimtamocltz7te1xx06m8x3m5fgkxr	.eJxVjMEOwiAQRP-FsyFLt4B69O43kIUFixowpU00xn-3TXrQ22TmzXsLR_M0uLnF0WUWR6FA7H5LT-EWy7rwlcqlylDLNGYvV0Rua5PnyvF-2tg_wUBtWN6AkNI-KUBjtUmelEpL8pqArbHYA3bcGU2WeqMtHkIXMDCzJYtB9au0xdZyLS4-H3l8iSN8voUiPqI:1sXsr6:Zy8ESOAM_BKYfkw_8OL_z27i8KgEmpTA4fjajl5zCYY	2024-08-11 01:37:48.515239+00
la7tjitl90ji1xjb2tnhu19k1x1dn5qy	.eJxVjsEOgyAQRP-FsyGgaNRj7_0GsrssSmugEU3aNP33YuKhvexh3szsvIWFfZvtnnm1wYlRNKL61RDozvEA7gZxSpJS3NaA8rDIk2Z5TY6Xy-n9K5ghzyXdIw3gvGNoqUajQKEmatkga-ObutPeNENP3rkCuk470OB1rRS2yKSO0sw5hxQtPx9hfYlRVecou5S7w8TlEUfx-QITxUhn:1sXyUf:6KxaeV7S9BuLJnc6zZpuQMLS_H87OqHEoq6lGommXiY	2024-08-11 07:39:01.762771+00
z76wpm2j4rcrd71eyojl4hh28etwtuwl	.eJxVjE0OgjAYBe_StWlaKARYuvcMzfdXqZrWUEgwxrsLCQvdvpk3b-VhmUe_FJl8ZDWoWp1-NwS6S9oB3yBds6ac5imi3hV90KIvmeVxPty_wAhl3N4dUg8cWKChCp0Bg5aoEYdiXair1gZX9x0F5g20rWWwEGxlDDYoZPZokVJiTl7WZ5xeajCfL-kqQJA:1sY4Xl:G4fg6mZ_r7bP3U80aSp1IsTYTaDO6abP2blnTZnkDBI	2024-08-11 14:06:37.829019+00
6m1jz1470vtlqudnk5albw12lko1x57l	.eJxVjEEOwiAQRe_C2pCBEWq7dO8ZCDCDRQ2Y0iYa4921SRe6_e_99xLOL_PolsaTyyQGgb3Y_Y7BxyuXldDFl3OVsZZ5ykGuitxok6dKfDtu7l9g9G38vhP05HUg6oLRgEYpRCJOoEFZE7mzTDFFo731e2tQxcQdHygAWEKFa7Rxa7kWx497np5igPcH02w_uw:1sY8qL:gx2W2GlpIGpYR8VHfLUE2puuyQpNRPlUVhVJM6z0O78	2024-08-11 18:42:05.508962+00
68uk7ma8x7b55rm0wyr3i7avc2w2p1dc	.eJxVjMEOwiAQRP-FsyFLt4B69O43kIUFixowpU00xn-3TXrQ22TmzXsLR_M0uLnF0WUWR6FA7H5LT-EWy7rwlcqlylDLNGYvV0Rua5PnyvF-2tg_wUBtWN6AkNI-KUBjtUmelEpL8pqArbHYA3bcGU2WeqMtHkIXMDCzJYtB9au0xdZyLS4-H3l8iSN8voUiPqI:1sYLmY:G7yEvHHwy0784AbBxUdTFB_70ED-mFV1eAaG4T6HerY	2024-08-12 08:31:02.922034+00
baxrhekv16ktjanydqhkj32c5ma98fs3	.eJxVjMsOwiAQRf-FtSE8pEiX7v0GMgODRQ0YaBON8d-1SRe6vefc82IelnnyS6fmc2Qj05rtfkeEcKWykniBcq481DK3jHxV-EY7P9VIt-Pm_gUm6NP3jTHZARwkqSKADYacdQg6CWlkQjGQcnaQewchaaVQKBlcQmUOaITRco126j3X4ulxz-3JRvH-ANamP2Q:1sYM4n:R3tt4MDTgS7FVnXFm-PRD4tw2zyhjpFEEhBpLYm0Xrk	2024-08-12 08:49:53.119669+00
plqqx3yu4umd2x6kj0fjhohchxbhxrx7	.eJxVjEEOwiAQRe_C2pDiAC0u3XsGwjCDRQ2Y0iYa4921SRe6_e_99xI-LPPol8aTzyQOAozY_Y4Y4pXLSugSyrnKWMs8ZZSrIjfa5KkS346b-xcYQxu_b8XWESH1ScEeEtqg0VFwnCyT6hwYh6Adg8JBAyEa0Mn0g3YQozF2jTZuLdfi-XHP01McuvcH128_iw:1sYM7w:_ap2HHS4J-QgsdL0-fljE0_B0ExknKLZt1jZqi8zUZA	2024-08-12 08:53:08.039201+00
boshdn9ikiv19ov617d7lhzlgwgr7udi	.eJxVjEEOwiAQRe_C2pDiAC0u3XsGwjCDRQ2Y0iYa4921SRe6_e_99xI-LPPol8aTzyQOAozY_Y4Y4pXLSugSyrnKWMs8ZZSrIjfa5KkS346b-xcYQxu_b8XWESH1ScEeEtqg0VFwnCyT6hwYh6Adg8JBAyEa0Mn0g3YQozF2jTZuLdfi-XHP01McuvcH128_iw:1sYMCR:mRtC-u1ibnsxpNqKxd5TOSdU2iM2vlLEMHk3pdMG9LI	2024-08-12 08:57:47.671801+00
1essetkhci2fqn0e1k86v64uawuny5n6	.eJxVjEEOwiAQRe_C2hAKbRm6dO8ZyJQZLGrAlDbRGO-uTbrQ7X_vv5fwuC6TXyvPPpEYRGPF4XccMVw5b4QumM9FhpKXOY1yU-ROqzwV4ttxd_8CE9bp-7YxoAPsCUD3rTWOMSpm6jTRqKzilnRndGSjoAWwykVHlnXQTY8mwhatXGsq2fPjnuanGNT7A8TgP2E:1sYZUY:BO988GZwYgGS6xvIJbnB2vaupJYOAi2KvzoObgQgMZ8	2024-08-12 23:09:22.305704+00
6mugwxhiwye4b0dj2kfaolke74ezb1pm	.eJxVjEEOwiAQRe_C2hDGwkxx6b5nIMMAtmpoUtqV8e7apAvd_vfef6nA2zqGreUlTEldlDXq9DtGlkeuO0l3rrdZy1zXZYp6V_RBmx7mlJ_Xw_07GLmN39ozIXfiICF5AioFyJmCbCQKoUMDEi2SzXLOvrfUIUBvXOkxduhJvT_wWTcA:1sYZW8:iJKoRqoFkg_nWvxFv5zyyFVwl4f9taYSXdSp60rOxo8	2024-08-12 23:11:00.012941+00
6w0arrz4y8njfd5i5ksrwe6vut6iwlgu	.eJxVjMsOwiAQRf-FtSG0w7NL934DgWFqUQOmtInG-O_apAvd3nPueTEf1mXya6PZ58QG1rPD7xYDXqlsIF1COVeOtSxzjnxT-E4bP9VEt-Pu_gWm0KbvGwAFkpTOaBdHctaBCTrIEZXFBB2JHpTVxtkOFSQxWic02F4ZjIZU3KKNWsu1eHrc8_xkg3h_AGvzPnQ:1sYb0m:c0Hkq9y4m6EUrCFbI30zDtq438nqGi3Cx4zjThxuBUM	2024-08-13 00:46:44.044973+00
dgk8bzeko4gxvvrypg6ptrj8oefgxo15	.eJxVTrsOgyAU_RdmQ1Dk5di930DgclVaAw1o0qbpv1cTh3Y5w3m_iXXbOtutYrExkIF0pPnlvIM7pkMIN5emTCGntURPDws91UqvOeByOb1_BbOr857mHBhg3xsljR_RaMOVk64fQWgIvEXWcaGlMroFwQMbtWGS604o8AqFP0or1hpzsvh8xPIiA2vOU3bZcXMT7kOukM8XZfdGSw:1sYbTj:Van-1j3hxsNmsW2lMdeRlmSjPjrPMxdLk7LvruOAobU	2024-08-13 01:16:39.176721+00
ysoh7g49cc1ekbvj1sasqd381ze2tlew	.eJxVjMEOwiAQRP-FsyFLt4B69O43kIUFixowpU00xn-3TXrQ22TmzXsLR_M0uLnF0WUWR6FA7H5LT-EWy7rwlcqlylDLNGYvV0Rua5PnyvF-2tg_wUBtWN6AkNI-KUBjtUmelEpL8pqArbHYA3bcGU2WeqMtHkIXMDCzJYtB9au0xdZyLS4-H3l8iSN8voUiPqI:1sYb56:fYCd6hugDkEQXMbHebEx_h3nbBuO8Z5eR4iODZ3MbmA	2024-08-13 00:51:12.591096+00
xikkutmxfesfcn51idugog3ncdx7mtfd	.eJxVjMEOwiAQRP-FsyFLt4B69O43kIUFixowpU00xn-3TXrQ22TmzXsLR_M0uLnF0WUWR6FA7H5LT-EWy7rwlcqlylDLNGYvV0Rua5PnyvF-2tg_wUBtWN6AkNI-KUBjtUmelEpL8pqArbHYA3bcGU2WeqMtHkIXMDCzJYtB9au0xdZyLS4-H3l8iSN8voUiPqI:1sYb8g:Pv-5G2f0AjmHDe5woImdfw56sf7N66LoAbXFBvg5--8	2024-08-13 00:54:54.774087+00
1xheoykw0lyzy3ybjx92pgeo4x0fhh2u	.eJxVjMEOwiAQRP-FsyFLt4B69O43kIUFixowpU00xn-3TXrQ22TmzXsLR_M0uLnF0WUWR6FA7H5LT-EWy7rwlcqlylDLNGYvV0Rua5PnyvF-2tg_wUBtWN6AkNI-KUBjtUmelEpL8pqArbHYA3bcGU2WeqMtHkIXMDCzJYtB9au0xdZyLS4-H3l8iSN8voUiPqI:1sYbWg:-xZqltG9k1O9IGFiCNS8B72YMDM42T8_GeYogE4xkvI	2024-08-13 01:19:42.086069+00
mt9hokn8htbx2z4gt6kqqqlpv6c4hcaz	.eJxVjMsOwiAQRf-FtSE8pEiX7v0GMgODRQ0YaBON8d-1SRe6vefc82IelnnyS6fmc2Qj05rtfkeEcKWykniBcq481DK3jHxV-EY7P9VIt-Pm_gUm6NP3jTHZARwkqSKADYacdQg6CWlkQjGQcnaQewchaaVQKBlcQmUOaITRco126j3X4ulxz-3JRvH-ANamP2Q:1sYbXS:CTULWdIv5mYs-ZNWqZ61g0SA8wWqGUOcdVUo4lwtN4A	2024-08-13 01:20:30.067348+00
1jnphzvixoy9xro9jag16cu7b1p0jlfh	.eJxVjEEOwiAQRe_C2hBA2mm7dO8ZyMAMFjXQlDbRGO-uTbrQ7X_vv5dwuC6jWyvPLpEYhBGH381juHHeAF0xX4oMJS9z8nJT5E6rPBfi-2l3_wIj1vH7BmV1Y9G3R28jgW4gQFTect8Z1KZjMNEq0NATUjSkbRu5CQjRgGHqtmjlWlPJjh9Tmp9iUO8PeSg_Fw:1sYgpK:49lHKw0aHbUZYHr_1ehL0qsDqQr_v_jR0b1l91XH1M0	2024-08-13 06:59:18.300685+00
m81atmpaun6brj30wuh8lawtrggquwj6	.eJxVjEEOwiAQRe_C2hAGCgWX7j0DmWFAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xYnEWIE6_G2F65LYDvmO7zTLNbV0mkrsiD9rldeb8vBzu30HFXr-1YjN45YdEiFByMBys1jw6cKiYnEmMCiCMgGgteet1NojkCxQ24MT7A99qN-g:1sYr51:R1Cp5CicG0qDEMnKmMAvjo1Z7wRn_xmZkfMQFxVxfCc	2024-08-13 17:56:11.906218+00
1wgg0qvq471mtbkqcq5omyn98sb867ep	.eJxVjMEOwiAQRP-FsyGLpWvp0bvfQIDdWtRAA22iMf67bdKD3mbmzcxbWLfMo10qFxtJ9EKDOPyG3oU7p43QzaVrliGnuUQvt4rcaZWXTPw4792_g9HVcV0b3SCjC6r1hAHcoD2TxiEg6BYbYFy9OiKR6TwbAG47s0qFajixUdtp5VpjTpafUywv0cPnC8oqP4I:1sZDwe:JW19W6A05NjYxxBlPg9ACJAqrA8QC_uDB-CupqH7OPo	2024-08-14 18:21:04.442888+00
1rxsm5js0ohxygo5raif2o2kcetofxix	.eJxVjMsOwiAQRf-FtSGUl8Wle7-BMMxgUQOmtInG-O9K0oVuzzn3vpgP6zL5tdHsM7IDU4btfiGEeKXSDV5COVcea1nmDLwnfLONnyrS7bi1fwdTaFNfJ2OQRpkS2iRAWXBSR_2FCkEAKutw0Ck5HJVG6TDGBANZI_daSDf200at5Vo8Pe55frKDeH8A6po_6Q:1sZsKH:Zbl303Xv5Ft8NSN7TglkbrYHo_jlKbLOrwXFedyafJc	2024-08-16 13:28:09.685633+00
l6s1pgdsf7m7noxi64wjijm94yfbi026	.eJxVjk0OwiAYRO_C2hB-bLVduvcMBJivFjXQQJtojHeXmi50-97MZF7M2GUezVIomwDWM63Z7hc6628UV4OrjZfEfYpzDo6vEb7Zws8JdD9t2b-B0ZaxtgmqUWi7TjUHKNV2wkL7VkoJQUe4PUH4wXnrpFMYACngG10LolJ8XxUqJaRo6DGF_GS9eH8A1chATA:1sZuOd:UkW9usKO8s-DL8kLkO2LOHeaQrDhMmb3AX3NJXCOnFE	2024-08-16 15:40:47.762455+00
p03afpzbm8731let2pcy966stnki3m97	.eJxVjMsOwiAQRf-FtSHAlEK7dO83kBkeFjVgSptojP-uTbrQ7T3nnhdzuC6TW1ucXQ5sZGDY4Xck9NdYNhIuWM6V-1qWORPfFL7Txk81xNtxd_8CE7bp--5SlygRgNWgrAwDdTKSFgITCm8lkRws9cmAMmCUQKU1CC-jIjN42W_RFlvLtbj4uOf5yUbx_gCqnj7Q:1sZud6:AoRBtx84dtqRGj684jCV64LfEjWyLqGyA4OX5PVT9Rg	2024-08-16 15:55:44.939845+00
l20lhs98zdkbx5s960og0ltctuf3mqxe	.eJxVjEEOwiAQRe_C2hA6haHp0r1nIAMMFjVgSptojHfXJl3o9r_330s4WpfJrY1nl6MYRS8Ov5uncOWygXihcq4y1LLM2ctNkTtt8lQj3467-xeYqE3fNwB6hYQGjObU22AiYuyNAgZjdQIKzIg2eRW07Yi00Z0Z7JACRrBhizZuLdfi-HHP81OM6v0BawU-sg:1saFY2:YExArj53JY_Zk3AwVBJvS7bFvEzu9VkLsfIryrMxTn8	2024-08-17 14:15:54.842204+00
ptt6df8iv8g8krmu87v5ysfn1fx6hiwh	e30:1sb9vF:g-1li3gO8oKv_q6cldTCmWhElHYGCMbmEC-zcOobvYY	2024-08-20 02:27:37.084262+00
amv9512j0fpzb5mkqwaa67g9kgf4veq7	.eJxVTksOwiAQvQtr05RSGHCnF2kGZgjEhiZCV8a7W0wXunz_9xIL7i0te-XnkklcxazE5Zf0GB5cuoLr2ukBQ9j20oav55TrcDsQl5YDtryV-5n6q0pYU1-QYBloMnE2EZUjcgQjWXBGWS05woTRgSHJ0hjtR9BWcfDkJWh3_Ht_ANdlPBg:1sbALd:Uz78jNV5IaJg-Z0eRvd_JseCTiWIIB5kOYgiM5mdpS8	2024-08-20 02:54:53.281825+00
cntqnw1auh0vb3746evbemnsaxtwy6sn	.eJxVjEEOwiAQRe_C2hAYhIJL956BzMAgVUOT0q6MdzckXej2v_f-W0Tctxr3zmucs7gILU6_G2F6chsgP7DdF5mWtq0zyaHIg3Z5WzK_rof7d1Cx11GT1tYZ0EQWvVcJiCFZUwC9VVyChmSgUCnobMBz4OydmQKT4sllLz5f6Fg4NA:1sbBQt:xtUCkQDVljAEw4tcx2QZ5Qhi5BD7st6n8UCvdRz57v0	2024-08-20 04:04:23.656056+00
drsnsq1n42hh69deaw3nnzb8h5bha331	.eJxVjEEOwiAQRe_C2pCBobXt0r1nIAwdLGqgKW2iMd5dSbrQ7X_vv5ewblsnuxVebBzFIBoQh9-RnL9xqmS8unTJ0ue0LpFkVeROizznke-n3f0LTK5M37cJBEi9Bu3ZQKtVj6Q1tWyaBhE1osFAR_bKeyYKGoKCrlMOfDWxRguXEnOy_Jjj8hQDvD-LJT60:1sbBv3:AKRZ0Vku41c8g9NOg5yolp_AqzVAK-j4RNau805fAAQ	2024-08-20 04:35:33.034248+00
tiaupst3tt2kv6kxmgbwl4jzwby9kh3v	.eJxVjM0OwiAQhN-Fs2n46ZbiTV-kWZYlEBuaCD0Z391ietDjzDffvMSCe0vLXvm55CCuApS4_JYe6cGlE1zXXg9ItO2lDd_NietwOxKXlglb3sr9tP6uEtbUf0YAYAvTpK2SGohDjPNIxArYsNHkLHrn2Ek5B4yoArBXnnUw-vDE-wPlbz0O:1sbC1g:PLTQjL5Dm5Woul5_ghagN32s_5g1-Dc2PADsg8qPdw0	2024-08-20 04:42:24.417803+00
ynyb5yzyvmlw4yd06sddl2uckp60n1o9	e30:1sbCFp:rtR3BzC_3SfZWP9_kOUUZUa7XiRSUa-Lq8eufFHPUJw	2024-08-20 04:57:01.066533+00
ndqc2583nocd8nk45r383nqiu534vz4u	e30:1sbCmk:zdolB1nooE7MyinVvbDlIJ6-u138Naxxt8ciaU0Cj7c	2024-08-20 05:31:02.427955+00
czo12fsuqdfhzv51koy26w6xfdvnd2w2	e30:1sbCvV:2tmSGBG9G4Kw27cB1lZKGoU3OlvJEYihLLR_z0gyZGU	2024-08-20 05:40:05.603173+00
zya6dze0zqr8uhxdfs2f9g6vqndkdpol	e30:1sbCy4:eQENM3otWEpI1C-pMwcXSqOUzHQw-k0-2iHmQY0Cu3s	2024-08-20 05:42:44.748415+00
6iem3zhh40llcanqfbmi2npbetdnea9t	.eJxVjEEOwiAQRe_C2hAYhIJL956BzMAgVUOT0q6MdzckXej2v_f-W0Tctxr3zmucs7gILU6_G2F6chsgP7DdF5mWtq0zyaHIg3Z5WzK_rof7d1Cx11GT1tYZ0EQWvVcJiCFZUwC9VVyChmSgUCnobMBz4OydmQKT4sllLz5f6Fg4NA:1sbDni:HvOzD24j2z6UIzga6TdCpL5zi6kewD1KxELOSsSPhJM	2024-08-20 06:36:06.690833+00
co2cv2k32kqt0p6900cyz3e75qihkk2m	.eJxVjEEOwiAQRe_C2hAYhIJL956BzMAgVUOT0q6MdzckXej2v_f-W0Tctxr3zmucs7gILU6_G2F6chsgP7DdF5mWtq0zyaHIg3Z5WzK_rof7d1Cx11GT1tYZ0EQWvVcJiCFZUwC9VVyChmSgUCnobMBz4OydmQKT4sllLz5f6Fg4NA:1sbDqe:1r6McmDXeTqomAXtOuUh6NBEaG8ycmFDfhw3MubmsQI	2024-08-20 06:39:08.264884+00
09pq3o8nirlkhtq7687m08ikjvcnvtmu	.eJxVjEEOwiAQRe_C2hAYhIJL956BzMAgVUOT0q6MdzckXej2v_f-W0Tctxr3zmucs7gILU6_G2F6chsgP7DdF5mWtq0zyaHIg3Z5WzK_rof7d1Cx11GT1tYZ0EQWvVcJiCFZUwC9VVyChmSgUCnobMBz4OydmQKT4sllLz5f6Fg4NA:1sbDwq:ysFiSzP-W0lrLGtO94WcfKJ2BGe0vRSgz88zifVl_FQ	2024-08-20 06:45:32.1811+00
sbkxtvsc3wwty4qjzbr6jj37i0fgsel3	e30:1sbFF2:ae5HFRZ61dEXr1gAPRIpMHSOsGx3E_50cahwDYwi23A	2024-08-20 08:08:24.577769+00
dl01f2904bq3uthnmqejliik0sdokjw6	e30:1sbFND:1BLeq9QcaJ-qH5pLXYT53kVZfzmalfpF-ZfxUtqFMsY	2024-08-20 08:16:51.158368+00
44pskpq5si3l8npfzistkiohwbd50czt	.eJxVjEEOwiAQRe_C2hAYhIJL956BzMAgVUOT0q6MdzckXej2v_f-W0Tctxr3zmucs7gILU6_G2F6chsgP7DdF5mWtq0zyaHIg3Z5WzK_rof7d1Cx11GT1tYZ0EQWvVcJiCFZUwC9VVyChmSgUCnobMBz4OydmQKT4sllLz5f6Fg4NA:1sbJ1x:M2RxOSx6sAZcFAaM6_xEJuLibj7rbBefKAZpXtuFJLE	2024-08-20 12:11:09.980242+00
141807ljbmw7f70u9g5ad5h9dsexek4m	.eJxVjsEOwiAQRP-Fc0NooQV69O43kAWWFjVgSptojP8uNT3oZQ8zb2bnRQxs62y2gouJnoykZaT5FS24K6bd8RdIU6Yup3WJlu4IPdxCz9nj7XSwfwUzlLmmRacEb6WVOrTaorNed1xAzzjvBi50kKCYAjn0okKqDwq4BQiBuSCD-64qWErMyeDjHpcnGVlzjDK3ejeYsD7CRN4flgZG8w:1scBIM:53R2HKphMSdV8pkQ6iPRjpTNslwW6twAYqz8aLUkcBA	2024-08-22 22:07:42.926568+00
z7z9mrhqtnf9hzwlp9c38mnsuzu3r1mp	.eJxVjssOwiAURP-FtSFQaIEu3fsN5PK4ghowpU00xn-3NV3ods6ZybyIhWVOdmlxsjmQkXBGDr-hA3-NZSPhAuVcqa9lnrKjm0J32uiphng77u7fQIKW1rbstBRcOWWQGxe9C6YTEnomRDcIaVCBZhrU0MtV0j1qEA4AkXlU6L-vWmwt12Lj456nJxnZ-wOM5j8c:1scDaD:FGKN3VxWbHi193Rb_2tSHwUdDlOr4_sKC6OwLAL516M	2024-08-23 00:34:17.192489+00
amf5t1cruplvw68zp6t4jcityeg3mati	.eJxVjkEOwiAURO_C2hBaaIEu3XsG8oFPixowpU00xrtLtZtuZjHzZjJv4q-QxmzuVVcYkQwEEzkRA-symbXgbKKvZsOOpgV3w7Ql_wHqclrmaOmG0D0t9JI93s87exiYoEy1LVoleCOt1KHRFp31uuUCOsZ523OhgwTFFMi-ExVSXVDALUAIzAUZ3O9VwVJiTgafjzi_yMA-X9ZWRvM:1scDfR:GyooIxMfBgqsQ2Nbih6F4SeddZk1S7zalLH9KrGOB3g	2024-08-23 00:39:41.686781+00
5wawhcekgr665vu6a0wha1pocti1zx6q	.eJxVjEEOwiAQRe_C2hA6haHp0r1nIAMMFjVgSptojHfXJl3o9r_330s4WpfJrY1nl6MYRS8Ov5uncOWygXihcq4y1LLM2ctNkTtt8lQj3467-xeYqE3fNwB6hYQGjObU22AiYuyNAgZjdQIKzIg2eRW07Yi00Z0Z7JACRrBhizZuLdfi-HHP81OM6v0BawU-sg:1scDvh:MhXggg88i31zmxx5qBkKV9UVyNCkH_0TrRS40mNVcwE	2024-08-23 00:56:29.411133+00
vgy3u9ychy1u62qj25ukw7s6l0ky8w2g	.eJxVjEEOwiAQRe_C2hA6haHp0r1nIAMMFjVgSptojHfXJl3o9r_330s4WpfJrY1nl6MYRS8Ov5uncOWygXihcq4y1LLM2ctNkTtt8lQj3467-xeYqE3fNwB6hYQGjObU22AiYuyNAgZjdQIKzIg2eRW07Yi00Z0Z7JACRrBhizZuLdfi-HHP81OM6v0BawU-sg:1scDvu:Qq3ojBxsY8fn_ti4g99qkOhIEg-cd_SZwZMqnnum3g4	2024-08-23 00:56:42.244734+00
uhqwofr8hlj3p2mjafl981g87i9dwwtm	.eJxVjssOwiAURP-FtSFQaIEu3fsN5PK4ghowpU00xn-3NV3ods6ZybyIhWVOdmlxsjmQkXBGDr-hA3-NZSPhAuVcqa9lnrKjm0J32uiphng77u7fQIKW1rbstBRcOWWQGxe9C6YTEnomRDcIaVCBZhrU0MtV0j1qEA4AkXlU6L-vWmwt12Lj456nJxnZ-wOM5j8c:1scE3M:TaScG6LYXh559MpAtOMc-EVTeD3eka8S8wxvjoygl4I	2024-08-23 01:04:24.993935+00
a7wx2cz8wmmrhzw64yxp4xhz5rgog8gz	.eJxVjssOwiAURP-FtSFQaIEu3fsN5PK4ghowpU00xn-3NV3ods6ZybyIhWVOdmlxsjmQkXBGDr-hA3-NZSPhAuVcqa9lnrKjm0J32uiphng77u7fQIKW1rbstBRcOWWQGxe9C6YTEnomRDcIaVCBZhrU0MtV0j1qEA4AkXlU6L-vWmwt12Lj456nJxnZ-wOM5j8c:1scEH2:qMi9XlmPzS0debSERsP5duiHdPLq-bKeib85LMHpt4w	2024-08-23 01:18:32.515814+00
sv1aih6r7a8ik06a4r8le5i66s2xfuk0	.eJxVjsEOwiAQRP-Fc0NooQV69O43kAWWFjVgSptojP8uNT3oZQ8zb2bnRQxs62y2gouJnoykZaT5FS24K6bd8RdIU6Yup3WJlu4IPdxCz9nj7XSwfwUzlLmmRacEb6WVOrTaorNed1xAzzjvBi50kKCYAjn0okKqDwq4BQiBuSCD-64qWErMyeDjHpcnGVlzjDK3ejeYsD7CRN4flgZG8w:1scEId:LTTgJYDjc6mVAiwl9xATp8asGVTfqLrROLT4vCWSeVs	2024-08-23 01:20:11.61209+00
e5d0uj5ca1cimxe3og9bbrdi9v2etmko	eyJzb2NpYWxhY2NvdW50X3N0YXRlcyI6e319:1tAF1m:5zqXimuQ5CqWpsKs_tSjcNXv61iYf_CxFSxKQbAEVE4	2024-11-24 20:59:22.453183+00
bas8a3cz6shey1sdooj81h9gebpsejkg	.eJxVjMEKwyAQRP_FcxGNuxvsrf0RWXUlocFANafSf29ScmhPw8ybmZcKvPUpbE2eYc7qqojU5TeMnB5SD8LLcsSaU1q32vW3c-Kmb7uT2ufEfV7r_Vz9XU3cpv3HOWsQDaCXCKnIriPYLBERC2A2xORpJDCDEwJxOfuItiA5P7CAen8AxqU7zw:1scJ0Y:D-n72lcBSJmIfixjbaDDUefQQMlVdd3ExPqFDHyrviI	2024-08-23 06:21:50.610074+00
5a9ubqh42rt08ut7v7a45l727jb81ptt	.eJxVjMEOgjAQRP-lZ0PSbuku3vRHmt2yBCIpiW1Pxn8XDAc9zpuZ9zKRW51jK_qMy2iuJqC5_ELh9NB8NLyuB-44pa3l2n03Z12625401yVxXbZ8P19_qpnLvHvEC0hAFB6k5zChBjv1yU3gnDqyRBIIATQNSIAIdrTIHgIQeiU17w_kejvi:1scJkz:19g9sl3wEeQiJectksmyE6exaVmd9CBPQ4BYES7NNXo	2024-08-23 07:09:49.724518+00
6s9dojd4w0ddf13c2lkh48ipjpfhdkp0	.eJxVjMsOwiAQRf-FtSHQ8BqX7v0GMjCDVA0kpV0Z_12bdKHbe865LxFxW2vcBi9xJnEWWpx-t4T5wW0HdMd26zL3ti5zkrsiDzrktRM_L4f7d1Bx1G-d0zQplTSxN04lWyizscYDFApgFTkFPiE5UAzgtEfwaAIUCDZgZvH-AOIAN8s:1sfVXF:9AqcD9wdZvIC6KWurj8G1cTpHLUMlkxCE_MewViav34	2024-09-01 02:20:49.838125+00
f8tgld9h6ej7ttyllbbhkwomigdwh2pz	.eJxVjk0KwjAYRO-StYSmTWrp0r1nCN9fbFQSSVpQxLtrpQvdznszzFN5WObJL1WKj6xG1TZq9xsi0EXSSvgM6ZQ15TSXiHpV9EarPmaW62Fz_wYmqNOn3SMwm4FpCIiChKFFZnJ7ChyMA0eORWxnjfTWWGKA0A3WtMb2wcn3VZVaY05e7rdYHmpsXm9CHEE8:1sfWrm:yXMKP6ZvSb2lpLMC87FNGJcQqHLFKsR8enpuysETQ2E	2024-09-01 03:46:06.837142+00
hkhtdjvjfdn569iym8mf3xiat9jy4c5e	.eJxVjMsOwiAQRf-FtSHQ8BqX7v0GMjCDVA0kpV0Z_12bdKHbe865LxFxW2vcBi9xJnEWWpx-t4T5wW0HdMd26zL3ti5zkrsiDzrktRM_L4f7d1Bx1G-d0zQplTSxN04lWyizscYDFApgFTkFPiE5UAzgtEfwaAIUCDZgZvH-AOIAN8s:1sfXrh:y1tbWbYYIwYUTVvDjA-m4dS_hUoWipaNRRov-NG_Pa0	2024-09-01 04:50:05.821391+00
mex3uwpijfm1sv5bs0ocfimbya79wwqg	.eJxVjMsOwiAQRf-FtSHQ8BqX7v0GMjCDVA0kpV0Z_12bdKHbe865LxFxW2vcBi9xJnEWWpx-t4T5wW0HdMd26zL3ti5zkrsiDzrktRM_L4f7d1Bx1G-d0zQplTSxN04lWyizscYDFApgFTkFPiE5UAzgtEfwaAIUCDZgZvH-AOIAN8s:1sfYWN:wETYqiFzO-yncdOhJo_MCD6A0D7PTLYnEH__ya5wfG0	2024-09-01 05:32:07.091463+00
pthwyh0il0gjs89yufrg7bne2k9luatk	.eJxVjMsOwiAQRf-FtSHQ8BqX7v0GMjCDVA0kpV0Z_12bdKHbe865LxFxW2vcBi9xJnEWWpx-t4T5wW0HdMd26zL3ti5zkrsiDzrktRM_L4f7d1Bx1G-d0zQplTSxN04lWyizscYDFApgFTkFPiE5UAzgtEfwaAIUCDZgZvH-AOIAN8s:1sg3RM:sVUnT974IOKIhorM0I_mqvuGOh0D0ioawxTlhP1nsno	2024-09-02 14:33:00.68687+00
hkhvaynq9xv0b9ppag1ywimflvqb3oz0	.eJxVjMsOwiAURP-FtSE8Clzc6Y-QywXSxoYmAivjv9uaLnQ5Z2bOiwUcfQ6j5WdYErsyC-zyCyPSI9ejwXU9MEeibdTOv5uzbvy2p1z7QtiXrd7P159qxjbvHhMjaBezRgLrJiMUEAgsDjVaAV4ZU9CQ96ZYpQpAttKBhKQpSecn9v4A2tc74w:1sg3Z0:HTgWEJoSCYx3jCu_PY5SLcdkzXMIvrDRyxRLoukwAI0	2024-09-02 14:40:54.816833+00
2t8wghqe8jrixaf8uywkmf9jsdwgupdl	.eJxVjMsOwiAURP-FtWl4tDzc6Y-Qey80EBuaCKyM_y41XehyzpmZF_PQW_K9xqfPgV2ZduzyCxHoEcthYNsOPAHR3kubvp1T1-k2UiwtE7S8l_u5-rtKUNP4sQZoFUJLjXaNoCmA4lLQYkZWAq0DzZGjVrNFI5cgJZ-dtdGBAyUNe38A6_g8Ig:1sg4PD:wsAU6oTWqWn0l2zrARshEk5I22KMdf13fzIh91zkqJI	2024-09-02 15:34:51.063994+00
yi0joxwjm2fj2ccppp6rc9iegc5dzua0	.eJxVjMsOwiAQRf-FtSHQ8BqX7v0GMjCDVA0kpV0Z_12bdKHbe865LxFxW2vcBi9xJnEWWpx-t4T5wW0HdMd26zL3ti5zkrsiDzrktRM_L4f7d1Bx1G-d0zQplTSxN04lWyizscYDFApgFTkFPiE5UAzgtEfwaAIUCDZgZvH-AOIAN8s:1sgiNF:hC8MVV3z6CCMNagB30N0f3uUaqwb5pkZPUb7--WS-WA	2024-09-04 10:15:29.989335+00
p63c4qxe0640edq34t4bv94uvtsjoz9l	.eJxVjMsOwiAQRf-FtSHQ8BqX7v0GMjCDVA0kpV0Z_12bdKHbe865LxFxW2vcBi9xJnEWWpx-t4T5wW0HdMd26zL3ti5zkrsiDzrktRM_L4f7d1Bx1G-d0zQplTSxN04lWyizscYDFApgFTkFPiE5UAzgtEfwaAIUCDZgZvH-AOIAN8s:1sgq6K:amBU-dX_ODAKWFwOoG0hUIBYT57ALmhgOTOzBVrbZkI	2024-09-04 18:30:32.198275+00
hfxe018mt86jtq5rj8ieqkthlo1k68uw	.eJxVjMsOwiAURP-FtSE8BHrd2R8hlwsNxIYmAivjv9uaLnQ5Z2bOi3kcPfvR0tOXyG7MCXb5hQHpkerR4LoemCPRNmrn381ZN37fU6q9EPay1fl8_akytrx7IsJCSREhxqsIE2lLVpGxIUpHACZIJaVVCcJkpQaxQHAJnDNak7OGvT8KkTyK:1sgylk:FB0mkbh1tQihBJqpmpwbzg4q5FPm0FYvOht_bF5XfjQ	2024-09-05 03:45:52.127228+00
1w6h9bwlfo3787uy5b6yd1ld9y8hf3p2	.eJxVjEEOwiAUBe_C2hCo0EKX7j0D-cDDoqaY0iYa490NSRe6nZnMmzna1sltFYvLkY1skOzwCz2FG-Zm4pXmS-GhzOuSPW8J323l5xJxP-3t32CiOrWvsNKkzgrbU5IymKBDpyIsLCU_hGPqNDwIvdYQShmCVyLAGNioQG1aUWsus8PzkZcXG8XnC9UMQEk:1sgzK1:r1wVq2JQ9jyCkp9tq4sdY4L6aA09bsQdVQMf_0IkPf8	2024-09-05 04:21:17.027343+00
am17v63jonkef8khcypejdq5x3u6e3am	.eJxVjEEOwiAUBe_C2hCo0EKX7j0D-cDDoqaY0iYa490NSRe6nZnMmzna1sltFYvLkY1skOzwCz2FG-Zm4pXmS-GhzOuSPW8J323l5xJxP-3t32CiOrWvsNKkzgrbU5IymKBDpyIsLCU_hGPqNDwIvdYQShmCVyLAGNioQG1aUWsus8PzkZcXG8XnC9UMQEk:1sh03H:1GAYUsozDEFmmcoRwsBA4XUKZpEQE71K2o2pm6lnMoc	2024-09-05 05:08:03.335355+00
jf0ov4wlx3s1aigqt0rn66upj2056t3w	.eJxVjk0KwjAYRO-StYQ0Nk3apXvPEL4_bFQSaVpQxLtrpQvdznszzFNFWOYxLlWmmFgNqjFq9xsi0EXySvgM-VQ0lTxPCfWq6I1WfSws18Pm_g2MUMdPO7QOSfrguTdkLCOiAXEo0hH0XnxAoUZcACaEhqXbh9aCZWes8-H7qkqtqeQo91uaHmowrzf8UEBZ:1shD9F:lj1SMeWV0Obw8fVg70YxCpT16RQ1sQm9SE97-ppbKQ4	2024-09-05 19:07:05.175072+00
ndd97v71ftdao6ikluupzjs9wqtzm8mq	.eJxVjk0KwjAYRO-StYQ0Nk3apXvPEL4_bFQSaVpQxLtrpQvdznszzFNFWOYxLlWmmFgNqjFq9xsi0EXySvgM-VQ0lTxPCfWq6I1WfSws18Pm_g2MUMdPO7QOSfrguTdkLCOiAXEo0hH0XnxAoUZcACaEhqXbh9aCZWes8-H7qkqtqeQo91uaHmowrzf8UEBZ:1shDSs:6pOfoAbzg3ilz41yFAYOioBOhSlR-kAtvpj3dywQGYw	2024-09-05 19:27:22.282953+00
cxgswj89ztxo1s3jl236p7gzm6ipntkh	.eJxVjjsOwjAQRO_iGll25N9S0nMGa-1dJ4EokeKkQtwdR6SAZor5PM1LRNy3Ie6V1ziSuAotLr9ewvzk-QjogXO_yLzM2zomeVTkmVZ5X4in29n9AwxYh7bOqeuUSprYG6eSLZTZWOMBCgWwipwCn5AcKAZw2iN4NAEKBBswc4N-D8Sp6Y49N-i2ivcHQyE_tQ:1shQyJ:bdO4xzVt0rCsF-m4yfUaJkR3LM6UARjaIvI7LWJx9H4	2024-09-06 09:52:43.952324+00
amhuekem4vrh1qf6cvwi3wbkwvnpp8qg	.eJxVjs0OwiAQhN-Fc0OoBfpz9O4zkGUXWtSAgTbRGN9dmvSglz3MfDM7b2ZgWxezFZdNIDaxTrHmV7SANxd3h64Q58QxxTUHy3eEH27hl0Tufj7Yv4IFylLTYzdIrenUa0WdQtlaRVIoiSi9ow4VSBBCq9YR9ACqkhb84JFaqXEUe2lxpYQUjXs-Qn6xSTTHKHOvd4PZ1Uc-s88XwzJHdQ:1shJYk:MopEFkP5tFih9OvwZbMlVMyFGdflLww73SKV4JZ9byM	2024-09-06 01:57:50.723155+00
1q4ifst81sqhsj02dfl5b0j9124yn4x7	.eJxVjjkOwjAQRe_iGll25G0o6TmDNfaMk0DkSFkqxN1xRApofvGXp_8SEfdtiPvKSxxJXIUWl18vYX5yPQJ6YO1nmee6LWOSR0We6SrvM_F0O7t_gAHXoa1z6jqlkib2xqlkC2U21niAQgGsIqfAJyQHigGc9ggeTYACwQbM3KDfA3FqumPPDcpVvD9C2T-i:1shu1S:qT63y9SSOcMHLksamLmcyua4BE7S22cCFkHuMUrtuxQ	2024-09-07 16:53:54.522259+00
05wxij5bzswmje0v48xvk0cnwbfl92c6	eyJkamFuZ29fbGFuZ3VhZ2UiOiJhciJ9:1shs91:y-9pNjDm1isaAcbJ_uvlMM2TozvgDS8CZ-cQhd5q2yM	2024-09-07 14:53:35.254557+00
fz7k3utaxz885tvcqne3299dhowd0gyn	eyJkamFuZ29fbGFuZ3VhZ2UiOiJwdCJ9:1shvjt:Dog5bMh3xKmSmmXyULY6E7_WRMRsoCZga4t6aB7oMWc	2024-09-07 18:43:53.580779+00
lqyfrbztd7cfgkenv2913kkjwt373f8o	eyJkamFuZ29fbGFuZ3VhZ2UiOiJmciJ9:1shtvI:0RhtpHNpN-0xC-mbO0eHN0tlk0pMIfSBhO9xrE6TBbU	2024-09-07 16:47:32.736781+00
bih7jr4i0b28pn07vt4h3mz38zlvrmky	eyJkamFuZ29fbGFuZ3VhZ2UiOiJodSJ9:1shuH1:LQ4qsAUMPEEo5a4heeXCB-9cbdE9zHpY4nhAG3TffIA	2024-09-07 17:09:59.661923+00
dqm71s4jidm8l43few9gl0b3gos1sclh	eyJkamFuZ29fbGFuZ3VhZ2UiOiJmciJ9:1shuVA:JpDUKJDaSPBKUwuW_JTCZR8u3OqkQ6Jdzeii9PONrck	2024-09-07 17:24:36.813659+00
jywl7y51fd3vjr6iew78j1gcdwzr74yv	eyJkamFuZ29fbGFuZ3VhZ2UiOiJlbiJ9:1shw6b:hJAOIQao9OBKRKN-QGZdlhyH2Z29Jgw4K4Z_bfsW1rg	2024-09-07 19:07:21.685356+00
c3ef7lk7doafqb6qb3qp07ykbxb3djfm	.eJxVjDsOgzAQRO_iOrJs5N-mTJ8zWGvvGpMgkDBUUe4eUGhoppg3bz6CXjj1cxz33LBncRdlETcRcVtr3BovcaC91NcuYX7zdIC_L_M8rcuQ5DGRJ23yOROPj3N7OajY6m7n1HVKJU3sjVPJFspsrPEAhQJYRU6BT0gOFAM47RE8mgAFgg2YWXx_ii8_pw:1siITm:40li3MDpIU83GK39mJWrwUHorSD5q2En6l_gcNlZogg	2024-09-08 19:00:46.487188+00
lybua8mhqmx80zwbe4dbckl2h06td9im	.eJxVjDsOgzAQRO_iOrJs5N-mTJ8zWGvvGkiQkTBUUe4eUGhoppg3bz6CXlj7OU57btizuAuu4iYibusQt8ZLHGkv9bVLmN9cD_D3ZZ7ruoxJHhN50iafM_H0OLeXgwHbsNs5dZ1SSRN741SyhTIbazxAoQBWkVPgE5IDxQBOewSPJkCBYANmFt8fhs0_og:1sjKRC:lGy4Z_E7goy7vx9n3nNIW2iEC5T7QRzEsw5UfNNwPR4	2024-09-11 15:18:22.310352+00
a1qjolmwby748u1zvsqm0v48wjar3gjm	.eJxVjEEOwiAURO_C2hD8LdB06d4zkA98BDVgoE00xrtbki50N5l5897M4LpEszaqJnk2M2CH386iu1Hug79ivhTuSl5qsrwjfF8bPxdP99PO_gkitri9RwBlB5TuiCglegVA4xBA4iREUNYFAE0TuiC2oBRaMXlyRFqDBI1d2qi1VLKh5yPVF5vF5wuQWj9V:1sjKb4:_JaXvEkokG3Q6CXnWJjx1TVTBLrjN1sQUKRJyOfYa7s	2024-09-11 15:28:34.381119+00
425dm6oiymu7i10vspf1bq38lvk3vgs6	e30:1sjLVm:RVO1Zy39ivmy0WurhmcLUblO2nUV9Tn-1IB5QRNAPZE	2024-09-11 16:27:10.222774+00
p1tbemkf47je2dw6cijldem996l8v5v0	.eJxVjEEOwiAURO_C2hD8LdB06d4zkA98BDVgoE00xrtbki50N5l5897M4LpEszaqJnk2M2CH386iu1Hug79ivhTuSl5qsrwjfF8bPxdP99PO_gkitri9RwBlB5TuiCglegVA4xBA4iREUNYFAE0TuiC2oBRaMXlyRFqDBI1d2qi1VLKh5yPVF5vF5wuQWj9V:1sjLvg:p1YcdFsrNstdkyDU2zjKrngNDj8uC6HIZwXiAI6Jy0s	2024-09-11 16:53:56.202915+00
gu0j01c6w7xqq2ag1qtcq71538jz7ha4	e30:1sjN1C:czcZCVr5LrGJbO2y4FQUgsARHNQZo2ofUbviAhPIsAk	2024-09-11 18:03:42.964631+00
gqx7ae5zwe80g75lr7b42bafs0p6sunf	e30:1sjN31:3buCcG_WM6tCaHBVBoLcsPOwdX5EeWoXjTcxpkLfiNY	2024-09-11 18:05:35.99557+00
67lmgin26kq95p4ep4x057n8qi9ez6de	.eJxVjEEOwiAURO_C2hD8LdB06d4zkA98BDVgoE00xrtbki50N5l5897M4LpEszaqJnk2M2CH386iu1Hug79ivhTuSl5qsrwjfF8bPxdP99PO_gkitri9RwBlB5TuiCglegVA4xBA4iREUNYFAE0TuiC2oBRaMXlyRFqDBI1d2qi1VLKh5yPVF5vF5wuQWj9V:1sjN3U:8yGgpeoaaSatE6I1jz1oky3w38eaLck-rsIOswvhJwM	2024-09-11 18:06:04.97609+00
t7bgxhjpevipngthn50n65rt7yzde8y8	e30:1sjPcu:oueQpSCafz7C78XEwsUeRPCRLdaWKJHlk8TkQCL1HII	2024-09-11 20:50:48.697795+00
81p2qrlzh1xuf3hoh518kqdstn52pxak	.eJxVjsEOgjAQRP-lZ9MsK6XA0bvf0HS7i1RNaygkGuO_K5GDXue9mcxTOb_Mo1uKTC6y6pWt1e43JB8uklbCZ59OWYec5imSXhW90aKPmeV62Ny_gdGX8dMOCEht6FomtmRhQByk2YM1EppgiY1pPXHl6w4tVaZiBAMdUwOM9fdVkVJiTk7utzg9VA-vN8QTPzo:1sjPou:FvPEP2hkrUU45UqSR3HpYQL2hdqXLGMsKVe3GIqM-8s	2024-09-11 21:03:12.318914+00
nuq5w8cvs45tir6h2btj5cmegsjummlf	.eJxVjMsOwiAUBf-FtSGU8uzSvd9ALnCxqIGmtInG-O-GpAvdnpkzb-Jg32a3N1xdjmQiWpLT7-gh3LF0Em9QrpWGWrY1e9oVetBGLzXi43y4f4EZ2tzfIwAoDpAGqccUrdI8AGdaG4_GemM4QyGkTNIDpmCFBDsolhgPPirRow1by7U4fC55fZGJfb7SLj-q:1sjPqX:8CeZygYfw9Mkr0J0QRPUtioxiLIDWqjcUWb2WcOoPI4	2024-09-11 21:04:53.685696+00
1wursoz9dax5hg9nsrto9kh506h3g2i4	.eJxVjMEOgyAQRP-Fc2MAgV16a3_ErMsSTQ0mFU5N_73aeGiP82bmvdRArU5D2-Q5zEldFQR1-YUj8UPK0dCyHLgj5rWV2n03Z711tz1JqTNTnddyP19_qom2affYHlyUpBMgeg-iMY5Wo7MZR9DGa9EhojW2l0CZA7HpE7kUIFPyAur9Abm0O_0:1sjQ1w:-TzxyOonmQ5P3ne_IicM9pYzpc9UPn0y0YaqXahN6VI	2024-09-11 21:16:40.906007+00
3mrn5xbhr87raqkdwindvbwzimi1f0nv	.eJxVjEEOwiAQRe_C2hBKC0O7dO8ZyMBMLWrAlDbRGO-uTbrQ7X_vv5fwuC6TXyvPPpEYBFhx-B0DxivnjdAF87nIWPIypyA3Re60ylMhvh139y8wYZ2-b91C1zMpAueMAVauD1q5To8ugGqMYmV7pxvdssUxWoxNS9iRhRHJMGzRyrWmkj0_7ml-ikG9P4BqPsY:1sjQDf:xe32yu-QVagtoStNSe1FG7bw_74gi0NO_M5J5TbrAVs	2024-09-11 21:28:47.530774+00
qplw7j9ek2fvcdvyuc53l983fqivptcq	.eJxVjjkOwjAQRe_iGll25G0o6TmDNfaMk0DkSFkqxN1xRApofvGXp_8SEfdtiPvKSxxJXIUWl18vYX5yPQJ6YO1nmee6LWOSR0We6SrvM_F0O7t_gAHXoa1z6jqlkib2xqlkC2U21niAQgGsIqfAJyQHigGc9ggeTYACwQbM3KDfA3FqumPPDcpVvD9C2T-i:1slmqh:YpbrN_RFIgRqU08W8FPp7WGnN2rxnjomrmtPfby-FLA	2024-09-18 10:02:51.793069+00
5spuo46j5yllc2l9z9nvw6v017e35q2n	.eJxVjsEOgjAQRP-lZ9MsK6XA0bvf0HS7i1RNaygkGuO_K5GDXue9mcxTOb_Mo1uKTC6y6pWt1e43JB8uklbCZ59OWYec5imSXhW90aKPmeV62Ny_gdGX8dMOCEht6FomtmRhQByk2YM1EppgiY1pPXHl6w4tVaZiBAMdUwOM9fdVkVJiTk7utzg9VA-vN8QTPzo:1sjaT0:SpjPnFzwnSCByEBr41LlRCWrhowWptdewkzgIcTx6s4	2024-09-12 08:25:18.389905+00
2udw6z8o7j9n6ij20wldfe88swb5uhef	.eJxVTksOgjAQvUvXpBkqpcDSvWdoOp0BqqQ1FBKN8e5CZKGbt3j_l7BuXUa7Zp5tINEJU4nil0Tnbxx3ha4uDkn6FJc5oNwt8lCzvCTi6Xx4_wpGl8ct7RUobHzbEJJBA71SPdcnMJp97Q2S1o1DKl3VKoOlLkmBhpawBlLV91XmnEOKlh_3MD9FB8Vxyk4brm7gbYijeH8Az-VHEQ:1sjb1F:O6isusF4N8kBKnUPr809_1wWdoaE03pspYMIlyB4ySg	2024-09-12 09:00:41.854176+00
0o7eowjwjj4amwnyxadonxjbs9j65yu7	.eJxVjMsOwiAURP-FtSE8Wgou3fsN5HK5WNSAKW2iMf67bdKFLmYzc-a8mYdlHv3SaPI5siPrBDv8lgHwRmVb4hXKpXKsZZ5y4BvC97Xxc410P-3sn2CENq5vCJ2TygQTIqLtgjCRknFiGKyVqJMa5BoroU86BUTdK2VI9waAnCa3SRu1lmvx9Hzk6cWO4vMFwAQ_fA:1sjb5q:Fw3YO4C5ATwlit-u_XUtaD0LcHAf1QAhbBvhSqkmYSU	2024-09-12 09:05:26.71516+00
t2vwi78php2xskeaj2xbzvf5j67v8nhs	.eJxVjEEOwiAQRe_C2hBKC0O7dO8ZyMBMLWrAlDbRGO-uTbrQ7X_vv5fwuC6TXyvPPpEYBFhx-B0DxivnjdAF87nIWPIypyA3Re60ylMhvh139y8wYZ2-b91C1zMpAueMAVauD1q5To8ugGqMYmV7pxvdssUxWoxNS9iRhRHJMGzRyrWmkj0_7ml-ikG9P4BqPsY:1sjc3G:m_eM_54N6__-DxIEDO1uaqwmiC_wj5aKeqwMxvSXKDc	2024-09-12 10:06:50.579002+00
1fwntwdb02htbrcfk91nij7t36opir0c	.eJxVjMsOwiAURP-FtSE8Wgou3fsN5HK5WNSAKW2iMf67bdKFLmYzc-a8mYdlHv3SaPI5siPrBDv8lgHwRmVb4hXKpXKsZZ5y4BvC97Xxc410P-3sn2CENq5vCJ2TygQTIqLtgjCRknFiGKyVqJMa5BoroU86BUTdK2VI9waAnCa3SRu1lmvx9Hzk6cWO4vMFwAQ_fA:1sjcdU:31hBAgPZxv5p1hAVNnUiGPhasseJ8OVqowQsKC6xadk	2024-09-12 10:44:16.17324+00
sj0tpujmkdk3e5bvscurvt3k5564h8xj	.eJxVjMsOwiAURP-FtSE8Wgou3fsN5HK5WNSAKW2iMf67bdKFLmYzc-a8mYdlHv3SaPI5siPrBDv8lgHwRmVb4hXKpXKsZZ5y4BvC97Xxc410P-3sn2CENq5vCJ2TygQTIqLtgjCRknFiGKyVqJMa5BoroU86BUTdK2VI9waAnCa3SRu1lmvx9Hzk6cWO4vMFwAQ_fA:1sjd2M:MlZPyNYpTVgs6wx9gbdY9BnyD05KdUw5Qk_oFKCzDyg	2024-09-12 11:09:58.752995+00
1z72eg1zgid6vsk8p1fpt8c6sam81e5c	.eJxVjEEOwiAQRe_C2hAqQ4Eu3XsGMjOgRQ2Y0iYa4921xoVu_3v_PUTAZR7D0tIUchSD6JXY_I6EfE5lJfGE5Vgl1zJPmeSqyC9tcl9juuy-7l9gxDa-34Y0MUJnojboezLALlrqtj1Q9GgBrI2kWbGyzisEr_EAndfkHCv_ibbUWq4lpNs1T3cxqOcLr7s_FA:1sjdcL:hvKwHS35y0tuDieJ8k0_rHOBpxY0wjn_Qrm4yRh5dnw	2024-09-12 11:47:09.479821+00
yvdjnzcgjz58s60iiht8nqwnyzdan0ds	.eJxVjMEOwiAQBf-FsyGFbqH06N1vIAssFjVgoE00xn_XJj3o9c28eTGL6zLbtVG1KbCJDZIdfkeH_kp5I-GC-Vy4L3mpyfFN4Ttt_FQC3Y67-xeYsc3ft1YE3YgmqoiKei8lgVeeJCD0nRggjpGCMEIHiIg0KB2Mc0EIcF4avUUbtZZKtvS4p_pkU_f-AM_KP9o:1sjgPO:II43KE63fBO-wfAne8_qm2rvXeZxTNH8vwfJCmcUuHI	2024-09-12 14:45:58.273036+00
4o1443jdgrkghybb0kmlxraa0b3ioge5	.eJxVjEEOwiAQRe_C2hBKC0O7dO8ZyMBMLWrAlDbRGO-uTbrQ7X_vv5fwuC6TXyvPPpEYBFhx-B0DxivnjdAF87nIWPIypyA3Re60ylMhvh139y8wYZ2-b91C1zMpAueMAVauD1q5To8ugGqMYmV7pxvdssUxWoxNS9iRhRHJMGzRyrWmkj0_7ml-ikG9P4BqPsY:1sjkg1:H5WjyJNPA63ronA5cF5kdzcnSG752CBpRC9hgPyAFYs	2024-09-12 19:19:25.162279+00
5pkq0iwqcso7kqdtbhw7fj2h0l839fas	.eJxVjEEOwiAQRe_C2hBKC0O7dO8ZyMBMLWrAlDbRGO-uTbrQ7X_vv5fwuC6TXyvPPpEYBFhx-B0DxivnjdAF87nIWPIypyA3Re60ylMhvh139y8wYZ2-b91C1zMpAueMAVauD1q5To8ugGqMYmV7pxvdssUxWoxNS9iRhRHJMGzRyrWmkj0_7ml-ikG9P4BqPsY:1sjm6N:275b6srx7vMJrbVPa6VZwzz6Wz8FCR0BIDkZP6_P5mY	2024-09-12 20:50:43.0824+00
6o4sii1ae5n1kque6kfta3mt4at55alp	.eJxVjsEOgjAQRP-lZ9MsK6XA0bvf0HS7i1RNaygkGuO_K5GDXue9mcxTOb_Mo1uKTC6y6pWt1e43JB8uklbCZ59OWYec5imSXhW90aKPmeV62Ny_gdGX8dMOCEht6FomtmRhQByk2YM1EppgiY1pPXHl6w4tVaZiBAMdUwOM9fdVkVJiTk7utzg9VA-vN8QTPzo:1sjoET:w8YLKPR1w2E10h96COHHHGZ5WKL2KNezSHNodXtHuGI	2024-09-12 23:07:13.781921+00
qxn85m5569w1e6c7x30j5p4gxyflfaaz	.eJxVjMsOwiAUBf-FtSGUZ2-X7v0GcnlZ1ICBNtEY_12bdKHbM3PmRSyuy2zXHpvNgUzEcHL4HR36aywbCRcs50p9LUvLjm4K3Wmnpxri7bi7f4EZ-_x9C3ASOIxJJhfQQ2CKDymh1FqDFMYrptSII5PABGj0ODgtpfHcoBuE3qI99p5rsfFxz-1JJvb-AJdZPpE:1skJvF:I4UB5ApqOlOZxnb8M-3lrVmS02uh2nXp1qQxoKlAMcA	2024-09-14 08:57:29.727985+00
i9gnu0uucvjdtjy5oy6hjp7gocgwpf1r	.eJxVjMsOwiAQRf-FtSHQ8BqX7v0GMjCDVA0kpV0Z_12bdKHbe865LxFxW2vcBi9xJnEWWpx-t4T5wW0HdMd26zL3ti5zkrsiDzrktRM_L4f7d1Bx1G-d0zQplTSxN04lWyizscYDFApgFTkFPiE5UAzgtEfwaAIUCDZgZvH-AOIAN8s:1skSoH:VpH8w_dLNkGwapIKpixwuAtRf6JplxQ2qPzymsBa8go	2024-09-14 18:26:53.979366+00
8xnu7rvgdq4ompx3ifk9cn12bk9ieg8d	.eJxVjEEOwiAURO_C2hD8LdB06d4zkA98BDVgoE00xrtbki50N5l5897M4LpEszaqJnk2M2CH386iu1Hug79ivhTuSl5qsrwjfF8bPxdP99PO_gkitri9RwBlB5TuiCglegVA4xBA4iREUNYFAE0TuiC2oBRaMXlyRFqDBI1d2qi1VLKh5yPVF5vF5wuQWj9V:1skhso:Hx3hZCT6BVTmLmyQZdiP__sfNtPozSPqUBrlGLLqQUI	2024-09-15 10:32:34.295915+00
l9t4d8xvvo00gccq99usi7dx5pvv1w4t	.eJxVjEEOwiAQRe_C2hAqQ4Eu3XsGMjOgRQ2Y0iYa4921xoVu_3v_PUTAZR7D0tIUchSD6JXY_I6EfE5lJfGE5Vgl1zJPmeSqyC9tcl9juuy-7l9gxDa-34Y0MUJnojboezLALlrqtj1Q9GgBrI2kWbGyzisEr_EAndfkHCv_ibbUWq4lpNs1T3cxqOcLr7s_FA:1skpTu:TvAAZ0RZkok56_Txu1UReaBXbf8gtrkDY9lCcCzPq0A	2024-09-15 18:39:22.857907+00
k25pdscv06as0k3r668ppbmuda8o2gmv	.eJxVjkEOwiAURO_C2hAolX66dO8ZyAc-FjVgoE00xrtrTRe6nfdmMk9mcZknuzSqNgU2MmXY7jd06C-UVxLOmE-F-5LnmhxfFb7Rxo8l0PWwuX8DE7bp044CAUUvCAxg34EE3WmnImojSavOeEdi2KNQUcqoPZkgUYD3oJQZ4PuqUWupZEv3W6oPNorXG5kVPsQ:1slX9F:zBeb2OQE-UJbUXJkqdXcM0HbHryHcj8gXKLcN0ap_zc	2024-09-17 17:16:57.26936+00
7rrj9sjik65qisz4c1jy50lf9d79cwhf	.eJxVjEEOgjAQRe_StWnK1ALj0r1nINOZwaKmTSisjHcXEha6fe_9_zYDrUsa1qrzMIm5GERz-oWR-Kl5N_KgfC-WS17mKdo9sYet9lZEX9ej_TtIVNO2Djw2Z0DpgTpABFIn3HqngI0wBfHaRQih6dpesFWAkZjZRRdkY958vgwEOAs:1t2xqS:yUO1NHOEnYQTa6inO2B7IUjvP6HOaDWtB8as73VoQuM	2024-11-04 19:13:36.774845+00
lztwgq4wskjfbbsc06o5sh8yn7rp4epg	.eJxVTksOwiAQvQvrhgClg7h07xnItDNp0QYMtInGeHfbpAvdvMX7v0XAdZnCWrmESOIsjBfNL9njcOe0K3TDNGY55LSU2MvdIg-1ymsmni-H969gwjptaQWoDLvBApNHywBAviXUBI5aA53qvGEyoFt2WtuT7jtlNaDR2jsHe2nlWmNOgZ-PWF7irJrjVJg3XHHkbWgp4vMFdMVF3Q:1slZST:1V-CNRelrYZn-lIslKmPwAoyNV_wrml1Y8nOMXmmolw	2024-09-17 19:44:57.497956+00
7i9z9nkj4ktyyftbwoh9ezbga152xd5r	.eJxVjEEOwiAQRe_C2hCcVkq7dO8ZyDAzWNSAKW2iMd5dm3Sh2__efy_lcZlHv1SZfGI1KOjU7ncMSFfJK-EL5nPRVPI8paBXRW-06lNhuR039y8wYh2_77YXsdGJ68gZG6wLFCUw9QEYDo4sYgPUA8W9cBNM21rTCTEaaKIFWKNVak0le3nc0_RUg3l_APYDQDg:1slbbL:vSkg_5QPGCLBPj-0f57NzPKLt0PKQ-hvq1zUxXJzvho	2024-09-17 22:02:15.615764+00
4scjlrj0hhhmbypmxt7tbje1bbedbub1	.eJxVjMsOwiAQRf-FtSHQ8BqX7v0GMjCDVA0kpV0Z_12bdKHbe865LxFxW2vcBi9xJnEWWpx-t4T5wW0HdMd26zL3ti5zkrsiDzrktRM_L4f7d1Bx1G-d0zQplTSxN04lWyizscYDFApgFTkFPiE5UAzgtEfwaAIUCDZgZvH-AOIAN8s:1slckV:oS2bg8DMHvRdyT9etuoZdwYbsR1C0lyaaGJZVY4hg20	2024-09-17 23:15:47.976153+00
332l9zhx199xo8e515j80jtnjukrh8hk	e30:1slclZ:BTciQ5mGPxUUYUUSNUjj21fjW_VUfBbLrJJfxHoLUYY	2024-09-17 23:16:53.264424+00
hsfises3hs1mq5clflingxjxgw2keoha	e30:1slcnf:mvUsLgO1v262T1moxZ4B1bl9ZppykhRha4EC97tviK4	2024-09-17 23:19:03.796152+00
lmh21x9k2wf93xome4w7jl7tz6l9vgev	.eJxVjEEOwiAQRe_C2hAolbFduvcMZAYGixow0CYa4921SRe6_e_99xIOl3lyS-PqUhCjABC735HQXzmvJFwwn4v0Jc81kVwVudEmTyXw7bi5f4EJ2_R9azDMHZEljYNm0GyU8mBij-AtBqXMYY-GehODtww8aB-Zbd8Fih2oNdq4tVSy48c91acY1fsD1Ig_9w:1slcqY:6jVAj8CEx6K_MWl5Ww1DFH_4L38GyJEnyYl1kUSwM7Q	2024-09-17 23:22:02.965988+00
rimiz45dhbv7hd4dexbgk7hekixaxyzs	.eJxVjEEOwiAURO_C2hAolW-7dO8ZyAc-LdqAgTbRGO9uG7vpZhYzb96H-TumIZtpzQUHYj0LhZ2YwWUezVKpmOjXEuBYWnQPStvyF3CX01yi5RvC97XyW_Y0XXf2IBixjutbgiJqrNVWYicJJCkhHKjQIjiNXgh1OaOyrQreaQLqpAtEum28DQ2ITVqp1piTodczljfrxfcHIdJH0w:1slctX:B-0oZ_Ho7YVe_y1WOi8cWmAgGX5-jvB9RUCti_ronEQ	2024-09-17 23:25:07.728301+00
3n1gwx8wvtt42e49kcwll9bs1jto3p3j	.eJxVjDsOwjAQRO_iGln-JP5Q0nMGa9feEAOyUZxIIMTdSaQUUM7Mm_dmAZZ5DEujKeTEjsx4dvgtEeKNyrakK5RL5bGWecrIN4Tva-Pnmuh-2tk_wQhtXN_OQhykNMqgGwhMTKCFkrG3a9YSnQcjUKDRnUOr-qSU6Lxz5MGDVnaTNmot1xLo-cjTix3F5wu1fj7r:1slcuB:1-X_FSEB9YkNFTZGG0TTqBq1fcZ10hSFkk8p9cfF4zU	2024-09-17 23:25:47.960204+00
qkp76wctxjx4obh8v5eqg91jd2hcgyji	.eJxVjEEOwiAQRe_C2pChhUq6dO8ZyAwwFjVgSpvUGO-uJF3o9r_3_ks4XJfJrTXOLgUxiqMVh9-R0N9ibiRcMV-K9CUvcyLZFLnTKs8lxPtpd_8OJqzTtzZERoM24HsP3UAwsAIVFHXgFVnNGDruDfXaekZLjECBA5pWWOB2WmOtqWQXt0ean2KE9we-zD_V:1slcvu:1sTiYdHcvQQyFn37SNHZv9MOKN-KiF7mUWKXF7FbS5M	2024-09-17 23:27:34.623889+00
xcu2ut2cvrf6hhub3o4ujqnk46ic21a2	.eJxVjMEOgyAQRP-Fc2PsCov0Vn-E7C4QSQ0mFU5N_73aeGiP82bmvZSnVmfftvj0Oaibsk5dfiGTPGI5GlqWA3cksrZSu-_mrLfuvqdYahaqeS3T-fpTzbTNu4eRIdgYxLBjYDuKSZB6QEwU2fUCYQiIUY8aLDrLmsQM5tqHpAeBpN4fDVs9Fw:1sld2d:j_O9ExNa4klm7r0hBwFlX_semfsySai1cWgXd_vo5GY	2024-09-17 23:34:31.312997+00
8glkaota3q3382hcuv0l1a3i3n0zimi1	.eJxVjEEOwiAQRe_C2hAolbFduvcMZAYGixow0CYa4921SRe6_e_99xIOl3lyS-PqUhCjABC735HQXzmvJFwwn4v0Jc81kVwVudEmTyXw7bi5f4EJ2_R9azDMHZEljYNm0GyU8mBij-AtBqXMYY-GehODtww8aB-Zbd8Fih2oNdq4tVSy48c91acY1fsD1Ig_9w:1sld2l:U48bZZj4jsAFRIiorzd8klLMRRMFaYgrhYpxC2AIykc	2024-09-17 23:34:39.346699+00
kr051w4bkpb97epghoyqdziae8k3zvnh	.eJxVTksOgyAQvQtrQxQVxGX3PQMZYEZpDTSgSZumd68mLtrNW7z_mxnY1tlsBbMJno1sEKz6JS24O8ZD8TeIU-IuxTUHyw8LP9XCr8njcjm9fwUzlHlPO02-g76lQfXKOdFo8LYhkuShrQlaYVWrCZyAXqLoamFJSy87Oyh0Vh6lBUsJKRp8PkJ-sbGuzlNm2XGDCfehNbPPFyCcSFc:1sleWh:uej3RF563Xqgve74EXSd7AlpjV5-QWPh73p3i3x7yN0	2024-09-18 01:09:39.442111+00
2c0597nev75cpd1y62cqio8veuzdn37g	.eJxVjEEOwiAQRe_C2hBKC0O7dO8ZyMBMLWrAlDbRGO-uTbrQ7X_vv5fwuC6TXyvPPpEYBFhx-B0DxivnjdAF87nIWPIypyA3Re60ylMhvh139y8wYZ2-b91C1zMpAueMAVauD1q5To8ugGqMYmV7pxvdssUxWoxNS9iRhRHJMGzRyrWmkj0_7ml-ikG9P4BqPsY:1slfba:kSZFdn5D_J8pHAWA22OEjfHRfLBvQdj1_UyyPiMyY1c	2024-09-18 02:18:46.190236+00
27dwxgn3djo73w677pic84sdsrpaz5k6	.eJxVjMsOwiAQRf-FtSEDKY926d5vIAMMFjVgSpvUGP_dNulCt-ece9_M4TKPbmk0uRzZwCyw0y_0GO5UdhNvWK6Vh1rmKXu-J_ywjV9qpMf5aP8ORmzjtta2SwmU7kKfogFUyoqkegNCShLaSykxCa3Bg_HBWkWaUMaNmAjQ2f20UWu5FkfrM08vNsDnC4IiPlU:1sllqg:bWM8iqQydewb9bXsROgO8582ea4bS-KNrHWSu8paI4Q	2024-09-18 08:58:46.972511+00
6wjw8582cje942an2oc1diq1d44votwq	.eJxVjMsOwiAUBf-FtSGU8uzSvd9ALnCxqIGmtInG-O-GpAvdnpkzb-Jg32a3N1xdjmQiWpLT7-gh3LF0Em9QrpWGWrY1e9oVetBGLzXi43y4f4EZ2tzfIwAoDpAGqccUrdI8AGdaG4_GemM4QyGkTNIDpmCFBDsolhgPPirRow1by7U4fC55fZGJfb7SLj-q:1slmQy:Y9NW5xFXMeWKuYb-e2EdWj2HApAcVtRDH8Mi8SbC0RU	2024-09-18 09:36:16.931385+00
ds6b9y029i48toabz5reiolm8gebm9b7	.eJxVjMsOwiAUBf-FtSGU8uzSvd9ALnCxqIGmtInG-O-GpAvdnpkzb-Jg32a3N1xdjmQiWpLT7-gh3LF0Em9QrpWGWrY1e9oVetBGLzXi43y4f4EZ2tzfIwAoDpAGqccUrdI8AGdaG4_GemM4QyGkTNIDpmCFBDsolhgPPirRow1by7U4fC55fZGJfb7SLj-q:1slmg3:4IzwTfhPk8GswpWWB9xn9GdAqQfzgC2SAnSS8G-cbfI	2024-09-18 09:51:51.32073+00
rkdorhvqpkbdr96937px20i5fala1wxj	.eJxVjEEOwiAQRe_C2hCcVkq7dO8ZyDAzWNSAKW2iMd5dm3Sh2__efy_lcZlHv1SZfGI1KOjU7ncMSFfJK-EL5nPRVPI8paBXRW-06lNhuR039y8wYh2_77YXsdGJ68gZG6wLFCUw9QEYDo4sYgPUA8W9cBNM21rTCTEaaKIFWKNVak0le3nc0_RUg3l_APYDQDg:1slsB8:johDhQjCJfw82Bytdv2lHmYPwSsNcUX1DgfEUoF_-g8	2024-09-18 15:44:18.32867+00
1lmduefivucgswfb9dii2of321laa1tl	.eJxVjMEOwiAQRP-Fs2mAhS560x8hC6yB2NBE4GT8d1vTgx7nzcx7CU-jZz8aP31J4iIciNMvDBQfXPeGlmXHE8W4jtqn7-ao23TdEtdeIvWy1tvx-lNlannzWG2kVqw4Eqqk8U5WKtAyAXBk5ZwEALKoLHJCMzun0ZwDhlmykwHE-wO9ZDtN:1slvNB:q38LbPvtY7_og1c3P3I8aJmtEsIayj5cdlretasTzk8	2024-09-18 19:08:57.429757+00
oylue55huipmol9satx6edqmtdhbkk8b	.eJxVTksOwiAQvQvrhkChWLp07xnIMExb1ICBNtEY726bdKGbt3j_N3OwLrNbKxUXAxvYybDml_SAN0q7Eq6Qpswxp6VEz3cLP9TKLznQ_Xx4_wpmqPOWBk2tJkm9VbZTvel6KTUIQENBqICgRmztCKgCoPXSdtoEIbwGSygU7aWVao05OXo-YnmxQTTHKXffcIWJtqGlsM8X3PRHtA:1sm6QX:h3O7nfaz3JacTUT6KF_9AEudf-b-viL66u0QCmdhpFA	2024-09-19 06:57:09.159044+00
8w0op8h5pwcl6scqo61y25wvspw6fvy0	.eJxVjsEOgyAQRP-FsyErigWPvfcbyAqr0howoEmbpv9eSTy0l81k5-3svJnBfZvNnikZ71jPFKt-dwPaB4ViuDuGKXIbw5b8wAvCTzfzW3S0XE_2L2DGPJdrcEp2QBrEIAlRybpuAFoUGqSyDkC69pDSCq1HgRchRuigkWokTaIroZly9jEYeq4-vVgP1VnKLMfccaLj0ZbY5ws8ikXS:1smATM:VCcWWIRkT9SwBf5lqbgI50P3f7hm9t5M2pGzbxqLPRw	2024-09-19 11:16:20.375882+00
tets347c7zqsg85rxx5cnpihznbqltsz	.eJxVTksOgjAQvUvXhFDKIGXp3jM0M50BqoQSConGeHchYaGbt3j_t3K4rYPbkiwusGoVVCr7JQn9Q6ZD4TtOfcx9nNYlUH5Y8lNN-S2yjNfT-1cwYBr2tAapqhq8Be2Nb2omoaLTFWJtSZiRm9JYg2IRuqKEmoUIzUWzhY4IjtIkKYU4OXnOYXmptsjOU27cccNe9qF5VJ8vCgdIQQ:1smBxH:8LLhorqWk0zIx0j9Kt1a2598-7P7JLy0FgZdcTyysD8	2024-09-19 12:51:19.553848+00
j3cn0fmh39m7s36imgi9vqfza39f7iia	.eJxVjEsOwiAUAO_C2hAKxYJL9z0DebyPVA0k_ayMd9cmXeh2ZjIvlWBbS9oWntNE6qI6dfplGfDBdRd0h3prGltd5ynrPdGHXfTYiJ_Xo_0bFFjKvhUSGdiAIAexwQ8GwROC7ftoO-Rz7thZP6D4b4kUowk5OuuyeBdZvT8aRTkB:1smCcX:zrDN0I3HIDEt_fuYutLmklXijD1mDs9kt7VviRs7TJ8	2024-09-19 13:33:57.865856+00
cexr43auf3oxcjmcumvb4kp09j4q4avz	.eJxVjsEOgyAQRP-Fc0MQpEqPvfsNZFl21dZoInBq-u_F1EN7mcPMy8u8hIeSJ18S7X6O4iYacfntAuCT1mOID1jHTeK25n0O8kDkuSY5bJGW-8n-CSZI06HlyNyRAkbqWfe2Uwg2Iui2dbpBuoaGjLYdsq0kRudUH5zRJrA1jqr0e8AvNQuMVKV5F-8PlzFA6w:1smHTr:yx6JiYaV8qUFsktBFWrB4ow0COh6EQmWds22wQwsI8c	2024-09-19 18:45:19.297697+00
j6q5ikr5ls7o3zqreazm0cil2pr97fsr	.eJxVjsEOgyAQRP-Fc0MQpEqPvfsNZFl21dZoInBq-u_F1EN7mcPMy8u8hIeSJ18S7X6O4iYacfntAuCT1mOID1jHTeK25n0O8kDkuSY5bJGW-8n-CSZI06HlyNyRAkbqWfe2Uwg2Iui2dbpBuoaGjLYdsq0kRudUH5zRJrA1jqr0e8AvNQuMVKV5F-8PlzFA6w:1smcQC:Wiiq_SoeY0sWhYo9dGoiIcO9yr3XtonheH2RZk9y7To	2024-09-20 17:06:56.770441+00
3o0jw94iwvl58kfufhtr9cvt8rwtgo3l	.eJxVjEsOwiAUAO_C2hAKxYJL9z0DebyPVA0k_ayMd9cmXeh2ZjIvlWBbS9oWntNE6qI6dfplGfDBdRd0h3prGltd5ynrPdGHXfTYiJ_Xo_0bFFjKvhUSGdiAIAexwQ8GwROC7ftoO-Rz7thZP6D4b4kUowk5OuuyeBdZvT8aRTkB:1sndtr:nxfxxc5NxAwI0L543NkurARM4UMaii92p5K-clf23Lk	2024-09-23 12:53:47.359673+00
4d95e73f4l4uvjxmveq2m95rp8lcrcge	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1sorgM:gcPseRFz26jcAMLRst3-s7illGoBLd2x1EffH50dxTc	2024-09-26 21:48:54.959412+00
9cj5e5fx28hr1j2garfs3qcq7afzd9vp	.eJxVjs0OgjAQhN-lZ0JY7A9y9O4zNNt2C1XSmhYSjfHdpQkHvcxhZvLNvJnGbZ31Vijr4NjIpGLNr2nQ3inWxN0wTqm1Ka45mLZW2iMt7TU5Wi5H9w8wY5krFzhYASfV98Z30INCi8SRA1gwsiPHrZQopD8brwY3CIuD99wQ50I4WaGFSgkpano-Qn6xsWuOU3rZdcOJ9qE1s88XuVNHVQ:1sosQa:7bCOAwhFOuDefeUBI-U37RPk6_wQgpFA4yE64bBsbhc	2024-09-26 22:36:40.912569+00
fzlqevidz6277zn10zng1qikc97c5faw	.eJxVjMEOwiAQBf-FsyGltAv06N1vIMAuFjXQlDbRGP_dkPSg1zfz5s2s27fZ7pVWm5BNDHp2-h29C3fKjeDN5WvhoeRtTZ43hR-08ktBepwP9y8wuzq3t1KaBEQHMWqB0AetJWkDCkYwZhgHqQIKiREwGCE9dT2N4GlAIDSmRSvVmkq29FzS-mJT9_kCrno_UA:1soslR:o2nXYnCE5HD2_PAHQlsk3uYpr20vnVk2zkpRn1QHpLs	2024-09-26 22:58:13.513193+00
eku5de0320y92s55xrtry0ialv6bi4dd	e30:1spiA4:xcqSL9bO8h16n_izkQUyW4e0g1L0zzDSoOrejEMU1xw	2024-09-29 05:51:04.760025+00
q71115sot4zd5dnksd8mbzzvt4ru7n9w	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1spjAV:5RkFYUqjB5fiEVSOkGt6SiTbJg0CXrqAfKDDqbHvdgQ	2024-09-29 06:55:35.89438+00
mwzh46s4ihcdl6s46o52gqbwipnbrhqz	.eJxVjEEOwiAUBe_C2hCo0EKX7j0D-cDDoqaY0iYa490NSRe6nZnMmzna1sltFYvLkY1skOzwCz2FG-Zm4pXmS-GhzOuSPW8J323l5xJxP-3t32CiOrWvsNKkzgrbU5IymKBDpyIsLCU_hGPqNDwIvdYQShmCVyLAGNioQG1aUWsus8PzkZcXG8XnC9UMQEk:1spk4Y:JQVNui9s6CGdIcfsTO5BXWrJsZ06Fggs-AYq6_2JGow	2024-09-29 07:53:30.310275+00
uiixwwavym4pldtbedcu18yxbs286tfh	.eJxVjEEOwiAQAP_C2ZBuXaD26N03kAUWixpoSptojH83JD3odWYyb2FpWye7VV5sCmIU2ojDL3Tk75ybCTfK1yJ9yeuSnGyJ3G2VlxL4cd7bv8FEdWpfQPAKjqbvXeygB0OeGAkBPDjdcUCvNSkdTy6aIQzK0xAjOkZUKug2rVxrKtnyc07LS4zd5wuo0j9r:1spkV2:ey_3zPff7NZdSpM3oP7vF-jVC-zPBB-Z5f_Tw8u_MY8	2024-09-29 08:20:52.139987+00
lfy5xdxn6eliuwk1bnpf95k9jet7dr48	.eJxVjMsOwiAUBf-FtSEUCly6dO83kMvLogYMtInG-O_apAvdnpkzL2JxXWa79thsDmQiCsjhd3Tor7FsJFywnCv1tSwtO7opdKednmqIt-Pu_gVm7PP3LZ0DoV0U6EHpUTIOHhgmjQIVA8OlTCi9MTIpzhNAVIOGAYLwYdBm3KI99p5rsfFxz-1JJvb-AJ97Pqw:1spkk1:2GiXLXQwiKT5eyxJhdguIhoujS2zsMtwHHUmIFk_CEI	2024-09-29 08:36:21.688008+00
6zxp5f8pzsl0k6ng4rf7l7xnnqqqe7u2	.eJxVjEEOwiAQRe_C2hCoBaYu3XsGMjCDRQ2Y0iYa4921SRe6_e_99xIel3n0S-PJZxIHYY3Y_Y4B45XLSuiC5VxlrGWecpCrIjfa5KkS346b-xcYsY3ft1aJe2cNBEoWUmAVXVTEkGJ0A4FOg2ZjrEboOgLXEypGG2CPvQYFa7Rxa7kWz497np7ioN4f3XY_ug:1splkR:ES1CUxLr-lgoLJdz54Bl5THV2lVeR66bPiyRBRgTinQ	2024-09-29 09:40:51.766864+00
95tjcq6v8sjmpoq20k7ft3aolz5rovtd	.eJxVjEEOwiAQRe_C2hBwAEuX7j0DmYHBooaa0iYa4921SRe6_e_99xIBl3kIS-MplCR64ZzY_Y6E8cp1JemC9TzKONZ5KiRXRW60ydOY-Hbc3L_AgG34viFDdyCns_Wpw5wMGedgT9olx9ShZ68iGePBMqFVwNpkBmNN1KgA1mjj1spYAz_uZXqKXr0_vbc_Rw:1splpA:ifxx18rzoNm-Czdip1grWRNn7PmmGKFg7DEI9vQqepk	2024-09-29 09:45:44.09359+00
dbvu50zntmdjsz1n293be6uy3p8lk1t9	.eJxVjDsOwjAQBe_iGlnGv40p6XMGa-1d4wBypDipEHeHSCmgfTPzXiLitta4dV7iROIighan3zFhfnDbCd2x3WaZ57YuU5K7Ig_a5TgTP6-H-3dQsddvbYGITLHB2nMhDw6Is0rKBWdhCBod-GJQeZVYo3esvGXgwUDwoEwS7w__bjdk:1sqK3e:8k7qXhUQC1wF9Y6oicsxrub9i17kN_chsjRFbdxRuJY	2024-09-30 22:18:58.57854+00
8me3ew1hsguz88zi8vigeg5wym61q9ke	.eJxVjEEOwiAQRe_C2hAolQGX7nsGMjMMUjVtUtqV8e7apAvd_vfef6mE21rT1mRJY1YXFZ06_Y6E_JBpJ_mO023WPE_rMpLeFX3Qpoc5y_N6uH8HFVv91sYSGixoyImnPrvgMXZoBIpY47M7A3gLITMY7iNhJ8FzZPA9EJeg3h8adjhq:1sqK7X:J3g8FCEGewNHObcRqB0FWST1g_bDxyfdCQZUptIbzS0	2024-09-30 22:22:59.858548+00
0yzdcv6n0uzfcpm2sjy0rjke13i26kwn	.eJxVjMsOwiAQRf-FtSE8CrRduvcbyMBMLWrAQJtojP-uTbrQ7T3nnhfzsC6zXxtVn5CNzGl2-B0DxCvljeAF8rnwWPJSU-Cbwnfa-Kkg3Y67-xeYoc3ftxwCBS0NRTmgAKGMRHBgFCFipyYU1g2TNn3vjBVSBkAdVRenYI2wVmzRRq2lkj097qk-2SjeH7y7PzA:1srojQ:tXVfoFqZZW3IpK4aSkulUeZxU1bnB15nkOlJo77hv7c	2024-10-05 01:16:16.949527+00
bkgln1k2bjcwjaj2lu6565enxp9stldb	.eJxVjDsOwjAQBe_iGllrxw4WJT1nsPaTxQGUSHFSRdwdLKWA9s3M203GbS15q8OSRzEXc07m9DsS8nOYGpEHTvfZ8jyty0i2Kfag1d5mGV7Xw_07KFjLt45EMUCIwB2D7wl6deDEkQd2lIKieO0idSGxYiJFIFHB2IoEat4fCKU4mA:1sruTq:WioMIpcpqFcu7FnGWaMtdq9s5x42V9ee6Q0_qZkUalQ	2024-10-05 07:24:34.667691+00
qqqcx6xzsh4ye2bjj8yp0gurbeq47xk4	.eJxVjDkOwjAUBe_iGlmJk--Fkp4zWP4bDqBEylIh7g6RUkD7Zua9TC7bWvO2yJwHNmeTenP6HbHQQ8ad8L2Mt8nSNK7zgHZX7EEXe51YnpfD_TuoZanfuoWkGh0g91Fjl4BAyAkqUKMYg_cEHFoNITXaMzIUJx49pUY65da8PyJ5OO0:1svNWT:OmZkwMJBcifF--OFOeRRXZQGXsSQz_aq4XAPWEvT-mI	2024-10-14 21:01:37.192444+00
0rir3rus9b0mgihrfujsqw1cyr99wb63	eyJkamFuZ29fbGFuZ3VhZ2UiOiJlbiJ9:1svdnN:cqBbEUZQuvnYgEzwj_M1gKE2ymW5LUfd7lkpwRjkPLc	2024-10-15 14:24:09.079022+00
owe7p03q6z8djs9zdzzskxua9q8eaj0f	.eJxVjDkOwjAUBe_iGlmJd1PSc4bob8YB5EhZKsTdIVIKaN_MvJcaYFvrsC0yDyOrs8penX5HBHpI2wnfod0mTVNb5xH1ruiDLvo6sTwvh_t3UGGp37qIL9lTyoYCQTJsoPPCfSCLPUTxGR04jzEWIRuQXbC2S9ZQZNf1Rr0_KD04Og:1svorJ:qNliKVlSgSOuB9YPfOXXvSBLsUlXgJTL-gb_TbdAMP0	2024-10-16 02:12:57.867991+00
9uuvjkci4dr6pzh3c6s7f3q5rj8z0yhj	.eJxVjDsOwjAQBe_iGlle_5ZQ0ucM0a53gwMokfKpEHeHSCmgfTPzXqajba3dtujcDWIupsnm9DsylYeOO5E7jbfJlmlc54HtrtiDLradRJ_Xw_07qLTUbw2aSgOESJj82XsXCYGTcp-9BMagPpQMvdcMjOAEMDpSciEKSyrm_QH7Mjfr:1svow2:_R4zjph3fW0fNqcxbVFHO6IeLpOYJvgZDTFqt2ko89U	2024-10-16 02:17:50.187335+00
6e3o7a6cabvbze6rmpq80t0t9t7ehvl3	.eJxVjDsOwjAQBe_iGln-sF6Hkj5nsNbeNQ6gRMqnQtwdIqWA9s3Me6lE29rStsicBlYX1aE6_Y6ZykPGnfCdxtukyzSu85D1ruiDLrqfWJ7Xw_07aLS0bw2Oi7AJLnhghnh2XcXIBqMDBGctea4ejCsBsxVfC4LJHQmhDVWien8A9cM3tw:1svowO:KlgklV-1bhf4tQWz4IZwOM_9Dh9aPRRx1dtrP7mg-wQ	2024-10-16 02:18:12.193383+00
43b0mxqs7s2lsr5jm1lqxqhxgq1vf9md	.eJxVjMsOwiAQRf-FtSHAMDxcuvcbyPCoVA0kpV0Z_12bdKHbe865LxZoW2vYRlnCnNmZecdOv2Ok9ChtJ_lO7dZ56m1d5sh3hR908GvP5Xk53L-DSqN-axJea5-cQKuyxWwkamEzYkoEphhBZAugkeBARamEcmYqaNREACISe38A4qo3Dw:1svox6:YJw8kR2UD9sjYdHHy55XP8ShSS1JsMHWNgkOldbsTaY	2024-10-16 02:18:56.285444+00
crlnv1f8dc7i722y0c4xpf8a1tkrnxnk	.eJxVjk0OgyAQhe_CuiGKg0CX3fcMZAZGsTWaiKya3r2Yumg3b_F-vryX8Fj25EvmzU9RXEUrLr8eYXjycgTxgcu4yrAu-zaRPCryTLO8r5Hn29n9AyTMqa6taZxWTKA7Aw6s61RH0WowARS0RBgJdbQUwFBvYWgb7pkbBmOd64cK_R7wc9WCI1fovon3BxSIP0k:1sxCQy:eikC5CuZC87c-UxSQ1oO2nzDFvC1wWZNKKgNcpLxu9I	2024-10-19 21:35:28.780147+00
fwyszk48zygmbs32p8mto3hlesxgnfvt	.eJxVjMsOwiAQRf-FtSGUZ-nSvd9AhmFqUQOmtInG-O_apAvd3nPuebEA6zKFtdEccmID84YdfscIeKWykXSBcq4ca1nmHPmm8J02fqqJbsfd_QtM0KbveyQzeoO9l2gRepkkCEOps6hiB46Mjxq0ic6NhMrGpK1SolcSXdKik1u0UWu5lkCPe56fbBDvD9cMP3c:1svp1S:4GtQEH_iQFSH1iszB9EJa8NEhHJeY3u_RSQ_ry5QeBw	2024-10-16 02:23:26.617971+00
j156onic5i3gnymrl3yn5kx4ngayc3wr	.eJxVjMsOwiAQRf-FtSGUZ-nSvd9AhmFqUQOmtInG-O_apAvd3nPuebEA6zKFtdEccmID84YdfscIeKWykXSBcq4ca1nmHPmm8J02fqqJbsfd_QtM0KbveyQzeoO9l2gRepkkCEOps6hiB46Mjxq0ic6NhMrGpK1SolcSXdKik1u0UWu5lkCPe56fbBDvD9cMP3c:1svp5c:vNB6Ez6VKdtIfSgbtZfLUtVCrHUUEwNExuAb0y21GnE	2024-10-16 02:27:44.307706+00
bnek21b2nbbfkc0dxucy1ewmag92qirl	eyJkamFuZ29fbGFuZ3VhZ2UiOiJ0ciJ9:1sx3Fp:l79jMUk7KS-If5DSbCKzfygyPT_OrNqefHGGAm8G_3I	2024-10-19 11:47:21.957627+00
30y5sek4qhl8uid5bkb49u48pgkgnbqz	eyJkamFuZ29fbGFuZ3VhZ2UiOiJlbiJ9:1sxCql:x1639hmqi5o2Azi04DSA_lBdZu7rg1m4A8wOJ3nvo08	2024-10-19 22:02:07.968815+00
6dug7zoxkrp2a7do76a00tyojvcav25s	eyJkamFuZ29fbGFuZ3VhZ2UiOiJmciJ9:1sxF1W:DfylI7M2F1a27B0gRAbxfYiljUNCDSZGM6VaaV4Rw9g	2024-10-20 00:21:22.848398+00
33ssimjtiszd4g8mz0cbma62pn9m5jxs	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1sxOWS:ISFT8ogn89yjiZCbKV0S0pSGWdEHzleOpXvnGnauWlw	2024-10-20 10:29:56.199486+00
4lqmwtw0fshdhqojsrgh6su1q46b10vg	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1t0EQv:eQUH4iD59z_61yEEAKiPDZ1nJwA3UlsEnIm-B8jH7wI	2024-10-28 06:19:57.89319+00
ztz2tvzmqr49vbqofkrn8otay1e4ypja	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1t0FCv:zAyaS9FJPdsTut3rSezRnnZr3dTHhzT9NFLP2HORa7U	2024-10-28 07:09:33.800436+00
em7u7hgwr9pasqwf8csyb01cs3pl7u1w	e30:1tKlK2:uGDH9CRXdYEqfhniLx3Z7yT-o3ImlZmWc0lNUWSkR-g	2024-12-23 21:29:42.884091+00
w2o9uu25ok1k7jvg2ybc9a8vlxwys24m	.eJxVjEEOgjAQRe_StWnKYIGydO8ZmunMIFXTGgqJxnh3IWGh2_fe_2_lcZlHvxSZfGTVK-fU4RcGpJukzfAV0yVrymmeYtBbondb9Dmz3E97-3cwYhnXtaWhOoLjDrAF5wDFMDW1EXAVE1qupQ1gbdU2HbtGAAYkIhOM5ZXV22mRUmJOXp6POL1Ubz5ftyc_SA:1t2xqu:2FrWdWnZm0MEp5pWGj4HzmslsSyH_SqZVuRo_lVDx48	2024-11-04 19:14:04.030022+00
qelh3sc6utgtayoy0xagin0th8nbgrmb	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1t2xs7:rQrnt9yoFBbqQwxK0fz4MG1m7giVa_KGGNYXTa_E4io	2024-11-04 19:15:19.265223+00
c3fwzoqaqtoenmt8tng30wwklclo2kn4	.eJxVjEEOgjAQRe_StWnKYIGydO8ZmunMIFXTGgqJxnh3IWGh2_fe_2_lcZlHvxSZfGTVK-fU4RcGpJukzfAV0yVrymmeYtBbondb9Dmz3E97-3cwYhnXtaWhOoLjDrAF5wDFMDW1EXAVE1qupQ1gbdU2HbtGAAYkIhOM5ZXV22mRUmJOXp6POL1Ubz5ftyc_SA:1t2yK4:0OMx3yw3Hy0kM5VGkZEpM8Altnks5t8olNM3xhh_-28	2024-11-04 19:44:12.455674+00
5f6mme8y0rlpjaynq4f9qovzqun0f6m4	eyJkamFuZ29fbGFuZ3VhZ2UiOiJ0ciJ9:1t3B6G:CsXau8P1iQYb9d4OvlZOwOmCUZKcuxn4_KfqY6vX7cQ	2024-11-05 09:22:48.397849+00
cfp2kdqb4d2g557wfdqrf3cuuoses252	eyJkamFuZ29fbGFuZ3VhZ2UiOiJlbiJ9:1t4RFp:e6ErAu35lJ-uca9g3ukCHLFxooEfzonSuFXRyNSiDjs	2024-11-08 20:49:53.8219+00
wbboz5r228zznma9eur7scjcxgwaeqvp	.eJxVjDsOwjAQBe_iGlnOOv5R0nMGa71e4wBypDipEHeHSCmgfTPzXiLitta4dV7ilMVZDArE6XdNSA9uO8p3bLdZ0tzWZUpyV-RBu7zOmZ-Xw_07qNjrt0aNqJOzxFiC55T1EApCShiYeAzgiV1xpviQRwKibH0gDcoWMEoZ8f4AcH05YA:1t4Rr1:hOV65TgLoCF8Dc_qLrA4XJqH3CFAwfz9osFKJYA42ro	2024-11-08 21:28:19.128924+00
03dwwr42z37jg5802svtnd35dd0ypa1a	.eJxVjMsOwiAQRf-FtSG8BZfu-w0EmBmpGkhKuzL-uzbpQrf3nHNfLKZtrXEbuMQZ2IVJodnpd82pPLDtCO6p3Tovva3LnPmu8IMOPnXA5_Vw_w5qGvVbe4dok0ctMzlBNpEnI8k7dS7kMmnlpSkIBZTDQMGqIp0HJYwMGYJm7w9Hwjiv:1t4SZl:7rwclfbuiezmGpjBNLBhbCoBmvewetaSlLL_TR5PaDo	2024-11-08 22:14:33.945595+00
paa3gq410uuobqts70qxhdat1cl2l4fi	.eJxVjkEOwiAURO_C2hCgFKFL956BAP9_ixowpU00xrtrTRe6nfdmMk_mwzKPfmk4-QxsYFJ0bPebxpAuWFYE51BOlada5ilHvip8o40fK-D1sLl_A2No46dtDWIfLHYykhHUB7KkJVmj9olMpE5ZqRNCAmXQketVksaCElq6CO77qmFruRaP91ueHmwQrzf_tT_s:1t4ScY:o5FCXbo7R3LzMKRQmbDmh-CC3SQsFxBxOtky8v0CrhE	2024-11-08 22:17:26.502614+00
8gdd5xxs1jssv23602fw5ne2rn1nd9mu	.eJxVjMsOwiAUBf-FtSGlcCm4dO83kPugUjU0Ke3K-O_apAvdnpk5L5VwW0vaWl7SJOqsTOfU6Xcl5EeuO5I71tusea7rMpHeFX3Qpq-z5OflcP8OCrbyrQdrcXQdRYAeY6QQ4uDIGjScAchHHgMLZEHrAkAkS-gzMErw1vlevT8loThK:1t4Tz4:_v9sWtsaBd1dLcRnv_Zq1oJZU6JB2CTAOCzAtqSw2Bk	2024-11-08 23:44:46.164137+00
ahvg72da1yoer1zomlb7ecz1aw2c7dcn	.eJxVjEEOwiAQRe_C2hCwDKBL9z0DmYFBqgaS0q6Md7dNutDtf-_9twi4LiWsnecwJXEVWoE4_a6E8cl1R-mB9d5kbHWZJ5K7Ig_a5dgSv26H-3dQsJetHthbIGvVcHEpUwSryStHELNRwOwdKY6gwZkN4tk4sqizY_BgDGnx-QImKjgN:1t4U8l:rha8Rrh5wzYq-MjG0ODBUsx5iaPi3LDsSq_L0LY3WVU	2024-11-08 23:54:47.554407+00
yudpepf6keon0suzjf2kyshmk1v9mly7	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1t4dMc:nOsI0VhSaV01mYp6BJt6Y_Acld3N7kO0Q7KUx_2eSBY	2024-11-09 09:45:42.475484+00
7phbt28nimxiep1zq1cqf1cjclxagzcd	.eJxVjDsOwjAQBe_iGlnGjn-U9DlDtN5d4wCypTipEHeHSCmgfTPzXmKCbS3T1nmZZhIXcVZOnH7XBPjguiO6Q701ia2uy5zkrsiDdjk24uf1cP8OCvTyrWMkg8lnnS1gYnIZA1sPITvwEZzFEJjJsBmURgXgEY2mHLUaODgW7w9qhTme:1t4eaU:CQY2EVJtHlPFnrzQWnxyQKbu9JnuRktTk-jtTb_r5_0	2024-11-09 11:04:06.526125+00
h06kfxxgi1mlpw0eyy042p19mh9q7fy9	.eJxVjDsOwjAQBe_iGlmO_6GkzxmsXXuNA8iW4qRC3J1ESgHtm5n3ZgG2tYSt0xLmxK5sEI5dfleE-KR6oPSAem88trouM_JD4SftfGqJXrfT_Tso0MteO9SjiALQjElqsugiRAXkrDXWZe2FHKz2oIz1nqTaqTeZslQGBYBiny8qdzg3:1t4kCW:wwmYpYgLi5hi3yy2CjeATDVenpgCTeLkRXBQWNV_Crg	2024-11-09 17:03:44.521886+00
rqozi9hky7xagxs3udqvr56r2g8nu7q0	.eJxVjEEOgjAQRe_StWnKYIGydO8ZmunMIFXTGgqJxnh3IWGh2_fe_2_lcZlHvxSZfGTVK-fU4RcGpJukzfAV0yVrymmeYtBbondb9Dmz3E97-3cwYhnXtaWhOoLjDrAF5wDFMDW1EXAVE1qupQ1gbdU2HbtGAAYkIhOM5ZXV22mRUmJOXp6POL1Ubz5ftyc_SA:1t68lj:LUN_FY2OvmtpUHDLZHps6nIe5wWzzHU3d2OCYztxLkE	2024-11-13 13:29:51.235715+00
3rk458xw54neszlie03ac68b2vyt170b	.eJxVjEEOgjAQRe_StWnKYIGydO8ZmunMIFXTGgqJxnh3IWGh2_fe_2_lcZlHvxSZfGTVK-fU4RcGpJukzfAV0yVrymmeYtBbondb9Dmz3E97-3cwYhnXtaWhOoLjDrAF5wDFMDW1EXAVE1qupQ1gbdU2HbtGAAYkIhOM5ZXV22mRUmJOXp6POL1Ubz5ftyc_SA:1t7Baz:pTNsQz--Av4aNf8Tk7HC4LgcZRiVwru9XGxlZTYUNDY	2024-11-16 10:43:05.574721+00
w0b07mhtec0kh1uw9s5sief3u2rgcoll	.eJxVjEEOgjAQRe_StWnKYIGydO8ZmunMIFXTGgqJxnh3IWGh2_fe_2_lcZlHvxSZfGTVK-fU4RcGpJukzfAV0yVrymmeYtBbondb9Dmz3E97-3cwYhnXtaWhOoLjDrAF5wDFMDW1EXAVE1qupQ1gbdU2HbtGAAYkIhOM5ZXV22mRUmJOXp6POL1Ubz5ftyc_SA:1t7Bb0:dRdU0mmoLioQT9qpnRaCp2EPxsPZKaRKsQ_b7l4IJJs	2024-11-16 10:43:06.70626+00
r6l3xg5egnmcs87m09kumzig7bjw2l29	.eJxVjEEOgjAQRe_StWnKYIGydO8ZmunMIFXTGgqJxnh3IWGh2_fe_2_lcZlHvxSZfGTVK-fU4RcGpJukzfAV0yVrymmeYtBbondb9Dmz3E97-3cwYhnXtaWhOoLjDrAF5wDFMDW1EXAVE1qupQ1gbdU2HbtGAAYkIhOM5ZXV22mRUmJOXp6POL1Ubz5ftyc_SA:1t7EoO:mzQU52rty9oTWp88GSWM1teABWKZE6YbL9kp2ugUYEU	2024-11-16 14:09:08.415974+00
k4lmnbj6ugy1eh9wpcniplvrccr37cke	.eJxVjMsOwiAQRf-FtSFAgRlcuvcbmmEGpGrapI-V8d-1SRe6veec-1I9bWvrt6XM_SDqrKw16vS7ZuJHGXckdxpvk-ZpXOch613RB130dZLyvBzu30GjpX3rYNhUcsTisIL3kryNDIEtQUcCQRCFAyCgQ-ySj0TiUo61CwCJ1fsDKW439A:1t8m8K:diT54hCYSyVum2jMfr4ZQlWHhZXitGvFHkTn9AGkyPY	2024-11-20 19:56:04.56317+00
f52vgvhftz89zs63hl8v64jjmw2r775g	.eJxVjEEOgjAQRe_StWnKYIGydO8ZmunMIFXTGgqJxnh3IWGh2_fe_2_lcZlHvxSZfGTVK-fU4RcGpJukzfAV0yVrymmeYtBbondb9Dmz3E97-3cwYhnXtaWhOoLjDrAF5wDFMDW1EXAVE1qupQ1gbdU2HbtGAAYkIhOM5ZXV22mRUmJOXp6POL1Ubz5ftyc_SA:1t8n98:rausNHfnN_qtywfObv3fjSBAtZ5wYkPd1Ur6vgW6dxs	2024-11-20 21:00:58.15666+00
hl5wub8os6ur259c6pq7x7exa0bdi4cs	.eJytj81uwyAQhN9lz5aFMdjGt-SQSpV66KVSVEUIwzomsSAF3J9EefcSNYf23uvM7Dc7F5BqSZNcIgZpDfQgBBS_xUHpI7qbYw7K7X2pvUvBDuUtUt7dWD55g_P6nv0DmFSc8jXXY8WoMB1VLRWCKiRGNzVBKiqjFTc1tgPlvGqbzogGKR2V1poMhJus1TdoxBitdxI_TzZ8QU8KiF5bNeekX1ySMamEEfoLnDcfq-02PK6YsM-HMEP_eoFT8Doj8jez31uXkUYlBb1b5rmA01Gj1HmHfMdgR4vhx7kWVVsTwRlnoqxZ13VsV8B5qhL3bzqQRWxemof_KGjqqswtDaN8d71-Ayn-h3I:1t8uN5:MuX_SsuYXW0OXH1CvIk9o3BcMRQS6wEp4kf9Z3ZUdT0	2024-11-21 04:43:51.455511+00
ggxsceotdpjl4d833z05loo8s5z4infp	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1t8v5g:KPWqZMMEScoKAT-ojcU8QEWQ4RbOXanWCX3N8QYoA4c	2024-11-21 05:29:56.339846+00
9pyu2nivwxhomx831rt05koeei4i4xab	.eJxVjEEOgjAQRe_StWnKYIGydO8ZmunMIFXTGgqJxnh3IWGh2_fe_2_lcZlHvxSZfGTVK-fU4RcGpJukzfAV0yVrymmeYtBbondb9Dmz3E97-3cwYhnXtaWhOoLjDrAF5wDFMDW1EXAVE1qupQ1gbdU2HbtGAAYkIhOM5ZXV22mRUmJOXp6POL1Ubz5ftyc_SA:1t9Zx2:EUfwneNf3x9L59kh5oDGmmwGqeWmJ6rB9RLQ6mBj-so	2024-11-23 01:07:44.143624+00
jzii57t4ncyv0ocr4afgko5yto6to5sd	.eJxVjEEOgjAQRe_StWnKYIGydO8ZmunMIFXTGgqJxnh3IWGh2_fe_2_lcZlHvxSZfGTVK-fU4RcGpJukzfAV0yVrymmeYtBbondb9Dmz3E97-3cwYhnXtaWhOoLjDrAF5wDFMDW1EXAVE1qupQ1gbdU2HbtGAAYkIhOM5ZXV22mRUmJOXp6POL1Ubz5ftyc_SA:1t9avw:sZSUuNVzSkUwNQLICHfI0Px3FurGoTQ2R7L8wG-rGzg	2024-11-23 02:10:40.106415+00
o0bzc0yhniujc6quqzxqoypq2eltnynz	.eJxVjEEOgjAQRe_StWnKYIGydO8ZmunMIFXTGgqJxnh3IWGh2_fe_2_lcZlHvxSZfGTVK-fU4RcGpJukzfAV0yVrymmeYtBbondb9Dmz3E97-3cwYhnXtaWhOoLjDrAF5wDFMDW1EXAVE1qupQ1gbdU2HbtGAAYkIhOM5ZXV22mRUmJOXp6POL1Ubz5ftyc_SA:1t9axD:r0lhp3CSmigJnR6Rn9tToFZPHWGVCnXEls7-bWnCfhA	2024-11-23 02:11:59.488142+00
w868ryolfipx6yr6afkin5r6tb2hy3cc	.eJwlycEKAiEQANB_mbNEGovpsWPHYKGIkGF2CllZF50NQvz3gt71NaiZIiYkytsioQoKV_ANzu52mT_1RNlcUUYBf2-wlkxcfw8pv-ICCiYUBL9sKSlYZ-JAeeLw5hKfkct_utL2oI012rmdG4b9UdtH71_U3Som:1tAEz9:8VCCOn2xGAMwEaymturTypVnzj91so_e_Mf0YjrYo7c	2024-11-24 20:56:39.957448+00
mz4kb2d0l2d57dvmjzdfbmuvg8jmqzst	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tAF0l:MumjX4u14Fibdx9Pii-z4rWmZtNGzq9_57uvv8rHYqI	2024-11-24 20:58:19.86981+00
vqfff0h7l018dwla1yyxv0246gwl0bg1	.eJxVjktuhDAQRO_Sa4T8aWObZfY5QRSh9gdwwtgRmGxGc_dAhs3sWlXvlfoO5H3Zcx1or3PMNXmqqeThFutcwgb9xx2eN_SwFZ9ouQxogCr0XEsutECJrbQalVQN_KzlN4W4HspUyrTEg93TucCZVKg1IuOyEwqZ5cjg8dnA_wPDvsV1eJKcw0vqyH_HfFbhi_JUWl9yXZNrT6S92q19LyEubxf7MjDTNh-2U9YFRMfICB-ciCMbdbRWGqsDjiNSJwzTgQyzwmijQ2SxM1p5MzKjEB5_FCdiEg:1tAF2w:_L0uocYnlIWG_aeBKhlLVWbqSLrbaHoWFmoHcc0m46Y	2024-11-24 21:00:34.446599+00
4p93u611f6qkoxajh1it6f9vxd0gdgbu	.eJxVjbtuxCAURP_l1pZlMBhwuUmbSFGKKIoixON6TdaCFeA0lv89XmWbbefMnNmgJBfMYpxLa6y6VFOxwLgBy59P7v2UXp8n9aHeJIxfG1xzclgODks6hwgNeFMNjHFdlgauF4faJY_6F3OYAuZ_sjdE9IRTwgfVUqm4YvR7b0Cbtc56LZh18IeTwENmjbtgvAH_Y-I5tS7FmoNtb5X2Tkv7chwup3v3QTCbMh9rKTrFKVrGe8EUk6qnvfWSM-EYZcRa463hXlrHhB0km0iHA2KHTEilhgn2Pzr7X-w:1tBHsk:Djb1lPFUH9DA2Vox0wHNh9zbz7CxHe4hLysbLWd6snM	2024-11-27 18:14:22.800373+00
utgzioow824o1qzc3vzpzt79k52svm1f	.eJxVjMsOwiAQRf-FtSFDgRFcuvcbCI_BogZMaRON8d-1SRe6vefc82LOL_Polk6TK4kdmBCK7X7X4OOV6orSxddz47HVeSqBrwrfaOenluh23Ny_wOj7-H1HAolGRgN2EEErobQHkhYxZOEJzT4jIg0D6WByRrBJeYQMUpMNQGu0U--lVUePe5me7ADvD7nXPxs:1tBM79:_f4YuSzlYB4MH-DndMDkr6vEWFHCEH_Sr44KkfRdnh0	2024-11-27 22:45:31.802351+00
9kp6jred83483jb2mszk3apwefgvhhjd	.eJxVjDsOwjAQBe_iGln-kMVLSc8ZrLV3jQPIkeKkQtwdIqWA9s3Me6lI61Lj2mWOI6uzshbU4XdNlB_SNsR3ardJ56kt85j0puiddn2dWJ6X3f07qNTrt85uwAElAIJ14k1OzueTCWiJUJgcEwgVRAbLPvmCJtAxJfRABgqp9wcpXTif:1tBbBQ:iE1EwrMgxqlFIADIWF9YcijLUP8zXLEFib77F2qqC-Q	2024-11-28 14:50:56.601975+00
1qf1ki78p8p7ssi4r3wjo3s5j521hyzy	.eJxVjEEOwiAQRe_C2pABCgwu3XsGMtNBqZo2Ke3KeHfbpAvdvvf-f6tM61Lz2sqcB1FnZQyq0y9l6p9l3JU8aLxPup_GZR5Y74k-bNPXScrrcrR_B5Va3dbAwNLH6Jy4W0BEQgKBlEzECCl0FDsj3lqPbNAyBgsAHiA4LhtQny8GlDaA:1tBeV5:NVXspn1BflI2SqkDLZNXP3QupRSh5Nx3hLVtr4IOPLk	2024-11-28 18:23:27.498454+00
bvojd9ik0eh4ixq40mrf2osvqu72l2rf	.eJxVjEEOwiAQRe_C2pABWph26d4zEKaDFjVgSptojHe3TbrQ7Xvv_7fwYZlHv9Q4-cSiF0qhOPxSCsMt5k3xNeRLkUPJ85RIboncbZWnwvF-3Nu_gzHUcV0DAfHgnDFszhYRAwZg6Drl0EFnm-Aaxa3WLZJCTWg1ALQA1lBcwXZaY62pZB-fjzS9RA-fL5LbPb0:1tBeVg:T7KN0eZf0ZECFxi2wGztKriGQhulfEUVz2d-qMdIp4A	2024-11-28 18:24:04.093035+00
013g5fprgfwy90l74mvsl6tvhylgjc1r	.eJxVTksOwiAQvQvrhgzQwrRL956BQBlb1IApbaIx3l2adKGbt3j_N7NuW2e7FVpsDGxgQiBrflnvxhulXQpXl6bMx5zWJXq-W_ihFn7Oge6nw_tXMLsy1zR48GE0RqmgLhoRHToI0PfCoIFet860InRSdugFSo9aAkAHoJWnSuylhUqJOVl6PuLyYgM0xyl7r7i5ieoQJfb5AnxyRZQ:1tC0PT:ABGDRYtIJK-LgMkcLu25zcCwoky8_hDxxuivLgtiEMw	2024-11-29 17:47:07.221145+00
l75mov30m17xcemxassmhq1qbf7qja8x	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tBfNa:W3x3fpboZN7dqOmyprZvDYfSZqCngCmTBg9xF7CuGeI	2024-11-28 19:19:46.430812+00
cb1jp8j17uvgt29dr8qzzxdh9cuz8n9p	.eJxVjE0OwiAYBe_C2hAwUqBL956B8P1gUQMG2kRjvLs26UK3b-bNS4S4zFNYOreQSYxCayt2vytEvHJZEV1iOVeJtcwtg1wVudEuT5X4dtzcv8AU-_R9K4_JqKiT9YSsDioBpqgH9I44avTokI0aBiCdHFow1lnUzigCA_u0Rjv3nmsJ_Ljn9hSjen8AIFxAmw:1tBjv0:O9nijLqmTrHTNvFiyMUhUi4rbHlEF8L4RMrBaYvUKno	2024-11-29 00:10:34.473735+00
f6s7r2k93u3mgdpo5woonc8nit9icq7k	.eJxVjE0OwiAYBe_C2hAwUqBL956B8P1gUQMG2kRjvLs26UK3b-bNS4S4zFNYOreQSYxCayt2vytEvHJZEV1iOVeJtcwtg1wVudEuT5X4dtzcv8AU-_R9K4_JqKiT9YSsDioBpqgH9I44avTokI0aBiCdHFow1lnUzigCA_u0Rjv3nmsJ_Ljn9hSjen8AIFxAmw:1tBmr3:RuZAElhO-KAG8iap9mdXmLR41MWnaHnuR3o2Sk1tP1A	2024-11-29 03:18:41.786275+00
e2t3slaf9kqu2ua7uh3ybe79jwgb2ov2	.eJxVjE0OwiAYBe_C2hAwUqBL956B8P1gUQMG2kRjvLs26UK3b-bNS4S4zFNYOreQSYxCayt2vytEvHJZEV1iOVeJtcwtg1wVudEuT5X4dtzcv8AU-_R9K4_JqKiT9YSsDioBpqgH9I44avTokI0aBiCdHFow1lnUzigCA_u0Rjv3nmsJ_Ljn9hSjen8AIFxAmw:1tBmr8:eYFdujiwZJeOhFkrOVGt6OMyq4RRTdDBf_aZmzzuNC8	2024-11-29 03:18:46.09097+00
kdn9pw2ny9j2h0yhusiq7wwb70hprjom	.eJxVjE0OwiAYBe_C2hAwUqBL956B8P1gUQMG2kRjvLs26UK3b-bNS4S4zFNYOreQSYxCayt2vytEvHJZEV1iOVeJtcwtg1wVudEuT5X4dtzcv8AU-_R9K4_JqKiT9YSsDioBpqgH9I44avTokI0aBiCdHFow1lnUzigCA_u0Rjv3nmsJ_Ljn9hSjen8AIFxAmw:1tBogH:sRCFV9Mv-wwI8138ayfw3_aTh7tA1U-AVF1IQyH_h8Y	2024-11-29 05:15:41.540955+00
laxn5yl7olj704lg6s2fm415i2awofm5	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tC2AA:SM9ru-W21WrTtii0MMB_KiUW-xaiEcnnMKpf_g6p9oU	2024-11-29 19:39:26.612838+00
3b9jrdhbx1wbvuoydxkxuiph57akkwvd	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tC2AM:uBoFNxO2ohgeQ0RVjs993BCOo4TFiVkGIWhyBFM3C98	2024-11-29 19:39:38.066982+00
h5f3v0500bljq789dcf04povdbatxrl6	.eJxVjMsOwiAQRf-FtSFDgRFcuvcbCI_BogZMaRON8d-1SRe6vefc82LOL_Polk6TK4kdmBCK7X7X4OOV6orSxddz47HVeSqBrwrfaOenluh23Ny_wOj7-H1HAolGRgN2EEErobQHkhYxZOEJzT4jIg0D6WByRrBJeYQMUpMNQGu0U--lVUePe5me7ADvD7nXPxs:1tC32n:FbvVTiK0lzYLlNVJRjGWDX4Xbj1I-Lt4HJuwgCQarF0	2024-11-29 20:35:53.500984+00
qsrdj7gqrex99gxa9v3hrwynsc6ubcfm	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tC3LF:LuuvHk5s_ZU6dYsx47YwbY1YBoHcJdesoWYAUqXNEGs	2024-11-29 20:54:57.075396+00
4e1anzy3ksxka99y4991ckiof1qmrinu	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tC3LM:UAewZJTOye9zM-kZAE5uOT3zBS61rQCvlK2ub5-4boU	2024-11-29 20:55:04.908074+00
jowigu1ppvtt510u5awbvczaw0p1zvvb	.eJxVjEEOwiAQRe_C2pABWph26d4zEKaDFjVgSptojHe3TbrQ7Xvv_7fwYZlHv9Q4-cSiF0qhOPxSCsMt5k3xNeRLkUPJ85RIboncbZWnwvF-3Nu_gzHUcV0DAfHgnDFszhYRAwZg6Drl0EFnm-Aaxa3WLZJCTWg1ALQA1lBcwXZaY62pZB-fjzS9RA-fL5LbPb0:1tCi62:2Wa-9JbQljEOikfAylUK1PNzm171pfCNvmRpl_cZ6Ec	2024-12-01 16:25:58.245152+00
f40gtmprfd28xb9cht1ji0qnanuwkj71	.eJxVjEEOwiAQRe_C2pABWph26d4zEKaDFjVgSptojHe3TbrQ7Xvv_7fwYZlHv9Q4-cSiF0qhOPxSCsMt5k3xNeRLkUPJ85RIboncbZWnwvF-3Nu_gzHUcV0DAfHgnDFszhYRAwZg6Drl0EFnm-Aaxa3WLZJCTWg1ALQA1lBcwXZaY62pZB-fjzS9RA-fL5LbPb0:1tCi64:N0ve2uNEH0B2m3ANgRYTrCCoSQAs_YHf5OMFA5yc9TI	2024-12-01 16:26:00.736093+00
zxe46vrv9jgr2hlxvmltjg11zq53jgvx	.eJxVj0FvhSAQhP8LZ2MEUcBjD02TpknvTUMWWJVK5AW0hxr_ezHvHdrLHuabmcweRMO-zXrPmLR3ZCCUVH81A3bB9QLuC9Yp1jauW_Kmviz1g-b6LToMTw_vv4IZ8lzSUjSqY2h41wquuFQta42THReWM06NAWegc9JYLkwv-Ugb7BEb5EIq1Y-l9D5Ah3J3mLCU4lrkHK2HANbGfd103mDDTIaD_KgXeHbv3tFsXtNSRnwc5JaixVw4CXHyV9zBBmRY9xAqclssalte0d-Y_Ogx3clZUdEy1VBJRc2Y5JLKz_P8BeO7aII:1tH4vJ:weXSIBHTQG_yyyh_bF5WThUy1XjEsMJnoTKaq7Mqk_g	2024-12-13 17:36:57.333165+00
n4iycip52347f3cpvhqedu0dk36whsbq	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tIciQ:fD_8Ii8wK0wJoLAMBt90JRtgPo3AYy8EP1AZfbTRaQM	2024-12-17 23:54:02.720393+00
638f7wsti1yluxj7psuyu980cdb1oao8	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tIqqI:l7qVOxlBEQQEs_1xqLPPblxOYKIb4Bd5PhnvPa-5RNc	2024-12-18 14:59:06.462981+00
9u4wqudzzzb4hn10tvzfrmbdm3kgenrf	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1thWRM:HZP0dVSEwJpM1XcNxTY4u6T_s-CEdX9GBC3yh80GAQE	2025-02-24 16:15:20.40278+00
f3hk69nll8w3ig8od6pdjp5z9cmatlxx	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tKlIZ:SMRk9MbWGW39t2lqAPEcIrwyRH_JxvVHNEjC995BWKM	2024-12-23 21:28:11.130367+00
kip0tx8qib84b5m38qtmfum6y8l7mhek	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tKlJE:Hyxg9fooxcrA5iRyVtjhbvET3g-FVR0n8Go2KCtixYs	2024-12-23 21:28:52.130289+00
fxw37zb4r73cypx985pubafhn2p1ns5z	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1thWRn:JRRXC4RzzWy7X6Lx0qCNjAFoy9BimOu4mDcQ2yCqSvE	2025-02-24 16:15:47.980015+00
aaepziv8nf4ezptntl1renek70boh0zb	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tmwjm:1qJIr3i8JuO54kr-LF4VIgFCYnpG4kRP80tXIB_Bhh0	2025-03-11 15:20:46.880633+00
avmwzkodydzdgf900it8thytkiesys5h	.eJxVjEEOwiAURO_C2pB--YC4dO8ZmoEPUjVtUtqV8e7apAvdzntvXqrHutR-bXnuB1FnRezU4XeNSI88bkjuGG-TTtO4zEPUm6J32vR1kvy87O7fQUWr3zrEArFe4AAJsJQYJwtTnBQ2nkAhi2UTO2-CC8F1RJRhj8xcxEf1_gBQEThq:1tq4FY:rXELKP2E_nFTgqlpFzCuXXVfrGhBrlqyftPGCOCZy9Q	2025-03-20 05:58:28.439663+00
wbx18kvm1z31vu729t8d6el3arm90rgn	.eJxVjMsOwiAQRf-FtSFDgRFcuvcbCI_BogZMaRON8d-1SRe6vefc82LOL_Polk6TK4kdmBCK7X7X4OOV6orSxddz47HVeSqBrwrfaOenluh23Ny_wOj7-H1HAolGRgN2EEErobQHkhYxZOEJzT4jIg0D6WByRrBJeYQMUpMNQGu0U--lVUePe5me7ADvD7nXPxs:1trrdM:LMv3QPSTlkR-YLqihDNDdsyoqfmtDMKBsl3R0FKBriI	2025-03-25 04:54:28.524614+00
k3p9e72l21nvyoear57jvk4tv58l037q	.eJxVjDsOwjAQBe_iGlle2-sPJT1niHbtDQmgRIqTCnF3iJQC2jcz76U62tah25os3VjVWQFmdfpdmcpDph3VO023WZd5WpeR9a7ogzZ9nas8L4f7dzBQG741JzCAIGCdsA1kMJFHJuktsAeD4HzsQ8o2cKAcgKPJtkRBdAkDqPcHCb423Q:1tuUSq:mB2b7h2OuA9eQBTRTPaZqSyu69EVH6AYn-DEAZlp_wQ	2025-04-01 10:46:28.914382+00
s6422yok4a21mj263vuw3fvpx5e0mexi	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tKlLf:aL6NZOA5oWYCdluXP6YyiaYoZ1wwHizJbnmRTBy451g	2024-12-23 21:31:23.352032+00
5ev5vnpti3gb2bvng00hy1oaj4iduyuh	.eJxVjcsOwiAQRf-FtSFDebt07zeQAQapGpqUdmX8dyXpQrf3nJz7YgH3rYa90xrmzM5MSGCn3zVielAbKN-x3Raelratc-RD4Qft_Lpkel4O9y9QsdcRRquAEDxo56J0CWQxWKwX30vvjVdkdZJIGkFNEWKRUiXtPERTJkHs_QEHWzdt:1thWXi:wxo2yvp_EHpd-VCk1Z-8n47sXR4tnFRkvfNhdRCIL04	2025-02-24 16:21:54.693031+00
2tkxnls8e3saihg87s21kmuinuow9spn	.eJxVjEEOgjAQRe_StWkKdQrj0j1nIDOdqaCmTSisjHdXEha6_e-9_zIjbes0blWXcRZzMY1vzel3ZYoPzTuSO-VbsbHkdZnZ7oo9aLVDEX1eD_fvYKI6fWuv2iqSTwEBoAEM3EHoNSWUhBihF8cKTrjziXv1Z6DGuRiYFdWLeX8AN-w46A:1tltEY:m1uocnV2gKkYWeFrJ555AK_I9j3Ig5FVi-SD0iHqYbs	2025-03-08 17:24:10.784618+00
y2kkjn15dtq82enqk9jz0gs2cfsyn7ex	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tmwjr:JaCF6RrotpjHiRbsXaSt0zPiEtFzg4gFECHsE1mJp0E	2025-03-11 15:20:51.63453+00
b4on6tuzbc09p4a1csh64muvam41o11b	.eJxVjMsOwiAQRf-FtSE8hkdduvcbyMCAVA0kpV0Z_12bdKHbe865LxZwW2vYRl7CTOzMJHh2-l0jpkduO6I7tlvnqbd1mSPfFX7Qwa-d8vNyuH8HFUf91slMYJTNUyRJAgtY4UE7qb1NwvoUpTPoCxQHSsmYFRYlHApC0NYqw94fFdY3cg:1tqpTH:d2AdUkbNpO3lkHXpTEUdUD3hOzWUkhXl1FfYYG6MKO4	2025-03-22 08:23:47.859532+00
0ohz447o7dr8fm88yuuce9vrgy8riahr	.eJxVTrsOwiAU_RfmhkALV-jo7jcQHpcWNWCgTTTGf7dNOuhyhvN-E2PXZTZrw2pSICPhXJDul3XW3zDvUrjaPBXqS15qcnS30ENt9FIC3s-H969gtm3e0h7ZAGrwiumeOym4kJbhoAFc5BZBnSIAYN-jdCpGYDoICyyyQaJ2DPfShq2lkg0-H6m-yMi645S5b7jaCbehpZLPF8MoRwU:1trri4:ilxYZd1VUPkIsADITJ34yFXJMEAbuuO-g4h7MEgw3Zs	2025-03-25 04:59:20.533414+00
jh22efn7azmwn7zffsd359mkz58gq5fg	.eJxVjMsOgjAQRf-la9PQUgbq0r3fQObREdS0CYWV8d-VhIVu7znnvsyI2zqNW03LOIs5GweNOf2uhPxIeUdyx3wrlktel5nsrtiDVnstkp6Xw_07mLBO35q808FBCNr2DWiSNoAyNijIvYJXZJAokf0QkSNRGwiVxIc-do478_4ATOI5Wg:1tuzm9:Oj9_i3lBP6P7ZVmtG-ayKuNjZFK2iz9UzZNqDHLuRos	2025-04-02 20:12:29.240981+00
ffkbvc23q80gechu79nvpsqjjxxzhv2t	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tKly4:uQ-Nab6HDbbh1oRRQxv0mt8CKDwNGQMW6V1CJw0-3To	2024-12-23 22:11:04.428177+00
dfeb9jbkj5eno2qj16sn9iwld7w9yj6n	.eJxVjEEOwiAQRe_C2hCmFASX7j0DGWYGqZo2Ke3KeHfbpAvd_vf-e6uE61LT2mROA6uLAgvq9LtmpKeMO-IHjvdJ0zQu85D1ruiDNn2bWF7Xw_0LVGx1e3sw2Rax7DqP3IdMXQCw0UEsgmQJemM6vwXZngU9YQ4YqESW6Lxk9fkCMfs5GA:1tlWz0:UVPoJ2eWNTkLTCsukf_4pvjquOyH5WcZHWhyrKm7ZMw	2025-03-07 17:38:38.372807+00
dgs228qhh0ysn0mivhgkk2i40yde1zxx	.eJxVjDsOwjAQBe_iGlmx179Q0ucM1u7aJgHkSHFSIe5OIqWA9s3Me4uI2zrGreUlTklchQIQl9-VkJ-5Hig9sN5nyXNdl4nkociTNjnMKb9up_t3MGIb91qb4tlTsYU6p5ktAXIOBCFQD-jZaoMuma636LNzBnplE-xSyUqrIj5fQ3o4lg:1tm9zr:hhTZAhZRo7HBhHiM1z1QDdEylXoIVzrtZTV_mPt-hkw	2025-03-09 11:18:07.669034+00
ad9javriptqg2w3cjqv99zxqbhzy1jjq	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tmwjt:FKW4h0v1oeIISgQGW_XIaENOQVpF9WrHI9Hgob4ZU_Q	2025-03-11 15:20:53.053674+00
scnwb62nu5z4ggt4vqkj440few7kof3t	.eJxVjMsOwiAQRf-FtSE8ymNcuvcbyMCAVA0kpV0Z_12bdKHbe865LxZwW2vYRl7CTOzM5ATs9LtGTI_cdkR3bLfOU2_rMke-K_ygg1875eflcP8OKo76rZWKToAUgB4TaQ9eCDJxSgKooLO6OLBelOy0Nai0ysqAjiZTdEmawt4fGNY36Q:1tr94F:2CchW7fsc9V8abwqN1DDsclPoBwKkDtWRe72rzaXLBQ	2025-03-23 05:19:15.725584+00
qb6d7xhf1853pjfhbkjj0tpjkeseg15h	.eJxVjEsOwiAUAO_C2pDyB5fuewbygPekamhS2pXx7oakC93OTObNIhx7jUfHLS6FXZkwkl1-aYL8xDZUeUC7rzyvbd-WxEfCT9v5vBZ83c72b1Ch1zEGJz1YQ9kX67USAT0IT5hlSYFsKhqJbCA5CU3KOUhJSW0yhkmCU-zzBT5nOKg:1tsLIj:snGrvIXIfd0NO3g2-DMN12TUhQzRmR0DBswoqt7R1yU	2025-03-26 12:35:09.699645+00
m996ejjqp63xwbu894skdl6c6ujf3mhp	.eJxVjEsOwjAMBe-SNYpk8nHCkj1niOzYoQXUSv2sKu4OlbqA7ZuZt5lC69KVddap9GIuBiKY0-_KVJ867EgeNNxHW8dhmXq2u2IPOtvbKPq6Hu7fQUdz960jZJdc8A1dji3BGaqgAjcKyORYJDJQRFbfavAKqWYXBKtm71C9eX8AJj04fg:1tvVeV:e8MVTrcvgPenOspO1nl64379Ra9TDYLYZovXHQX-8wU	2025-04-04 06:14:43.301232+00
13c2wvzifhzt2zvbehk788mlanecj0ak	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tKllh:YAX9RWSIvcG7nC_fNFtrDS05Ivnfl-JGsBaR5arqTlY	2024-12-23 21:58:17.201287+00
a77yhh1gl6pbm7ezo0bm8leg0pe8kz4l	e30:1tKm2V:6gRPaXml6BxP_yUkWNlmLEIWAzjafl5wjOMfSE1Fpeo	2024-12-23 22:15:39.387741+00
87d6fqqa0vzpiujafh1xnkprnx3ilaq6	e30:1tKm2p:JIHyWg2RQ49u1AaiDISCg3trdoWr3KQbX11OX8woMeE	2024-12-23 22:15:59.449256+00
gtyubvax0rqmtrnbkcr29qo4fr8m863x	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tKmMu:QW2pjQ785NzuNlWDOXywf2633CXCoC3ffVxWf-G2LaY	2024-12-23 22:36:44.360274+00
cxvx0xfju3vekdq5b16dkrn5v5n58b2k	.eJxVjMsOwiAQRf-FtSFDgRFcuvcbCI_BogZMaRON8d-1SRe6vefc82LOL_Polk6TK4kdmBCK7X7X4OOV6orSxddz47HVeSqBrwrfaOenluh23Ny_wOj7-H1HAolGRgN2EEErobQHkhYxZOEJzT4jIg0D6WByRrBJeYQMUpMNQGu0U--lVUePe5me7ADvD7nXPxs:1tKmOp:iNEUNgZcWRgTFaZPwp5Z4GEhhl5ZVY2jxYCPQ2HQAC0	2024-12-23 22:38:43.504504+00
q13eg0u80jh3pabshy9ie4dxqo1ckoti	.eJxVjMsOwiAQRf-FtSGU8uzSvd9AZmBqUQOmtInG-O_apAvd3nPuebEA6zKFtdEccmID6zrPDr8rQrxS2VC6QDlXHmtZ5ox8U_hOGz_VRLfj7v4FJmjT9w0oe2218RgjWYMmSa8kkZWYIDpL2I9eIwmNVjjheqm9BaMSwAjeqS3aqLVcS6DHPc9PNoj3B_m_P-k:1tKmYV:tByoVTwdiecFreHUmnJ1d9rwCUEqO9sPuDvVM7uDhe8	2024-12-23 22:48:43.721049+00
ler48ld12vfhvp81uxcuk80c67hls8se	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tKmq4:svuyVOg48vSiHtfE8h73B-NAUwhDD5vHWbs9zjBhnSU	2024-12-23 23:06:52.39078+00
c3fcvsff76773p9ng0ch9vydgy88ko58	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tKmuo:on9gEcEz_4A176B-frh8dIrLh-E_-xb1gpMXyq4QTHY	2024-12-23 23:11:46.647264+00
fxkv7k2faqw4ua9jdwvtrac22n56kz02	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tMCiT:PaoOBTRPnd8Wg-Fq2_bcplrrRO2eBVFRQTfmuJVDhT8	2024-12-27 20:56:53.43943+00
ogw88dfn9o3lzac4lt9xgkj0vn9tnly2	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tMGLZ:WtkGO5nKrsDk3Z23ba0lwapulMIuJhZ1ToVU1ZNDpk4	2024-12-28 00:49:29.967373+00
wb5h53n2157sxbyuz84nx1q6hyh4got9	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tMQvG:TYpSyt_oGco2wndDaYwrmWNSOOJt5iH4rBqbWZHk5ws	2024-12-28 12:07:02.836159+00
zd47b2jyizyttr9ggqqxvlxnhxpjtqp1	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tMSEj:Pzdhcr1a6Mphw47rFnA4PtvtyBcBqunLCK3d0e4JnB0	2024-12-28 13:31:13.496719+00
04jxbxibgh6t6l0bttzbs835vgxns2sy	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tMotE:43-lWZnlEJ-szOxbUasQQDQ8ZUKhVrkhAL2knfqNup0	2024-12-29 13:42:32.670382+00
s5p3psmum8nfdvlb2x7mii1gb55ixnuo	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tMqOm:2XZ0oq0zwR86y4YSvgRWpUf4KHsyCYkjBp5CqTc8Yfs	2024-12-29 15:19:12.261881+00
lint6yt08qx0jo9dr8v5hochrjo6nlq4	.eJxVjEEOwiAQRe_C2pCZwVLq0r1nIAMMtmogKe3KeHdD0oVu_3vvv5XnfZv93mT1S1IXhQTq9LsGjk8pHaUHl3vVsZZtXYLuij5o07ea5HU93L-Dmdvca5yMyYIGRwgoDiAjZCNTwshsBwnTIJFAHBLDSBSz2GTJJcNCclafLyg2OHg:1tNC7L:1nZSaRz2yx7P7ahZ9hwAtge538LyN99mtyMQ-enR1fs	2024-12-30 14:30:39.295332+00
ikhpsbs5xinjpb76qtamgui8dhpz6bd7	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tNOMv:ztj75OCJRUVT2zOBLG-0k6ITIM69iz3tEQI53b5AW0c	2024-12-31 03:35:33.266324+00
m71ehv4yddb41h3jyjg2jn0nm3fpltva	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tNuMr:smYfStarlXJTansM1WMLDTseUgNhYJAKw_AEXzCSAfQ	2025-01-01 13:45:37.388329+00
8ywux1ed840z75m2s4w9oiu3yn309h5e	.eJxVjEEOwiAQRe_C2hBwCnRcuvcMBJipRQ2Y0iYa4921SRe6_e_99xI-LPPol8aTzyQOAsTud4shXbmsgC6hnKtMtcxTjnJV5EabPFXi23Fz_wJjaOP37XoajMWeTTAabLBDh0Yp2yPxHiKyYUgQwVl21DmDCiNS0IBx0KzTGm3cWq7F8-Oep6c4qPcHcbM-1Q:1tPVMN:3IqjvycNLYDSc7x7HSns2MjWaZKcP_zlXBUrmRtiG2k	2025-01-05 23:27:43.608715+00
qrecoasuv2sttypcu6mci1zu4b9ui2ku	.eJxVjjkOwjAQRe_iGllxMt4o6TmDNWNPFogcKU4qxN1xRApofvGXp_8SAfdtDHvhNUxJXIUSl1-PMD45H0F6YB4WGZe8rRPJoyLPtMj7kni-nd0_wIhlrGtnG69bJtCdBQ_Od21HyWmwEVpQRJgIdXIUwZJx0KuGDXPDYJ33pq_Q74EwV91x4ArlLN4fFEA_Ng:1tPnYV:ZfPvTHyd1SqnjY8O0U_QMo3DzMtFPtXgP7_URsANvyM	2025-01-06 18:53:27.286503+00
7v6oaj669j1zrjk8kby7j431ey5lnt2d	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tQAdk:sGII09j-J4Z7qyioHm0aaY1R8OhfU9WZia0NF5r3xyw	2025-01-07 19:32:24.824862+00
uhvtkf3vzwp2glzbukn6dg7xxm9yyvaf	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tQRuz:kqjPhZsN0jQhSAbkfdDAqg-IwdJDuqYMeyWRHEIg-uU	2025-01-08 13:59:21.472713+00
qoe8c0ddqbtdozuxbajccexpotgdzep0	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tQRv1:xXm1HLi_62AgP6OGHcZWQNAEwLdYhBAJLFtodBbuJJ4	2025-01-08 13:59:23.057421+00
y3unp99ssm1d9qjmm4pxzotwjzdzz2g0	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tQRv4:xp5FjQK2NhQYwBEVn_nlOO__LsSists72LC7SQE8CvA	2025-01-08 13:59:26.435756+00
i91cgitsskfrjc3z5hsw4lqmih473vvf	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tQRvG:pu2zqUuetCe4Yp5H77XzMsxHwndM_pYm73rYfg-2KnQ	2025-01-08 13:59:38.125328+00
p2u17yjj855rdg86r4ezruc8coxst86f	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tQRvI:hI29DT74ndE-LkqEPvaOZchpyLr4mUwTVd4GBZLqO70	2025-01-08 13:59:40.746455+00
ylhcj4p9totmw4y5mqcsbtojtc8z5leb	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tQRvL:an0flYCf1yw0PfpcwuBwIso0oHr-HvTkc32yUTeuqcw	2025-01-08 13:59:43.31097+00
xzf674i1x07qrr7oc4nsvorrf0vwup54	.eJxVjMEOwiAQRP-FsyEVKLAevfsNBNhdqRpISnsy_rtt0oPeJvPezFuEuC4lrJ3mMKG4iLM24vTbppifVHeEj1jvTeZWl3lKclfkQbu8NaTX9XD_DkrsZVsDeocJMZEj5YEQfB6VZR4MkGUHsEVWkR0niNbh4HjUmL3ynA1o8fkCY0k5bQ:1tmRKv:8ur0yU3SHkMc6YsOLyG3P0iqcDHFeSsc6xnuGCBzFsw	2025-03-10 05:49:01.180501+00
y392gr94xv7qysc2f89nd4b4dni221iy	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tQRvF:srTO2fYuHoPrcs7w3f9Dvu9pAQiashfjl-4QOb5-3EU	2025-01-08 13:59:37.044586+00
z1gr06p230j7nggvvu613x4zkkb2iy2l	.eJxVjEsOwjAMBe-SNYpiO40JS_Y9Q2WnCS2gVOpnhbg7VOoCtm9m3st0sq1Dty157sbeXAzQ2Zx-V5X0yHVH_V3qbbJpqus8qt0Ve9DFtlOfn9fD_TsYZBm-tXfgSBMU5hCVNCdEJFVyTYhegivApXECzCVEYMyJ0RNKRAixZPP-AAybN0A:1tnBrM:BD7zoX8g8yrUmFDGrYZPdHXnuYdhTG-TjIOakFrQ9cg	2025-03-12 07:29:36.15795+00
3zl1jfoe1nebx53oia7hpidftpe54mjo	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1trKTk:72sGKomSiWif7F83h1Q1TndqrgharGUsXEaqN5BkQIg	2025-03-23 17:30:20.360343+00
1rv1bdltnxr3jk5i879mpk8c39f21nr0	.eJxVjMsOgjAUBf-la9OUS1upS_d8Q3NfFdRAQmFl_HclYaHbMzPnZTJu65C3qksexVxME1pz-l0J-aHTjuSO0222PE_rMpLdFXvQavtZ9Hk93L-DAevwrTUphYjn1IaOHZAKQgHqIIJzHiFJEUUmchoDeu8iE8cOfGmSqGfz_gBITDkb:1tspr9:O25qBp8um0BCDHxLWQDSEhz1puAaOBHn89uHnz2hJDk	2025-03-27 21:12:43.200837+00
15c32igguz15razs5he4ou9iucb3mdeb	.eJxVjEsOwjAMBe-SNYoStwkxS_Y9Q2XHDimgVupnhbg7VOoCtm9m3sv0tK213xad-0HMxfgI5vS7MuWHjjuSO423yeZpXOeB7a7Ygy62m0Sf18P9O6i01G8dM5UW26SAgQP6kkrjmuhcEMxByRdIKHBmFeQISlFcRmF0AMgpm_cHLSA4fg:1tvl0M:EJo9BHzq5D4ofkUmL5JvmNCHiRNnj5PwOdSxpej5_IY	2025-04-04 22:38:18.71927+00
sskgcayx0dia6umbhqcscrl5oceb4bkx	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tQRv7:6PnVAbvFCNkQHcFNZxJmzp5_27pEGftW18llRvnT_2M	2025-01-08 13:59:29.814475+00
1zvxuyzu6p0uuigilf3491vlj33f6d2b	.eJxVjMsOwiAQRf-FtSG8yoBL934DYQaQqoGktCvjv2uTLnR7zzn3xULc1hq2kZcwJ3ZmUnt2-l0x0iO3HaV7bLfOqbd1mZHvCj_o4Nee8vNyuH8HNY76rQncRApRpqlIbRG1I6WASNlExRaAWIQXkqRxBFoqb53wDoAUmZINe38AOCs4Fw:1tnsM1:vCDcQBPlPYFiXnsMa8AOGX707ff9EuCIr_4aHyL3Fvw	2025-03-14 04:52:05.960177+00
qnjbdgq3ufu1zdudph657tdrlwf9p53y	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1trPDt:xwo838OHJOfWv3aibavrXTTYIGN1MMbf9nF5emtOwSc	2025-03-23 22:34:17.725174+00
bza1j3lz6hyjc7djfyialzo0hndjll8e	.eJxVjEEOwiAQRe_C2hCgDA4u3fcMZAaoVA0kpV0Z765NutDtf-_9lwi0rSVsPS9hTuIiNFhx-l2Z4iPXHaU71VuTsdV1mVnuijxol2NL-Xk93L-DQr18a2Sww-QzYDyTRY2YjALFVgMaRs3D5LR3nijGgXwCZZnZeevZOEck3h8VOjfh:1ttBNX:sNpsOI20uu9tvFVs641SvU3-WFAp4YY8yBDDEcWADX4	2025-03-28 20:11:35.309778+00
bezc66xstl6ilhnp3gvpu0boz0vakmsh	.eJxVjEEOwiAQRe_C2hAZ6AAu3fcMZKYMtmpKUtqV8e7apAvd_vfef6lE2zqmrcmSpqwuyqBVp9-VaXjIvKN8p_lW9VDndZlY74o-aNN9zfK8Hu7fwUht_NbR0hkQXRCPEcCRKRR9gcCZACNSxwWNMyCBSagTAZeLgewtF8ei3h8c0Tic:1tvxtv:bfNqrwoEpoVOsSnQI59C7r5Vilo9hNZNRQ0pIYY0MDs	2025-04-05 12:24:31.848219+00
83pbm25sinmjqqlggo1i4tmgkrsghnga	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tQRvG:pu2zqUuetCe4Yp5H77XzMsxHwndM_pYm73rYfg-2KnQ	2025-01-08 13:59:38.60151+00
69kax6yxttcjk6xav4sz7n502u7ms5dv	.eJxVjDsOwjAQBe_iGll24l8o6TmDtbte4wCypTipEHeHSCmgfTPzXiLCtpa4dV7inMRZ6NGK0--KQA-uO0p3qLcmqdV1mVHuijxol9eW-Hk53L-DAr18ax-MBquDYcykQHNmxEQegwtWG0IKbIkVTDiMk8kGtVN-NEMiB46UeH8ATj047A:1tmbiT:GgxiIqkHOnrw0Yug0Ur6lm8lMzyv_bWafUbZUCxOyQA	2025-03-10 16:54:01.949094+00
ru31r2gdkwk1l40csvk9l39cm2giiqo5	.eJxVjMEOwiAQRP-FsyG7QCl49N5vIAsLUjVtUtqT8d9tkx70OPPezFsE2tYatpaXMLK4CjQgLr9tpPTM04H4QdN9lmme1mWM8lDkSZscZs6v2-n-HVRqdV9no8AWIrbFMbPZowekXgNE1JpNKtZp57xHxKRyh8mCUYVKZ3uISny-ILk3jw:1toOQ6:BJsfXg71-JevKC692D9W81_g9VDuxa6x4KXnAB9ChsE	2025-03-15 15:06:26.799742+00
j7mespsp7orswagwkn1emt670ddv4tjl	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1trPgL:IgYShkSAM-79p5NqaUjZRqL5oXFucjGsdRRjY4tVGJc	2025-03-23 23:03:41.60349+00
6g6nnquhhtm0f3fqtc0a3825ozk97hi3	.eJxVjEEOwiAQRe_C2hAGijIu3fcMBGYGqZo2Ke3KeHfbpAvdvvf-f6uY1qXGtckcB1ZXBd6r0y_NiZ4y7oofabxPmqZxmYes90Qftul-YnndjvbvoKZWt3URLuBAQsrFBrIFwZxRGLxD8tbYjXeEzhmkgoQWi-cMWTyHLsBFfb5KgTir:1ttT7Z:LRPFkOxX7HySzl1TKGP9C3PaG7xap2YikDePq33bTx8	2025-03-29 15:08:17.2405+00
9lmhnt19h82nf7j2ja8q9mpcw74mq4jh	.eJxVjDsOwjAQBe_iGlnxH1PS5wzWrneNA8iR4qRC3B0ipYD2zcx7iQTbWtPWeUkTiYtQ3orT74qQH9x2RHdot1nmua3LhHJX5EG7HGfi5_Vw_w4q9PqtXQFkYm2MshB8yQ7BF0QwMdLARMYGE5AzBvJxUJHO3qnsdQRtQgni_QFiwzkE:1twQL8:XaHGnqyveD7F8tLpDtZpmnBnqaiaVhbFrNFvO4jigF0	2025-04-06 18:46:30.816562+00
1972sn30jh92m2uagwdhml288hwfm1go	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tQRvI:hI29DT74ndE-LkqEPvaOZchpyLr4mUwTVd4GBZLqO70	2025-01-08 13:59:40.327668+00
4tg6xafva74owm8vxo937lec9cbh1btv	.eJxVjDsOwjAQBe_iGlmx17-lpM8ZLH_WOIAcKU4qxN2RpRTQvpl5b-bDsVd_dNr8ktmVCTDs8rvGkJ7UBsqP0O4rT2vbtyXyofCTdj6vmV630_07qKHXUQdMSBMKIZRFAzobQGtBGmGSTDoWsKokVVyZCEDpohwQOek0aqOAfb4KPTcS:1tmobT:E0tdzbZH3NCG3C5bIWVqv37qv2_xfIhtzAv2FnGwo90	2025-03-11 06:39:39.113878+00
rw286ykffg5wmro7div4z93en1s3p77f	.eJxVjMsOwiAQRf-FtSEijwGX7vsNBIZBqgaS0q6M_25JutC7vOfkvJkP21r81mnxc2JXJtSFnX7fGPBJdaD0CPXeOLa6LnPkQ-EH7XxqiV63w_0LlNDLCAuwyZK2LtssQEkFlLNDRCMDaXfeoTQUAUBlMk5pjHqfQwMiyMg-XywROD8:1togeX:4gLOXMMtmoHEGnTrbYrohR-NrQjV0ppzTZx-rIhWFmM	2025-03-16 10:34:33.831642+00
75g2euxu488tuqxjib3r53bisahwu2e1	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1trPgM:thY7_AIklcpqGosAXNnArE0OFBa87m8GRkwAgeElhGk	2025-03-23 23:03:42.726335+00
2cspcxn51de9pigal2rthsdd5rjsjxg0	.eJxVjMsOwiAQRf-FtSHIlIcu3fcbyAwDUjWQlHZl_HfbpAvd3nPOfYuA61LC2tMcJhZXcTZWnH5XwvhMdUf8wHpvMra6zBPJXZEH7XJsnF63w_07KNjLVmcDaDUNzmuAfLEeMyptjAVlM_jEMCTQmShqB6DI8aamyJay18QkPl8dZThv:1ttkL6:PpWahHCQtWuwmyUJZ87iImdTn9Hx1Ft_FFKD1Ob18es	2025-03-30 09:31:24.422687+00
zkrygxd4ir9t3or2055woiyt7cydfv6r	.eJxVjMsOwiAURP-FtSE8egFduvcbyL08pGogKe3K-O_SpAvdTeacmTfzuK3Fbz0tfo7swqQBdvptCcMz1R3FB9Z746HVdZmJ7wo_aOe3FtPrerh_BwV7GWursrAmUzQuOZJCqUmAtTAyUh5ZCwoBLExAyUFQgaTWEpNANZ21YZ8vGSU3lQ:1twgdZ:sCBgkJaKhaiGOXqojFBW2opST8bP-s7nzVFly6OAK6U	2025-04-07 12:10:37.907667+00
21yee7ulfvm69k3vqlg3ywub57em3xes	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tQRvJ:vO7N7KXkYZmwUkrQhZmQfILhop6o_DoNr_sjwYgNw3U	2025-01-08 13:59:41.756622+00
opuunganxehzrnz9noq06vf1o6hxjxtg	.eJxVjDsOwjAQBe_iGlnr79qU9JzB8meDA8iW4qRC3B0ipYD2zcx7sRC3tYZt0BLmws5MaMVOv2uK-UFtR-Ue263z3Nu6zInvCj_o4Nde6Hk53L-DGkf91rIQCEyC0BM4NARAzk1KYUTrPTgtUUuBZgIHUhZjrUCL0RcrssrI3h_8GDae:1tovOK:RGgaRwKQH53wFCQzybO6xZZ8ukcbphT2Acc8OGwagF4	2025-03-17 02:18:48.84997+00
s0lbrgtr1aia4brkqm0c7mq5ywe0hgyg	.eJxVjEEOwiAQRe_C2pAOLQy6dN8zkBkGpGpKUtqV8e7apAvd_vfef6lA21rC1tISJlEXBRbV6Xdlio8070juNN-qjnVel4n1ruiDNj1WSc_r4f4dFGrlW9s4UOwzdzYjnl0U0xtil8QzAnRiYSDBzmUQdHaIvWePQmDJi4FM6v0BPX84kQ:1tu1md:5R98bX2lIor4Ha7Ob-aM7dilq-3dRJZ40nVFQD-w3Zw	2025-03-31 04:08:59.534049+00
4ihr9388yq6iq5xaoet22rfstfhygav6	.eJxVjMEOwiAQRP-FsyEsC5vq0bvfQBYWpGpoUtqT8d9tkx70MJd5b-atAq9LDWvPcxhFXRQQqdNvGzk9c9uRPLjdJ52mtsxj1LuiD9r1bZL8uh7u30HlXrc1uiIY8eyA0VhLZB0bKwiQiHLh4j16ZAPDliTRYiFLmYsMYBwk9fkCDtU3qw:1tx7R6:GlJPhBaeekPNnDuMTQUk6Ujl_ZuwsmWvlRfb8pYxmOY	2025-04-08 16:47:32.496772+00
cnm2l3dn5pg6tfow643gti0o2hafke61	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tQRvK:XRUmTtUW6KMYutcf67AGmb8JRc-z6NTaMRLzlk6tKqI	2025-01-08 13:59:42.491295+00
acpklhgvwmp7vg21jdrv5x4mnd1he3lo	.eJxVjEEOwiAQRe_C2hBgWqAu3XsGMgwzUjVtUtqV8e7apAvd_vfef6mE21rT1nhJY1FnZbtOnX7XjPTgaUfljtNt1jRP6zJmvSv6oE1f58LPy-H-HVRs9Vt7QxZKwBw6LtkMfaYIlh37gcQ4ZBLwnmwRIyGgsxKHiL1YME4ASL0_Rcw4vw:1tpIdP:gvIWLQDPV-f-Dn7hnc19j7NgdALmzwKJE-xfNaUZg7Y	2025-03-18 03:07:55.134323+00
afepxljoaemc9jgs6azeqpk5iz9jpvtg	.eJxVTrsOwiAU_RfmhkALV-jo7jcQHpcWNWCgTTTGf7dNOuhyhvN-E2PXZTZrw2pSICPhXJDul3XW3zDvUrjaPBXqS15qcnS30ENt9FIC3s-H969gtm3e0h7ZAGrwiumeOym4kJbhoAFc5BZBnSIAYN-jdCpGYDoICyyyQaJ2DPfShq2lkg0-H6m-yMi645S5b7jaCbehWMnnC8LwRvc:1tRhYp:oKsSRO3sbA5Xqv6_f3A70cktBtsnWsYeKkR0R1KrC7g	2025-01-12 00:53:39.145747+00
ijkvmtogtfiwstz2aejd53rxy4a6m9tk	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tRtqi:eLiqcxo6iMEljcCvowj_Mo7m9M0YyYaisCN8TKgFSXc	2025-01-12 14:00:56.091426+00
3agj7ga048fgh8i1mn4tsl897tpxp6x6	.eJxVjEEOwiAQRe_C2hDAAFOX7j0DGRhGqgaS0q6Md5cmXej2v_f-WwTc1hK2npcwk7gIbaw4_a4R0zPXHdED673J1Oq6zFHuijxol7dG-XU93L-Dgr2M2mrvgA1Etn5ilZzx1jNCBIMMRoNjzk4nn5GSilqTV6DUMGmU50l8viXuOBg:1tRtz0:zJI1O6-O-23GAK4xMPeN_AElIdWNpkQadudPDY59CQM	2025-01-12 14:09:30.915595+00
4rib6gzdh69ex6ewz347vyp6nnx1xyzm	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tSEUX:f-taEk6hE6ZIIt9NCp2PnOjUaPcaEnddXesLif01ZQU	2025-01-13 12:03:25.412743+00
dnytn9wymri3volk8nots27dajmev8a0	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tSEUb:sKgy_B7Gtqu-rEenbNTgtPQNWRBgM1ypmAsvk8phTaU	2025-01-13 12:03:29.049098+00
sh7ojm8q82zci4btibaly6djiwxu56sb	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tSEUd:_I6nmjum0iOJUqmSjW7yQJrOyhMHxUp3_2KHPdqZCf8	2025-01-13 12:03:31.04072+00
e27pdu5nd86stxs6bprsfxkkju3d45fe	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tSEUg:Sca1cgNVi0RCIfR07ZXPsd98ZVKsEQAiUXUq_HzJGzE	2025-01-13 12:03:34.96817+00
40mm6xemvgqggtuo5imercbw2yp5ta8b	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tSEVH:NHOJAhxolLx9_OTQ7YdUSAbjErHSuSGH1Ep_RKFShwU	2025-01-13 12:04:11.209793+00
7y2wqz4nxpomq5myiuaep0coyn7c3duy	.eJxVjMsOwiAQRf-FtSFDgRFcuvcbCI_BogZMaRON8d-1SRe6vefc82LOL_Polk6TK4kdmBCK7X7X4OOV6orSxddz47HVeSqBrwrfaOenluh23Ny_wOj7-H1HAolGRgN2EEErobQHkhYxZOEJzT4jIg0D6WByRrBJeYQMUpMNQGu0U--lVUePe5me7ADvD7nXPxs:1tSSGY:9S8MrlwQHDOb3HtPhiAHlTfFbchYqRrShy2SdRzrsHw	2025-01-14 02:45:54.494702+00
uofh7vz043eb0k7frhrqcy3zc5w5nmhl	.eJxVjMsOwiAQRf-FtSFDgRFcuvcbCI_BogZMaRON8d-1SRe6vefc82LOL_Polk6TK4kdmBCK7X7X4OOV6orSxddz47HVeSqBrwrfaOenluh23Ny_wOj7-H1HAolGRgN2EEErobQHkhYxZOEJzT4jIg0D6WByRrBJeYQMUpMNQGu0U--lVUePe5me7ADvD7nXPxs:1tSSGc:lID5wZaJJV_rYt5W7FtD1ggnBnFByyXdSsGNs7OZ5UI	2025-01-14 02:45:58.648854+00
b5g652kddrw5954gpykt0jdarm589mll	.eJxVjr0OgzAMhN8lcxUFAknUsXufIbLPKaFFIPEzob57g8rQLpbPd_fJu4q0rTluS5pjL-qqqrpRl98rE15pPCx50thNGtO4zj3rI6JPd9H3SdJwO7N_gExLLm3vqbYBEGa0lWlQpDhm9iYEK0yEVFFZG2MRxIKRAOOMh6MWvkC_D8ShzI26VKCPWb0_2NhBQA:1tSfwD:2Iqqu6KBPBx4CUGS3aJoH51Gpqzxe4EJ0RbcHmiGTxY	2025-01-14 17:21:49.910314+00
vuspq4uru795pasba9tqb94pcfdzc8rz	.eJxVjDsOwjAQBe_iGln-ZmNKes5grXc3OIASKU4qxN0hUgpo38y8l8q4rTVvTZY8sjor6zp1-l0L0kOmHfEdp9usaZ7WZSx6V_RBm77OLM_L4f4dVGz1W6euWB8IAlOEoevZSM_BGiJOFgl8is7ZCFG8G5wPAGlAEC5oLHsJ6v0BIbU4Dg:1tYTDi:sZH9UXb6-Z0C-WZ7YOfVPirQSongd3FEsfVnW316zVc	2025-01-30 16:59:50.812203+00
72acf39d75h55sorsy4r9k9oy0uj296m	.eJxVjMsOwiAQAP-FsyELUh4evfsNZIFdqRqalPZk_HdD0oNeZybzFhH3rca90xrnIi5CaSdOvzRhflIbqjyw3ReZl7atc5IjkYft8rYUel2P9m9QsdcxTgZz8Qo4aIPWBqcmJGDSbmKlSBMGYMhFs7eJSw42gUFzBqctZi8-XzgUOI0:1tYVaN:RGhrtllTPSHJg1kizkVvOdBBgkSIacJtBpvsF1CetA0	2025-01-30 19:31:23.258464+00
yaq25jkrdsqinwwafeqr70hxjg9fgtth	.eJxVjEEOwiAQAP_C2ZAFKZQevfsGssBiUQOmtInG-HdD0oNeZybzZg63dXZbo8XlyCYmpGGHX-ox3Kh0Fa9YLpWHWtYle94TvtvGzzXS_bS3f4MZ29zHXmGIo4BkpUKtrREDEiSSZkhCkCS0kCBEmUbtUwxWe1CojmCkxjD2aaPWci2Ono-8vNgEny_tXz_K:1tYVb8:HlFsqDi0oS-vfE2IBNku4UfitXXIXG9DZWPbVhPROcA	2025-01-30 19:32:10.676986+00
ix2nm99hd1ds9g2mxzdp5i8xhk0h82eo	.eJxVjEEOwiAQAP_C2ZAFKZQevfsGssBiUQOmtInG-HdD0oNeZybzZg63dXZbo8XlyCYmpGGHX-ox3Kh0Fa9YLpWHWtYle94TvtvGzzXS_bS3f4MZ29zHXmGIo4BkpUKtrREDEiSSZkhCkCS0kCBEmUbtUwxWe1CojmCkxjD2aaPWci2Ono-8vNgEny_tXz_K:1tYVbC:vgg_Rc6Kv6OChOwCJzaZF0lwcjFAbMRgoI08YqKqkY0	2025-01-30 19:32:14.114349+00
0dq13fgywk2lwk4ysk10gz4rwjmnn6c3	.eJxVjMsOwiAQRf-FtSFDgRFcuvcbCI_BogZMaRON8d-1SRe6vefc82LOL_Polk6TK4kdmBCK7X7X4OOV6orSxddz47HVeSqBrwrfaOenluh23Ny_wOj7-H1HAolGRgN2EEErobQHkhYxZOEJzT4jIg0D6WByRrBJeYQMUpMNQGu0U--lVUePe5me7ADvD7nXPxs:1tYpCo:6Peu11CSWcm8uY5GkJyCSgnqVNZQePbkjlEChYFopes	2025-01-31 16:28:22.183527+00
enynlgathxu8tl40t1afhngk31xwxjfe	.eJxVjMsOwiAQRf-FtSFDgRFcuvcbCI_BogZMaRON8d-1SRe6vefc82LOL_Polk6TK4kdmBCK7X7X4OOV6orSxddz47HVeSqBrwrfaOenluh23Ny_wOj7-H1HAolGRgN2EEErobQHkhYxZOEJzT4jIg0D6WByRrBJeYQMUpMNQGu0U--lVUePe5me7ADvD7nXPxs:1tYy9u:R1WClsmAkjpTuGxKyUDCVJhihSq4wAYYrHRpaL52ik0	2025-02-01 02:01:58.124161+00
lzaxyzw5xvq0nmrmi4cdqh521bf5eplp	.eJxVjMsOwiAQRf-FtSFDgRFcuvcbCI_BogZMaRON8d-1SRe6vefc82LOL_Polk6TK4kdmBCK7X7X4OOV6orSxddz47HVeSqBrwrfaOenluh23Ny_wOj7-H1HAolGRgN2EEErobQHkhYxZOEJzT4jIg0D6WByRrBJeYQMUpMNQGu0U--lVUePe5me7ADvD7nXPxs:1tZ8CL:0uU3mcNoAaG6swxhm-mOLPNqVHkXDyWfEvKh6VnPyMs	2025-02-01 12:45:09.577371+00
03j3vn0str33qdsz4v6tv6pqzznygh0s	.eJxVjMsOgjAQRf-la9P0AaWwdO83NDPTUaqmJRQSjfHflYSFbu8597xEgHUZw1p5DimKQWjjxeF3RaAb5w3FK-RLkVTyMieUmyJ3WuWpRL4fd_cvMEIdv--OI3oNCAxOKd9H5LNtNDlCUMbbvkdnyRnW1sUGW-qMAoPKefRkWrNFK9eaSg78mNL8FIN6fwAE-j_A:1ta25P:K8ce1O72avi0yg8ZWWA-f33NWcTCebvZq9JoY1D5SUY	2025-02-04 00:25:43.723762+00
xjfx5tvu34rpvxqpt3dq8f2rv0kdpc3f	.eJxVjMsOwiAQRf-FtSFDgRFcuvcbCI_BogZMaRON8d-1SRe6vefc82LOL_Polk6TK4kdmBCK7X7X4OOV6orSxddz47HVeSqBrwrfaOenluh23Ny_wOj7-H1HAolGRgN2EEErobQHkhYxZOEJzT4jIg0D6WByRrBJeYQMUpMNQGu0U--lVUePe5me7ADvD7nXPxs:1ta28U:Nq7Ztrh80bQIobGsbTIBDfXnMbOztQlwlj_MCflBP9o	2025-02-04 00:28:54.236235+00
32w7zskqhirjxdrwbe9sqmu82ua0g4ha	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1teDCr:U_4zfhUh9gYA56OEa4yj2mbmjvREML_I02rMPmhXDD4	2025-02-15 13:06:41.529743+00
mu7w310njws7sk8g8ycilhbn937g31fd	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1teDD1:7btHcpH1O6-rGcskbLJtwLlVPH77YQDfuWBd3nhs_Ck	2025-02-15 13:06:51.783631+00
pgsmkzks7ohuknmfovoyiyy57f3mcg23	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1teDD2:knfORvtHrmtGOw1xkkCWdwRrIdbQ1rMusY0zoReY2bw	2025-02-15 13:06:52.514031+00
gfy4vbk782wghp79fb3bkvtznmueuac4	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tmwC7:TqE1rEOmji3LLGl16Z5wSh7YPCPa5jCJ40TsQZbMIVg	2025-03-11 14:45:59.456703+00
0nrfoc1rlmybyso0nmv50cy4xihbgx43	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tehwI:_DY-9CwsBhLFdKGBQoD5bnM6aVE2fuWUYARDvNiOIKA	2025-02-16 21:55:38.813696+00
48zaey4d986d9bmwdrtny82wp1hanuqq	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tehwI:_DY-9CwsBhLFdKGBQoD5bnM6aVE2fuWUYARDvNiOIKA	2025-02-16 21:55:38.862378+00
ctnvib9izko7fpvecp3cuh4nunpnvw66	.eJxVjDsOwjAQBe_iGln-rH-U9JzB8tobHEC2FCcV4u4QKQW0b2bei8W0rTVug5Y4F3Zmkp1-N0z5QW0H5Z7arfPc27rMyHeFH3Tway_0vBzu30FNo35r70QwihCMdhDAB600Fm_AZVAgEVPBZIrHDA6th0kKskSCwPkQ7MTeH70bN18:1tehwK:3uHLhUMwZdvb-YrHF3Bg8IVaeyjY6R8OddZAappG32A	2025-02-16 21:55:40.192462+00
eecnfbum0mpejepkxdbaakt1og7i9l4e	.eJxVjMsOwiAQRf-FtSFAeY1L934DYWCQqoGktCvjv2uTLnR7zzn3xULc1hq2QUuYMzszqQ07_a4Y04PajvI9tlvnqbd1mZHvCj_o4Nee6Xk53L-DGkf91sIWL-SUop0gq4QkDEhTCFUBSB5VBkUFTZZANjnlvNXWFUVaR4cTsfcHNFk4gQ:1tpgDU:Kbl7V9w0xTqz0i-Vunc7xC-cWfX0t2G4xktBvNi7iac	2025-03-19 04:18:44.125786+00
so2pfaw9usaognl2izjx51dba27fvu38	.eJxVjMsOwiAQRf-FtSE8C7h07zeQGZhK1UBS2pXx35WkC93d3HNyXizCvpW4d1rjktmZSRXY6fdFSA-qA-U71FvjqdVtXZAPhR-082vL9Lwc7l-gQC8jTJKEmTQ6q2kyeTYqSGUsGXJowOJ3IoHzUunZ2UA-axA-WXQ5BEHs_QEfvjgY:1thWQZ:gz7zE-Tin6DXYYDA4Qf3xYmPMKMGjjlZTYL2vxftAZo	2025-02-24 16:14:31.374222+00
7sehdvh0wp58gojefk0gj5p1ta7cpy34	.eJxVjEEOwiAQRe_C2hCZDlBcuu8ZyDCAVA0kpV0Z765NutDtf-_9l_C0rcVvPS1-juIilFbi9LsG4keqO4p3qrcmudV1mYPcFXnQLqcW0_N6uH8HhXr51mgCEKCxASAgmDzygDzonJMChzZZ1GcmjjlGl1iDVTQCWw5Og0Yr3h8m7jg8:1trfqN:yUnCG912XgkMhFRvN72iZyHY_UZ2gq_HrgjlyWLmJnU	2025-03-24 16:19:07.176382+00
ri1uvdh9nvqabjbim5wlk23nmskgy7t9	.eJxVjDsOwjAQBe_iGll2HCcLJX3OEK33gwPIlvKpEHeHSCmgfTPzXmbEbc3jtsg8Tmwuxkcwp981IT2k7IjvWG7VUi3rPCW7K_agix0qy_N6uH8HGZf8rXtIPRGBV3HgHQYRT5q6xrdRk7QuyDnGGIAVVLsUGZE77htS8gjOvD9Qfjle:1tuA3W:Zu7kli4JZ7r2gMsavylHLthOjrvd5YEY8Oae8SEmZBU	2025-03-31 12:58:58.812803+00
jo2xq56eepsk9wlf67f7fy0zwekv4v5w	.eJxVjDsOwjAQBe_iGlnrjfyjpOcM1mbX4ACypTipIu4OkVJA-2bmbSrRupS09jynSdRZGefV6XcdiZ-57kgeVO9Nc6vLPI16V_RBu742ya_L4f4dFOrlW3MMEQXlZqwIWQDPIWRLhh14S-gseGAXw5CJY0QiMWgZzBAFEFC9Pyi4N50:1txEoy:hx3QedkEinDX_-7SqKkilRdXRlOPa-gT95HYoxcPxAk	2025-04-09 00:40:40.016884+00
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_site (id, name, domain) FROM stdin;
1	beyondboard	beyondboard-me.azurewebsites.net
\.


--
-- Data for Name: gram_comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gram_comments (id, comment_post, date, author_id, commented_image_id) FROM stdin;
\.


--
-- Data for Name: gram_image; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gram_image (id, image, image_caption, tag_someone, date, imageuploader_profile_id) FROM stdin;
\.


--
-- Data for Name: gram_image_image_likes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gram_image_image_likes (id, image_id, profile_id) FROM stdin;
\.


--
-- Data for Name: gram_profile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gram_profile (id, first_name, last_name, bio, profile_pic, profile_avatar, date, user_id, beyondblog_profileid) FROM stdin;
\.


--
-- Data for Name: jet_django_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jet_django_token (id, project, token, date_add) FROM stdin;
\.


--
-- Data for Name: leads_lead; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.leads_lead (id, name, email, phone, source, message, created_at, last_updated, status, country) FROM stdin;
863	Hassan Yassine	hassanyassine@example.com	213791783	W	\N	2024-12-31 18:10:27.776417+00	2024-12-31 18:10:27.776433+00	N	DZ
864	Fatima Khaled	fatimakhaled@example.com	213604853	W	\N	2024-12-31 18:10:27.779454+00	2024-12-31 18:10:27.779468+00	N	DZ
865	Mohamed Amine	mohamedamine@example.com	213609317	W	\N	2024-12-31 18:10:27.781634+00	2024-12-31 18:10:27.781646+00	N	DZ
866	Hassan Yassine	hassanyassine@example.com	213565531	W	\N	2024-12-31 18:10:27.783617+00	2024-12-31 18:10:27.783634+00	N	DZ
867	Ahmed Ben Salah	ahmedbensalah@example.com	213663434	W	\N	2024-12-31 18:10:27.785595+00	2024-12-31 18:10:27.785605+00	N	DZ
868	Mohamed Amine	mohamedamine@example.com	213540236	W	\N	2024-12-31 18:10:27.78739+00	2024-12-31 18:10:27.787401+00	N	DZ
869	Hassan Yassine	hassanyassine@example.com	213681500	W	\N	2024-12-31 18:10:27.790186+00	2024-12-31 18:10:27.790195+00	N	DZ
870	Ahmed Ben Salah	ahmedbensalah@example.com	213506369	W	\N	2024-12-31 18:10:27.792127+00	2024-12-31 18:10:27.792137+00	N	DZ
871	Hassan Yassine	hassanyassine@example.com	213690920	W	\N	2024-12-31 18:10:27.794162+00	2024-12-31 18:10:27.79417+00	N	DZ
848	Stoilka Spasova	stoilkaspasova@gmail.com	359885286529	fb		2024-12-22 13:51:11+00	2024-12-25 14:20:27.802399+00	new	BG
872	Hassan Yassine	hassanyassine@example.com	213713107	W	\N	2024-12-31 18:10:27.796229+00	2024-12-31 18:10:27.796239+00	N	DZ
757	Carlos Rodriguez	carlos.rodriguez@gmail.com	+15387476668	LinkedIn		2024-12-14 13:56:57+00	2024-12-25 14:20:28.340664+00	contacted	
853	Nina Fulcheri	mina.fulcheri@gmail.com	33782237934	fb		2024-12-23 21:37:10+00	2024-12-25 14:20:27.78194+00	new	FR
852	Jean Claude Duran	Jean-Claudeduran575@gmail.com	33684762568	fb		2024-12-23 21:36:39+00	2024-12-25 14:20:27.786093+00	new	FR
851	Lotfi Kanouni	lotfikanouni4@gmail.com	5380546393	fb	xx	2024-12-22 20:04:29+00	2024-12-25 14:20:27.790237+00	new	TR
850	Цвета Манчорова	tsweta@mail.bg	359883270606	fb		2024-12-22 13:51:55+00	2024-12-25 14:20:27.794165+00	new	BG
849	Лили Тенекева	lilitenekeva658@gmail.com	359878912461	fb		2024-12-22 13:51:35+00	2024-12-25 14:20:27.798079+00	new	BG
789	antonio di lauro	antoniodilauro@gmail.com	393388967373	fb		2024-12-15 19:38:52+00	2024-12-25 14:20:28.154861+00	contacted	IT
788	Martina Tura	martinatura@gmail.com	393394521031	ig		2024-12-15 19:38:52+00	2024-12-25 14:20:28.162093+00	contacted	IT
787	Jana Rozenberga	janarozenberga1@gmail.com	393392729343	ig		2024-12-15 19:38:52+00	2024-12-25 14:20:28.172355+00	contacted	IT
786	Joyce March	tamara516mrch@gnail.com	12543501183	fb		2024-12-15 19:38:52+00	2024-12-25 14:20:28.179333+00	contacted	US
785	Joe	jtorresg2001@yahoo.com	14082397089	fb		2024-12-15 19:38:52+00	2024-12-25 14:20:28.186169+00	contacted	US
784	George Gawel	vloopca@yahoo.ca	12267894334	fb		2024-12-15 19:38:52+00	2024-12-25 14:20:28.192705+00	contacted	CA
783	Angela Liggins	angelaliggins10@yahoo.com	19015715763	fb		2024-12-15 19:38:52+00	2024-12-25 14:20:28.199645+00	contacted	US
782	stone smyth	maverickfh@bell.net	17057591376	fb		2024-12-15 19:38:52+00	2024-12-25 14:20:28.207448+00	contacted	CA
781	Muaiao kiliona	kiliona1972@gmail.com	14157609016	fb		2024-12-15 19:38:52+00	2024-12-25 14:20:28.214602+00	contacted	US
780	Jose Batist	josebatista36282@gmail.com	18622189817	fb		2024-12-15 19:38:52+00	2024-12-25 14:20:28.22193+00	contacted	US
779	Janis E Bianucci	jebianucci10@yahoo.com	18653850616	fb		2024-12-15 19:38:52+00	2024-12-25 14:20:28.229569+00	contacted	US
778	menezes Candy	indianamulher@gmail.com	393513170148	ig		2024-12-15 19:38:52+00	2024-12-25 14:20:28.239765+00	contacted	IT
777	Yousaf Khan	youmek01@gmail.com	16104422234	fb		2024-12-15 19:38:52+00	2024-12-25 14:20:28.247074+00	contacted	US
776	jeanette ruffat	jruffat73@gmail.com	12037158052	fb		2024-12-15 19:38:52+00	2024-12-25 14:20:28.254492+00	contacted	US
767	Amara Okafor	amara.okafor@gmail.com	+18610225823	Instagram		2024-12-14 13:56:57+00	2024-12-25 14:20:28.298214+00	contacted	
766	Ivan Petrov	ivan.petrov@gmail.com	+15813168771	LinkedIn		2024-12-14 13:56:57+00	2024-12-25 14:20:28.302448+00	contacted	
756	Ivan Petrov	ivan.petrov@gmail.com	+17846779080	Instagram		2024-12-14 13:56:57+00	2024-12-25 14:20:28.345081+00	contacted	
755	Aisha Khan	aisha.khan@gmail.com	+19249331524	Instagram		2024-12-14 13:56:57+00	2024-12-25 14:20:28.349266+00	contacted	
754	Liam O'Connor	liam.o'connor@gmail.com	+13838614605	LinkedIn		2024-12-14 13:56:57+00	2024-12-25 14:20:28.353838+00	contacted	
753	Hiroshi Tanaka	hiroshi.tanaka@gmail.com	+12896545432	Instagram		2024-12-14 13:56:57+00	2024-12-25 14:20:28.359869+00	contacted	
752	Carlos Rodriguez	carlos.rodriguez@gmail.com	+11900445299	Facebook		2024-12-14 13:56:57+00	2024-12-25 14:20:28.366136+00	contacted	
751	Liam O'Connor	liam.o'connor@gmail.com	+18935141065	Website		2024-12-14 13:56:57+00	2024-12-25 14:20:28.372454+00	contacted	
750	Aisha Khan	aisha.khan@gmail.com	+19765676376	Instagram		2024-12-14 13:56:57+00	2024-12-25 14:20:28.385225+00	contacted	
749	Fatima Al-Masri	fatima.al-masri@gmail.com	+19708084549	LinkedIn		2024-12-14 13:56:57+00	2024-12-25 14:20:28.401318+00	contacted	
748	Sven Johansson	sven.johansson@gmail.com	+15909594672	Instagram		2024-12-14 13:56:57+00	2024-12-25 14:20:28.414886+00	contacted	
830	Dariush Modelis	dariushfashion5@gmail.com	35797828498	ig		2024-12-15 19:38:53+00	2024-12-25 14:20:27.897941+00	contacted	CY
829	Greg Santos	grigorisrantos997@gmail.com	306906717880	fb		2024-12-15 19:38:53+00	2024-12-25 14:20:27.902556+00	contacted	GR
828	Florinda  Maria do Ros‡rio Serra	florindaserra1945@gmail.com	351927809377	fb		2024-12-15 19:38:53+00	2024-12-25 14:20:27.906862+00	contacted	PT
827	Denis Scott akwafei	bt455473@gmail.com	35795584854	fb		2024-12-15 19:38:53+00	2024-12-25 14:20:27.911258+00	contacted	CM
826	Dioma Girard	diomagirard@gmail.com	33656828402	fb		2024-12-15 19:38:53+00	2024-12-25 14:20:27.915848+00	contacted	FR
825	Karin Loubser	karin_loubser@yahoo.com	27620149775	fb		2024-12-15 19:38:53+00	2024-12-25 14:20:27.920118+00	contacted	US
823	Nina Katsioloudi	ninakats1954@gmail.com	35799735713	fb		2024-12-15 19:38:53+00	2024-12-25 14:20:27.925156+00	contacted	CY
822	Joaquim Pop	kikasaguda1974@gmail.com	351912101480	fb		2024-12-15 19:38:53+00	2024-12-25 14:20:27.930942+00	contacted	PT
821	Jana Rozenberga	janarozenberga1@gmail.com	393392729343	ig		2024-12-15 19:38:53+00	2024-12-25 14:20:27.936492+00	contacted	IT
820	Joaquim Carvalho	joaquimcarvalhocbt1964@gmail.com	351964701110	fb		2024-12-15 19:38:53+00	2024-12-25 14:20:27.940989+00	contacted	US
862	Slavcho Asenov	slavchoasenov489@gmail.com	+359892732700	fb	hot	2024-12-25 14:20:27.741524+00	2024-12-25 14:20:27.741535+00	new	BG
861	Иван Димитров	ivandk4528@gmail.com	+359884585529	fb	hot	2024-12-25 14:20:27.746307+00	2024-12-25 14:20:27.746317+00	new	BG
860	Васка Младенова	vesela799@abv.bg	+359878458280	fb	hot	2024-12-25 14:20:27.751022+00	2024-12-25 14:20:27.751031+00	new	BG
859	Марина Петкова	marina_p@abv.bg	+359893328038	fb	hot	2024-12-25 14:20:27.75565+00	2024-12-25 14:20:27.75566+00	new	BG
858	Илиана Петкова	ilianapetkova@abv.bg	+359876989201	fb	hot	2024-12-25 14:20:27.760212+00	2024-12-25 14:20:27.760221+00	new	BG
857	Блага Туничева Туничева	blaga.tunicheva78@gmail.com	+359894539951	fb	hot	2024-12-25 14:20:27.764764+00	2024-12-25 14:20:27.764773+00	new	BG
856	Ahou Julienne	ahoujulienne668@gmail.coma	+33665398277	fb	hot	2024-12-25 14:20:27.769258+00	2024-12-25 14:20:27.769266+00	new	FR
855	Marie Vandebroek	marievandebroek642@gmail.com	+33609524444	fb	hot	2024-12-25 14:20:27.77387+00	2024-12-25 14:20:27.773879+00	new	FR
854	Pierre Veschambre	pierre.veschambre@hotmail.com	+33631535563	fb	hot	2024-12-25 14:20:27.778339+00	2024-12-25 14:20:27.778348+00	new	FR
847	Ioannis Paterakis		306947471848	fb		2024-12-15 19:38:53+00	2024-12-25 14:20:27.806319+00	contacted	GR
846	Martti Savikko	marttisav@gmail.com	358505551746	fb		2024-12-15 19:38:53+00	2024-12-25 14:20:27.810452+00	contacted	FI
845	Thomas Ntokas	tomas.dokas@gmail.com	306944705905	fb		2024-12-15 19:38:53+00	2024-12-25 14:20:27.814492+00	contacted	GR
844	Antonio Henrique Simao	antoniohenriquesimao@gmail.com	351967182283	fb		2024-12-15 19:38:53+00	2024-12-25 14:20:27.818515+00	contacted	PT
843	Joaquim Celorico	jcelorico2002@gmail.com	351932453847	fb		2024-12-15 19:38:53+00	2024-12-25 14:20:27.822564+00	contacted	PT
842	________ _______	Cristinapetrova72@gmail.com	31625164705	ig		2024-12-15 19:38:53+00	2024-12-25 14:20:27.828717+00	contacted	PT
841	Manel Kahavidana	m_wedasinghe@hotmail.com	33768440892	fb		2024-12-15 19:38:53+00	2024-12-25 14:20:27.833239+00	contacted	FR
840	________ _____________	gkokkinos1501@gmail.com	35799221522	fb		2024-12-15 19:38:53+00	2024-12-25 14:20:27.837439+00	contacted	CY
839	Jo‹o Maria d'Orey	orey_joao@hotmail.com	351916866384	fb		2024-12-15 19:38:53+00	2024-12-25 14:20:27.841625+00	contacted	PT
838	maria F‡tima  Caires entrada 43 port	marinaabreucaires@gmail.com	351934253267	fb		2024-12-15 19:38:53+00	2024-12-25 14:20:27.848042+00	contacted	US
837	Vacca	rocedado@gmail.com	393347978667	fb		2024-12-15 19:38:53+00	2024-12-25 14:20:27.852323+00	contacted	IT
836	Kiki Kakli	kikikakli61@gmail.com	306973691129	fb		2024-12-15 19:38:53+00	2024-12-25 14:20:27.859801+00	contacted	TR
835	Stefan Sobotka	stefan.sobotka13@gmail.com	421903602013	fb		2024-12-15 19:38:53+00	2024-12-25 14:20:27.864019+00	contacted	SK
834	e Filipe fomos uma gota de l’quido	alicefilipe@outlook.pt	351961902063	fb		2024-12-15 19:38:53+00	2024-12-25 14:20:27.870232+00	contacted	PT
833	Daniel Roger	roger.daniel53940@gmail.com	33672190048	fb		2024-12-15 19:38:53+00	2024-12-25 14:20:27.874503+00	contacted	US
832	Jorge Fonte	my.music@live.com.pt	351963234830	fb		2024-12-15 19:38:53+00	2024-12-25 14:20:27.885138+00	contacted	PT
831	Kaspars _t_ls	kashelz@inbox.lv	37129680921	fb		2024-12-15 19:38:53+00	2024-12-25 14:20:27.893097+00	contacted	LV
819	Mohamed Aliu Embalo	embalomohamedaliu07@gmail.com	351927559604	fb		2024-12-15 19:38:53+00	2024-12-25 14:20:27.945261+00	contacted	US
818	Maria Victoria Villegas	villegasmaria46@yahoo.com	35796406248	fb		2024-12-15 19:38:53+00	2024-12-25 14:20:27.949958+00	contacted	GR
817	Halide Mahmuto_lu	hmahmutoglu011@gmail.com	905488321388	fb		2024-12-15 19:38:53+00	2024-12-25 14:20:27.954791+00	contacted	US
816	Luc Nakken	lucnakken@hotmail.be	32497740099	fb		2024-12-15 19:38:53+00	2024-12-25 14:20:27.959065+00	contacted	BE
815	Yvett Dubnicka	iveta.dubnicka@gmail.com	421915362448	fb		2024-12-15 19:38:52+00	2024-12-25 14:20:27.963598+00	contacted	SK
814	Manuel Filipe	manueloliveirafilipe@gmail.com	351919876789	fb		2024-12-15 19:38:52+00	2024-12-25 14:20:27.968285+00	contacted	PT
813	Helder Margarido	helder@margarido.net	351969543999	ig		2024-12-15 19:38:52+00	2024-12-25 14:20:27.972801+00	contacted	PT
812	more.ingormation	mparkasgio@gmail.com	306982121662	fb		2024-12-15 19:38:52+00	2024-12-25 14:20:27.977382+00	contacted	GR
811	Savvas Tsestos	savvastsestos@gmail.com	35799930233	fb		2024-12-15 19:38:52+00	2024-12-25 14:20:27.981859+00	contacted	CY
810	Savvas Tsestos	savvastsestos@gmail.com	35799930233	fb		2024-12-15 19:38:52+00	2024-12-25 14:20:27.986666+00	contacted	CY
809	Neacsu Viorica	vioricaneacsu341@gmail.com	40771500723	fb		2024-12-15 19:38:52+00	2024-12-25 14:20:27.991811+00	contacted	RO
808	Jeana Dinu	dinujeana7@gmail.com	40752012504	fb		2024-12-15 19:38:52+00	2024-12-25 14:20:27.996785+00	contacted	RO
807	Ilie Craioveanu	craioveanuilie@gmail.com	40722635611	fb		2024-12-15 19:38:52+00	2024-12-25 14:20:28.002657+00	contacted	RO
806	Ncei Mousavi	Ncmiusavi@yahoo.vom	14165590440	fb		2024-12-15 19:38:52+00	2024-12-25 14:20:28.008832+00	contacted	CA
805	Annette (Antoinette) Guerrera	Annetteguerrera@hotmail.com	15147170272	fb		2024-12-15 19:38:52+00	2024-12-25 14:20:28.01509+00	contacted	CA
804	POPESCU CONSTANTINA	popescuconstantina46@gmail.com	40724947422	fb		2024-12-15 19:38:52+00	2024-12-25 14:20:28.021358+00	contacted	US
803	Vacca	rocedado@gmail.com	393347978667	fb		2024-12-15 19:38:52+00	2024-12-25 14:20:28.028091+00	contacted	IT
802	_______ ______	gavuraevgenia@gmail.com	15149701751	fb		2024-12-15 19:38:52+00	2024-12-25 14:20:28.034799+00	contacted	CA
801	m	gajdojoan@gmail.com6u	40762884007	fb		2024-12-15 19:38:52+00	2024-12-25 14:20:28.041734+00	contacted	US
800	Michaela Argireanu-Ioanidi	michaela043@gmail.com	40759374410	fb		2024-12-15 19:38:52+00	2024-12-25 14:20:28.048265+00	contacted	RO
799	Crisan Petru Ionel	auto2006ctp@yahoo.com	40745593435	fb		2024-12-15 19:38:52+00	2024-12-25 14:20:28.05515+00	contacted	RO
798	Neculai Gorgovan	gorgovannicolaie@gmail.com	40735654892	fb		2024-12-15 19:38:52+00	2024-12-25 14:20:28.062092+00	contacted	US
797	Fadia haddad	maggbeauty@gmail.com	9613046803	ig		2024-12-15 19:38:52+00	2024-12-25 14:20:28.069063+00	contacted	LB
796	Shaukat Pervezs	shaukatp@hotmail.com	13065815454	fb		2024-12-15 19:38:52+00	2024-12-25 14:20:28.075999+00	contacted	CA
795	Gheorghe Zaporojan	gheorghezaporojan1939@gmail.com	40727461209	fb		2024-12-15 19:38:52+00	2024-12-25 14:20:28.083482+00	contacted	RO
794	Constantin Bobai__	costelbobaita@gmail.com	40759397678	fb		2024-12-15 19:38:52+00	2024-12-25 14:20:28.093282+00	contacted	RO
793	Carmela Della Ripa Bilotto	starjojo09@gmail.com	15145761061	fb		2024-12-15 19:38:52+00	2024-12-25 14:20:28.099765+00	contacted	CA
792	Phindile Nxumalo	Phindilemalo@gmail.com	16478593862	ig		2024-12-15 19:38:52+00	2024-12-25 14:20:28.115052+00	contacted	CA
791	MICHAEL CIRIC	komet400@hotmail.com	19542256420	fb		2024-12-15 19:38:52+00	2024-12-25 14:20:28.129273+00	contacted	CA
790	Mindru Cezar	mindrucezar6@gmail.com	40726973885	fb		2024-12-15 19:38:52+00	2024-12-25 14:20:28.147359+00	contacted	RO
775	Giulia Rossi	giulia.rossi@gmail.com	+12245162516	Facebook		2024-12-14 13:56:57+00	2024-12-25 14:20:28.261685+00	contacted	
774	Ivan Petrov	ivan.petrov@gmail.com	+11592662465	Facebook		2024-12-14 13:56:57+00	2024-12-25 14:20:28.266544+00	contacted	
773	Carlos Rodriguez	carlos.rodriguez@gmail.com	+19645054449	LinkedIn		2024-12-14 13:56:57+00	2024-12-25 14:20:28.271931+00	contacted	
772	Aisha Khan	aisha.khan@gmail.com	+17532667127	LinkedIn		2024-12-14 13:56:57+00	2024-12-25 14:20:28.276394+00	contacted	
771	Hiroshi Tanaka	hiroshi.tanaka@gmail.com	+16711884926	Facebook		2024-12-14 13:56:57+00	2024-12-25 14:20:28.280804+00	contacted	
770	Chen Wei	chen.wei@gmail.com	+11640325499	Website		2024-12-14 13:56:57+00	2024-12-25 14:20:28.285055+00	contacted	
769	Sven Johansson	sven.johansson@gmail.com	+12322448814	Instagram		2024-12-14 13:56:57+00	2024-12-25 14:20:28.289551+00	contacted	
768	Chen Wei	chen.wei@gmail.com	+17270361390	LinkedIn		2024-12-14 13:56:57+00	2024-12-25 14:20:28.293783+00	contacted	
765	Sven Johansson	sven.johansson@gmail.com	+13962577431	Instagram		2024-12-14 13:56:57+00	2024-12-25 14:20:28.306669+00	contacted	
764	Sophia Müller	sophia.müller@gmail.com	+11816785230	Instagram		2024-12-14 13:56:57+00	2024-12-25 14:20:28.310922+00	contacted	
763	Ivan Petrov	ivan.petrov@gmail.com	+17134179886	LinkedIn		2024-12-14 13:56:57+00	2024-12-25 14:20:28.315155+00	contacted	
762	Amara Okafor	amara.okafor@gmail.com	+13404854944	Website		2024-12-14 13:56:57+00	2024-12-25 14:20:28.319327+00	contacted	
761	Sophia Müller	sophia.müller@gmail.com	+13685402089	Facebook		2024-12-14 13:56:57+00	2024-12-25 14:20:28.323734+00	contacted	
760	Amara Okafor	amara.okafor@gmail.com	+14921746943	Instagram		2024-12-14 13:56:57+00	2024-12-25 14:20:28.328003+00	contacted	
759	Hiroshi Tanaka	hiroshi.tanaka@gmail.com	+11385486105	Facebook		2024-12-14 13:56:57+00	2024-12-25 14:20:28.332225+00	contacted	
758	Amara Okafor	amara.okafor@gmail.com	+14570132969	LinkedIn		2024-12-14 13:56:57+00	2024-12-25 14:20:28.336441+00	contacted	
\.


--
-- Data for Name: leads_leadhistory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.leads_leadhistory (id, "timestamp", action, lead_id, user_id) FROM stdin;
259	2024-12-06 04:49:37.60975+00	Status changed to lost	749	\N
260	2024-12-13 18:28:23.614946+00	Status changed to qualified	749	\N
261	2024-12-06 02:47:19.617296+00	Status changed to converted	749	\N
262	2024-11-22 19:08:47.619759+00	Status changed to new	749	\N
263	2024-11-20 22:32:24.62267+00	Status changed to lost	750	\N
265	2024-11-20 05:43:57.674549+00	Status changed to converted	750	\N
266	2024-12-03 02:51:49.677155+00	Status changed to new	750	\N
267	2024-11-24 02:23:54.679902+00	Status changed to qualified	751	\N
268	2024-12-06 06:26:05.682872+00	Status changed to converted	751	\N
269	2024-11-30 11:56:47.68505+00	Status changed to converted	751	\N
270	2024-11-23 10:10:30.687337+00	Status changed to contacted	751	\N
271	2024-11-14 12:08:35.689999+00	Status changed to qualified	752	\N
272	2024-11-21 02:21:07.692397+00	Status changed to converted	752	\N
273	2024-12-12 04:01:33.694605+00	Status changed to converted	752	\N
274	2024-11-19 20:43:08.697113+00	Status changed to lost	753	\N
275	2024-12-04 02:57:32.699264+00	Status changed to lost	753	\N
276	2024-11-30 05:08:15.701607+00	Status changed to qualified	753	\N
277	2024-11-29 10:00:33.704098+00	Status changed to lost	753	\N
278	2024-12-05 05:52:37.706507+00	Status changed to converted	754	\N
279	2024-11-24 07:59:41.709298+00	Status changed to contacted	754	\N
280	2024-11-22 05:31:48.711787+00	Status changed to converted	755	\N
281	2024-11-28 13:36:25.714687+00	Status changed to new	755	\N
282	2024-12-07 00:19:29.717462+00	Status changed to qualified	755	\N
283	2024-11-23 22:10:26.720024+00	Status changed to converted	755	\N
284	2024-12-12 05:38:53.722684+00	Status changed to new	755	\N
285	2024-12-06 01:23:04.727896+00	Status changed to qualified	756	\N
286	2024-11-14 02:12:02.730793+00	Status changed to converted	756	\N
287	2024-11-17 13:53:07.733602+00	Status changed to lost	756	\N
288	2024-11-20 01:46:38.73672+00	Status changed to qualified	757	\N
289	2024-12-13 17:56:33.739148+00	Status changed to contacted	757	\N
290	2024-11-30 10:47:07.741411+00	Status changed to new	757	\N
291	2024-11-27 00:42:11.744115+00	Status changed to qualified	757	\N
293	2024-11-28 13:05:44.74677+00	Status changed to new	758	\N
294	2024-11-19 18:13:57.749361+00	Status changed to qualified	758	\N
295	2024-11-29 03:24:20.751825+00	Status changed to lost	758	\N
296	2024-11-17 13:49:27.754466+00	Status changed to lost	758	\N
297	2024-12-10 17:08:13.756709+00	Status changed to converted	759	\N
298	2024-12-11 22:06:27.759044+00	Status changed to contacted	759	\N
299	2024-12-06 06:00:17.761678+00	Status changed to new	759	\N
300	2024-11-22 21:17:11.764008+00	Status changed to contacted	759	\N
301	2024-11-18 01:19:22.766121+00	Status changed to lost	759	\N
302	2024-11-29 03:58:03.768967+00	Status changed to contacted	760	\N
303	2024-12-13 03:01:15.771197+00	Status changed to converted	760	\N
304	2024-11-21 15:20:14.773763+00	Status changed to converted	760	\N
305	2024-11-16 18:18:27.776341+00	Status changed to contacted	761	\N
306	2024-12-08 03:59:13.77876+00	Status changed to new	761	\N
307	2024-11-26 16:16:22.781128+00	Status changed to converted	761	\N
308	2024-12-09 04:22:44.784013+00	Status changed to lost	762	\N
309	2024-11-26 05:18:57.78973+00	Status changed to converted	762	\N
310	2024-11-20 09:00:30.792648+00	Status changed to lost	762	\N
311	2024-11-21 09:47:52.795631+00	Status changed to contacted	762	\N
312	2024-11-15 12:32:07.798195+00	Status changed to qualified	762	\N
314	2024-12-06 16:34:10.800616+00	Status changed to new	763	\N
315	2024-12-08 03:58:30.805505+00	Status changed to converted	764	\N
316	2024-12-06 03:22:36.808208+00	Status changed to converted	764	\N
317	2024-12-09 22:20:38.81085+00	Status changed to new	765	\N
318	2024-11-16 18:27:13.81307+00	Status changed to qualified	765	\N
319	2024-11-14 07:23:50.81593+00	Status changed to lost	765	\N
320	2024-11-18 23:07:07.818722+00	Status changed to new	765	\N
321	2024-12-04 14:29:22.821597+00	Status changed to lost	765	\N
322	2024-12-04 15:14:20.823883+00	Status changed to contacted	766	\N
323	2024-12-12 08:11:29.826762+00	Status changed to qualified	767	\N
324	2024-11-27 20:03:42.830236+00	Status changed to lost	768	\N
325	2024-11-21 08:22:55.832722+00	Status changed to qualified	769	\N
326	2024-12-05 02:06:13.835233+00	Status changed to new	769	\N
327	2024-12-04 13:30:38.837735+00	Status changed to qualified	769	\N
328	2024-11-29 22:21:55.840457+00	Status changed to new	770	\N
329	2024-11-14 02:07:19.842769+00	Status changed to qualified	770	\N
330	2024-11-29 01:20:55.845071+00	Status changed to qualified	770	\N
331	2024-11-20 23:22:30.847378+00	Status changed to contacted	770	\N
332	2024-11-23 20:33:11.882999+00	Status changed to converted	770	\N
333	2024-12-06 11:36:28.886422+00	Status changed to qualified	771	\N
334	2024-11-26 03:53:17.898752+00	Status changed to new	772	\N
336	2024-12-04 07:48:28.901656+00	Status changed to new	772	\N
337	2024-11-19 18:06:17.914787+00	Status changed to lost	773	\N
338	2024-11-14 17:57:44.917806+00	Status changed to lost	773	\N
339	2024-12-07 07:10:03.920362+00	Status changed to lost	773	\N
340	2024-12-02 07:29:38.922621+00	Status changed to lost	773	\N
341	2024-12-03 02:17:55.925387+00	Status changed to contacted	773	\N
342	2024-12-11 21:51:06.938767+00	Status changed to new	774	\N
343	2024-11-20 11:33:44.941874+00	Status changed to converted	774	\N
344	2024-11-20 08:53:09.944697+00	Status changed to qualified	774	\N
345	2024-11-16 21:43:44.947398+00	Status changed to new	775	\N
346	2024-11-23 13:50:52.949997+00	Status changed to contacted	775	\N
347	2024-11-20 12:24:29.952569+00	Status changed to converted	775	\N
348	2024-11-19 14:40:18.966801+00	Status changed to converted	775	\N
349	2024-12-12 00:35:08.970321+00	Status changed to converted	775	\N
258	2024-12-04 18:03:32.666486+00	Status changed to qualified	748	\N
264	2024-12-02 01:53:02.669126+00	Status changed to contacted	750	\N
292	2024-11-18 04:08:41.974769+00	Status changed to contacted	758	\N
313	2024-11-22 18:38:23.982746+00	Status changed to converted	763	\N
335	2024-11-25 05:56:10.985442+00	Status changed to converted	772	\N
\.


--
-- Data for Name: leads_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.leads_note (id, content, created_at, lead_id, user_id) FROM stdin;
208	sc	2024-12-18 13:45:51.365886+00	802	1
152	Client requested more information.	2024-11-17 10:40:29.530795+00	748	\N
153	Sent promotional material.	2024-12-05 23:09:26.534397+00	748	\N
154	Discussed service upgrades.	2024-12-13 19:39:42.537324+00	749	\N
155	Sent promotional material.	2024-12-08 01:25:59.546819+00	750	\N
156	Sent promotional material.	2024-12-09 18:33:20.550032+00	750	\N
157	Sent promotional material.	2024-11-28 07:59:25.555562+00	751	\N
159	Client is interested in our premium services.	2024-11-29 23:50:58.561985+00	751	\N
160	Client requested more information.	2024-11-26 02:07:31.5648+00	752	\N
161	Asked for a meeting with the sales team.	2024-12-11 02:15:11.568061+00	752	\N
162	Sent promotional material.	2024-12-04 05:41:23.57093+00	753	\N
163	Followed up with the client.	2024-11-27 10:00:29.573261+00	754	\N
164	Client is considering other options.	2024-11-24 03:04:12.575966+00	754	\N
165	Sent promotional material.	2024-11-26 13:34:38.578841+00	754	\N
166	Client requested more information.	2024-11-19 03:19:14.581146+00	755	\N
167	Client is considering other options.	2024-11-14 11:13:56.583746+00	756	\N
168	Followed up with the client.	2024-12-04 16:09:20.587049+00	757	\N
169	Discussed service upgrades.	2024-12-11 04:23:04.589495+00	757	\N
170	Discussed service upgrades.	2024-11-23 09:58:07.591895+00	757	\N
171	Scheduled a call for next week.	2024-12-06 10:54:39.594377+00	758	\N
172	Client is interested in our premium services.	2024-11-18 02:47:05.597455+00	758	\N
173	Sent promotional material.	2024-11-27 15:22:26.60006+00	758	\N
174	Client is considering other options.	2024-11-15 21:14:41.603694+00	759	\N
175	Scheduled a call for next week.	2024-11-16 09:43:34.606625+00	759	\N
176	Asked for a meeting with the sales team.	2024-11-24 12:57:03.608808+00	760	\N
177	Discussed service upgrades.	2024-11-27 21:15:15.611202+00	761	\N
178	Followed up with the client.	2024-12-04 17:57:58.613912+00	761	\N
179	Scheduled a call for next week.	2024-11-14 02:59:57.61648+00	762	\N
180	Discussed service upgrades.	2024-11-25 02:02:08.619067+00	763	\N
181	Client is interested in our premium services.	2024-11-15 16:56:26.621465+00	763	\N
182	Asked for a meeting with the sales team.	2024-11-21 18:32:14.623959+00	763	\N
199	Followed up with the client.	2024-11-16 13:37:34.689712+00	772	\N
200	Discussed service upgrades.	2024-11-26 06:35:04.692113+00	773	\N
201	Sent promotional material.	2024-11-22 17:16:43.69426+00	773	\N
202	Client is considering other options.	2024-12-06 06:18:46.696606+00	774	\N
203	Scheduled a call for next week.	2024-11-14 07:00:33.698847+00	774	\N
204	Client requested more information.	2024-12-12 05:37:04.701391+00	774	\N
205	Client requested more information.	2024-11-26 15:46:48.704362+00	775	\N
206	Client is interested in our premium services.	2024-11-24 04:18:44.706758+00	775	\N
158	Client is interested in our premium services.	2024-11-21 07:44:46.641925+00	751	\N
183	Scheduled a call for next week.	2024-11-15 06:00:16.6442+00	764	\N
184	Scheduled a call for next week.	2024-11-26 22:34:48.646691+00	764	\N
185	Scheduled a call for next week.	2024-12-13 08:34:15.649108+00	765	\N
186	Asked for a meeting with the sales team.	2024-12-07 09:37:04.651469+00	765	\N
187	Scheduled a call for next week.	2024-12-10 05:52:11.653838+00	765	\N
188	Client is interested in our premium services.	2024-12-11 17:44:05.656217+00	766	\N
189	Asked for a meeting with the sales team.	2024-11-28 12:15:37.65861+00	767	\N
190	Client is interested in our premium services.	2024-11-30 13:22:17.660867+00	768	\N
191	Client is considering other options.	2024-12-11 16:11:49.66347+00	768	\N
192	Client is interested in our premium services.	2024-12-07 18:50:28.666648+00	769	\N
193	Scheduled a call for next week.	2024-11-26 02:50:32.66926+00	769	\N
194	Client requested more information.	2024-12-05 15:06:05.671625+00	769	\N
195	Sent promotional material.	2024-12-03 02:27:49.679525+00	770	\N
196	Client is considering other options.	2024-11-30 06:44:33.682276+00	770	\N
197	Client requested more information.	2024-11-17 07:08:35.684589+00	771	\N
198	Asked for a meeting with the sales team.	2024-11-16 18:50:46.687175+00	772	\N
\.


--
-- Data for Name: socialaccount_socialaccount; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.socialaccount_socialaccount (id, provider, uid, last_login, date_joined, user_id, extra_data) FROM stdin;
1	google	103547744013625409140	2024-11-10 21:00:34.337396+00	2024-11-10 20:37:53.270781+00	111	{"iss": "https://accounts.google.com", "azp": "21754680437-4ds3jlcqr9ld3o07u3arec29pu6ckthp.apps.googleusercontent.com", "aud": "21754680437-4ds3jlcqr9ld3o07u3arec29pu6ckthp.apps.googleusercontent.com", "sub": "103547744013625409140", "email": "lona2023.io51023@gmail.com", "email_verified": true, "at_hash": "meng20_agOa4U5O1QcJxgw", "name": "Lotfi Kano", "picture": "https://lh3.googleusercontent.com/a/ACg8ocIoxxW7frCK9QW4gqUcN9epmYQuWYuucYfwMWVO2WSTW7IysA=s96-c", "given_name": "Lotfi", "family_name": "Kano", "iat": 1731272434, "exp": 1731276034}
2	google	114917860703938070464	2024-11-10 20:53:57.773091+00	2024-11-10 20:53:57.773117+00	113	{"iss": "https://accounts.google.com", "azp": "21754680437-4ds3jlcqr9ld3o07u3arec29pu6ckthp.apps.googleusercontent.com", "aud": "21754680437-4ds3jlcqr9ld3o07u3arec29pu6ckthp.apps.googleusercontent.com", "sub": "114917860703938070464", "hd": "bagdadinvest.com", "email": "medtouradmin@bagdadinvest.com", "email_verified": true, "at_hash": "2FHzG05qu_9yFFgNogByCw", "name": "LOTFI KANOUNI", "picture": "https://lh3.googleusercontent.com/a/ACg8ocKqNbsUgEbXfByZR_0vt1H5mo_678wFBSzDUmfykTJptmz4qw=s96-c", "given_name": "LOTFI", "family_name": "KANOUNI", "iat": 1731272037, "exp": 1731275637}
\.


--
-- Data for Name: socialaccount_socialapp; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.socialaccount_socialapp (id, provider, name, client_id, secret, key, provider_id, settings) FROM stdin;
\.


--
-- Data for Name: socialaccount_socialapp_sites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.socialaccount_socialapp_sites (id, socialapp_id, site_id) FROM stdin;
\.


--
-- Data for Name: socialaccount_socialtoken; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.socialaccount_socialtoken (id, token, token_secret, expires_at, account_id, app_id) FROM stdin;
\.


--
-- Data for Name: taggit_tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.taggit_tag (id, name, slug) FROM stdin;
\.


--
-- Data for Name: taggit_taggeditem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.taggit_taggeditem (id, object_id, content_type_id, tag_id) FROM stdin;
\.


--
-- Data for Name: wagtailadmin_admin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailadmin_admin (id) FROM stdin;
\.


--
-- Data for Name: wagtailadmin_editingsession; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailadmin_editingsession (id, object_id, last_seen_at, content_type_id, user_id, is_editing) FROM stdin;
1	2	2024-08-21 16:54:11.153725+00	37	1	f
\.


--
-- Data for Name: wagtailcore_collection; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailcore_collection (id, path, depth, numchild, name) FROM stdin;
1	0001	1	0	Root
\.


--
-- Data for Name: wagtailcore_collectionviewrestriction; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailcore_collectionviewrestriction (id, restriction_type, password, collection_id) FROM stdin;
\.


--
-- Data for Name: wagtailcore_collectionviewrestriction_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailcore_collectionviewrestriction_groups (id, collectionviewrestriction_id, group_id) FROM stdin;
\.


--
-- Data for Name: wagtailcore_comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailcore_comment (id, text, contentpath, "position", created_at, updated_at, resolved_at, page_id, resolved_by_id, user_id, revision_created_id) FROM stdin;
\.


--
-- Data for Name: wagtailcore_commentreply; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailcore_commentreply (id, text, created_at, updated_at, comment_id, user_id) FROM stdin;
\.


--
-- Data for Name: wagtailcore_groupapprovaltask; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailcore_groupapprovaltask (task_ptr_id) FROM stdin;
1
\.


--
-- Data for Name: wagtailcore_groupapprovaltask_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailcore_groupapprovaltask_groups (id, groupapprovaltask_id, group_id) FROM stdin;
1	1	5
\.


--
-- Data for Name: wagtailcore_groupcollectionpermission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailcore_groupcollectionpermission (id, collection_id, group_id, permission_id) FROM stdin;
1	1	6	246
2	1	5	246
3	1	6	247
4	1	5	247
5	1	6	249
6	1	5	249
7	1	6	250
8	1	5	250
9	1	6	251
10	1	5	251
11	1	6	253
12	1	5	253
\.


--
-- Data for Name: wagtailcore_grouppagepermission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailcore_grouppagepermission (id, group_id, page_id, permission_id) FROM stdin;
1	5	1	178
2	5	1	179
3	5	1	184
4	6	1	178
5	6	1	179
6	5	1	183
7	5	1	185
\.


--
-- Data for Name: wagtailcore_locale; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailcore_locale (id, language_code) FROM stdin;
1	fr
\.


--
-- Data for Name: wagtailcore_modellogentry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailcore_modellogentry (id, label, action, "timestamp", content_changed, deleted, object_id, content_type_id, user_id, uuid, revision_id, data) FROM stdin;
\.


--
-- Data for Name: wagtailcore_page; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailcore_page (id, path, depth, numchild, title, slug, live, has_unpublished_changes, url_path, seo_title, show_in_menus, search_description, go_live_at, expire_at, expired, content_type_id, owner_id, locked, latest_revision_created_at, first_published_at, live_revision_id, last_published_at, draft_title, locked_at, locked_by_id, locale_id, translation_key, alias_of_id, latest_revision_id) FROM stdin;
1	0001	1	1	Root	root	t	f	/		f		\N	\N	f	37	\N	f	\N	\N	\N	\N	Root	\N	\N	1	02127a01109d4f8aa63943a8d7433708	\N	\N
2	00010001	2	0	Welcome to your new Wagtail site!	home	t	f	/home/		f		\N	\N	f	37	\N	f	\N	\N	\N	\N	Welcome to your new Wagtail site!	\N	\N	1	839c603cdbea4cb39bfc6244e1abe8e7	\N	\N
\.


--
-- Data for Name: wagtailcore_pagelogentry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailcore_pagelogentry (id, label, action, "timestamp", content_changed, deleted, content_type_id, page_id, revision_id, user_id, uuid, data) FROM stdin;
\.


--
-- Data for Name: wagtailcore_pagesubscription; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailcore_pagesubscription (id, comment_notifications, page_id, user_id) FROM stdin;
1	f	2	1
\.


--
-- Data for Name: wagtailcore_pageviewrestriction; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailcore_pageviewrestriction (id, password, page_id, restriction_type) FROM stdin;
\.


--
-- Data for Name: wagtailcore_pageviewrestriction_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailcore_pageviewrestriction_groups (id, pageviewrestriction_id, group_id) FROM stdin;
\.


--
-- Data for Name: wagtailcore_referenceindex; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailcore_referenceindex (id, object_id, to_object_id, model_path, content_path, content_path_hash, base_content_type_id, content_type_id, to_content_type_id) FROM stdin;
1	1	1	collection	collection	b40b1263e92957f2a7f89dbce56b887b	63	63	44
2	1	1	collection	collection	b40b1263e92957f2a7f89dbce56b887b	62	62	44
\.


--
-- Data for Name: wagtailcore_revision; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailcore_revision (id, created_at, approved_go_live_at, user_id, content, object_id, content_type_id, base_content_type_id, object_str) FROM stdin;
\.


--
-- Data for Name: wagtailcore_site; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailcore_site (id, hostname, port, is_default_site, root_page_id, site_name) FROM stdin;
1	localhost	80	t	2	
\.


--
-- Data for Name: wagtailcore_task; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailcore_task (id, name, active, content_type_id) FROM stdin;
1	Moderators approval	t	39
\.


--
-- Data for Name: wagtailcore_taskstate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailcore_taskstate (id, status, started_at, finished_at, content_type_id, task_id, workflow_state_id, finished_by_id, comment, revision_id) FROM stdin;
\.


--
-- Data for Name: wagtailcore_uploadedfile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailcore_uploadedfile (id, file, for_content_type_id, uploaded_by_user_id) FROM stdin;
\.


--
-- Data for Name: wagtailcore_workflow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailcore_workflow (id, name, active) FROM stdin;
1	Moderators approval	t
\.


--
-- Data for Name: wagtailcore_workflowcontenttype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailcore_workflowcontenttype (content_type_id, workflow_id) FROM stdin;
\.


--
-- Data for Name: wagtailcore_workflowpage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailcore_workflowpage (page_id, workflow_id) FROM stdin;
1	1
\.


--
-- Data for Name: wagtailcore_workflowstate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailcore_workflowstate (id, status, created_at, current_task_state_id, requested_by_id, workflow_id, object_id, base_content_type_id, content_type_id) FROM stdin;
\.


--
-- Data for Name: wagtailcore_workflowtask; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailcore_workflowtask (id, sort_order, task_id, workflow_id) FROM stdin;
1	0	1	1
\.


--
-- Data for Name: wagtaildocs_document; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtaildocs_document (id, title, file, created_at, uploaded_by_user_id, collection_id, file_size, file_hash) FROM stdin;
1	اتفاقية عمولات عمليات البيع	documents/اتفاقية_عمولات_عمليات_البيع.docx	2024-08-21 14:44:22.915141+00	1	1	131775	13e8ea877f354b6e5c84c8f04070431006efa4fa
\.


--
-- Data for Name: wagtailembeds_embed; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailembeds_embed (id, url, max_width, type, html, title, author_name, provider_name, width, height, last_updated, hash, thumbnail_url, cache_until) FROM stdin;
\.


--
-- Data for Name: wagtailforms_formsubmission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailforms_formsubmission (id, submit_time, page_id, form_data) FROM stdin;
\.


--
-- Data for Name: wagtailimages_image; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailimages_image (id, title, width, height, created_at, focal_point_x, focal_point_y, focal_point_width, focal_point_height, uploaded_by_user_id, file_size, collection_id, file_hash, file) FROM stdin;
1	Screenshot (715)	1920	871	2024-08-21 14:26:54.018802+00	\N	\N	\N	\N	1	75725	1	7d1aab27631fb35e30e3d94b0861a27ac4c69a1a	original_images/Screenshot_715.png
\.


--
-- Data for Name: wagtailimages_rendition; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailimages_rendition (id, width, height, focal_point_key, filter_spec, image_id, file) FROM stdin;
1	165	74		max-165x165	1	images/Screenshot_715.max-165x165.png
\.


--
-- Data for Name: wagtailredirects_redirect; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailredirects_redirect (id, old_path, is_permanent, redirect_link, redirect_page_id, site_id, automatically_created, created_at, redirect_page_route_path) FROM stdin;
\.


--
-- Data for Name: wagtailsearch_indexentry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailsearch_indexentry (id, object_id, title_norm, content_type_id, autocomplete, body, title) FROM stdin;
1	1	1.34375	63	Screenshot (715)		Screenshot (715)
2	1	0.7962963	62	اتفاقية عمولات عمليات البيع		اتفاقية عمولات عمليات البيع
\.


--
-- Data for Name: wagtailsearch_indexentry_fts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailsearch_indexentry_fts (autocomplete, body, title) FROM stdin;
Screenshot (715)		Screenshot (715)
اتفاقية عمولات عمليات البيع		اتفاقية عمولات عمليات البيع
Screenshot (715)		Screenshot (715)
اتفاقية عمولات عمليات البيع		اتفاقية عمولات عمليات البيع
\.


--
-- Data for Name: wagtailsearch_indexentry_fts_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailsearch_indexentry_fts_config (k, v) FROM stdin;
version	4
\.


--
-- Data for Name: wagtailsearch_indexentry_fts_content; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailsearch_indexentry_fts_content (id, c0, c1, c2) FROM stdin;
1	Screenshot (715)		Screenshot (715)
2	اتفاقية عمولات عمليات البيع		اتفاقية عمولات عمليات البيع
\.


--
-- Data for Name: wagtailsearch_indexentry_fts_data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailsearch_indexentry_fts_data (id, block) FROM stdin;
1	\\x02060006
10	\\x000000000106060006010101020101030101040101050101060101
137438953473	\\x000000210430373135010803010203010a73637265656e73686f74010802010202040b
274877906945	\\x000000210430373135010903010203010a73637265656e73686f74010902010202040b
412316860417	\\x0000004c0f30d8a7d8aad981d8a7d982d98ad8a90208020102020308d984d8a8d98ad8b9020805010205020bb9d985d984d98ad8a7d8aa020804010204060788d984d8a7d8aa02080301020304161013
549755813889	\\x000000690430373135010903010203010a73637265656e73686f74010902010202010ed8a7d8aad981d8a7d982d98ad8a90209020102020308d984d8a8d98ad8b9020905010205020bb9d985d984d98ad8a7d8aa020904010204060788d984d8a7d8aa020903010203040b12161013
687194767361	\\x0000004c0f30d8a7d8aad981d8a7d982d98ad8a90209020102020308d984d8a8d98ad8b9020905010205020bb9d985d984d98ad8a7d8aa020904010204060788d984d8a7d8aa02090301020304161013
824633720833	\\x0000004c0f30d8a7d8aad981d8a7d982d98ad8a90209020102020308d984d8a8d98ad8b9020905010205020bb9d985d984d98ad8a7d8aa020904010204060788d984d8a7d8aa02090301020304161013
\.


--
-- Data for Name: wagtailsearch_indexentry_fts_docsize; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailsearch_indexentry_fts_docsize (id, sz) FROM stdin;
1	\\x020002
2	\\x040004
\.


--
-- Data for Name: wagtailsearch_indexentry_fts_idx; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailsearch_indexentry_fts_idx (segid, term, pgno) FROM stdin;
1		2
2		2
3		2
4		2
5		2
6		2
\.


--
-- Data for Name: wagtailusers_userprofile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wagtailusers_userprofile (id, submitted_notifications, approved_notifications, rejected_notifications, user_id, preferred_language, current_time_zone, avatar, updated_comments_notifications, dismissibles, theme, density) FROM stdin;
1	t	t	t	1				t	{"help": true, "whats-new-in-wagtail-6.2": true, "editor-guide": true}	system	default
\.


--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_emailaddress_id_seq', 53, true);


--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_emailconfirmation_id_seq', 1, true);


--
-- Name: actstream_action_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.actstream_action_id_seq', 578, true);


--
-- Name: actstream_follow_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.actstream_follow_id_seq', 1, true);


--
-- Name: apps_accommodation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.apps_accommodation_id_seq', 3, true);


--
-- Name: apps_appointment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.apps_appointment_id_seq', 1, true);


--
-- Name: apps_contact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.apps_contact_id_seq', 1, true);


--
-- Name: apps_emailtemplate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.apps_emailtemplate_id_seq', 2, true);


--
-- Name: apps_emergencycontact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.apps_emergencycontact_id_seq', 1, true);


--
-- Name: apps_flightreservation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.apps_flightreservation_id_seq', 1, true);


--
-- Name: apps_hospital_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.apps_hospital_id_seq', 7, true);


--
-- Name: apps_hospitalstay_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.apps_hospitalstay_id_seq', 112, true);


--
-- Name: apps_hotel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.apps_hotel_id_seq', 2, true);


--
-- Name: apps_insurance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.apps_insurance_id_seq', 175, true);


--
-- Name: apps_medicalfile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.apps_medicalfile_id_seq', 29, true);


--
-- Name: apps_medicalinformation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.apps_medicalinformation_id_seq', 173, true);


--
-- Name: apps_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.apps_message_id_seq', 11, true);


--
-- Name: apps_message_read_members_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.apps_message_read_members_id_seq', 1, true);


--
-- Name: apps_messagegroup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.apps_messagegroup_id_seq', 11, true);


--
-- Name: apps_messagegroup_members_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.apps_messagegroup_members_id_seq', 22, true);


--
-- Name: apps_patientschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.apps_patientschedule_id_seq', 2, true);


--
-- Name: apps_prescription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.apps_prescription_id_seq', 1, true);


--
-- Name: apps_referral_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.apps_referral_id_seq', 19, true);


--
-- Name: apps_subscription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.apps_subscription_id_seq', 1, true);


--
-- Name: apps_treatmentplan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.apps_treatmentplan_id_seq', 8, true);


--
-- Name: apps_treatmentplanitem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.apps_treatmentplanitem_id_seq', 22, true);


--
-- Name: apps_treatmentproduct_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.apps_treatmentproduct_id_seq', 45, true);


--
-- Name: apps_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.apps_user_groups_id_seq', 157, true);


--
-- Name: apps_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.apps_user_id_seq', 167, true);


--
-- Name: apps_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.apps_user_user_permissions_id_seq', 1, true);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 6, true);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 168, true);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 363, true);


--
-- Name: baton_batontheme_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.baton_batontheme_id_seq', 1, true);


--
-- Name: blog_comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.blog_comments_id_seq', 1, true);


--
-- Name: blog_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.blog_image_id_seq', 1, true);


--
-- Name: blog_image_image_likes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.blog_image_image_likes_id_seq', 1, true);


--
-- Name: blog_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.blog_profile_id_seq', 1, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1336, true);


--
-- Name: django_celery_results_chordcounter_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_celery_results_chordcounter_id_seq', 1, true);


--
-- Name: django_celery_results_groupresult_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_celery_results_groupresult_id_seq', 1, true);


--
-- Name: django_celery_results_taskresult_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_celery_results_taskresult_id_seq', 1, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 90, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 299, true);


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_site_id_seq', 1, true);


--
-- Name: gram_comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gram_comments_id_seq', 1, true);


--
-- Name: gram_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gram_image_id_seq', 1, true);


--
-- Name: gram_image_image_likes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gram_image_image_likes_id_seq', 1, true);


--
-- Name: gram_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gram_profile_id_seq', 1, true);


--
-- Name: jet_django_token_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jet_django_token_id_seq', 1, true);


--
-- Name: leads_lead_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.leads_lead_id_seq', 872, true);


--
-- Name: leads_leadhistory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.leads_leadhistory_id_seq', 349, true);


--
-- Name: leads_note_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.leads_note_id_seq', 208, true);


--
-- Name: socialaccount_socialaccount_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.socialaccount_socialaccount_id_seq', 2, true);


--
-- Name: socialaccount_socialapp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.socialaccount_socialapp_id_seq', 1, true);


--
-- Name: socialaccount_socialapp_sites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.socialaccount_socialapp_sites_id_seq', 1, true);


--
-- Name: socialaccount_socialtoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.socialaccount_socialtoken_id_seq', 1, true);


--
-- Name: taggit_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.taggit_tag_id_seq', 1, true);


--
-- Name: taggit_taggeditem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.taggit_taggeditem_id_seq', 1, true);


--
-- Name: wagtailadmin_admin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wagtailadmin_admin_id_seq', 1, true);


--
-- Name: wagtailadmin_editingsession_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wagtailadmin_editingsession_id_seq', 1, true);


--
-- Name: wagtailcore_collection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wagtailcore_collection_id_seq', 1, true);


--
-- Name: wagtailcore_collectionviewrestriction_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wagtailcore_collectionviewrestriction_groups_id_seq', 1, true);


--
-- Name: wagtailcore_collectionviewrestriction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wagtailcore_collectionviewrestriction_id_seq', 1, true);


--
-- Name: wagtailcore_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wagtailcore_comment_id_seq', 1, true);


--
-- Name: wagtailcore_commentreply_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wagtailcore_commentreply_id_seq', 1, true);


--
-- Name: wagtailcore_groupapprovaltask_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wagtailcore_groupapprovaltask_groups_id_seq', 1, true);


--
-- Name: wagtailcore_groupcollectionpermission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wagtailcore_groupcollectionpermission_id_seq', 12, true);


--
-- Name: wagtailcore_grouppagepermission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wagtailcore_grouppagepermission_id_seq', 7, true);


--
-- Name: wagtailcore_locale_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wagtailcore_locale_id_seq', 1, true);


--
-- Name: wagtailcore_modellogentry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wagtailcore_modellogentry_id_seq', 1, true);


--
-- Name: wagtailcore_page_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wagtailcore_page_id_seq', 2, true);


--
-- Name: wagtailcore_pagelogentry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wagtailcore_pagelogentry_id_seq', 1, true);


--
-- Name: wagtailcore_pagesubscription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wagtailcore_pagesubscription_id_seq', 1, true);


--
-- Name: wagtailcore_pageviewrestriction_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wagtailcore_pageviewrestriction_groups_id_seq', 1, true);


--
-- Name: wagtailcore_pageviewrestriction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wagtailcore_pageviewrestriction_id_seq', 1, true);


--
-- Name: wagtailcore_referenceindex_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wagtailcore_referenceindex_id_seq', 2, true);


--
-- Name: wagtailcore_revision_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wagtailcore_revision_id_seq', 1, true);


--
-- Name: wagtailcore_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wagtailcore_site_id_seq', 1, true);


--
-- Name: wagtailcore_task_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wagtailcore_task_id_seq', 1, true);


--
-- Name: wagtailcore_taskstate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wagtailcore_taskstate_id_seq', 1, true);


--
-- Name: wagtailcore_uploadedfile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wagtailcore_uploadedfile_id_seq', 1, true);


--
-- Name: wagtailcore_workflow_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wagtailcore_workflow_id_seq', 1, true);


--
-- Name: wagtailcore_workflowstate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wagtailcore_workflowstate_id_seq', 1, true);


--
-- Name: wagtailcore_workflowtask_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wagtailcore_workflowtask_id_seq', 1, true);


--
-- Name: wagtaildocs_document_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wagtaildocs_document_id_seq', 1, true);


--
-- Name: wagtailembeds_embed_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wagtailembeds_embed_id_seq', 1, true);


--
-- Name: wagtailforms_formsubmission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wagtailforms_formsubmission_id_seq', 1, true);


--
-- Name: wagtailimages_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wagtailimages_image_id_seq', 1, true);


--
-- Name: wagtailimages_rendition_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wagtailimages_rendition_id_seq', 1, true);


--
-- Name: wagtailredirects_redirect_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wagtailredirects_redirect_id_seq', 1, true);


--
-- Name: wagtailsearch_indexentry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wagtailsearch_indexentry_id_seq', 2, true);


--
-- Name: wagtailusers_userprofile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wagtailusers_userprofile_id_seq', 1, true);


--
-- Name: authtoken_token authtoken_token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_pkey PRIMARY KEY (key);


--
-- Name: authtoken_token authtoken_token_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_key UNIQUE (user_id);


--
-- Name: django_migrations idx_21897_django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT idx_21897_django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_content_type idx_21904_django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT idx_21904_django_content_type_pkey PRIMARY KEY (id);


--
-- Name: auth_group_permissions idx_21911_auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT idx_21911_auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_permission idx_21916_auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT idx_21916_auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_group idx_21923_auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT idx_21923_auth_group_pkey PRIMARY KEY (id);


--
-- Name: apps_messagegroup_members idx_21930_apps_messagegroup_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_messagegroup_members
    ADD CONSTRAINT idx_21930_apps_messagegroup_members_pkey PRIMARY KEY (id);


--
-- Name: apps_message_read_members idx_21935_apps_message_read_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_message_read_members
    ADD CONSTRAINT idx_21935_apps_message_read_members_pkey PRIMARY KEY (id);


--
-- Name: apps_user_groups idx_21940_apps_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_user_groups
    ADD CONSTRAINT idx_21940_apps_user_groups_pkey PRIMARY KEY (id);


--
-- Name: apps_user_user_permissions idx_21945_apps_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_user_user_permissions
    ADD CONSTRAINT idx_21945_apps_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log idx_21950_django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT idx_21950_django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_session idx_21956_sqlite_autoindex_django_session_1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT idx_21956_sqlite_autoindex_django_session_1 PRIMARY KEY (session_key);


--
-- Name: apps_appointment idx_21962_apps_appointment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_appointment
    ADD CONSTRAINT idx_21962_apps_appointment_pkey PRIMARY KEY (id);


--
-- Name: apps_contact idx_21967_apps_contact_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_contact
    ADD CONSTRAINT idx_21967_apps_contact_pkey PRIMARY KEY (id);


--
-- Name: apps_emergencycontact idx_21974_apps_emergencycontact_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_emergencycontact
    ADD CONSTRAINT idx_21974_apps_emergencycontact_pkey PRIMARY KEY (id);


--
-- Name: apps_hospital idx_21981_apps_hospital_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_hospital
    ADD CONSTRAINT idx_21981_apps_hospital_pkey PRIMARY KEY (id);


--
-- Name: apps_hospitalstay idx_21988_apps_hospitalstay_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_hospitalstay
    ADD CONSTRAINT idx_21988_apps_hospitalstay_pkey PRIMARY KEY (id);


--
-- Name: apps_message idx_21993_apps_message_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_message
    ADD CONSTRAINT idx_21993_apps_message_pkey PRIMARY KEY (id);


--
-- Name: apps_messagegroup idx_22000_apps_messagegroup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_messagegroup
    ADD CONSTRAINT idx_22000_apps_messagegroup_pkey PRIMARY KEY (id);


--
-- Name: apps_prescription idx_22007_apps_prescription_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_prescription
    ADD CONSTRAINT idx_22007_apps_prescription_pkey PRIMARY KEY (id);


--
-- Name: apps_subscription idx_22014_apps_subscription_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_subscription
    ADD CONSTRAINT idx_22014_apps_subscription_pkey PRIMARY KEY (id);


--
-- Name: apps_insurance idx_22021_apps_insurance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_insurance
    ADD CONSTRAINT idx_22021_apps_insurance_pkey PRIMARY KEY (id);


--
-- Name: apps_medicalinformation idx_22028_apps_medicalinformation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_medicalinformation
    ADD CONSTRAINT idx_22028_apps_medicalinformation_pkey PRIMARY KEY (id);


--
-- Name: apps_referral idx_22035_apps_referral_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_referral
    ADD CONSTRAINT idx_22035_apps_referral_pkey PRIMARY KEY (id);


--
-- Name: django_celery_results_groupresult idx_22042_django_celery_results_groupresult_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_celery_results_groupresult
    ADD CONSTRAINT idx_22042_django_celery_results_groupresult_pkey PRIMARY KEY (id);


--
-- Name: django_celery_results_chordcounter idx_22049_django_celery_results_chordcounter_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_celery_results_chordcounter
    ADD CONSTRAINT idx_22049_django_celery_results_chordcounter_pkey PRIMARY KEY (id);


--
-- Name: django_celery_results_taskresult idx_22056_django_celery_results_taskresult_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_celery_results_taskresult
    ADD CONSTRAINT idx_22056_django_celery_results_taskresult_pkey PRIMARY KEY (id);


--
-- Name: blog_profile idx_22068_blog_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blog_profile
    ADD CONSTRAINT idx_22068_blog_profile_pkey PRIMARY KEY (id);


--
-- Name: blog_image idx_22075_blog_image_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blog_image
    ADD CONSTRAINT idx_22075_blog_image_pkey PRIMARY KEY (id);


--
-- Name: blog_image_image_likes idx_22082_blog_image_image_likes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blog_image_image_likes
    ADD CONSTRAINT idx_22082_blog_image_image_likes_pkey PRIMARY KEY (id);


--
-- Name: blog_comments idx_22087_blog_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blog_comments
    ADD CONSTRAINT idx_22087_blog_comments_pkey PRIMARY KEY (id);


--
-- Name: gram_image_image_likes idx_22094_gram_image_image_likes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gram_image_image_likes
    ADD CONSTRAINT idx_22094_gram_image_image_likes_pkey PRIMARY KEY (id);


--
-- Name: gram_comments idx_22099_gram_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gram_comments
    ADD CONSTRAINT idx_22099_gram_comments_pkey PRIMARY KEY (id);


--
-- Name: gram_image idx_22106_gram_image_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gram_image
    ADD CONSTRAINT idx_22106_gram_image_pkey PRIMARY KEY (id);


--
-- Name: gram_profile idx_22113_gram_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gram_profile
    ADD CONSTRAINT idx_22113_gram_profile_pkey PRIMARY KEY (id);


--
-- Name: account_emailconfirmation idx_22120_account_emailconfirmation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_emailconfirmation
    ADD CONSTRAINT idx_22120_account_emailconfirmation_pkey PRIMARY KEY (id);


--
-- Name: account_emailaddress idx_22127_account_emailaddress_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_emailaddress
    ADD CONSTRAINT idx_22127_account_emailaddress_pkey PRIMARY KEY (id);


--
-- Name: django_site idx_22134_django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT idx_22134_django_site_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialapp_sites idx_22141_socialaccount_socialapp_sites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites
    ADD CONSTRAINT idx_22141_socialaccount_socialapp_sites_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialapp idx_22146_socialaccount_socialapp_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialapp
    ADD CONSTRAINT idx_22146_socialaccount_socialapp_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialtoken idx_22153_socialaccount_socialtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialtoken
    ADD CONSTRAINT idx_22153_socialaccount_socialtoken_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialaccount idx_22160_socialaccount_socialaccount_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialaccount
    ADD CONSTRAINT idx_22160_socialaccount_socialaccount_pkey PRIMARY KEY (id);


--
-- Name: jet_django_token idx_22167_jet_django_token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jet_django_token
    ADD CONSTRAINT idx_22167_jet_django_token_pkey PRIMARY KEY (id);


--
-- Name: taggit_taggeditem idx_22174_taggit_taggeditem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taggit_taggeditem
    ADD CONSTRAINT idx_22174_taggit_taggeditem_pkey PRIMARY KEY (id);


--
-- Name: taggit_tag idx_22179_taggit_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taggit_tag
    ADD CONSTRAINT idx_22179_taggit_tag_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_collection idx_22186_wagtailcore_collection_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_collection
    ADD CONSTRAINT idx_22186_wagtailcore_collection_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_groupcollectionpermission idx_22193_wagtailcore_groupcollectionpermission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_groupcollectionpermission
    ADD CONSTRAINT idx_22193_wagtailcore_groupcollectionpermission_pkey PRIMARY KEY (id);


--
-- Name: wagtailadmin_admin idx_22198_wagtailadmin_admin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailadmin_admin
    ADD CONSTRAINT idx_22198_wagtailadmin_admin_pkey PRIMARY KEY (id);


--
-- Name: wagtailadmin_editingsession idx_22203_wagtailadmin_editingsession_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailadmin_editingsession
    ADD CONSTRAINT idx_22203_wagtailadmin_editingsession_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_pageviewrestriction_groups idx_22210_wagtailcore_pageviewrestriction_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_pageviewrestriction_groups
    ADD CONSTRAINT idx_22210_wagtailcore_pageviewrestriction_groups_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_pageviewrestriction idx_22215_wagtailcore_pageviewrestriction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_pageviewrestriction
    ADD CONSTRAINT idx_22215_wagtailcore_pageviewrestriction_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_collectionviewrestriction idx_22222_wagtailcore_collectionviewrestriction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_collectionviewrestriction
    ADD CONSTRAINT idx_22222_wagtailcore_collectionviewrestriction_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_collectionviewrestriction_groups idx_22229_wagtailcore_collectionviewrestriction_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_collectionviewrestriction_groups
    ADD CONSTRAINT idx_22229_wagtailcore_collectionviewrestriction_groups_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_site idx_22234_wagtailcore_site_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_site
    ADD CONSTRAINT idx_22234_wagtailcore_site_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_task idx_22241_wagtailcore_task_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_task
    ADD CONSTRAINT idx_22241_wagtailcore_task_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_workflow idx_22248_wagtailcore_workflow_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_workflow
    ADD CONSTRAINT idx_22248_wagtailcore_workflow_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_groupapprovaltask idx_22254_wagtailcore_groupapprovaltask_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_groupapprovaltask
    ADD CONSTRAINT idx_22254_wagtailcore_groupapprovaltask_pkey PRIMARY KEY (task_ptr_id);


--
-- Name: wagtailcore_workflowpage idx_22257_wagtailcore_workflowpage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_workflowpage
    ADD CONSTRAINT idx_22257_wagtailcore_workflowpage_pkey PRIMARY KEY (page_id);


--
-- Name: wagtailcore_workflowtask idx_22261_wagtailcore_workflowtask_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_workflowtask
    ADD CONSTRAINT idx_22261_wagtailcore_workflowtask_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_groupapprovaltask_groups idx_22266_wagtailcore_groupapprovaltask_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_groupapprovaltask_groups
    ADD CONSTRAINT idx_22266_wagtailcore_groupapprovaltask_groups_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_locale idx_22271_wagtailcore_locale_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_locale
    ADD CONSTRAINT idx_22271_wagtailcore_locale_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_page idx_22278_wagtailcore_page_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_page
    ADD CONSTRAINT idx_22278_wagtailcore_page_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_commentreply idx_22285_wagtailcore_commentreply_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_commentreply
    ADD CONSTRAINT idx_22285_wagtailcore_commentreply_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_pagesubscription idx_22292_wagtailcore_pagesubscription_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_pagesubscription
    ADD CONSTRAINT idx_22292_wagtailcore_pagesubscription_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_comment idx_22297_wagtailcore_comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_comment
    ADD CONSTRAINT idx_22297_wagtailcore_comment_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_referenceindex idx_22304_wagtailcore_referenceindex_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_referenceindex
    ADD CONSTRAINT idx_22304_wagtailcore_referenceindex_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_taskstate idx_22311_wagtailcore_taskstate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_taskstate
    ADD CONSTRAINT idx_22311_wagtailcore_taskstate_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_workflowstate idx_22318_wagtailcore_workflowstate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_workflowstate
    ADD CONSTRAINT idx_22318_wagtailcore_workflowstate_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_workflowcontenttype idx_22324_wagtailcore_workflowcontenttype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_workflowcontenttype
    ADD CONSTRAINT idx_22324_wagtailcore_workflowcontenttype_pkey PRIMARY KEY (content_type_id);


--
-- Name: wagtailcore_modellogentry idx_22328_wagtailcore_modellogentry_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_modellogentry
    ADD CONSTRAINT idx_22328_wagtailcore_modellogentry_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_pagelogentry idx_22335_wagtailcore_pagelogentry_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_pagelogentry
    ADD CONSTRAINT idx_22335_wagtailcore_pagelogentry_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_grouppagepermission idx_22342_wagtailcore_grouppagepermission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_grouppagepermission
    ADD CONSTRAINT idx_22342_wagtailcore_grouppagepermission_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_revision idx_22347_wagtailcore_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_revision
    ADD CONSTRAINT idx_22347_wagtailcore_revision_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_uploadedfile idx_22354_wagtailcore_uploadedfile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_uploadedfile
    ADD CONSTRAINT idx_22354_wagtailcore_uploadedfile_pkey PRIMARY KEY (id);


--
-- Name: wagtaildocs_document idx_22361_wagtaildocs_document_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtaildocs_document
    ADD CONSTRAINT idx_22361_wagtaildocs_document_pkey PRIMARY KEY (id);


--
-- Name: wagtailembeds_embed idx_22368_wagtailembeds_embed_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailembeds_embed
    ADD CONSTRAINT idx_22368_wagtailembeds_embed_pkey PRIMARY KEY (id);


--
-- Name: wagtailforms_formsubmission idx_22375_wagtailforms_formsubmission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailforms_formsubmission
    ADD CONSTRAINT idx_22375_wagtailforms_formsubmission_pkey PRIMARY KEY (id);


--
-- Name: wagtailimages_image idx_22382_wagtailimages_image_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailimages_image
    ADD CONSTRAINT idx_22382_wagtailimages_image_pkey PRIMARY KEY (id);


--
-- Name: wagtailimages_rendition idx_22389_wagtailimages_rendition_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailimages_rendition
    ADD CONSTRAINT idx_22389_wagtailimages_rendition_pkey PRIMARY KEY (id);


--
-- Name: wagtailredirects_redirect idx_22396_wagtailredirects_redirect_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailredirects_redirect
    ADD CONSTRAINT idx_22396_wagtailredirects_redirect_pkey PRIMARY KEY (id);


--
-- Name: wagtailsearch_indexentry idx_22403_wagtailsearch_indexentry_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailsearch_indexentry
    ADD CONSTRAINT idx_22403_wagtailsearch_indexentry_pkey PRIMARY KEY (id);


--
-- Name: wagtailsearch_indexentry_fts_data idx_22414_wagtailsearch_indexentry_fts_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailsearch_indexentry_fts_data
    ADD CONSTRAINT idx_22414_wagtailsearch_indexentry_fts_data_pkey PRIMARY KEY (id);


--
-- Name: wagtailsearch_indexentry_fts_idx idx_22419_sqlite_autoindex_wagtailsearch_indexentry_fts_idx_1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailsearch_indexentry_fts_idx
    ADD CONSTRAINT idx_22419_sqlite_autoindex_wagtailsearch_indexentry_fts_idx_1 PRIMARY KEY (segid, term);


--
-- Name: wagtailsearch_indexentry_fts_content idx_22424_wagtailsearch_indexentry_fts_content_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailsearch_indexentry_fts_content
    ADD CONSTRAINT idx_22424_wagtailsearch_indexentry_fts_content_pkey PRIMARY KEY (id);


--
-- Name: wagtailsearch_indexentry_fts_docsize idx_22429_wagtailsearch_indexentry_fts_docsize_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailsearch_indexentry_fts_docsize
    ADD CONSTRAINT idx_22429_wagtailsearch_indexentry_fts_docsize_pkey PRIMARY KEY (id);


--
-- Name: wagtailsearch_indexentry_fts_config idx_22434_sqlite_autoindex_wagtailsearch_indexentry_fts_config_; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailsearch_indexentry_fts_config
    ADD CONSTRAINT idx_22434_sqlite_autoindex_wagtailsearch_indexentry_fts_config_ PRIMARY KEY (k);


--
-- Name: wagtailusers_userprofile idx_22440_wagtailusers_userprofile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailusers_userprofile
    ADD CONSTRAINT idx_22440_wagtailusers_userprofile_pkey PRIMARY KEY (id);


--
-- Name: apps_homepage idx_22446_apps_homepage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_homepage
    ADD CONSTRAINT idx_22446_apps_homepage_pkey PRIMARY KEY (page_ptr_id);


--
-- Name: apps_emailtemplate idx_22452_apps_emailtemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_emailtemplate
    ADD CONSTRAINT idx_22452_apps_emailtemplate_pkey PRIMARY KEY (id);


--
-- Name: actstream_action idx_22459_actstream_action_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actstream_action
    ADD CONSTRAINT idx_22459_actstream_action_pkey PRIMARY KEY (id);


--
-- Name: actstream_follow idx_22466_actstream_follow_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actstream_follow
    ADD CONSTRAINT idx_22466_actstream_follow_pkey PRIMARY KEY (id);


--
-- Name: apps_medicalfile idx_22473_apps_medicalfile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_medicalfile
    ADD CONSTRAINT idx_22473_apps_medicalfile_pkey PRIMARY KEY (id);


--
-- Name: apps_treatmentproduct idx_22480_apps_treatmentproduct_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_treatmentproduct
    ADD CONSTRAINT idx_22480_apps_treatmentproduct_pkey PRIMARY KEY (id);


--
-- Name: apps_user idx_22487_apps_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_user
    ADD CONSTRAINT idx_22487_apps_user_pkey PRIMARY KEY (id);


--
-- Name: apps_patientschedule idx_22494_apps_patientschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_patientschedule
    ADD CONSTRAINT idx_22494_apps_patientschedule_pkey PRIMARY KEY (id);


--
-- Name: apps_flightreservation idx_22501_apps_flightreservation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_flightreservation
    ADD CONSTRAINT idx_22501_apps_flightreservation_pkey PRIMARY KEY (id);


--
-- Name: apps_hotel idx_22508_apps_hotel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_hotel
    ADD CONSTRAINT idx_22508_apps_hotel_pkey PRIMARY KEY (id);


--
-- Name: apps_accommodation idx_22515_apps_accommodation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_accommodation
    ADD CONSTRAINT idx_22515_apps_accommodation_pkey PRIMARY KEY (id);


--
-- Name: apps_treatmentplan idx_22520_apps_treatmentplan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_treatmentplan
    ADD CONSTRAINT idx_22520_apps_treatmentplan_pkey PRIMARY KEY (id);


--
-- Name: apps_treatmentplanitem idx_22527_apps_treatmentplanitem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_treatmentplanitem
    ADD CONSTRAINT idx_22527_apps_treatmentplanitem_pkey PRIMARY KEY (id);


--
-- Name: baton_batontheme idx_22534_baton_batontheme_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.baton_batontheme
    ADD CONSTRAINT idx_22534_baton_batontheme_pkey PRIMARY KEY (id);


--
-- Name: leads_lead leads_lead_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leads_lead
    ADD CONSTRAINT leads_lead_pkey PRIMARY KEY (id);


--
-- Name: leads_leadhistory leads_leadhistory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leads_leadhistory
    ADD CONSTRAINT leads_leadhistory_pkey PRIMARY KEY (id);


--
-- Name: leads_note leads_note_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leads_note
    ADD CONSTRAINT leads_note_pkey PRIMARY KEY (id);


--
-- Name: authtoken_token_key_10f0b77e_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX authtoken_token_key_10f0b77e_like ON public.authtoken_token USING btree (key varchar_pattern_ops);


--
-- Name: idx_21904_django_content_type_app_label_model_76bd3d3b_uniq; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_21904_django_content_type_app_label_model_76bd3d3b_uniq ON public.django_content_type USING btree (app_label, model);


--
-- Name: idx_21911_auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21911_auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: idx_21911_auth_group_permissions_group_id_permission_id_0cd325b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_21911_auth_group_permissions_group_id_permission_id_0cd325b ON public.auth_group_permissions USING btree (group_id, permission_id);


--
-- Name: idx_21911_auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21911_auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: idx_21916_auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21916_auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: idx_21916_auth_permission_content_type_id_codename_01ab375a_uni; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_21916_auth_permission_content_type_id_codename_01ab375a_uni ON public.auth_permission USING btree (content_type_id, codename);


--
-- Name: idx_21923_sqlite_autoindex_auth_group_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_21923_sqlite_autoindex_auth_group_1 ON public.auth_group USING btree (name);


--
-- Name: idx_21930_apps_messagegroup_members_messagegroup_id_ba3d4db7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21930_apps_messagegroup_members_messagegroup_id_ba3d4db7 ON public.apps_messagegroup_members USING btree (messagegroup_id);


--
-- Name: idx_21930_apps_messagegroup_members_messagegroup_id_user_id_544; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_21930_apps_messagegroup_members_messagegroup_id_user_id_544 ON public.apps_messagegroup_members USING btree (messagegroup_id, user_id);


--
-- Name: idx_21930_apps_messagegroup_members_user_id_48d8bf91; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21930_apps_messagegroup_members_user_id_48d8bf91 ON public.apps_messagegroup_members USING btree (user_id);


--
-- Name: idx_21935_apps_message_read_members_message_id_c1bbaac4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21935_apps_message_read_members_message_id_c1bbaac4 ON public.apps_message_read_members USING btree (message_id);


--
-- Name: idx_21935_apps_message_read_members_message_id_user_id_4557a3e1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_21935_apps_message_read_members_message_id_user_id_4557a3e1 ON public.apps_message_read_members USING btree (message_id, user_id);


--
-- Name: idx_21935_apps_message_read_members_user_id_a5cdfd6e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21935_apps_message_read_members_user_id_a5cdfd6e ON public.apps_message_read_members USING btree (user_id);


--
-- Name: idx_21940_apps_user_groups_group_id_8bd2d5d0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21940_apps_user_groups_group_id_8bd2d5d0 ON public.apps_user_groups USING btree (group_id);


--
-- Name: idx_21940_apps_user_groups_user_id_b2b5cf0f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21940_apps_user_groups_user_id_b2b5cf0f ON public.apps_user_groups USING btree (user_id);


--
-- Name: idx_21940_apps_user_groups_user_id_group_id_ec865e7a_uniq; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_21940_apps_user_groups_user_id_group_id_ec865e7a_uniq ON public.apps_user_groups USING btree (user_id, group_id);


--
-- Name: idx_21945_apps_user_user_permissions_permission_id_d63a42b4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21945_apps_user_user_permissions_permission_id_d63a42b4 ON public.apps_user_user_permissions USING btree (permission_id);


--
-- Name: idx_21945_apps_user_user_permissions_user_id_091021c9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21945_apps_user_user_permissions_user_id_091021c9 ON public.apps_user_user_permissions USING btree (user_id);


--
-- Name: idx_21945_apps_user_user_permissions_user_id_permission_id_891b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_21945_apps_user_user_permissions_user_id_permission_id_891b ON public.apps_user_user_permissions USING btree (user_id, permission_id);


--
-- Name: idx_21950_django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21950_django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: idx_21950_django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21950_django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: idx_21956_django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21956_django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: idx_21962_apps_appointment_doctor_id_1979dfe2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21962_apps_appointment_doctor_id_1979dfe2 ON public.apps_appointment USING btree (doctor_id);


--
-- Name: idx_21962_apps_appointment_patient_id_2a2077b1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21962_apps_appointment_patient_id_2a2077b1 ON public.apps_appointment USING btree (patient_id);


--
-- Name: idx_21988_apps_hospitalstay_hospital_id_95d65eb1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21988_apps_hospitalstay_hospital_id_95d65eb1 ON public.apps_hospitalstay USING btree (hospital_id);


--
-- Name: idx_21988_apps_hospitalstay_patient_id_d714f425; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21988_apps_hospitalstay_patient_id_d714f425 ON public.apps_hospitalstay USING btree (patient_id);


--
-- Name: idx_21993_apps_message_group_id_4be18166; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21993_apps_message_group_id_4be18166 ON public.apps_message USING btree (group_id);


--
-- Name: idx_21993_apps_message_sender_id_ffa71c6e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21993_apps_message_sender_id_ffa71c6e ON public.apps_message USING btree (sender_id);


--
-- Name: idx_22007_apps_prescription_patient_id_c5cd3260; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22007_apps_prescription_patient_id_c5cd3260 ON public.apps_prescription USING btree (patient_id);


--
-- Name: idx_22028_apps_medicalinformation_insurance_id_dc66658d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22028_apps_medicalinformation_insurance_id_dc66658d ON public.apps_medicalinformation USING btree (insurance_id);


--
-- Name: idx_22035_apps_referral_referred_id_9d398d3c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22035_apps_referral_referred_id_9d398d3c ON public.apps_referral USING btree (referred_id);


--
-- Name: idx_22035_apps_referral_referrer_id_9a059671; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22035_apps_referral_referrer_id_9a059671 ON public.apps_referral USING btree (referrer_id);


--
-- Name: idx_22042_django_cele_date_cr_bd6c1d_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22042_django_cele_date_cr_bd6c1d_idx ON public.django_celery_results_groupresult USING btree (date_created);


--
-- Name: idx_22042_django_cele_date_do_caae0e_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22042_django_cele_date_do_caae0e_idx ON public.django_celery_results_groupresult USING btree (date_done);


--
-- Name: idx_22042_sqlite_autoindex_django_celery_results_groupresult_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22042_sqlite_autoindex_django_celery_results_groupresult_1 ON public.django_celery_results_groupresult USING btree (group_id);


--
-- Name: idx_22049_sqlite_autoindex_django_celery_results_chordcounter_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22049_sqlite_autoindex_django_celery_results_chordcounter_1 ON public.django_celery_results_chordcounter USING btree (group_id);


--
-- Name: idx_22056_django_cele_date_cr_f04a50_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22056_django_cele_date_cr_f04a50_idx ON public.django_celery_results_taskresult USING btree (date_created);


--
-- Name: idx_22056_django_cele_date_do_f59aad_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22056_django_cele_date_do_f59aad_idx ON public.django_celery_results_taskresult USING btree (date_done);


--
-- Name: idx_22056_django_cele_status_9b6201_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22056_django_cele_status_9b6201_idx ON public.django_celery_results_taskresult USING btree (status);


--
-- Name: idx_22056_django_cele_task_na_08aec9_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22056_django_cele_task_na_08aec9_idx ON public.django_celery_results_taskresult USING btree (task_name);


--
-- Name: idx_22056_django_cele_worker_d54dd8_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22056_django_cele_worker_d54dd8_idx ON public.django_celery_results_taskresult USING btree (worker);


--
-- Name: idx_22056_sqlite_autoindex_django_celery_results_taskresult_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22056_sqlite_autoindex_django_celery_results_taskresult_1 ON public.django_celery_results_taskresult USING btree (task_id);


--
-- Name: idx_22062_sqlite_autoindex_django_openai_assistant_openaitask_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22062_sqlite_autoindex_django_openai_assistant_openaitask_1 ON public.django_openai_assistant_openaitask USING btree (runid);


--
-- Name: idx_22068_sqlite_autoindex_blog_profile_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22068_sqlite_autoindex_blog_profile_1 ON public.blog_profile USING btree (user_id);


--
-- Name: idx_22075_blog_image_imageuploader_profile_id_a1baf921; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22075_blog_image_imageuploader_profile_id_a1baf921 ON public.blog_image USING btree (imageuploader_profile_id);


--
-- Name: idx_22082_blog_image_image_likes_image_id_b5735d7e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22082_blog_image_image_likes_image_id_b5735d7e ON public.blog_image_image_likes USING btree (image_id);


--
-- Name: idx_22082_blog_image_image_likes_image_id_profile_id_73fbff60_u; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22082_blog_image_image_likes_image_id_profile_id_73fbff60_u ON public.blog_image_image_likes USING btree (image_id, profile_id);


--
-- Name: idx_22082_blog_image_image_likes_profile_id_de28ea41; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22082_blog_image_image_likes_profile_id_de28ea41 ON public.blog_image_image_likes USING btree (profile_id);


--
-- Name: idx_22087_blog_comments_author_id_883440ef; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22087_blog_comments_author_id_883440ef ON public.blog_comments USING btree (author_id);


--
-- Name: idx_22087_blog_comments_commented_image_id_7a957515; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22087_blog_comments_commented_image_id_7a957515 ON public.blog_comments USING btree (commented_image_id);


--
-- Name: idx_22094_gram_image_image_likes_image_id_ec9bba73; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22094_gram_image_image_likes_image_id_ec9bba73 ON public.gram_image_image_likes USING btree (image_id);


--
-- Name: idx_22094_gram_image_image_likes_image_id_profile_id_5bb2b021_u; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22094_gram_image_image_likes_image_id_profile_id_5bb2b021_u ON public.gram_image_image_likes USING btree (image_id, profile_id);


--
-- Name: idx_22094_gram_image_image_likes_profile_id_02ff2c90; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22094_gram_image_image_likes_profile_id_02ff2c90 ON public.gram_image_image_likes USING btree (profile_id);


--
-- Name: idx_22099_gram_comments_author_id_c03c8b80; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22099_gram_comments_author_id_c03c8b80 ON public.gram_comments USING btree (author_id);


--
-- Name: idx_22099_gram_comments_commented_image_id_a234db74; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22099_gram_comments_commented_image_id_a234db74 ON public.gram_comments USING btree (commented_image_id);


--
-- Name: idx_22106_gram_image_imageuploader_profile_id_cc4da15b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22106_gram_image_imageuploader_profile_id_cc4da15b ON public.gram_image USING btree (imageuploader_profile_id);


--
-- Name: idx_22113_sqlite_autoindex_gram_profile_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22113_sqlite_autoindex_gram_profile_1 ON public.gram_profile USING btree (user_id);


--
-- Name: idx_22120_account_emailconfirmation_email_address_id_5b7f8c58; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22120_account_emailconfirmation_email_address_id_5b7f8c58 ON public.account_emailconfirmation USING btree (email_address_id);


--
-- Name: idx_22120_sqlite_autoindex_account_emailconfirmation_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22120_sqlite_autoindex_account_emailconfirmation_1 ON public.account_emailconfirmation USING btree (key);


--
-- Name: idx_22127_account_emailaddress_email_03be32b2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22127_account_emailaddress_email_03be32b2 ON public.account_emailaddress USING btree (email);


--
-- Name: idx_22127_account_emailaddress_user_id_2c513194; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22127_account_emailaddress_user_id_2c513194 ON public.account_emailaddress USING btree (user_id);


--
-- Name: idx_22127_account_emailaddress_user_id_email_987c8728_uniq; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22127_account_emailaddress_user_id_email_987c8728_uniq ON public.account_emailaddress USING btree (user_id, email);


--
-- Name: idx_22127_unique_primary_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22127_unique_primary_email ON public.account_emailaddress USING btree (user_id, "primary");


--
-- Name: idx_22127_unique_verified_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22127_unique_verified_email ON public.account_emailaddress USING btree (email);


--
-- Name: idx_22134_sqlite_autoindex_django_site_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22134_sqlite_autoindex_django_site_1 ON public.django_site USING btree (domain);


--
-- Name: idx_22141_socialaccount_socialapp_sites_site_id_2579dee5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22141_socialaccount_socialapp_sites_site_id_2579dee5 ON public.socialaccount_socialapp_sites USING btree (site_id);


--
-- Name: idx_22141_socialaccount_socialapp_sites_socialapp_id_97fb6e7d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22141_socialaccount_socialapp_sites_socialapp_id_97fb6e7d ON public.socialaccount_socialapp_sites USING btree (socialapp_id);


--
-- Name: idx_22141_socialaccount_socialapp_sites_socialapp_id_site_id_71; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22141_socialaccount_socialapp_sites_socialapp_id_site_id_71 ON public.socialaccount_socialapp_sites USING btree (socialapp_id, site_id);


--
-- Name: idx_22153_socialaccount_socialtoken_account_id_951f210e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22153_socialaccount_socialtoken_account_id_951f210e ON public.socialaccount_socialtoken USING btree (account_id);


--
-- Name: idx_22153_socialaccount_socialtoken_app_id_636a42d7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22153_socialaccount_socialtoken_app_id_636a42d7 ON public.socialaccount_socialtoken USING btree (app_id);


--
-- Name: idx_22153_socialaccount_socialtoken_app_id_account_id_fca4e0ac_; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22153_socialaccount_socialtoken_app_id_account_id_fca4e0ac_ ON public.socialaccount_socialtoken USING btree (app_id, account_id);


--
-- Name: idx_22160_socialaccount_socialaccount_provider_uid_fc810c6e_uni; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22160_socialaccount_socialaccount_provider_uid_fc810c6e_uni ON public.socialaccount_socialaccount USING btree (provider, uid);


--
-- Name: idx_22160_socialaccount_socialaccount_user_id_8146e70c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22160_socialaccount_socialaccount_user_id_8146e70c ON public.socialaccount_socialaccount USING btree (user_id);


--
-- Name: idx_22174_sqlite_autoindex_taggit_taggeditem_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22174_sqlite_autoindex_taggit_taggeditem_1 ON public.taggit_taggeditem USING btree (content_type_id, object_id, tag_id);


--
-- Name: idx_22174_taggit_tagg_content_8fc721_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22174_taggit_tagg_content_8fc721_idx ON public.taggit_taggeditem USING btree (content_type_id, object_id);


--
-- Name: idx_22174_taggit_taggeditem_content_type_id_9957a03c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22174_taggit_taggeditem_content_type_id_9957a03c ON public.taggit_taggeditem USING btree (content_type_id);


--
-- Name: idx_22174_taggit_taggeditem_object_id_e2d7d1df; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22174_taggit_taggeditem_object_id_e2d7d1df ON public.taggit_taggeditem USING btree (object_id);


--
-- Name: idx_22174_taggit_taggeditem_tag_id_f4f5b767; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22174_taggit_taggeditem_tag_id_f4f5b767 ON public.taggit_taggeditem USING btree (tag_id);


--
-- Name: idx_22179_sqlite_autoindex_taggit_tag_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22179_sqlite_autoindex_taggit_tag_1 ON public.taggit_tag USING btree (name);


--
-- Name: idx_22179_sqlite_autoindex_taggit_tag_2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22179_sqlite_autoindex_taggit_tag_2 ON public.taggit_tag USING btree (slug);


--
-- Name: idx_22186_sqlite_autoindex_wagtailcore_collection_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22186_sqlite_autoindex_wagtailcore_collection_1 ON public.wagtailcore_collection USING btree (path);


--
-- Name: idx_22193_wagtailcore_groupcollectionpermission_collection_id_5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22193_wagtailcore_groupcollectionpermission_collection_id_5 ON public.wagtailcore_groupcollectionpermission USING btree (collection_id);


--
-- Name: idx_22193_wagtailcore_groupcollectionpermission_group_id_05d614; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22193_wagtailcore_groupcollectionpermission_group_id_05d614 ON public.wagtailcore_groupcollectionpermission USING btree (group_id);


--
-- Name: idx_22193_wagtailcore_groupcollectionpermission_group_id_collec; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22193_wagtailcore_groupcollectionpermission_group_id_collec ON public.wagtailcore_groupcollectionpermission USING btree (group_id, collection_id, permission_id);


--
-- Name: idx_22193_wagtailcore_groupcollectionpermission_permission_id_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22193_wagtailcore_groupcollectionpermission_permission_id_1 ON public.wagtailcore_groupcollectionpermission USING btree (permission_id);


--
-- Name: idx_22203_wagtailadmi_content_717955_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22203_wagtailadmi_content_717955_idx ON public.wagtailadmin_editingsession USING btree (content_type_id, object_id);


--
-- Name: idx_22203_wagtailadmin_editingsession_content_type_id_4df7730e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22203_wagtailadmin_editingsession_content_type_id_4df7730e ON public.wagtailadmin_editingsession USING btree (content_type_id);


--
-- Name: idx_22203_wagtailadmin_editingsession_user_id_6e1a9b70; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22203_wagtailadmin_editingsession_user_id_6e1a9b70 ON public.wagtailadmin_editingsession USING btree (user_id);


--
-- Name: idx_22210_wagtailcore_pageviewrestriction_groups_group_id_6460f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22210_wagtailcore_pageviewrestriction_groups_group_id_6460f ON public.wagtailcore_pageviewrestriction_groups USING btree (group_id);


--
-- Name: idx_22210_wagtailcore_pageviewrestriction_groups_pageviewrestri; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22210_wagtailcore_pageviewrestriction_groups_pageviewrestri ON public.wagtailcore_pageviewrestriction_groups USING btree (pageviewrestriction_id, group_id);


--
-- Name: idx_22215_wagtailcore_pageviewrestriction_page_id_15a8bea6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22215_wagtailcore_pageviewrestriction_page_id_15a8bea6 ON public.wagtailcore_pageviewrestriction USING btree (page_id);


--
-- Name: idx_22222_wagtailcore_collectionviewrestriction_collection_id_7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22222_wagtailcore_collectionviewrestriction_collection_id_7 ON public.wagtailcore_collectionviewrestriction USING btree (collection_id);


--
-- Name: idx_22229_wagtailcore_collectionviewrestriction_groups_collecti; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22229_wagtailcore_collectionviewrestriction_groups_collecti ON public.wagtailcore_collectionviewrestriction_groups USING btree (collectionviewrestriction_id);


--
-- Name: idx_22229_wagtailcore_collectionviewrestriction_groups_group_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22229_wagtailcore_collectionviewrestriction_groups_group_id ON public.wagtailcore_collectionviewrestriction_groups USING btree (group_id);


--
-- Name: idx_22234_wagtailcore_site_hostname_96b20b46; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22234_wagtailcore_site_hostname_96b20b46 ON public.wagtailcore_site USING btree (hostname);


--
-- Name: idx_22234_wagtailcore_site_hostname_port_2c626d70_uniq; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22234_wagtailcore_site_hostname_port_2c626d70_uniq ON public.wagtailcore_site USING btree (hostname, port);


--
-- Name: idx_22234_wagtailcore_site_root_page_id_e02fb95c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22234_wagtailcore_site_root_page_id_e02fb95c ON public.wagtailcore_site USING btree (root_page_id);


--
-- Name: idx_22241_wagtailcore_task_content_type_id_249ab8ba; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22241_wagtailcore_task_content_type_id_249ab8ba ON public.wagtailcore_task USING btree (content_type_id);


--
-- Name: idx_22257_wagtailcore_workflowpage_workflow_id_56f56ff6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22257_wagtailcore_workflowpage_workflow_id_56f56ff6 ON public.wagtailcore_workflowpage USING btree (workflow_id);


--
-- Name: idx_22261_wagtailcore_workflowtask_task_id_ce7716fe; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22261_wagtailcore_workflowtask_task_id_ce7716fe ON public.wagtailcore_workflowtask USING btree (task_id);


--
-- Name: idx_22261_wagtailcore_workflowtask_workflow_id_b9717175; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22261_wagtailcore_workflowtask_workflow_id_b9717175 ON public.wagtailcore_workflowtask USING btree (workflow_id);


--
-- Name: idx_22261_wagtailcore_workflowtask_workflow_id_task_id_4ec7a62b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22261_wagtailcore_workflowtask_workflow_id_task_id_4ec7a62b ON public.wagtailcore_workflowtask USING btree (workflow_id, task_id);


--
-- Name: idx_22266_wagtailcore_groupapprovaltask_groups_group_id_2e64b61; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22266_wagtailcore_groupapprovaltask_groups_group_id_2e64b61 ON public.wagtailcore_groupapprovaltask_groups USING btree (group_id);


--
-- Name: idx_22266_wagtailcore_groupapprovaltask_groups_groupapprovaltas; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22266_wagtailcore_groupapprovaltask_groups_groupapprovaltas ON public.wagtailcore_groupapprovaltask_groups USING btree (groupapprovaltask_id, group_id);


--
-- Name: idx_22271_sqlite_autoindex_wagtailcore_locale_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22271_sqlite_autoindex_wagtailcore_locale_1 ON public.wagtailcore_locale USING btree (language_code);


--
-- Name: idx_22278_sqlite_autoindex_wagtailcore_page_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22278_sqlite_autoindex_wagtailcore_page_1 ON public.wagtailcore_page USING btree (path);


--
-- Name: idx_22278_wagtailcore_page_alias_of_id_12945502; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22278_wagtailcore_page_alias_of_id_12945502 ON public.wagtailcore_page USING btree (alias_of_id);


--
-- Name: idx_22278_wagtailcore_page_content_type_id_c28424df; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22278_wagtailcore_page_content_type_id_c28424df ON public.wagtailcore_page USING btree (content_type_id);


--
-- Name: idx_22278_wagtailcore_page_first_published_at_2b5dd637; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22278_wagtailcore_page_first_published_at_2b5dd637 ON public.wagtailcore_page USING btree (first_published_at);


--
-- Name: idx_22278_wagtailcore_page_latest_revision_id_e60fef51; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22278_wagtailcore_page_latest_revision_id_e60fef51 ON public.wagtailcore_page USING btree (latest_revision_id);


--
-- Name: idx_22278_wagtailcore_page_live_revision_id_930bd822; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22278_wagtailcore_page_live_revision_id_930bd822 ON public.wagtailcore_page USING btree (live_revision_id);


--
-- Name: idx_22278_wagtailcore_page_locale_id_3c7e30a6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22278_wagtailcore_page_locale_id_3c7e30a6 ON public.wagtailcore_page USING btree (locale_id);


--
-- Name: idx_22278_wagtailcore_page_locked_by_id_bcb86245; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22278_wagtailcore_page_locked_by_id_bcb86245 ON public.wagtailcore_page USING btree (locked_by_id);


--
-- Name: idx_22278_wagtailcore_page_owner_id_fbf7c332; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22278_wagtailcore_page_owner_id_fbf7c332 ON public.wagtailcore_page USING btree (owner_id);


--
-- Name: idx_22278_wagtailcore_page_slug_e7c11b8f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22278_wagtailcore_page_slug_e7c11b8f ON public.wagtailcore_page USING btree (slug);


--
-- Name: idx_22278_wagtailcore_page_translation_key_locale_id_9b041bad_u; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22278_wagtailcore_page_translation_key_locale_id_9b041bad_u ON public.wagtailcore_page USING btree (translation_key, locale_id);


--
-- Name: idx_22285_wagtailcore_commentreply_comment_id_afc7e027; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22285_wagtailcore_commentreply_comment_id_afc7e027 ON public.wagtailcore_commentreply USING btree (comment_id);


--
-- Name: idx_22285_wagtailcore_commentreply_user_id_d0b3b9c3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22285_wagtailcore_commentreply_user_id_d0b3b9c3 ON public.wagtailcore_commentreply USING btree (user_id);


--
-- Name: idx_22292_wagtailcore_pagesubscription_page_id_a085e7a6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22292_wagtailcore_pagesubscription_page_id_a085e7a6 ON public.wagtailcore_pagesubscription USING btree (page_id);


--
-- Name: idx_22292_wagtailcore_pagesubscription_page_id_user_id_0cef73ed; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22292_wagtailcore_pagesubscription_page_id_user_id_0cef73ed ON public.wagtailcore_pagesubscription USING btree (page_id, user_id);


--
-- Name: idx_22292_wagtailcore_pagesubscription_user_id_89d7def9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22292_wagtailcore_pagesubscription_user_id_89d7def9 ON public.wagtailcore_pagesubscription USING btree (user_id);


--
-- Name: idx_22297_wagtailcore_comment_page_id_108444b5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22297_wagtailcore_comment_page_id_108444b5 ON public.wagtailcore_comment USING btree (page_id);


--
-- Name: idx_22297_wagtailcore_comment_resolved_by_id_a282aa0e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22297_wagtailcore_comment_resolved_by_id_a282aa0e ON public.wagtailcore_comment USING btree (resolved_by_id);


--
-- Name: idx_22297_wagtailcore_comment_revision_created_id_1d058279; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22297_wagtailcore_comment_revision_created_id_1d058279 ON public.wagtailcore_comment USING btree (revision_created_id);


--
-- Name: idx_22297_wagtailcore_comment_user_id_0c577ca6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22297_wagtailcore_comment_user_id_0c577ca6 ON public.wagtailcore_comment USING btree (user_id);


--
-- Name: idx_22304_wagtailcore_referenceindex_base_content_type_id_313cf; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22304_wagtailcore_referenceindex_base_content_type_id_313cf ON public.wagtailcore_referenceindex USING btree (base_content_type_id);


--
-- Name: idx_22304_wagtailcore_referenceindex_base_content_type_id_objec; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22304_wagtailcore_referenceindex_base_content_type_id_objec ON public.wagtailcore_referenceindex USING btree (base_content_type_id, object_id, to_content_type_id, to_object_id, content_path_hash);


--
-- Name: idx_22304_wagtailcore_referenceindex_content_type_id_766e0336; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22304_wagtailcore_referenceindex_content_type_id_766e0336 ON public.wagtailcore_referenceindex USING btree (content_type_id);


--
-- Name: idx_22304_wagtailcore_referenceindex_to_content_type_id_93690bb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22304_wagtailcore_referenceindex_to_content_type_id_93690bb ON public.wagtailcore_referenceindex USING btree (to_content_type_id);


--
-- Name: idx_22311_wagtailcore_taskstate_content_type_id_0a758fdc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22311_wagtailcore_taskstate_content_type_id_0a758fdc ON public.wagtailcore_taskstate USING btree (content_type_id);


--
-- Name: idx_22311_wagtailcore_taskstate_finished_by_id_13f98229; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22311_wagtailcore_taskstate_finished_by_id_13f98229 ON public.wagtailcore_taskstate USING btree (finished_by_id);


--
-- Name: idx_22311_wagtailcore_taskstate_revision_id_df25a499; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22311_wagtailcore_taskstate_revision_id_df25a499 ON public.wagtailcore_taskstate USING btree (revision_id);


--
-- Name: idx_22311_wagtailcore_taskstate_task_id_c3677c34; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22311_wagtailcore_taskstate_task_id_c3677c34 ON public.wagtailcore_taskstate USING btree (task_id);


--
-- Name: idx_22311_wagtailcore_taskstate_workflow_state_id_9239a775; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22311_wagtailcore_taskstate_workflow_state_id_9239a775 ON public.wagtailcore_taskstate USING btree (workflow_state_id);


--
-- Name: idx_22318_sqlite_autoindex_wagtailcore_workflowstate_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22318_sqlite_autoindex_wagtailcore_workflowstate_1 ON public.wagtailcore_workflowstate USING btree (current_task_state_id);


--
-- Name: idx_22318_unique_in_progress_workflow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22318_unique_in_progress_workflow ON public.wagtailcore_workflowstate USING btree (base_content_type_id, object_id);


--
-- Name: idx_22318_wagtailcore_workflowstate_base_content_type_id_a30dc5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22318_wagtailcore_workflowstate_base_content_type_id_a30dc5 ON public.wagtailcore_workflowstate USING btree (base_content_type_id);


--
-- Name: idx_22318_wagtailcore_workflowstate_content_type_id_2bb78ce1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22318_wagtailcore_workflowstate_content_type_id_2bb78ce1 ON public.wagtailcore_workflowstate USING btree (content_type_id);


--
-- Name: idx_22318_wagtailcore_workflowstate_requested_by_id_4090bca3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22318_wagtailcore_workflowstate_requested_by_id_4090bca3 ON public.wagtailcore_workflowstate USING btree (requested_by_id);


--
-- Name: idx_22318_wagtailcore_workflowstate_workflow_id_1f18378f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22318_wagtailcore_workflowstate_workflow_id_1f18378f ON public.wagtailcore_workflowstate USING btree (workflow_id);


--
-- Name: idx_22318_workflowstate_base_ct_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22318_workflowstate_base_ct_id_idx ON public.wagtailcore_workflowstate USING btree (base_content_type_id, object_id);


--
-- Name: idx_22318_workflowstate_ct_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22318_workflowstate_ct_id_idx ON public.wagtailcore_workflowstate USING btree (content_type_id, object_id);


--
-- Name: idx_22324_wagtailcore_workflowcontenttype_workflow_id_9aad7cd2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22324_wagtailcore_workflowcontenttype_workflow_id_9aad7cd2 ON public.wagtailcore_workflowcontenttype USING btree (workflow_id);


--
-- Name: idx_22328_wagtailcore_modellogentry_action_d2d856ee; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22328_wagtailcore_modellogentry_action_d2d856ee ON public.wagtailcore_modellogentry USING btree (action);


--
-- Name: idx_22328_wagtailcore_modellogentry_content_changed_8bc39742; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22328_wagtailcore_modellogentry_content_changed_8bc39742 ON public.wagtailcore_modellogentry USING btree (content_changed);


--
-- Name: idx_22328_wagtailcore_modellogentry_content_type_id_68849e77; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22328_wagtailcore_modellogentry_content_type_id_68849e77 ON public.wagtailcore_modellogentry USING btree (content_type_id);


--
-- Name: idx_22328_wagtailcore_modellogentry_object_id_e0e7d4ef; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22328_wagtailcore_modellogentry_object_id_e0e7d4ef ON public.wagtailcore_modellogentry USING btree (object_id);


--
-- Name: idx_22328_wagtailcore_modellogentry_revision_id_df6ca33a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22328_wagtailcore_modellogentry_revision_id_df6ca33a ON public.wagtailcore_modellogentry USING btree (revision_id);


--
-- Name: idx_22328_wagtailcore_modellogentry_timestamp_9694521b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22328_wagtailcore_modellogentry_timestamp_9694521b ON public.wagtailcore_modellogentry USING btree ("timestamp");


--
-- Name: idx_22328_wagtailcore_modellogentry_user_id_0278d1bf; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22328_wagtailcore_modellogentry_user_id_0278d1bf ON public.wagtailcore_modellogentry USING btree (user_id);


--
-- Name: idx_22335_wagtailcore_pagelogentry_action_c2408198; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22335_wagtailcore_pagelogentry_action_c2408198 ON public.wagtailcore_pagelogentry USING btree (action);


--
-- Name: idx_22335_wagtailcore_pagelogentry_content_changed_99f27ade; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22335_wagtailcore_pagelogentry_content_changed_99f27ade ON public.wagtailcore_pagelogentry USING btree (content_changed);


--
-- Name: idx_22335_wagtailcore_pagelogentry_content_type_id_74e7708a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22335_wagtailcore_pagelogentry_content_type_id_74e7708a ON public.wagtailcore_pagelogentry USING btree (content_type_id);


--
-- Name: idx_22335_wagtailcore_pagelogentry_page_id_8464e327; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22335_wagtailcore_pagelogentry_page_id_8464e327 ON public.wagtailcore_pagelogentry USING btree (page_id);


--
-- Name: idx_22335_wagtailcore_pagelogentry_revision_id_8043d103; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22335_wagtailcore_pagelogentry_revision_id_8043d103 ON public.wagtailcore_pagelogentry USING btree (revision_id);


--
-- Name: idx_22335_wagtailcore_pagelogentry_timestamp_deb774c4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22335_wagtailcore_pagelogentry_timestamp_deb774c4 ON public.wagtailcore_pagelogentry USING btree ("timestamp");


--
-- Name: idx_22335_wagtailcore_pagelogentry_user_id_604ccfd8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22335_wagtailcore_pagelogentry_user_id_604ccfd8 ON public.wagtailcore_pagelogentry USING btree (user_id);


--
-- Name: idx_22342_sqlite_autoindex_wagtailcore_grouppagepermission_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22342_sqlite_autoindex_wagtailcore_grouppagepermission_1 ON public.wagtailcore_grouppagepermission USING btree (group_id, page_id, permission_id);


--
-- Name: idx_22342_wagtailcore_grouppagepermission_group_id_fc07e671; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22342_wagtailcore_grouppagepermission_group_id_fc07e671 ON public.wagtailcore_grouppagepermission USING btree (group_id);


--
-- Name: idx_22342_wagtailcore_grouppagepermission_page_id_710b114a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22342_wagtailcore_grouppagepermission_page_id_710b114a ON public.wagtailcore_grouppagepermission USING btree (page_id);


--
-- Name: idx_22342_wagtailcore_grouppagepermission_permission_id_05acb22; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22342_wagtailcore_grouppagepermission_permission_id_05acb22 ON public.wagtailcore_grouppagepermission USING btree (permission_id);


--
-- Name: idx_22347_base_content_object_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22347_base_content_object_idx ON public.wagtailcore_revision USING btree (base_content_type_id, object_id);


--
-- Name: idx_22347_content_object_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22347_content_object_idx ON public.wagtailcore_revision USING btree (content_type_id, object_id);


--
-- Name: idx_22347_wagtailcore_revision_approved_go_live_at_88d3dee5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22347_wagtailcore_revision_approved_go_live_at_88d3dee5 ON public.wagtailcore_revision USING btree (approved_go_live_at);


--
-- Name: idx_22347_wagtailcore_revision_base_content_type_id_5b4ef7bd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22347_wagtailcore_revision_base_content_type_id_5b4ef7bd ON public.wagtailcore_revision USING btree (base_content_type_id);


--
-- Name: idx_22347_wagtailcore_revision_content_type_id_c8cb69c0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22347_wagtailcore_revision_content_type_id_c8cb69c0 ON public.wagtailcore_revision USING btree (content_type_id);


--
-- Name: idx_22347_wagtailcore_revision_created_at_81450aa6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22347_wagtailcore_revision_created_at_81450aa6 ON public.wagtailcore_revision USING btree (created_at);


--
-- Name: idx_22347_wagtailcore_revision_user_id_03df83b0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22347_wagtailcore_revision_user_id_03df83b0 ON public.wagtailcore_revision USING btree (user_id);


--
-- Name: idx_22354_wagtailcore_uploadedfile_for_content_type_id_b0fc87b2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22354_wagtailcore_uploadedfile_for_content_type_id_b0fc87b2 ON public.wagtailcore_uploadedfile USING btree (for_content_type_id);


--
-- Name: idx_22354_wagtailcore_uploadedfile_uploaded_by_user_id_c7580fe8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22354_wagtailcore_uploadedfile_uploaded_by_user_id_c7580fe8 ON public.wagtailcore_uploadedfile USING btree (uploaded_by_user_id);


--
-- Name: idx_22361_wagtaildocs_document_collection_id_23881625; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22361_wagtaildocs_document_collection_id_23881625 ON public.wagtaildocs_document USING btree (collection_id);


--
-- Name: idx_22361_wagtaildocs_document_uploaded_by_user_id_17258b41; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22361_wagtaildocs_document_uploaded_by_user_id_17258b41 ON public.wagtaildocs_document USING btree (uploaded_by_user_id);


--
-- Name: idx_22368_sqlite_autoindex_wagtailembeds_embed_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22368_sqlite_autoindex_wagtailembeds_embed_1 ON public.wagtailembeds_embed USING btree (hash);


--
-- Name: idx_22368_wagtailembeds_embed_cache_until_26c94bb0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22368_wagtailembeds_embed_cache_until_26c94bb0 ON public.wagtailembeds_embed USING btree (cache_until);


--
-- Name: idx_22375_wagtailforms_formsubmission_page_id_e48e93e7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22375_wagtailforms_formsubmission_page_id_e48e93e7 ON public.wagtailforms_formsubmission USING btree (page_id);


--
-- Name: idx_22382_wagtailimages_image_collection_id_c2f8af7e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22382_wagtailimages_image_collection_id_c2f8af7e ON public.wagtailimages_image USING btree (collection_id);


--
-- Name: idx_22382_wagtailimages_image_created_at_86fa6cd4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22382_wagtailimages_image_created_at_86fa6cd4 ON public.wagtailimages_image USING btree (created_at);


--
-- Name: idx_22382_wagtailimages_image_file_hash_fb5bbb23; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22382_wagtailimages_image_file_hash_fb5bbb23 ON public.wagtailimages_image USING btree (file_hash);


--
-- Name: idx_22382_wagtailimages_image_uploaded_by_user_id_5d73dc75; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22382_wagtailimages_image_uploaded_by_user_id_5d73dc75 ON public.wagtailimages_image USING btree (uploaded_by_user_id);


--
-- Name: idx_22389_wagtailimages_rendition_filter_spec_1cba3201; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22389_wagtailimages_rendition_filter_spec_1cba3201 ON public.wagtailimages_rendition USING btree (filter_spec);


--
-- Name: idx_22389_wagtailimages_rendition_image_id_3e1fd774; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22389_wagtailimages_rendition_image_id_3e1fd774 ON public.wagtailimages_rendition USING btree (image_id);


--
-- Name: idx_22389_wagtailimages_rendition_image_id_filter_spec_focal_po; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22389_wagtailimages_rendition_image_id_filter_spec_focal_po ON public.wagtailimages_rendition USING btree (image_id, filter_spec, focal_point_key);


--
-- Name: idx_22396_wagtailredirects_redirect_old_path_bb35247b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22396_wagtailredirects_redirect_old_path_bb35247b ON public.wagtailredirects_redirect USING btree (old_path);


--
-- Name: idx_22396_wagtailredirects_redirect_old_path_site_id_783622d7_u; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22396_wagtailredirects_redirect_old_path_site_id_783622d7_u ON public.wagtailredirects_redirect USING btree (old_path, site_id);


--
-- Name: idx_22396_wagtailredirects_redirect_redirect_page_id_b5728a8f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22396_wagtailredirects_redirect_redirect_page_id_b5728a8f ON public.wagtailredirects_redirect USING btree (redirect_page_id);


--
-- Name: idx_22396_wagtailredirects_redirect_site_id_780a0e1e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22396_wagtailredirects_redirect_site_id_780a0e1e ON public.wagtailredirects_redirect USING btree (site_id);


--
-- Name: idx_22403_wagtailsearch_indexentry_content_type_id_62ed694f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22403_wagtailsearch_indexentry_content_type_id_62ed694f ON public.wagtailsearch_indexentry USING btree (content_type_id);


--
-- Name: idx_22403_wagtailsearch_indexentry_content_type_id_object_id_bc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22403_wagtailsearch_indexentry_content_type_id_object_id_bc ON public.wagtailsearch_indexentry USING btree (content_type_id, object_id);


--
-- Name: idx_22440_sqlite_autoindex_wagtailusers_userprofile_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22440_sqlite_autoindex_wagtailusers_userprofile_1 ON public.wagtailusers_userprofile USING btree (user_id);


--
-- Name: idx_22452_sqlite_autoindex_apps_emailtemplate_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22452_sqlite_autoindex_apps_emailtemplate_1 ON public.apps_emailtemplate USING btree (name);


--
-- Name: idx_22459_actstream_action_action_object_content_type_id_ee623c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22459_actstream_action_action_object_content_type_id_ee623c ON public.actstream_action USING btree (action_object_content_type_id);


--
-- Name: idx_22459_actstream_action_action_object_object_id_6433bdf7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22459_actstream_action_action_object_object_id_6433bdf7 ON public.actstream_action USING btree (action_object_object_id);


--
-- Name: idx_22459_actstream_action_actor_content_type_id_d5e5ec2a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22459_actstream_action_actor_content_type_id_d5e5ec2a ON public.actstream_action USING btree (actor_content_type_id);


--
-- Name: idx_22459_actstream_action_actor_object_id_72ef0cfa; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22459_actstream_action_actor_object_id_72ef0cfa ON public.actstream_action USING btree (actor_object_id);


--
-- Name: idx_22459_actstream_action_public_ac0653e9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22459_actstream_action_public_ac0653e9 ON public.actstream_action USING btree (public);


--
-- Name: idx_22459_actstream_action_target_content_type_id_187fa164; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22459_actstream_action_target_content_type_id_187fa164 ON public.actstream_action USING btree (target_content_type_id);


--
-- Name: idx_22459_actstream_action_target_object_id_e080d801; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22459_actstream_action_target_object_id_e080d801 ON public.actstream_action USING btree (target_object_id);


--
-- Name: idx_22459_actstream_action_timestamp_a23fe3ae; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22459_actstream_action_timestamp_a23fe3ae ON public.actstream_action USING btree ("timestamp");


--
-- Name: idx_22459_actstream_action_verb_83f768b7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22459_actstream_action_verb_83f768b7 ON public.actstream_action USING btree (verb);


--
-- Name: idx_22466_actstream_follow_content_type_id_ba287eb9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22466_actstream_follow_content_type_id_ba287eb9 ON public.actstream_follow USING btree (content_type_id);


--
-- Name: idx_22466_actstream_follow_flag_0e741c24; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22466_actstream_follow_flag_0e741c24 ON public.actstream_follow USING btree (flag);


--
-- Name: idx_22466_actstream_follow_object_id_d790e00d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22466_actstream_follow_object_id_d790e00d ON public.actstream_follow USING btree (object_id);


--
-- Name: idx_22466_actstream_follow_started_254c63bd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22466_actstream_follow_started_254c63bd ON public.actstream_follow USING btree (started);


--
-- Name: idx_22466_actstream_follow_user_id_content_type_id_object_id_fl; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22466_actstream_follow_user_id_content_type_id_object_id_fl ON public.actstream_follow USING btree (user_id, content_type_id, object_id, flag);


--
-- Name: idx_22466_actstream_follow_user_id_e9d4e1ff; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22466_actstream_follow_user_id_e9d4e1ff ON public.actstream_follow USING btree (user_id);


--
-- Name: idx_22473_apps_medicalfile_medical_information_id_fcb79edf; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22473_apps_medicalfile_medical_information_id_fcb79edf ON public.apps_medicalfile USING btree (medical_information_id);


--
-- Name: idx_22473_apps_medicalfile_user_id_7f7ac961; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22473_apps_medicalfile_user_id_7f7ac961 ON public.apps_medicalfile USING btree (user_id);


--
-- Name: idx_22480_sqlite_autoindex_apps_treatmentproduct_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22480_sqlite_autoindex_apps_treatmentproduct_1 ON public.apps_treatmentproduct USING btree (slug);


--
-- Name: idx_22487_apps_user_emergency_contact_id_8526c675; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22487_apps_user_emergency_contact_id_8526c675 ON public.apps_user USING btree (emergency_contact_id);


--
-- Name: idx_22487_apps_user_medical_information_id_62c4e813; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22487_apps_user_medical_information_id_62c4e813 ON public.apps_user USING btree (medical_information_id);


--
-- Name: idx_22487_sqlite_autoindex_apps_user_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22487_sqlite_autoindex_apps_user_1 ON public.apps_user USING btree (username);


--
-- Name: idx_22494_apps_patientschedule_accommodation_id_81153c02; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22494_apps_patientschedule_accommodation_id_81153c02 ON public.apps_patientschedule USING btree (accommodation_id);


--
-- Name: idx_22494_apps_patientschedule_appointment_id_43629dac; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22494_apps_patientschedule_appointment_id_43629dac ON public.apps_patientschedule USING btree (appointment_id);


--
-- Name: idx_22494_apps_patientschedule_flight_reservation_id_c86b7ad1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22494_apps_patientschedule_flight_reservation_id_c86b7ad1 ON public.apps_patientschedule USING btree (flight_reservation_id);


--
-- Name: idx_22494_apps_patientschedule_hospital_id_a9bf8d60; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22494_apps_patientschedule_hospital_id_a9bf8d60 ON public.apps_patientschedule USING btree (hospital_id);


--
-- Name: idx_22494_apps_patientschedule_user_id_bc9e5f13; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22494_apps_patientschedule_user_id_bc9e5f13 ON public.apps_patientschedule USING btree (user_id);


--
-- Name: idx_22501_apps_flightreservation_user_id_e8c13797; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22501_apps_flightreservation_user_id_e8c13797 ON public.apps_flightreservation USING btree (user_id);


--
-- Name: idx_22515_apps_accommodation_hotel_id_16940ee6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22515_apps_accommodation_hotel_id_16940ee6 ON public.apps_accommodation USING btree (hotel_id);


--
-- Name: idx_22515_apps_accommodation_treatment_plan_id_dbdd786c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22515_apps_accommodation_treatment_plan_id_dbdd786c ON public.apps_accommodation USING btree (treatment_plan_id);


--
-- Name: idx_22515_apps_accommodation_user_id_7f18e63f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22515_apps_accommodation_user_id_7f18e63f ON public.apps_accommodation USING btree (user_id);


--
-- Name: idx_22520_apps_treatmentplan_doctor_id_89a52519; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22520_apps_treatmentplan_doctor_id_89a52519 ON public.apps_treatmentplan USING btree (doctor_id);


--
-- Name: idx_22520_apps_treatmentplan_patient_id_9139f24f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22520_apps_treatmentplan_patient_id_9139f24f ON public.apps_treatmentplan USING btree (patient_id);


--
-- Name: idx_22527_apps_treatmentplanitem_product_id_ef309e26; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22527_apps_treatmentplanitem_product_id_ef309e26 ON public.apps_treatmentplanitem USING btree (product_id);


--
-- Name: idx_22527_apps_treatmentplanitem_treatment_plan_id_92a80682; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22527_apps_treatmentplanitem_treatment_plan_id_92a80682 ON public.apps_treatmentplanitem USING btree (treatment_plan_id);


--
-- Name: leads_leadhistory_lead_id_df206d67; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX leads_leadhistory_lead_id_df206d67 ON public.leads_leadhistory USING btree (lead_id);


--
-- Name: leads_leadhistory_user_id_22682495; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX leads_leadhistory_user_id_22682495 ON public.leads_leadhistory USING btree (user_id);


--
-- Name: leads_note_lead_id_5778e489; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX leads_note_lead_id_5778e489 ON public.leads_note USING btree (lead_id);


--
-- Name: leads_note_user_id_e4b36bfd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX leads_note_user_id_e4b36bfd ON public.leads_note USING btree (user_id);


--
-- Name: account_emailaddress account_emailaddress_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_emailaddress
    ADD CONSTRAINT account_emailaddress_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.apps_user(id);


--
-- Name: account_emailconfirmation account_emailconfirmation_email_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_emailconfirmation
    ADD CONSTRAINT account_emailconfirmation_email_address_id_fkey FOREIGN KEY (email_address_id) REFERENCES public.account_emailaddress(id);


--
-- Name: actstream_action actstream_action_action_object_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actstream_action
    ADD CONSTRAINT actstream_action_action_object_content_type_id_fkey FOREIGN KEY (action_object_content_type_id) REFERENCES public.django_content_type(id);


--
-- Name: actstream_action actstream_action_actor_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actstream_action
    ADD CONSTRAINT actstream_action_actor_content_type_id_fkey FOREIGN KEY (actor_content_type_id) REFERENCES public.django_content_type(id);


--
-- Name: actstream_action actstream_action_target_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actstream_action
    ADD CONSTRAINT actstream_action_target_content_type_id_fkey FOREIGN KEY (target_content_type_id) REFERENCES public.django_content_type(id);


--
-- Name: actstream_follow actstream_follow_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actstream_follow
    ADD CONSTRAINT actstream_follow_content_type_id_fkey FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id);


--
-- Name: actstream_follow actstream_follow_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actstream_follow
    ADD CONSTRAINT actstream_follow_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.apps_user(id);


--
-- Name: apps_accommodation apps_accommodation_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_accommodation
    ADD CONSTRAINT apps_accommodation_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.apps_hotel(id);


--
-- Name: apps_accommodation apps_accommodation_treatment_plan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_accommodation
    ADD CONSTRAINT apps_accommodation_treatment_plan_id_fkey FOREIGN KEY (treatment_plan_id) REFERENCES public.apps_treatmentplan(id);


--
-- Name: apps_accommodation apps_accommodation_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_accommodation
    ADD CONSTRAINT apps_accommodation_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.apps_user(id);


--
-- Name: apps_appointment apps_appointment_doctor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_appointment
    ADD CONSTRAINT apps_appointment_doctor_id_fkey FOREIGN KEY (doctor_id) REFERENCES public.apps_user(id);


--
-- Name: apps_appointment apps_appointment_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_appointment
    ADD CONSTRAINT apps_appointment_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.apps_user(id);


--
-- Name: apps_flightreservation apps_flightreservation_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_flightreservation
    ADD CONSTRAINT apps_flightreservation_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.apps_user(id);


--
-- Name: apps_homepage apps_homepage_page_ptr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_homepage
    ADD CONSTRAINT apps_homepage_page_ptr_id_fkey FOREIGN KEY (page_ptr_id) REFERENCES public.wagtailcore_page(id);


--
-- Name: apps_hospitalstay apps_hospitalstay_hospital_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_hospitalstay
    ADD CONSTRAINT apps_hospitalstay_hospital_id_fkey FOREIGN KEY (hospital_id) REFERENCES public.apps_hospital(id);


--
-- Name: apps_hospitalstay apps_hospitalstay_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_hospitalstay
    ADD CONSTRAINT apps_hospitalstay_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.apps_user(id);


--
-- Name: apps_medicalfile apps_medicalfile_medical_information_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_medicalfile
    ADD CONSTRAINT apps_medicalfile_medical_information_id_fkey FOREIGN KEY (medical_information_id) REFERENCES public.apps_medicalinformation(id);


--
-- Name: apps_medicalfile apps_medicalfile_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_medicalfile
    ADD CONSTRAINT apps_medicalfile_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.apps_user(id);


--
-- Name: apps_medicalinformation apps_medicalinformation_insurance_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_medicalinformation
    ADD CONSTRAINT apps_medicalinformation_insurance_id_fkey FOREIGN KEY (insurance_id) REFERENCES public.apps_insurance(id);


--
-- Name: apps_message apps_message_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_message
    ADD CONSTRAINT apps_message_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.apps_messagegroup(id);


--
-- Name: apps_message_read_members apps_message_read_members_message_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_message_read_members
    ADD CONSTRAINT apps_message_read_members_message_id_fkey FOREIGN KEY (message_id) REFERENCES public.apps_message(id);


--
-- Name: apps_message_read_members apps_message_read_members_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_message_read_members
    ADD CONSTRAINT apps_message_read_members_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.apps_user(id);


--
-- Name: apps_message apps_message_sender_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_message
    ADD CONSTRAINT apps_message_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES public.apps_user(id);


--
-- Name: apps_messagegroup_members apps_messagegroup_members_messagegroup_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_messagegroup_members
    ADD CONSTRAINT apps_messagegroup_members_messagegroup_id_fkey FOREIGN KEY (messagegroup_id) REFERENCES public.apps_messagegroup(id);


--
-- Name: apps_messagegroup_members apps_messagegroup_members_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_messagegroup_members
    ADD CONSTRAINT apps_messagegroup_members_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.apps_user(id);


--
-- Name: apps_patientschedule apps_patientschedule_accommodation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_patientschedule
    ADD CONSTRAINT apps_patientschedule_accommodation_id_fkey FOREIGN KEY (accommodation_id) REFERENCES public.apps_accommodation(id);


--
-- Name: apps_patientschedule apps_patientschedule_appointment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_patientschedule
    ADD CONSTRAINT apps_patientschedule_appointment_id_fkey FOREIGN KEY (appointment_id) REFERENCES public.apps_appointment(id);


--
-- Name: apps_patientschedule apps_patientschedule_flight_reservation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_patientschedule
    ADD CONSTRAINT apps_patientschedule_flight_reservation_id_fkey FOREIGN KEY (flight_reservation_id) REFERENCES public.apps_flightreservation(id);


--
-- Name: apps_patientschedule apps_patientschedule_hospital_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_patientschedule
    ADD CONSTRAINT apps_patientschedule_hospital_id_fkey FOREIGN KEY (hospital_id) REFERENCES public.apps_hospital(id);


--
-- Name: apps_patientschedule apps_patientschedule_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_patientschedule
    ADD CONSTRAINT apps_patientschedule_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.apps_user(id);


--
-- Name: apps_prescription apps_prescription_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_prescription
    ADD CONSTRAINT apps_prescription_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.apps_user(id);


--
-- Name: apps_referral apps_referral_referred_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_referral
    ADD CONSTRAINT apps_referral_referred_id_fkey FOREIGN KEY (referred_id) REFERENCES public.apps_user(id);


--
-- Name: apps_referral apps_referral_referrer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_referral
    ADD CONSTRAINT apps_referral_referrer_id_fkey FOREIGN KEY (referrer_id) REFERENCES public.apps_user(id);


--
-- Name: apps_treatmentplan apps_treatmentplan_doctor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_treatmentplan
    ADD CONSTRAINT apps_treatmentplan_doctor_id_fkey FOREIGN KEY (doctor_id) REFERENCES public.apps_user(id);


--
-- Name: apps_treatmentplan apps_treatmentplan_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_treatmentplan
    ADD CONSTRAINT apps_treatmentplan_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.apps_user(id);


--
-- Name: apps_treatmentplanitem apps_treatmentplanitem_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_treatmentplanitem
    ADD CONSTRAINT apps_treatmentplanitem_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.apps_treatmentproduct(id);


--
-- Name: apps_treatmentplanitem apps_treatmentplanitem_treatment_plan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_treatmentplanitem
    ADD CONSTRAINT apps_treatmentplanitem_treatment_plan_id_fkey FOREIGN KEY (treatment_plan_id) REFERENCES public.apps_treatmentplan(id);


--
-- Name: apps_user apps_user_emergency_contact_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_user
    ADD CONSTRAINT apps_user_emergency_contact_id_fkey FOREIGN KEY (emergency_contact_id) REFERENCES public.apps_emergencycontact(id);


--
-- Name: apps_user_groups apps_user_groups_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_user_groups
    ADD CONSTRAINT apps_user_groups_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.auth_group(id);


--
-- Name: apps_user_groups apps_user_groups_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_user_groups
    ADD CONSTRAINT apps_user_groups_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.apps_user(id);


--
-- Name: apps_user apps_user_medical_information_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_user
    ADD CONSTRAINT apps_user_medical_information_id_fkey FOREIGN KEY (medical_information_id) REFERENCES public.apps_medicalinformation(id);


--
-- Name: apps_user_user_permissions apps_user_user_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_user_user_permissions
    ADD CONSTRAINT apps_user_user_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id);


--
-- Name: apps_user_user_permissions apps_user_user_permissions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps_user_user_permissions
    ADD CONSTRAINT apps_user_user_permissions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.apps_user(id);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.auth_group(id);


--
-- Name: auth_group_permissions auth_group_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id);


--
-- Name: auth_permission auth_permission_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_fkey FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id);


--
-- Name: authtoken_token authtoken_token_user_id_35299eff_fk_apps_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_35299eff_fk_apps_user_id FOREIGN KEY (user_id) REFERENCES public.apps_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: blog_comments blog_comments_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blog_comments
    ADD CONSTRAINT blog_comments_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.blog_profile(id);


--
-- Name: blog_comments blog_comments_commented_image_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blog_comments
    ADD CONSTRAINT blog_comments_commented_image_id_fkey FOREIGN KEY (commented_image_id) REFERENCES public.blog_image(id);


--
-- Name: blog_image_image_likes blog_image_image_likes_image_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blog_image_image_likes
    ADD CONSTRAINT blog_image_image_likes_image_id_fkey FOREIGN KEY (image_id) REFERENCES public.blog_image(id);


--
-- Name: blog_image_image_likes blog_image_image_likes_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blog_image_image_likes
    ADD CONSTRAINT blog_image_image_likes_profile_id_fkey FOREIGN KEY (profile_id) REFERENCES public.blog_profile(id);


--
-- Name: blog_image blog_image_imageuploader_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blog_image
    ADD CONSTRAINT blog_image_imageuploader_profile_id_fkey FOREIGN KEY (imageuploader_profile_id) REFERENCES public.apps_user(id);


--
-- Name: blog_profile blog_profile_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blog_profile
    ADD CONSTRAINT blog_profile_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.apps_user(id);


--
-- Name: django_admin_log django_admin_log_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_fkey FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id);


--
-- Name: django_admin_log django_admin_log_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.apps_user(id);


--
-- Name: gram_comments gram_comments_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gram_comments
    ADD CONSTRAINT gram_comments_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.gram_profile(id);


--
-- Name: gram_comments gram_comments_commented_image_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gram_comments
    ADD CONSTRAINT gram_comments_commented_image_id_fkey FOREIGN KEY (commented_image_id) REFERENCES public.gram_image(id);


--
-- Name: gram_image_image_likes gram_image_image_likes_image_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gram_image_image_likes
    ADD CONSTRAINT gram_image_image_likes_image_id_fkey FOREIGN KEY (image_id) REFERENCES public.gram_image(id);


--
-- Name: gram_image_image_likes gram_image_image_likes_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gram_image_image_likes
    ADD CONSTRAINT gram_image_image_likes_profile_id_fkey FOREIGN KEY (profile_id) REFERENCES public.gram_profile(id);


--
-- Name: gram_image gram_image_imageuploader_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gram_image
    ADD CONSTRAINT gram_image_imageuploader_profile_id_fkey FOREIGN KEY (imageuploader_profile_id) REFERENCES public.apps_user(id);


--
-- Name: gram_profile gram_profile_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gram_profile
    ADD CONSTRAINT gram_profile_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.apps_user(id);


--
-- Name: leads_leadhistory leads_leadhistory_lead_id_df206d67_fk_leads_lead_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leads_leadhistory
    ADD CONSTRAINT leads_leadhistory_lead_id_df206d67_fk_leads_lead_id FOREIGN KEY (lead_id) REFERENCES public.leads_lead(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: leads_leadhistory leads_leadhistory_user_id_22682495_fk_apps_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leads_leadhistory
    ADD CONSTRAINT leads_leadhistory_user_id_22682495_fk_apps_user_id FOREIGN KEY (user_id) REFERENCES public.apps_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: leads_note leads_note_lead_id_5778e489_fk_leads_lead_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leads_note
    ADD CONSTRAINT leads_note_lead_id_5778e489_fk_leads_lead_id FOREIGN KEY (lead_id) REFERENCES public.leads_lead(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: leads_note leads_note_user_id_e4b36bfd_fk_apps_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leads_note
    ADD CONSTRAINT leads_note_user_id_e4b36bfd_fk_apps_user_id FOREIGN KEY (user_id) REFERENCES public.apps_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialaccount socialaccount_socialaccount_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialaccount
    ADD CONSTRAINT socialaccount_socialaccount_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.apps_user(id);


--
-- Name: socialaccount_socialapp_sites socialaccount_socialapp_sites_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_socialapp_sites_site_id_fkey FOREIGN KEY (site_id) REFERENCES public.django_site(id);


--
-- Name: socialaccount_socialapp_sites socialaccount_socialapp_sites_socialapp_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_socialapp_sites_socialapp_id_fkey FOREIGN KEY (socialapp_id) REFERENCES public.socialaccount_socialapp(id);


--
-- Name: socialaccount_socialtoken socialaccount_socialtoken_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_socialtoken_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.socialaccount_socialaccount(id);


--
-- Name: socialaccount_socialtoken socialaccount_socialtoken_app_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_socialtoken_app_id_fkey FOREIGN KEY (app_id) REFERENCES public.socialaccount_socialapp(id);


--
-- Name: taggit_taggeditem taggit_taggeditem_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taggit_taggeditem
    ADD CONSTRAINT taggit_taggeditem_content_type_id_fkey FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id);


--
-- Name: taggit_taggeditem taggit_taggeditem_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taggit_taggeditem
    ADD CONSTRAINT taggit_taggeditem_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.taggit_tag(id);


--
-- Name: wagtailadmin_editingsession wagtailadmin_editingsession_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailadmin_editingsession
    ADD CONSTRAINT wagtailadmin_editingsession_content_type_id_fkey FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id);


--
-- Name: wagtailadmin_editingsession wagtailadmin_editingsession_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailadmin_editingsession
    ADD CONSTRAINT wagtailadmin_editingsession_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.apps_user(id);


--
-- Name: wagtailcore_collectionviewrestriction_groups wagtailcore_collectionviewres_collectionviewrestriction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_collectionviewrestriction_groups
    ADD CONSTRAINT wagtailcore_collectionviewres_collectionviewrestriction_id_fkey FOREIGN KEY (collectionviewrestriction_id) REFERENCES public.wagtailcore_collectionviewrestriction(id);


--
-- Name: wagtailcore_collectionviewrestriction wagtailcore_collectionviewrestriction_collection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_collectionviewrestriction
    ADD CONSTRAINT wagtailcore_collectionviewrestriction_collection_id_fkey FOREIGN KEY (collection_id) REFERENCES public.wagtailcore_collection(id);


--
-- Name: wagtailcore_collectionviewrestriction_groups wagtailcore_collectionviewrestriction_groups_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_collectionviewrestriction_groups
    ADD CONSTRAINT wagtailcore_collectionviewrestriction_groups_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.auth_group(id);


--
-- Name: wagtailcore_comment wagtailcore_comment_page_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_comment
    ADD CONSTRAINT wagtailcore_comment_page_id_fkey FOREIGN KEY (page_id) REFERENCES public.wagtailcore_page(id);


--
-- Name: wagtailcore_comment wagtailcore_comment_resolved_by_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_comment
    ADD CONSTRAINT wagtailcore_comment_resolved_by_id_fkey FOREIGN KEY (resolved_by_id) REFERENCES public.apps_user(id);


--
-- Name: wagtailcore_comment wagtailcore_comment_revision_created_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_comment
    ADD CONSTRAINT wagtailcore_comment_revision_created_id_fkey FOREIGN KEY (revision_created_id) REFERENCES public.wagtailcore_revision(id);


--
-- Name: wagtailcore_comment wagtailcore_comment_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_comment
    ADD CONSTRAINT wagtailcore_comment_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.apps_user(id);


--
-- Name: wagtailcore_commentreply wagtailcore_commentreply_comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_commentreply
    ADD CONSTRAINT wagtailcore_commentreply_comment_id_fkey FOREIGN KEY (comment_id) REFERENCES public.wagtailcore_comment(id);


--
-- Name: wagtailcore_commentreply wagtailcore_commentreply_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_commentreply
    ADD CONSTRAINT wagtailcore_commentreply_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.apps_user(id);


--
-- Name: wagtailcore_groupapprovaltask_groups wagtailcore_groupapprovaltask_groups_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_groupapprovaltask_groups
    ADD CONSTRAINT wagtailcore_groupapprovaltask_groups_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.auth_group(id);


--
-- Name: wagtailcore_groupapprovaltask_groups wagtailcore_groupapprovaltask_groups_groupapprovaltask_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_groupapprovaltask_groups
    ADD CONSTRAINT wagtailcore_groupapprovaltask_groups_groupapprovaltask_id_fkey FOREIGN KEY (groupapprovaltask_id) REFERENCES public.wagtailcore_groupapprovaltask(task_ptr_id);


--
-- Name: wagtailcore_groupapprovaltask wagtailcore_groupapprovaltask_task_ptr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_groupapprovaltask
    ADD CONSTRAINT wagtailcore_groupapprovaltask_task_ptr_id_fkey FOREIGN KEY (task_ptr_id) REFERENCES public.wagtailcore_task(id);


--
-- Name: wagtailcore_groupcollectionpermission wagtailcore_groupcollectionpermission_collection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_groupcollectionpermission
    ADD CONSTRAINT wagtailcore_groupcollectionpermission_collection_id_fkey FOREIGN KEY (collection_id) REFERENCES public.wagtailcore_collection(id);


--
-- Name: wagtailcore_groupcollectionpermission wagtailcore_groupcollectionpermission_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_groupcollectionpermission
    ADD CONSTRAINT wagtailcore_groupcollectionpermission_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.auth_group(id);


--
-- Name: wagtailcore_groupcollectionpermission wagtailcore_groupcollectionpermission_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_groupcollectionpermission
    ADD CONSTRAINT wagtailcore_groupcollectionpermission_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id);


--
-- Name: wagtailcore_grouppagepermission wagtailcore_grouppagepermission_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_grouppagepermission
    ADD CONSTRAINT wagtailcore_grouppagepermission_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.auth_group(id);


--
-- Name: wagtailcore_grouppagepermission wagtailcore_grouppagepermission_page_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_grouppagepermission
    ADD CONSTRAINT wagtailcore_grouppagepermission_page_id_fkey FOREIGN KEY (page_id) REFERENCES public.wagtailcore_page(id);


--
-- Name: wagtailcore_grouppagepermission wagtailcore_grouppagepermission_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_grouppagepermission
    ADD CONSTRAINT wagtailcore_grouppagepermission_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id);


--
-- Name: wagtailcore_modellogentry wagtailcore_modellogentry_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_modellogentry
    ADD CONSTRAINT wagtailcore_modellogentry_content_type_id_fkey FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id);


--
-- Name: wagtailcore_page wagtailcore_page_alias_of_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_page
    ADD CONSTRAINT wagtailcore_page_alias_of_id_fkey FOREIGN KEY (alias_of_id) REFERENCES public.wagtailcore_page(id);


--
-- Name: wagtailcore_page wagtailcore_page_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_page
    ADD CONSTRAINT wagtailcore_page_content_type_id_fkey FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id);


--
-- Name: wagtailcore_page wagtailcore_page_latest_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_page
    ADD CONSTRAINT wagtailcore_page_latest_revision_id_fkey FOREIGN KEY (latest_revision_id) REFERENCES public.wagtailcore_revision(id);


--
-- Name: wagtailcore_page wagtailcore_page_live_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_page
    ADD CONSTRAINT wagtailcore_page_live_revision_id_fkey FOREIGN KEY (live_revision_id) REFERENCES public.wagtailcore_revision(id);


--
-- Name: wagtailcore_page wagtailcore_page_locale_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_page
    ADD CONSTRAINT wagtailcore_page_locale_id_fkey FOREIGN KEY (locale_id) REFERENCES public.wagtailcore_locale(id);


--
-- Name: wagtailcore_page wagtailcore_page_locked_by_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_page
    ADD CONSTRAINT wagtailcore_page_locked_by_id_fkey FOREIGN KEY (locked_by_id) REFERENCES public.apps_user(id);


--
-- Name: wagtailcore_page wagtailcore_page_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_page
    ADD CONSTRAINT wagtailcore_page_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES public.apps_user(id);


--
-- Name: wagtailcore_pagelogentry wagtailcore_pagelogentry_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_pagelogentry
    ADD CONSTRAINT wagtailcore_pagelogentry_content_type_id_fkey FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id);


--
-- Name: wagtailcore_pagesubscription wagtailcore_pagesubscription_page_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_pagesubscription
    ADD CONSTRAINT wagtailcore_pagesubscription_page_id_fkey FOREIGN KEY (page_id) REFERENCES public.wagtailcore_page(id);


--
-- Name: wagtailcore_pagesubscription wagtailcore_pagesubscription_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_pagesubscription
    ADD CONSTRAINT wagtailcore_pagesubscription_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.apps_user(id);


--
-- Name: wagtailcore_pageviewrestriction_groups wagtailcore_pageviewrestriction_gro_pageviewrestriction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_pageviewrestriction_groups
    ADD CONSTRAINT wagtailcore_pageviewrestriction_gro_pageviewrestriction_id_fkey FOREIGN KEY (pageviewrestriction_id) REFERENCES public.wagtailcore_pageviewrestriction(id);


--
-- Name: wagtailcore_pageviewrestriction_groups wagtailcore_pageviewrestriction_groups_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_pageviewrestriction_groups
    ADD CONSTRAINT wagtailcore_pageviewrestriction_groups_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.auth_group(id);


--
-- Name: wagtailcore_pageviewrestriction wagtailcore_pageviewrestriction_page_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_pageviewrestriction
    ADD CONSTRAINT wagtailcore_pageviewrestriction_page_id_fkey FOREIGN KEY (page_id) REFERENCES public.wagtailcore_page(id);


--
-- Name: wagtailcore_referenceindex wagtailcore_referenceindex_base_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_referenceindex
    ADD CONSTRAINT wagtailcore_referenceindex_base_content_type_id_fkey FOREIGN KEY (base_content_type_id) REFERENCES public.django_content_type(id);


--
-- Name: wagtailcore_referenceindex wagtailcore_referenceindex_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_referenceindex
    ADD CONSTRAINT wagtailcore_referenceindex_content_type_id_fkey FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id);


--
-- Name: wagtailcore_referenceindex wagtailcore_referenceindex_to_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_referenceindex
    ADD CONSTRAINT wagtailcore_referenceindex_to_content_type_id_fkey FOREIGN KEY (to_content_type_id) REFERENCES public.django_content_type(id);


--
-- Name: wagtailcore_revision wagtailcore_revision_base_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_revision
    ADD CONSTRAINT wagtailcore_revision_base_content_type_id_fkey FOREIGN KEY (base_content_type_id) REFERENCES public.django_content_type(id);


--
-- Name: wagtailcore_revision wagtailcore_revision_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_revision
    ADD CONSTRAINT wagtailcore_revision_content_type_id_fkey FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id);


--
-- Name: wagtailcore_revision wagtailcore_revision_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_revision
    ADD CONSTRAINT wagtailcore_revision_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.apps_user(id);


--
-- Name: wagtailcore_site wagtailcore_site_root_page_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_site
    ADD CONSTRAINT wagtailcore_site_root_page_id_fkey FOREIGN KEY (root_page_id) REFERENCES public.wagtailcore_page(id);


--
-- Name: wagtailcore_task wagtailcore_task_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_task
    ADD CONSTRAINT wagtailcore_task_content_type_id_fkey FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id);


--
-- Name: wagtailcore_taskstate wagtailcore_taskstate_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_taskstate
    ADD CONSTRAINT wagtailcore_taskstate_content_type_id_fkey FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id);


--
-- Name: wagtailcore_taskstate wagtailcore_taskstate_finished_by_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_taskstate
    ADD CONSTRAINT wagtailcore_taskstate_finished_by_id_fkey FOREIGN KEY (finished_by_id) REFERENCES public.apps_user(id);


--
-- Name: wagtailcore_taskstate wagtailcore_taskstate_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_taskstate
    ADD CONSTRAINT wagtailcore_taskstate_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES public.wagtailcore_revision(id);


--
-- Name: wagtailcore_taskstate wagtailcore_taskstate_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_taskstate
    ADD CONSTRAINT wagtailcore_taskstate_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.wagtailcore_task(id);


--
-- Name: wagtailcore_taskstate wagtailcore_taskstate_workflow_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_taskstate
    ADD CONSTRAINT wagtailcore_taskstate_workflow_state_id_fkey FOREIGN KEY (workflow_state_id) REFERENCES public.wagtailcore_workflowstate(id);


--
-- Name: wagtailcore_uploadedfile wagtailcore_uploadedfile_for_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_uploadedfile
    ADD CONSTRAINT wagtailcore_uploadedfile_for_content_type_id_fkey FOREIGN KEY (for_content_type_id) REFERENCES public.django_content_type(id);


--
-- Name: wagtailcore_uploadedfile wagtailcore_uploadedfile_uploaded_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_uploadedfile
    ADD CONSTRAINT wagtailcore_uploadedfile_uploaded_by_user_id_fkey FOREIGN KEY (uploaded_by_user_id) REFERENCES public.apps_user(id);


--
-- Name: wagtailcore_workflowcontenttype wagtailcore_workflowcontenttype_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_workflowcontenttype
    ADD CONSTRAINT wagtailcore_workflowcontenttype_content_type_id_fkey FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id);


--
-- Name: wagtailcore_workflowcontenttype wagtailcore_workflowcontenttype_workflow_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_workflowcontenttype
    ADD CONSTRAINT wagtailcore_workflowcontenttype_workflow_id_fkey FOREIGN KEY (workflow_id) REFERENCES public.wagtailcore_workflow(id);


--
-- Name: wagtailcore_workflowpage wagtailcore_workflowpage_page_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_workflowpage
    ADD CONSTRAINT wagtailcore_workflowpage_page_id_fkey FOREIGN KEY (page_id) REFERENCES public.wagtailcore_page(id);


--
-- Name: wagtailcore_workflowpage wagtailcore_workflowpage_workflow_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_workflowpage
    ADD CONSTRAINT wagtailcore_workflowpage_workflow_id_fkey FOREIGN KEY (workflow_id) REFERENCES public.wagtailcore_workflow(id);


--
-- Name: wagtailcore_workflowstate wagtailcore_workflowstate_base_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_workflowstate
    ADD CONSTRAINT wagtailcore_workflowstate_base_content_type_id_fkey FOREIGN KEY (base_content_type_id) REFERENCES public.django_content_type(id);


--
-- Name: wagtailcore_workflowstate wagtailcore_workflowstate_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_workflowstate
    ADD CONSTRAINT wagtailcore_workflowstate_content_type_id_fkey FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id);


--
-- Name: wagtailcore_workflowstate wagtailcore_workflowstate_current_task_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_workflowstate
    ADD CONSTRAINT wagtailcore_workflowstate_current_task_state_id_fkey FOREIGN KEY (current_task_state_id) REFERENCES public.wagtailcore_taskstate(id);


--
-- Name: wagtailcore_workflowstate wagtailcore_workflowstate_requested_by_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_workflowstate
    ADD CONSTRAINT wagtailcore_workflowstate_requested_by_id_fkey FOREIGN KEY (requested_by_id) REFERENCES public.apps_user(id);


--
-- Name: wagtailcore_workflowstate wagtailcore_workflowstate_workflow_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_workflowstate
    ADD CONSTRAINT wagtailcore_workflowstate_workflow_id_fkey FOREIGN KEY (workflow_id) REFERENCES public.wagtailcore_workflow(id);


--
-- Name: wagtailcore_workflowtask wagtailcore_workflowtask_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_workflowtask
    ADD CONSTRAINT wagtailcore_workflowtask_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.wagtailcore_task(id);


--
-- Name: wagtailcore_workflowtask wagtailcore_workflowtask_workflow_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailcore_workflowtask
    ADD CONSTRAINT wagtailcore_workflowtask_workflow_id_fkey FOREIGN KEY (workflow_id) REFERENCES public.wagtailcore_workflow(id);


--
-- Name: wagtaildocs_document wagtaildocs_document_collection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtaildocs_document
    ADD CONSTRAINT wagtaildocs_document_collection_id_fkey FOREIGN KEY (collection_id) REFERENCES public.wagtailcore_collection(id);


--
-- Name: wagtaildocs_document wagtaildocs_document_uploaded_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtaildocs_document
    ADD CONSTRAINT wagtaildocs_document_uploaded_by_user_id_fkey FOREIGN KEY (uploaded_by_user_id) REFERENCES public.apps_user(id);


--
-- Name: wagtailforms_formsubmission wagtailforms_formsubmission_page_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailforms_formsubmission
    ADD CONSTRAINT wagtailforms_formsubmission_page_id_fkey FOREIGN KEY (page_id) REFERENCES public.wagtailcore_page(id);


--
-- Name: wagtailimages_image wagtailimages_image_collection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailimages_image
    ADD CONSTRAINT wagtailimages_image_collection_id_fkey FOREIGN KEY (collection_id) REFERENCES public.wagtailcore_collection(id);


--
-- Name: wagtailimages_image wagtailimages_image_uploaded_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailimages_image
    ADD CONSTRAINT wagtailimages_image_uploaded_by_user_id_fkey FOREIGN KEY (uploaded_by_user_id) REFERENCES public.apps_user(id);


--
-- Name: wagtailimages_rendition wagtailimages_rendition_image_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailimages_rendition
    ADD CONSTRAINT wagtailimages_rendition_image_id_fkey FOREIGN KEY (image_id) REFERENCES public.wagtailimages_image(id);


--
-- Name: wagtailredirects_redirect wagtailredirects_redirect_redirect_page_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailredirects_redirect
    ADD CONSTRAINT wagtailredirects_redirect_redirect_page_id_fkey FOREIGN KEY (redirect_page_id) REFERENCES public.wagtailcore_page(id);


--
-- Name: wagtailredirects_redirect wagtailredirects_redirect_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailredirects_redirect
    ADD CONSTRAINT wagtailredirects_redirect_site_id_fkey FOREIGN KEY (site_id) REFERENCES public.wagtailcore_site(id);


--
-- Name: wagtailsearch_indexentry wagtailsearch_indexentry_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailsearch_indexentry
    ADD CONSTRAINT wagtailsearch_indexentry_content_type_id_fkey FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id);


--
-- Name: wagtailusers_userprofile wagtailusers_userprofile_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wagtailusers_userprofile
    ADD CONSTRAINT wagtailusers_userprofile_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.apps_user(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

