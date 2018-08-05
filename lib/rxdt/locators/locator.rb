module Rxdt::Locators
  class Locator
    def self.from_element(element)
      ns = (element.namespaces.select { |k, v| v == Rxdt::SCHEMA }).keys.first
      locator_attribute = element.attribute("#{ns}:Locator")

      if locator_attribute.nil?
        return Implicit.new(element)
      end

      case locator_attribute.value
      when /Match\((.*?)\)$/
        Match.new(element, $1.split(","))
      else
        raise RxdtError.new("Unknown value for Replace attribute: #{action}")
      end
    end

    attr_reader :element

    def initialize(element)
      @element = element
    end
  end
end
