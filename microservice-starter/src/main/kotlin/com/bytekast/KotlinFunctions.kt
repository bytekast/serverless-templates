package com.bytekast

import com.amazonaws.services.lambda.runtime.Context
import org.apache.log4j.Logger

class KotlinFunctions {

  companion object {
    val logger = Logger.getLogger(KotlinFunctions::class.java)!!
  }

  fun echo(input: Map<String, Any>, context: Context?): Map<String, Any> {
    logger.info(context?.invokedFunctionArn)
    return input
  }

}