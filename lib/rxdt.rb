require "rexml/document"

require "rxdt/version"
require "rxdt/transform"
require "rxdt/document"

class RxdtError < StandardError
end

module Rxdt
  def self.run
    if ARGV.length < 2
      self.display_help()
    end
  end

  def self.display_help
    puts "TODO: Help here"
  end
end
