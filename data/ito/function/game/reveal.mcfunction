scoreboard players set @s it_used 2
function ito:game/history
scoreboard players operation #revealed_owner it_ctx = @s it_owner
scoreboard players operation #revealed_number it_ctx = @s it_number
execute as @a[tag=it.audience] if score @s it_seat = #revealed_owner it_ctx run tellraw @a[tag=it.audience] [{text:"[命悬一线] ",color:"gold"},{selector:"@s"},{text:" 打出了 [",color:"white"},{score:{name:"#revealed_number",objective:"it_ctx"},color:"gold"},{text:"]",color:"white"}]
