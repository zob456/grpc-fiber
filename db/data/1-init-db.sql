CREATE SCHEMA IF NOT EXISTS perch;

SET SCHEMA 'perch';

CREATE TYPE role as ENUM ('admin', 'member', 'trainer', 'staff', 'facility manager', 'regional manager');

CREATE TABLE IF NOT EXISTS "user"
(
    "user_ID"                uuid PRIMARY KEY NOT NULL,
    user_firstname           text             NOT NULL,
    user_middlename          text             NOT NULL,
    user_lastname            text             NOT NULL,
    user_gender              varchar(1)       not null,
    "user_DOB"               timestamp        not null,
    title                    text,
    role                     role             NOT NULL,
    password                 text             not null,
    active                   boolean          NOT NULL,
    "primary_facility_ID"    uuid             NOT NULL,
    created_at               timestamp        NOT NULL,
    modified_at              timestamp,
    "modified_by_userID"     uuid,
    "emergency_contact_ID_1" uuid             NOT NULL,
    "emergency_contact_ID_2" uuid,
    user_email               text             NOT NULL,
    dark_theme               boolean          NOT NULL DEFAULT true,
    sik                      text
    );

CREATE TABLE IF NOT EXISTS emergence_contact
(
    "emergency_contact_ID"       uuid PRIMARY KEY NOT NULL,
    emergency_contact_firstname  text             NOT NULL,
    emergency_contact_middlename text             NOT NULL,
    emergency_contact_lastname   text             NOT NULL,
    emergency_contact_email      text             NOT NULL
);

CREATE TABLE IF NOT EXISTS user_address
(
    "user_ID"      uuid PRIMARY KEY NOT NULL REFERENCES "user" ("user_ID"),
    address_line_1 text             NOT NULL,
    address_line_2 text,
    city           text             NOT NULL,
    state          varchar(2)       NOT NULL,
    postal_code    integer          NOT NULL,
    country        text             NOT NULL
    );

CREATE TABLE IF NOT EXISTS user_phone
(
    "user_ID"     uuid PRIMARY KEY NOT NULL REFERENCES "user" ("user_ID"),
    country_code  integer          NOT NULL,
    mobile_number bigint           NOT NULL,
    home_number   bigint,
    work_number   bigint
    );

CREATE TABLE IF NOT EXISTS facility
(
    "facility_ID"  uuid PRIMARY KEY NOT NULL,
    client_db_name text             NOT NULL UNIQUE
);

CREATE OR REPLACE VIEW "vw_User" as
SELECT u."user_ID",
       user_firstname,
       user_lastname,
       active,
       "user_DOB",
       role,
       title,
       user_email,
       country_code,
       mobile_number,
       address_line_1,
       address_line_2,
       city,
       state,
       postal_code,
       country,
       "primary_facility_ID",
       created_at,
       modified_at,
       "modified_by_userID",
       "emergency_contact_ID_1",
       "emergency_contact_ID_2",
       password,
       sik
FROM "user" u
         LEFT JOIN user_address ua on u."user_ID" = ua."user_ID"
         LEFT JOIN user_phone up on u."user_ID" = up."user_ID"
         LEFT JOIN facility f on u."primary_facility_ID" = f."facility_ID"