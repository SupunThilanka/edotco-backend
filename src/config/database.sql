--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2024-08-11 19:37:00

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
-- TOC entry 221 (class 1259 OID 17092)
-- Name: equipment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.equipment (
    equipment_id integer NOT NULL,
    image_location character varying(255),
    name character varying,
    description character varying(2000)
);


ALTER TABLE public.equipment OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17091)
-- Name: equipment_equipment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.equipment_equipment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.equipment_equipment_id_seq OWNER TO postgres;

--
-- TOC entry 4816 (class 0 OID 0)
-- Dependencies: 220
-- Name: equipment_equipment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.equipment_equipment_id_seq OWNED BY public.equipment.equipment_id;


--
-- TOC entry 218 (class 1259 OID 17058)
-- Name: tower_created; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tower_created (
    creation_id integer NOT NULL,
    latitude character varying(100),
    longitude character varying(100),
    tower_id integer,
    height integer
);


ALTER TABLE public.tower_created OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 17057)
-- Name: tower_created_tower_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.tower_created ALTER COLUMN creation_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tower_created_tower_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 219 (class 1259 OID 17075)
-- Name: tower_equipment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tower_equipment (
    creation_id integer NOT NULL,
    equipment_id integer NOT NULL
);


ALTER TABLE public.tower_equipment OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 17051)
-- Name: tower_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tower_type (
    tower_id integer NOT NULL,
    name character varying(100) NOT NULL,
    image_location character varying(100),
    description character varying(2000),
    height_range character varying(50)
);


ALTER TABLE public.tower_type OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 17050)
-- Name: tower_type_tower_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tower_type_tower_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tower_type_tower_id_seq OWNER TO postgres;

--
-- TOC entry 4817 (class 0 OID 0)
-- Dependencies: 215
-- Name: tower_type_tower_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tower_type_tower_id_seq OWNED BY public.tower_type.tower_id;


--
-- TOC entry 4649 (class 2604 OID 17095)
-- Name: equipment equipment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipment ALTER COLUMN equipment_id SET DEFAULT nextval('public.equipment_equipment_id_seq'::regclass);


--
-- TOC entry 4648 (class 2604 OID 17054)
-- Name: tower_type tower_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tower_type ALTER COLUMN tower_id SET DEFAULT nextval('public.tower_type_tower_id_seq'::regclass);


--
-- TOC entry 4810 (class 0 OID 17092)
-- Dependencies: 221
-- Data for Name: equipment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.equipment (equipment_id, image_location, name, description) FROM stdin;
1	antenna_panel.jpg	Antenna Panel	Essential for transmitting and receiving signals. Mounted on various types of towers.
2	bts.jpg	Base Transceiver Station (BTS)	The core equipment for communication, handling radio communications with mobile devices.
3	rru.jpg	Remote Radio Unit (RRU)	Located near the antenna, this unit amplifies signals to and from the BTS, enhancing signal strength.
4	microwave_dish.jpg	Microwave Dish	Used for point-to-point communication, typically between towers or to a central hub.
5	power_cabinet.jpg	Power Cabinet	Contains power supplies, batteries, and backup systems ensuring uninterrupted operation of the tower equipment.
6	gps_antenna.jpg	GPS Antenna	Provides precise timing and location data for network synchronization.
7	fiber_optic_cable.jpg	Fiber Optic Cable	High-speed data transmission cable, critical for connecting towers to the core network.
8	duplexer.jpg	Duplexer	Allows simultaneous transmission and reception of signals through the same antenna.
9	tower_light.jpg	Tower Light	Ensures the tower is visible to aircraft, enhancing safety.
10	grounding_kit.jpg	Grounding Kit	Protects the tower and equipment from lightning strikes and electrical surges.
\.


--
-- TOC entry 4807 (class 0 OID 17058)
-- Dependencies: 218
-- Data for Name: tower_created; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tower_created (creation_id, latitude, longitude, tower_id, height) FROM stdin;
1	00000000	00000000	1	35
2	89841567	00055454	3	150
3	123	456	6	150
4	111111	000000	3	500
5	111	00000000	2	500
\.


