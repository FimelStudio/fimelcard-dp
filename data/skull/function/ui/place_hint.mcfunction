# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute if entity @a[tag=sk.viewer,scores={sk_done=0}] run tellraw @a[tag=sk.viewer] {text:"[骷髅牌] 选中要扣的手牌，按Q丢出；本轮首次只能扣一张。",color:"yellow"}
execute if entity @a[tag=sk.viewer,scores={sk_done=1}] run tellraw @a[tag=sk.viewer] {text:"[骷髅牌] 你已完成首次扣牌，请等待其他人。",color:"yellow"}
