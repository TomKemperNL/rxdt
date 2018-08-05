module Rxdt
  class Document
    attr_reader :xml

    def initialize(xml)
      @xml = REXML::Document.new xml
    end

    def apply(transform)
      result = REXML::Document.new (@xml.to_s)

      transform.actions.each do |act|
        act.execute result
      end

      Document.new(result.to_s)
    end

    def inspect
      writer = REXML::Formatters::Pretty.new()
      formatted = ""
      formatted = writer.write(@xml.root, formatted)
      "\n" + formatted
    end

    def ==(other)
      if other.nil?
        return false
      end

      writer = REXML::Formatters::Pretty.new()
      def writer.write_text(node, output)
        super(node.to_s.strip, output)
      end

      formatted = ""
      otherFormatted = ""
      writer.write(@xml, formatted)
      writer.write(other.xml, otherFormatted)
      return formatted == otherFormatted
    end
  end
end
