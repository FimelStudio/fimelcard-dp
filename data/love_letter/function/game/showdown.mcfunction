scoreboard players operation #public_role ll_ctx = @s ll_hand
function love_letter:game/role_name
tellraw @a[tag=ll.audience] [{nbt:"data.ll_name",entity:"@s",interpret:true,color:"aqua"},{text:" 的留牌："},{nbt:"role",storage:"love_letter:runtime",interpret:true}]
