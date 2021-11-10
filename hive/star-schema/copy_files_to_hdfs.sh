#!/bin/bash

## TODO 1 :
##      - replace 'MY_NAME' with your name
##       - replace LOGIN_NAME also (e.g. ec2-user  or ubuntu)
##
##    Hint : 
##      - Use a text editor's 'replace' option to change MY_NAME  & LOGIN_NAME appropriately. 
##      - In vim do :1,$s/MY_NAME/your name/g


hdfs dfs -mkdir -p MY_NAME/schema
hdfs dfs -mkdir -p MY_NAME/schema/ClickStream_Fact
hdfs dfs -mkdir -p MY_NAME/schema/ClickStream_Date_Dimension
hdfs dfs -mkdir -p MY_NAME/schema/ClickStream_Session_Dimension
hdfs dfs -mkdir -p MY_NAME/schema/ClickStream_Customer_Dimension
hdfs dfs -mkdir -p MY_NAME/schema/ClickStream_UserAgent_Dimension
hdfs dfs -mkdir -p MY_NAME/schema/ClickStream_IPAddress_Dimension
hdfs dfs -mkdir -p MY_NAME/schema/ClickStream_Page_Dimension

hdfs dfs -put ../../data/click-stream-multi-table/clickstream_customer_dim.csv MY_NAME/schema/ClickStream_Customer_Dimension 
hdfs dfs -put ../../data/click-stream-multi-table/clickstream_date_dim.csv MY_NAME/schema/ClickStream_Date_Dimension 
hdfs dfs -put ../../data/click-stream-multi-table/clickstream_fact.csv MY_NAME/schema/ClickStream_Fact
hdfs dfs -put ../../data/click-stream-multi-table/clickstream_ip_address_dim.csv MY_NAME/schema/ClickStream_IPAddress_Dimension
hdfs dfs -put ../../data/click-stream-multi-table/clickstream_page_dim.csv MY_NAME/schema/ClickStream_Page_Dimension
hdfs dfs -put ../../data/click-stream-multi-table/clickstream_session_dim.csv MY_NAME/schema/ClickStream_Session_Dimension
hdfs dfs -put ../../data/click-stream-multi-table/clickstream_useragent_dim.csv MY_NAME/schema/ClickStream_UserAgent_Dimension

