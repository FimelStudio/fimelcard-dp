clear @s *[minecraft:custom_data~{magical_athlete:{tool:1b}}]
scoreboard players set @s ma_expected 1
scoreboard players operation @s ma_depoch = @e[tag=ma.current,limit=1] ma_epoch
execute unless score @s ma_cepoch = @e[tag=ma.current,limit=1] ma_epoch run scoreboard players set @s ma_confirm -999
execute unless score @s ma_iepoch = @e[tag=ma.current,limit=1] ma_epoch run scoreboard players set @s ma_dpage 0
scoreboard players operation @s ma_iepoch = @e[tag=ma.current,limit=1] ma_epoch
execute store result storage magical_athlete:direct table int 1 run scoreboard players get @s ma_table
execute store result storage magical_athlete:direct epoch int 1 run scoreboard players get @s ma_depoch
execute store result storage magical_athlete:ui side int 1 run scoreboard players get @s ma_side
function magical_athlete:ui/private with storage magical_athlete:ui
function magical_athlete:input/menu_tool with storage magical_athlete:direct
execute if entity @e[tag=ma.current,scores={ma_state=1},limit=1] if score @s ma_side = @e[tag=ma.current,limit=1] ma_turn run function magical_athlete:direct/draft
execute if entity @e[tag=ma.current,scores={ma_state=2},limit=1] run function magical_athlete:direct/lineup
execute if entity @e[tag=ma.current,scores={ma_state=3,ma_anim=0},limit=1] if score @s ma_side = @e[tag=ma.current,limit=1] ma_pending run function magical_athlete:direct/choices
function magical_athlete:direct/roster
