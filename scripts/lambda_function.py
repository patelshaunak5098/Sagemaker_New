def handler(event, context):

    # Your logic goes here
    message = "Here you Go!!!"
    print('Hello, world from GET Lambda Func! This is from Terraform')
    print('updated!!!!!!!!!!')
    return {
        'statusCode': 200,
        'body': message
    }
