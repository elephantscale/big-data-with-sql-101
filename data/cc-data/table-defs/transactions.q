-- TODO 1 : replace 'MY_NAME' with your username
-- TODO 2 : replace 'LOGIN_NAME' with actual login name

-- use correct db
use MY_NAME_db;


CREATE EXTERNAL TABLE transactions (
    id INT,
    account_id INT,
    vendor_id INT,
    time STRING,
    city STRING,
    state STRING ,
    amount DOUBLE)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
stored as textfile
LOCATION '/data/transactions/in/'  ;
