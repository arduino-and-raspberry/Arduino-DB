CREATE TABLE arduino.temperature
(
    id integer DEFAULT nextval('arduino.temp_id_seq'::regclass) NOT NULL,
    name varchar(255),
    temperature double precision,
    datecreated timestamp(0),
    timecreated time(0),
    test date
);
INSERT INTO arduino.temperature (id, name, temperature, datecreated, timecreated, test) VALUES (1, '1', 15.145, null, null, null);
INSERT INTO arduino.temperature (id, name, temperature, datecreated, timecreated, test) VALUES (3, '4', 25.145, null, null, null);
INSERT INTO arduino.temperature (id, name, temperature, datecreated, timecreated, test) VALUES (5, null, 22.144, '2018-10-31 00:00:00', null, null);
INSERT INTO arduino.temperature (id, name, temperature, datecreated, timecreated, test) VALUES (400, 'from REST', 150, '2019-01-25 00:00:00', null, null);
INSERT INTO arduino.temperature (id, name, temperature, datecreated, timecreated, test) VALUES (350, 'from REST', 220, '2019-01-25 00:00:00', null, null);
INSERT INTO arduino.temperature (id, name, temperature, datecreated, timecreated, test) VALUES (300, 'from REST', 50, '2018-10-31 00:00:00', null, null);
INSERT INTO arduino.temperature (id, name, temperature, datecreated, timecreated, test) VALUES (13, 'Test', 15, '2019-01-30 00:00:00', null, null);
INSERT INTO arduino.temperature (id, name, temperature, datecreated, timecreated, test) VALUES (14, 'Test', 18, '2019-01-30 00:00:00', '14:55:06', '2019-01-30');