connection: "events_ecommerce"

# include all the views
include: "*.view"

datagroup: lookml_613_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: lookml_613_default_datagroup
