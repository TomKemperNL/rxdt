module Rxdt::Locators
  class Implicit < Locator
    def xpath_query
      return @element.name
    end
  end
end
