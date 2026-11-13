# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$tellraw @a[tag=wq.actor,limit=1] {text:"[ $(label) ]",color:"green",bold:true,click_event:{action:"run_command",command:"/trigger wq_action set $(value)"}}
