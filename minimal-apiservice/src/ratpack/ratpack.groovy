import groovy.json.JsonOutput
import org.yaml.snakeyaml.Yaml
import ratpack.handling.Context

import static ratpack.groovy.Groovy.ratpack

final serverlessYml = new File("${System.getProperty('project.rootDir')}/serverless.yml").text
final yaml = new Yaml().load(serverlessYml)
final functions = yaml.functions?.keySet()?.collect { name -> yaml.functions.get(name) }

final functionHandlers = []
functions?.each { f ->
  final clazz = f.handler?.tokenize('::')?.first()
  final instance = Class.forName(clazz).newInstance()

  final method = f.handler?.tokenize('::')?.last()
  final handler = instance.&"${method}"

  final httpEvents = f?.events?.http
  httpEvents?.each {
    def path = it.path?.toString()?.replaceAll('\\{', ":").replaceAll("}", "")
    functionHandlers << [
        method : it.method,
        path   : path,
        handler: { Context context ->

          final lambdaContext = new Expando()
          lambdaContext.with {
            getAwsRequestId = { UUID.randomUUID().toString() }
            getFunctionName = { 'local' }
            getRemainingTimeInMillis = { 20000 }
            getInvokedFunctionArn = { UUID.randomUUID().toString() }
          }

          context.request.body.then({ data ->
            final input = [
                httpMethod           : context.request.method.toString(),
                queryStringParameters: context.request.queryParams,
                pathParameters       : context.pathTokens,
                resource             : context.request.path,
                headers              : context.request.headers.asMultiValueMap(),
                body                 : data.getText()
            ]

            final result = handler(input, lambdaContext as com.amazonaws.services.lambda.runtime.Context)
            if (result instanceof String) {
              context.response.send(result)
            } else if (result instanceof Map) {
              final body = result.body ?: result
              context.response.send(JsonOutput.toJson(body))
            } else {
              context.response.send(JsonOutput.toJson(result))
            }
          })
        }
    ]
  }
}

ratpack {
  handlers {
    functionHandlers.each {
      "${it.method}"("${it.path}".toString(), it.handler)
    }
  }
}
