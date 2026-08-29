scoreboard players add @s ab_scan 1
execute if score @s ab_scan matches 5.. run scoreboard players set @s ab_scan 1
scoreboard players operation #scan ab_ctx = @s ab_scan
execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx if score @s ab_seat = #scan ab_ctx run tag @s add ab.deal_receiver
execute if entity @a[tag=ab.deal_receiver,limit=1] run scoreboard players set #found ab_ctx 1
