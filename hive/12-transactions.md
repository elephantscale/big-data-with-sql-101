<link rel='stylesheet' href='../assets/css/main.css'/>

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

## Step 2: Create a new transactional table

```sql
use MY_NAME_db;

CREATE table transactions_orc as select * from transactions;

```

You have now created a new transactional table.  Let's confirm that is the case:

```sql
describe extended transactions_orc;
```

HINT: examine the field `parameters.transactional_properties`

QUESTION: What data format is the table?



## Step 3: Try to retrieve a row from the transactional table.

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

## Step 4: Try to update a row from the transactional table. 

Take the row from step 3, and try to update it (Your query might look slightly different).

```sql
update transactions_orc set vendor_id=9 where id=600001;
```

Now let's try to select the row and see if it appears to be updated again.

```sql
select * from transactions_orc limit 1;
```

Did you get the correct row? Why not?

Let's try that again:

**==>TODO: Try to retrieve the row you just updated**

```sql
select ????  from transactions_orc WHERE ???;
```


## Step 5: Take a look at the files to see the delta files. 

Drop out of hive client

```bash
sudo -u hdfs hdfs dfs -ls /warehouse/tablespace/managed/hive/MY_NAME_db.db/transactions_orc
```

You should see some of the delta files.


## Step 6: Force a compaction

We can force a compaction like this:

```sql
ALTER TABLE transactions_orc COMPACT 'minor';
```

Go ahead and force a compaction.


## Step 7: Try to delete a row.

**=> TODO: Go ahead and try to delete the row you just updated**

```sql
DELETE FROM transactions_orc WHERE ???
```

Now try to retrieve the row.

