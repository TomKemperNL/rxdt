module Rxdt::Actions
  class Set_Attributes < Action
    def execute(result)
      puts xpath_query
      target = REXML::XPath.first(result, xpath_query)

      clone = @element.clone()
      clean_node clone

      target.add_attributes clone.attributes

      target
    end
  end
end
