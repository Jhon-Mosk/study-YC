from decimal import Decimal
from pprint import pprint
import boto3
from botocore.exceptions import ClientError

def delete_underrated_serie(title, series_id, rating):
    ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "https://docapi.serverless.yandexcloud.net/ru-central1/b1ghk9uitis1fanhbci6/etn0s60acnb01kg3t91e")

    table = ydb_docapi_client.Table('docapitest/series')

    try:
        response = table.delete_item(
            Key = {
                'series_id': series_id,
                'title': title
            },
            ConditionExpression = "info.rating <= :val",
            ExpressionAttributeValues = {
                ":val": Decimal(rating)
            }
        )
    except ClientError as e:
        if e.response['Error']['Code'] == "ConditionalCheckFailedException":
            print(e.response['Error']['Message'])
        else:
            raise
    else:
        return response

if __name__ == '__main__':
    print("Deleting...")
    delete_response = delete_underrated_serie("Supernatural", 3, 8)
    if delete_response:
        print("Series data deleted:")
        pprint(delete_response, sort_dicts = False)
