-- ## TODO 1 :
--      - replace 'MY_NAME' with your name
--      - replace LOGIN_NAME also (e.g. ec2-user  or ubuntu)
-- 
--    Hint : 
--      * Use a text editor's 'replace' option to change MY_NAME  & LOGIN_NAME appropriately. 
--      * In vim do :1,$s/MY_NAME/your name/g

-- This is the your database name
USE MY_NAME;


-- CSV source table
CREATE EXTERNAL TABLE clickstream (
    ts BIGINT,
    ip STRING,
    userid STRING,
    action STRING,
    domain STRING,
    campaign_id STRING,
    cost INT,
    session_id STRING )
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
stored as textfile
LOCATION '/user/LOGIN_NAME/MY_NAME/clickstream/in'  ;
