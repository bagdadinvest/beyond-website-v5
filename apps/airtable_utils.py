# airtable_utils.py

from airtable import Airtable
from django.conf import settings

def get_airtable_client():
    return Airtable(settings.AIRTABLE_BASE_ID, settings.AIRTABLE_API_KEY)

def fetch_table_data(table_name):
    client = get_airtable_client()
    return client.get(table_name)

def create_record(table_name, data):
    client = get_airtable_client()
    return client.create(table_name, data)

def update_record(table_name, record_id, data):
    client = get_airtable_client()
    return client.update(table_name, record_id, data)

def delete_record(table_name, record_id):
    client = get_airtable_client()
    return client.delete(table_name, record_id)
