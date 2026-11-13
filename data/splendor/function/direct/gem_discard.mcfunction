execute unless score #gem_owned sp_ctx > #gem_pick sp_ctx run return run function splendor:hud/notice {"text":{"text":"你没有更多这种宝石可以退回。","color":"yellow"}}
execute if score @s sp_target matches 0 run scoreboard players add @s sp_pick0 1
execute if score @s sp_target matches 1 run scoreboard players add @s sp_pick1 1
execute if score @s sp_target matches 2 run scoreboard players add @s sp_pick2 1
execute if score @s sp_target matches 3 run scoreboard players add @s sp_pick3 1
execute if score @s sp_target matches 4 run scoreboard players add @s sp_pick4 1
execute if score @s sp_target matches 5 run scoreboard players add @s sp_pick5 1
scoreboard players set @s sp_panel 2
function splendor:direct/gem_stats
execute store result score #discard_due sp_ctx run data get entity @e[tag=sp.current,limit=1] data.splendor.discard_due
execute if score #pick_total sp_ctx = #discard_due sp_ctx run return run function splendor:direct/discard_commit
execute as @e[tag=sp.current,limit=1] at @s run function splendor:visual/selection
function splendor:hud/notice {"text":{"text":"已选中待退宝石；继续右键选择，左键撤销，退到十颗时自动确认。","color":"yellow"}}
