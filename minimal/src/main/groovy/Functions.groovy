import com.amazonaws.services.lambda.runtime.Context
import groovy.transform.Field
import org.apache.log4j.Logger

@Field
final Logger logger = Logger.getLogger(Functions.class)

def hello(Map input, Context context) {
  logger.info context?.invokedFunctionArn
  'Hello'
}