[sts]
aws sts assume-role \
--role-arn arn:aws:iam::017820697174:role/S3DeleteRole \
--role-session-name testman \
--duration-seconds 900

[profile]
aws configure set --profile s3 aws_access_key_id [AccessKeyId]
aws configure set --profile s3 aws_secret_access_key [SecretAccessKey]
aws configure set --profile s3 aws_session_token [SessionToken]

[s3]
aws s3 rb s3://{Bucket_NAME} --profile s3

[profile assume]
role_arn = arn:aws:iam::{ACCOUNT}:role/S3DeleteRole
source_profile = default