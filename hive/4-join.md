<link rel='stylesheet' href='../assets/css/main.css'/>

[Main Index](../../README.md)

-----

# Lab HIVE-4 : Hive Joins

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

## Step 3 : Join 'transactions' and 'vendors' table

```sql
    >
        select transactions.*,  vendors.* from transactions join vendors on (transactions.vendor_id = vendors.id) limit 10;
```

## Step 4 : More Joins
`vendors` table has `category` field.  
Calculate total money spent on each category.  Update the above join query.  Fill in values for '???'

```sql
    >
        select  vendors.category,  SUM(???) as total
        from transactions join vendors on (transactions.vendor_id = vendors.id) group by ??? ;

```

## Step 5:  Pretty Print

Pretty print the numbers displayed.

Hint : checkout [format_number](https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF) function

## Bonus Lab 1 :  Calculate amount owed to each vendor
In `vendor` table you will find a column `swipe_rate`.  This is the rate they pay to accept credit card payments.

For example,
* if swipe_rate is 3%
* customer paid $1000
* the vendor gets  : $1000 * (1 - 3/100) = $970

Calculate the final amount of money to be paid to each vendor.


## Bonus Lab 2 : Map side Join
Hive can cache small tables in memory.  This will speed up the join operation.

MapJoin syntax is:
```sql

    select /*+ MAPJOIN (small_table) */ big_table.*, small_table.* from ....

    -- for example
    select /*+ MAPJOIN (vendors) */ transactions.*,  vendors.* from .....
```
