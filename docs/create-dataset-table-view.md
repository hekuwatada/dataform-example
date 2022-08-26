# Create a dtaset, table and view with unit test

## Step 1: Create a table and view in a dataset

- (1) Create a table as a definition SQLX
  - Use `type: "table"`
  - Add `assertions`
- (2) Create a view as a definition SQLX
  - Use `type: "view"`
  - Add `assertions`
- NOTE: The dataset required for the table and view will be auto-created by `dataform run`

## Step 2: Add assertions to ensure the result of running SQL queries

- (1) Add an assertion to confirm that the table is populated
   - Use `type: "assertion"`

## Step 3: Format and compile the code

- (1) Run `terraform format`
- (2) Run `terraform compile`
  - Assertions are auto-generated as `assertionSchema.<dataset>_<table>_assertions_<type>`
  - `trafform run --dry-run` seems to output the same results
```
# dataform compile
Compiling...

Compiled 8 action(s).
2 dataset(s):
  df_example.age_groups [view]
  df_example.ages [table]
5 assertion(s):
  df_example_assertions.df_example_age_groups_assertions_uniqueKey_0
  df_example_assertions.df_example_age_groups_assertions_rowConditions
  df_example_assertions.df_example_ages_assertions_uniqueKey_0
  df_example_assertions.df_example_ages_assertions_rowConditions
  df_example_assertions.ages_not_empty
1 operation(s):
  df_example.df_example
```

## Step 4: Run the compiled SQL queries

- (1) Run `terraform run`
  - It compiles the code first
  - It runs `dataset(s)` actions before `assertion(s)` actions, which means that assertions can work as a "smoke test" after running the SQL queries
```
# dataform run
Compiling...

Compiled successfully.

Running...

Dataset created:  df_example.ages [table]
Dataset created:  df_example.age_groups [view]
Assertion passed:  df_example_assertions.df_example_ages_assertions_uniqueKey_0
Assertion passed:  df_example_assertions.df_example_ages_assertions_rowConditions
Assertion passed:  df_example_assertions.ages_not_empty
Assertion passed:  df_example_assertions.df_example_age_groups_assertions_uniqueKey_0
Assertion passed:  df_example_assertions.df_example_age_groups_assertions_rowConditions
```  
- (2) (Optional) Confirm that the objects have been created
```
# bq ls 
        datasetId
 -----------------------
  df_example
  df_example_assertions
                                                                                           
# bq ls df_example
   tableId     Type    Labels   Time Partitioning   Clustered Fields
 ------------ ------- -------- ------------------- ------------------
  age_groups   VIEW
  ages         TABLE

# bq ls df_example_assertions
                     tableId                       Type   Labels   Time Partitioning   Clustered Fields
 ------------------------------------------------ ------ -------- ------------------- ------------------
  ages_not_empty                                   VIEW
  df_example_age_groups_assertions_rowConditions   VIEW
  df_example_age_groups_assertions_uniqueKey_0     VIEW
  df_example_ages_assertions_rowConditions         VIEW
  df_example_ages_assertions_uniqueKey_0           VIEW
```

## Step 5: Unit test the view
- (1) Add a [unit test](../dataform/definitions/tests/unit_tests/age_groups/age_groups_test_grouping.sqlx) for a [view](../dataform/definitions/src/models/age_groups.sqlx) to test (Subject Under Test) as a test SQLX
  - Use type: "test"
  - Use `input "<source table>"` to generate input data to the SUT 
- (2) Run `dataform compile` for syntax errors
  - NOTE: It will not generate any action as it will not create or update any BigQuery object
- (3) Run `dataform test` to run unit tests only
  - NOTE: It will use the definition of the SUT reading `FROM` the input data specified in `input`
  - For example, a generated unit test will look like:
```
SELECT
  FLOOR(age / 5) * 5 AS age_group,
  COUNT(1) AS user_count
FROM
  (
  SELECT 15 AS age UNION ALL
  SELECT 21 AS age UNION ALL
  SELECT 24 AS age UNION ALL
  SELECT 34 AS age
)
GROUP BY
  age_group
```
