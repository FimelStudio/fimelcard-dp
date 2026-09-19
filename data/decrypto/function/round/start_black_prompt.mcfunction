scoreboard players set @s dc_state 4
function decrypto:title/update_all
scoreboard players set @s dc_clue 0
execute as @a[tag=dc.player,scores={dc_team=2,dc_encoder=1}] run function decrypto:input/give_book
execute as @a[tag=dc.player,scores={dc_team=2,dc_encoder=1}] run tellraw @s [{text:'[本轮密码] ',color:'gold'},{score:{name:'@e[tag=dc.controller,limit=1]',objective:'dc_b1'}},{text:' - '},{score:{name:'@e[tag=dc.controller,limit=1]',objective:'dc_b2'}},{text:' - '},{score:{name:'@e[tag=dc.controller,limit=1]',objective:'dc_b3'}}]
tellraw @a[tag=dc.player] [{text:'[阶段：黑队加密] ',color:'aqua',bold:true},{selector:'@a[tag=dc.player,scores={dc_team=2,dc_encoder=1},limit=1]',color:'gold'},{text:' 正在作为黑队加密者，在提示册中填写三条提示（每页一条，完成后按Q提交）。',color:'yellow'}]
