# @s 是玩家附近的一件掉落物，只回收原主属于本暂停桌的游戏道具。
tag @s remove ct.pause_candidate
execute if items entity @s contents *[minecraft:custom_data~{fast_card:{}}] run tag @s add ct.pause_candidate
execute if items entity @s contents *[minecraft:custom_data~{liars_holdem:{}}] run tag @s add ct.pause_candidate
execute if items entity @s contents *[minecraft:custom_data~{hanabi:{}}] run tag @s add ct.pause_candidate
execute if items entity @s contents *[minecraft:custom_data~{abraca:{}}] run tag @s add ct.pause_candidate
execute if items entity @s contents *[minecraft:custom_data~{bullshit:{}}] run tag @s add ct.pause_candidate
execute if items entity @s contents *[minecraft:custom_data~{decrypto:{}}] run tag @s add ct.pause_candidate
execute if items entity @s contents *[minecraft:custom_data~{critical_point:{}}] run tag @s add ct.pause_candidate
execute if items entity @s contents *[minecraft:custom_data~{wenfei:{}}] run tag @s add ct.pause_candidate
execute if items entity @s contents *[minecraft:custom_data~{skull:{}}] run tag @s add ct.pause_candidate
execute if items entity @s contents *[minecraft:custom_data~{doudizhu:{}}] run tag @s add ct.pause_candidate
execute if items entity @s contents *[minecraft:custom_data~{uno:{}}] run tag @s add ct.pause_candidate
execute if items entity @s contents *[minecraft:custom_data~{chess:{}}] run tag @s add ct.pause_candidate
execute if items entity @s contents *[minecraft:custom_data~{xiangqi:{}}] run tag @s add ct.pause_candidate
execute if items entity @s contents *[minecraft:custom_data~{gomoku:{}}] run tag @s add ct.pause_candidate
execute if items entity @s contents *[minecraft:custom_data~{aeroplane_chess:{}}] run tag @s add ct.pause_candidate
execute if items entity @s contents *[minecraft:custom_data~{avalon:{}}] run tag @s add ct.pause_candidate
execute if items entity @s contents *[minecraft:custom_data~{love_letter:{}}] run tag @s add ct.pause_candidate
execute if items entity @s contents *[minecraft:custom_data~{guandan:{}}] run tag @s add ct.pause_candidate
execute if items entity @s contents *[minecraft:custom_data~{ito:{}}] run tag @s add ct.pause_candidate
execute if items entity @s contents *[minecraft:custom_data~{weiqi:{}}] run tag @s add ct.pause_candidate
execute if items entity @s contents *[minecraft:custom_data~{catan:{}}] run tag @s add ct.pause_candidate
execute if items entity @s contents *[minecraft:custom_data~{splendor:{}}] run tag @s add ct.pause_candidate
execute if items entity @s contents *[minecraft:custom_data~{magical_athlete:{}}] run tag @s add ct.pause_candidate
execute unless entity @s[tag=ct.pause_candidate] run return 0
tag @s remove ct.pause_candidate
execute on origin if entity @s[type=minecraft:player,tag=ct.player,scores={ct_paused=1}] if score @s ct_id = #pause_table ct_id run tag @s add ct.pause_owner
execute unless entity @a[tag=ct.pause_owner,limit=1] run return 0
tag @s add ct.pause_candidate
tag @s add ct.paused_return
execute on origin run function cardtable:session/return_paused_drop
tag @s remove ct.pause_candidate
tag @a[tag=ct.pause_owner] remove ct.pause_owner
