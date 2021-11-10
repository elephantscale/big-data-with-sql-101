<link rel='stylesheet' href='../assets/css/main.css'/>

[Main Index](../../README.md)

-----
# Lab  Using Hive with Tez and Spark Engines


### Overview
Plugin Tez and Spark engines to Hive.

### Builds on
None

### Run time
approx. 30 minutes

### Note
Tez only works on Hortonworks Hadoop distribution.  
Spark works on pretty much all distributions.


## Step 1: Launch Hive Shell
```bash
    $  hive
    # or beeline
```

## Step 2: Run a simple aggregate query in MR mode
```sql
    hive>
            set hive.cli.print.current.db=true;

            use MY_NAME_db;

            set hive.execution.engine=mr;  

            select account_id, SUM(amount_customer) as total from transactions group by account_id order by total desc limit 10;
```

Note the time taken by query

## Step 3 : Query using Tez

```sql
    hive>
            set hive.execution.engine=tez;  

            select account_id, SUM(amount_customer) as total from transactions group by account_id order by total desc limit 10;
```

Note the time taken.

Run the query again a few times, and notice the time taken.  
Can you explain the behavior?


## Step 4 : Try a Join query
Join transactions & vendors

```sql
    hive>

    set hive.execution.engine=mr;  
    select  vendors.category,  SUM(transactions.amount_customer) as total
        from transactions join vendors on (transactions.vendor_id = vendors.id) group by vendors.category ;
    -- measure the time taken

    set hive.execution.engine=tez;  
    select  vendors.category,  SUM(transactions.amount_customer) as total
        from transactions join vendors on (transactions.vendor_id = vendors.id) group by vendors.category ;
    -- measure the time taken
```

## Step 5 : Using Spark
Spark can be used as an engine as follows.
```sql
    set hive.execution.engine=spark;  
```

Compare Spark performance vs MapReduce.


```sql

        -- use MR
        set hive.execution.engine=mr;  

        select account_id, SUM(amount_customer) as total from transactions group by account_id order by total desc limit 10;
        -- measure time taken

        -- switch to spark
        set hive.execution.engine=spark;  

        select account_id, SUM(amount_customer) as total from transactions group by account_id order by total desc limit 10;
        -- measure time taken

        -- Run the query again, notice the time taken
```
**==> Run the Spark query a couple of times.  Notice what happens to the execution time.  
Can you explain the behavior?**

Now let's try a join query.

```sql

        -- use MR
        set hive.execution.engine=mr;  
        select  vendors.category,  SUM(transactions.amount_customer) as total
            from transactions join vendors on (transactions.vendor_id = vendors.id) group by vendors.category ;
        -- measure time taken

        -- switch to spark
        set hive.execution.engine=spark;  
        select  vendors.category,  SUM(transactions.amount_customer) as total
            from transactions join vendors on (transactions.vendor_id = vendors.id) group by vendors.category ;
        -- measure time taken

```
**==> Run the Spark query a couple of times.  And notice the execution time.**

## Bonus Lab : Comparing Spark & Tez
Use the the join query above to compare performance with Spark & Tez.  
You can switch engines as shown below.  
**==> Do 2-3 runs to get an idea of average time for query**

```sql

        set hive.execution.engine=tez;  
        -- your query here
        -- run your query a couple of times
        set hive.execution.engine=spark;  
        -- your query here
        -- run your query a couple of times
```
