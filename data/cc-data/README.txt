# Schema for credit card data

## Transactions:
  - id  : auto incrementing ID
  - accountID  : card holders account
  - vendorID :  merchant ID
  - date : transaction date & time
  - city : where transaction happened
  - state : where transaction happened
  - transaction amount in $.    (e.g  10.34)
  - sample data:
    1,5715,4,2015-01-01 00:00:00,El Paso,TX,62.81
    2,8236,6,2015-01-01 00:00:00,Pittsburgh,PA,157.33

## Vendors
  - id : unique id
  - name
  - vendor city
  - vendor state
  - category : (General / Grocery / Technology)
  - sample data:
    1,Walmart,Bentonville,AR,General
    2,Kroger,Cincinatti,OH,Grocery

## Accounts
  - id : auto inc id
  - accountNo
  - bankID
  - first_name
  - last_name
  - email
  - gender
  - address
  - city
  - state
  - zip
