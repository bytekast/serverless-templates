# Serverless HTTP REST API with local server demo

To create a project using this template, run
```
serverless create --template-url https://github.com/bytekast/serverless-templates/tree/master/minimal-apigateway --path myservice
```

To test the HTTP endpoints locally, run
```
gradle clean build
gradle run
```

If you want the server to auto-update the running server when code changes are detected, run this instead:
```bash
gradle run --continuous
```
