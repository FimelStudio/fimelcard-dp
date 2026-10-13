# 切分字符串并插入

data modify storage fimel_anim_text:runtime operation.string.split.template.text set string storage fimel_anim_text:runtime operation.string.split.input 0 1

data modify storage fimel_anim_text:runtime operation.text.output append from storage fimel_anim_text:runtime operation.string.split.template

# debug

#tellraw @a {nbt:"operation.text.output",storage:"fimel_anim_text:runtime",interpret:true}

# 更新切分

data modify storage fimel_anim_text:runtime operation.string.split.input set string storage fimel_anim_text:runtime operation.string.split.input 1

# 完成检测

execute if data storage fimel_anim_text:runtime operation.string.split{input:""} run return run function fimel_anim_text:operation/input/list/split/run

# 递归

function fimel_anim_text:operation/input/string/split/split