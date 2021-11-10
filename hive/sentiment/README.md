[<< back to main index](../README.md)

Lab :Sentiment Analysis
===================

### Overview
Doing Sentiment Analysis With Hive

### Builds on
None

### Run time
approx. 10 minutes 
### Working directory
`hadoop-adv-labs/3-hive/3.3-sentiment`

### Note
Replace `MY_NAME` appropriately throughout the lab.



----------------------------
STEP 0: Make sure your database exists.
----------------------------

You should already have created your database with
your name (i.e., MY_NAME).  If not, do that.

You can check by saying in hive:

```sql
    hive>
         USE MY_NAME; -- Change to your name.
```

If you need to create it, do the following.

```sql
    hive>
         CREATE DATABASE MY_NAME -- Change to your name.
         USE MY_NAME;
```

----------------------------
STEP 1:  Examine tweets data
----------------------------
Examine json data  in [data/tweets/](../../data/tweets) directory.  
The data is in json format.  
We have 3 tweet datasets:
* [ironman3.json](../../data/tweets/ironman3.json)
* [bmw.json](../../data/tweets/bmw.json)
* [ladygaga.json](../../data/tweets/ladygaga.json)

Here is an example: (somewhat snipped)

```json
{  
   "text":"Iron Man 4: Why Robert Downey Jr. Must Do It - Will's War, Ep. 6: http://t.co/uVSf7CnZ0y via @youtube",
   "lang":"en",
   "entities":{  
      "urls":[  
         {  
            "expanded_url":"http://youtu.be/bMrB9mA7NZ8",
            "indices":[  
               66,
               88
            ],
            "display_url":"youtu.be/bMrB9mA7NZ8",
            "url":"http://t.co/uVSf7CnZ0y"
         }
      ],
      "hashtags":[  

      ],
   },
   "in_reply_to_status_id_str":null,
   "id":330076609535168513,
   "source":"<a href=\"http://twitter.com/tweetbutton\" rel=\"nofollow\">Tweet Button<\/a>",
   "id_str":"330076609535168513",
   "place":null,
   "user":{  
      "location":"Davie, Florida",
      "default_profile":false,
      "profile_banner_url":"https://si0.twimg.com/profile_banners/1355880158/1366081528",
      "id":1355880158,
      "following":null,
      "favourites_count":0,
      "description":"Making tomorrow's Music Today. We are Airlines #HackMan #BushMan #FirstClass #SpadeVillain\r\nPlease subscribe on youtube http://t.co/CVrvPOLnLe",
      "verified":false,
      "default_profile_image":false,
      "id_str":"1355880158",
      "is_translator":false
   },
   "coordinates":null
}
```

Note: all three files came from the same source, so do not be alarmed if some of the tweets seem to be modified or hacked up.

----------------------------
STEP 2:  Copy tweet data into HDFS
----------------------------
**==> Copy tweets data and dictionary into HDFS, as follows **  

```bash
    $   cd ~/MY_NAME/hadoop-sql/hive-adv/sentiment

    $   hdfs   dfs  -mkdir -p  MY_NAME/sentiment/in
    $   hdfs   dfs  -mkdir -p  MY_NAME/sentiment/dictionary

    $   hdfs   dfs  -put  ../../data/tweets/*.json   MY_NAME/sentiment/in/
    $   hdfs   dfs  -put  ../../data/dictionary/dictionary.tsv  MY_NAME/sentiment/dictionary
```

----------------------------
STEP 3: Edit Hive scripts
---------------------------
Edit the following files : 
- `drop_tables.sql`
- `create.sql`
- `sentiment.sql`    
Replace all instances of `MY_NAME`.  
The best way to do this is to open this file in a text editor and use the editor's replace function.  
For vi/vim, you can use the following:
```
    :1,$s/MY_NAME/your name/g
```

**Don't run these files just yet!**  

----------------------------
STEP 3: Clear out (any old) tables
---------------------------
The first time through, this shouldn't be necessary, but if you make a mistake,
you will need to definitely need to do this to get a clean start. 

Do not forget to complete the previous step to put your name where MY_NAME appears!

```bash
    $   hive -f drop_tables.sql
```


---------------------------
STEP 4:  Creating a Hive table on the json data.
---------------------------

