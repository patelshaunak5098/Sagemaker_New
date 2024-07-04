def handler(event, context):

    # Your logic goes here
    message = "Hello, world from GET Lambda Func! This is Sagemaker"
    print('Hello, world from GET Lambda Func! This is from Terraform')
    print('updated!!!!!!!!!!')
    return {
        'statusCode': 200,
        'body': message
    }
