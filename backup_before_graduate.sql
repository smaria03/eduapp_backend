--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5 (Postgres.app)
-- Dumped by pg_dump version 17.5 (Postgres.app)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.active_storage_attachments (
    id bigint NOT NULL,
    name character varying NOT NULL,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    blob_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.active_storage_attachments OWNER TO postgres;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.active_storage_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.active_storage_attachments_id_seq OWNER TO postgres;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.active_storage_attachments_id_seq OWNED BY public.active_storage_attachments.id;


--
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.active_storage_blobs (
    id bigint NOT NULL,
    key character varying NOT NULL,
    filename character varying NOT NULL,
    content_type character varying,
    metadata text,
    service_name character varying NOT NULL,
    byte_size bigint NOT NULL,
    checksum character varying NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.active_storage_blobs OWNER TO postgres;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.active_storage_blobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.active_storage_blobs_id_seq OWNER TO postgres;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.active_storage_blobs_id_seq OWNED BY public.active_storage_blobs.id;


--
-- Name: active_storage_variant_records; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.active_storage_variant_records (
    id bigint NOT NULL,
    blob_id bigint NOT NULL,
    variation_digest character varying NOT NULL
);


ALTER TABLE public.active_storage_variant_records OWNER TO postgres;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.active_storage_variant_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNER TO postgres;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNED BY public.active_storage_variant_records.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: mariasilaghi
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO mariasilaghi;

--
-- Name: attendances; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attendances (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    assignment_id bigint NOT NULL,
    period_id bigint NOT NULL,
    date date,
    status integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.attendances OWNER TO postgres;

--
-- Name: attendances_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.attendances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.attendances_id_seq OWNER TO postgres;

--
-- Name: attendances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.attendances_id_seq OWNED BY public.attendances.id;


--
-- Name: grades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grades (
    id bigint NOT NULL,
    value integer,
    student_id bigint NOT NULL,
    teacher_id bigint NOT NULL,
    subject_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.grades OWNER TO postgres;

--
-- Name: grades_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.grades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.grades_id_seq OWNER TO postgres;

--
-- Name: grades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.grades_id_seq OWNED BY public.grades.id;


--
-- Name: homework_submissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.homework_submissions (
    id bigint NOT NULL,
    homework_id bigint NOT NULL,
    student_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    grade integer
);


ALTER TABLE public.homework_submissions OWNER TO postgres;

--
-- Name: homework_submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.homework_submissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.homework_submissions_id_seq OWNER TO postgres;

--
-- Name: homework_submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.homework_submissions_id_seq OWNED BY public.homework_submissions.id;


--
-- Name: homeworks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.homeworks (
    id bigint NOT NULL,
    title character varying,
    description text,
    deadline date,
    assignment_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.homeworks OWNER TO postgres;

--
-- Name: homeworks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.homeworks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.homeworks_id_seq OWNER TO postgres;

--
-- Name: homeworks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.homeworks_id_seq OWNED BY public.homeworks.id;


--
-- Name: learning_materials; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.learning_materials (
    id bigint NOT NULL,
    title character varying,
    description text,
    assignment_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.learning_materials OWNER TO postgres;

--
-- Name: learning_materials_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.learning_materials_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.learning_materials_id_seq OWNER TO postgres;

--
-- Name: learning_materials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.learning_materials_id_seq OWNED BY public.learning_materials.id;


--
-- Name: periods; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.periods (
    id bigint NOT NULL,
    start_time time without time zone,
    end_time time without time zone,
    label character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.periods OWNER TO postgres;

--
-- Name: periods_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.periods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.periods_id_seq OWNER TO postgres;

--
-- Name: periods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.periods_id_seq OWNED BY public.periods.id;


--
-- Name: quiz_answers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quiz_answers (
    id bigint NOT NULL,
    quiz_submission_id bigint NOT NULL,
    quiz_question_id bigint NOT NULL,
    selected_option_ids integer[] DEFAULT '{}'::integer[],
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.quiz_answers OWNER TO postgres;

--
-- Name: quiz_answers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quiz_answers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.quiz_answers_id_seq OWNER TO postgres;

--
-- Name: quiz_answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quiz_answers_id_seq OWNED BY public.quiz_answers.id;


--
-- Name: quiz_options; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quiz_options (
    id bigint NOT NULL,
    quiz_question_id bigint NOT NULL,
    text character varying,
    is_correct boolean,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.quiz_options OWNER TO postgres;

--
-- Name: quiz_options_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quiz_options_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.quiz_options_id_seq OWNER TO postgres;

--
-- Name: quiz_options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quiz_options_id_seq OWNED BY public.quiz_options.id;


--
-- Name: quiz_questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quiz_questions (
    id bigint NOT NULL,
    quiz_id bigint NOT NULL,
    question_text text,
    point_value double precision,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.quiz_questions OWNER TO postgres;

--
-- Name: quiz_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quiz_questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.quiz_questions_id_seq OWNER TO postgres;

--
-- Name: quiz_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quiz_questions_id_seq OWNED BY public.quiz_questions.id;


--
-- Name: quiz_submissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quiz_submissions (
    id bigint NOT NULL,
    quiz_id bigint NOT NULL,
    student_id bigint NOT NULL,
    submitted_at timestamp without time zone,
    raw_score double precision,
    final_score double precision,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.quiz_submissions OWNER TO postgres;

--
-- Name: quiz_submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quiz_submissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.quiz_submissions_id_seq OWNER TO postgres;

--
-- Name: quiz_submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quiz_submissions_id_seq OWNED BY public.quiz_submissions.id;


--
-- Name: quizzes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quizzes (
    id bigint NOT NULL,
    title character varying,
    description text,
    deadline timestamp without time zone,
    time_limit integer,
    assignment_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.quizzes OWNER TO postgres;

--
-- Name: quizzes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quizzes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.quizzes_id_seq OWNER TO postgres;

--
-- Name: quizzes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quizzes_id_seq OWNED BY public.quizzes.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: mariasilaghi
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO mariasilaghi;

--
-- Name: school_class_archives; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.school_class_archives (
    id bigint NOT NULL,
    school_class_id bigint NOT NULL,
    label character varying,
    archived_at timestamp without time zone,
    data jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.school_class_archives OWNER TO postgres;

--
-- Name: school_class_archives_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.school_class_archives_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.school_class_archives_id_seq OWNER TO postgres;

--
-- Name: school_class_archives_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.school_class_archives_id_seq OWNED BY public.school_class_archives.id;


--
-- Name: school_class_subjects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.school_class_subjects (
    id bigint NOT NULL,
    school_class_id bigint NOT NULL,
    subject_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    teacher_id bigint
);


ALTER TABLE public.school_class_subjects OWNER TO postgres;

--
-- Name: school_class_subjects_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.school_class_subjects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.school_class_subjects_id_seq OWNER TO postgres;

--
-- Name: school_class_subjects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.school_class_subjects_id_seq OWNED BY public.school_class_subjects.id;


--
-- Name: school_classes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.school_classes (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.school_classes OWNER TO postgres;

--
-- Name: school_classes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.school_classes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.school_classes_id_seq OWNER TO postgres;

--
-- Name: school_classes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.school_classes_id_seq OWNED BY public.school_classes.id;


--
-- Name: subjects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subjects (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.subjects OWNER TO postgres;

--
-- Name: subjects_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subjects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subjects_id_seq OWNER TO postgres;

--
-- Name: subjects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subjects_id_seq OWNED BY public.subjects.id;


--
-- Name: timetable_entries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.timetable_entries (
    id bigint NOT NULL,
    assignment_id bigint NOT NULL,
    weekday integer NOT NULL,
    period_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.timetable_entries OWNER TO postgres;

--
-- Name: timetable_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.timetable_entries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.timetable_entries_id_seq OWNER TO postgres;

--
-- Name: timetable_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.timetable_entries_id_seq OWNED BY public.timetable_entries.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: mariasilaghi
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    name character varying,
    role character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    jti character varying,
    school_class_id bigint
);


ALTER TABLE public.users OWNER TO mariasilaghi;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: mariasilaghi
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO mariasilaghi;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mariasilaghi
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: active_storage_attachments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_attachments ALTER COLUMN id SET DEFAULT nextval('public.active_storage_attachments_id_seq'::regclass);


--
-- Name: active_storage_blobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_blobs ALTER COLUMN id SET DEFAULT nextval('public.active_storage_blobs_id_seq'::regclass);


--
-- Name: active_storage_variant_records id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_variant_records ALTER COLUMN id SET DEFAULT nextval('public.active_storage_variant_records_id_seq'::regclass);


--
-- Name: attendances id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendances ALTER COLUMN id SET DEFAULT nextval('public.attendances_id_seq'::regclass);


--
-- Name: grades id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grades ALTER COLUMN id SET DEFAULT nextval('public.grades_id_seq'::regclass);


--
-- Name: homework_submissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.homework_submissions ALTER COLUMN id SET DEFAULT nextval('public.homework_submissions_id_seq'::regclass);


--
-- Name: homeworks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.homeworks ALTER COLUMN id SET DEFAULT nextval('public.homeworks_id_seq'::regclass);


--
-- Name: learning_materials id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.learning_materials ALTER COLUMN id SET DEFAULT nextval('public.learning_materials_id_seq'::regclass);


--
-- Name: periods id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.periods ALTER COLUMN id SET DEFAULT nextval('public.periods_id_seq'::regclass);


--
-- Name: quiz_answers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_answers ALTER COLUMN id SET DEFAULT nextval('public.quiz_answers_id_seq'::regclass);


--
-- Name: quiz_options id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_options ALTER COLUMN id SET DEFAULT nextval('public.quiz_options_id_seq'::regclass);


--
-- Name: quiz_questions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_questions ALTER COLUMN id SET DEFAULT nextval('public.quiz_questions_id_seq'::regclass);


--
-- Name: quiz_submissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_submissions ALTER COLUMN id SET DEFAULT nextval('public.quiz_submissions_id_seq'::regclass);


--
-- Name: quizzes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quizzes ALTER COLUMN id SET DEFAULT nextval('public.quizzes_id_seq'::regclass);


--
-- Name: school_class_archives id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.school_class_archives ALTER COLUMN id SET DEFAULT nextval('public.school_class_archives_id_seq'::regclass);


--
-- Name: school_class_subjects id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.school_class_subjects ALTER COLUMN id SET DEFAULT nextval('public.school_class_subjects_id_seq'::regclass);


--
-- Name: school_classes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.school_classes ALTER COLUMN id SET DEFAULT nextval('public.school_classes_id_seq'::regclass);


--
-- Name: subjects id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subjects ALTER COLUMN id SET DEFAULT nextval('public.subjects_id_seq'::regclass);


--
-- Name: timetable_entries id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timetable_entries ALTER COLUMN id SET DEFAULT nextval('public.timetable_entries_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: mariasilaghi
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: active_storage_attachments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.active_storage_attachments (id, name, record_type, record_id, blob_id, created_at) FROM stdin;
1	file	LearningMaterial	1	1	2025-08-21 08:30:45.112349
3	file	LearningMaterial	3	3	2025-08-21 10:44:37.657642
8	file	LearningMaterial	8	8	2025-08-21 14:48:26.623948
12	file	LearningMaterial	12	12	2025-08-22 08:03:31.220143
15	file	HomeworkSubmission	3	15	2025-08-27 15:05:24.747809
16	file	HomeworkSubmission	4	16	2025-08-28 09:21:24.462412
17	file	LearningMaterial	13	17	2025-08-28 11:00:56.070722
18	file	LearningMaterial	14	18	2025-08-28 11:07:34.467654
19	file	HomeworkSubmission	5	19	2025-08-28 16:31:22.654411
21	file	HomeworkSubmission	7	21	2025-08-28 16:41:09.470955
22	file	LearningMaterial	15	22	2025-09-01 07:44:17.992002
25	file	LearningMaterial	18	25	2025-09-01 09:12:17.062965
27	file	HomeworkSubmission	9	27	2025-09-01 12:03:53.81925
\.


--
-- Data for Name: active_storage_blobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.active_storage_blobs (id, key, filename, content_type, metadata, service_name, byte_size, checksum, created_at) FROM stdin;
1	jh8544w0u37g6ir4yzp2xldn8b5a	New Hires Guidelines.pdf	application/pdf	{"identified":true,"analyzed":true}	local	300361	fYnsz/GUfQwQklhu+2UiAw==	2025-08-21 08:30:45.108941
3	6oq9ups8x0ke70rjbf8mf1sioenn	Internal Development Processes.pdf	application/pdf	{"identified":true,"analyzed":true}	local	569077	IKfMupo/iX3aHposoOTh7g==	2025-08-21 10:44:37.65189
22	uqdskepfph1nflbsll458kzblq0a	ss1.png	image/png	{"identified":true,"analyzed":true}	local	127412	MTsxkt8Cds5PLLIEor/e6A==	2025-09-01 07:44:17.988065
8	4amwu99gacs5853yxrju67hlc6hq	ss3.png	image/png	{"identified":true,"analyzed":true}	local	1403339	cdttmyJvdYe7mLIIPsTXEQ==	2025-08-21 14:48:26.619514
25	clzwf2vbubar1r3asuf0gmbyox23	ss3.png	image/png	{"identified":true,"analyzed":true}	local	1403339	cdttmyJvdYe7mLIIPsTXEQ==	2025-09-01 09:12:17.060736
12	9xw8iuym75ee6f5vxfi5gq39hn24	ss2.png	image/png	{"identified":true,"analyzed":true}	local	431977	EBUnub9+7p+NTni3gYdYiw==	2025-08-22 08:03:31.194192
15	i1ekdxrnmons3x28lje6j9em146c	New Hires Guidelines.pdf	application/pdf	{"identified":true,"analyzed":true}	local	300361	fYnsz/GUfQwQklhu+2UiAw==	2025-08-27 15:05:24.734527
16	1msyypdv86bixnan8vkue4pj294j	ss2.png	image/png	{"identified":true,"analyzed":true}	local	431977	EBUnub9+7p+NTni3gYdYiw==	2025-08-28 09:21:24.403555
17	j7ai6dhv40cwxe45olx8uds2uuw1	ss2.png	image/png	{"identified":true,"analyzed":true}	local	431977	EBUnub9+7p+NTni3gYdYiw==	2025-08-28 11:00:56.059727
18	5qxw2jc9l1plkftb7k5mtgugd2r1	ss1.png	image/png	{"identified":true,"analyzed":true}	local	127412	MTsxkt8Cds5PLLIEor/e6A==	2025-08-28 11:07:34.456055
19	qgbp98umxrba0gtda8ql0xgho1f6	New Hires Guidelines.pdf	application/pdf	{"identified":true,"analyzed":true}	local	300361	fYnsz/GUfQwQklhu+2UiAw==	2025-08-28 16:31:22.642239
21	c1lcwqgvjt1m2eb5mbdkm732izew	ss3.png	image/png	{"identified":true,"analyzed":true}	local	1403339	cdttmyJvdYe7mLIIPsTXEQ==	2025-08-28 16:41:09.462653
27	oo7j06xn5zhoxnrbk8cc495ta1pv	New Hires Guidelines.pdf	application/pdf	{"identified":true,"analyzed":true}	local	300361	fYnsz/GUfQwQklhu+2UiAw==	2025-09-01 12:03:53.816668
\.


--
-- Data for Name: active_storage_variant_records; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.active_storage_variant_records (id, blob_id, variation_digest) FROM stdin;
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: mariasilaghi
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2025-07-28 15:20:15.194679	2025-07-28 15:20:15.194679
\.


--
-- Data for Name: attendances; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attendances (id, user_id, assignment_id, period_id, date, status, created_at, updated_at) FROM stdin;
1	5	6	3	2025-08-18	0	2025-08-19 14:08:29.932068	2025-08-19 14:08:29.932068
2	5	6	3	2025-08-11	0	2025-08-19 14:08:47.380255	2025-08-19 14:08:47.380255
3	8	6	3	2025-08-11	1	2025-08-19 14:09:14.898147	2025-08-19 14:09:14.898147
4	8	6	3	2025-08-18	0	2025-08-19 14:09:25.986209	2025-08-19 14:09:25.986209
6	8	6	3	2025-08-25	0	2025-08-19 14:27:19.89555	2025-08-19 14:27:19.89555
9	5	6	3	2025-08-25	1	2025-08-20 07:31:24.79003	2025-08-20 07:31:24.79003
11	11	19	1	2025-08-25	0	2025-08-20 10:59:14.995141	2025-08-20 10:59:14.995141
12	12	19	1	2025-08-25	0	2025-08-20 10:59:15.015963	2025-08-20 10:59:15.015963
13	11	19	2	2025-08-25	1	2025-08-20 11:00:25.644175	2025-08-20 11:00:25.644175
14	12	19	2	2025-08-25	1	2025-08-20 11:00:25.66431	2025-08-20 11:00:25.66431
16	16	9	4	2025-08-22	1	2025-08-20 11:13:33.116078	2025-08-20 12:38:25.476037
17	15	9	4	2025-08-22	1	2025-08-20 12:36:24.47387	2025-08-20 12:38:25.519781
15	10	9	4	2025-08-22	0	2025-08-20 11:12:50.263379	2025-08-20 12:38:44.453361
18	10	9	5	2025-08-22	0	2025-08-20 13:03:17.079181	2025-08-20 13:03:52.431434
20	15	9	5	2025-08-22	0	2025-08-20 13:03:52.476506	2025-08-20 13:03:52.476506
21	16	8	2	2025-08-26	1	2025-08-20 15:56:33.805746	2025-08-20 15:56:33.805746
22	16	8	3	2025-08-25	1	2025-08-20 15:56:51.753193	2025-08-20 15:56:51.753193
23	16	8	3	2025-09-01	0	2025-08-20 15:57:11.627302	2025-08-20 15:57:11.627302
24	16	8	2	2025-09-02	1	2025-08-20 15:57:25.173138	2025-08-20 15:57:25.173138
19	16	9	5	2025-08-22	1	2025-08-20 13:03:38.113382	2025-08-29 14:17:12.176728
25	10	9	4	2025-01-03	0	2025-08-29 14:17:55.191907	2025-08-29 14:17:55.191907
26	16	9	4	2025-01-03	0	2025-08-29 14:17:55.226191	2025-08-29 14:17:55.226191
27	15	9	4	2025-01-03	0	2025-08-29 14:17:55.250708	2025-08-29 14:17:55.250708
28	8	6	3	2025-07-07	0	2025-09-01 07:53:26.997262	2025-09-01 07:53:26.997262
29	5	6	3	2025-07-07	0	2025-09-01 07:53:27.029743	2025-09-01 07:53:27.029743
30	8	6	3	2025-06-16	1	2025-09-01 07:53:37.50736	2025-09-01 07:53:37.50736
31	5	6	3	2025-06-16	0	2025-09-01 07:53:37.528089	2025-09-01 07:53:37.528089
32	8	6	3	2025-07-14	1	2025-09-01 07:53:47.033728	2025-09-01 07:53:47.033728
33	5	6	3	2025-07-14	1	2025-09-01 07:53:47.053036	2025-09-01 07:53:47.053036
\.


--
-- Data for Name: grades; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.grades (id, value, student_id, teacher_id, subject_id, created_at, updated_at) FROM stdin;
12	8	5	3	3	2025-08-14 15:34:47.695443	2025-08-14 15:34:47.695443
13	10	8	3	3	2025-08-14 15:35:33.574607	2025-08-14 15:35:33.574607
14	9	16	3	3	2025-08-14 15:35:55.531335	2025-08-14 15:35:55.531335
11	6	5	3	3	2025-08-14 15:31:17.75893	2025-08-14 15:36:33.436553
15	9	13	3	2	2025-08-14 16:20:42.567635	2025-08-14 16:21:25.350203
17	9	10	7	3	2025-08-18 10:23:54.878973	2025-08-18 10:23:54.878973
18	7	10	7	3	2025-08-18 10:24:00.521799	2025-08-18 10:24:00.521799
19	8	15	7	3	2025-08-18 10:24:19.751931	2025-08-18 10:24:19.751931
21	6	16	7	3	2025-08-18 11:00:48.792977	2025-08-18 11:00:48.792977
22	3	10	7	3	2025-08-18 11:01:07.046478	2025-08-18 11:01:07.046478
24	6	12	7	6	2025-08-18 11:04:03.687327	2025-08-18 11:04:03.687327
25	8	12	7	6	2025-08-18 11:42:03.564419	2025-08-18 11:42:03.564419
27	1	15	7	4	2025-08-25 14:04:57.290703	2025-08-25 14:04:57.290703
28	10	10	7	4	2025-08-25 14:19:19.19948	2025-08-25 14:19:19.19948
29	10	10	7	4	2025-08-26 08:25:43.137342	2025-08-26 08:25:43.137342
30	7	15	7	4	2025-08-26 08:28:31.894966	2025-08-26 08:28:31.894966
32	4	16	7	4	2025-08-26 16:06:47.448109	2025-08-26 16:06:47.448109
33	10	16	7	4	2025-08-26 17:45:56.347773	2025-08-26 17:45:56.347773
34	1	16	6	10	2025-08-26 18:21:44.896591	2025-08-26 18:21:44.896591
35	1	16	6	10	2025-08-26 18:40:43.533771	2025-08-26 18:40:43.533771
36	4	16	6	10	2025-08-27 07:48:53.09704	2025-08-27 07:48:53.09704
37	10	16	7	3	2025-08-27 08:52:26.458043	2025-08-27 08:52:26.458043
38	4	16	7	3	2025-08-28 09:19:28.959345	2025-08-28 09:19:28.959345
31	10	16	7	4	2025-08-26 08:30:12.000764	2025-08-28 14:09:04.555036
20	9	16	7	3	2025-08-18 11:00:11.596199	2025-08-28 14:28:13.14565
39	9	16	7	3	2025-08-28 14:30:23.803704	2025-08-28 14:30:23.803704
40	10	16	7	4	2025-08-28 14:30:38.852686	2025-08-28 14:30:38.852686
41	6	16	7	4	2025-08-28 16:31:49.4447	2025-08-28 16:31:49.4447
43	4	11	7	6	2025-08-29 11:20:36.415958	2025-08-29 11:20:36.415958
44	5	16	7	4	2025-09-01 10:26:35.918819	2025-09-01 10:26:35.918819
\.


--
-- Data for Name: homework_submissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.homework_submissions (id, homework_id, student_id, created_at, updated_at, grade) FROM stdin;
3	4	16	2025-08-27 15:05:24.710733	2025-08-28 14:09:04.458903	10
4	7	16	2025-08-28 09:21:24.374161	2025-08-28 14:28:13.098365	9
5	3	16	2025-08-28 16:31:22.584574	2025-08-28 16:31:49.306937	6
7	11	16	2025-08-28 16:41:09.45357	2025-09-01 10:26:35.87392	5
9	12	16	2025-09-01 12:03:53.810489	2025-09-01 12:03:53.824533	\N
\.


--
-- Data for Name: homeworks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.homeworks (id, title, description, deadline, assignment_id, created_at, updated_at) FROM stdin;
1	Tema 1	aaa	2025-09-10	8	2025-08-27 09:46:49.032692	2025-08-27 09:46:49.032692
3	Tema 3	ccc	2025-09-10	9	2025-08-27 09:47:57.26414	2025-08-27 09:47:57.26414
4	aaa	aaa	2025-08-28	9	2025-08-27 10:52:44.114372	2025-08-27 10:52:44.114372
6	zzz	zzz	2025-08-10	9	2025-08-27 15:04:20.981211	2025-08-27 15:04:20.981211
7	bbb	bbb	2025-08-30	8	2025-08-28 07:48:06.761973	2025-08-28 07:48:06.761973
9	ccc	ccc	2025-08-20	8	2025-08-28 07:49:56.706126	2025-08-28 07:49:56.706126
10	dd	dd	2025-12-19	9	2025-08-28 16:35:08.693636	2025-08-28 16:35:08.693636
11	ee	ee	2025-08-14	9	2025-08-28 16:35:22.411361	2025-08-28 16:35:22.411361
12	sss	sss	2025-10-10	9	2025-09-01 07:22:31.854925	2025-09-01 07:22:31.854925
\.


--
-- Data for Name: learning_materials; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.learning_materials (id, title, description, assignment_id, created_at, updated_at) FROM stdin;
1	title1		8	2025-08-21 08:30:45.034904	2025-08-21 08:30:45.116385
3	title3		9	2025-08-21 10:44:37.601158	2025-08-21 10:44:37.663157
8	aaa	bbb	9	2025-08-21 14:48:26.608744	2025-08-21 14:48:26.627447
12	title2	aaa	8	2025-08-22 08:03:31.134907	2025-08-22 08:03:31.227959
13	v	v	9	2025-08-28 11:00:56.015533	2025-08-28 11:00:56.077744
14	zz	zz	9	2025-08-28 11:07:34.409546	2025-08-28 11:07:34.474933
15	a	a	9	2025-09-01 07:44:17.978243	2025-09-01 07:44:17.9947
18	aaa	aaa	8	2025-09-01 09:12:17.05769	2025-09-01 09:12:17.064302
\.


--
-- Data for Name: periods; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.periods (id, start_time, end_time, label, created_at, updated_at) FROM stdin;
1	08:00:00	08:50:00	08:00–08:50	2025-08-12 18:51:28.736687	2025-08-12 18:51:28.736687
2	09:00:00	09:50:00	09:00–09:50	2025-08-12 18:51:28.756958	2025-08-12 18:51:28.756958
3	10:00:00	10:50:00	10:00–10:50	2025-08-12 18:51:28.765015	2025-08-12 18:51:28.765015
4	11:00:00	11:50:00	11:00–11:50	2025-08-12 18:51:28.771398	2025-08-12 18:51:28.771398
5	12:00:00	12:50:00	12:00–12:50	2025-08-12 18:51:28.776238	2025-08-12 18:51:28.776238
6	13:00:00	13:50:00	13:00–13:50	2025-08-12 18:51:28.780886	2025-08-12 18:51:28.780886
\.


--
-- Data for Name: quiz_answers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quiz_answers (id, quiz_submission_id, quiz_question_id, selected_option_ids, created_at, updated_at) FROM stdin;
5	3	13	{26}	2025-08-25 14:04:57.256622	2025-08-25 14:04:57.256622
6	3	14	{27,28}	2025-08-25 14:04:57.263426	2025-08-25 14:04:57.263426
7	4	13	{25,26}	2025-08-25 14:19:19.172108	2025-08-25 14:19:19.172108
8	4	14	{27}	2025-08-25 14:19:19.177655	2025-08-25 14:19:19.177655
9	5	10	{21}	2025-08-26 08:25:43.08111	2025-08-26 08:25:43.08111
10	5	11	{22,23}	2025-08-26 08:25:43.092115	2025-08-26 08:25:43.092115
11	6	11	{22,23}	2025-08-26 08:28:31.868264	2025-08-26 08:28:31.868264
12	7	11	{23}	2025-08-26 08:30:11.979873	2025-08-26 08:30:11.979873
13	8	5	{12}	2025-08-26 16:06:47.406939	2025-08-26 16:06:47.406939
14	8	6	{14}	2025-08-26 16:06:47.419335	2025-08-26 16:06:47.419335
15	9	13	{25,26}	2025-08-26 17:45:56.15128	2025-08-26 17:45:56.15128
16	9	14	{27}	2025-08-26 17:45:56.172493	2025-08-26 17:45:56.172493
17	10	17	{33}	2025-08-26 18:21:44.866123	2025-08-26 18:21:44.866123
18	10	18	{35}	2025-08-26 18:21:44.87131	2025-08-26 18:21:44.87131
19	10	19	{37,38}	2025-08-26 18:21:44.873647	2025-08-26 18:21:44.873647
20	11	25	{49}	2025-08-26 18:40:43.514268	2025-08-26 18:40:43.514268
21	12	23	{45,46}	2025-08-27 07:48:53.029434	2025-08-27 07:48:53.029434
22	12	24	{47}	2025-08-27 07:48:53.043763	2025-08-27 07:48:53.043763
23	13	1	{1}	2025-08-27 08:52:26.4241	2025-08-27 08:52:26.4241
24	13	2	{5,7}	2025-08-27 08:52:26.435219	2025-08-27 08:52:26.435219
25	14	28	{56,57}	2025-08-28 09:19:28.920299	2025-08-28 09:19:28.920299
26	14	29	{58}	2025-08-28 09:19:28.929079	2025-08-28 09:19:28.929079
\.


--
-- Data for Name: quiz_options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quiz_options (id, quiz_question_id, text, is_correct, created_at, updated_at) FROM stdin;
1	1	rasp1	t	2025-08-22 13:29:36.678691	2025-08-22 13:29:36.678691
2	1	rasp2	f	2025-08-22 13:29:36.685816	2025-08-22 13:29:36.685816
3	1	rasp3	f	2025-08-22 13:29:36.690906	2025-08-22 13:29:36.690906
4	1	rasp4	f	2025-08-22 13:29:36.696024	2025-08-22 13:29:36.696024
5	2	rasp21	t	2025-08-22 13:29:36.706697	2025-08-22 13:29:36.706697
6	2	rasp22	f	2025-08-22 13:29:36.711642	2025-08-22 13:29:36.711642
7	2	rasp23	t	2025-08-22 13:29:36.717255	2025-08-22 13:29:36.717255
12	5	rasp1-q2	t	2025-08-22 13:45:12.643699	2025-08-22 13:45:12.643699
13	5	rasp2-q2	f	2025-08-22 13:45:12.647627	2025-08-22 13:45:12.647627
14	6	rasp21-q2	t	2025-08-22 13:45:12.658616	2025-08-22 13:45:12.658616
15	6	rasp22-q2	t	2025-08-22 13:45:12.682136	2025-08-22 13:45:12.682136
21	10	aa	t	2025-08-25 09:49:22.641334	2025-08-25 09:49:22.641334
22	11	bb	t	2025-08-25 09:49:22.669506	2025-08-25 09:49:22.669506
23	11	bb	t	2025-08-25 09:49:22.684341	2025-08-25 09:49:22.684341
25	13	b1	t	2025-08-25 10:17:00.831615	2025-08-25 10:17:00.831615
26	13	b2	t	2025-08-25 10:17:00.844785	2025-08-25 10:17:00.844785
27	14	bb1	t	2025-08-25 10:17:00.876054	2025-08-25 10:17:00.876054
28	14	bb2	f	2025-08-25 10:17:00.895372	2025-08-25 10:17:00.895372
33	17	c1	t	2025-08-26 18:15:47.027069	2025-08-26 18:15:47.027069
34	17	c2	t	2025-08-26 18:15:47.032379	2025-08-26 18:15:47.032379
35	18	cc1	t	2025-08-26 18:15:47.038239	2025-08-26 18:15:47.038239
36	18	cc2	t	2025-08-26 18:15:47.043212	2025-08-26 18:15:47.043212
37	19	ccc1	t	2025-08-26 18:15:47.051755	2025-08-26 18:15:47.051755
38	19	ccc2	f	2025-08-26 18:15:47.056428	2025-08-26 18:15:47.056428
39	20	c21	t	2025-08-26 18:17:35.914442	2025-08-26 18:17:35.914442
40	20	c22	t	2025-08-26 18:17:35.918053	2025-08-26 18:17:35.918053
41	21	cc21	t	2025-08-26 18:17:35.924162	2025-08-26 18:17:35.924162
42	21	cc22	t	2025-08-26 18:17:35.929029	2025-08-26 18:17:35.929029
43	22	ccc21	t	2025-08-26 18:17:35.935507	2025-08-26 18:17:35.935507
44	22	ccc22	f	2025-08-26 18:17:35.939311	2025-08-26 18:17:35.939311
45	23	d1	t	2025-08-26 18:19:06.921135	2025-08-26 18:19:06.921135
46	23	d2	t	2025-08-26 18:19:06.92542	2025-08-26 18:19:06.92542
47	24	dd1	t	2025-08-26 18:19:06.936183	2025-08-26 18:19:06.936183
48	24	dd2	t	2025-08-26 18:19:06.943836	2025-08-26 18:19:06.943836
49	25	e1	t	2025-08-26 18:40:18.597663	2025-08-26 18:40:18.597663
50	25	e2	t	2025-08-26 18:40:18.609383	2025-08-26 18:40:18.609383
51	26	ee1	t	2025-08-26 18:40:18.626013	2025-08-26 18:40:18.626013
52	26	ee2	t	2025-08-26 18:40:18.641123	2025-08-26 18:40:18.641123
53	27	32	f	2025-08-28 07:51:20.495509	2025-08-28 07:51:20.495509
54	27	23	f	2025-08-28 07:51:20.503166	2025-08-28 07:51:20.503166
55	27	434	t	2025-08-28 07:51:20.512746	2025-08-28 07:51:20.512746
56	28	a	t	2025-08-28 07:52:46.10182	2025-08-28 07:52:46.10182
57	28	a	t	2025-08-28 07:52:46.105996	2025-08-28 07:52:46.105996
58	29	b	t	2025-08-28 07:52:46.112966	2025-08-28 07:52:46.112966
59	29	b	t	2025-08-28 07:52:46.118232	2025-08-28 07:52:46.118232
60	30	c	t	2025-08-28 07:52:46.126298	2025-08-28 07:52:46.126298
61	30	c	t	2025-08-28 07:52:46.131559	2025-08-28 07:52:46.131559
62	31	4	t	2025-08-28 09:24:30.380806	2025-08-28 09:24:30.380806
64	33	q	t	2025-08-29 14:40:04.545458	2025-08-29 14:40:04.545458
65	34	qq	t	2025-08-29 14:45:07.667377	2025-08-29 14:45:07.667377
\.


--
-- Data for Name: quiz_questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quiz_questions (id, quiz_id, question_text, point_value, created_at, updated_at) FROM stdin;
1	1	Intrebarea1	3	2025-08-22 13:29:36.620308	2025-08-22 13:29:36.620308
2	1	Intrebarea2	6	2025-08-22 13:29:36.700306	2025-08-22 13:29:36.700306
5	3	Intrebarea1-q2	3	2025-08-22 13:45:12.637837	2025-08-22 13:45:12.637837
6	3	Intrebarea2-q2	6	2025-08-22 13:45:12.652609	2025-08-22 13:45:12.652609
10	6	aa	3	2025-08-25 09:49:22.612325	2025-08-25 09:49:22.612325
11	6	bb	6	2025-08-25 09:49:22.652577	2025-08-25 09:49:22.652577
13	8	b	5	2025-08-25 10:17:00.807182	2025-08-25 10:17:00.807182
14	8	bb	4	2025-08-25 10:17:00.853577	2025-08-25 10:17:00.853577
17	10	c?	3	2025-08-26 18:15:47.022046	2025-08-26 18:15:47.022046
18	10	cc?	3	2025-08-26 18:15:47.034612	2025-08-26 18:15:47.034612
19	10	ccc?	3	2025-08-26 18:15:47.047175	2025-08-26 18:15:47.047175
20	11	c2?	3	2025-08-26 18:17:35.881011	2025-08-26 18:17:35.881011
21	11	cc2?	3	2025-08-26 18:17:35.920425	2025-08-26 18:17:35.920425
22	11	ccc2?	3	2025-08-26 18:17:35.931751	2025-08-26 18:17:35.931751
23	12	d?	3	2025-08-26 18:19:06.917421	2025-08-26 18:19:06.917421
24	12	dd?	6	2025-08-26 18:19:06.929813	2025-08-26 18:19:06.929813
25	13	e?	3	2025-08-26 18:40:18.579002	2025-08-26 18:40:18.579002
26	13	dd?	6	2025-08-26 18:40:18.614949	2025-08-26 18:40:18.614949
27	14	vgg	9	2025-08-28 07:51:20.487181	2025-08-28 07:51:20.487181
28	15	aa	3	2025-08-28 07:52:46.096221	2025-08-28 07:52:46.096221
29	15	bb	3	2025-08-28 07:52:46.107955	2025-08-28 07:52:46.107955
30	15	cc	3	2025-08-28 07:52:46.121713	2025-08-28 07:52:46.121713
31	16	aa	9	2025-08-28 09:24:30.357494	2025-08-28 09:24:30.357494
33	18	q	9	2025-08-29 14:40:04.53596	2025-08-29 14:40:04.53596
34	19	qq	9	2025-08-29 14:45:07.655211	2025-08-29 14:45:07.655211
\.


--
-- Data for Name: quiz_submissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quiz_submissions (id, quiz_id, student_id, submitted_at, raw_score, final_score, created_at, updated_at) FROM stdin;
3	8	15	2025-08-25 14:04:57.235038	1	1	2025-08-25 14:04:57.251921	2025-08-25 14:04:57.251921
4	8	10	2025-08-25 14:19:19.153659	10	10	2025-08-25 14:19:19.160816	2025-08-25 14:19:19.160816
5	6	10	2025-08-26 08:25:43.04364	10	10	2025-08-26 08:25:43.057082	2025-08-26 08:25:43.057082
6	6	15	2025-08-26 08:28:31.851185	7	7	2025-08-26 08:28:31.857324	2025-08-26 08:28:31.857324
7	6	16	2025-08-26 08:30:11.958571	1	1	2025-08-26 08:30:11.961571	2025-08-26 08:30:11.961571
8	3	16	2025-08-26 16:06:47.091208	4	4	2025-08-26 16:06:47.357877	2025-08-26 16:06:47.357877
9	8	16	2025-08-26 17:45:55.782971	10	10	2025-08-26 17:45:56.111716	2025-08-26 17:45:56.111716
10	10	16	2025-08-26 18:21:44.794166	1	1	2025-08-26 18:21:44.851133	2025-08-26 18:21:44.851133
11	13	16	2025-08-26 18:40:43.503174	1	1	2025-08-26 18:40:43.505434	2025-08-26 18:40:43.505434
12	12	16	2025-08-27 07:48:52.928933	4	4	2025-08-27 07:48:52.97128	2025-08-27 07:48:52.97128
13	1	16	2025-08-27 08:52:26.384706	10	10	2025-08-27 08:52:26.393136	2025-08-27 08:52:26.393136
14	15	16	2025-08-28 09:19:28.709574	4	4	2025-08-28 09:19:28.886337	2025-08-28 09:19:28.886337
\.


--
-- Data for Name: quizzes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quizzes (id, title, description, deadline, time_limit, assignment_id, created_at, updated_at) FROM stdin;
1	Test1	Description1	2025-09-01 23:59:00	10	8	2025-08-22 13:29:36.574026	2025-08-22 13:29:36.574026
3	Test1	Description2	2025-09-01 23:59:00	10	9	2025-08-22 13:45:12.629623	2025-08-22 13:45:12.629623
6	aa	aa	2025-08-26 12:48:00	3	9	2025-08-25 09:49:22.485133	2025-08-25 09:49:22.485133
8	B	B	2025-08-28 18:15:00	20	9	2025-08-25 10:17:00.764751	2025-08-25 10:17:00.764751
10	C	C	2025-09-01 23:59:00	10	23	2025-08-26 18:15:47.01732	2025-08-26 18:15:47.01732
11	C2	C2	2025-08-26 18:18:00	15	23	2025-08-26 18:17:35.875702	2025-08-26 18:17:35.875702
12	D	D	2025-09-01 23:59:00	1	23	2025-08-26 18:19:06.913695	2025-08-26 18:19:06.913695
13	E	E	2025-09-01 23:59:00	1	23	2025-08-26 18:40:18.535943	2025-08-26 18:40:18.535943
14	aa	aaa	2025-08-26 10:50:00	20	8	2025-08-28 07:51:20.468369	2025-08-28 07:51:20.468369
15	bb	bb	2025-11-06 10:00:00	1	8	2025-08-28 07:52:46.088852	2025-08-28 07:52:46.088852
16	sss	ss	2025-08-30 12:24:00	1	8	2025-08-28 09:24:30.332091	2025-08-28 09:24:30.332091
18	q	q	2025-05-19 17:00:00	9	8	2025-08-29 14:40:04.521887	2025-08-29 14:40:04.521887
19	qq	qq	2025-11-06 17:30:00	10	8	2025-08-29 14:45:07.642415	2025-08-29 14:45:07.642415
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: mariasilaghi
--

COPY public.schema_migrations (version) FROM stdin;
20250728130837
20250728184515
20250729130417
20250729131028
20250730142120
20250804153757
20250805073855
20250806091331
20250806182607
20250806194147
20250807082616
20250807083454
20250811064047
20250812120519
20250812121549
20250814133618
20250819132810
20250820081453
20250821075337
20250821080153
20250822104312
20250822104511
20250822104630
20250822105631
20250822110810
20250827090912
20250827112300
20250827120357
20250902080025
\.


--
-- Data for Name: school_class_archives; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.school_class_archives (id, school_class_id, label, archived_at, data, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: school_class_subjects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.school_class_subjects (id, school_class_id, subject_id, created_at, updated_at, teacher_id) FROM stdin;
2	1	3	2025-08-07 11:13:28.416402	2025-08-07 11:13:28.416402	\N
10	2	2	2025-08-11 08:34:44.936479	2025-08-11 09:10:09.991722	3
9	7	4	2025-08-08 10:34:25.84196	2025-08-11 09:43:16.03901	7
11	16	2	2025-08-11 10:12:53.681169	2025-08-11 10:12:53.681169	\N
12	16	6	2025-08-11 10:12:54.621667	2025-08-11 10:12:54.621667	\N
6	13	3	2025-08-07 15:19:25.886097	2025-08-11 11:06:16.060368	3
7	13	2	2025-08-08 10:34:08.996538	2025-08-11 11:06:23.812823	6
8	7	3	2025-08-08 10:34:24.741032	2025-08-11 11:07:17.299579	7
15	9	2	2025-08-11 11:09:19.647452	2025-08-11 11:09:22.994324	9
18	9	3	2025-08-13 10:44:59.081805	2025-08-13 10:44:59.081805	\N
19	9	6	2025-08-13 10:45:02.975477	2025-08-13 10:45:07.666159	7
1	1	2	2025-08-07 08:45:56.492475	2025-08-13 11:14:46.848801	9
20	1	10	2025-08-13 12:35:32.616578	2025-08-13 12:35:35.144892	6
21	2	10	2025-08-13 12:35:42.696491	2025-08-13 12:35:45.39129	6
17	13	4	2025-08-11 11:29:06.037525	2025-08-18 12:55:02.024375	17
22	18	9	2025-08-19 11:07:59.177391	2025-08-19 11:08:12.970399	17
23	7	10	2025-08-21 09:06:55.777683	2025-08-21 09:07:17.218244	6
\.


--
-- Data for Name: school_classes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.school_classes (id, name, created_at, updated_at) FROM stdin;
2	9A	2025-08-05 08:56:27.218465	2025-08-05 08:56:27.218465
1	10D	2025-08-05 08:56:02.299764	2025-08-05 12:41:23.777958
9	10A	2025-08-05 15:52:06.65154	2025-08-05 15:52:06.65154
16	8A	2025-08-07 09:03:29.250582	2025-08-07 09:03:29.250582
13	1A	2025-08-06 12:09:02.06774	2025-08-08 10:34:13.686477
7	1B	2025-08-05 12:26:53.202314	2025-08-08 10:34:44.187975
18	1C	2025-08-18 12:13:41.465288	2025-08-18 12:13:41.465288
\.


--
-- Data for Name: subjects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subjects (id, name, created_at, updated_at) FROM stdin;
2	Math	2025-08-06 18:43:18.653121	2025-08-06 18:43:18.653121
3	History	2025-08-06 18:44:00.222425	2025-08-06 18:44:00.222425
4	Geography	2025-08-06 18:44:11.321184	2025-08-06 18:44:11.321184
5	Biology	2025-08-06 18:44:19.587239	2025-08-06 18:44:19.587239
6	Physics	2025-08-06 18:44:27.461962	2025-08-06 18:44:27.461962
8	Computer Science	2025-08-06 20:10:57.10326	2025-08-06 20:10:57.10326
9	Chemistry	2025-08-07 07:32:04.936536	2025-08-07 07:32:04.936536
10	English	2025-08-07 07:34:01.911748	2025-08-07 07:34:01.911748
\.


--
-- Data for Name: timetable_entries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.timetable_entries (id, assignment_id, weekday, period_id, created_at, updated_at) FROM stdin;
1	6	1	3	2025-08-12 19:15:30.858796	2025-08-12 19:15:30.858796
3	8	1	3	2025-08-12 20:00:06.118733	2025-08-12 20:00:06.118733
4	15	1	3	2025-08-12 20:00:48.003642	2025-08-12 20:00:48.003642
5	15	1	4	2025-08-12 20:00:59.573218	2025-08-12 20:00:59.573218
6	15	2	1	2025-08-12 20:01:08.829336	2025-08-12 20:01:08.829336
7	15	3	2	2025-08-12 20:01:14.928064	2025-08-12 20:01:14.928064
9	19	1	2	2025-08-13 10:57:06.377731	2025-08-13 10:57:06.377731
10	1	1	2	2025-08-13 11:15:19.130036	2025-08-13 11:15:19.130036
11	20	1	1	2025-08-13 12:36:23.394867	2025-08-13 12:36:23.394867
12	20	4	4	2025-08-13 12:36:26.769348	2025-08-13 12:36:26.769348
14	21	1	3	2025-08-13 14:30:33.181689	2025-08-13 14:30:33.181689
15	21	3	2	2025-08-13 14:30:36.126581	2025-08-13 14:30:36.126581
16	1	2	4	2025-08-13 14:41:17.30914	2025-08-13 14:41:17.30914
17	9	5	5	2025-08-14 11:06:18.030334	2025-08-14 11:06:18.030334
18	17	5	1	2025-08-18 12:55:14.684006	2025-08-18 12:55:14.684006
19	8	2	2	2025-08-20 09:26:25.109643	2025-08-20 09:26:25.109643
20	19	1	1	2025-08-20 10:56:57.406447	2025-08-20 10:56:57.406447
21	9	5	4	2025-08-20 11:11:57.317283	2025-08-20 11:11:57.317283
22	23	1	2	2025-08-21 09:07:32.239313	2025-08-21 09:07:32.239313
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: mariasilaghi
--

COPY public.users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, name, role, created_at, updated_at, jti, school_class_id) FROM stdin;
3	teacher1@example.com	$2a$12$.PnUPNW8csYR.AuUbXtETefCb4y9UfBvicDk.nxGeSkZkmIpOhFf.	\N	\N	\N	Prenume1 Nume1	teacher	2025-07-28 19:06:36.611956	2025-07-28 19:06:36.611956	6df41cb8-1863-4ef1-aa38-787bb2822cd9	\N
6	teacher2@example.com	$2a$12$gUFR7mboEpkj/QB/rM50PuD1Mpsm3FZPRZwgH/2Fyp6hqhAswJUj2	\N	\N	\N	Prenume2 Nume2	teacher	2025-07-31 10:59:25.431606	2025-07-31 10:59:25.431606	84767bee-957a-411c-bf31-25685ec0915c	\N
7	teacher3@example.com	$2a$12$Er/gmT8nldMdzIWAgnTXO.IFLXS4BBuUCiYWKVanR5kQjWj8MHVMS	\N	\N	\N	Prenume3 Nume3	teacher	2025-07-31 12:31:26.962747	2025-07-31 12:31:26.962747	33e0471e-0c38-4a26-b53b-7ac27383b871	\N
9	teacher4@example.com	$2a$12$ZkYnUe4MUUe3dBAx3.HjreMF43l59vXEXHO1h6mdahLPs8eKoiYem	\N	\N	\N	Prenume4 Nume4	teacher	2025-07-31 13:15:37.283243	2025-07-31 13:15:37.283243	6f1b8a26-bf33-443c-8d03-2dce7fe5c6bd	\N
12	student6@example.com	$2a$12$8BKgevrdrQJQMQqpp8ySjOEJPAkM/nsOYQIZtHotrW56tD6mTydiK	\N	\N	\N	Prenume6 Nume6	student	2025-08-06 12:04:03.119397	2025-08-12 08:35:45.821353	54d7514e-adfa-47c4-8b1d-7e6a58937673	9
10	a@a.a	$2a$12$XbdZqI/Bwnl6lqwzM6FKDeaXzeu5opKCZpIb9dPFTDzwsYZJFOfyy	\N	\N	\N	a	student	2025-08-04 09:50:36.694199	2025-08-18 08:12:31.211694	2c0f94af-f1c9-4d4d-9063-b76129a9957f	7
4	student2@example.com	$2a$12$XzwVy0q1nSo72Qm4KTN/R.rcGMe65gGDBGtM2P2Ktxk0LjSbSsgZK	\N	\N	\N	Prenume2 Nume2	student	2025-07-31 08:42:59.707431	2025-08-05 12:07:21.681958	e495d043-2857-457a-92e8-5d53c6c99932	1
16	a@aa.a	$2a$12$1wkWgjqx0nClKXArZPZDG.as3SeAdKH/oTJoWWk8qQWAX2IIg3QZW	\N	\N	\N	A A 	student	2025-08-08 10:33:47.49855	2025-08-18 08:12:32.213328	6193ddf6-0893-4d2a-a1bf-c3eff22c6572	7
15	aaa@a.a	$2a$12$EwOvquhz8cWXXbKzqhKMkekUdG4MebSvknp0c1egSH5Wenh3Tc6aO	\N	\N	\N	aaa	student	2025-08-07 09:07:47.336773	2025-08-18 08:12:33.145593	8db25569-2fa1-4b9d-9f78-a98db5d6e14a	7
14	student8@example.com	$2a$12$Ad5F0bEr9IG2IulvWYuVz.75r2imS0Oq.788Tgo1YTBDTY/8IEUqa	\N	\N	\N	Prenume8 Nume8	student	2025-08-06 12:04:20.952294	2025-08-18 09:50:21.101444	4e7ec449-8710-4713-88ae-7091a0c0bcd0	2
17	teacher5@example.com	$2a$12$o8Eqxq9hW6.Ksjlk9f0vVe0hrgW4s799740KpurM3LmkzEnWWABeS	\N	\N	\N	Prenume5 Nume5	teacher	2025-08-18 12:50:06.644555	2025-08-18 12:50:06.644555	b0d86b5a-4d46-4666-879b-eae48cb262a5	\N
18	student9@example.com	$2a$12$pCCxXXrG9WNP2fNLm/WQUulVo8Slw5ee43rW2U2kPxHjUtqgmARle	\N	\N	\N	Prenume9 Nume9	student	2025-08-19 10:00:35.779839	2025-08-19 10:00:35.779839	b78062e9-28e1-4c2f-9e5a-7ff3453eb866	\N
19	student10@example.com	$2a$12$hjfgFJ9XPMeFccJDU7BbA.KO0kITRG2/A4W0Tq6iy5y/hbknp7S6q	\N	\N	\N	Prenume10 Nume10	student	2025-08-19 10:01:05.582109	2025-08-19 10:01:05.582109	86402041-2e8f-4efe-8f9a-1e94678a31a6	\N
20	student11@example.com	$2a$12$ueIvHbHyw5HxIQG1jvesKuckhqGMxT4xbvDKgduNY7Ygsrs2U5YQa	\N	\N	\N	Prenume11 Nume11	student	2025-08-19 10:01:24.345908	2025-08-19 10:01:24.345908	ba02bf57-3f51-4372-a8c7-2dd09105eb41	\N
21	student12@example.com	$2a$12$cxm7VTPpF.1xlHBYAqoksOGnm0pnY3IXYrZSPdYazG30BOIMiEUIi	\N	\N	\N	Prenume11 Nume11	student	2025-08-19 10:01:49.192424	2025-08-19 10:01:49.192424	65573742-937a-4d6c-a12f-6d7ea134248e	\N
22	student14@example.com	$2a$12$EEA/MC34jQi4sKIBiKEyj.jerIirzukgy5esHz4RXD46McCP00Fae	\N	\N	\N	Prenume14 Nume14	student	2025-08-19 10:02:08.650343	2025-08-19 10:02:08.650343	6c582635-8ce2-4c02-a4ca-75e6528350a1	\N
11	student5@example.com	$2a$12$/0CgG4g7gwgtbLkitiZ1seOtKXi53D3PT.kMNuRZwDLRA0uVzGCL.	\N	\N	\N	Prenume5 Nume5	student	2025-08-06 12:03:53.12276	2025-08-20 10:57:50.956403	9a91a048-94a1-4c86-8c68-a5bf542e1f5e	9
13	student7@example.com	$2a$12$L7N3t1Ktx/rQ7hsO7ub3Z.ff5nxwU5cUFgU/2fPGTBjMKGcKKVMkS	\N	\N	\N	Prenume7 Nume7	student	2025-08-06 12:04:12.217268	2025-08-20 10:58:01.80251	085f09b3-de28-403d-a882-8e7e64253447	\N
1	smaria.oana@yahoo.com	$2a$12$fpoFzh2oyPsqOXNvpB8ojexPsAC6qTS72/K.1IymhBkh.RWtY/iXK	\N	\N	\N	Maria Silaghi	admin	2025-07-28 15:31:09.465123	2025-08-05 16:47:42.663066	bd6273c5-192b-4b4d-9854-6322390e97eb	\N
8	student4@example.com	$2a$12$z8Zn21OOQXo5utB3d6q1PeyhRAmK/SpijkECBllrovB5No39fJiwG	\N	\N	\N	Prenume4 Nume4	student	2025-07-31 13:11:36.729745	2025-08-06 12:09:02.137573	33d8d76e-6e57-43c4-998d-d9ffd75a51c8	13
5	student3@example.com	$2a$12$TwjSaej5hnj/czgAntejZ.R26MdVgMTfaHwQfEkYyVO5HOQ3HPV2S	\N	\N	\N	Prenume3 Nume3	student	2025-07-31 08:45:11.176603	2025-08-06 12:09:02.144089	e8e93875-3336-44a6-8653-a170613e2350	13
2	student1@example.com	$2a$12$Asbb7OtC90okR/k.9/OACu5JYX0Mh9z.3XWvIx7EvdFGpx59YaQeS	\N	\N	\N	Prenume1 Nume1	student	2025-07-28 16:11:58.352782	2025-08-06 12:22:14.77476	abf3e309-44c0-4de2-a8c9-785f3dfec2e6	1
\.


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_storage_attachments_id_seq', 27, true);


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_storage_blobs_id_seq', 27, true);


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_storage_variant_records_id_seq', 1, false);


--
-- Name: attendances_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.attendances_id_seq', 33, true);


--
-- Name: grades_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.grades_id_seq', 44, true);


--
-- Name: homework_submissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.homework_submissions_id_seq', 9, true);


--
-- Name: homeworks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.homeworks_id_seq', 12, true);


--
-- Name: learning_materials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.learning_materials_id_seq', 18, true);


--
-- Name: periods_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.periods_id_seq', 6, true);


--
-- Name: quiz_answers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quiz_answers_id_seq', 26, true);


--
-- Name: quiz_options_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quiz_options_id_seq', 65, true);


--
-- Name: quiz_questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quiz_questions_id_seq', 34, true);


--
-- Name: quiz_submissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quiz_submissions_id_seq', 14, true);


--
-- Name: quizzes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quizzes_id_seq', 19, true);


--
-- Name: school_class_archives_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.school_class_archives_id_seq', 1, false);


--
-- Name: school_class_subjects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.school_class_subjects_id_seq', 23, true);


--
-- Name: school_classes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.school_classes_id_seq', 18, true);


--
-- Name: subjects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subjects_id_seq', 11, true);


--
-- Name: timetable_entries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.timetable_entries_id_seq', 22, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mariasilaghi
--

SELECT pg_catalog.setval('public.users_id_seq', 22, true);


--
-- Name: active_storage_attachments active_storage_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_pkey PRIMARY KEY (id);


--
-- Name: active_storage_blobs active_storage_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT active_storage_blobs_pkey PRIMARY KEY (id);


--
-- Name: active_storage_variant_records active_storage_variant_records_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT active_storage_variant_records_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: mariasilaghi
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: attendances attendances_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendances
    ADD CONSTRAINT attendances_pkey PRIMARY KEY (id);


--
-- Name: grades grades_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_pkey PRIMARY KEY (id);


--
-- Name: homework_submissions homework_submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.homework_submissions
    ADD CONSTRAINT homework_submissions_pkey PRIMARY KEY (id);


--
-- Name: homeworks homeworks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.homeworks
    ADD CONSTRAINT homeworks_pkey PRIMARY KEY (id);


--
-- Name: learning_materials learning_materials_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.learning_materials
    ADD CONSTRAINT learning_materials_pkey PRIMARY KEY (id);


--
-- Name: periods periods_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.periods
    ADD CONSTRAINT periods_pkey PRIMARY KEY (id);


--
-- Name: quiz_answers quiz_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_answers
    ADD CONSTRAINT quiz_answers_pkey PRIMARY KEY (id);


--
-- Name: quiz_options quiz_options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_options
    ADD CONSTRAINT quiz_options_pkey PRIMARY KEY (id);


--
-- Name: quiz_questions quiz_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_questions
    ADD CONSTRAINT quiz_questions_pkey PRIMARY KEY (id);


--
-- Name: quiz_submissions quiz_submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_submissions
    ADD CONSTRAINT quiz_submissions_pkey PRIMARY KEY (id);


--
-- Name: quizzes quizzes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quizzes
    ADD CONSTRAINT quizzes_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: mariasilaghi
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: school_class_archives school_class_archives_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.school_class_archives
    ADD CONSTRAINT school_class_archives_pkey PRIMARY KEY (id);


--
-- Name: school_class_subjects school_class_subjects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.school_class_subjects
    ADD CONSTRAINT school_class_subjects_pkey PRIMARY KEY (id);


--
-- Name: school_classes school_classes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.school_classes
    ADD CONSTRAINT school_classes_pkey PRIMARY KEY (id);


--
-- Name: subjects subjects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subjects
    ADD CONSTRAINT subjects_pkey PRIMARY KEY (id);


--
-- Name: timetable_entries timetable_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timetable_entries
    ADD CONSTRAINT timetable_entries_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: mariasilaghi
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_periods_unique_range; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_periods_unique_range ON public.periods USING btree (start_time, end_time);


--
-- Name: idx_timetable_day_period; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_timetable_day_period ON public.timetable_entries USING btree (weekday, period_id);


--
-- Name: idx_unique_assignment_day_period; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_unique_assignment_day_period ON public.timetable_entries USING btree (assignment_id, weekday, period_id);


--
-- Name: idx_unique_class_subject; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_unique_class_subject ON public.school_class_subjects USING btree (school_class_id, subject_id);


--
-- Name: index_active_storage_attachments_on_blob_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_active_storage_attachments_on_blob_id ON public.active_storage_attachments USING btree (blob_id);


--
-- Name: index_active_storage_attachments_uniqueness; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_active_storage_attachments_uniqueness ON public.active_storage_attachments USING btree (record_type, record_id, name, blob_id);


--
-- Name: index_active_storage_blobs_on_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_key ON public.active_storage_blobs USING btree (key);


--
-- Name: index_active_storage_variant_records_uniqueness; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_active_storage_variant_records_uniqueness ON public.active_storage_variant_records USING btree (blob_id, variation_digest);


--
-- Name: index_attendances_on_assignment_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_attendances_on_assignment_id ON public.attendances USING btree (assignment_id);


--
-- Name: index_attendances_on_period_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_attendances_on_period_id ON public.attendances USING btree (period_id);


--
-- Name: index_attendances_on_unique_columns; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_attendances_on_unique_columns ON public.attendances USING btree (user_id, assignment_id, period_id, date);


--
-- Name: index_attendances_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_attendances_on_user_id ON public.attendances USING btree (user_id);


--
-- Name: index_grades_on_student_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_grades_on_student_id ON public.grades USING btree (student_id);


--
-- Name: index_grades_on_subject_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_grades_on_subject_id ON public.grades USING btree (subject_id);


--
-- Name: index_grades_on_teacher_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_grades_on_teacher_id ON public.grades USING btree (teacher_id);


--
-- Name: index_homework_submissions_on_homework_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_homework_submissions_on_homework_id ON public.homework_submissions USING btree (homework_id);


--
-- Name: index_homework_submissions_on_homework_id_and_student_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_homework_submissions_on_homework_id_and_student_id ON public.homework_submissions USING btree (homework_id, student_id);


--
-- Name: index_homework_submissions_on_student_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_homework_submissions_on_student_id ON public.homework_submissions USING btree (student_id);


--
-- Name: index_homeworks_on_assignment_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_homeworks_on_assignment_id ON public.homeworks USING btree (assignment_id);


--
-- Name: index_learning_materials_on_assignment_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_learning_materials_on_assignment_id ON public.learning_materials USING btree (assignment_id);


--
-- Name: index_quiz_answers_on_quiz_question_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_quiz_answers_on_quiz_question_id ON public.quiz_answers USING btree (quiz_question_id);


--
-- Name: index_quiz_answers_on_quiz_submission_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_quiz_answers_on_quiz_submission_id ON public.quiz_answers USING btree (quiz_submission_id);


--
-- Name: index_quiz_options_on_quiz_question_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_quiz_options_on_quiz_question_id ON public.quiz_options USING btree (quiz_question_id);


--
-- Name: index_quiz_questions_on_quiz_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_quiz_questions_on_quiz_id ON public.quiz_questions USING btree (quiz_id);


--
-- Name: index_quiz_submissions_on_quiz_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_quiz_submissions_on_quiz_id ON public.quiz_submissions USING btree (quiz_id);


--
-- Name: index_quiz_submissions_on_student_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_quiz_submissions_on_student_id ON public.quiz_submissions USING btree (student_id);


--
-- Name: index_quizzes_on_assignment_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_quizzes_on_assignment_id ON public.quizzes USING btree (assignment_id);


--
-- Name: index_school_class_archives_on_school_class_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_school_class_archives_on_school_class_id ON public.school_class_archives USING btree (school_class_id);


--
-- Name: index_school_class_archives_on_school_class_id_and_label; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_school_class_archives_on_school_class_id_and_label ON public.school_class_archives USING btree (school_class_id, label);


--
-- Name: index_school_class_subjects_on_school_class_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_school_class_subjects_on_school_class_id ON public.school_class_subjects USING btree (school_class_id);


--
-- Name: index_school_class_subjects_on_subject_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_school_class_subjects_on_subject_id ON public.school_class_subjects USING btree (subject_id);


--
-- Name: index_school_class_subjects_on_teacher_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_school_class_subjects_on_teacher_id ON public.school_class_subjects USING btree (teacher_id);


--
-- Name: index_school_classes_on_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_school_classes_on_name ON public.school_classes USING btree (name);


--
-- Name: index_subjects_on_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_subjects_on_name ON public.subjects USING btree (name);


--
-- Name: index_timetable_entries_on_assignment_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_timetable_entries_on_assignment_id ON public.timetable_entries USING btree (assignment_id);


--
-- Name: index_timetable_entries_on_period_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_timetable_entries_on_period_id ON public.timetable_entries USING btree (period_id);


--
-- Name: index_unique_class_subject; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_unique_class_subject ON public.school_class_subjects USING btree (school_class_id, subject_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: mariasilaghi
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_jti; Type: INDEX; Schema: public; Owner: mariasilaghi
--

CREATE UNIQUE INDEX index_users_on_jti ON public.users USING btree (jti);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: mariasilaghi
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_users_on_school_class_id; Type: INDEX; Schema: public; Owner: mariasilaghi
--

CREATE INDEX index_users_on_school_class_id ON public.users USING btree (school_class_id);


--
-- Name: school_class_subjects fk_rails_0010e394e3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.school_class_subjects
    ADD CONSTRAINT fk_rails_0010e394e3 FOREIGN KEY (school_class_id) REFERENCES public.school_classes(id);


--
-- Name: grades fk_rails_07b671bb47; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT fk_rails_07b671bb47 FOREIGN KEY (subject_id) REFERENCES public.subjects(id);


--
-- Name: attendances fk_rails_0808c35c2f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendances
    ADD CONSTRAINT fk_rails_0808c35c2f FOREIGN KEY (period_id) REFERENCES public.periods(id);


--
-- Name: homeworks fk_rails_0f4c15b663; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.homeworks
    ADD CONSTRAINT fk_rails_0f4c15b663 FOREIGN KEY (assignment_id) REFERENCES public.school_class_subjects(id);


--
-- Name: grades fk_rails_18b280df22; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT fk_rails_18b280df22 FOREIGN KEY (student_id) REFERENCES public.users(id);


--
-- Name: homework_submissions fk_rails_1954c411ec; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.homework_submissions
    ADD CONSTRAINT fk_rails_1954c411ec FOREIGN KEY (homework_id) REFERENCES public.homeworks(id);


--
-- Name: quiz_answers fk_rails_1c975560c5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_answers
    ADD CONSTRAINT fk_rails_1c975560c5 FOREIGN KEY (quiz_question_id) REFERENCES public.quiz_questions(id);


--
-- Name: timetable_entries fk_rails_26cb19b981; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timetable_entries
    ADD CONSTRAINT fk_rails_26cb19b981 FOREIGN KEY (assignment_id) REFERENCES public.school_class_subjects(id);


--
-- Name: timetable_entries fk_rails_3ce11f6331; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timetable_entries
    ADD CONSTRAINT fk_rails_3ce11f6331 FOREIGN KEY (period_id) REFERENCES public.periods(id);


--
-- Name: quiz_submissions fk_rails_473863d022; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_submissions
    ADD CONSTRAINT fk_rails_473863d022 FOREIGN KEY (quiz_id) REFERENCES public.quizzes(id);


--
-- Name: attendances fk_rails_47a6ab3924; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendances
    ADD CONSTRAINT fk_rails_47a6ab3924 FOREIGN KEY (assignment_id) REFERENCES public.school_class_subjects(id);


--
-- Name: school_class_subjects fk_rails_4caf177f78; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.school_class_subjects
    ADD CONSTRAINT fk_rails_4caf177f78 FOREIGN KEY (subject_id) REFERENCES public.subjects(id);


--
-- Name: school_class_subjects fk_rails_52a0c20a70; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.school_class_subjects
    ADD CONSTRAINT fk_rails_52a0c20a70 FOREIGN KEY (teacher_id) REFERENCES public.users(id);


--
-- Name: grades fk_rails_5920ec935f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT fk_rails_5920ec935f FOREIGN KEY (teacher_id) REFERENCES public.users(id);


--
-- Name: learning_materials fk_rails_716d14207e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.learning_materials
    ADD CONSTRAINT fk_rails_716d14207e FOREIGN KEY (assignment_id) REFERENCES public.school_class_subjects(id);


--
-- Name: attendances fk_rails_77ad02f5c5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendances
    ADD CONSTRAINT fk_rails_77ad02f5c5 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: quiz_options fk_rails_8b95d49b12; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_options
    ADD CONSTRAINT fk_rails_8b95d49b12 FOREIGN KEY (quiz_question_id) REFERENCES public.quiz_questions(id);


--
-- Name: quiz_submissions fk_rails_8fb6c3fcd4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_submissions
    ADD CONSTRAINT fk_rails_8fb6c3fcd4 FOREIGN KEY (student_id) REFERENCES public.users(id);


--
-- Name: active_storage_variant_records fk_rails_993965df05; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT fk_rails_993965df05 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: quizzes fk_rails_9f9beaf05c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quizzes
    ADD CONSTRAINT fk_rails_9f9beaf05c FOREIGN KEY (assignment_id) REFERENCES public.school_class_subjects(id);


--
-- Name: active_storage_attachments fk_rails_c3b3935057; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT fk_rails_c3b3935057 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: homework_submissions fk_rails_c4e9aea156; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.homework_submissions
    ADD CONSTRAINT fk_rails_c4e9aea156 FOREIGN KEY (student_id) REFERENCES public.users(id);


--
-- Name: quiz_questions fk_rails_c723d3feef; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_questions
    ADD CONSTRAINT fk_rails_c723d3feef FOREIGN KEY (quiz_id) REFERENCES public.quizzes(id);


--
-- Name: users fk_rails_cd47c15ffb; Type: FK CONSTRAINT; Schema: public; Owner: mariasilaghi
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_rails_cd47c15ffb FOREIGN KEY (school_class_id) REFERENCES public.school_classes(id);


--
-- Name: quiz_answers fk_rails_dc063f783f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_answers
    ADD CONSTRAINT fk_rails_dc063f783f FOREIGN KEY (quiz_submission_id) REFERENCES public.quiz_submissions(id);


--
-- Name: school_class_archives fk_rails_f90a9cb7f9; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.school_class_archives
    ADD CONSTRAINT fk_rails_f90a9cb7f9 FOREIGN KEY (school_class_id) REFERENCES public.school_classes(id);


--
-- PostgreSQL database dump complete
--

