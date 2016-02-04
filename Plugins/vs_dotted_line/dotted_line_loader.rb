# Copyright 2015-2016, Vladimir Syroezhkin
# vladimir@syroezhkin.net

require_relative 'conversion'
require_relative 'dotted'
require_relative 'inputbox'
require_relative 'select'
require_relative 'right_click_tool'

unless file_loaded?("__FILE__")
  UI.add_context_menu_handler do |menu|
    if(selection = VS::DottedLine.select)
      menu.add_separator
      menu.add_item("Replace by dotted lines...") { VS::DottedLine.right_click_tool selection }
    end
  end
end

file_loaded("__FILE__")
