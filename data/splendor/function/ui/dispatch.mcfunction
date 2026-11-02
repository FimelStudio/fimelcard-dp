# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute if score #code sp_ctx matches 1 run return run function splendor:ui/open
execute if score #code sp_ctx matches 2 run return run function splendor:ui/market
execute if score #code sp_ctx matches 3 run return run function splendor:ui/token_begin
execute if score #code sp_ctx matches 4 run return run function splendor:ui/blind
execute if score #code sp_ctx matches 5 run return run function splendor:ui/reserved
execute if score #code sp_ctx matches 6 run return run function splendor:ui/public
execute if score #code sp_ctx matches 7 run return run function splendor:ui/nobles
execute if score #code sp_ctx matches 8 run return run function splendor:ui/rules
execute if score #code sp_ctx matches 9 run return run function splendor:ui/music
execute if score #code sp_ctx matches 122 run scoreboard players set @s sp_target 14
execute if score #code sp_ctx matches 121 run scoreboard players set @s sp_target 13
execute if score #code sp_ctx matches 120 run scoreboard players set @s sp_target 12
execute if score #code sp_ctx matches 111 run scoreboard players set @s sp_target 11
execute if score #code sp_ctx matches 110 run scoreboard players set @s sp_target 10
execute if score #code sp_ctx matches 109 run scoreboard players set @s sp_target 9
execute if score #code sp_ctx matches 108 run scoreboard players set @s sp_target 8
execute if score #code sp_ctx matches 107 run scoreboard players set @s sp_target 7
execute if score #code sp_ctx matches 106 run scoreboard players set @s sp_target 6
execute if score #code sp_ctx matches 105 run scoreboard players set @s sp_target 5
execute if score #code sp_ctx matches 104 run scoreboard players set @s sp_target 4
execute if score #code sp_ctx matches 103 run scoreboard players set @s sp_target 3
execute if score #code sp_ctx matches 102 run scoreboard players set @s sp_target 2
execute if score #code sp_ctx matches 101 run scoreboard players set @s sp_target 1
execute if score #code sp_ctx matches 100 run scoreboard players set @s sp_target 0
execute if score #code sp_ctx matches 20 run return run function splendor:ui/return_begin
execute if score #code sp_ctx matches 100..122 run return run function splendor:ui/details
execute if entity @e[tag=sp.current,scores={sp_anim=1..},limit=1] run return run function splendor:ui/open
execute unless score @s sp_side = @e[tag=sp.current,limit=1] sp_turn run return run function splendor:ui/open
execute if score #code sp_ctx matches 200..211 run return run function splendor:ui/edit
execute if score #code sp_ctx matches 10 if score @s sp_panel matches 1 run return run function splendor:ui/submit_take
execute if score #code sp_ctx matches 11 if score @s sp_panel matches 2 run return run function splendor:ui/submit_return
execute if score #code sp_ctx matches 12 if score @s sp_panel matches 3 run return run function splendor:ui/submit_buy
execute if score #code sp_ctx matches 13 if score @s sp_panel matches 3 if score @s sp_target matches 0..11 run return run function splendor:ui/submit_reserve
execute if score #code sp_ctx matches 140 run scoreboard players set @s sp_target 12
execute if score #code sp_ctx matches 140 run return run function splendor:ui/submit_reserve
execute if score #code sp_ctx matches 141 run scoreboard players set @s sp_target 13
execute if score #code sp_ctx matches 141 run return run function splendor:ui/submit_reserve
execute if score #code sp_ctx matches 142 run scoreboard players set @s sp_target 14
execute if score #code sp_ctx matches 142 run return run function splendor:ui/submit_reserve
execute if score #code sp_ctx matches 160 run scoreboard players set @s sp_target 0
execute if score #code sp_ctx matches 160 run return run function splendor:ui/submit_noble
execute if score #code sp_ctx matches 161 run scoreboard players set @s sp_target 1
execute if score #code sp_ctx matches 161 run return run function splendor:ui/submit_noble
execute if score #code sp_ctx matches 162 run scoreboard players set @s sp_target 2
execute if score #code sp_ctx matches 162 run return run function splendor:ui/submit_noble
execute if score #code sp_ctx matches 163 run scoreboard players set @s sp_target 3
execute if score #code sp_ctx matches 163 run return run function splendor:ui/submit_noble
execute if score #code sp_ctx matches 164 run scoreboard players set @s sp_target 4
execute if score #code sp_ctx matches 164 run return run function splendor:ui/submit_noble
function splendor:ui/open
