# 转移组件

data modify storage fimel_anim_text:runtime operation.list.split.input prepend from storage fimel_anim_text:runtime operation.list.split.input_0[]

# debug

#tellraw @a {nbt:"operation.text.output",storage:"fimel_anim_text:runtime",interpret:true}

# 递归

function fimel_anim_text:operation/input/list/split/run