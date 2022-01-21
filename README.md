<link rel='stylesheet' href='assets/css/main.css'/>

#  Big Data with SQL 101 Labs


## Setup
 * [Setup](./setup.md)


## Labs

 * [0. HDFS Intro](hdfs/1-hdfs-intro.md)
 * [1. Hive Intro](hive/1-intro.md)
 * [2. Star Schema](hive/star-schema/README.md)
 * [3. Hive Billing](hive/2-billing.md)
 * [4. Hive Functions](hive/5-stats.md)
 * [5. Hive UDF](hive/udf/README.md)
 * [6. Views](hive/13-materialized-views.md)
 * [7. Hive Partitions](hive/3-partitions.md)
 * [8. Hive Joins](hive/4-join.md)
 * [9. Tez](hive/tez/README.md)



## Sylabus

* [Course Syllabus](https://degreed.com/pathway/79xx73jw9k?orgsso=visa)


## HDP Sandbox

You have been instructed in your [Setup](./setup.md) to use the HDP sandbox.


## Changing Beeline logging level

```bash
cd MY_NAME
cp /etc/hive/conf/beeline-log4j2.properties.template beeline-log4j2.properties
```

Use vi or nano to edit the file, and change line 22 to the following:

```console
property.hive.log.level = INFO
```

By default it should be WARN

