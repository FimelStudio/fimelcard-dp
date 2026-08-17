# 宏参数seat是权威座位号，action是点击后提交的trigger值
$execute if score #actor_seat hb_ctx matches $(seat) run return 0
$execute as @a[tag=hb.player,scores={hb_seat=$(seat)}] if score @s hb_id = #ctx_id hb_ctx run tag @s add hb.hint_option
$execute unless entity @a[tag=hb.hint_option,scores={hb_seat=$(seat)},limit=1] run return 0

execute if score #option_added hb_ctx matches 1.. run data modify storage hanabi:dialog target_body.extra append value {text:"\n"}
$execute as @a[tag=hb.hint_option,scores={hb_seat=$(seat)},limit=1] at @s run function hanabi:name/resolve
$data modify storage hanabi:dialog target_piece set value {text:"",color:"aqua",bold:true,click_event:{action:"run_command",command:"trigger hb_action set $(action)"},extra:[]}
data modify storage hanabi:dialog target_piece.extra append from storage hanabi:name resolved
data modify storage hanabi:dialog target_body.extra append value {text:"• ",color:"gray"}
data modify storage hanabi:dialog target_body.extra append from storage hanabi:dialog target_piece
scoreboard players add #option_added hb_ctx 1
