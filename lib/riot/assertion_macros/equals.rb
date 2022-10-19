module Riot
  # In the positive case, asserts that the result of the test equals the expected value. Using the +==+ 
  # operator to assert equality.
  #
  #   asserts("test") { "foo" }.equals("foo")
  #   should("test") { "foo" }.equals("foo")
  #   asserts("test") { "foo" }.equals { "foo" }
  #
  # In the negative case, asserts that the result of the test *does not* equal the expected value. Using the
  # +==+ operator.
  #
  #   denies("test") { "foo" }.equals("bar")
  #   denies("test") { "foo" }.equals { "bar" }
  class EqualsMacro < AssertionMacro
    register :equals

    # (see Riot::AssertionMacro#evaluate)
    # @param [Object] expected the object value to compare actual to
    def evaluate(actual, expected)
      if expected == actual
        pass new_message.is_equal_to(expected)
      else
        fail expected_message(expected).not(actual)
      end
    end

    # (see Riot::AssertionMacro#devaluate)
    # @param [Object] expected the object value to compare actual to
    def devaluate(actual, expected)
      if expected != actual
        pass new_message.is_equal_to(expected).when_it_is(actual)
      else
        fail new_message.did_not_expect(actual)
      end
    end
  end
end
