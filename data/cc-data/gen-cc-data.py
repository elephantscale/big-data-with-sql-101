#!/usr/bin/env python

## generates mock billing data files
## log format
##   timestamp (in ms), customer_id, resource_id, qty, cost

## timestamp converstions testing site : http://www.epochconverter.com/


import sys

## ----- config
days=10
entries_per_day=100000
log_format="csv"
#log_format="json"
if ( (len(sys.argv) > 1) ):
  log_format = sys.argv[1]  
## --- end config


import os
import datetime as dt
import random
import json

# auto incrementing counter
counter = 0

cities_states = [('Gainesville', 'GA'),  ('Boise', 'ID'),  
              ('Indianapolis','IN'), ('Pittsburgh', 'PA'),
              ('Largo', 'FL'), ('Savannah', 'GA'), ('Harrisburg', 'PA'),
              ('Bronx', 'NY'), ('Springfield', 'MA'), ('Tacoma', 'WA'),
              ('El Paso', 'TX'), ('Henderson', 'NV'), ('Peoria', 'IL'),
              ('Topeka', 'KS'), ('New Orleans', 'LA'), 
              ('San Francisco', 'CA'), ('Hartford', 'CT'), 
              ('Baltimore', 'MD'), ('Austin', 'TX')
              ]

## set seed so every one gets same data
random.seed(10)

# overwrite this function to customize log generation
def generate_log(timestamp):
  global counter
  counter = counter + 1
  account_id = random.randint(1,10000)
  vendor_id = random.randint(1,10)
  #date = timestamp
  date = dt.datetime.utcfromtimestamp(timestamp/1000).strftime('%Y-%m-%d %H:%M:%S')
  city_state = random.choice(cities_states)
  city = city_state[0]
  state = city_state[1]
  amount = round(random.randint(1,300) + random.random(), 2)

  #csv
  if (log_format == 'csv'):
    logline = "%s,%s,%s,%s,%s,%s,%s" % (counter, account_id, vendor_id, date, city, state, amount)

  # generate JSON format
  if (log_format == 'json'):
    dict={'id' : counter, 'account_id': account_id, 'vendor_id' : vendor_id, 'timestamp': date, 'city': city, 'state': state,  'amount':amount}
    logline = json.dumps(dict)


  #print logline
  return logline



#main
## --- script main
if __name__ == '__main__':
  time_inc_ms = int ((24.0*3600*1000)/entries_per_day)
  #print "time inc ms", time_inc_ms
  #epoch = dt.datetime.fromtimestamp(0)
  epoch = dt.datetime(1970,1,1)

  year_start = dt.datetime(2015, 1, 1)
  for day in range(0, days):
    day_delta = dt.timedelta(days=day)
    start_ts = year_start + day_delta
    #end_ts = dt.datetime(start_ts.year, start_ts.month, start_ts.day, 23, 59, 59)
    end_ts = dt.datetime(start_ts.year, start_ts.month, start_ts.day+1, 0, 0, 0)
    filename = "transaction-" + start_ts.strftime("%Y-%m-%d")
    if (log_format == 'csv'):
      filename = filename + ".csv"
    elif (log_format == 'json'):
      filename = filename + ".json"
    else:
      print "Unknown log format : " + log_format
      exit(1)

    #print start_ts
    #print end_ts
    last_ts = start_ts

    with open(filename, "w") as fout:
      print "generating log ", filename
      while (last_ts < end_ts):
        delta_since_epoch = last_ts - epoch
        millis = int((delta_since_epoch.microseconds + (delta_since_epoch.seconds + delta_since_epoch.days * 24 * 3600) * 10**6) / 1e3)
        #print "last ts", last_ts
        #print "millis",  millis
        logline = generate_log(millis)
        fout.write(logline + "\n")

        last_ts = last_ts + dt.timedelta(milliseconds=time_inc_ms)

