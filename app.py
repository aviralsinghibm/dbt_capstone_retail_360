import streamlit as st
import snowflake.connector
import pandas as pd

st.set_page_config(
    page_title="Retail360",
    page_icon="🛒",
    layout="wide"
)

st.title("Retail360 Analytics Dashboard")
st.caption("Retail customer, order, product, and inventory analytics")

conn = snowflake.connector.connect(
    **st.secrets["connections"]["retail360"]
)

# -------------------------
# Load data
# -------------------------

customers = pd.read_sql("""
    select *
    from retail360.marts.dim_customers
""", conn)

products = pd.read_sql("""
    select *
    from retail360.marts.dim_products
""", conn)

orders = pd.read_sql("""
    select *
    from retail360.marts.fct_orders
""", conn)

# -------------------------
# KPI calculations
# -------------------------

total_revenue = orders["TOTAL_PRICE"].sum()
total_orders = len(orders)
total_customers = len(customers)
total_products = len(products)

# -------------------------
# KPI cards
# -------------------------

col1, col2, col3, col4 = st.columns(4)

col1.metric("Total Revenue", f"${total_revenue:,.0f}")
col2.metric("Total Orders", f"{total_orders:,}")
col3.metric("Customers", f"{total_customers:,}")
col4.metric("Products", f"{total_products:,}")

st.divider()

# -------------------------
# Customer section
# -------------------------

st.subheader("Customer 360")

customer_chart = (
    customers[
        ["CUSTOMER_NAME", "TOTAL_SPEND"]
    ]
    .sort_values("TOTAL_SPEND", ascending=False)
    .head(10)
    .set_index("CUSTOMER_NAME")
)

st.bar_chart(customer_chart)

# -------------------------
# Product section
# -------------------------

st.subheader("Top Products by Revenue")

product_chart = (
    products[
        ["PRODUCT_NAME", "NET_REVENUE"]
    ]
    .sort_values("NET_REVENUE", ascending=False)
    .head(10)
    .set_index("PRODUCT_NAME")
)

st.bar_chart(product_chart)

# -------------------------
# Inventory section
# -------------------------

st.subheader("Inventory Alerts")

low_stock = products[
    products["IS_LOW_STOCK"] == True
][
    [
        "PRODUCT_NAME",
        "TOTAL_AVAILABLE_QTY",
        "TOTAL_QUANTITY_SOLD"
    ]
].sort_values("TOTAL_AVAILABLE_QTY")

st.dataframe(
    low_stock,
    use_container_width=True
)

conn.close()
