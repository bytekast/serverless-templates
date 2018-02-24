package com.bytekast

import spock.lang.Specification

class GroovyFunctionsSpec extends Specification {

  def 'test Groovy echo function'() {

    given:
    def functions = new GroovyFunctions()

    when:
    def result = functions.echo('Hello', null)

    then:
    result == 'Hello'


    when:
    result = functions.echo([foo: 'bar'], null)

    then:
    result.foo == 'bar'
  }
}
