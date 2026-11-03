function splendor:input/context
execute unless entity @s[tag=sp.actor] run return 0
$execute unless score @s sp_table matches $(table) run return 0
$execute unless score @e[tag=sp.current,limit=1] sp_epoch matches $(epoch) run return 0
execute unless entity @e[tag=sp.current,scores={sp_anim=0},limit=1] run return 0
execute unless score @s sp_side = @e[tag=sp.current,limit=1] sp_turn run return run tellraw @s {text:"尚未轮到你行动",color:"yellow"}
$scoreboard players set @s sp_target $(id)
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:2} run return run function splendor:direct/buy
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:3} run return run function splendor:direct/noble
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:4} run function splendor:direct/take
