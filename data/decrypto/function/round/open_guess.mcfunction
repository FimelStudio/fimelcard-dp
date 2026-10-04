function decrypto:input/clear_guess
function decrypto:player/audience
scoreboard players set @s dc_pos 1
scoreboard players set @s dc_guess1 0
scoreboard players set @s dc_guess2 0
scoreboard players set @s dc_guess3 0
scoreboard players operation #phase dc_ctx = @s dc_state
tag @a[tag=dc.guesser] remove dc.guesser
execute as @a[tag=dc.audience] run function decrypto:player/select_guesser
execute if score @s dc_state matches 5 run tellraw @a[tag=dc.audience] [{text:'[谍报风云] 黑队拦截白队密码：',color:'aqua'},{selector:'@a[tag=dc.guesser,limit=1]',color:'gold'},{text:' 负责输入。',color:'yellow'}]
execute if score @s dc_state matches 6 run tellraw @a[tag=dc.audience] [{text:'[谍报风云] 白队解密己方密码：',color:'aqua'},{selector:'@a[tag=dc.guesser,limit=1]',color:'gold'},{text:' 负责输入。',color:'yellow'}]
execute if score @s dc_state matches 7 run tellraw @a[tag=dc.audience] [{text:'[谍报风云] 白队拦截黑队密码：',color:'aqua'},{selector:'@a[tag=dc.guesser,limit=1]',color:'gold'},{text:' 负责输入。',color:'yellow'}]
execute if score @s dc_state matches 8 run tellraw @a[tag=dc.audience] [{text:'[谍报风云] 黑队解密己方密码：',color:'aqua'},{selector:'@a[tag=dc.guesser,limit=1]',color:'gold'},{text:' 负责输入。',color:'yellow'}]
execute as @a[tag=dc.guesser] run function decrypto:input/give_guess
tag @a[tag=dc.guesser] remove dc.guesser
