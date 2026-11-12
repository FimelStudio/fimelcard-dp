# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function guandan:system/context
scoreboard players add @s gd_botclock 1
execute if score @s gd_state matches 2 if score @s gd_botclock matches 20.. run return run function guandan:bot/tribute
execute unless score @s gd_state matches 3 run return 0
execute if score @s gd_auto matches 1..100 run return 0
scoreboard players operation #actor gd_ctx = @s gd_turn
scoreboard players set #isbot gd_ctx 0
execute as @e[tag=gd.board,tag=gd.bot,scores={gd_rank=0}] if score @s gd_seat = #actor gd_ctx run scoreboard players set #isbot gd_ctx 1
execute unless score #isbot gd_ctx matches 1 run return 0
execute unless score @s gd_botepoch = @s gd_epoch run function guandan:bot/begin
execute unless score @s gd_botclock matches 12.. run return 0
function guandan:bot/step
execute if data entity @s data.guandan.bot.todo[0] run function guandan:bot/step
execute if data entity @s data.guandan.bot.todo[0] run function guandan:bot/step
execute unless data entity @s data.guandan.bot.todo[0] run function guandan:bot/finish
