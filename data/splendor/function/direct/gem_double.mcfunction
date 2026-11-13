execute unless score #pick_total sp_ctx matches 1 run return run function splendor:hud/notice {"text":{"text":"拿两颗同色前，请先左键取消其他颜色。","color":"yellow"}}
execute unless score #gem_stock sp_ctx matches 4.. run return run function splendor:hud/notice {"text":{"text":"拿两颗同色宝石前，该色银行库存至少需要四颗。","color":"yellow"}}
execute if score @s sp_target matches 0 run scoreboard players set @s sp_pick0 2
execute if score @s sp_target matches 1 run scoreboard players set @s sp_pick1 2
execute if score @s sp_target matches 2 run scoreboard players set @s sp_pick2 2
execute if score @s sp_target matches 3 run scoreboard players set @s sp_pick3 2
execute if score @s sp_target matches 4 run scoreboard players set @s sp_pick4 2
function splendor:direct/gem_commit
