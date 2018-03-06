# Demo: Simulate API Gateway Endpoints using a Local Server

This demo project utilizes this **EXPRIMENTAL** [Gradle Plugin](https://plugins.gradle.org/plugin/com.bytekast.serverless-local-apigateway): **[local-apigateway-gradle-plugin](https://github.com/bytekast/local-apigateway-gradle-plugin)**

Notice the plugins section of [build.gradle](build.gradle)
```groovy
plugins {
  id "com.bytekast.serverless-local-apigateway" version "0.5"
}
```


To create a project using this template, run
```
serverless create --template-url https://github.com/bytekast/serverless-templates/tree/master/minimal-apigateway --path myservice
```

To test the HTTP endpoints locally, run
```
gradle clean build
gradle run
```

To auto-restart the running server when code changes are detected, run instead:
```bash
gradle run --continuous
```
