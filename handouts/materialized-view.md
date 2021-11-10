
# Materialized Views

Materizlied Views are a new feature in Hive 3.x, and represent a powerful new way to pre-compute summaries of data
and use them as an optimizatoon for uueries.

### About Materialized Views

Ordinary Views in Hive are take no additional storage as they will execute the SQL every they are invoked.  Ordinary Views
exist mainly to provide ways to control access to data, as security settings can be done to views as well as tables.

Materializediews ardo take storage as the results of the query are run and stored.  The advantage of storing the data
is that queries against the table will not require thdata t first be materialized.  .  



```sql
create materialized view mv_invoices
as
select account_id, sum(amount) as total from transactions_orc group by account_id order by total desc;
```



### Query Rewrite

Materialized views can be used as a 


```sql
ALTER MATERIALIZED VIEW mv_invoices enable rewrite;
```

Hive 3 does not feature indexes.  Indexing support was removed by the creators of Hive in Hive 3 as it did not prove useful.
Materialized Views can serve much the same purpose as indexes in improving the efficiency of certain queries.  A skillfully
chosen set of materialized views can make difficult quriees far more efficient.



Joins in hive can be very costly particularly if a map-side join is not possible, fo  example if joining two large tables.
By creating a materiazlied view 


```sql

create materialized view mv_join_transactions_vendors
on
select A.*, B.* from tranasactions A join vendors B on A.vendor_id = B.id;

```



