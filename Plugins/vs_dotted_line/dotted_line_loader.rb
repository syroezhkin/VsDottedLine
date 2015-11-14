# Copyright 2015, Vladimir Syroezhkin
# vladimir@syroezhkin.net

require 'sketchup.rb'
require_relative "dotted"
require_relative "conversion"
require_relative "select"


# Create menu items
unless file_loaded?("__FILE__")
  # Add context menu
  UI.add_context_menu_handler do |menu|
    if(selection = VS::DottedLine.select)
      menu.add_separator
      menu.add_item("Replace by dotted lines...") { VS::DottedLine::Conversion.new selection }
    end
  end
end

file_loaded("__FILE__")