from pprint import pprint
import boto3
from boto3.dynamodb.conditions import Key

def query_and_project_series(series_id, title_range):
    ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "https://docapi.serverless.yandexcloud.net/ru-central1/b1ghk9uitis1fanhbci6/etn0s60acnb01kg3t91e")

    table = ydb_docapi_client.Table('docapitest/series')
    
    response = table.query(
        ProjectionExpression = "series_id, title, info.release_date",
        KeyConditionExpression = Key('series_id').eq(series_id) & Key('title').begins_with(title_range)
    )
    return response['Items']

if __name__ == '__main__':
    query_id = 3
    query_range = 'T'
    print(f"Series with ID = {query_id} and names beginning with "
          f"{query_range}")
    series = query_and_project_series(query_id, query_range)
    for serie in series:
        print(f"\n{serie['series_id']} : {serie['title']}")
        pprint(serie['info'])
