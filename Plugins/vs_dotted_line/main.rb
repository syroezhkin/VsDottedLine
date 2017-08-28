# Copyright 2015-2017, Vladimir Syroezhkin
# vladimir@syroezhkin.net

require 'sketchup.rb'

Sketchup::require 'vs_dotted_line/conversion'
Sketchup::require 'vs_dotted_line/dotted'
Sketchup::require 'vs_dotted_line/inputbox'
Sketchup::require 'vs_dotted_line/select'
Sketchup::require 'vs_dotted_line/right_click_tool'

unless file_loaded?(__FILE__)
  UI.add_context_menu_handler do |menu|
    if(selection = VS::DottedLine.select)
      menu.add_separator
      menu.add_item("Replace by dotted lines...") { VS::DottedLine.right_click_tool selection }
    end
  end
  file_loaded(__FILE__)
end

