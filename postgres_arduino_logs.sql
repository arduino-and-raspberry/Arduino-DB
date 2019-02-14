CREATE TABLE arduino.logs
(
    id bigint DEFAULT nextval('arduino.logs_id_seq'::regclass) PRIMARY KEY NOT NULL,
    "Who" varchar(255),
    ac boolean,
    lan boolean,
    lasttemperature integer,
    lasthumidity integer,
    servertime time(0),
    lastсontacttime time(0),
    lastсontactdate date,
    current integer,
    amperage integer,
    power integer,
    consuming bigint
);
COMMENT ON COLUMN arduino.logs."Who" IS 'Кто записал значение? Источник? Варианты: Ардуино, Тест, Сервер';
COMMENT ON COLUMN arduino.logs.ac IS 'Сеть 220 есть?';
COMMENT ON COLUMN arduino.logs.lan IS 'LAN есть или нет?';
COMMENT ON COLUMN arduino.logs.lasthumidity IS 'Влажность';
COMMENT ON COLUMN arduino.logs.servertime IS 'Серверное время';
COMMENT ON COLUMN arduino.logs.lastсontacttime IS 'Время последнего контакта';
COMMENT ON COLUMN arduino.logs.lastсontactdate IS 'Дата последнего контакта';
COMMENT ON COLUMN arduino.logs.current IS 'Напряжение';
COMMENT ON COLUMN arduino.logs.amperage IS 'Сила тока';
COMMENT ON COLUMN arduino.logs.power IS 'Можность (W)';
COMMENT ON COLUMN arduino.logs.consuming IS 'Энергопотребление (Wh)';
INSERT INTO arduino.logs (id, who, ac, lan, lasttemperature, lasthumidity, servertime, lastсontacttime, lastсontactdate, current, amperage, power, consuming) VALUES (1, 'Test', true, true, -3, 67, '14:00:00', '14:00:00', '2019-02-05', 220, 16, 40, 101);
INSERT INTO arduino.logs (id, who, ac, lan, lasttemperature, lasthumidity, servertime, lastсontacttime, lastсontactdate, current, amperage, power, consuming) VALUES (2, 'Test', true, true, -5, 60, '20:00:00', '20:00:00', '2019-02-05', 220, 16, 40, 102);
INSERT INTO arduino.logs (id, who, ac, lan, lasttemperature, lasthumidity, servertime, lastсontacttime, lastсontactdate, current, amperage, power, consuming) VALUES (450, 'Arduino', true, true, -9, 89, '14:15:39', '08:00:00', '2019-02-01', 220, 10, 60, 105);
INSERT INTO arduino.logs (id, who, ac, lan, lasttemperature, lasthumidity, servertime, lastсontacttime, lastсontactdate, current, amperage, power, consuming) VALUES (400, 'Arduino', true, true, -9, 89, '12:25:50', '02:00:00', '2019-01-01', 220, 10, 60, 105);
INSERT INTO arduino.logs (id, who, ac, lan, lasttemperature, lasthumidity, servertime, lastсontacttime, lastсontactdate, current, amperage, power, consuming) VALUES (500, 'Arduino', true, true, -9, 89, '14:50:25', '23:00:00', '2018-09-12', 220, 10, 60, 105);
INSERT INTO arduino.logs (id, who, ac, lan, lasttemperature, lasthumidity, servertime, lastсontacttime, lastсontactdate, current, amperage, power, consuming) VALUES (600, 'Arduino', true, true, -9, 89, '15:00:52', '15:00:00', '2019-02-06', 220, 10, 60, 105);
INSERT INTO arduino.logs (id, who, ac, lan, lasttemperature, lasthumidity, servertime, lastсontacttime, lastсontactdate, current, amperage, power, consuming) VALUES (550, 'Arduino', true, true, -9, 89, '14:53:33', '16:08:00', '2019-02-06', 220, 10, 60, 105);
INSERT INTO arduino.logs (id, who, ac, lan, lasttemperature, lasthumidity, servertime, lastсontacttime, lastсontactdate, current, amperage, power, consuming) VALUES (23, 'Test', true, true, -50, 80, '06:00:00', '06:00:00', '2019-02-07', 220, null, null, null);
INSERT INTO arduino.logs (id, who, ac, lan, lasttemperature, lasthumidity, servertime, lastсontacttime, lastсontactdate, current, amperage, power, consuming) VALUES (1200, 'Arduino', true, true, -9, 89, '11:08:38', '02:00:00', '2019-02-03', 220, 10, 60, 105);
INSERT INTO arduino.logs (id, who, ac, lan, lasttemperature, lasthumidity, servertime, lastсontacttime, lastсontactdate, current, amperage, power, consuming) VALUES (1250, 'Arduino', true, true, -9, 89, '11:15:52', '02:00:00', '2019-02-07', 220, 10, 60, 105);
INSERT INTO arduino.logs (id, who, ac, lan, lasttemperature, lasthumidity, servertime, lastсontacttime, lastсontactdate, current, amperage, power, consuming) VALUES (1450, 'Arduino', true, true, -9, 89, '12:50:11', '12:50:00', '2019-02-07', 220, 10, 60, 105);
INSERT INTO arduino.logs (id, who, ac, lan, lasttemperature, lasthumidity, servertime, lastсontacttime, lastсontactdate, current, amperage, power, consuming) VALUES (1601, 'ARDUINO', true, true, -9, 89, '15:43:51', '14:50:00', '2019-02-07', 220, 10, 60, 105);
INSERT INTO arduino.logs (id, who, ac, lan, lasttemperature, lasthumidity, servertime, lastсontacttime, lastсontactdate, current, amperage, power, consuming) VALUES (1602, 'ARDUINO', true, true, -9, 89, '15:44:32', '15:44:00', '2019-02-07', 220, 10, 60, 105);
INSERT INTO arduino.logs (id, who, ac, lan, lasttemperature, lasthumidity, servertime, lastсontacttime, lastсontactdate, current, amperage, power, consuming) VALUES (1603, 'REST: NO PING', false, false, 0, 0, '15:59:39', '15:59:39', '2019-02-07', 0, 0, 0, 0);
INSERT INTO arduino.logs (id, who, ac, lan, lasttemperature, lasthumidity, servertime, lastсontacttime, lastсontactdate, current, amperage, power, consuming) VALUES (1604, 'ARDUINO', true, true, -9, 89, '16:02:18', '16:01:00', '2019-02-07', 220, 10, 60, 105);
INSERT INTO arduino.logs (id, who, ac, lan, lasttemperature, lasthumidity, servertime, lastсontacttime, lastсontactdate, current, amperage, power, consuming) VALUES (1750, 'ARDUINO', true, true, -9, 89, '18:07:49', '18:07:00', '2019-02-07', 220, 10, 60, 105);
INSERT INTO arduino.logs (id, who, ac, lan, lasttemperature, lasthumidity, servertime, lastсontacttime, lastсontactdate, current, amperage, power, consuming) VALUES (1800, 'ARDUINO', true, true, -9, 89, '18:17:18', '18:17:00', '2019-02-07', 220, 10, 60, 105);