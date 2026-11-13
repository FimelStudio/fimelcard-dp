execute if score @s go_result matches 1 run function cardtable:game/result/title {audience:"@a[tag=go.audience]",title:{text:"黑方获胜",color:"gray",bold:true},subtitle:{nbt:"data.weiqi.black_name",entity:"@s",interpret:true}}
execute if score @s go_result matches 2 run function cardtable:game/result/title {audience:"@a[tag=go.audience]",title:{text:"白方获胜",color:"white",bold:true},subtitle:{nbt:"data.weiqi.white_name",entity:"@s",interpret:true}}
execute if score @s go_result matches 3 run function cardtable:game/result/title {audience:"@a[tag=go.audience]",title:{text:"和棋",color:"yellow",bold:true},subtitle:{text:""}}
tellraw @a[tag=go.audience] [{text:"[围棋] ",color:"gold"},{nbt:"data.weiqi.result",entity:"@s",interpret:false,color:"gold",bold:true},{text:"。五秒后返回大厅，可通过最后一格菜单复盘。",color:"yellow"}]
execute if score @s go_reason matches 1 run function weiqi:game/result_score
execute if score @s go_reason matches 6 run tellraw @a[tag=go.audience] {"text": "[围棋] 胜负原因：一方超时。", "color": "yellow"}
execute if score @s go_reason matches 7 run tellraw @a[tag=go.audience] {"text": "[围棋] 胜负原因：一方认输。", "color": "yellow"}
