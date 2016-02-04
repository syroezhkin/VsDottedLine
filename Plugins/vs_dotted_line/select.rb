# Copyright 2015-2016, Vladimir Syroezhkin
# vladimir@syroezhkin.net

module VS::DottedLine

  def self.select
    model = Sketchup.active_model
    entities = model.active_entities
    selection = model.selection
    return nil if selection.empty?
    selection.each { |sel| return nil unless (sel.instance_of? Sketchup::Edge) }
    selection
  end

end # module VS::DottedLine
