module Rxdt::Actions
  class Insert < Action
    def execute(result)
      target = REXML::XPath.first(result, xpath_query_for_parent)
      clone = @element.deep_clone()
      clean_node clone

      target.add_element(clone)
      target
    end
  end
end
