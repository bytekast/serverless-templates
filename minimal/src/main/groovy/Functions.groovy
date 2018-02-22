import com.amazonaws.services.lambda.runtime.Context
import groovy.transform.CompileStatic
import groovy.transform.Field
import org.apache.log4j.Logger

@Field
final Logger logger = Logger.getLogger(Functions.class)

@CompileStatic
def echo(def input, Context context) {
  logger.info context?.invokedFunctionArn
  input
}