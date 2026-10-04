# 重载老版本三/四人对局时只补角色信息，不改变本轮加密者或队伍。
scoreboard players operation #ctx dc_ctx = @s dc_id
scoreboard players set #legacy_roles dc_ctx 0
execute as @a[tag=dc.player] if score @s dc_id = #ctx dc_ctx unless score @s dc_role matches 0..4 run scoreboard players set #legacy_roles dc_ctx 1
execute unless score #legacy_roles dc_ctx matches 1 run return 0
function decrypto:team/index
execute if score @s dc_mode matches 4 as @a[tag=dc.player] if score @s dc_id = #ctx dc_ctx run scoreboard players set @s dc_role 4
execute if score @s dc_mode matches 4 as @a[tag=dc.player,scores={dc_encoder=1}] if score @s dc_id = #ctx dc_ctx run scoreboard players set @s dc_role 1
execute if score @s dc_mode matches 3 as @a[tag=dc.player] if score @s dc_id = #ctx dc_ctx run function decrypto:roles/three
