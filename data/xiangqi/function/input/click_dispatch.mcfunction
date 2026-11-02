# advancement 只恢复下次右键资格；输入在 tick 中读该格记录的最后右键者。
# 这样不会依赖 advancement 触发与 interaction NBT 写入的先后顺序。
advancement revoke @s only xiangqi:click_cell
# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
