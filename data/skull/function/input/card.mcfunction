scoreboard players set #card_epoch sk_ctx -1
scoreboard players set #slot sk_ctx -1
execute store result score #card_epoch sk_ctx run data get entity @e[tag=sk.drop,limit=1] Item.components."minecraft:custom_data".skull.epoch
execute store result score #slot sk_ctx run data get entity @e[tag=sk.drop,limit=1] Item.components."minecraft:custom_data".skull.slot
kill @e[tag=sk.drop,limit=1]
scoreboard players set #played sk_ctx 0
tag @a[tag=sk.actor] remove sk.actor
tag @s add sk.actor
scoreboard players operation #ctx sk_ctx = @s sk_id
scoreboard players operation #actor_seat sk_ctx = @s sk_seat
execute store result storage skull:io action.seat int 1 run scoreboard players get @s sk_seat
execute store result storage skull:io action.slot int 1 run scoreboard players get #slot sk_ctx
execute if score #slot sk_ctx matches 1..4 as @e[type=minecraft:marker,tag=sk.controller] at @s if score @s sk_id = #ctx sk_ctx if score @s sk_epoch = #card_epoch sk_ctx run function skull:input/play
execute if score #played sk_ctx matches 0 run function skull:hand/sync
execute if score #played sk_ctx matches 0 run tellraw @s {text:"[骷髅牌] 当前不能扣这张牌，已返还。首次每人限一张；之后仅轮到自己且尚未叫号时可扣牌。",color:"yellow"}
tag @a[tag=sk.actor] remove sk.actor
tag @a[tag=sk.audience] remove sk.audience
