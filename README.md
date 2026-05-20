### Zepto SQL Analysis : </br>
Exploratory Data Analysis and business question solving on Zepto grocery data using Pandas and PostgreSQL.

1. top 10 products based on discount_pct
2. products with max mrp but are out of stock
3. estimated revenue per category
4. all products with mrp > 500 & discount_pct<10
5. top 5 categories with high avg discount_pct
6. price per gram for products above 100g & sort by best value
7. group the products into categories as light,medium,bulk
8. total inventory weight per category

~~~
sql :
CREATE TABLE zepto (
    sku_id                   SERIAL PRIMARY KEY,
    category                 VARCHAR(120),
    name                     VARCHAR(120) NOT NULL,
    mrp                      DECIMAL(8,2),
    discount_pct             NUMERIC(5,2),
    available_qnt            INTEGER,
    discounted_selling_price NUMERIC(8,2),
    weight_in_gms            INTEGER,
    out_of_stock             BOOLEAN,
    quantity                 INTEGER
);
NOTE : in pgAdmin4 (or any) zepto_db >> Schemes >> Table >> Import/Export data >> [Options >> Turn on Header] and also [Columns >> Remove 'sku_id']
~~~

#### File Structure

~~~
zepto_sql/
├── data/
│   ├── zepto_raw.csv               # Original raw dataset
│   ├── zepto_raw_data.csv          # UTF-8 encoded version
│   └── zepto_cleaned.csv           # Cleaned dataset used for analysis
├── notebooks/
│   └── EDA.ipynb                   # Exploratory Data Analysis (Pandas)
└── sql/
    └── zepto.sql                   # All SQL queries
~~~

