
with base as (

    select * 
    from {{ ref('stg_pendo__page_history_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_pendo__page_history_tmp')),
                staging_columns=get_page_history_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        id as page_id,
        name as page_name,
        app_id,
        created_at,
        created_by_user_id,
        dirty as is_dirty,
        group_id,
        last_updated_at,
        last_updated_by_user_id,
        root_version_id,
        stable_version_id,
        valid_through,
        _fivetran_synced

    from fields
)

select * 
from final
