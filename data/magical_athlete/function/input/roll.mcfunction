function magical_athlete:input/context
execute unless entity @s[tag=ma.actor] run return 0
execute unless entity @e[tag=ma.current,scores={ma_state=3,ma_anim=0},limit=1] run return run tellraw @s {text:"此时无需掷骰；需要选择时用紫色染料按Q。",color:"yellow"}
execute if score @s ma_side = @e[tag=ma.current,limit=1] ma_pending run return run function magical_athlete:direct/roll_pending
execute unless score @s ma_side = @e[tag=ma.current,limit=1] ma_turn run return run tellraw @s {text:"等待你的队伍行动",color:"yellow"}
scoreboard players operation @s ma_seen = @e[tag=ma.current,limit=1] ma_epoch
scoreboard players set #roll_pawn ma_ctx -1
execute if score #roll_pawn ma_ctx matches -1 run function magical_athlete:input/roll_pawn {index:0}
execute if score #roll_pawn ma_ctx matches -1 run function magical_athlete:input/roll_pawn {index:1}
execute if score #roll_pawn ma_ctx matches -1 run function magical_athlete:input/roll_pawn {index:2}
execute if score #roll_pawn ma_ctx matches -1 run function magical_athlete:input/roll_pawn {index:3}
execute if score #roll_pawn ma_ctx matches -1 run function magical_athlete:input/roll_pawn {index:4}
execute if score #roll_pawn ma_ctx matches -1 run function magical_athlete:input/roll_pawn {index:5}
execute store result score #forced_roll ma_ctx run data get entity @e[tag=ma.current,limit=1] data.magical_athlete.forced
execute if score #forced_roll ma_ctx matches 0..5 run scoreboard players operation #roll_pawn ma_ctx = #forced_roll ma_ctx
execute unless score #roll_pawn ma_ctx matches 0..5 run return 0
scoreboard players operation #code ma_ctx = #roll_pawn ma_ctx
scoreboard players add #code ma_ctx 300
function magical_athlete:ui/dispatch
