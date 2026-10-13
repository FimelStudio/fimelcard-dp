# 复制组件

data modify storage fimel_anim_text:runtime operation.text.output append from storage fimel_anim_text:runtime operation.component.split.input

data remove storage fimel_anim_text:runtime operation.text.output[-1].extra

data remove storage fimel_anim_text:runtime operation.text.output[-1].hover_event

data remove storage fimel_anim_text:runtime operation.text.output[-1].click_event

function fimel_anim_text:operation/input/component/split/extra