function doudizhu:team/totals
execute if score @s dd_team_one > @s dd_team_two run tellraw @a[tag=dd.audience] {text:"橙队获胜！",color:"gold",bold:true}
execute if score @s dd_team_two > @s dd_team_one run tellraw @a[tag=dd.audience] {text:"青队获胜！",color:"aqua",bold:true}
execute if score @s dd_team_one = @s dd_team_two run tellraw @a[tag=dd.audience] {text:"两队同分，平局。",color:"yellow"}
execute if score @s dd_team_one > @s dd_team_two run function doudizhu:team/result_title {team:1,title:{text:"橙队获胜",color:"gold",bold:true}}
execute if score @s dd_team_two > @s dd_team_one run function doudizhu:team/result_title {team:2,title:{text:"青队获胜",color:"aqua",bold:true}}
execute if score @s dd_team_one = @s dd_team_two run function cardtable:game/result/title {audience:"@a[tag=dd.audience]",title:{text:"平局",color:"yellow",bold:true},subtitle:{text:""}}
function doudizhu:game/abort
