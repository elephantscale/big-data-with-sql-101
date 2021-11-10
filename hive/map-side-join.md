<link rel='stylesheet' href='../assets/css/main.css'/>

[Main Index](../../README.md)

-----

# Lab: Map Side Joins

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

## Step 3 : Join 'transactions' and 'vendors' table as a reduce side join

```sql
    > set hive.auto.convert.join=false;
        select transactions.*,  vendors.* from transactions join vendors on (transactions.vendor_id = vendors.id) limit 10;
```

## Step 3 : Join 'transactions' and 'vendors' table as a map side join

```sql
    > set hive.auto.convert.join=true;
        select transactions.*,  vendors.* from transactions join vendors on (transactions.vendor_id = vendors.id) limit 10;
```