So you might think that we need to go through a fancy parsing exercise
to extract fields out the JSON, right?   Well, if you think that,
you would be wrong.  We have a better way: the JSON serde 
(serializer / deserlializer) for hive. 

It is actually in a third party jar, which means that we have to
include the jar.

```sql
    hive> 
      --  for cloudera
      ADD JAR '../../lib/hive-json-serde/1.3.7/cdh5/json-serde-1.3.7-jar-with-dependencies.jar';

      -- for hw
      ADD JAR './../lib/hive-json-serde/1.3.7/hdp23/json-serde-1.3.7-jar-with-dependencies.jar';

      # old ignore
      ADD JAR ../../lib/json-serde/json-serde-1.1.6-SNAPSHOT-jar-with-dependencies.jar;

```

Once we do that, we can easily create the table.

```sql
    hive> 
          USE MY_NAME;
          CREATE TABLE ..... 
          ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
          LOCATION ...
```

The CREATE TABLE is located at the top of `create.sql`.   
We will run this in the next.

Make sure you change MY_NAME to your name in it first.

```bash
    $   hive -f   create.sql
```

---------------------------
STEP 5: Running the sentiment scoring 
---------------------------
The sentiment scoring is a little complex, as we do the entire thing in sql.
Have a look in `sentiment.sql`

When you are ready, go ahead and run `sentiment.sql`

**==> Run Sentient Scoring**  

```bash
    $ hive -f sentiment.sql
```

When done, you can examine the tables and views created.

```sql
    hive> 
          show tables;
          -- or  just to see your table --
          show tables LIKE 'MY_NAME*';
```

```console
    dictionary
    l1
    l2
    l3
    tweets_raw
    tweets_sentiment
    tweets_simple
    tweetsbi
    twitter_3grams
```

---------------------------
STEP 6: Querying and the Sentiment Scoring For BMW
---------------------------

Sentiment scoring gives 
- 0 for a negative tweet, 
- 1 for a neutral tweet, and
- 2 for a positive tweet.

Why not -1, 0, +1?  
Perhaps because even a neutral mention of something should be inferred as mildly positive.
A lot of mentions should be weighed more than just a few mentions even if the few mentions
are positive. So ANY mention of the subject except negative helps the score.

We are looking for 3 subjects:
* BMW
* Lady Gaga
* Iron Man 3

Let us find how many tweets match those subjects.

**==> Execute the following to determine counts of tweets.**  

```sql
    hive>
          select count(*) from tweetsbi;
          select count(*) from tweetsbi WHERE text LIKE '%bmw%';
```

Oops!!  That didn't bring back very many hits.   
Can we make sure case sensitivity doesn't get in our way?  
Check Hive reference here : https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF

**==> Do a count on BMW (case insensitive)**  
Hint : `lower(text)` 


---------------------------
STEP 7: Querying and the Sentiment Scoring For BMW
---------------------------

Now let's overall sentiment score for BMW.

**==> Complete the following and execute it.**  

```sql
    hive> 
          USE MY_NAME;
     
          select SUM(sentiment) from MY_NAME_tweetsbi WHERE text .....;
```

You should get a score. However, the score isn't really very meaningful.
Why?

Because it's not adjusted for the total number of tweets matching.
How can we adjust it?

**==> TODO: Get a WEIGHTED score for BMW.**  
Hint : `SUM(sentiment) / COUNT(*)` will work but...
Hint 2: What is another function that does the same as SUM divided by COUNT?

- Something around 1.0 per tweet would be, neutral. 
- Less than that would be negative.
- greater than 1.0 would be positive.


---------------------------
STEP 8: Complete similar scoring for Lady Gaga and Iron Man 3.
---------------------------

Complete the steps in step 6 and 7 for Lady Gaga and Iron Man 3.

**==> TODO: Get a WEIGHTED score for Lady Gaga and Iron Man 3.**  

Which of the 3 subjects were he most positive?  Which was the least?

**==> TODO: Examine the tweets.**  

Look at the captured tweets (there are only a few hundred).  Does
the sentiment algorithm accurately capture the sentiment in most cases?
What are some of the weaknesses? 

**==> TODO: Find a few examples of tweets that are incorrectly scored.**  


