
{{ dbt_utils_sqlserver.union_tables([
        ref('data_union_table_1'),
        ref('data_union_table_2')]
) }} 

