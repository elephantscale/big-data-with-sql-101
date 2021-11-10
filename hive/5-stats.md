<link rel='stylesheet' href='../assets/css/main.css'/>

[Main Index](../../README.md)

-----

# Lab: Hive Stats

### Overview
Basic statistics in hive.

### Run time
approx. 20-30 minutes


## STEP 1:  Find the mean (average) value of transactions by account

Launch Hive shell
```bash
    $  hive
    # or beeline
```

Try these in Hive shell:
```sql
  hive>

    set hive.cli.print.current.db=true;
    set hive.cli.print.header=true;

    use MY_NAME_db;

    -- AVG across all accounts
    select AVG(amount)  from transactions ;

    -- AVG per account
    select account_id,  AVG(amount)  from transactions group by account_id limit 10;
```

## STEP 2:  Find quartiles

```sql
  hive>

    SELECT  explode(percentile_approx(amount,array(0.01,0.20,0.40,0.60,0.80)))
    FROM transactions;
```

Why percentile_approx and not percentile?  Because percentile is not
valid for floating point numbers, only for integer.

Now, we did the percentile by transactions.  How would we do this by
account id?  We have to do a subquery.

```sql
  hive>


   SELECT  explode(percentile_approx(t1.total,array(0.01,0.20,0.40,0.60,0.80)))
    FROM
   (select account_id, sum(amount) as total from
    transactions
    group by account_id) t1
    limit 10;

```

Why does this work?  What are the results?


## STEP 3: Find median value
Having found the mean and quartiles for amounts, what would
the median value be?  Remember, median means 50% is below the
value and 50% above.

HINT: The percentile function will help here.

## STEP 4:  Find mean and quartiles by vendor
We've taken mean and quartile by account id.  How would we do the same by vendor?
