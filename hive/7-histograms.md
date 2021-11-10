<link rel='stylesheet' href='../assets/css/main.css'/>

[Main Index](../../README.md)

-----

# Lab Hive Histograms


### Overview
Hive Histograms

### Builds on

### Run time
approx. 20-30 minutes


--------------------------------
STEP 1:  Run a histogram on amount_customers
--------------------------------

Launch Hive shell
```
    $  hive
```

Try these in Hive shell:
```sql
    set hive.cli.print.header=true;
    set hive.cli.print.current.db=true;
    use MY_NAME_db;

    select inline(histogram_numeric(amount_customer, 5)) from transactions;
```

What do the results mean?  How can this be used?

--------------------------------
Step 2: Perform a plot
--------------------------------

Visualize the numbers by creating an excel spreadsheet with the overall histogram numbers


--------------------------------
Step 3: Perform a histogram on account totals
--------------------------------

Find a histogram on account totals. Note that to do this, you have to first generate a table in a subquery
to calcualate account totals, then perform the histogram as in step 1

```sql

select accounts.id, sum(transactions.amount_customer)  from transactions  join accounts on transactions.account_id = accounts.id group by accounts.id
```

-----------------------------------
Step 4: Do a binary binning exercise
-----------------------------------

Sometimes we want to do a binary binning exercise, for example, count transactions above a certain amount_customer and below.  This is a case of fixed-width bins.

Unfortunately, using the histogram_numeric() function becomes difficult in this case, but we can easily do the following;

```sql
   select count(CASE WHEN amount_customer > 15.0 THEN amount_customer END) AS gt_15,
   count(CASE WHEN amount_customer <= 15.0 then amount_customer END) as lt_15 from transactions;
```

How could we figure out the same information PER vendor category?
HINT: Use a group by -- remember that vendor category is in the vendors table
and and not the transactions table and so requires a join.

---------------
Notes
------------

It's possible to the same query as follows:

```sql
select inline(histogram_numeric(amount_customer, 3)) from transactions;
```
