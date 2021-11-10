DROP TABLE IF EXISTS x_clickstream;
CREATE EXTERNAL TABLE x_clickstream (
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
LOCATION '/data/clickstream/in' ;



DROP TABLE IF EXISTS x_domains;
CREATE EXTERNAL TABLE x_domains (
    domain STRING,
    category STRING )
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
stored as textfile
LOCATION '/data/domains/in'    ;


select * from x_clickstream limit 10;
select * from x_domains limit 10;

