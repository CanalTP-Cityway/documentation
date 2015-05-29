CREATE TABLE journeyplanners (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    api_url character varying(255) NOT NULL,
    api_key character varying(50),
    geo_position_capability boolean,
    stop_capability boolean,
    poi_capability boolean,
    multi_start_arrival_capability integer
);


CREATE TABLE stops (
    id integer NOT NULL,
    journey_planners_id integer NOT NULL,
    registration_number character varying(50) NOT NULL,
    stop_category character varying(255),
    name character varying(255) NOT NULL,
    latitude numeric(19,16) NOT NULL,
    longitude numeric(19,16) NOT NULL,
    long_lat_type character varying(255) NOT NULL,
    x double precision NOT NULL,
    y double precision NOT NULL,
    projection_type character varying(255) NOT NULL
);


CREATE TABLE transitions (
    departure_stop_id integer NOT NULL,
    arrival_stop_id integer NOT NULL,
    duration integer NOT NULL,
    prm_duration integer
);


ALTER TABLE ONLY journeyplanners
    ADD CONSTRAINT journey_planners_pkey PRIMARY KEY (id);


ALTER TABLE ONLY stops
    ADD CONSTRAINT stops_pkey PRIMARY KEY (id);


ALTER TABLE ONLY stops
    ADD CONSTRAINT stops_registration_number_journey_planners_id_key UNIQUE (registration_number, journey_planners_id);


ALTER TABLE ONLY transitions
    ADD CONSTRAINT transition_departure_stop_id_arrival_stop_id_key UNIQUE (departure_stop_id, arrival_stop_id);


ALTER TABLE ONLY transitions
    ADD CONSTRAINT arr_stop_id FOREIGN KEY (arrival_stop_id) REFERENCES stops(id);


ALTER TABLE ONLY transitions
    ADD CONSTRAINT dep_stop_id FOREIGN KEY (departure_stop_id) REFERENCES stops(id);


ALTER TABLE ONLY stops
    ADD CONSTRAINT jou_pla_id FOREIGN KEY (journey_planners_id) REFERENCES journeyplanners(id);

