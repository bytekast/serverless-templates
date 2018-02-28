# Minimally Opinionated Serverless Microservice Project

#### Prerequisites

1) Install [Java 8](http://www.oracle.com/technetwork/java/javase/overview/java8-2100321.html), [Groovy](http://groovy-lang.org/), [Kotlin](https://kotlinlang.org/), and [Gradle](https://gradle.org/) - I highly recommend using [SDKMAN](http://sdkman.io/) to install any JVM-related packages.
2) Install [NodeJS](https://nodejs.org/en/) and the [Serverless Framework](https://serverless.com/framework/docs/getting-started/)
3) [Amazon Web Services](https://aws.amazon.com/), [GitHub](https://github.com/), [Travis CI](https://travis-ci.org/), [CodeCov](https://codecov.io)  and [Sentry](https://sentry.io) accounts


#### Create a new Serverless project


Using the **Serverless Framework**, you can create a new project by providing the base template **[microservice-starter](https://github.com/bytekast/serverless-templates/tree/master/microservice-starter)**:

```
serverless create \
  --template-url https://github.com/bytekast/serverless-templates/tree/master/microservice-starter \
  --path myservice
```

This project is pre-configured to use the following development tools and services:

- [Groovy](http://groovy-lang.org/) / [Kotlin](https://kotlinlang.org/) - Development Languages
- [Gradle](https://gradle.org/) - Dependency Management and Build Tool
- [Spock](http://spockframework.org/) - Test/Specification Framework
- [Serverless Framework](https://serverless.com/) - Serverless Management and Deployment Toolkit
- [Travis CI](https://travis-ci.org/) - Continuous Integration and Continuous Deployment
- [Jacoco](https://github.com/jacoco/jacoco) / [CodeCov](https://codecov.io) - Code Coverage
- [Sentry](https://sentry.io) - Automatic Error and Bug Tracking

This project makes a few assumptions before you are able to deploy the service in AWS. 

First, you need to setup your AWS credentials/profiles in `~/.aws/credentials` file.

```
[dev]
aws_access_key_id = XXXXXXXXXXXXXX
aws_secret_access_key = XXXXXXXXXXXXXX
region = us-east-1

[prod]
aws_access_key_id = XXXXXXXXXXXXXX
aws_secret_access_key = XXXXXXXXXXXXXX
region = us-east-1
```


Now you can go to the project directory, build the binaries and deploy to the `DEV` environment.

![build](http://www.rowellbelen.com/content/images/2018/02/carbon--7-.png)


Test the functions locally or invoke the real instance in AWS to verify:

![invoke](http://www.rowellbelen.com/content/images/2018/02/carbon--8-.png)


#### Additional Conventions / Configurations
<br/>

##### Bug Tracking and Error Reporting:

- This project uses **[Log4J](https://logging.apache.org/log4j)** to automatically create trackable bug issues in **[Sentry](https://sentry.io/)** whenever a message with the `ERROR` severity is logged via `log.error("...")`.
- Update the [serverless.env.yml](https://github.com/bytekast/serverless-templates/blob/master/microservice-starter/serverless.env.yml#L2) file to provide the `SENTRY_DSN` environment variable so that issues are created in the appropriate project in **[Sentry](https://sentry.io/)**.



##### Travis CI for Continuous Integration
- When the project is enabled in Travis CI, the provided `travis.yml` will autodeploy the service to the *dev* AWS Environment.
- The `DEV_AWS_KEY` and `DEV_AWS_SECRET` environment variables must be provided in [.travis.yml](https://github.com/bytekast/serverless-templates/blob/master/microservice-starter/.travis.yml#L23-L24).
- Code Coverage reports are automatically uploaded to [CodeCov](https://codecov.io) if the `CODECOV_TOKEN` environment variable is provided in [.travis.yml](https://github.com/bytekast/serverless-templates/blob/master/microservice-starter/.travis.yml#L25).


##### VPC for Security and Access Restriction

- If deploying the microservice in a VPC, provide the necessary configuration - *account ids*, *vpc ids*, *subnet ids* and *security group ids* - in the [serverless.yml](https://github.com/bytekast/serverless-templates/blob/master/microservice-starter/serverless.yml#L24-L38) file and uncomment the `vpc` section [here](https://github.com/bytekast/serverless-templates/blob/master/microservice-starter/serverless.yml#L12-L14).

