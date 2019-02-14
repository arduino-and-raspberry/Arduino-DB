create table logs
(
	id bigint default nextval('arduino.logs_id_seq'::regclass) not null
		constraint logs_pkey
			primary key,
	"Who" varchar(255),
	ac boolean,
	lan boolean,
	lasttemperature integer,
	lasthumidity integer,
	servertime time(0),
	"lastсontacttime" time(0),
	"lastсontactdate" date,
	current integer,
	amperage integer,
	power integer,
	consuming bigint
)
;

comment on column logs."Who" is 'Кто записал значение? Источник? Варианты: Ардуино, Тест, Сервер'
;

comment on column logs.ac is 'Сеть 220 есть?'
;

comment on column logs.lan is 'LAN есть или нет?'
;

comment on column logs.lasthumidity is 'Влажность'
;

comment on column logs.servertime is 'Серверное время'
;

comment on column logs."lastсontacttime" is 'Время последнего контакта'
;

comment on column logs."lastсontactdate" is 'Дата последнего контакта'
;

comment on column logs.current is 'Напряжение'
;

comment on column logs.amperage is 'Сила тока'
;

comment on column logs.power is 'Можность (W)'
;

comment on column logs.consuming is 'Энергопотребление (Wh)'
;


create table temperature
(
	id integer default nextval('arduino.temp_id_seq'::regclass) not null,
	name varchar(255),
	temperature double precision,
	datecreated timestamp(0),
	timecreated time(0),
	test date
)
;

create table temperature_copy
(
	id integer default nextval('arduino.temp_id_seq'::regclass) not null,
	name varchar(255),
	temperature double precision,
	datecreated timestamp(0),
	timecreated time(0),
	test date
)
;

create function update_user_created_date() returns trigger
	language plpgsql
as $$
BEGIN
 IF TG_OP='INSERT' THEN
       NEW.datecreated = now();
    END IF;
 RETURN NEW;
 END;
$$
;

create sequence logs_id_seq
;

create sequence temp_id_seq
;



--Добавляем Autoincremental Sequence для таблицы
CREATE SEQUENCE arduino.logs_id_seq   INCREMENT 1   MAXVALUE 9223372036854775807 CACHE 1;
ALTER TABLE arduino.logs_id_seq   OWNER TO postgres;
ALTER TABLE arduino.logs ALTER COLUMN id SET DEFAULT nextval('arduino.logs_id_seq');
UPDATE arduino.logs SET id = nextval('arduino.logs_id_seq');





