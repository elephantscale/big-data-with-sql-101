-- TODO : update MY_NAME


use MY_NAME_db;

CREATE EXTERNAL TABLE offers (
    start_date STRING,
    end_date STRING,
    vendor_id INT ,
    discount DOUBLE)
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
STORED AS TEXTFILE
LOCATION '/data/offers/in-json/'  ;