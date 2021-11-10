<link rel='stylesheet' href='../assets/css/main.css'/>

[Main Index](../README.md)

-----

# Lab: Up and Running With HIve

**Note : Replace MY_NAME appropriately throughout the lab.**

**Hints :**

* To see column names set the following property in hive shell
```sql
        set hive.cli.print.header=true;
```

* To see current DB
```sql
         set hive.cli.print.current.db=true;
```
Hive prompt will indicate the current db.


## Step 0 : Instructor will demo this lab on screen first

## Step 1 : Hive vs. Beeline
There are two shells for interacting with Hive.
* Hive : oldest
* Beeline : newest, faster

Read  [hive clients](../README.md) for more details.

### Hive Shell
```bash

    $   hive

    hive>   show databases;
```

### Beeline Shell
```sql

    $  beeline
    beeline>   
        !connect jdbc:hive2://
        -- no user/password, just hit enter for user / pass
        show databases;

```

## Step 2: Data
### [Transactions.csv](../data/cc-data/transactions.csv) (<- click to download)
```
1,1,5,2015-01-01 00:00:00,El Paso,TX,62.81
2,2,7,2015-01-01 00:00:00,Pittsburgh,PA,157.33
3,2,10,2015-01-01 00:00:01,Austin,TX,14.86
```

### [accounts.csv](../data/cc-data/accounts.csv) (<- click to download)
```
1,1,1,Ryan,Johnston,rjohnston0@mayoclinic.com,Male,5 Hintze Terrace,Laredo,TX,78044
2,2,9,Todd,Martin,tmartin1@europa.eu,Male,878 Sheridan Point,Columbia,SC,29215
3,3,1,Sharon,Martin,smartin2@archive.org,Female,2 Fremont Plaza,Lubbock,TX,79452
```

### [vendors.csv](../data/cc-data/vendors.csv) (<- click to download)
```
1,Walmart,Bentonville,AR,General,2.0
2,Kroger,Cincinatti,OH,Grocery,2.4
3,Starbucks,Seattle,WA,Coffee,1.5
```

## Step 3 : Login to Hadoop cluster
Login to the Hadoop cluster using SSH  (Instructor will provide details).

## Step 4: Start Hive Shell

And fire up Hive shell (Hive / Beeline)

```bash
    $  hive

    # or

    $ beeline
```

## Step 5: Create your own database
Change 'MY_NAME' accordingly.

### Option 1 : Hive
```sql
    hive>    
            set hive.cli.print.current.db=true;
            -- see databases
            show databases;

            -- create your own database
            create database MY_NAME_db;
            show databases;
```

### Option 2 : Beeline
```sql
    beeline >
        set hive.cli.print.current.db=true;
        show databases;
        create database MY_NAME_db;
        !connect jdbc:hive2:///MY_NAME_db; -- change MY_NAME accordingly
        show tables;
```

## STEP 6: Create a Hive tables

Make sure to use your own DB.

### Option 1 : Hive Client
```sql

    hive>
        set hive.cli.print.current.db=true;
        use MY_NAME_db;
        show tables;

```

### Option 2 : Beeline client
```sql
    beeline >
        set hive.cli.print.current.db=true;
        show databases;
        !connect jdbc:hive2:///MY_NAME_db; -- change MY_NAME accordingly
        show tables;
```

### Transactions Table

```sql
    >

    CREATE EXTERNAL TABLE transactions (
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
            response_code STRING
            )
        ROW FORMAT DELIMITED
        FIELDS TERMINATED BY ','
        stored as textfile
        LOCATION '/data/transactions/in'  ;


```

## Rewards table

```sql
    CREATE EXTERNAL TABLE rewards (
            merchant_id INT,
	    reward_points INT
            )
        ROW FORMAT DELIMITED
        FIELDS TERMINATED BY ','
        stored as textfile
        LOCATION '/data/rewards/in'  ;


```


## Step 7: Understand table structure
We can use `DESCRIBE` (short form `DESC`) command to see how tables are structured

```sql
  hive>
      DESC  transactions;
      DESC  rewards;
```

To get more details we can use `EXTENDED` option.

```sql
  hive>
    DESCRIBE EXTENDED transactions;
```

**=> Inspect the 'extended' output**

## STEP 8:  Run queries
Lets see data in table.
```sql
    >  
        set hive.cli.print.header=true;

        show tables;

        select * from transactions limit 10;

        select * from rewards limit 10;

```
