# Copyright 2015—2016, Vladimir Syroezhkin
# vladimir@syroezhkin.net

module VS::DottedLine

  def self.right_click_tool(selection)
    model = Sketchup.active_model
    entities = model.entities
    count_of_edges = selection.count
    if count_of_edges > 100
      result = UI.messagebox("The count of the selected edges is #{count_of_edges.to_s}. Do you really like to continue? (This may take some time dependent of the hardware of your system).", MB_YESNO)
      return if result == IDNO
    end
    model.start_operation "Conversion The Lines"
    conversion = VS::DottedLine::ConversionToDotted.new
    if input = VS::DottedLine.inputbox
      conversion.dot     = input[0]
      conversion.space   = input[1]
      conversion.soften  = input[2]
      conversion.convert selection
      selection.clear
    end
    model.commit_operation # Conversion The Lines
  end

end # module VS::DottedLine
