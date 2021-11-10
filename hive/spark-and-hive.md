# Hive And Spark

## Working Directory


## Depends On
Previous Hive Labs

## Step 1 : Login to Dev Environment
Follow instructions for your environment.

We will run Hive Shell and Spark Shell simultaneously.  So we would need at least 2 terminals.  So create at least 2 login terminals.


## Step 2 : In Terminal 1 : Start Hive Shell
```
    $   hive
```

Inspect the tables and run a query on an existing table

```sql
    hive>
            show tables;

            select * from MY_TABLE limit 10;

            -- run an aggregate query
            select X, count(*) as Y from MY_TABLE group by X;
```


## Step 3 : In Terminal 2 Start Spark shell

```
    $    spark-shell
```

Type this in Spark Shell
```
    sc.setLogLevel("WARN")
```

Go to Spark Shell UI (port 4040)


## Step 4 : Inspect Hive Tables
Do this in Spark-Shell

```
    scala>

        sqlContext.tableNames

        val t = sqlContext.table("MY_TABLE")

        t.printSchema

        t.show

        sqlContext.sql("select * from MY_TABLE limit 10").show

        sqlContext.sql("run the same aggregate query here").show
```

