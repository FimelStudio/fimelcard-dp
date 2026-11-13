# 保留唯一顶牌；其余弃牌随机抽取即构成新洗牌堆。
scoreboard players operation #u_top un_ctx = @s un_top
execute as @e[type=minecraft:marker,tag=un.cards,scores={un_owner=-1}] unless score @s un_idx = #u_top un_ctx run scoreboard players set @s un_owner 0
execute if entity @e[type=minecraft:marker,tag=un.cards,scores={un_owner=0}] run tellraw @a[tag=un.audience] [{text:'[UNO] 摸牌堆已耗尽，弃牌重新洗回。',color:'gray'}]
