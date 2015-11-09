# Copyright 2015, Vladimir Syroezhkin
# vladimir@syroezhkin.net

require 'sketchup.rb'

module VsDottedLine

  # Checking whether the selection is the edge and returns its entity
  def self.selected_edges
    model = Sketchup.active_model
    entities = model.active_entities
    selection = model.selection
    return nil if selection.empty?
    selection.each { |sel| return nil unless (sel.instance_of? Sketchup::Edge) }
    selection
  end

  # Accepts coordinates of two points with the properties and creates the dotted line
  def self.add_dotted_line(start_point, end_point, dot, space)
    step = dot + space
    distance = start_point.distance end_point
    number_of_lines = (distance / step).ceil

    vector = start_point.vector_to end_point
    vector_dot = vector.clone
    vector_dot.length = dot

    vector_step = vector.clone
    vector_step.length = step

    vector_first = vector.clone
    shift = ((vector_step.length * number_of_lines - space) - distance) / 2
    vector_first.length = (dot - shift)

    vector_shift = vector.clone
    vector_shift.length = (step - shift)

    model = Sketchup.active_model
    entities = model.active_entities

    pt1 = start_point
    pt2 = start_point.offset vector_first
    first_line = entities.add_line pt1, pt2
    pt1 = start_point.offset vector_shift
    pt2 = pt1.offset vector_dot

    number_of_lines -= 2

    number_of_lines.times do
      line = entities.add_line pt1, pt2
      pt1 = pt1.offset! vector_step
      pt2 = pt2.offset! vector_step
    end

    last_line = entities.add_line pt1, end_point
  end

  # Accepts the selected edges and replaces it by dotted lines
  def self.replace_by_dotted_lines(selection)
    prompts = ["Dots", "Spaces"]
    defaults = [100.0.mm, 20.0.mm]
    input = UI.inputbox(prompts, defaults, "Enter the line properties")
    return nil if not input
    dot = input[0]
    space = input[1]

    model = Sketchup.active_model
    entities = model.active_entities
    model.start_operation "Replacing The Lines"

    selection_count = VsDottedLine.selected_edges.count

    selection_count.times do
      selection.each do |edge|
        if edge.length > (dot + space)
          pt1 = edge.start.position
          pt2 = edge.end.position
          entities.erase_entities edge
          dotted_line = VsDottedLine.add_dotted_line(pt1, pt2, dot, space)
        end
      end
    end

    selection.clear

    model.commit_operation # Replacing The Lines
  end

end # module VsDottedLine

# Create menu items
unless file_loaded?("__FILE__")
  # Add context menu
  UI.add_context_menu_handler do |menu|
    if(selection = VsDottedLine.selected_edges)
      menu.add_separator
      menu.add_item("Replace by dotted lines...") { VsDottedLine.replace_by_dotted_lines selection }
    end
  end
end

file_loaded("__FILE__")
