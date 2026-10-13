# 非text跳出

execute if score #operation.split.component.text fca_store matches 0 run return run function fimel_anim_text:operation/input/component/split/no_string

# 切分字符串并插入

data modify storage fimel_anim_text:runtime operation.component.split.template.text set string storage fimel_anim_text:runtime operation.component.split.input_text 0 1

data modify storage fimel_anim_text:runtime operation.text.output append from storage fimel_anim_text:runtime operation.component.split.template

# debug

#tellraw @a {nbt:"operation.text.output",storage:"fimel_anim_text:runtime",interpret:true}

# 更新切分

data modify storage fimel_anim_text:runtime operation.component.split.input_text set string storage fimel_anim_text:runtime operation.component.split.input_text 1

# 完成检测

execute if data storage fimel_anim_text:runtime operation.component.split{input_text:""} run return run function fimel_anim_text:operation/input/component/split/extra

# 递归

function fimel_anim_text:operation/input/component/split/split