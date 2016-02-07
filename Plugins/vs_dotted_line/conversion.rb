# Copyright 2015—2016, Vladimir Syroezhkin
# vladimir@syroezhkin.net

module VS::DottedLine

  class ConversionToDotted

    attr_accessor :dot, :space, :soften

    def initialize(dot = nil, space = nil, soften = nil)
      @dot = dot
      @space = space
      @dotted_lines = []
      @soften = soften
    end

    def convert(entity)
      @selection = entity
      entities = Sketchup.active_model.active_entities
      group = entities.add_group
      @entities = group.entities
      convert_edge if @selection.instance_of? Sketchup::Edge
      convert_group(@selection) if @selection.instance_of? Sketchup::Group
      convert_selection if @selection.instance_of? Sketchup::Selection
      entities.erase_entities @selection if self.soften == false
    end

    private

    def convert_edge(entities = Sketchup.active_model.active_entities, edge = @selection)
      pt1 = edge.start.position
      pt2 = edge.end.position
      dotted_line = Dotted.new pt1, pt2, @dot, @space
      dotted_line.draw @entities
      edge.soft = 'true' if self.soften == true
    end

    def convert_group(ent)
      entities = ent.entities
      entities.each { |edge| convert_edge(@entities, edge) }
    end

    def convert_selection
      array = []
      @selection.each { |s| array.push s }
      array.each { |a| convert_edge(@entities, a) if a.instance_of? Sketchup::Edge }
    end

  end # class Conversion

end # module VS::DottedLine
