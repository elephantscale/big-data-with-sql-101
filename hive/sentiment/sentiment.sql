-- TOOD: Be sure to change MY_NAME to your name

ADD JAR ../../lib/json-serde/json-serde-1.1.6-SNAPSHOT-jar-with-dependencies.jar;

-- TODO: change this to your nmae
USE MY_NAME;


-- Clean up tweets
CREATE VIEW tweets_simple AS
SELECT
  id,
  cast ( from_unixtime( unix_timestamp(concat( '2013 ', substring(created_at,5,15)), 'yyyy MMM dd hh:mm:ss')) as timestamp) ts,
  text,
  user_s.time_zone 
FROM tweets_raw
;

-- Compute sentiment
create view l1 as select id, words from tweets_raw lateral view explode(sentences(lower(text))) dummy as words;
create view l2 as select id, word from l1 lateral view explode( words ) dummy as word ;

-- was: select * from l2 left outer join dict d on l2.word = d.word where polarity = 'negative' limit 10;

create view l3 as select 
    id, 
    l2.word, 
    case d.polarity 
      when  'negative' then -1
      when 'positive' then 1 
      else 0 end as polarity 
 from l2 left outer join dictionary d on l2.word = d.word;
 
 create table tweets_sentiment stored as orc as select 
  id, 
  case 
    when sum( polarity ) > 0 then 'positive' 
    when sum( polarity ) < 0 then 'negative'  
    else 'neutral' end as sentiment 
 from l3 group by id;

-- put everything back together and re-number sentiment
CREATE TABLE tweetsbi 
STORED AS ORC
AS
SELECT 
  t.*,
  case s.sentiment 
    when 'positive' then 2 
    when 'neutral' then 1 
    when 'negative' then 0 
  end as sentiment  
FROM tweets_simple t LEFT OUTER JOIN tweets_sentiment s on t.id = s.id;


-- context n-gram made readable
CREATE TABLE twitter_3grams
STORED AS ORC
AS
SELECT year, month, day, hour, snippet 
FROM
( SELECT
    year,
    month,
     day,
     hour,
     context_ngrams(sentences(lower(text)), array("iron","man","3",null,null,null), 10) ngs
  FROM tweets_raw group by year,month,day, hour 
) base
 LATERAL VIEW
     explode(  ngs  ) ngsTab AS snippet -- ngsTab is random alias => must be there even though not used
; 

