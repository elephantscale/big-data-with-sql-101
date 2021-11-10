<link nsarel='stylesheet' href='../assets/css/main.css'/>

[Main Index](../../README.md)

-----

# Lab  Transactional Tables

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

## Step 2: Create a new ORC table

```sql
use MY_NAME_db;

CREATE table transactions_orc as select * from transactions;

```

You have now created a new ORC table.  Let's confirm that is the case:

```sql
describe extended transactions_orc;
```

HINT: examine the field `parameters.transactional_properties`

QUESTION: What data format is the table?



## Step 3: Try to retrieve a row from the ORC table.

```sql
select * from transactions_orc limit 1;
```

You should get the top row from the table.  It *may* look like this:

```console
+----------------------+------------------------------+-----------------------------+------------------------+------------------------+-------------------------+--------------------------+
| transactions_orc.id  | transactions_orc.account_id  | transactions_orc.vendor_id  | transactions_orc.time  | transactions_orc.city  | transactions_orc.state  | transactions_orc.amount  |
+----------------------+------------------------------+-----------------------------+------------------------+------------------------+-------------------------+--------------------------+
| 600001               | 9476                         | 8                           | 2015-01-07 00:00:00    | Springfield            | MA                      | 94.22                    |
+----------------------+------------------------------+-----------------------------+------------------------+------------------------+-------------------------+--------------------------+
1 row selected (0.113 seconds)
```


## Step 4: T

```sql
select * from transactions_orc limit 1;
```

You should get the top row from the table.  It *may* look like this:

```console
+----------------------+------------------------------+-----------------------------+------------------------+------------------------+-------------------------+--------------------------+
| transactions_orc.id  | transactions_orc.account_id  | transactions_orc.vendor_id  | transactions_orc.time  | transactions_orc.city  | transactions_orc.state  | transactions_orc.amount  |
+----------------------+------------------------------+-----------------------------+------------------------+------------------------+-------------------------+--------------------------+
| 600001               | 9476                         | 8                           | 2015-01-07 00:00:00    | Springfield            | MA                      | 94.22                    |
+----------------------+------------------------------+-----------------------------+------------------------+------------------------+-------------------------+--------------------------+
1 row selected (0.113 seconds)
```


## STEP 2:  Run invoices query
Lets run our invoices query as we did in the billing lab the number of rows in the table
```sql
    hive>
  select account_id, SUM(amount) as total from transactions_orc group by account_id order by total desc;
```

This will actually kick off a tez job, and at the end you will get the count.


**Q: CHECK the counter INPUT_RECORDS_PROCESSED **




**Inspect the YARN Resource Manager UI.  Can you spot your query?**


## Step 3: Now let us try a top 10 query

Now let's try a top 10 query.

```sql
  select account_id, SUM(amount) as total from transactions_orc group by account_id order by total desc limit 10;
```

Did the query generate a tez job?  Should it have done that?


## Step 5: Enable vectorization

```sql
set hive.vectorized.execution.enabled = true;
```

## Step 6: Rerun the query with explain

Try rerunning the query

```sql
  explain vectorization select account_id, SUM(amount) as total from transactions_orc group by account_id order by total desc limit 10;
```

**Q: CHECK the counter INPUT_RECORDS_PROCESSED **

Why was the input records processed so different for the vectorized executionj

## Step 6: Rerun the query with explain vectorization

Try rerunning the query

```sql
  explain vectorization select account_id, SUM(amount) as total from transactions_orc group by account_id order by total desc limit 10;
```


You should see a section called `EXPLAIN VECTORIZATION`






