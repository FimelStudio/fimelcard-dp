function skull:player/audience
scoreboard players operation #turn sk_ctx = @s sk_turn
execute as @a[tag=sk.audience] if score @s sk_seat = #turn sk_ctx run tellraw @a[tag=sk.audience] [{text:"[骷髅牌] 轮到 ",color:"yellow"},{selector:"@s"},{text:" 行动。"}]
