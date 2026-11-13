# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute unless score @s av_id = #ballot_table av_ctx run return 0
execute unless score @s ct_id = #ballot_table av_ctx run return 0
function avalon:bind
execute unless entity @e[tag=av.current,limit=1] run return 0
execute unless score #ballot_epoch av_ctx = @e[tag=av.current,limit=1] av_epoch run return 0
execute unless score #ballot_code av_ctx matches 20..21 unless score #ballot_code av_ctx matches 30..31 run return 0
scoreboard players operation @s av_action = @s av_ui_base
scoreboard players operation @s av_action += #ballot_code av_ctx
function avalon:input/handle
