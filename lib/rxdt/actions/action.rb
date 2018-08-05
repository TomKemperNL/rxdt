module Rxdt::Actions
  class Action
    attr_reader :element

    def self.from_element(element)
      action = element.attribute "Transform", {"xdt" => Rxdt::SCHEMA}

      case action.value
      when "Replace"
        Replace.new(element)
      when "Insert"
        Insert.new(element)
      when "Remove"
        Remove.new(element)
      when "SetAttributes"
        Set_Attributes.new(element)
      else
        raise RxdtError.new("Unknown value for Replace attribute: #{action}")
      end
    end

    def initialize(element)
      @element = element
    end
  end
end
