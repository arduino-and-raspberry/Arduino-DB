CREATE TABLE arduino.temperature_copy
(
    id integer DEFAULT nextval('arduino.temp_id_seq'::regclass) NOT NULL,
    name varchar(255),
    temperature double precision,
    datecreated timestamp(0),
    timecreated time(0),
    test date
);
INSERT INTO arduino.temperature_copy (id, name, temperature, datecreated, timecreated, test) VALUES (14, 'Test', 18, '2019-01-31 00:00:00', '14:00:06', '2019-01-31');
INSERT INTO arduino.temperature_copy (id, name, temperature, datecreated, timecreated, test) VALUES (13, 'Test', 15, '2019-01-31 10:46:45', '08:00:00', '2019-01-31');
INSERT INTO arduino.temperature_copy (id, name, temperature, datecreated, timecreated, test) VALUES (17, 'Test', 0, '2019-01-31 07:52:10', '20:00:00', '2019-01-31');
INSERT INTO arduino.temperature_copy (id, name, temperature, datecreated, timecreated, test) VALUES (350, 'from REST', 220, '2019-01-30 00:00:00', '14:00:06', '2019-01-30');
INSERT INTO arduino.temperature_copy (id, name, temperature, datecreated, timecreated, test) VALUES (400, 'from REST', 150, '2019-01-29 00:00:00', '14:00:00', '2019-01-29');
INSERT INTO arduino.temperature_copy (id, name, temperature, datecreated, timecreated, test) VALUES (1, '1', 15.145, '2019-01-30 08:13:45', '02:00:00', '2019-01-30');
INSERT INTO arduino.temperature_copy (id, name, temperature, datecreated, timecreated, test) VALUES (3, '4', 25.145, '2019-01-29 08:14:06', '02:00:00', '2019-01-29');
INSERT INTO arduino.temperature_copy (id, name, temperature, datecreated, timecreated, test) VALUES (18, 'Test', -10, '2019-01-31 07:52:54', '02:00:00', '2019-01-31');
INSERT INTO arduino.temperature_copy (id, name, temperature, datecreated, timecreated, test) VALUES (19, 'Test', 3, '2019-02-01 13:42:17', '02:00:00', '2019-02-01');
INSERT INTO arduino.temperature_copy (id, name, temperature, datecreated, timecreated, test) VALUES (20, 'Test', 7, '2019-02-01 13:42:41', '14:00:00', '2019-02-01');
INSERT INTO arduino.temperature_copy (id, name, temperature, datecreated, timecreated, test) VALUES (21, 'Test', 25, '2019-02-05 09:16:29', '02:00:00', '2019-02-05');
INSERT INTO arduino.temperature_copy (id, name, temperature, datecreated, timecreated, test) VALUES (22, 'Test', -30, '2019-02-05 09:17:47', '14:00:00', '2019-02-05');
INSERT INTO arduino.temperature_copy (id, name, temperature, datecreated, timecreated, test) VALUES (1150, 'from REST', -45, null, null, null);