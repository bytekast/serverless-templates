# microservice-deploy
Generic Gradle + Serverless deployment job for Travis

Trigger Build via Travis API (Example):
```
body='{
  "request":{
    "branch":"master",
    "config":{
      "env":{
        "SERVICE_GROUP" : "com.github.bytekast",
        "SERVICE_NAME" : "demo",
        "SERVICE_VERSION" : "master-SNAPSHOT",
        "AWS_PROFILE" : "dev",
        "AWS_ACCESS_KEY_ID" : "XXXXXXXXXXXXXXXXXX",
        "AWS_SECRET_ACCESS_KEY" : "XXXXXXXXXXXXXXXXXX"
      }
    }
  }
}'

curl -s -X POST \
 -H "Content-Type: application/json" \
 -H "Accept: application/json" \
 -H "Travis-API-Version: 3" \
 -H "Authorization: token XXXXXXXXXXXXXXXXXX" \
 -d "$body" \
 https://api.travis-ci.org/repo/bytekast%microservice-deploy/requests
```