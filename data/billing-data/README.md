# Generating Data

how to generate billing data files and load them in HDFS

### Data Format

CSV log format

timestamp,  customer_id,   resource_id,  qty,   cost

For a sample see this: [an example](./sample.csv )


### STEP 1)

    create your home directory in HDFS
        for hadoop 1
            $ hadoop dfs -mkdir <your name>
        for hadoop 2
            $ hdfs dfs -mkdir <your name>
        e.g
            $ hdfs dfs -mkdir sujee

    create hdfs directory to store logs
            $  hdfs dfs -mkdir <your name>/billing/in
    e.g :   $  hdfs dfs -mkdir sujee/billing/in
    
    
this will create a dir in `/user/<login_name>/<yourname>/billing/in`


### STEP 2) copy sample data into HDFS
    $  cd  HI-labs/data/billing-data
    $  hdfs dfs -put sample.txt   <your name>/billing/in/


### STEP 3 ) Generating more data
    run python script
        $  cd  HI-labs/data/billing-data
        $  python gen-billing-data.py

this will generate a bunch of log files in the current dir


### STEP 4) copy the files into hdfs
    $ hdfs dfs -put *.log   <your name>/billing/in/

    verify files
        $ hdfs dfs -ls <your name>/billing/in

