#!/bin/sh
application=target-app
bucket=cakedisk-api
tag=$(date +%F)-$(git rev-parse --short HEAD)
bundle=bundle-${tag}.zip

git archive HEAD -o /tmp/${bundle}

aws s3 cp /tmp/${bundle} s3://${bucket}

aws elasticbeanstalk create-application-version \
    --application-name ${application} \
    --version-label ${tag}  \
    --source-bundle S3Bucket="${bucket}",S3Key="${bundle}" \
    --no-auto-create-application
