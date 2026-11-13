$execute as @e[type=minecraft:interaction,tag=ct.vote,nbt={interaction:{player:$(uuid),timestamp:$(tick)L}}] run scoreboard players operation #clicked_table ct_ctx = @s ct_id
$execute as @e[type=minecraft:interaction,tag=ct.vote,nbt={attack:{player:$(uuid),timestamp:$(tick)L}}] run scoreboard players operation #clicked_table ct_ctx = @s ct_id
