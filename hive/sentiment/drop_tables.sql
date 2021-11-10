-- ## TODO 1 :
--      - replace 'MY_NAME' with your name
--        - replace LOGIN_NAME also (e.g. ec2-user  or ubuntu)

--    Hint : 
--      - Use a text editor's 'replace' option to change MY_NAME  & LOGIN_NAME appropriately. 
--      - In vim do :1,$s/MY_NAME/your name/g

USE MY_NAME;

DROP TABLE IF EXISTS tweets_raw;
DROP TABLE IF EXISTS tweets_raw;
DROP TABLE IF EXISTS dictionary;
DROP VIEW IF EXISTS tweets_simple;
DROP VIEW IF EXISTS tweets_clean;
DROP VIEW IF EXISTS l1;
DROP VIEW IF EXISTS l2;
DROP VIEW IF EXISTS l3;
DROP TABLE IF EXISTS tweets_sentiment;
DROP TABLE IF EXISTS tweetsbi;
DROP TABLE IF EXISTS twitter_3grams;

