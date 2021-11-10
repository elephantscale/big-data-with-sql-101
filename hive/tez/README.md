[<< back to main index](../README.md)

Lab 3.1 : Introduction to Tez With Vectorization With Hive
===================

### Overview
Getting Started on Tez on Hive

### Builds on
None

### Run time
approx. 10 minutes

### Working directory
`hadoop-adv-labs/3-hive/3.1-tez`

### File

### Note
Replace `MY_NAME` appropriately throughout the lab.

----------------------------
STEP 0:  Setup 'Clickstream' data
----------------------------
Setup data using this lab : [setup-data](../../setup-data.md).  
You can skip this step if you had done it already.

----------------------------
STEP 1: CREATE a Database with your name.
----------------------------
To create a database:
```sql
    hive>
          CREATE DATABASE MY_NAME; -- Change to your name.
```

To use the database
```sql
    hive>    USE MY_NAME;
```


----------------------------
STEP 2:  Set Up Domain Data
----------------------------

**==> Examine Domain Data data**  
The data file is in [data/click-stream/clickstream.csv](../../data/click-stream/domaininfo.csv)

The __domain-info__ data that looks like this:

```
amazon.com,SHOPPING
bbc.co.uk,NEWS
facebook.com,SOCIAL
flickr.com,PHOTO
foxnews.com,NEWS
google.com,SEARCH
```

**==> Copy domaininfo data into HDFS, as follows**   
(If you had already done this, you may skip this)
```bash
    $   cd ~/MY_NAME/hadoop-adv-labs/3-hive/3.1-tez/

    # create a hive 
    $   hdfs   dfs  -mkdir -p  MY_NAME/clickstream/domains

    # copy domain data into HDFS
    $   hdfs   dfs  -put  ../../data/click-stream/domain-info.csv   MY_NAME/clickstream/domains
```
----------------------------
STEP 4: CREATE THE TABLES
----------------------------

**Edit file  : `create_table_clickstream.q`**  
**Edit file  : `create_table_domaininfo.q`**  
**Complete the TODOs in both files**  
**Save and run them as follows**  

if you have not already created a hive table for clicksteam, do that
```bash
    $ hive -f create_table_clickstream.q
```

Then, for domaininfo
```bash
    $ hive -f create_table_domaininfo.q
```

After this you should have two tables as follows:
```sql
  hive>
        USE MY_NAME;
        show tables;
```

and get the response:

```console
        clickstream
        domains
```

----------------------------
STEP 5: Verify Data in Both Tables
----------------------------

Start Hive, then run:

```sql
   hive>
	    USE MY_NAME;
        select * from clickstream  LIMIT 10;
        select * from domains  LIMIT 10;
```


----------------------------
STEP 6: Perform Mapreduce join
----------------------------
First, let's ensure we are running with Mapreduce (mr) not tez

**==> TODO : Set the following config property**  

```console
    hive> 
            set hive.execution.engine=mr;
```

**==> TODO : Execute the following SQL**  
**==> TODO : fix MY_NAME**

```sql
    hive> 
            select clickstream.*, domains.*
                from clickstream join domains on
                (clickstream.domain = domains.domain)
                limit 10;
```

**==> TODO : Note the Time it takes**  
This will be at the end: as follows:
```console
  Time Taken: 47.000 seconds, Fetched: 8000 rows;
```

----------------------------
STEP 7: Perform Tez join
----------------------------
Now instead of running in MapReduce, let's try Tez. This should
execute in fewer stages.

```
   hive> 
        set hive.execution.engine=tez;
```

**==> TODO : fix MY_NAME**  

```sql
    hive> 
        select clickstream.*, domains.*
                from clickstream join domains on
                (clickstream.domain = domains.domain)
                limit 10;
```


**==> TODO : Note the Time it takes**  
This will be at the end.
```console
   Time Taken: xxx.xxx seconds.

```

**==> TODO : Note the Time it takes**  

Was it faster?


Check out the YARN web UI.  Try to find your job.  Look under
the application type: it should say TEZ not MAPREDUCE.

----------------------------
STEP 8:Hot Containers
----------------------------
Tez contains a feature called hot containers, which allows 
new steps to recycle the containers of the old ones.

**==> TODO : Try running the same query again.**  
```sql
    hive> 
            select clickstream.*, domains.*
                from clickstream join domains on
                (clickstream.domain = domains.domain)
                limit 10;
```

**==> TODO : Note the Time it takes**  
Was it faster?  It should probably be faster.

----------------------------
STEP 9:Vectorization
----------------------------
We can play with Vectorization, which should make things faster.
Vectorization only works with ORC format, so create a new table in
ORC format.  
(If you had already done this, skip this step.)  
**==> TODO : Execute the following CREATE TABLE command**  

```sql
    hive> 
          use MY_NAME;  -- use your db

          create table clickstream_orc STORED AS ORC as
          select * from clickstream;
```

**==> TODO : Execute the following GROUP BY Aggregation**  
   
```sql
    hive>  
            select clickstream_orc.*, domains.*
                from clickstream join domains on
                (clickstream_orc.domain = domains.domain)
                limit 10;
```

**==> TODO : Note the Time it takes**  

Now try with the new orc table. It should be somewhat faster.


**==> TODO : Execute the following code**  

```sql
    hive> 
          select userid, SUM(cost) as total from clickstream_orc
          GROUP BY customer_id  LIMIT 10;
```

**==> TODO : Note the Time it takes**  

TODO: Now let's turn on Vectorization.
```sql
    hive> 
            set hive.vectorized.execution.enabled;

            select userid, SUM(cost) as total from clickstream_orc GROUP BY userid LIMIT 10;
```

**==> TODO : Note the Time it takes; it should be faster. **  

Did it run with Vectorization?  Let's see:


**==> TODO : Execute the following EXPLAIN:**  

```sql
    hive> 
          explain select userid, SUM(cost) as total from clickstream_orc GROUP BY userid;
```

Check out the plan. At the beginning it should say:
     Execution Mode: vectorized


