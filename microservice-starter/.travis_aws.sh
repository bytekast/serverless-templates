#!/bin/bash

mkdir -p ~/.aws

cat > ~/.aws/credentials << EOL
[dev]
aws_access_key_id = ${DEV_AWS_KEY}
aws_secret_access_key = ${DEV_AWS_SECRET}

EOL