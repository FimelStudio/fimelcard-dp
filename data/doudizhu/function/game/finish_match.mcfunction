function doudizhu:player/audience
tellraw @a[tag=dd.audience] {text:"════ 斗地主整场总分 ════",color:"gold",bold:true}
scoreboard players set #best_total dd_ctx -2147483648
execute as @e[tag=dd.actors] run scoreboard players operation #best_total dd_ctx > @s dd_total
execute as @e[tag=dd.actors] run tellraw @a[tag=dd.audience] [{selector:"@s",color:"yellow"},{text:"：",color:"gray"},{score:{name:"@s",objective:"dd_total"},color:"aqua"}]
execute as @e[tag=dd.actors] if score @s dd_total = #best_total dd_ctx run tellraw @a[tag=dd.audience] [{text:"总分优胜：",color:"gold"},{selector:"@s",color:"yellow"}]
function doudizhu:game/abort
