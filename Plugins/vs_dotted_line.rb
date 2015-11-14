# Copyright 2015, Vladimir Syroezhkin
# vladimir@syroezhkin.net

require 'sketchup.rb'
require 'extensions.rb'

module VS

  module DottedLine

  vs_dotted_line = SketchupExtension.new("VS Dotted Line", (File.join(File.dirname(__FILE__),"vs_dotted_line","dotted_line_loader.rb")))
  vs_dotted_line.description=("Replace selected edges by dotted line.")
  vs_dotted_line.version="0.2.0"
  vs_dotted_line.creator="Vladimir Syroezhkin"
  vs_dotted_line.copyright="© 2015, Vladimir Syroezhkin"
  Sketchup.register_extension vs_dotted_line,true

  end

end