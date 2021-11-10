<link rel='stylesheet' href='../assets/css/main.css'/>

[Main Index](../README.md)

-----

# Lab: Row Storage vs Columnar storage


### Overview
Compare Row Storage Vs Columnar Sorage

### Builds on
None

### Run time
approx. 15 minutes

### Note
Tez only works on Hortonworks Hadoop distribution


## Step 1: Launch Hive Shell
```bash
    $  hive
    # or beeline
```

```sql
hive>
            set hive.cli.print.current.db=true;

            use MY_NAME_db;
```



## Step 2 : Create a Parquet table

In Hive Shell
```sql
hive>
    CREATE TABLE transactions_parquet STORED AS PARQUETFILE
    AS SELECT * FROM transactions;

    show tables;

    DESCRIBE FORMATTED transactions_parquet;
```

**=> Note the time took to create Parquet table**

**=> Note the table size of  the Parquet table from 'DESCRIBE' command**

## Step 2 : Create ORC Table

In Hive Shell
```sql
hive>
    CREATE TABLE transactions_orc STORED AS ORC
    AS SELECT * FROM transactions;

    show tables;

    DESCRIBE FORMATTED transactions_orc;
```

**=> Note time time took to create the ORC table**

**=> Note the table size of  the ORC table from 'DESCRIBE' command**


## STEP 3: Do some benchmarking
Let's do an aggregate query on the tables and compare performance.

### Query 1 : Simple aggregate (MAX)
Let's find MAX(amount_customer) from all tables.  
**=> Note the query time for all tables**

```sql  
    -- CSV table
    SELECT MAX(amount_customer) FROM transactions;

    -- parquet
    SELECT MAX(amount_customer) FROM transactions_parquet;

    -- ORC
    SELECT MAX(amount_customer) FROM transactions_orc;
```

### Query 2 : Top-10 customers

**=> Note the query time for all tables**

```sql
    /* csv */
    SELECT account_id, SUM(amount_customer) AS total FROM transactions
    GROUP BY account_id ORDER BY total DESC LIMIT 10;

    /* parquet */
    SELECT account_id, SUM(amount_customer) AS total FROM transactions_parquet
    GROUP BY account_id ORDER BY total DESC LIMIT 10;

    /* ORC */
    SELECT account_id, SUM(amount_customer) AS total FROM transactions_orc
    GROUP BY account_id ORDER BY total DESC LIMIT 10;
```

## Step 4: Discuss Your Findings
