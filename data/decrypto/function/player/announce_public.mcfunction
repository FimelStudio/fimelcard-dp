scoreboard players operation #ctx dc_ctx = @s dc_id
tag @a[tag=dc.public_audience] remove dc.public_audience
tag @a[tag=dc.white_encoder] remove dc.white_encoder
tag @a[tag=dc.white_decoder] remove dc.white_decoder
tag @a[tag=dc.black_encoder] remove dc.black_encoder
tag @a[tag=dc.black_decoder] remove dc.black_decoder
tag @a[tag=dc.coop_encoder] remove dc.coop_encoder
tag @a[tag=dc.coop_decoder] remove dc.coop_decoder
tag @a[tag=dc.public_interceptor] remove dc.public_interceptor
execute as @a[tag=dc.player] if score @s dc_id = #ctx dc_ctx run tag @s add dc.public_audience
execute if score @s dc_mode matches 4 as @a[tag=dc.public_audience,scores={dc_team=1,dc_encoder=1}] run tag @s add dc.white_encoder
execute if score @s dc_mode matches 4 as @a[tag=dc.public_audience,scores={dc_team=1,dc_encoder=0}] run tag @s add dc.white_decoder
execute if score @s dc_mode matches 4 as @a[tag=dc.public_audience,scores={dc_team=2,dc_encoder=1}] run tag @s add dc.black_encoder
execute if score @s dc_mode matches 4 as @a[tag=dc.public_audience,scores={dc_team=2,dc_encoder=0}] run tag @s add dc.black_decoder
execute if score @s dc_mode matches 4 run tellraw @a[tag=dc.public_audience] [{text:'════ 本轮公开分工 ════',color:'aqua',bold:true}]
execute if score @s dc_mode matches 4 run tellraw @a[tag=dc.public_audience] [{text:'白队：',color:'white',bold:true},{selector:'@a[tag=dc.white_encoder,limit=1]',color:'gold'},{text:' 加密；',color:'gray'},{selector:'@a[tag=dc.white_decoder,limit=1]',color:'aqua'},{text:' 解密并截密黑队。',color:'gray'}]
execute if score @s dc_mode matches 4 run tellraw @a[tag=dc.public_audience] [{text:'黑队：',color:'dark_gray',bold:true},{selector:'@a[tag=dc.black_encoder,limit=1]',color:'gold'},{text:' 加密；',color:'gray'},{selector:'@a[tag=dc.black_decoder,limit=1]',color:'light_purple'},{text:' 解密并截密白队。',color:'gray'}]
execute if score @s dc_mode matches 3 as @a[tag=dc.public_audience,scores={dc_team=1,dc_encoder=1}] run tag @s add dc.coop_encoder
execute if score @s dc_mode matches 3 as @a[tag=dc.public_audience,scores={dc_team=1,dc_encoder=0}] run tag @s add dc.coop_decoder
execute if score @s dc_mode matches 3 as @a[tag=dc.public_audience,scores={dc_team=2}] run tag @s add dc.public_interceptor
execute if score @s dc_mode matches 3 run tellraw @a[tag=dc.public_audience] [{text:'════ 本轮公开分工 ════',color:'aqua',bold:true}]
execute if score @s dc_mode matches 3 run tellraw @a[tag=dc.public_audience] [{selector:'@a[tag=dc.coop_encoder,limit=1]',color:'gold'},{text:' 为合作队加密者；',color:'gray'},{selector:'@a[tag=dc.coop_decoder,limit=1]',color:'green'},{text:' 为合作队解密者；',color:'gray'},{selector:'@a[tag=dc.public_interceptor,limit=1]',color:'red'},{text:' 为截密者。',color:'gray'}]
tag @a[tag=dc.public_audience] remove dc.public_audience
tag @a[tag=dc.white_encoder] remove dc.white_encoder
tag @a[tag=dc.white_decoder] remove dc.white_decoder
tag @a[tag=dc.black_encoder] remove dc.black_encoder
tag @a[tag=dc.black_decoder] remove dc.black_decoder
tag @a[tag=dc.coop_encoder] remove dc.coop_encoder
tag @a[tag=dc.coop_decoder] remove dc.coop_decoder
tag @a[tag=dc.public_interceptor] remove dc.public_interceptor
