require "rexml/document"

require "rxdt/version"
require "rxdt/transform"
require "rxdt/document"

require "rxdt/locators/locator"
require "rxdt/locators/implicit"
require "rxdt/locators/match"

require "rxdt/actions/action"
require "rxdt/actions/insert"
require "rxdt/actions/remove"
require "rxdt/actions/replace"
require "rxdt/actions/set_attributes"

class RxdtError < StandardError
end

module Rxdt
  SCHEMA = "http://schemas.microsoft.com/XML-Document-Transform"

  def self.run
    if ARGV.length < 2
      self.display_help()
    end
  end

  def self.display_help
    puts "TODO: Help here"
  end
end
