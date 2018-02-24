package com.bytekast

import spock.lang.Specification

class KotlinFunctionsTest extends Specification {

  def 'test Kotlin echo function'() {

    given:
    def functions = new KotlinFunctions()

    when:
    def result = functions.echo([foo: 'bar'], null)

    then:
    result.foo == 'bar'
  }
}
