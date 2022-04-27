'''
File uses AWS SDK Boto3 for working with AWS services via API.
'''

import boto3


# s3_client = boto3.client('s3') # in case I need to use the client instead of the resource
s3_resource = boto3.resource('s3')


bucket = 'code-challenges-paul-2022'


def upload_s3():
    bucket = 'code-challenges-paul-2022'
    file = 'test.txt'
    upload = s3_resource.Object(bucket, file).upload_file(Filename=file)
    return upload


if __name__ == '__main__':
    upload_s3()