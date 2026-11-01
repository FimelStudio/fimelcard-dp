tellraw @a[tag=go.audience] [{text:"[围棋] ",color:"gold"},{nbt:"data.weiqi.result",entity:"@s",interpret:false,color:"gold",bold:true},{text:"。五秒后返回大厅，可通过最后一格菜单复盘。",color:"yellow"}]
execute if score @s go_reason matches 1 run function weiqi:game/result_score
execute if score @s go_reason matches 6 run tellraw @a[tag=go.audience] {"text": "[围棋] 胜负原因：一方超时。", "color": "yellow"}
execute if score @s go_reason matches 7 run tellraw @a[tag=go.audience] {"text": "[围棋] 胜负原因：一方认输。", "color": "yellow"}
