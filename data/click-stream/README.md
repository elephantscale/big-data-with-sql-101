<link rel='stylesheet' href='../../assets/css/main.css'/>

# ClickStream logs format:

```
timestamp,  user_id,  action,   domain,   campaign_id,  cost,   session
```

* timestamp : (long) milliseconds since epoch
* user_id : (int)
* action : (string) clicked, viewed, blocked
* domain : (string) where the ad was served
* campaign_id : (int) ad campaign id
* cost : (int) cost to serve this ad
* session : (string) user's session id

## Sample Data
```
1420070400000,ip_1,user_5,clicked,<fieldset></fieldset>acebook.com,campaign_6,139,session_98
1420070400864,ip_2,user_3,viewed,facebook.com,campaign_4,35,session_98
1420070401728,ip_8,user_8,clicked,youtube.com,campaign_12,115,session_92
```