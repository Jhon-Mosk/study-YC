from pprint import pprint
import boto3
from boto3.dynamodb.conditions import Key

def scan_series(id_range, display_series):
    ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "https://docapi.serverless.yandexcloud.net/ru-central1/b1ghk9uitis1fanhbci6/etn0s60acnb01kg3t91e")

    table = ydb_docapi_client.Table('docapitest/series')
    scan_kwargs = {
        'FilterExpression': Key('series_id').between(*id_range),
        'ProjectionExpression': "series_id, title, info.release_date"
    }

    done = False
    start_key = None
    while not done:
        if start_key:
            scan_kwargs['ExclusiveStartKey'] = start_key
        response = table.scan(**scan_kwargs)
        display_series(response.get('Items', []))
        start_key = response.get('LastEvaluatedKey', None)
        done = start_key is None

if __name__ == '__main__':
    def print_series(series):
        for serie in series:
            print(f"\n{serie['series_id']} : {serie['title']}")
            pprint(serie['info'])

    query_range = (1, 3)
    print(f"Series with IDs from {query_range[0]} to {query_range[1]}...")
    scan_series(query_range, print_series)
