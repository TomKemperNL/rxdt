module Rxdt
  class Transform
    attr_reader :doc

    def initialize(xdt)
      if (xdt.nil?)
        raise RxdtError.new("XDT cannot be nil")
      end

      if (File.file? xdt)
        xdt = File.read xdt
      end

      @doc = REXML::Document.new xdt
      if @doc.root.nil?
        raise RxdtError.new("XDT requires a root element")
      end

      if @doc.root.namespaces.values.none? { |n| n == SCHEMA }
        raise RxdtError.new("XDT requires the XDT namespace (\"http://schemas.microsoft.com/XML-Document-Transform\")")
      end
    end

    def actions
      REXML::XPath.each(@doc.root, "//*[@xdt:Transform]", {"xdt" => SCHEMA}).map { |el| Rxdt::Actions::Action.from_element el }
    end
  end
end
