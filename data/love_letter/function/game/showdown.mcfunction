scoreboard players set #public_role ll_ctx -1
execute if score @s ll_alive matches 1 run scoreboard players operation #public_role ll_ctx = @s ll_hand
execute if score @s ll_alive matches 0 if data entity @s data.discards[-1] store result score #public_role ll_ctx run data get entity @s data.discards[-1]
execute if score #public_role ll_ctx matches 0..9 store result entity @s data.ll_reveal int 1 run scoreboard players get #public_role ll_ctx
function love_letter:game/role_name
execute if score @s ll_alive matches 1 run tellraw @a[tag=ll.audience] [{nbt:"data.ll_name",entity:"@s",interpret:true,color:"aqua"},{text:" 摊牌："},{nbt:"role",storage:"love_letter:runtime",interpret:true}]
execute if score @s ll_alive matches 0 run tellraw @a[tag=ll.audience] [{nbt:"data.ll_name",entity:"@s",interpret:true,color:"aqua"},{text:" 已出局，最后亮出的牌：",color:"gray"},{nbt:"role",storage:"love_letter:runtime",interpret:true}]
