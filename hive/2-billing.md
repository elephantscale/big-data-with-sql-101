<link rel='stylesheet' href='../assets/css/main.css'/>

[Main Index](../README.md)

-----
# Lab Hive Customer Billing

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

## STEP 2:  Run query
Lets count the number of rows in the table
```sql
    hive>
        select count(*) from transactions;
```

This will actually kick off a mapreduce job, and at the end you will get the count.

**Q : how many mappers and how many reducers?**   

**Q : Can you explain how to do count(*) in MR?**  

**Inspect the YARN Resource Manager UI.  Can you spot your query?**


## STEP 3: Query data
Calculate total invoice for each account.  
Hint : group by `account_id`

```sql
    >
    select account_id, SUM(amount) as total from transactions  group by ???  limit 10;
```


## STEP 4: Find top 10 spending customers
What is the query?

## STEP 5: Calculate accounts totals by month
```sql
    >
    select account_id, YEAR(`time`) as year, MONTH(time) as month, SUM(amount) as total from transactions group by ???? limit 10;
```


## STEP 6:  Creating invoice table
We want to save the calculated invoices into a table.

Create an invoice table as follows:

```sql
    >
     -- change MY_NAME

    CREATE EXTERNAL TABLE invoices (
        account_id INT,
        total INT)
    ROW FORMAT DELIMITED
    FIELDS TERMINATED BY ','
    stored as textfile
    LOCATION '/user/LOGIN_NAME/MY_NAME/invoices' ; -- <-- change LOGIN_NAME & MY_NAME

    -- For CentOS LOGIN_NAME = ec2-user
    -- for Ubuntu LOGIN_NAME = ubuntu
    -- MY_NAME = use your name, something unique

```



## STEP 7:  Save results into invoice table
Here is the query:

```sql
    >

    INSERT OVERWRITE TABLE invoices
       ??? select query goes here (from step 3) ???   ;

    select * from invoices limit 10;

```

