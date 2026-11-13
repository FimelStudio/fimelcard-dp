execute unless score @s sp_target matches 0..5 run return run function splendor:hud/notice {"text":{"text":"请选择一种有效宝石。","color":"yellow"}}
execute unless score @s sp_select_kind matches 4 run function splendor:direct/reset
scoreboard players set @s sp_select_kind 4
function splendor:direct/hand
function splendor:direct/gem_read
execute if entity @e[tag=sp.current,scores={sp_state=2},limit=1] run return run function splendor:direct/gem_discard
execute unless entity @e[tag=sp.current,scores={sp_state=1},limit=1] run return run function splendor:hud/notice {"text":{"text":"请先选择符合条件的一位贵族。","color":"yellow"}}
execute if score @s sp_target matches 5 run return run function splendor:hud/notice {"text":{"text":"黄金只能通过预定发展卡获得。","color":"yellow"}}
execute unless score #gem_stock sp_ctx matches 1.. run return run function splendor:hud/notice {"text":{"text":"银行没有这种宝石了。","color":"yellow"}}
function splendor:direct/gem_stats
execute if score #gem_pick sp_ctx matches 1 run return run function splendor:direct/gem_double
execute if score @s sp_target matches 0 run scoreboard players set @s sp_pick0 1
execute if score @s sp_target matches 1 run scoreboard players set @s sp_pick1 1
execute if score @s sp_target matches 2 run scoreboard players set @s sp_pick2 1
execute if score @s sp_target matches 3 run scoreboard players set @s sp_pick3 1
execute if score @s sp_target matches 4 run scoreboard players set @s sp_pick4 1
function splendor:direct/gem_stats
execute if score #pick_available sp_ctx matches 2.. if score #pick_total sp_ctx = #pick_available sp_ctx run return run function splendor:direct/gem_commit
execute if score #pick_available sp_ctx matches 1 unless score #gem_stock sp_ctx matches 4.. run return run function splendor:direct/gem_commit
execute as @e[tag=sp.current,limit=1] at @s run function splendor:visual/selection
function splendor:hud/notice {"text":{"text":"已选中宝石；继续右键其他颜色，或再次右键这一颗拿两颗同色；左键取消。","color":"yellow"}}
