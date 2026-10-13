data modify storage fimel_anim_text:runtime operation.text.input set from storage fimel_anim_text:runtime global.subtitle.data.text

function fimel_anim_text:operation/input/initial

data modify storage fimel_anim_text:runtime global.subtitle.input set from storage fimel_anim_text:runtime operation.text.output