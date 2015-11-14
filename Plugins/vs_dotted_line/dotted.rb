# Copyright 2015, Vladimir Syroezhkin
# vladimir@syroezhkin.net

module VS

  module DottedLine

    class Dotted

      def initialize(start_point, end_point, dot, space)
        @start_point = start_point
        @end_point = end_point
        @dot = dot
        @space = space
        @step = dot + space
        @length = @start_point.distance @end_point
        @number_of_lines = (@length / @step).ceil

        calculate_vectors
        draw_lines
      end

      private

      def calculate_vectors
        vector = @start_point.vector_to @end_point
        @vector_dot = vector.clone
        @vector_dot.length = @dot

        @vector_step = vector.clone
        @vector_step.length = @step

        @vector_first = vector.clone
        shift = ((@vector_step.length * @number_of_lines - @space) - @length) / 2
        @vector_first.length = (@dot - shift)

        @vector_shift = vector.clone
        @vector_shift.length = (@step - shift)
      end

      def draw_lines
        model = Sketchup.active_model
        entities = model.active_entities

        pt1 = @start_point
        pt2 = @start_point.offset @vector_first
        first_line = entities.add_line pt1, pt2
        pt1 = @start_point.offset @vector_shift
        pt2 = pt1.offset @vector_dot

        @number_of_lines -= 2

        @number_of_lines.times do
          line = entities.add_line pt1, pt2
          pt1 = pt1.offset! @vector_step
          pt2 = pt2.offset! @vector_step
        end

        last_line = entities.add_line pt1, @end_point
      end

    end #class Dotted

  end # module DottedLine

end # module VS