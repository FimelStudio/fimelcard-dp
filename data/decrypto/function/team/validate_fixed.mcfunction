scoreboard players set #fixed_valid dc_ctx 0
scoreboard players operation #team_capacity dc_ctx = @s ct_capacity
scoreboard players set #fixed_white dc_ctx 0
scoreboard players set #fixed_black dc_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #ctx dc_ctx run function decrypto:team/count_fixed_one
scoreboard players operation #fixed_diff dc_ctx = #fixed_white dc_ctx
scoreboard players operation #fixed_diff dc_ctx -= #fixed_black dc_ctx
execute if score #fixed_white dc_ctx matches 2..4 if score #fixed_black dc_ctx matches 2..4 if score #fixed_diff dc_ctx matches -1..1 run scoreboard players set #fixed_valid dc_ctx 1
execute unless score #fixed_valid dc_ctx matches 1 run tellraw @a[tag=ct.start_actor,limit=1] [{text:"[谍报风云] 当前固定分队：白队 "},{score:{name:"#fixed_white",objective:"dc_ctx"}},{text:" 人，黑队 "},{score:{name:"#fixed_black",objective:"dc_ctx"}},{text:" 人。每队需2至4人，人数差不能超过1人。请调整座位或改用随机组队。",color:"yellow"}]
