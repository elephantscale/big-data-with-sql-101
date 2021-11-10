-- ## TODO 1 :
--      - replace 'MY_NAME' with your name
--        - replace LOGIN_NAME also (e.g. ec2-user  or ubuntu)

--    Hint : 
--      - Use a text editor's 'replace' option to change MY_NAME  & LOGIN_NAME appropriately. 
--      - In vim do :1,$s/MY_NAME/your name/g


-- TODO type USE MY_NAME; before runnig this script

USE MY_NAME;

DROP TABLE ClickStream_Fact;
DROP TABLE ClickStream_Page_Dimension;
DROP TABLE ClickStream_Date_Dimension;
DROP TABLE ClickStream_Session_Dimension;
DROP TABLE ClickStream_Customer_Dimension;
DROP TABLE ClickStream_UserAgent_Dimension;
DROP TABLE ClickStream_IPAddress_Dimension;


CREATE EXTERNAL TABLE ClickStream_Fact 
(Date_Key INT, Session_Key INT, Customer_Key INT, IPAddress_Key INT, 
    UserAgent_Key INT, Page_Key INT, Referrer_Page_Id INT, NUM_ERRORS INT,
    KBytes_Downloaded INT, Browsing_Time INT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ","
LOCATION '/user/ec2-user/MY_NAME/schema/ClickStream_Fact/';

CREATE EXTERNAL TABLE ClickStream_Page_Dimension 
(Page_Key INT, Page_Name STRING, Page_Sub_Domain STRING, Page_Domain STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ","
LOCATION '/user/ec2-user/MY_NAME/schema/ClickStream_Page_Dimension/';

CREATE EXTERNAL TABLE ClickStream_Date_Dimension 
(Date_Key INT, Date_ts STRING, Date_Val STRING, Date_Description STRING, Calendar_Month_Number_In_Year  INT, Calendar_Day INT, Calendar_Year INT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ","
LOCATION '/user/ec2-user/MY_NAME/schema/ClickStream_Date_Dimension/';

CREATE EXTERNAL TABLE ClickStream_Session_Dimension 
(Session_Key INT, Session_Num STRING, Session_Start_Time STRING, Session_End_Time STRING, Duration INT, Server_IP STRING, Client_IP STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ","
LOCATION '/user/ec2-user/MY_NAME/schema/ClickStream_Session_Dimension/';

CREATE EXTERNAL TABLE ClickStream_Customer_Dimension 
(Customer_Key INT, Customer_Name STRING, Customer_Email STRING, Sex STRING, Annual_Income INT, City STRING, State STRING, Country STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ","
LOCATION '/user/ec2-user/MY_NAME/schema/ClickStream_Customer_Dimension/';

CREATE EXTERNAL TABLE ClickStream_UserAgent_Dimension 
(UserAgent_Key INT, Browser_Name STRING, Browser_Version STRING, Operating_System STRING, Agent_Language STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ","
LOCATION '/user/ec2-user/MY_NAME/schema/ClickStream_UserAgent_Dimension/';

CREATE EXTERNAL TABLE ClickStream_IPAddress_Dimension 
(IPAddress_Key INT, IPAddress_Val STRING, City STRING, State STRING, Country STRING) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ","
LOCATION '/user/ec2-user/MY_NAME/schema/ClickStream_IPAddress_Dimension/';

