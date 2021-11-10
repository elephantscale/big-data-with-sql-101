<link rel='stylesheet' href='../assets/css/main.css'/>

[Main Index](../../README.md)

---

# Lab Analyzing Text Data


## Datasets To Analyze
We have the following text data.  
Click on the links to download the text.
- [moby-dick.txt](../data/text/moby-dick.txt) : The classic novel
- [sotu-2014-obama.txt](../data/text/sotu-2014-obama.txt) : State of the Union address 2014
- [FOMC20080916meeting.txt](../data/text/FOMC20080916meeting.txt) : Feds emergency meeting after 2008 financial crisis  (un-classified after 5 years)

## STEP 1: Instructor only  : Stage Data in HDFS

```bash
    $   cd   ~/MYNAME/hadoop-dev/

    # SOTU
    hdfs  dfs  -mkdir  -p /data/text_sotu
    hdfs  dfs  -put  data/text/sotu-2014-obama.txt   /data/text_sotu/

    # Moby Dick
    hdfs  dfs  -mkdir  -p /data/text_moby
    hdfs  dfs  -put  data/text/moby-dick.txt   /data/text_moby/

    # FOMC
    hdfs  dfs  -mkdir  -p /data/text_fomc
    hdfs  dfs  -put  data/text/FOMC20080916meeting.txt    /data/text_fomc/

```


## STEP 2: Create a hive tables
Launch Hive shell

```bash
    $   hive
```

Create text tables in Hive shell.

```sql

hive>
        set hive.cli.print.current.db=true;

        use MY_NAME_db;

        create external table sotu (
            line string)
        row format delimited
        fields terminated by '\n'
        stored as textfile
        location '/data/text_sotu' ;

        create external table moby (
            line string)
        row format delimited
        fields terminated by '\n'
        stored as textfile
        location '/data/text_moby' ;

        create external table fomc (
            line string)
        row format delimited
        fields terminated by '\n'
        stored as textfile
        location '/data/text_fomc' ;


```

##  STEP 3: Examine Data In Tables
Examine the data in text table
```sql
    hive>

        select * from moby limit 10;
```


## STEP 4: N-grams / Bi-grams
Find the most occuring bigrams (two) in text.  
We are using `explode` function in Hive so the output is formated.

```sql
    hive>
        SELECT explode(ngrams(sentences(lower(line)), 2, 20 )) FROM moby;

        -- try other tables too
```

**=> Q : What are the top bi-grams?**  
**=> Q : Do they offer any insights?**  
Hint : these are called [stop words](https://en.wikipedia.org/wiki/Stop_words) (or filler words)

**=> Q : Find top 2 words for State of The Union**

## STEP 5: Context NGrams

### For Moby-dick:   
What words follow the word `whale`
```sql
        hive>
            SELECT explode(context_ngrams(sentences(lower(line)),
            array("whale", null), 30))
            FROM moby ;
```

###  For State of the union text  
Find the word the follows the word `american`
```sql
    hive>
        SELECT explode(context_ngrams(sentences(lower(line)),
        array("american", null), 30))
        FROM sotu ;
```

### Feds Meeting minute
Find the most used adjective used to describe the word `market`.

```sql
    hive>
        SELECT explode(context_ngrams(sentences(lower(line)),
        array(null, "markets"), 30))
        FROM fomc ;
```

Also find what words follow the word `markets`

## STEP 6: 'Visualizing' text
'Word Clouds' are very interesting way of visualizing text.  
Try these word cloud generators  
- https://www.jasondavies.com/wordcloud/

- Copy paste text from [sotu-2014-obama.txt](../data/text/sotu-2014-obama.txt)   
([alternate link](https://raw.githubusercontent.com/elephantscale/HI-labs/master/hadoop-dev/hive/text/sotu-2014-obama.txt) )
