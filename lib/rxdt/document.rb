module Rxdt
  class Document
    attr_reader :xml

    def initialize(xml)
      if (File.file? xml)
        @xml = File.read xml
      else
        @xml = xml
      end
    end

    def apply(transform)
      result = Rxdt::Document.new(@xml.to_s)

      transform.actions.each do |act|
        act.execute result
      end

      result
    end

    def ==(other)
      if other.nil?
        return false
      end

      return @xml == other.xml
    end
  end
end
