function doudizhu:duplicate/match_audience
function doudizhu:duplicate/totals
execute if score @s dd_team_one > @s dd_team_two run tellraw @a[tag=dd.audience] {text:"红队获胜！",color:"red",bold:true}
execute if score @s dd_team_two > @s dd_team_one run tellraw @a[tag=dd.audience] {text:"蓝队获胜！",color:"blue",bold:true}
execute if score @s dd_team_one = @s dd_team_two run tellraw @a[tag=dd.audience] {text:"两队同分，平局。",color:"yellow"}
function doudizhu:game/abort
