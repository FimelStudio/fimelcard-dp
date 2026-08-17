scoreboard players set @s hb_action 0
scoreboard players enable @s hb_action
$scoreboard players set #row_seat hb_ctx $(seat)
$data modify storage hanabi:dialog seat set value $(seat)
tag @a[tag=hb.hint_choice_name] remove hb.hint_choice_name
$execute as @a[tag=hb.player,scores={hb_seat=$(seat)}] if score @s hb_id = #ctx_id hb_ctx run tag @s add hb.hint_choice_name
execute unless entity @a[tag=hb.hint_choice_name,limit=1] run function hanabi:dialog/hint/target
execute unless entity @a[tag=hb.hint_choice_name,limit=1] run return 0
execute as @a[tag=hb.hint_choice_name,limit=1] at @s run function hanabi:name/resolve
data modify storage hanabi:dialog target_name set value {text:"",color:"aqua",bold:true,extra:[]}
data modify storage hanabi:dialog target_name.extra append from storage hanabi:name resolved
data modify storage hanabi:dialog target_hand set value {text:"",font:"card:hanabi_ui",shadow_color:0,extra:[]}
scoreboard players set #target_added hb_ctx 0
execute as @e[type=minecraft:marker,tag=hb.hand,scores={hb_slot=1}] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #row_seat hb_ctx run function hanabi:dialog/hint/append_target
execute as @e[type=minecraft:marker,tag=hb.hand,scores={hb_slot=2}] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #row_seat hb_ctx run function hanabi:dialog/hint/append_target
execute as @e[type=minecraft:marker,tag=hb.hand,scores={hb_slot=3}] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #row_seat hb_ctx run function hanabi:dialog/hint/append_target
execute as @e[type=minecraft:marker,tag=hb.hand,scores={hb_slot=4}] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #row_seat hb_ctx run function hanabi:dialog/hint/append_target
execute as @e[type=minecraft:marker,tag=hb.hand,scores={hb_slot=5}] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #row_seat hb_ctx run function hanabi:dialog/hint/append_target
data modify storage hanabi:dialog storm_color_option set value {text:""}
execute as @e[type=minecraft:marker,tag=hb.controller,scores={hb_storm=1}] if score @s hb_id = #ctx_id hb_ctx run data modify storage hanabi:dialog storm_color_option set value {text:"　[彩]",color:"light_purple",click_event:{action:"run_command",command:"trigger hb_action set 406"}}
function hanabi:dialog/hint/show_choice with storage hanabi:dialog
function hanabi:log {text:"提示内容Dialog已打开"}
tag @a[tag=hb.hint_choice_name] remove hb.hint_choice_name
