module Rxdt::Locators
  class Locator
    def self.from_element(element)
      return Implicit.new(element)
    end

    attr_reader :element

    def initialize(element)
      @element = element
    end
  end
end
