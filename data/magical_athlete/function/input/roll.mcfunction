# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function magical_athlete:input/context
execute unless entity @s[tag=ma.actor] run return 0
execute unless entity @e[tag=ma.current,scores={ma_state=3,ma_anim=0},limit=1] run return run function magical_athlete:direct/busy
execute if score @s ma_side = @e[tag=ma.current,limit=1] ma_pending run return run function magical_athlete:direct/roll_pending
execute if entity @e[tag=ma.current,scores={ma_pending=1..},limit=1] run return run function magical_athlete:direct/pending_note
execute unless score @s ma_side = @e[tag=ma.current,limit=1] ma_turn run return run function magical_athlete:direct/wait
scoreboard players set #roll_pawn ma_ctx -1
execute if score #roll_pawn ma_ctx matches -1 run function magical_athlete:input/roll_pawn {index:0}
execute if score #roll_pawn ma_ctx matches -1 run function magical_athlete:input/roll_pawn {index:1}
execute if score #roll_pawn ma_ctx matches -1 run function magical_athlete:input/roll_pawn {index:2}
execute if score #roll_pawn ma_ctx matches -1 run function magical_athlete:input/roll_pawn {index:3}
execute if score #roll_pawn ma_ctx matches -1 run function magical_athlete:input/roll_pawn {index:4}
execute if score #roll_pawn ma_ctx matches -1 run function magical_athlete:input/roll_pawn {index:5}
execute store result score #forced_roll ma_ctx run data get entity @e[tag=ma.current,limit=1] data.magical_athlete.forced
execute if score #forced_roll ma_ctx matches 0..5 run scoreboard players operation #roll_pawn ma_ctx = #forced_roll ma_ctx
execute unless score #roll_pawn ma_ctx matches 0..5 run return run function magical_athlete:direct/wait
scoreboard players operation #code ma_ctx = #roll_pawn ma_ctx
scoreboard players add #code ma_ctx 300
function magical_athlete:direct/submit
