<link rel='stylesheet' href='../assets/css/main.css'/>

[Main Index](../../README.md)

-----

# Lab HIVE-11 Explain Keyword


### Overview
Here we will be doing the explain keyword

### Builds on
All the previous labs

### Run time
approx. 30 minutes

### Note
Tez only works on Hortonworks Hadoop distribution


## Step 1: Query
Here is the query we are going to optimize.  
This one calculates money spent per vendor category (grocery, retail ..etc).

```sql
select SUM(transactions.amount) as total,  vendors.category from transactions join vendors on (transactions.vendor_id = vendors.id) group by vendors.category order by total desc;
```


## Step 2 : Run the query

Start Hive Shell
```bash
  $  hive ```

Switch to your db:

```sql
hive>
  set hive.cli.print.current.db=true;
  set hive.cli.print.header=true;
  use MY_NAME_db;

  explain select SUM(transactions.amount) as total,  vendors.category from transactions join vendors on (transactions.vendor_id = vendors.id) group by vendors.category order by total desc;
```

**=> See what it says for the explain**


## Step 3 : Optimize!

Here are some tips for you
* Change the execution engine to Tez (See [Tez labs](../3.9-tez/README.md) for instructions)
* Use 'map-join / memory-join' (see [join lab](../3.4-join/README.md) for instructions)
* Convert the tables to Parquet or ORC formats (see [Data Formats lab](../3.10-data-formats/README.d))

You can use a combination of all these techniques!

**==> Find the fastest time for query**
