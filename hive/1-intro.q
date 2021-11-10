-- creates Hive tables

-- TODO 1 : replace 'MY_NAME' with your username
-- use your own database
use MY_NAME_db;


    CREATE EXTERNAL TABLE transactions (
            id STRING,
            `timestamp` TIMESTAMP,
            mti STRING,
            card_number STRING,
            amount_customer DECIMAL (10,2),
            merchant_type STRING,
            merchant_id STRING,
            merchant_address STRING,
            ref_id STRING,
            amount_merchant  DECIMAL (10,2),
            response_code STRING
            )
        ROW FORMAT DELIMITED
        FIELDS TERMINATED BY ','
        stored as textfile
        LOCATION '/data/transactions/in'  ;



   CREATE EXTERNAL TABLE rewards (
            vendor_id INT,
            reward_points INT
            )
        ROW FORMAT DELIMITED
        FIELDS TERMINATED BY ','
        stored as textfile
        LOCATION '/data/rewards/in'  ;

