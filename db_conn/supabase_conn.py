import os
from supabase import create_client, Client

url = 'https://ebiapqslvifugmknaisr.supabase.co'
key = 'sb_publishable_B76gL2LbuFymEBpjcKddEw_GYKUuebE'
supabase: Client = create_client(url, key)


def check_table(table):
    response = (
        supabase.table(table)
        .select("*")
        .execute()
    )

    return response.data

