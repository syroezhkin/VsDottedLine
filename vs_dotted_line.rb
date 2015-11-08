# Copyright 2015, Vladimir Syroezhkin
# vladimir@syroezhkin.net

require 'sketchup.rb'

module VsDottedLine

    def self.selected_edges # checks whether the selection is the edge and returns its entity
        model = Sketchup.active_model
        entities = model.active_entities
        selection = model.selection
        return nil if selection.empty?
        selection.each do |sel|
            return nil if not (sel.instance_of? Sketchup::Edge)
        end
        selection
    end

    def self.add_dotted_line(start_point, end_point, dot, space) # accepts coordinates of two points with the properties and creates the dotted line
        distance = start_point.distance end_point
        number_of_lines = (distance / step).to_i

        vector = start_point.vector_to end_point
        vector_dot = vector.clone
        vector_dot.length = dot
        vector_step = vector.clone
        vector_step.length = step

        model = Sketchup.active_model
        entities = model.active_entities
        pt1 = start_point
        pt2 = start_point.offset vector_dot

        number_of_lines.times do
            line = entities.add_line pt1, pt2
            pt1 = pt1.offset! vector_step
            pt2 = pt2.offset! vector_step
        end

        last_line = entities.add_line pt1, end_point
    end

    def self.replace_by_dotted_lines(selection) # accepts the selected edges and replaces it by dotted lines
        prompts = ["Dots", "Spaces"]
        defaults = [100.0.mm, 20.0.mm]
        input = UI.inputbox(prompts, defaults, "Enter the line properties")

        model = Sketchup.active_model
        entities = model.active_entities
        model.start_operation "Replacing The Lines"

        selection_count = VsDottedLine.selected_edges.count

        selection_count.times do
            selection.each do |edge|
                pt1 = edge.start.position
                pt2 = edge.end.position
                entities.erase_entities edge
                dotted_line = VsDottedLine.add_dotted_line(pt1, pt2, dot, space)
            end
        end

        model.commit_operation # Replacing The Lines
    end

end # module

if( not file_loaded?("vs_dotted_line.rb") )
    UI.add_context_menu_handler do |menu|
        if(selection = VsDottedLine.selected_edges)
            menu.add_separator
            menu.add_item("Replace by dotted lines...") { VsDottedLine.replace_by_dotted_lines selection }
        end
    end
end

file_loaded("vs_dotted_line.rb")
