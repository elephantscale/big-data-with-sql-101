<link rel='stylesheet' href='../assets/css/main.css'/>

[Main Index](../../README.md)

-----

# Lab  Hive Joins

## Step 1 : Launch Hive client

Read  [hive clients](../README.md) for more details.

### Option 1 : Hive Shell
```sql

    $   hive
    hive>   
        set hive.cli.print.current.db=true;
        show databases;
        use MY_NAME_db;
        show tables;

```

### Option 2 : Beeline Shell
```sql

    $  beeline
    beeline>   
        !connect jdbc:hive2://
        -- no user/password, just hit enter for user / pass
        show databases;
        -- connect to your db
        !connect jdbc:hive2:///MY_NAME_db;  -- change MY_NAME accordingly
        show tables;
```

## Step 2 : Inspect Tables

```sql
    -- in hive or beeline shell >

        set hive.cli.print.header=true;
        set hive.cli.print.current.db=true;

        show databases;
        use MY_NAME_db;

        show tables;

        desc transactions;
        desc vendors;

        select * from transactions limit 10;
        select * from vendors limit 10;
```

## Step 3 : Join 'transactions' and 'rewards' table

```sql
    >
        select transactions.*,  rewards.* from transactions join rewards on (transactions.merchant_id = rewards.merchant_id) limit 10;
```

## Step 4 : More Joins

Find the sum of all rewards by card number:

```sql
    >
        select  transactions.card_number  SUM(???) as rewards
        from transactions join ??? on (transactions.merchant_id = rewards.merchant_id) group by ??? ;
```


**How would you find the sum of all reward by merchant??** 

## Step 5:  Pretty Print

Pretty print the numbers displayed.

Hint : checkout [format_number](https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF) function

