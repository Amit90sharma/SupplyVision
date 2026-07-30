import pandas as pd
from pathlib import Path
from sqlalchemy import create_engine

# =====================================================
# MYSQL CONNECTION
# =====================================================

USERNAME = "root"
PASSWORD = "root#pswd"
HOST = "localhost"
PORT = 3306
DATABASE = "supplyvision"

engine = create_engine(
    f"mysql+pymysql://{USERNAME}:{PASSWORD}@{HOST}:{PORT}/{DATABASE}"
)

# =====================================================
# PATH
# =====================================================

processed_path = Path("data/processed")

# =====================================================
# TABLE LOAD ORDER
# (Respect Foreign Keys)
# =====================================================

tables_to_load = [
    "categories",
    "customers",
    "employees",
    "stores",
    "suppliers",
    "products",
    "promotions",
    "dim_date",
    "orders",
    "order_items",
    "payments",
    "shipments",
    "returns"
]

# =====================================================
# DATE COLUMNS
# =====================================================

date_columns = {
    "customers": ["signup_date"],
    "orders": ["order_date"],
    "dim_date": ["date"]
}

print("=" * 70)
print("SUPPLYVISION MYSQL DATA LOADER")
print("=" * 70)

print(f"\nWorking Directory : {Path.cwd()}")
print(f"Processed Folder  : {processed_path.resolve()}")

success = []
failed = []

# =====================================================
# LOAD TABLES
# =====================================================

for table in tables_to_load:

    if table == "dim_date":
        csv_file = processed_path / "dim_date.csv"
    else:
        csv_file = processed_path / f"{table}_clean.csv"

    print("\n" + "-" * 70)
    print(f"Loading : {table}")

    try:

        df = pd.read_csv(csv_file)

        if table in date_columns:
            for col in date_columns[table]:
                if col in df.columns:
                    df[col] = pd.to_datetime(df[col])

        print(f"Rows : {len(df):,}")

        df.to_sql(
            name=table,
            con=engine,
            if_exists="append",
            index=False,
            method=None
        )

        print(f"✅ {table} loaded successfully.")

        success.append(table)

    except Exception as e:

        print(f"\n❌ Failed : {table}")

        if hasattr(e, "orig"):
            print(e.orig)
        else:
            print(e)

        failed.append(table)

# =====================================================
# SUMMARY
# =====================================================

print("\n")
print("=" * 70)
print("IMPORT SUMMARY")
print("=" * 70)

print(f"\nSuccessful Tables ({len(success)})")

for table in success:
    print(f"✅ {table}")

print(f"\nFailed Tables ({len(failed)})")

for table in failed:
    print(f"❌ {table}")

print("\n" + "=" * 70)

if len(failed) == 0:
    print("🎉 ALL 13 TABLES IMPORTED SUCCESSFULLY!")
else:
    print("⚠️ Some tables failed.")

print("=" * 70)