scoreboard players set @s it_used 2
function ito:game/history
tellraw @a[tag=it.audience] [{text:"[命悬一线] 翻开：",color:"gold"},{score:{name:"@s",objective:"it_number"}}]
