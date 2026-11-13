execute store result storage doudizhu:deck card int 1 run scoreboard players get @s dd_card
execute unless entity @e[tag=dd.collector] run data modify entity @e[tag=dd.current,limit=1] data.dd_collect append from storage doudizhu:deck card
execute if entity @e[tag=dd.collector] run data modify entity @e[tag=dd.collector,limit=1] data.dd_collect append from storage doudizhu:deck card
