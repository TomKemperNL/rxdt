module Rxdt::Actions
  class Remove < Action
    def execute(result)
      target = REXML::XPath.first(result, xpath_query)

      target.parent.delete(target)
      target
    end
  end
end
