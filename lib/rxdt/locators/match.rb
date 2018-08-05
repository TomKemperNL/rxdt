module Rxdt::Locators
  class Match < Locator
    def initialize(element, attrs)
      super(element)
      @attrs = attrs
    end

    def xpath_query
      attr_query = (@attrs.map { |a| "@#{a}=#{@element.attribute(a).value}" }).join(" and ")

      return "#{@element.name}[#{attr_query}]"
    end
  end
end
