# 角色：0轮空、1加密（两人队也负责拦截）、2解密、3拦截。
scoreboard players operation @s dc_role = @s dc_index
scoreboard players operation @s dc_role += #role_round dc_ctx
scoreboard players remove @s dc_role 1
scoreboard players operation @s dc_role %= @s dc_size
scoreboard players add @s dc_role 1
execute if score @s dc_size matches 4 if score @s dc_role matches 4 run scoreboard players set @s dc_role 0
scoreboard players set @s dc_encoder 0
execute if score @s dc_role matches 1 run scoreboard players set @s dc_encoder 1
