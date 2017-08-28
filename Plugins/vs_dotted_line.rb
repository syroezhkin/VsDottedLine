# Copyright 2015-2017, Vladimir Syroezhkin
# vladimir@syroezhkin.net

require 'sketchup.rb'
require 'extensions.rb'

module VS
  module DottedLine

    # Plugin information
    PLUGIN_NAME = 'VS Dotted Line'.freeze
    PLUGIN_VERSION = '1.0.3'.freeze
    PLUGIN_DESCRIPTION = 'Replace selected edges by dotted line.'.freeze
    PLUGIN_CREATOR = 'Vladimir Syroezhkin'.freeze
    PLUGIN_COPYRIGHT = "© 2015—2017, #{PLUGIN_CREATOR}"

    # Resource paths
    current_path = File.dirname(__FILE__)
    if current_path.respond_to?(:force_encoding)
      current_path.force_encoding('UTF-8')
    end
    PATH_ROOT = current_path.freeze
    FILENAMESPACE = File.basename(__FILE__, '.*')
    PATH = File.join(PATH_ROOT, FILENAMESPACE).freeze

    unless file_loaded?(__FILE__)
      ex = SketchupExtension.new(PLUGIN_NAME, File.join(PATH, 'main'))
      ex.description = PLUGIN_DESCRIPTION
      ex.version = PLUGIN_VERSION
      ex.creator = PLUGIN_CREATOR
      ex.copyright = PLUGIN_COPYRIGHT
      Sketchup.register_extension(ex, true)
      file_loaded(__FILE__)
    end

  end
end
