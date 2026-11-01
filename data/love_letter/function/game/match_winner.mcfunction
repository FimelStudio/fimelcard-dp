tellraw @a[tag=ll.audience] [{text:"[情书] 本场胜者：",color:"gold"},{nbt:"data.ll_name",entity:"@s",interpret:true,color:"aqua"},{text:" · "},{score:{name:"@s",objective:"ll_points"}},{text:" 好感。"}]
scoreboard players operation #victory_seat ll_ctx = @s ll_seat
execute as @a[tag=ll.audience] if score @s ll_seat = #victory_seat ll_ctx at @s run function love_letter:game/firework
