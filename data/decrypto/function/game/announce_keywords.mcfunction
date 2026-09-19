# 在清理玩家状态和左上角面板前，向本桌玩家公开本局密码词语。
scoreboard players operation #ctx dc_ctx = @s dc_id
tag @a[tag=dc.end_audience] remove dc.end_audience
execute as @a[tag=dc.player] if score @s dc_id = #ctx dc_ctx run tag @s add dc.end_audience
function decrypto:hud/load_keywords
tellraw @a[tag=dc.end_audience] [{text:'════ 本局密码词语公开 ════',color:'gold',bold:true}]
execute if score @s dc_mode matches 4 run tellraw @a[tag=dc.end_audience] [{text:'白队：',color:'white',bold:true},{nbt:'white',storage:'decrypto:hud',interpret:true,color:'aqua'}]
execute if score @s dc_mode matches 4 run tellraw @a[tag=dc.end_audience] [{text:'黑队：',color:'dark_gray',bold:true},{nbt:'black',storage:'decrypto:hud',interpret:true,color:'light_purple'}]
execute if score @s dc_mode matches 3 run tellraw @a[tag=dc.end_audience] [{text:'合作队：',color:'white',bold:true},{nbt:'white',storage:'decrypto:hud',interpret:true,color:'aqua'}]
tag @a[tag=dc.end_audience] remove dc.end_audience
