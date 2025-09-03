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
    updated_at timestamp(6) without time zone NOT NULL,
    archived boolean DEFAULT false
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
    school_class_id bigint,
    graduated boolean DEFAULT false
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
28	file	LearningMaterial	19	28	2025-09-02 10:06:57.439724
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
28	7fe93mxi8657pga6tk98e7sxedow	1B_Report.pdf	application/pdf	{"identified":true,"analyzed":true}	local	24328	YbssLhDaBC/VQTWnMGc0Eg==	2025-09-02 10:06:57.431386
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
\.


--
-- Data for Name: grades; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.grades (id, value, student_id, teacher_id, subject_id, created_at, updated_at) FROM stdin;
15	9	13	3	2	2025-08-14 16:20:42.567635	2025-08-14 16:21:25.350203
\.


--
-- Data for Name: homework_submissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.homework_submissions (id, homework_id, student_id, created_at, updated_at, grade) FROM stdin;
\.


--
-- Data for Name: homeworks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.homeworks (id, title, description, deadline, assignment_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: learning_materials; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.learning_materials (id, title, description, assignment_id, created_at, updated_at) FROM stdin;
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
\.


--
-- Data for Name: quiz_options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quiz_options (id, quiz_question_id, text, is_correct, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: quiz_questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quiz_questions (id, quiz_id, question_text, point_value, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: quiz_submissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quiz_submissions (id, quiz_id, student_id, submitted_at, raw_score, final_score, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: quizzes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quizzes (id, title, description, deadline, time_limit, assignment_id, created_at, updated_at) FROM stdin;
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
20250902102456
20250902102502
20250902104728
20250902104808
\.


--
-- Data for Name: school_class_archives; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.school_class_archives (id, school_class_id, label, archived_at, data, created_at, updated_at) FROM stdin;
14	2	2020-2021	2025-09-02 09:53:04.366177	{"grades": [], "quizzes": [], "students": [{"id": 14, "name": "Prenume8 Nume8", "email": "student8@example.com"}], "homeworks": [], "materials": [], "assignments": [{"subject_id": 2, "teacher_id": 3, "subject_name": "Math", "teacher_name": "Prenume1 Nume1"}, {"subject_id": 10, "teacher_id": 6, "subject_name": "English", "teacher_name": "Prenume2 Nume2"}], "attendances": [], "quiz_answers": [], "quiz_submissions": [], "timetable_entries": [{"id": 14, "weekday": "monday", "class_id": 2, "period_id": 3, "class_name": "tmp_9A", "subject_id": 10, "teacher_id": 6, "period_label": "10:00–10:50", "subject_name": "English", "teacher_name": "Prenume2 Nume2", "assignment_id": 21}, {"id": 15, "weekday": "wednesday", "class_id": 2, "period_id": 2, "class_name": "tmp_9A", "subject_id": 10, "teacher_id": 6, "period_label": "09:00–09:50", "subject_name": "English", "teacher_name": "Prenume2 Nume2", "assignment_id": 21}], "homework_submissions": []}	2025-09-02 09:53:04.426641	2025-09-02 09:53:04.426641
15	1	2020-2021	2025-09-02 09:53:04.468161	{"grades": [], "quizzes": [], "students": [{"id": 4, "name": "Prenume2 Nume2", "email": "student2@example.com"}, {"id": 2, "name": "Prenume1 Nume1", "email": "student1@example.com"}], "homeworks": [], "materials": [], "assignments": [{"subject_id": 3, "teacher_id": null, "subject_name": "History", "teacher_name": null}, {"subject_id": 2, "teacher_id": 9, "subject_name": "Math", "teacher_name": "Prenume4 Nume4"}, {"subject_id": 10, "teacher_id": 6, "subject_name": "English", "teacher_name": "Prenume2 Nume2"}], "attendances": [], "quiz_answers": [], "quiz_submissions": [], "timetable_entries": [{"id": 10, "weekday": "monday", "class_id": 1, "period_id": 2, "class_name": "tmp_10D", "subject_id": 2, "teacher_id": 9, "period_label": "09:00–09:50", "subject_name": "Math", "teacher_name": "Prenume4 Nume4", "assignment_id": 1}, {"id": 11, "weekday": "monday", "class_id": 1, "period_id": 1, "class_name": "tmp_10D", "subject_id": 10, "teacher_id": 6, "period_label": "08:00–08:50", "subject_name": "English", "teacher_name": "Prenume2 Nume2", "assignment_id": 20}, {"id": 12, "weekday": "thursday", "class_id": 1, "period_id": 4, "class_name": "tmp_10D", "subject_id": 10, "teacher_id": 6, "period_label": "11:00–11:50", "subject_name": "English", "teacher_name": "Prenume2 Nume2", "assignment_id": 20}, {"id": 16, "weekday": "tuesday", "class_id": 1, "period_id": 4, "class_name": "tmp_10D", "subject_id": 2, "teacher_id": 9, "period_label": "11:00–11:50", "subject_name": "Math", "teacher_name": "Prenume4 Nume4", "assignment_id": 1}], "homework_submissions": []}	2025-09-02 09:53:04.502974	2025-09-02 09:53:04.502974
16	9	2020-2021	2025-09-02 09:53:04.526397	{"grades": [{"id": 24, "value": 6, "created_at": "2025-08-18T11:04:03.687Z", "student_id": 12, "subject_id": 6, "teacher_id": 7, "updated_at": "2025-08-18T11:04:03.687Z"}, {"id": 25, "value": 8, "created_at": "2025-08-18T11:42:03.564Z", "student_id": 12, "subject_id": 6, "teacher_id": 7, "updated_at": "2025-08-18T11:42:03.564Z"}, {"id": 43, "value": 4, "created_at": "2025-08-29T11:20:36.415Z", "student_id": 11, "subject_id": 6, "teacher_id": 7, "updated_at": "2025-08-29T11:20:36.415Z"}], "quizzes": [], "students": [{"id": 12, "name": "Prenume6 Nume6", "email": "student6@example.com"}, {"id": 11, "name": "Prenume5 Nume5", "email": "student5@example.com"}], "homeworks": [], "materials": [], "assignments": [{"subject_id": 2, "teacher_id": 9, "subject_name": "Math", "teacher_name": "Prenume4 Nume4"}, {"subject_id": 3, "teacher_id": null, "subject_name": "History", "teacher_name": null}, {"subject_id": 6, "teacher_id": 7, "subject_name": "Physics", "teacher_name": "Prenume3 Nume3"}], "attendances": [{"id": 11, "date": "2025-08-25", "status": "present", "user_id": 11, "period_id": 1, "created_at": "2025-08-20T10:59:14.995Z", "updated_at": "2025-08-20T10:59:14.995Z", "assignment_id": 19}, {"id": 12, "date": "2025-08-25", "status": "present", "user_id": 12, "period_id": 1, "created_at": "2025-08-20T10:59:15.015Z", "updated_at": "2025-08-20T10:59:15.015Z", "assignment_id": 19}, {"id": 13, "date": "2025-08-25", "status": "absent", "user_id": 11, "period_id": 2, "created_at": "2025-08-20T11:00:25.644Z", "updated_at": "2025-08-20T11:00:25.644Z", "assignment_id": 19}, {"id": 14, "date": "2025-08-25", "status": "absent", "user_id": 12, "period_id": 2, "created_at": "2025-08-20T11:00:25.664Z", "updated_at": "2025-08-20T11:00:25.664Z", "assignment_id": 19}], "quiz_answers": [], "quiz_submissions": [], "timetable_entries": [{"id": 4, "weekday": "monday", "class_id": 9, "period_id": 3, "class_name": "tmp_10A", "subject_id": 2, "teacher_id": 9, "period_label": "10:00–10:50", "subject_name": "Math", "teacher_name": "Prenume4 Nume4", "assignment_id": 15}, {"id": 5, "weekday": "monday", "class_id": 9, "period_id": 4, "class_name": "tmp_10A", "subject_id": 2, "teacher_id": 9, "period_label": "11:00–11:50", "subject_name": "Math", "teacher_name": "Prenume4 Nume4", "assignment_id": 15}, {"id": 6, "weekday": "tuesday", "class_id": 9, "period_id": 1, "class_name": "tmp_10A", "subject_id": 2, "teacher_id": 9, "period_label": "08:00–08:50", "subject_name": "Math", "teacher_name": "Prenume4 Nume4", "assignment_id": 15}, {"id": 7, "weekday": "wednesday", "class_id": 9, "period_id": 2, "class_name": "tmp_10A", "subject_id": 2, "teacher_id": 9, "period_label": "09:00–09:50", "subject_name": "Math", "teacher_name": "Prenume4 Nume4", "assignment_id": 15}, {"id": 9, "weekday": "monday", "class_id": 9, "period_id": 2, "class_name": "tmp_10A", "subject_id": 6, "teacher_id": 7, "period_label": "09:00–09:50", "subject_name": "Physics", "teacher_name": "Prenume3 Nume3", "assignment_id": 19}, {"id": 20, "weekday": "monday", "class_id": 9, "period_id": 1, "class_name": "tmp_10A", "subject_id": 6, "teacher_id": 7, "period_label": "08:00–08:50", "subject_name": "Physics", "teacher_name": "Prenume3 Nume3", "assignment_id": 19}], "homework_submissions": []}	2025-09-02 09:53:04.586313	2025-09-02 09:53:04.586313
17	16	2020-2021	2025-09-02 09:53:04.610272	{"grades": [], "quizzes": [], "students": [], "homeworks": [], "materials": [], "assignments": [{"subject_id": 2, "teacher_id": null, "subject_name": "Math", "teacher_name": null}, {"subject_id": 6, "teacher_id": null, "subject_name": "Physics", "teacher_name": null}], "attendances": [], "quiz_answers": [], "quiz_submissions": [], "timetable_entries": [], "homework_submissions": []}	2025-09-02 09:53:04.621076	2025-09-02 09:53:04.621076
59	16	2022-2023	2025-09-02 12:38:28.176304	{"grades": [], "quizzes": [], "students": [], "homeworks": [], "materials": [], "assignments": [], "attendances": [], "quiz_answers": [], "quiz_submissions": [], "timetable_entries": [], "homework_submissions": []}	2025-09-02 12:38:28.184527	2025-09-02 12:38:28.184527
18	13	2020-2021	2025-09-02 09:53:04.641761	{"grades": [{"id": 11, "value": 6, "created_at": "2025-08-14T15:31:17.758Z", "student_id": 5, "subject_id": 3, "teacher_id": 3, "updated_at": "2025-08-14T15:36:33.436Z"}, {"id": 12, "value": 8, "created_at": "2025-08-14T15:34:47.695Z", "student_id": 5, "subject_id": 3, "teacher_id": 3, "updated_at": "2025-08-14T15:34:47.695Z"}, {"id": 13, "value": 10, "created_at": "2025-08-14T15:35:33.574Z", "student_id": 8, "subject_id": 3, "teacher_id": 3, "updated_at": "2025-08-14T15:35:33.574Z"}], "quizzes": [], "students": [{"id": 8, "name": "Prenume4 Nume4", "email": "student4@example.com"}, {"id": 5, "name": "Prenume3 Nume3", "email": "student3@example.com"}], "homeworks": [], "materials": [], "assignments": [{"subject_id": 3, "teacher_id": 3, "subject_name": "History", "teacher_name": "Prenume1 Nume1"}, {"subject_id": 2, "teacher_id": 6, "subject_name": "Math", "teacher_name": "Prenume2 Nume2"}, {"subject_id": 4, "teacher_id": 17, "subject_name": "Geography", "teacher_name": "Prenume5 Nume5"}], "attendances": [{"id": 1, "date": "2025-08-18", "status": "present", "user_id": 5, "period_id": 3, "created_at": "2025-08-19T14:08:29.932Z", "updated_at": "2025-08-19T14:08:29.932Z", "assignment_id": 6}, {"id": 2, "date": "2025-08-11", "status": "present", "user_id": 5, "period_id": 3, "created_at": "2025-08-19T14:08:47.380Z", "updated_at": "2025-08-19T14:08:47.380Z", "assignment_id": 6}, {"id": 3, "date": "2025-08-11", "status": "absent", "user_id": 8, "period_id": 3, "created_at": "2025-08-19T14:09:14.898Z", "updated_at": "2025-08-19T14:09:14.898Z", "assignment_id": 6}, {"id": 4, "date": "2025-08-18", "status": "present", "user_id": 8, "period_id": 3, "created_at": "2025-08-19T14:09:25.986Z", "updated_at": "2025-08-19T14:09:25.986Z", "assignment_id": 6}, {"id": 6, "date": "2025-08-25", "status": "present", "user_id": 8, "period_id": 3, "created_at": "2025-08-19T14:27:19.895Z", "updated_at": "2025-08-19T14:27:19.895Z", "assignment_id": 6}, {"id": 9, "date": "2025-08-25", "status": "absent", "user_id": 5, "period_id": 3, "created_at": "2025-08-20T07:31:24.790Z", "updated_at": "2025-08-20T07:31:24.790Z", "assignment_id": 6}, {"id": 28, "date": "2025-07-07", "status": "present", "user_id": 8, "period_id": 3, "created_at": "2025-09-01T07:53:26.997Z", "updated_at": "2025-09-01T07:53:26.997Z", "assignment_id": 6}, {"id": 29, "date": "2025-07-07", "status": "present", "user_id": 5, "period_id": 3, "created_at": "2025-09-01T07:53:27.029Z", "updated_at": "2025-09-01T07:53:27.029Z", "assignment_id": 6}, {"id": 30, "date": "2025-06-16", "status": "absent", "user_id": 8, "period_id": 3, "created_at": "2025-09-01T07:53:37.507Z", "updated_at": "2025-09-01T07:53:37.507Z", "assignment_id": 6}, {"id": 31, "date": "2025-06-16", "status": "present", "user_id": 5, "period_id": 3, "created_at": "2025-09-01T07:53:37.528Z", "updated_at": "2025-09-01T07:53:37.528Z", "assignment_id": 6}, {"id": 32, "date": "2025-07-14", "status": "absent", "user_id": 8, "period_id": 3, "created_at": "2025-09-01T07:53:47.033Z", "updated_at": "2025-09-01T07:53:47.033Z", "assignment_id": 6}, {"id": 33, "date": "2025-07-14", "status": "absent", "user_id": 5, "period_id": 3, "created_at": "2025-09-01T07:53:47.053Z", "updated_at": "2025-09-01T07:53:47.053Z", "assignment_id": 6}], "quiz_answers": [], "quiz_submissions": [], "timetable_entries": [{"id": 1, "weekday": "monday", "class_id": 13, "period_id": 3, "class_name": "tmp_1A", "subject_id": 3, "teacher_id": 3, "period_label": "10:00–10:50", "subject_name": "History", "teacher_name": "Prenume1 Nume1", "assignment_id": 6}, {"id": 18, "weekday": "friday", "class_id": 13, "period_id": 1, "class_name": "tmp_1A", "subject_id": 4, "teacher_id": 17, "period_label": "08:00–08:50", "subject_name": "Geography", "teacher_name": "Prenume5 Nume5", "assignment_id": 17}], "homework_submissions": []}	2025-09-02 09:53:04.672171	2025-09-02 09:53:04.672171
19	7	2020-2021	2025-09-02 09:53:04.699829	{"grades": [{"id": 14, "value": 9, "created_at": "2025-08-14T15:35:55.531Z", "student_id": 16, "subject_id": 3, "teacher_id": 3, "updated_at": "2025-08-14T15:35:55.531Z"}, {"id": 17, "value": 9, "created_at": "2025-08-18T10:23:54.878Z", "student_id": 10, "subject_id": 3, "teacher_id": 7, "updated_at": "2025-08-18T10:23:54.878Z"}, {"id": 18, "value": 7, "created_at": "2025-08-18T10:24:00.521Z", "student_id": 10, "subject_id": 3, "teacher_id": 7, "updated_at": "2025-08-18T10:24:00.521Z"}, {"id": 19, "value": 8, "created_at": "2025-08-18T10:24:19.751Z", "student_id": 15, "subject_id": 3, "teacher_id": 7, "updated_at": "2025-08-18T10:24:19.751Z"}, {"id": 20, "value": 9, "created_at": "2025-08-18T11:00:11.596Z", "student_id": 16, "subject_id": 3, "teacher_id": 7, "updated_at": "2025-08-28T14:28:13.145Z"}, {"id": 21, "value": 6, "created_at": "2025-08-18T11:00:48.792Z", "student_id": 16, "subject_id": 3, "teacher_id": 7, "updated_at": "2025-08-18T11:00:48.792Z"}, {"id": 22, "value": 3, "created_at": "2025-08-18T11:01:07.046Z", "student_id": 10, "subject_id": 3, "teacher_id": 7, "updated_at": "2025-08-18T11:01:07.046Z"}, {"id": 27, "value": 1, "created_at": "2025-08-25T14:04:57.290Z", "student_id": 15, "subject_id": 4, "teacher_id": 7, "updated_at": "2025-08-25T14:04:57.290Z"}, {"id": 28, "value": 10, "created_at": "2025-08-25T14:19:19.199Z", "student_id": 10, "subject_id": 4, "teacher_id": 7, "updated_at": "2025-08-25T14:19:19.199Z"}, {"id": 29, "value": 10, "created_at": "2025-08-26T08:25:43.137Z", "student_id": 10, "subject_id": 4, "teacher_id": 7, "updated_at": "2025-08-26T08:25:43.137Z"}, {"id": 30, "value": 7, "created_at": "2025-08-26T08:28:31.894Z", "student_id": 15, "subject_id": 4, "teacher_id": 7, "updated_at": "2025-08-26T08:28:31.894Z"}, {"id": 31, "value": 10, "created_at": "2025-08-26T08:30:12.000Z", "student_id": 16, "subject_id": 4, "teacher_id": 7, "updated_at": "2025-08-28T14:09:04.555Z"}, {"id": 32, "value": 4, "created_at": "2025-08-26T16:06:47.448Z", "student_id": 16, "subject_id": 4, "teacher_id": 7, "updated_at": "2025-08-26T16:06:47.448Z"}, {"id": 33, "value": 10, "created_at": "2025-08-26T17:45:56.347Z", "student_id": 16, "subject_id": 4, "teacher_id": 7, "updated_at": "2025-08-26T17:45:56.347Z"}, {"id": 34, "value": 1, "created_at": "2025-08-26T18:21:44.896Z", "student_id": 16, "subject_id": 10, "teacher_id": 6, "updated_at": "2025-08-26T18:21:44.896Z"}, {"id": 35, "value": 1, "created_at": "2025-08-26T18:40:43.533Z", "student_id": 16, "subject_id": 10, "teacher_id": 6, "updated_at": "2025-08-26T18:40:43.533Z"}, {"id": 36, "value": 4, "created_at": "2025-08-27T07:48:53.097Z", "student_id": 16, "subject_id": 10, "teacher_id": 6, "updated_at": "2025-08-27T07:48:53.097Z"}, {"id": 37, "value": 10, "created_at": "2025-08-27T08:52:26.458Z", "student_id": 16, "subject_id": 3, "teacher_id": 7, "updated_at": "2025-08-27T08:52:26.458Z"}, {"id": 38, "value": 4, "created_at": "2025-08-28T09:19:28.959Z", "student_id": 16, "subject_id": 3, "teacher_id": 7, "updated_at": "2025-08-28T09:19:28.959Z"}, {"id": 39, "value": 9, "created_at": "2025-08-28T14:30:23.803Z", "student_id": 16, "subject_id": 3, "teacher_id": 7, "updated_at": "2025-08-28T14:30:23.803Z"}, {"id": 40, "value": 10, "created_at": "2025-08-28T14:30:38.852Z", "student_id": 16, "subject_id": 4, "teacher_id": 7, "updated_at": "2025-08-28T14:30:38.852Z"}, {"id": 41, "value": 6, "created_at": "2025-08-28T16:31:49.444Z", "student_id": 16, "subject_id": 4, "teacher_id": 7, "updated_at": "2025-08-28T16:31:49.444Z"}, {"id": 44, "value": 5, "created_at": "2025-09-01T10:26:35.918Z", "student_id": 16, "subject_id": 4, "teacher_id": 7, "updated_at": "2025-09-01T10:26:35.918Z"}], "quizzes": [{"id": 1, "title": "Test1", "deadline": "2025-09-01T23:59:00.000Z", "created_at": "2025-08-22T13:29:36.574Z", "time_limit": 10, "updated_at": "2025-08-22T13:29:36.574Z", "description": "Description1", "assignment_id": 8}, {"id": 3, "title": "Test1", "deadline": "2025-09-01T23:59:00.000Z", "created_at": "2025-08-22T13:45:12.629Z", "time_limit": 10, "updated_at": "2025-08-22T13:45:12.629Z", "description": "Description2", "assignment_id": 9}, {"id": 6, "title": "aa", "deadline": "2025-08-26T12:48:00.000Z", "created_at": "2025-08-25T09:49:22.485Z", "time_limit": 3, "updated_at": "2025-08-25T09:49:22.485Z", "description": "aa", "assignment_id": 9}, {"id": 8, "title": "B", "deadline": "2025-08-28T18:15:00.000Z", "created_at": "2025-08-25T10:17:00.764Z", "time_limit": 20, "updated_at": "2025-08-25T10:17:00.764Z", "description": "B", "assignment_id": 9}, {"id": 10, "title": "C", "deadline": "2025-09-01T23:59:00.000Z", "created_at": "2025-08-26T18:15:47.017Z", "time_limit": 10, "updated_at": "2025-08-26T18:15:47.017Z", "description": "C", "assignment_id": 23}, {"id": 11, "title": "C2", "deadline": "2025-08-26T18:18:00.000Z", "created_at": "2025-08-26T18:17:35.875Z", "time_limit": 15, "updated_at": "2025-08-26T18:17:35.875Z", "description": "C2", "assignment_id": 23}, {"id": 12, "title": "D", "deadline": "2025-09-01T23:59:00.000Z", "created_at": "2025-08-26T18:19:06.913Z", "time_limit": 1, "updated_at": "2025-08-26T18:19:06.913Z", "description": "D", "assignment_id": 23}, {"id": 13, "title": "E", "deadline": "2025-09-01T23:59:00.000Z", "created_at": "2025-08-26T18:40:18.535Z", "time_limit": 1, "updated_at": "2025-08-26T18:40:18.535Z", "description": "E", "assignment_id": 23}, {"id": 14, "title": "aa", "deadline": "2025-08-26T10:50:00.000Z", "created_at": "2025-08-28T07:51:20.468Z", "time_limit": 20, "updated_at": "2025-08-28T07:51:20.468Z", "description": "aaa", "assignment_id": 8}, {"id": 15, "title": "bb", "deadline": "2025-11-06T10:00:00.000Z", "created_at": "2025-08-28T07:52:46.088Z", "time_limit": 1, "updated_at": "2025-08-28T07:52:46.088Z", "description": "bb", "assignment_id": 8}, {"id": 16, "title": "sss", "deadline": "2025-08-30T12:24:00.000Z", "created_at": "2025-08-28T09:24:30.332Z", "time_limit": 1, "updated_at": "2025-08-28T09:24:30.332Z", "description": "ss", "assignment_id": 8}, {"id": 18, "title": "q", "deadline": "2025-05-19T17:00:00.000Z", "created_at": "2025-08-29T14:40:04.521Z", "time_limit": 9, "updated_at": "2025-08-29T14:40:04.521Z", "description": "q", "assignment_id": 8}, {"id": 19, "title": "qq", "deadline": "2025-11-06T17:30:00.000Z", "created_at": "2025-08-29T14:45:07.642Z", "time_limit": 10, "updated_at": "2025-08-29T14:45:07.642Z", "description": "qq", "assignment_id": 8}], "students": [{"id": 10, "name": "a", "email": "a@a.a"}, {"id": 16, "name": "A A ", "email": "a@aa.a"}, {"id": 15, "name": "aaa", "email": "aaa@a.a"}], "homeworks": [{"id": 1, "title": "Tema 1", "deadline": "2025-09-10", "created_at": "2025-08-27T09:46:49.032Z", "updated_at": "2025-08-27T09:46:49.032Z", "description": "aaa", "assignment_id": 8}, {"id": 3, "title": "Tema 3", "deadline": "2025-09-10", "created_at": "2025-08-27T09:47:57.264Z", "updated_at": "2025-08-27T09:47:57.264Z", "description": "ccc", "assignment_id": 9}, {"id": 4, "title": "aaa", "deadline": "2025-08-28", "created_at": "2025-08-27T10:52:44.114Z", "updated_at": "2025-08-27T10:52:44.114Z", "description": "aaa", "assignment_id": 9}, {"id": 6, "title": "zzz", "deadline": "2025-08-10", "created_at": "2025-08-27T15:04:20.981Z", "updated_at": "2025-08-27T15:04:20.981Z", "description": "zzz", "assignment_id": 9}, {"id": 7, "title": "bbb", "deadline": "2025-08-30", "created_at": "2025-08-28T07:48:06.761Z", "updated_at": "2025-08-28T07:48:06.761Z", "description": "bbb", "assignment_id": 8}, {"id": 9, "title": "ccc", "deadline": "2025-08-20", "created_at": "2025-08-28T07:49:56.706Z", "updated_at": "2025-08-28T07:49:56.706Z", "description": "ccc", "assignment_id": 8}, {"id": 10, "title": "dd", "deadline": "2025-12-19", "created_at": "2025-08-28T16:35:08.693Z", "updated_at": "2025-08-28T16:35:08.693Z", "description": "dd", "assignment_id": 9}, {"id": 11, "title": "ee", "deadline": "2025-08-14", "created_at": "2025-08-28T16:35:22.411Z", "updated_at": "2025-08-28T16:35:22.411Z", "description": "ee", "assignment_id": 9}, {"id": 12, "title": "sss", "deadline": "2025-10-10", "created_at": "2025-09-01T07:22:31.854Z", "updated_at": "2025-09-01T07:22:31.854Z", "description": "sss", "assignment_id": 9}], "materials": [{"id": 1, "title": "title1", "created_at": "2025-08-21T08:30:45.034Z", "updated_at": "2025-08-21T08:30:45.116Z", "description": "", "assignment_id": 8}, {"id": 3, "title": "title3", "created_at": "2025-08-21T10:44:37.601Z", "updated_at": "2025-08-21T10:44:37.663Z", "description": "", "assignment_id": 9}, {"id": 8, "title": "aaa", "created_at": "2025-08-21T14:48:26.608Z", "updated_at": "2025-08-21T14:48:26.627Z", "description": "bbb", "assignment_id": 9}, {"id": 12, "title": "title2", "created_at": "2025-08-22T08:03:31.134Z", "updated_at": "2025-08-22T08:03:31.227Z", "description": "aaa", "assignment_id": 8}, {"id": 13, "title": "v", "created_at": "2025-08-28T11:00:56.015Z", "updated_at": "2025-08-28T11:00:56.077Z", "description": "v", "assignment_id": 9}, {"id": 14, "title": "zz", "created_at": "2025-08-28T11:07:34.409Z", "updated_at": "2025-08-28T11:07:34.474Z", "description": "zz", "assignment_id": 9}, {"id": 15, "title": "a", "created_at": "2025-09-01T07:44:17.978Z", "updated_at": "2025-09-01T07:44:17.994Z", "description": "a", "assignment_id": 9}, {"id": 18, "title": "aaa", "created_at": "2025-09-01T09:12:17.057Z", "updated_at": "2025-09-01T09:12:17.064Z", "description": "aaa", "assignment_id": 8}], "assignments": [{"subject_id": 4, "teacher_id": 7, "subject_name": "Geography", "teacher_name": "Prenume3 Nume3"}, {"subject_id": 3, "teacher_id": 7, "subject_name": "History", "teacher_name": "Prenume3 Nume3"}, {"subject_id": 10, "teacher_id": 6, "subject_name": "English", "teacher_name": "Prenume2 Nume2"}], "attendances": [{"id": 16, "date": "2025-08-22", "status": "absent", "user_id": 16, "period_id": 4, "created_at": "2025-08-20T11:13:33.116Z", "updated_at": "2025-08-20T12:38:25.476Z", "assignment_id": 9}, {"id": 17, "date": "2025-08-22", "status": "absent", "user_id": 15, "period_id": 4, "created_at": "2025-08-20T12:36:24.473Z", "updated_at": "2025-08-20T12:38:25.519Z", "assignment_id": 9}, {"id": 15, "date": "2025-08-22", "status": "present", "user_id": 10, "period_id": 4, "created_at": "2025-08-20T11:12:50.263Z", "updated_at": "2025-08-20T12:38:44.453Z", "assignment_id": 9}, {"id": 18, "date": "2025-08-22", "status": "present", "user_id": 10, "period_id": 5, "created_at": "2025-08-20T13:03:17.079Z", "updated_at": "2025-08-20T13:03:52.431Z", "assignment_id": 9}, {"id": 20, "date": "2025-08-22", "status": "present", "user_id": 15, "period_id": 5, "created_at": "2025-08-20T13:03:52.476Z", "updated_at": "2025-08-20T13:03:52.476Z", "assignment_id": 9}, {"id": 21, "date": "2025-08-26", "status": "absent", "user_id": 16, "period_id": 2, "created_at": "2025-08-20T15:56:33.805Z", "updated_at": "2025-08-20T15:56:33.805Z", "assignment_id": 8}, {"id": 22, "date": "2025-08-25", "status": "absent", "user_id": 16, "period_id": 3, "created_at": "2025-08-20T15:56:51.753Z", "updated_at": "2025-08-20T15:56:51.753Z", "assignment_id": 8}, {"id": 23, "date": "2025-09-01", "status": "present", "user_id": 16, "period_id": 3, "created_at": "2025-08-20T15:57:11.627Z", "updated_at": "2025-08-20T15:57:11.627Z", "assignment_id": 8}, {"id": 24, "date": "2025-09-02", "status": "absent", "user_id": 16, "period_id": 2, "created_at": "2025-08-20T15:57:25.173Z", "updated_at": "2025-08-20T15:57:25.173Z", "assignment_id": 8}, {"id": 19, "date": "2025-08-22", "status": "absent", "user_id": 16, "period_id": 5, "created_at": "2025-08-20T13:03:38.113Z", "updated_at": "2025-08-29T14:17:12.176Z", "assignment_id": 9}, {"id": 25, "date": "2025-01-03", "status": "present", "user_id": 10, "period_id": 4, "created_at": "2025-08-29T14:17:55.191Z", "updated_at": "2025-08-29T14:17:55.191Z", "assignment_id": 9}, {"id": 26, "date": "2025-01-03", "status": "present", "user_id": 16, "period_id": 4, "created_at": "2025-08-29T14:17:55.226Z", "updated_at": "2025-08-29T14:17:55.226Z", "assignment_id": 9}, {"id": 27, "date": "2025-01-03", "status": "present", "user_id": 15, "period_id": 4, "created_at": "2025-08-29T14:17:55.250Z", "updated_at": "2025-08-29T14:17:55.250Z", "assignment_id": 9}], "quiz_answers": [{"id": 5, "created_at": "2025-08-25T14:04:57.256Z", "updated_at": "2025-08-25T14:04:57.256Z", "quiz_question_id": 13, "quiz_submission_id": 3, "selected_option_ids": [26]}, {"id": 6, "created_at": "2025-08-25T14:04:57.263Z", "updated_at": "2025-08-25T14:04:57.263Z", "quiz_question_id": 14, "quiz_submission_id": 3, "selected_option_ids": [27, 28]}, {"id": 7, "created_at": "2025-08-25T14:19:19.172Z", "updated_at": "2025-08-25T14:19:19.172Z", "quiz_question_id": 13, "quiz_submission_id": 4, "selected_option_ids": [25, 26]}, {"id": 8, "created_at": "2025-08-25T14:19:19.177Z", "updated_at": "2025-08-25T14:19:19.177Z", "quiz_question_id": 14, "quiz_submission_id": 4, "selected_option_ids": [27]}, {"id": 9, "created_at": "2025-08-26T08:25:43.081Z", "updated_at": "2025-08-26T08:25:43.081Z", "quiz_question_id": 10, "quiz_submission_id": 5, "selected_option_ids": [21]}, {"id": 10, "created_at": "2025-08-26T08:25:43.092Z", "updated_at": "2025-08-26T08:25:43.092Z", "quiz_question_id": 11, "quiz_submission_id": 5, "selected_option_ids": [22, 23]}, {"id": 11, "created_at": "2025-08-26T08:28:31.868Z", "updated_at": "2025-08-26T08:28:31.868Z", "quiz_question_id": 11, "quiz_submission_id": 6, "selected_option_ids": [22, 23]}, {"id": 12, "created_at": "2025-08-26T08:30:11.979Z", "updated_at": "2025-08-26T08:30:11.979Z", "quiz_question_id": 11, "quiz_submission_id": 7, "selected_option_ids": [23]}, {"id": 13, "created_at": "2025-08-26T16:06:47.406Z", "updated_at": "2025-08-26T16:06:47.406Z", "quiz_question_id": 5, "quiz_submission_id": 8, "selected_option_ids": [12]}, {"id": 14, "created_at": "2025-08-26T16:06:47.419Z", "updated_at": "2025-08-26T16:06:47.419Z", "quiz_question_id": 6, "quiz_submission_id": 8, "selected_option_ids": [14]}, {"id": 15, "created_at": "2025-08-26T17:45:56.151Z", "updated_at": "2025-08-26T17:45:56.151Z", "quiz_question_id": 13, "quiz_submission_id": 9, "selected_option_ids": [25, 26]}, {"id": 16, "created_at": "2025-08-26T17:45:56.172Z", "updated_at": "2025-08-26T17:45:56.172Z", "quiz_question_id": 14, "quiz_submission_id": 9, "selected_option_ids": [27]}, {"id": 17, "created_at": "2025-08-26T18:21:44.866Z", "updated_at": "2025-08-26T18:21:44.866Z", "quiz_question_id": 17, "quiz_submission_id": 10, "selected_option_ids": [33]}, {"id": 18, "created_at": "2025-08-26T18:21:44.871Z", "updated_at": "2025-08-26T18:21:44.871Z", "quiz_question_id": 18, "quiz_submission_id": 10, "selected_option_ids": [35]}, {"id": 19, "created_at": "2025-08-26T18:21:44.873Z", "updated_at": "2025-08-26T18:21:44.873Z", "quiz_question_id": 19, "quiz_submission_id": 10, "selected_option_ids": [37, 38]}, {"id": 20, "created_at": "2025-08-26T18:40:43.514Z", "updated_at": "2025-08-26T18:40:43.514Z", "quiz_question_id": 25, "quiz_submission_id": 11, "selected_option_ids": [49]}, {"id": 21, "created_at": "2025-08-27T07:48:53.029Z", "updated_at": "2025-08-27T07:48:53.029Z", "quiz_question_id": 23, "quiz_submission_id": 12, "selected_option_ids": [45, 46]}, {"id": 22, "created_at": "2025-08-27T07:48:53.043Z", "updated_at": "2025-08-27T07:48:53.043Z", "quiz_question_id": 24, "quiz_submission_id": 12, "selected_option_ids": [47]}, {"id": 23, "created_at": "2025-08-27T08:52:26.424Z", "updated_at": "2025-08-27T08:52:26.424Z", "quiz_question_id": 1, "quiz_submission_id": 13, "selected_option_ids": [1]}, {"id": 24, "created_at": "2025-08-27T08:52:26.435Z", "updated_at": "2025-08-27T08:52:26.435Z", "quiz_question_id": 2, "quiz_submission_id": 13, "selected_option_ids": [5, 7]}, {"id": 25, "created_at": "2025-08-28T09:19:28.920Z", "updated_at": "2025-08-28T09:19:28.920Z", "quiz_question_id": 28, "quiz_submission_id": 14, "selected_option_ids": [56, 57]}, {"id": 26, "created_at": "2025-08-28T09:19:28.929Z", "updated_at": "2025-08-28T09:19:28.929Z", "quiz_question_id": 29, "quiz_submission_id": 14, "selected_option_ids": [58]}], "quiz_submissions": [{"id": 3, "quiz_id": 8, "raw_score": 1.0, "created_at": "2025-08-25T14:04:57.251Z", "student_id": 15, "updated_at": "2025-08-25T14:04:57.251Z", "final_score": 1.0, "submitted_at": "2025-08-25T14:04:57.235Z"}, {"id": 4, "quiz_id": 8, "raw_score": 10.0, "created_at": "2025-08-25T14:19:19.160Z", "student_id": 10, "updated_at": "2025-08-25T14:19:19.160Z", "final_score": 10.0, "submitted_at": "2025-08-25T14:19:19.153Z"}, {"id": 5, "quiz_id": 6, "raw_score": 10.0, "created_at": "2025-08-26T08:25:43.057Z", "student_id": 10, "updated_at": "2025-08-26T08:25:43.057Z", "final_score": 10.0, "submitted_at": "2025-08-26T08:25:43.043Z"}, {"id": 6, "quiz_id": 6, "raw_score": 7.0, "created_at": "2025-08-26T08:28:31.857Z", "student_id": 15, "updated_at": "2025-08-26T08:28:31.857Z", "final_score": 7.0, "submitted_at": "2025-08-26T08:28:31.851Z"}, {"id": 7, "quiz_id": 6, "raw_score": 1.0, "created_at": "2025-08-26T08:30:11.961Z", "student_id": 16, "updated_at": "2025-08-26T08:30:11.961Z", "final_score": 1.0, "submitted_at": "2025-08-26T08:30:11.958Z"}, {"id": 8, "quiz_id": 3, "raw_score": 4.0, "created_at": "2025-08-26T16:06:47.357Z", "student_id": 16, "updated_at": "2025-08-26T16:06:47.357Z", "final_score": 4.0, "submitted_at": "2025-08-26T16:06:47.091Z"}, {"id": 9, "quiz_id": 8, "raw_score": 10.0, "created_at": "2025-08-26T17:45:56.111Z", "student_id": 16, "updated_at": "2025-08-26T17:45:56.111Z", "final_score": 10.0, "submitted_at": "2025-08-26T17:45:55.782Z"}, {"id": 10, "quiz_id": 10, "raw_score": 1.0, "created_at": "2025-08-26T18:21:44.851Z", "student_id": 16, "updated_at": "2025-08-26T18:21:44.851Z", "final_score": 1.0, "submitted_at": "2025-08-26T18:21:44.794Z"}, {"id": 11, "quiz_id": 13, "raw_score": 1.0, "created_at": "2025-08-26T18:40:43.505Z", "student_id": 16, "updated_at": "2025-08-26T18:40:43.505Z", "final_score": 1.0, "submitted_at": "2025-08-26T18:40:43.503Z"}, {"id": 12, "quiz_id": 12, "raw_score": 4.0, "created_at": "2025-08-27T07:48:52.971Z", "student_id": 16, "updated_at": "2025-08-27T07:48:52.971Z", "final_score": 4.0, "submitted_at": "2025-08-27T07:48:52.928Z"}, {"id": 13, "quiz_id": 1, "raw_score": 10.0, "created_at": "2025-08-27T08:52:26.393Z", "student_id": 16, "updated_at": "2025-08-27T08:52:26.393Z", "final_score": 10.0, "submitted_at": "2025-08-27T08:52:26.384Z"}, {"id": 14, "quiz_id": 15, "raw_score": 4.0, "created_at": "2025-08-28T09:19:28.886Z", "student_id": 16, "updated_at": "2025-08-28T09:19:28.886Z", "final_score": 4.0, "submitted_at": "2025-08-28T09:19:28.709Z"}], "timetable_entries": [{"id": 3, "weekday": "monday", "class_id": 7, "period_id": 3, "class_name": "tmp_1B", "subject_id": 3, "teacher_id": 7, "period_label": "10:00–10:50", "subject_name": "History", "teacher_name": "Prenume3 Nume3", "assignment_id": 8}, {"id": 17, "weekday": "friday", "class_id": 7, "period_id": 5, "class_name": "tmp_1B", "subject_id": 4, "teacher_id": 7, "period_label": "12:00–12:50", "subject_name": "Geography", "teacher_name": "Prenume3 Nume3", "assignment_id": 9}, {"id": 19, "weekday": "tuesday", "class_id": 7, "period_id": 2, "class_name": "tmp_1B", "subject_id": 3, "teacher_id": 7, "period_label": "09:00–09:50", "subject_name": "History", "teacher_name": "Prenume3 Nume3", "assignment_id": 8}, {"id": 21, "weekday": "friday", "class_id": 7, "period_id": 4, "class_name": "tmp_1B", "subject_id": 4, "teacher_id": 7, "period_label": "11:00–11:50", "subject_name": "Geography", "teacher_name": "Prenume3 Nume3", "assignment_id": 9}, {"id": 22, "weekday": "monday", "class_id": 7, "period_id": 2, "class_name": "tmp_1B", "subject_id": 10, "teacher_id": 6, "period_label": "09:00–09:50", "subject_name": "English", "teacher_name": "Prenume2 Nume2", "assignment_id": 23}], "homework_submissions": [{"id": 3, "grade": 10, "created_at": "2025-08-27T15:05:24.710Z", "student_id": 16, "updated_at": "2025-08-28T14:09:04.458Z", "homework_id": 4}, {"id": 4, "grade": 9, "created_at": "2025-08-28T09:21:24.374Z", "student_id": 16, "updated_at": "2025-08-28T14:28:13.098Z", "homework_id": 7}, {"id": 5, "grade": 6, "created_at": "2025-08-28T16:31:22.584Z", "student_id": 16, "updated_at": "2025-08-28T16:31:49.306Z", "homework_id": 3}, {"id": 7, "grade": 5, "created_at": "2025-08-28T16:41:09.453Z", "student_id": 16, "updated_at": "2025-09-01T10:26:35.873Z", "homework_id": 11}, {"id": 9, "grade": null, "created_at": "2025-09-01T12:03:53.810Z", "student_id": 16, "updated_at": "2025-09-01T12:03:53.824Z", "homework_id": 12}]}	2025-09-02 09:53:04.96972	2025-09-02 09:53:04.96972
20	18	2020-2021	2025-09-02 09:53:05.011799	{"grades": [], "quizzes": [], "students": [], "homeworks": [], "materials": [], "assignments": [{"subject_id": 9, "teacher_id": 17, "subject_name": "Chemistry", "teacher_name": "Prenume5 Nume5"}], "attendances": [], "quiz_answers": [], "quiz_submissions": [], "timetable_entries": [], "homework_submissions": []}	2025-09-02 09:53:05.024816	2025-09-02 09:53:05.024816
50	2	2021-2022	2025-09-02 11:11:21.228223	{"grades": [], "quizzes": [], "students": [{"id": 14, "name": "Prenume8 Nume8", "email": "student8@example.com"}], "homeworks": [], "materials": [], "assignments": [], "attendances": [], "quiz_answers": [], "quiz_submissions": [], "timetable_entries": [], "homework_submissions": []}	2025-09-02 11:11:21.255306	2025-09-02 11:11:21.255306
51	9	2021-2022	2025-09-02 11:11:21.290024	{"grades": [], "quizzes": [], "students": [{"id": 12, "name": "Prenume6 Nume6", "email": "student6@example.com"}, {"id": 11, "name": "Prenume5 Nume5", "email": "student5@example.com"}], "homeworks": [], "materials": [], "assignments": [], "attendances": [], "quiz_answers": [], "quiz_submissions": [], "timetable_entries": [], "homework_submissions": []}	2025-09-02 11:11:21.294929	2025-09-02 11:11:21.294929
52	16	2021-2022	2025-09-02 11:11:21.310944	{"grades": [], "quizzes": [], "students": [], "homeworks": [], "materials": [], "assignments": [], "attendances": [], "quiz_answers": [], "quiz_submissions": [], "timetable_entries": [], "homework_submissions": []}	2025-09-02 11:11:21.315637	2025-09-02 11:11:21.315637
53	13	2021-2022	2025-09-02 11:11:21.333724	{"grades": [], "quizzes": [], "students": [{"id": 8, "name": "Prenume4 Nume4", "email": "student4@example.com"}, {"id": 5, "name": "Prenume3 Nume3", "email": "student3@example.com"}], "homeworks": [], "materials": [], "assignments": [], "attendances": [], "quiz_answers": [], "quiz_submissions": [], "timetable_entries": [], "homework_submissions": []}	2025-09-02 11:11:21.338488	2025-09-02 11:11:21.338488
54	7	2021-2022	2025-09-02 11:11:21.354652	{"grades": [{"id": 45, "value": 6, "created_at": "2025-09-02T10:05:34.205Z", "student_id": 16, "subject_id": 2, "teacher_id": 7, "updated_at": "2025-09-02T10:05:34.205Z"}], "quizzes": [], "students": [{"id": 10, "name": "a", "email": "a@a.a"}, {"id": 16, "name": "A A ", "email": "a@aa.a"}, {"id": 15, "name": "aaa", "email": "aaa@a.a"}], "homeworks": [], "materials": [{"id": 19, "title": "aa", "created_at": "2025-09-02T10:06:57.416Z", "updated_at": "2025-09-02T10:06:57.443Z", "description": "aa", "assignment_id": 24}], "assignments": [{"subject_id": 2, "teacher_id": 7, "subject_name": "Math", "teacher_name": "Prenume3 Nume3"}], "attendances": [{"id": 34, "date": "2025-08-26", "status": "absent", "user_id": 10, "period_id": 3, "created_at": "2025-09-02T10:05:24.494Z", "updated_at": "2025-09-02T10:05:24.494Z", "assignment_id": 24}, {"id": 35, "date": "2025-08-26", "status": "absent", "user_id": 16, "period_id": 3, "created_at": "2025-09-02T10:05:24.515Z", "updated_at": "2025-09-02T10:05:24.515Z", "assignment_id": 24}, {"id": 36, "date": "2025-08-26", "status": "absent", "user_id": 15, "period_id": 3, "created_at": "2025-09-02T10:05:24.531Z", "updated_at": "2025-09-02T10:05:24.531Z", "assignment_id": 24}], "quiz_answers": [], "quiz_submissions": [], "timetable_entries": [{"id": 23, "weekday": "tuesday", "class_id": 7, "period_id": 3, "class_name": "tmp_2B", "subject_id": 2, "teacher_id": 7, "period_label": "10:00–10:50", "subject_name": "Math", "teacher_name": "Prenume3 Nume3", "assignment_id": 24}, {"id": 24, "weekday": "tuesday", "class_id": 7, "period_id": 4, "class_name": "tmp_2B", "subject_id": 2, "teacher_id": 7, "period_label": "11:00–11:50", "subject_name": "Math", "teacher_name": "Prenume3 Nume3", "assignment_id": 24}], "homework_submissions": []}	2025-09-02 11:11:21.492923	2025-09-02 11:11:21.492923
55	18	2021-2022	2025-09-02 11:11:21.518518	{"grades": [], "quizzes": [], "students": [], "homeworks": [], "materials": [], "assignments": [], "attendances": [], "quiz_answers": [], "quiz_submissions": [], "timetable_entries": [], "homework_submissions": []}	2025-09-02 11:11:21.524084	2025-09-02 11:11:21.524084
56	1	2021-2022	2025-09-02 11:11:21.551154	{"grades": [{"id": 46, "value": 8, "created_at": "2025-09-02T10:07:19.055Z", "student_id": 2, "subject_id": 10, "teacher_id": 3, "updated_at": "2025-09-02T10:07:19.055Z"}, {"id": 47, "value": 10, "created_at": "2025-09-02T10:07:21.797Z", "student_id": 2, "subject_id": 10, "teacher_id": 3, "updated_at": "2025-09-02T10:07:21.797Z"}, {"id": 48, "value": 9, "created_at": "2025-09-02T10:07:28.836Z", "student_id": 4, "subject_id": 10, "teacher_id": 3, "updated_at": "2025-09-02T10:07:28.836Z"}], "quizzes": [], "students": [{"id": 4, "name": "Prenume2 Nume2", "email": "student2@example.com"}, {"id": 2, "name": "Prenume1 Nume1", "email": "student1@example.com"}], "homeworks": [], "materials": [], "assignments": [{"subject_id": 10, "teacher_id": 3, "subject_name": "English", "teacher_name": "Prenume1 Nume1"}], "attendances": [{"id": 37, "date": "2025-08-19", "status": "absent", "user_id": 4, "period_id": 2, "created_at": "2025-09-02T10:07:39.875Z", "updated_at": "2025-09-02T10:07:39.875Z", "assignment_id": 25}, {"id": 38, "date": "2025-08-19", "status": "absent", "user_id": 2, "period_id": 2, "created_at": "2025-09-02T10:07:39.899Z", "updated_at": "2025-09-02T10:07:39.899Z", "assignment_id": 25}, {"id": 39, "date": "2025-08-26", "status": "present", "user_id": 4, "period_id": 2, "created_at": "2025-09-02T10:07:54.034Z", "updated_at": "2025-09-02T10:07:54.034Z", "assignment_id": 25}], "quiz_answers": [], "quiz_submissions": [], "timetable_entries": [{"id": 25, "weekday": "tuesday", "class_id": 1, "period_id": 2, "class_name": "tmp_12D", "subject_id": 10, "teacher_id": 3, "period_label": "09:00–09:50", "subject_name": "English", "teacher_name": "Prenume1 Nume1", "assignment_id": 25}], "homework_submissions": []}	2025-09-02 11:11:21.592079	2025-09-02 11:11:21.592079
57	2	2022-2023	2025-09-02 12:38:28.00639	{"grades": [], "quizzes": [], "students": [{"id": 14, "name": "Prenume8 Nume8", "email": "student8@example.com"}], "homeworks": [], "materials": [], "assignments": [], "attendances": [], "quiz_answers": [], "quiz_submissions": [], "timetable_entries": [], "homework_submissions": []}	2025-09-02 12:38:28.036479	2025-09-02 12:38:28.036479
58	9	2022-2023	2025-09-02 12:38:28.107263	{"grades": [], "quizzes": [], "students": [{"id": 12, "name": "Prenume6 Nume6", "email": "student6@example.com"}, {"id": 11, "name": "Prenume5 Nume5", "email": "student5@example.com"}], "homeworks": [], "materials": [], "assignments": [], "attendances": [], "quiz_answers": [], "quiz_submissions": [], "timetable_entries": [], "homework_submissions": []}	2025-09-02 12:38:28.127128	2025-09-02 12:38:28.127128
60	13	2022-2023	2025-09-02 12:38:28.219023	{"grades": [], "quizzes": [], "students": [{"id": 8, "name": "Prenume4 Nume4", "email": "student4@example.com"}, {"id": 5, "name": "Prenume3 Nume3", "email": "student3@example.com"}], "homeworks": [], "materials": [], "assignments": [], "attendances": [], "quiz_answers": [], "quiz_submissions": [], "timetable_entries": [], "homework_submissions": []}	2025-09-02 12:38:28.228153	2025-09-02 12:38:28.228153
61	7	2022-2023	2025-09-02 12:38:28.254108	{"grades": [], "quizzes": [], "students": [{"id": 10, "name": "a", "email": "a@a.a"}, {"id": 16, "name": "A A ", "email": "a@aa.a"}, {"id": 15, "name": "aaa", "email": "aaa@a.a"}], "homeworks": [], "materials": [], "assignments": [], "attendances": [], "quiz_answers": [], "quiz_submissions": [], "timetable_entries": [], "homework_submissions": []}	2025-09-02 12:38:28.315207	2025-09-02 12:38:28.315207
62	18	2022-2023	2025-09-02 12:38:28.332144	{"grades": [], "quizzes": [], "students": [], "homeworks": [], "materials": [], "assignments": [], "attendances": [], "quiz_answers": [], "quiz_submissions": [], "timetable_entries": [], "homework_submissions": []}	2025-09-02 12:38:28.336195	2025-09-02 12:38:28.336195
63	2	2023-2024	2025-09-02 14:18:47.160457	{"grades": [], "quizzes": [], "students": [{"id": 14, "name": "Prenume8 Nume8", "email": "student8@example.com"}], "homeworks": [], "materials": [], "class_name": "12A", "assignments": [], "attendances": [], "quiz_answers": [], "quiz_submissions": [], "timetable_entries": [], "homework_submissions": []}	2025-09-02 14:18:47.183824	2025-09-02 14:18:47.183824
64	16	2023-2024	2025-09-02 14:18:47.275612	{"grades": [], "quizzes": [], "students": [], "homeworks": [], "materials": [], "class_name": "11A", "assignments": [], "attendances": [], "quiz_answers": [], "quiz_submissions": [], "timetable_entries": [], "homework_submissions": []}	2025-09-02 14:18:47.280605	2025-09-02 14:18:47.280605
65	13	2023-2024	2025-09-02 14:18:47.299543	{"grades": [], "quizzes": [], "students": [{"id": 8, "name": "Prenume4 Nume4", "email": "student4@example.com"}, {"id": 5, "name": "Prenume3 Nume3", "email": "student3@example.com"}], "homeworks": [], "materials": [], "class_name": "4A", "assignments": [], "attendances": [], "quiz_answers": [], "quiz_submissions": [], "timetable_entries": [], "homework_submissions": []}	2025-09-02 14:18:47.303879	2025-09-02 14:18:47.303879
66	7	2023-2024	2025-09-02 14:18:47.320121	{"grades": [], "quizzes": [], "students": [{"id": 10, "name": "a", "email": "a@a.a"}, {"id": 16, "name": "A A ", "email": "a@aa.a"}, {"id": 15, "name": "aaa", "email": "aaa@a.a"}], "homeworks": [], "materials": [], "class_name": "4B", "assignments": [], "attendances": [], "quiz_answers": [], "quiz_submissions": [], "timetable_entries": [], "homework_submissions": []}	2025-09-02 14:18:47.325458	2025-09-02 14:18:47.325458
67	18	2023-2024	2025-09-02 14:18:47.341379	{"grades": [], "quizzes": [], "students": [], "homeworks": [], "materials": [], "class_name": "4C", "assignments": [], "attendances": [], "quiz_answers": [], "quiz_submissions": [], "timetable_entries": [], "homework_submissions": []}	2025-09-02 14:18:47.34613	2025-09-02 14:18:47.34613
68	19	2023-2024	2025-09-02 14:18:47.362169	{"grades": [], "quizzes": [], "students": [{"id": 19, "name": "Prenume10 Nume10", "email": "student10@example.com"}], "homeworks": [], "materials": [], "class_name": "1A", "assignments": [], "attendances": [], "quiz_answers": [], "quiz_submissions": [], "timetable_entries": [], "homework_submissions": []}	2025-09-02 14:18:47.366731	2025-09-02 14:18:47.366731
\.


--
-- Data for Name: school_class_subjects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.school_class_subjects (id, school_class_id, subject_id, created_at, updated_at, teacher_id) FROM stdin;
\.


--
-- Data for Name: school_classes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.school_classes (id, name, created_at, updated_at, archived) FROM stdin;
9	12A_2022-2023	2025-08-05 15:52:06.65154	2025-09-02 09:53:04.592546	t
1	12D_2021-2022	2025-08-05 08:56:02.299764	2025-09-02 10:09:08.851241	t
2	12A_2023-2024	2025-08-05 08:56:27.218465	2025-09-02 09:53:04.432503	t
16	12A	2025-08-07 09:03:29.250582	2025-09-02 09:53:04.624965	f
13	5A	2025-08-06 12:09:02.06774	2025-09-02 09:53:04.678452	f
7	5B	2025-08-05 12:26:53.202314	2025-09-02 09:53:04.986539	f
18	5C	2025-08-18 12:13:41.465288	2025-09-02 09:53:05.02912	f
19	2A	2025-09-02 14:12:16.499754	2025-09-02 14:12:16.499754	f
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
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: mariasilaghi
--

COPY public.users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, name, role, created_at, updated_at, jti, school_class_id, graduated) FROM stdin;
4	student2@example.com	$2a$12$XzwVy0q1nSo72Qm4KTN/R.rcGMe65gGDBGtM2P2Ktxk0LjSbSsgZK	\N	\N	\N	Prenume2 Nume2	student	2025-07-31 08:42:59.707431	2025-08-05 12:07:21.681958	e495d043-2857-457a-92e8-5d53c6c99932	1	t
3	teacher1@example.com	$2a$12$.PnUPNW8csYR.AuUbXtETefCb4y9UfBvicDk.nxGeSkZkmIpOhFf.	\N	\N	\N	Prenume1 Nume1	teacher	2025-07-28 19:06:36.611956	2025-07-28 19:06:36.611956	6df41cb8-1863-4ef1-aa38-787bb2822cd9	\N	f
6	teacher2@example.com	$2a$12$gUFR7mboEpkj/QB/rM50PuD1Mpsm3FZPRZwgH/2Fyp6hqhAswJUj2	\N	\N	\N	Prenume2 Nume2	teacher	2025-07-31 10:59:25.431606	2025-07-31 10:59:25.431606	84767bee-957a-411c-bf31-25685ec0915c	\N	f
7	teacher3@example.com	$2a$12$Er/gmT8nldMdzIWAgnTXO.IFLXS4BBuUCiYWKVanR5kQjWj8MHVMS	\N	\N	\N	Prenume3 Nume3	teacher	2025-07-31 12:31:26.962747	2025-07-31 12:31:26.962747	33e0471e-0c38-4a26-b53b-7ac27383b871	\N	f
9	teacher4@example.com	$2a$12$ZkYnUe4MUUe3dBAx3.HjreMF43l59vXEXHO1h6mdahLPs8eKoiYem	\N	\N	\N	Prenume4 Nume4	teacher	2025-07-31 13:15:37.283243	2025-07-31 13:15:37.283243	6f1b8a26-bf33-443c-8d03-2dce7fe5c6bd	\N	f
10	a@a.a	$2a$12$XbdZqI/Bwnl6lqwzM6FKDeaXzeu5opKCZpIb9dPFTDzwsYZJFOfyy	\N	\N	\N	a	student	2025-08-04 09:50:36.694199	2025-08-18 08:12:31.211694	2c0f94af-f1c9-4d4d-9063-b76129a9957f	7	f
16	a@aa.a	$2a$12$1wkWgjqx0nClKXArZPZDG.as3SeAdKH/oTJoWWk8qQWAX2IIg3QZW	\N	\N	\N	A A 	student	2025-08-08 10:33:47.49855	2025-08-18 08:12:32.213328	6193ddf6-0893-4d2a-a1bf-c3eff22c6572	7	f
15	aaa@a.a	$2a$12$EwOvquhz8cWXXbKzqhKMkekUdG4MebSvknp0c1egSH5Wenh3Tc6aO	\N	\N	\N	aaa	student	2025-08-07 09:07:47.336773	2025-08-18 08:12:33.145593	8db25569-2fa1-4b9d-9f78-a98db5d6e14a	7	f
17	teacher5@example.com	$2a$12$o8Eqxq9hW6.Ksjlk9f0vVe0hrgW4s799740KpurM3LmkzEnWWABeS	\N	\N	\N	Prenume5 Nume5	teacher	2025-08-18 12:50:06.644555	2025-08-18 12:50:06.644555	b0d86b5a-4d46-4666-879b-eae48cb262a5	\N	f
18	student9@example.com	$2a$12$pCCxXXrG9WNP2fNLm/WQUulVo8Slw5ee43rW2U2kPxHjUtqgmARle	\N	\N	\N	Prenume9 Nume9	student	2025-08-19 10:00:35.779839	2025-08-19 10:00:35.779839	b78062e9-28e1-4c2f-9e5a-7ff3453eb866	\N	f
20	student11@example.com	$2a$12$ueIvHbHyw5HxIQG1jvesKuckhqGMxT4xbvDKgduNY7Ygsrs2U5YQa	\N	\N	\N	Prenume11 Nume11	student	2025-08-19 10:01:24.345908	2025-08-19 10:01:24.345908	ba02bf57-3f51-4372-a8c7-2dd09105eb41	\N	f
21	student12@example.com	$2a$12$cxm7VTPpF.1xlHBYAqoksOGnm0pnY3IXYrZSPdYazG30BOIMiEUIi	\N	\N	\N	Prenume11 Nume11	student	2025-08-19 10:01:49.192424	2025-08-19 10:01:49.192424	65573742-937a-4d6c-a12f-6d7ea134248e	\N	f
12	student6@example.com	$2a$12$8BKgevrdrQJQMQqpp8ySjOEJPAkM/nsOYQIZtHotrW56tD6mTydiK	\N	\N	\N	Prenume6 Nume6	student	2025-08-06 12:04:03.119397	2025-08-12 08:35:45.821353	54d7514e-adfa-47c4-8b1d-7e6a58937673	9	t
19	student10@example.com	$2a$12$hjfgFJ9XPMeFccJDU7BbA.KO0kITRG2/A4W0Tq6iy5y/hbknp7S6q	\N	\N	\N	Prenume10 Nume10	student	2025-08-19 10:01:05.582109	2025-09-02 14:12:16.516395	86402041-2e8f-4efe-8f9a-1e94678a31a6	19	f
14	student8@example.com	$2a$12$Ad5F0bEr9IG2IulvWYuVz.75r2imS0Oq.788Tgo1YTBDTY/8IEUqa	\N	\N	\N	Prenume8 Nume8	student	2025-08-06 12:04:20.952294	2025-08-18 09:50:21.101444	4e7ec449-8710-4713-88ae-7091a0c0bcd0	2	t
22	student14@example.com	$2a$12$EEA/MC34jQi4sKIBiKEyj.jerIirzukgy5esHz4RXD46McCP00Fae	\N	\N	\N	Prenume14 Nume14	student	2025-08-19 10:02:08.650343	2025-08-19 10:02:08.650343	6c582635-8ce2-4c02-a4ca-75e6528350a1	\N	f
13	student7@example.com	$2a$12$L7N3t1Ktx/rQ7hsO7ub3Z.ff5nxwU5cUFgU/2fPGTBjMKGcKKVMkS	\N	\N	\N	Prenume7 Nume7	student	2025-08-06 12:04:12.217268	2025-08-20 10:58:01.80251	085f09b3-de28-403d-a882-8e7e64253447	\N	f
1	smaria.oana@yahoo.com	$2a$12$fpoFzh2oyPsqOXNvpB8ojexPsAC6qTS72/K.1IymhBkh.RWtY/iXK	\N	\N	\N	Maria Silaghi	admin	2025-07-28 15:31:09.465123	2025-08-05 16:47:42.663066	bd6273c5-192b-4b4d-9854-6322390e97eb	\N	f
8	student4@example.com	$2a$12$z8Zn21OOQXo5utB3d6q1PeyhRAmK/SpijkECBllrovB5No39fJiwG	\N	\N	\N	Prenume4 Nume4	student	2025-07-31 13:11:36.729745	2025-08-06 12:09:02.137573	33d8d76e-6e57-43c4-998d-d9ffd75a51c8	13	f
5	student3@example.com	$2a$12$TwjSaej5hnj/czgAntejZ.R26MdVgMTfaHwQfEkYyVO5HOQ3HPV2S	\N	\N	\N	Prenume3 Nume3	student	2025-07-31 08:45:11.176603	2025-08-06 12:09:02.144089	e8e93875-3336-44a6-8653-a170613e2350	13	f
2	student1@example.com	$2a$12$Asbb7OtC90okR/k.9/OACu5JYX0Mh9z.3XWvIx7EvdFGpx59YaQeS	\N	\N	\N	Prenume1 Nume1	student	2025-07-28 16:11:58.352782	2025-08-06 12:22:14.77476	abf3e309-44c0-4de2-a8c9-785f3dfec2e6	1	t
11	student5@example.com	$2a$12$/0CgG4g7gwgtbLkitiZ1seOtKXi53D3PT.kMNuRZwDLRA0uVzGCL.	\N	\N	\N	Prenume5 Nume5	student	2025-08-06 12:03:53.12276	2025-08-20 10:57:50.956403	9a91a048-94a1-4c86-8c68-a5bf542e1f5e	9	t
\.


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_storage_attachments_id_seq', 28, true);


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_storage_blobs_id_seq', 28, true);


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_storage_variant_records_id_seq', 1, false);


--
-- Name: attendances_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.attendances_id_seq', 39, true);


--
-- Name: grades_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.grades_id_seq', 48, true);


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

SELECT pg_catalog.setval('public.learning_materials_id_seq', 19, true);


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

SELECT pg_catalog.setval('public.school_class_archives_id_seq', 68, true);


--
-- Name: school_class_subjects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.school_class_subjects_id_seq', 25, true);


--
-- Name: school_classes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.school_classes_id_seq', 19, true);


--
-- Name: subjects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subjects_id_seq', 11, true);


--
-- Name: timetable_entries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.timetable_entries_id_seq', 25, true);


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

