advancement revoke @s only cardtable:click/game_rules
advancement revoke @s only cardtable:click/game_rules_attack
function cardtable:log {text:"玩家点击规则介绍文本"}

# 规则入口始终可见，因此不要求点击者先加入牌桌
# 从点击者身边最近的规则交互实体取得桌号，避免依赖玩家身上可能不存在的 ct_id
scoreboard players set #rules_target ct_ctx 0
execute if entity @e[type=minecraft:interaction,tag=ct.rules,distance=..6,sort=nearest,limit=1] run scoreboard players set #rules_target ct_ctx 1
execute as @e[type=minecraft:interaction,tag=ct.rules,distance=..6,sort=nearest,limit=1] run scoreboard players operation #ctx_id ct_ctx = @s ct_id
execute unless score #rules_target ct_ctx matches 1 run return fail

tag @s add ct.rules_actor
tag @e[tag=ct.rules_controller] remove ct.rules_controller
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_state=0..1}] if score @s ct_id = #ctx_id ct_ctx run tag @s add ct.rules_controller
execute unless entity @e[tag=ct.rules_controller,limit=1] run tag @s remove ct.rules_actor
execute unless entity @e[tag=ct.rules_controller,limit=1] run return fail

execute as @e[tag=ct.rules_controller,limit=1] at @s run function cardtable:game/open_rules
tag @e[tag=ct.rules_controller] remove ct.rules_controller
tag @s remove ct.rules_actor
