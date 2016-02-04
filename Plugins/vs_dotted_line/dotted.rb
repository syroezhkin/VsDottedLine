# Copyright 2015—2016, Vladimir Syroezhkin
# vladimir@syroezhkin.net

module VS::DottedLine

  class Dotted

    attr_accessor :start_point
    attr_accessor :end_point
    attr_accessor :dot
    attr_accessor :space
    attr_reader   :step
    attr_reader   :length
    attr_reader   :number_of_lines

    def initialize(start_point = nil, end_point = nil, dot = nil, space = nil)
      @start_point = start_point
      @end_point = end_point
      @dot = dot
      @space = space
    end

    def draw(entities = nil)
      @step = @dot + @space
      @length = @start_point.distance @end_point
      @number_of_lines = (@length / @step).ceil
      @entities = entities ? entities : Sketchup.active_model.active_entities
      if @length > (@dot + @space)
        calculate_vectors
        draw_lines
      else
        self.add_line @start_point, @end_point
      end
    end

    def add_line(pt1, pt2)
      @entities.add_line pt1, pt2
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
      pt1 = @start_point
      pt2 = @start_point.offset @vector_first
      @first_line = self.add_line pt1, pt2
      pt1 = @start_point.offset @vector_shift
      pt2 = pt1.offset @vector_dot

      @number_of_lines -= 2
      @middle_lines = []

      @number_of_lines.times do
        line = self.add_line pt1, pt2
        @middle_lines.push line
        pt1 = pt1.offset! @vector_step
        pt2 = pt2.offset! @vector_step
      end

      @last_line = self.add_line pt1, @end_point
    end

  end #class Dotted

end # module VS::DottedLine
