function doudizhu:player/audience
tellraw @a[tag=dd.audience] {text:"════ 斗地主整场总分 ════",color:"gold",bold:true}
execute if score @s dd_humans matches 4 run return run function doudizhu:team/finish_match
scoreboard players set #best_total dd_ctx -2147483648
execute as @e[tag=dd.actors] run scoreboard players operation #best_total dd_ctx > @s dd_total
execute as @e[tag=dd.actors] run tellraw @a[tag=dd.audience] [{selector:"@s",color:"yellow"},{text:"：",color:"gray"},{score:{name:"@s",objective:"dd_total"},color:"aqua"}]
execute as @e[tag=dd.actors] if score @s dd_total = #best_total dd_ctx run tellraw @a[tag=dd.audience] [{text:"总分优胜：",color:"gold"},{selector:"@s",color:"yellow"}]
tag @e[tag=ct.final_winner] remove ct.final_winner
execute as @e[tag=dd.actors] if score @s dd_total = #best_total dd_ctx run tag @s add ct.final_winner
execute if entity @e[tag=ct.final_winner] run function cardtable:game/result/title {audience:"@a[tag=dd.audience]",title:{text:"最终胜利者",color:"gold",bold:true},subtitle:{selector:"@e[tag=ct.final_winner]"}}
tag @e[tag=ct.final_winner] remove ct.final_winner
function doudizhu:game/abort
