module Riot
  # Asserts that result's size is as expected. Expected size can be specified as
  # a number or a range.
  #
  #   asserts("a string") { 'washington' }.size(9..12)
  #   asserts("an array") { [1, 2, 3] }.size(3)
  #   asserts("a hash") { {:name => 'washington'} }.size(1)
  #
  # To ensure that the result is not of a specific size:
  #
  #   denies("a string") { 'washington' }.size(4)
  #   denies("an array") { [1, 2, 3] }.size(6..10)
  #   denies("a hash") { {:name => 'washington'} }.size(2)
  class SizeMacro < AssertionMacro
    register :size

    # (see Riot::AssertionMacro#evaluate)
    # @param [Number] expected the expected size of actual
    def evaluate(actual, expected)
      failure_message = expected_message.size_of(actual).to_be(expected).not(actual.size)
      expected === actual.size ? pass(new_message.is_of_size(expected)) : fail(failure_message)
    end

    # (see Riot::AssertionMacro#devaluate)
    # @param [Number] expected the unexpected size of actual
    def devaluate(actual, expected)
      failure_message = expected_message.size_of(actual).to_not_be(expected).not(actual.size)
      expected === actual.size ? fail(failure_message) : pass(new_message.is_size(expected))
    end
  end
end
