-- ## TODO 1 :
--      - replace 'MY_NAME' with your name
--        - replace LOGIN_NAME also (e.g. ec2-user  or ubuntu)

--    Hint : 
--      - Use a text editor's 'replace' option to change MY_NAME  & LOGIN_NAME appropriately. 
--      - In vim do :1,$s/MY_NAME/your name/g

--TODO: CHANGE MY_NAME to your name *************************************************************
USE MY_NAME;

ADD JAR ../../lib/json-serde/json-serde-1.1.6-SNAPSHOT-jar-with-dependencies.jar;

--create the tweets_raw table containing the records as received from Twitter

DROP TABLE tweets_raw;

CREATE EXTERNAL TABLE tweets_raw (
   id BIGINT,
   created_at STRING,
   source STRING,
   favorited BOOLEAN,
   retweet_count INT,
   retweeted_status STRUCT<
      text:STRING,
      user_s:STRUCT<screen_name:STRING,name:STRING>>,
   entities STRUCT<
      urls:ARRAY<STRUCT<expanded_url:STRING>>,
      user_mentions:ARRAY<STRUCT<screen_name:STRING,name:STRING>>,
      hashtags:ARRAY<STRUCT<text:STRING>>>,
   text STRING,
   user_s STRUCT<
      screen_name:STRING,
      name:STRING,
      friends_count:INT,
      followers_count:INT,
      statuses_count:INT,
      verified:BOOLEAN,
      utc_offset:STRING, -- was INT but nulls are strings
      time_zone:STRING>,
   in_reply_to_screen_name STRING,
   year int,
   month int,
   day int,
   hour int
)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
LOCATION '/user/ec2-user/MY_NAME/sentiment/in'
;

-- create sentiment dictionary
CREATE EXTERNAL TABLE dictionary (
    type string,
    length int,
    word string,
    pos string,
    stemmed string,
    polarity string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' 
STORED AS TEXTFILE
LOCATION '/user/ec2-user/MY_NAME/sentiment/dictionary';
