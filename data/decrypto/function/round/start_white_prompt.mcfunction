scoreboard players set @s dc_state 2
scoreboard players set @s dc_clue 0
setblock ~ ~1 ~ minecraft:anvil
execute if score @s dc_mode matches 4 as @a[tag=dc.player,scores={dc_team=1,dc_encoder=1}] run function decrypto:input/give_papers
execute if score @s dc_mode matches 3 as @a[tag=dc.player,scores={dc_encoder=1}] run function decrypto:input/give_papers
execute as @a[tag=dc.player,scores={dc_team=1,dc_encoder=1}] run tellraw @s [{text:'[本轮密码] ',color:'gold'},{score:{name:'@e[tag=dc.controller,limit=1]',objective:'dc_w1'}},{text:' - '},{score:{name:'@e[tag=dc.controller,limit=1]',objective:'dc_w2'}},{text:' - '},{score:{name:'@e[tag=dc.controller,limit=1]',objective:'dc_w3'}}]
tellraw @a[tag=dc.player] [{text:'[阶段：白队加密] ',color:'aqua',bold:true},{selector:'@a[tag=dc.player,scores={dc_team=1,dc_encoder=1},limit=1]',color:'gold'},{text:' 正在作为白队加密者，秘密用铁砧提交三条提示。',color:'yellow'}]
