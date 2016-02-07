# Copyright 2015—2016, Vladimir Syroezhkin
# vladimir@syroezhkin.net

module VS::DottedLine

  def self.inputbox
    model = Sketchup.active_model
    attr_name = 'VsDottedLine'
    dot    = model.get_attribute attr_name, 'dots',   200.mm
    space  = model.get_attribute attr_name, 'spaces', 50.mm
    soften = model.get_attribute attr_name, 'soften', 'No'
    prompts = ['Dots', 'Spaces', 'Soften']
    defaults = [dot, space, soften]
    lists = ['', '', 'Yes|No']
    input = UI.inputbox(prompts, defaults, lists, 'Line properties')
    return nil if not input
    dot = input[0]
    space = input[1]
    soften = (input[2] == 'Yes') ? true : false
    model.set_attribute attr_name, 'dots',   dot
    model.set_attribute attr_name, 'spaces', space
    model.set_attribute attr_name, 'soften', soften == true ? 'Yes' : 'No'
    [dot, space, soften]
  end

end # module VS::DottedLine
