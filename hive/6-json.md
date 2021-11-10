<link rel='stylesheet' href='../assets/css/main.css'/>

[Main Index](../../README.md)

-----

# Lab JSON in Hive

### Overview
Apply offers from offers table


### Run time
approx. 20-30 minutes

## JSON Data (Offers.json)
Our [offers.json](/data/cc-data/offers.json) (click the link to download)
looks like this:

```json
{"start_date": "2015-01-01 00:00:36", "end_date": "2015-01-02 00:00:36", "discount": 0.10, "vendor_id": 5}
{"start_date": "2015-01-02 00:00:36", "end_date": "2015-01-03 00:00:36", "discount": 0.05, "vendor_id": 1}
{"start_date": "2015-01-03 00:00:36", "end_date": "2015-01-04 00:00:36", "discount": 0.20, "vendor_id": 2}
```

## STEP 1:  Prepare Offers Table

### *** Only on Cloudera distribution
You may need to refer to the JSON serde jar. The exact location will vary depending on your distribution.
For example, a recent version of cloudera CDH had the jar in the following location:

```sql
hive>
    ADD JAR /opt/cloudera/parcels/CDH/jars/hive-hcatalog-core-2.1.1-cdh6.3.2.jar
```

If the above doesn't work, please try this:  
On Linux shell...
```bash
    $  find /opt/cloudera/parcels/CDH/jars  | grep hive-hcatalog-core

    ...
    # pick this one  
    /opt/cloudera/parcels/CDH/jars/hive-hcatalog-core-2.1.1-cdh6.3.2.jar

    ...

```

With this you may create your table.

```sql

    $  hive

    hive >
        set hive.cli.print.current.db=true;
        set hive.auto.convert.join = false;

        use MY_NAME_db;

        CREATE EXTERNAL TABLE offers (
            start_date STRING,
            end_date STRING,
            vendor_id INT ,
            discount DOUBLE)
        ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
        STORED AS TEXTFILE
        LOCATION '/data/offers/in-json'  ;
```

## STEP 2:  Inspect Hive tables

```sql
    hive>

        use MY_NAME_db;

        show tables;

        desc offers;

        select * from offers;
```

## STEP 3:  Join
Join `transactions` table and `offers` table.  
Try this in Hive shell:

```sql
    hive>

        select transactions.*,  offers.* from transactions join offers on (transactions.vendor_id = offers.vendor_id) limit 10;
```

Inspect the joined data.

## STEP 4:  Apply the discounts
`offers` table has `discount` field.  
Calculate total money spent on each category.  Try the following query.

```sql
    hive>

        select transactions.*, vendors.*, offers.discount as discount
        from transactions  join vendors on transactions.vendor_id = vendors.id left outer join offers on offers.vendor_id = vendors.id
        limit 10;
```

Now how do we calculate the discounts?  Remember that an arithmetic operation involving null will be null.  That's not what we want.  
