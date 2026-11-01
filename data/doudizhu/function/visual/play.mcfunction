execute unless data storage doudizhu:table_cards models run function doudizhu:visual/load
execute if score @e[tag=dd.current,limit=1] dd_type matches 0 as @e[tag=dd.current,limit=1] run function doudizhu:visual/clear
function doudizhu:visual/clear_seat
execute store result storage doudizhu:table_cards args.cap int 1 run scoreboard players get @e[tag=dd.current,limit=1] ct_capacity
execute store result storage doudizhu:table_cards args.seat int 1 run scoreboard players get @s dd_seat
data modify storage doudizhu:table_cards cards set value []
execute if entity @e[tag=dd.hand,scores={dd_card=54,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 53
execute if entity @e[tag=dd.hand,scores={dd_card=53,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 52
execute if entity @e[tag=dd.hand,scores={dd_card=52,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 51
execute if entity @e[tag=dd.hand,scores={dd_card=51,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 50
execute if entity @e[tag=dd.hand,scores={dd_card=50,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 49
execute if entity @e[tag=dd.hand,scores={dd_card=49,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 48
execute if entity @e[tag=dd.hand,scores={dd_card=48,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 47
execute if entity @e[tag=dd.hand,scores={dd_card=47,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 46
execute if entity @e[tag=dd.hand,scores={dd_card=46,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 45
execute if entity @e[tag=dd.hand,scores={dd_card=45,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 44
execute if entity @e[tag=dd.hand,scores={dd_card=44,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 43
execute if entity @e[tag=dd.hand,scores={dd_card=43,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 42
execute if entity @e[tag=dd.hand,scores={dd_card=42,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 41
execute if entity @e[tag=dd.hand,scores={dd_card=41,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 40
execute if entity @e[tag=dd.hand,scores={dd_card=40,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 39
execute if entity @e[tag=dd.hand,scores={dd_card=39,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 38
execute if entity @e[tag=dd.hand,scores={dd_card=38,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 37
execute if entity @e[tag=dd.hand,scores={dd_card=37,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 36
execute if entity @e[tag=dd.hand,scores={dd_card=36,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 35
execute if entity @e[tag=dd.hand,scores={dd_card=35,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 34
execute if entity @e[tag=dd.hand,scores={dd_card=34,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 33
execute if entity @e[tag=dd.hand,scores={dd_card=33,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 32
execute if entity @e[tag=dd.hand,scores={dd_card=32,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 31
execute if entity @e[tag=dd.hand,scores={dd_card=31,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 30
execute if entity @e[tag=dd.hand,scores={dd_card=30,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 29
execute if entity @e[tag=dd.hand,scores={dd_card=29,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 28
execute if entity @e[tag=dd.hand,scores={dd_card=28,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 27
execute if entity @e[tag=dd.hand,scores={dd_card=27,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 26
execute if entity @e[tag=dd.hand,scores={dd_card=26,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 25
execute if entity @e[tag=dd.hand,scores={dd_card=25,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 24
execute if entity @e[tag=dd.hand,scores={dd_card=24,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 23
execute if entity @e[tag=dd.hand,scores={dd_card=23,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 22
execute if entity @e[tag=dd.hand,scores={dd_card=22,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 21
execute if entity @e[tag=dd.hand,scores={dd_card=21,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 20
execute if entity @e[tag=dd.hand,scores={dd_card=20,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 19
execute if entity @e[tag=dd.hand,scores={dd_card=19,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 18
execute if entity @e[tag=dd.hand,scores={dd_card=18,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 17
execute if entity @e[tag=dd.hand,scores={dd_card=17,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 16
execute if entity @e[tag=dd.hand,scores={dd_card=16,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 15
execute if entity @e[tag=dd.hand,scores={dd_card=15,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 14
execute if entity @e[tag=dd.hand,scores={dd_card=14,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 13
execute if entity @e[tag=dd.hand,scores={dd_card=13,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 12
execute if entity @e[tag=dd.hand,scores={dd_card=12,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 11
execute if entity @e[tag=dd.hand,scores={dd_card=11,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 10
execute if entity @e[tag=dd.hand,scores={dd_card=10,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 9
execute if entity @e[tag=dd.hand,scores={dd_card=9,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 8
execute if entity @e[tag=dd.hand,scores={dd_card=8,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 7
execute if entity @e[tag=dd.hand,scores={dd_card=7,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 6
execute if entity @e[tag=dd.hand,scores={dd_card=6,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 5
execute if entity @e[tag=dd.hand,scores={dd_card=5,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 4
execute if entity @e[tag=dd.hand,scores={dd_card=4,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 3
execute if entity @e[tag=dd.hand,scores={dd_card=3,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 2
execute if entity @e[tag=dd.hand,scores={dd_card=2,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 1
execute if entity @e[tag=dd.hand,scores={dd_card=1,dd_selected=1}] run data modify storage doudizhu:table_cards cards append value 0
execute store result storage doudizhu:table_cards args.count int 1 run data get storage doudizhu:table_cards cards
function doudizhu:visual/layout with storage doudizhu:table_cards args
execute at @e[tag=dd.current,limit=1] positioned ~ ~1.04 ~ run function doudizhu:visual/loop
