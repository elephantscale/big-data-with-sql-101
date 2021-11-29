-- TODO 1 : replace 'MY_NAME' with your username
-- TODO 2 : replace 'LOGIN_NAME' with actual login name

-- use your own database
use MY_NAME_db;

CREATE EXTERNAL TABLE vendors (
    id INT,
    name STRING,
    city STRING,
    state STRING ,
    category STRING ,
    swipe_rate DOUBLE)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
stored as textfile
LOCATION '/data/vendors/in/'  ;