--
-- TOC entry 4808 (class 0 OID 17075)
-- Dependencies: 219
-- Data for Name: tower_equipment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tower_equipment (creation_id, equipment_id) FROM stdin;
1	1
1	2
2	1
2	2
2	3
2	4
2	5
2	6
3	3
3	4
3	5
4	3
4	5
4	7
5	1
5	2
\.


--
-- TOC entry 4805 (class 0 OID 17051)
-- Dependencies: 216
-- Data for Name: tower_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tower_type (tower_id, name, image_location, description, height_range) FROM stdin;
1	Monopole Tower	monopole.jpg	A single tubular pole that supports antennas and radio equipment. Suitable for urban areas due to its minimal footprint.	15-50 meters
2	Lattice Tower	lattice.jpg	A freestanding structure made of steel latticework. Known for its high strength and ability to support multiple antennas.	20-200 meters
3	Guyed Tower	guyed.jpg	A tall, slender structure supported by guy wires. Economical for rural areas where space is not a constraint.	50-600 meters
4	Stealth Tower	stealth.jpg	Designed to blend with the environment, often camouflaged as trees or other structures. Ideal for aesthetic-sensitive locations.	20-40 meters
5	Rooftop Tower	rooftop.jpg	Installed on the rooftops of buildings, saving ground space. Common in dense urban environments.	10-30 meters
6	Self-Supporting Tower	self-supporting.jpg	A robust freestanding structure with a wide base. Suitable for high load capacity requirements.	30-180 meters
7	COW (Cell on Wheels)	cow.jpg	A mobile tower mounted on a truck or trailer. Used for temporary coverage during events or emergencies.	10-30 meters
8	Flagpole Tower	flagpole.jpg	A type of stealth tower that doubles as a flagpole. Blends seamlessly into civic areas.	10-30 meters
9	Microcell Tower	microcell.jpg	A compact tower for boosting coverage in small areas. Often used in urban canyons and inside buildings.	5-20 meters
10	Small Cell Tower	smallcell.jpg	A low-power, short-range tower used to improve coverage and capacity in high-density areas.	5-20 meters
\.


--
-- TOC entry 4818 (class 0 OID 0)
-- Dependencies: 220
-- Name: equipment_equipment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.equipment_equipment_id_seq', 10, true);


--
-- TOC entry 4819 (class 0 OID 0)
-- Dependencies: 217
-- Name: tower_created_tower_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tower_created_tower_id_seq', 5, true);


--
-- TOC entry 4820 (class 0 OID 0)
-- Dependencies: 215
-- Name: tower_type_tower_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tower_type_tower_id_seq', 10, true);


--
-- TOC entry 4655 (class 2606 OID 17111)
-- Name: tower_equipment combine_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tower_equipment
    ADD CONSTRAINT combine_key PRIMARY KEY (creation_id, equipment_id);


--
-- TOC entry 4657 (class 2606 OID 17097)
-- Name: equipment equipment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT equipment_pkey PRIMARY KEY (equipment_id);


--
-- TOC entry 4653 (class 2606 OID 17062)
-- Name: tower_created tower_created_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tower_created
    ADD CONSTRAINT tower_created_pkey PRIMARY KEY (creation_id);


--
-- TOC entry 4651 (class 2606 OID 17056)
-- Name: tower_type tower_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tower_type
    ADD CONSTRAINT tower_type_pkey PRIMARY KEY (tower_id);


--
-- TOC entry 4658 (class 2606 OID 17105)
-- Name: tower_created tower_created_tower_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tower_created
    ADD CONSTRAINT tower_created_tower_id_fkey FOREIGN KEY (tower_id) REFERENCES public.tower_type(tower_id);


--
-- TOC entry 4659 (class 2606 OID 17098)
-- Name: tower_equipment tower_equipment_equipment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tower_equipment
    ADD CONSTRAINT tower_equipment_equipment_id_fkey FOREIGN KEY (equipment_id) REFERENCES public.equipment(equipment_id);


--
-- TOC entry 4660 (class 2606 OID 17080)
-- Name: tower_equipment tower_equipment_tower_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tower_equipment
    ADD CONSTRAINT tower_equipment_tower_id_fkey FOREIGN KEY (creation_id) REFERENCES public.tower_created(creation_id);


-- Completed on 2024-08-11 19:37:01

--
-- PostgreSQL database dump complete
--

