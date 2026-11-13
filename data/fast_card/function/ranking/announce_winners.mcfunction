tag @a[tag=fc.finish_audience] remove fc.finish_audience
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run tag @s add fc.finish_audience
tag @a[tag=ct.final_winner] remove ct.final_winner
execute as @a[tag=fc.finish_audience] if score @s fc_score = #best fc_ctx run tag @s add ct.final_winner
execute if entity @a[tag=ct.final_winner] run function cardtable:game/result/title {audience:"@a[tag=fc.finish_audience]",title:{text:"最终胜利者",color:"gold",bold:true},subtitle:{selector:"@a[tag=ct.final_winner]"}}
tag @a[tag=ct.final_winner] remove ct.final_winner
tag @a[tag=fc.finish_audience] remove fc.finish_audience
