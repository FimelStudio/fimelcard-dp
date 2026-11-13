function doudizhu:duplicate/match_audience
function doudizhu:duplicate/totals
execute if score @s dd_team_one > @s dd_team_two run tellraw @a[tag=dd.audience] {text:"红队获胜！",color:"red",bold:true}
execute if score @s dd_team_two > @s dd_team_one run tellraw @a[tag=dd.audience] {text:"蓝队获胜！",color:"blue",bold:true}
execute if score @s dd_team_one > @s dd_team_two run function doudizhu:team/result_title {team:1,title:{text:"红队获胜",color:"red",bold:true}}
execute if score @s dd_team_two > @s dd_team_one run function doudizhu:team/result_title {team:2,title:{text:"蓝队获胜",color:"blue",bold:true}}
function doudizhu:game/abort
