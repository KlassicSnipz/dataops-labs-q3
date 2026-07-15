# DataOps & dbt Mentorship Program

**Duration:** 6 Weeks
**Focus:** Hands-on practice. Each week is a small, self-contained assignment that fits in 2 hours, focused on doing. By the end, you will have built a complete star-schema data warehouse from raw CSVs.
**Tech Stack:** PostgreSQL, dbt, Airflow, Docker

## Week 1: Staging & Dimensions

- **Warm-Up:** Set up the project, connect to PostgreSQL, and run `dbt seed`.
- **One View per Source:** Write a `STAGE` view for each of the 5 seeds — trim text, cast types, standardize casing.
- **The Dimensions:** Build all three dimensions — `dim_customers`, `dim_products`, `dim_stores` — from the staged data.
- **Assignment:** All 5 staging views run, and the 3 dimensions build without errors.

## Week 2: The Incremental Fact & Snapshots

- **The Fact Table:** Join staged orders, items, and products into `fct_order_items` (one row per line item) with revenue, cost, and margin.
- **Incremental:** Make the fact incremental on `order_item_id` so re-runs only load new rows.
- **Snapshots:** Take an automatic "picture" of a table over time — track changes to product prices with a snapshot.
- **Assignment:** The incremental fact loads only new rows on re-run (313 rows), and a working snapshot captures product price history.

## Week 3: Test the Warehouse

- **Built-In Tests:** Add `not_null`, `unique`, and `relationships` to keys and foreign keys.
- **One Custom Test:** Write a SQL check for a basic rule (e.g. `net_amount` is never negative).
- **Find & Fix a Bug:** A `unique` test fails on duplicate order data — diagnose it and fix the staging model.
- **Assignment:** `dbt test` green after the fix; row counts land at 313 items / 155 orders.

## Week 4: A Reusable Macro

- **Jinja Basics:** Use a variable and a macro inside a SQL file.
- **Your First Macro:** Write one small `net_amount()` macro and call it in the fact model.
- **Reuse It:** Build `fct_orders` (order grain) that rolls up the line items.
- **Assignment:** The repeated revenue math is replaced by your macro; output is unchanged.

## Week 5: Hooks

- **Post-Hooks:** Run SQL right after a model builds — add an index to `fct_order_items` to speed up joins.
- **Project-Level Hooks:** Configure a hook in `dbt_project.yml` that runs for every model (e.g. `GRANT SELECT` so dashboards can read the tables).
- **Assignment:** The index is created by a post-hook, and a project-level grant hook runs on every model build.

## Week 6: Automate with Airflow

- **A Simple DAG:** Read a ready-made DAG that runs the dbt project on a schedule.
- **Run It:** Trigger the DAG manually and watch the tasks succeed in order.
- **Add a Task:** Wire in a `dbt build` task and set basic retries.
- **Assignment:** A full DAG run passes green end to end.

---
