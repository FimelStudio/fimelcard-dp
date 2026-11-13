$execute unless score @s sp_table matches $(table) run return 0
$execute unless score @s sp_side matches $(owner) run return 0
execute if entity @s[nbt={Health:0.0f}] run return 0
execute unless score @s sp_idrop matches 1.. run return 0
scoreboard players set @s sp_idrop 0
execute if score @s ct_paused matches 1 run return 0
$execute if predicate {type:"minecraft:int_value_check",value:$(kind),test:2} run return run function splendor:direct/reserved_use {slot:$(reserve_slot),epoch:$(epoch),table:$(table),owner:$(owner)}
$execute if predicate {type:"minecraft:int_value_check",value:$(kind),test:0} run return run function splendor:direct/gem_return {color:$(color),table:$(table),owner:$(owner)}
function splendor:hud/notice {text:{text:"已获得的卡牌持续生效，已为你放回物品栏。",color:"yellow"}}
