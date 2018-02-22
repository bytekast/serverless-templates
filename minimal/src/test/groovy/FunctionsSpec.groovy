import spock.lang.Specification

class FunctionsSpec extends Specification {

  def 'test hello function'() {

    given:
    def functions = new Functions()

    when:
    def result = functions.hello([:], null)

    then:
    result == 'Hello'
  }
}
