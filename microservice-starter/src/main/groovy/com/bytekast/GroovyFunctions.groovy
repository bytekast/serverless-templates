package com.bytekast

import com.amazonaws.services.lambda.runtime.Context
import groovy.transform.CompileStatic
import org.apache.log4j.Logger

@CompileStatic
class GroovyFunctions {

  final static Logger logger = Logger.getLogger(GroovyFunctions.class)

  def echo(def input, Context context) {
    logger.info context?.invokedFunctionArn
    input
  }
}