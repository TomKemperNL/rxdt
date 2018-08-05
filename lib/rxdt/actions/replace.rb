module Rxdt::Actions
  class Replace < Action
    def execute(result)
      target = REXML::XPath.first(result, xpath_query)

      clone = @element.deep_clone()
      clean_node clone

      target.parent.replace_child(target, clone)
      target
    end
  end
end
