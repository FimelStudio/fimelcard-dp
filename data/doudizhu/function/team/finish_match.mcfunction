function doudizhu:team/totals
execute if score @s dd_team_one > @s dd_team_two run tellraw @a[tag=dd.audience] {text:"橙队获胜！",color:"gold",bold:true}
execute if score @s dd_team_two > @s dd_team_one run tellraw @a[tag=dd.audience] {text:"青队获胜！",color:"aqua",bold:true}
execute if score @s dd_team_one = @s dd_team_two run tellraw @a[tag=dd.audience] {text:"两队同分，平局。",color:"yellow"}
function doudizhu:game/abort
