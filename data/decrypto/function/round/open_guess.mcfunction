function decrypto:input/clear_guess
scoreboard players set @s dc_pos 1
scoreboard players set @s dc_guess1 0
scoreboard players set @s dc_guess2 0
scoreboard players set @s dc_guess3 0
execute if score @s dc_state matches 5 run tellraw @a[tag=dc.player] [{text:'[谍报风云] ',color:'aqua'},{text:'黑队请拦截白队密码。',color:'yellow'}]
execute if score @s dc_state matches 6 run tellraw @a[tag=dc.player] [{text:'[谍报风云] ',color:'aqua'},{text:'白队请解码己方密码。',color:'yellow'}]
execute if score @s dc_state matches 7 run tellraw @a[tag=dc.player] [{text:'[谍报风云] ',color:'aqua'},{text:'白队请拦截黑队密码。',color:'yellow'}]
execute if score @s dc_state matches 8 run tellraw @a[tag=dc.player] [{text:'[谍报风云] ',color:'aqua'},{text:'黑队请解码己方密码。',color:'yellow'}]
execute if score @s dc_state matches 5 if score @s dc_mode matches 4 run tellraw @a[tag=dc.player] [{text:'[谍报风云] ',color:'aqua'},{selector:'@a[tag=dc.player,scores={dc_team=2,dc_encoder=0},limit=1]',color:'gold'},{text:' 负责本次拦截。',color:'yellow'}]
execute if score @s dc_state matches 5 if score @s dc_mode matches 3 run tellraw @a[tag=dc.player] [{text:'[谍报风云] ',color:'aqua'},{selector:'@a[tag=dc.player,scores={dc_team=2},limit=1]',color:'gold'},{text:'（截密者）负责本次拦截。',color:'yellow'}]
execute if score @s dc_state matches 6 if score @s dc_mode matches 4 run tellraw @a[tag=dc.player] [{text:'[谍报风云] ',color:'aqua'},{selector:'@a[tag=dc.player,scores={dc_team=1,dc_encoder=0},limit=1]',color:'gold'},{text:' 负责本次白队解码。',color:'yellow'}]
execute if score @s dc_state matches 6 if score @s dc_mode matches 3 run tellraw @a[tag=dc.player] [{text:'[阶段：合作队解码] ',color:'aqua',bold:true},{selector:'@a[tag=dc.player,scores={dc_team=1,dc_encoder=0},limit=1]',color:'gold'},{text:' 正在代表合作队解码。',color:'yellow'}]
execute if score @s dc_state matches 7 run tellraw @a[tag=dc.player] [{text:'[谍报风云] ',color:'aqua'},{selector:'@a[tag=dc.player,scores={dc_team=1,dc_encoder=0},limit=1]',color:'gold'},{text:' 负责本次拦截。',color:'yellow'}]
execute if score @s dc_state matches 8 run tellraw @a[tag=dc.player] [{text:'[谍报风云] ',color:'aqua'},{selector:'@a[tag=dc.player,scores={dc_team=2,dc_encoder=0},limit=1]',color:'gold'},{text:' 负责本次黑队解码。',color:'yellow'}]
execute if score @s dc_state matches 5 if score @s dc_mode matches 4 as @a[tag=dc.player,scores={dc_team=2,dc_encoder=0}] if score @s dc_id = #ctx dc_ctx run function decrypto:input/give_guess
execute if score @s dc_state matches 5 if score @s dc_mode matches 3 as @a[tag=dc.player,scores={dc_team=2}] if score @s dc_id = #ctx dc_ctx run function decrypto:input/give_guess
execute if score @s dc_state matches 6 if score @s dc_mode matches 4 as @a[tag=dc.player,scores={dc_team=1,dc_encoder=0}] if score @s dc_id = #ctx dc_ctx run function decrypto:input/give_guess
execute if score @s dc_state matches 6 if score @s dc_mode matches 3 as @a[tag=dc.player,scores={dc_team=1,dc_encoder=0}] if score @s dc_id = #ctx dc_ctx run function decrypto:input/give_guess
execute if score @s dc_state matches 7 as @a[tag=dc.player,scores={dc_team=1,dc_encoder=0}] if score @s dc_id = #ctx dc_ctx run function decrypto:input/give_guess
execute if score @s dc_state matches 8 as @a[tag=dc.player,scores={dc_team=2,dc_encoder=0}] if score @s dc_id = #ctx dc_ctx run function decrypto:input/give_guess
