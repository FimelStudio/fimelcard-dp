scoreboard players operation #scan_table wq_ctx = @s wq_id
execute at @s as @e[type=minecraft:item,tag=!wq.rejected,distance=..8] if items entity @s contents *[minecraft:custom_data~{wenfei:{}}] run function wenfei:input/drop
tag @a[tag=wq.audience] remove wq.audience
