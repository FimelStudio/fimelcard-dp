# 复制原列表元素0

data modify storage fimel_anim_text:runtime operation.component.split.extra_fix set from storage fimel_anim_text:runtime operation.component.split.extra[0]

# 删除原列表元素0

data remove storage fimel_anim_text:runtime operation.component.split.extra[0]

# 字符串处理

data remove storage fimel_anim_text:runtime operation.component.split.temp

execute store success score #operation.split.component.extra.string fca_store run data modify storage fimel_anim_text:runtime operation.component.split.temp set string storage fimel_anim_text:runtime operation.component.split.extra_fix

execute if score #operation.split.component.extra.string fca_store matches 1 run function fimel_anim_text:operation/input/component/split/extra_fix_string

# 列表处理

scoreboard players set #operation.split.component.extra.list fca_store 0

execute if data storage fimel_anim_text:runtime operation.component.split.extra_fix[] run scoreboard players set #operation.split.component.extra.list fca_store 1

execute if score #operation.split.component.extra.list fca_store matches 1 run function fimel_anim_text:operation/input/component/split/extra_fix_list

# 组件继承

execute unless data storage fimel_anim_text:runtime operation.component.split.extra_fix.color run data modify storage fimel_anim_text:runtime operation.component.split.extra_fix.color set from storage fimel_anim_text:runtime operation.split.template[-1].color

execute unless data storage fimel_anim_text:runtime operation.component.split.extra_fix.italic run data modify storage fimel_anim_text:runtime operation.component.split.extra_fix.italic set from storage fimel_anim_text:runtime operation.split.template[-1].italic

execute unless data storage fimel_anim_text:runtime operation.component.split.extra_fix.underlined run data modify storage fimel_anim_text:runtime operation.component.split.extra_fix.underlined set from storage fimel_anim_text:runtime operation.split.template[-1].underlined

execute unless data storage fimel_anim_text:runtime operation.component.split.extra_fix.strikethrough run data modify storage fimel_anim_text:runtime operation.component.split.extra_fix.strikethrough set from storage fimel_anim_text:runtime operation.split.template[-1].strikethrough

execute unless data storage fimel_anim_text:runtime operation.component.split.extra_fix.obfuscated run data modify storage fimel_anim_text:runtime operation.component.split.extra_fix.obfuscated set from storage fimel_anim_text:runtime operation.split.template[-1].obfuscated

execute unless data storage fimel_anim_text:runtime operation.component.split.extra_fix.bold run data modify storage fimel_anim_text:runtime operation.component.split.extra_fix.bold set from storage fimel_anim_text:runtime operation.split.template[-1].bold

execute unless data storage fimel_anim_text:runtime operation.component.split.extra_fix.font run data modify storage fimel_anim_text:runtime operation.component.split.extra_fix.font set from storage fimel_anim_text:runtime operation.split.template[-1].font

# 插入元素

data modify storage fimel_anim_text:runtime operation.component.split.extra_fixed append from storage fimel_anim_text:runtime operation.component.split.extra_fix

# 检测跳出

execute if data storage fimel_anim_text:runtime operation.component.split.extra[0] run function fimel_anim_text:operation/input/component/split/extra_fix