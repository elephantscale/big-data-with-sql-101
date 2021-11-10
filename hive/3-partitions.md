<link rel='stylesheet' href='../assets/css/main.css'/>

[Main Index](../README.md)

---

# Lab  Hive Partitions

## Step 1: Start Hive Shell
```bash

    $   hive

    hive>   
        show databases;
```
## Step 2: Stage the data in HDFS
We can load data into Hive
* from local computers
* and from HDFS
We will stage our data in HDFS.

Execute these in hive shell.  

**=> TODO: Fix 'MY_NAME' in table definition below**

```
hive>
  -- make an staging directory
  dfs  -mkdir -p MY_NAME/staging/  ;

  -- copy some files into staging
  dfs -cp /data/transactions/in/transaction-2015-01-01.csv    MY_NAME/staging/  ;

  dfs -cp /data/transactions/in/transaction-2015-01-02.csv    MY_NAME/staging/  ;
  
  -- see files in staging dir
  dfs -ls -R   MY_NAME/staging/ ;
```

## Step 3: Create partition table

**=> TODO: Fix 'MY_NAME' in table definition below**

```sql
    hive>
        set hive.cli.print.current.db=true;

        use MY_NAME_db;

        CREATE EXTERNAL TABLE transactions_p (
           id STRING,
            `timestamp` TIMESTAMP,
            mti STRING,
            card_number STRING,
            amount_customer DECIMAL (10,2),
            merchant_type STRING,
            merchant_id STRING,
            merchant_address STRING,
            ref_id STRING,
            amount_merchant  DECIMAL (10,2),
            response_code STRING)
        PARTITIONED BY (dt STRING)
        ROW FORMAT DELIMITED
        FIELDS TERMINATED BY ','
        stored as textfile
        LOCATION '/user/LOGIN_NAME/MY_NAME/transactions/in-part/'  ; -- <-- change LOGIN_NAME & MYNAME

        -- For CentOS LOGIN_NAME = ec2-user
        -- for Ubuntu LOGIN_NAME = ubuntu
        -- MY_NAME = use your name, something unique


        -- see table structure
        DESC transactions_p;

        select * from transactions_p limit 10;
        -- should return no rows

        -- display partitions
        show partitions transactions_p;

```


## STEP 4: Load data into partitions
In this step, we are going to load data into partitions.

```sql
    hive>
        load data inpath 'MY_NAME/staging/transaction-2015-01-01.csv' INTO TABLE transactions_p partition (dt='2015-01-01');

        load data inpath 'MY_NAME/staging/transaction-2015-01-02.csv' INTO TABLE transactions_p partition (dt='2015-01-02');

```

Note :  We have to specify the partition.

**Check the files in staging directory, notice they have been moved**

```
    hive>
        dfs -ls -R  MY_NAME/staging/ ;
```

## STEP 5:  Using partitions
Lets run some queries using partitions
```sql
    hive>   
        -- display partitions
        show partitions transactions_p;

        -- count all data in table
        select count(*) from transactions_p;

        -- partition specific
        select count(*) from transactions_p where dt='2015-01-01';
        select count(*) from transactions_p where dt='2015-01-02';
```

**=>Note the count results.**


## STEP 6:  Verify data layount in HDFS
```
    hive>
      dfs -ls -R   /user/LOGIN_NAME/MY_NAME/transactions/in-part/ ;
```
