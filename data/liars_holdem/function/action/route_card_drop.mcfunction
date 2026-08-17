# 当前执行者是参赛玩家附近的一张赌命德州扑克手牌掉落物
# origin会切换到真正丢出该物品的玩家，可避免同桌多人同时按Q时串牌
tag @e[type=minecraft:item,tag=lh.dropped_owned] remove lh.dropped_owned
tag @s add lh.drop_processed
tag @s add lh.dropped_owned
execute on origin if entity @s[tag=lh.player] at @s run function liars_holdem:action/drop_card
tag @s remove lh.dropped_owned
