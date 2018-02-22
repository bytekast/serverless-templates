import spock.lang.Specification

class FunctionsSpec extends Specification {

  def 'test echo function'() {

    given:
    def functions = new Functions()

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
