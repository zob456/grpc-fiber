SET SCHEMA 'perch';

DO
$$
    DECLARE
        record_creator   uuid default '76da9c9e-2113-44b7-9d76-34b3451ee6e7';
        noah_uid         uuid default '99287b16-0277-4177-93a9-aaeb01be2184';
        jacob_uid        uuid default '47391fab-ad0a-4a12-b682-d483223353eb';
        sam_uid          uuid default 'f0a2724d-fc3e-4ab7-9634-22a3c16dfbaf';
        facility_uuid_1    uuid default '23e0edd1-4c16-413e-8610-6f6bd02b5e6d';
        facility_uuid_2    uuid default '24866993-5870-44a1-aea1-2b9217b287ec';
        noah_DOB         timestamp DEFAULT '1991-10-19 12:06:51.105987';
        jacob_DOB        timestamp DEFAULT '1989-10-19 12:06:51.105987';
        sam_DOB          timestamp DEFAULT '1989-10-19 12:06:51.105987';
        noah_created_at  timestamp DEFAULT '2021-10-19 12:06:51.105987';
        jacob_created_at timestamp DEFAULT '2021-10-19 12:06:51.105987';
        sam_created_at   timestamp DEFAULT '2021-10-19 12:06:51.105987';
    BEGIN

        -- Create users
        INSERT INTO perch."user"("user_ID", user_firstname, user_middlename, user_lastname, user_gender,
                                 "user_DOB",
                                 title, role,
                                 password, active, "primary_facility_ID", created_at, modified_at,
                                 "modified_by_userID",
                                 "emergency_contact_ID_1", "emergency_contact_ID_2", user_email, dark_theme)
        VALUES (noah_uid, 'Noah', 'Danger', 'Dreyer', 'M', noah_DOB, 'PERCH', 'admin', 'password',
                true, facility_uuid_1, noah_created_at, noah_created_at, record_creator, jacob_uid, null,
                'noah@helloperch.com', true),
               (jacob_uid, 'Jacob', 'Danger', 'Specht', 'M', jacob_DOB, 'PERCH', 'admin', 'password',
                true, facility_uuid_1, jacob_created_at, jacob_created_at, record_creator, noah_uid, null,
                'jacob@helloperch.com',
                false),
               (sam_uid, 'Sam', 'Ops', 'Spade', 'F', sam_DOB, 'member', 'member', 'password',
                true, facility_uuid_2, sam_created_at, sam_created_at, record_creator, noah_uid, jacob_uid,
                'samspade@gmail.com',
                true);


-- Create user addresses
        INSERT INTO perch.user_address("user_ID", address_line_1, address_line_2, city, state, postal_code,
                                       country)
        VALUES (noah_uid, '123 Perch Dr.', null, 'Clearwater', 'FL', 33764, 'USA'),
               (jacob_uid, '123 Perch Dr.', null, 'Chicago', 'IL', 60187, 'USA'),
               (sam_uid, '8781 St. James Pl.', 'apt. 1A', 'New York', 'NY', 10001, 'USA');

-- Create user phone numbers
        INSERT INTO perch.user_phone("user_ID", country_code, mobile_number, home_number, work_number)
        VALUES (noah_uid, 1, 2019839034, null, null),
               (jacob_uid, 1, 6305559098, null, null),
               (sam_uid, 1, 2125551358, null, null);

-- Create user phone numbers
        INSERT INTO perch.facility("facility_ID", client_db_name)
        VALUES (facility_uuid_1, 'beta'),
               (facility_uuid_2, 'ninja');

    END
$$;