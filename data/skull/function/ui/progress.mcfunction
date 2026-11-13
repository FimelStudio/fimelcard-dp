# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage skull:ui dialog.body append value {type:"minecraft:plain_message",contents:{text:"已翻出$(done) / $(goal)张花。选择一个牌堆，翻它最上面的一张。",color:"green"}}
