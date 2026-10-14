# 消耗当前掉落物；无效阶段或本轮已提示时不重复广播。
kill @e[type=minecraft:item,tag=cp.input_drop,limit=1]
execute if entity @s[tag=cp.signal_used] run return 0
scoreboard players operation #ctx cp_ctx = @s cp_id
execute if score @s cp_locked matches 1 run return 0
tag @e[type=minecraft:marker,tag=cp.current] remove cp.current
execute as @e[type=minecraft:marker,tag=cp.controller,scores={cp_state=1}] if score @s cp_id = #ctx cp_ctx run tag @s add cp.current
execute unless entity @e[type=minecraft:marker,tag=cp.current,limit=1] run return 0
tag @s add cp.signal_used
function critical_point:input/clear_signal_tools
function critical_point:player/restore_cards
tag @s add cp.signal_actor
execute as @a[tag=cp.player] if score @s cp_id = #ctx cp_ctx run tag @s add cp.audience
tellraw @a[tag=cp.audience] [{text:'[临界点] ',color:'red'},{selector:'@a[tag=cp.signal_actor,limit=1]',color:'yellow'},{text:'：我这把会出偏大的牌。',color:'gray'}]
tag @a[tag=cp.audience] remove cp.audience
tag @s remove cp.signal_actor
tag @e[type=minecraft:marker,tag=cp.current] remove cp.current
