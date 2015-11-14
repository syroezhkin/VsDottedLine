# Copyright 2015, Vladimir Syroezhkin
# vladimir@syroezhkin.net

module VS

  module DottedLine

    class Conversion

      def initialize(selection, dot = nil, space = nil)
        @selection = selection
        @dot = dot
        @space = space
        model = Sketchup.active_model
        model.start_operation "Conversion The Lines"

        return convert_selection if selection.instance_of? Sketchup::Selection
        return convert_edge if selection.instance_of? Sketchup::Edge

        model.commit_operation # Replacing The Lines
      end

      private

      def get_inputbox
        unless @dot && @space
          prompts = ["Dots", "Spaces"]
          defaults = [100.0.mm, 20.0.mm]
          input = UI.inputbox(prompts, defaults, "Enter the line properties")
          return nil if not input
          @dot = input[0]
          @space = input[1]
        end
      end

      def draw_line(edge)
        entities = Sketchup.active_model.active_entities
        if edge.length > (@dot + @space)
          pt1 = edge.start.position
          pt2 = edge.end.position
          entities.erase_entities edge
          dotted_line = Dotted.new(pt1, pt2, @dot, @space)
        end
      end

      def convert_selection
        get_inputbox
        @selection.count.times do
          @selection.each { |edge| draw_line(edge) }
        end
        @selection.clear
      end

      def convert_edge
        get_inputbox
        draw_line(@selection)
      end

    end # class Conversion

  end # module DottedLine

end #module VS