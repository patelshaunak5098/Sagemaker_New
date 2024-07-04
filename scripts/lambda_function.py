import boto3
import json


def handler(event, context):

    # Your logic goes here

    print("Event ===== ",event)

    # Initialize the SageMaker runtime client
    runtime = boto3.client('sagemaker-runtime', region_name='us-east-1')

    # Your endpoint name
    endpoint_name = 'xgboost-2024-07-04-15-28-03-321'

    data = [13.88,5.4,2.23,19,85,0.98,0.34,0.4,0.68,4.9,0.50,1.30,420]
    
    body = json.loads(event['body'])

    body_data = json.loads(body)
    dummy = body_data['data']


    print("dummy ===== ",dummy)
    


    print(data)
    payload = ','.join([str(item) for item in data])
    print(payload)
    # Invoke the endpoint

    response = runtime.invoke_endpoint(EndpointName=endpoint_name,
                                    ContentType='text/csv',
                                    Body=payload)
    print(response)

    # Parse response
    result = json.loads(response['Body'].read().decode())
    print(result)

    return {
        'statusCode': 200,
        'body': dummy+result
    }

    '''
    message = "Here you Go!!!"
    print('Hello, world from GET Lambda Func! This is from Terraform')
    print('updated!!!!!!!!!!')
    return {
        'statusCode': 200,
        'body': message
    }
    '''

