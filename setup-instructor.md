<link rel='stylesheet' href='assets/css/main.css'/>

# Instructor Setup

### To be completed by Instructor

## 1 - Copy labs to cluster
```bash
    # target dir is :  ~/a
    rsync -avz -e ssh hadoop-labs   user@HADOP-HOST
    #or
    scp -r hadoop-labs   user@HADOOP_HOST
```

## 2 - Execute the setup script

``` bash
    $  cd  ~/hadoop-labs/scripts

    $  ./setup-data.sh
```

## 3 - Verify data in HDFS UI
In HDFS UI, go to `/data` directory.
