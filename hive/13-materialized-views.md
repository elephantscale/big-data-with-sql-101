<link rel='stylesheet' href='../assets/css/main.css'/>

[Main Index](../../README.md)

-----
# Lab Hive Materialized Views

**Note : Replace MY_NAME appropriately throughout the lab.**

**Hint : To see column names set the following property in hive shell**
```sql
    hive>   set hive.cli.print.header=true;
```



## STEP 1: Launch Hive shell, and inspect the tables
### Option 1 : Hive client
```sql
    $ hive
    hive >
        set hive.cli.print.current.db=true;
        show databases;
        use MY_NAME_db;
        show tables;

```

### Option 2 : Beeline client
```sql
    $ beeline
    beeline >   
            !connect jdbc:hive2:///MY_NAME_db;  -- change MY_NAME
            show tables;

```

## STEP 2:  Run invoices query
Lets run our invoices query as we did in the billing lab the number of rows in the table
```sql
    hive>
  select account_id, SUM(amount) as total from transactions group by account_id;
```

This will actually kick off a tez job, and at the end you will get the count.

**Q : how many mappers and how many reducers?**   


**Inspect the YARN Resource Manager UI.  Can you spot your query?**


## Step 3: Create materialized view:

```sql
create materialized view mv_invoices
as
select account_id, sum(amount) as total from transactions_orc group by account_id order by total desc;
```

## Step 4: Now let us try a top 10 query

Now let's try a top 10 query.

```sql
  select account_id, SUM(amount) as total from transactions_orc group by account_id order by total desc limit 10;
```

Did the query generate a tez job?  Should it have done that?

## Step 5: Enable query rewrite

```sql
ALTER MATERIALIZED VIEW mv_invoices enable rewrite;
```

## Step 6: Rerun the query

Try rerunning the query

```sql
  select account_id, SUM(amount) as total from transactions_orc group by account_id order by total desc limit 10;
```

What happened?  Did a tez job run?  

You should have seen the results returned immediately.

