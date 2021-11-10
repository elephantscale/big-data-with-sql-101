<link rel='stylesheet' href='../assets/css/main.css'/>

[Main Index](../../README.md)

-----

# Hive Quick Intro

## Hive Clients
### 1 - Classic client 'Hive'
Oldest, works reasonably well.
```sql

    $   hive

    hive>
        show databases;
        use MY_db;  -- select a db
        show tables;

```


### 2 - Beeline
New client for Hive2 Server.

```sql
    $  beeline

    beeline>
        -- connecting to default Hive server
        !connect jdbc:hive2://

        -- connecting to specific Hive server
        !connect jdbc:hive2://server_ip:10000

        -- connecting to specific Hive db
        !connect jdbc:hive2:///my_db
        !connect jdbc:hive2://server_ip:10000/my_db

        -- getting help
        !help;
```

### Typical Beeline session
```sql
    beeline>
        !connect jdbc:hive2://
        -- no user / pass, just hit enter at user / pass prompts
        show databases;

        -- connect to a specific db
        !connect jdbc:hive2:///MY_NAME_db;  -- change MY_NAME accordingly
        show tables;

```

### Executing beeline in script mode

```
    $   beeline -u jdbc:hive2://   -n username  -p  password   -f  file.q
```

`beeline --help`  for more options.

## Hints
* **To see column names**  
Set the following property in hive shell
```sql
        set hive.cli.print.header=true;
```

* **To see current DB**  
```sql
         set hive.cli.print.current.db=true;
```
Hive prompt will indicate the current db.

*  **Disabling the logs**  
Start hive in 'silent' mode by supplying '-S' option
```bash
    $   hive -S
```
