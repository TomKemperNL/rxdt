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
      @ns = (@element.namespaces.select { |k, v| v == Rxdt::SCHEMA }).keys.first
    end

    def clean_node(node)
      node.attributes.delete_all "#{@ns}:Transform"
      node.attributes.delete_all "#{@ns}:Locator"
    end

    def xpath_query_for_parent
      query = ""
      node = @element.parent

      loop do
        query = "/" + node.name + query

        break if node == @element.document.root || node.parent.nil?
        node = @element.parent
      end

      query
    end

    def xpath_query
      if @element == @element.document.root
        "/" + @element.name
      else
        xpath_query_for_parent + "/" + @element.name
      end
    end
  end
end
