# Copyright 2015—2016, Vladimir Syroezhkin
# vladimir@syroezhkin.net

module VS::DottedLine

  def self.inputbox
    prompts = ['Dots', 'Spaces', 'Soften']
    defaults = [200.0.mm, 50.0.mm, 'No']
    lists = ['', '', 'Yes|No']
    input = UI.inputbox(prompts, defaults, lists, 'Line properties')
    return nil if not input
    dot = input[0]
    space = input[1]
    soften = (input[2] == 'Yes') ? true : false
    [dot, space, soften]
  end

end # module VS::DottedLine
