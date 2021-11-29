-- TODO 1 : replace 'MY_NAME' with your username
-- TODO 2 : replace 'LOGIN_NAME' with actual login name

-- use your own database
use MY_NAME_db;

CREATE EXTERNAL TABLE accounts (
    id INT,
    accountNo INT,
    bankID INT,
    first_name STRING,
    last_name STRING,
    email STRING,
    gender STRING,
    address STRING,
    city STRING,
    state STRING,
    zip STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
stored as textfile
LOCATION '/data/accounts/in/'  ;
