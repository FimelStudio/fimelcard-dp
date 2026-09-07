scoreboard players operation #phase dc_ctx = @s dc_state
scoreboard players set #correct dc_ctx 1
execute if score @s dc_state matches 5 unless score @s dc_guess1 = @s dc_w1 run scoreboard players set #correct dc_ctx 0
execute if score @s dc_state matches 5 unless score @s dc_guess2 = @s dc_w2 run scoreboard players set #correct dc_ctx 0
execute if score @s dc_state matches 5 unless score @s dc_guess3 = @s dc_w3 run scoreboard players set #correct dc_ctx 0
execute if score @s dc_state matches 6 unless score @s dc_guess1 = @s dc_w1 run scoreboard players set #correct dc_ctx 0
execute if score @s dc_state matches 6 unless score @s dc_guess2 = @s dc_w2 run scoreboard players set #correct dc_ctx 0
execute if score @s dc_state matches 6 unless score @s dc_guess3 = @s dc_w3 run scoreboard players set #correct dc_ctx 0
execute if score @s dc_state matches 7 unless score @s dc_guess1 = @s dc_b1 run scoreboard players set #correct dc_ctx 0
execute if score @s dc_state matches 7 unless score @s dc_guess2 = @s dc_b2 run scoreboard players set #correct dc_ctx 0
execute if score @s dc_state matches 7 unless score @s dc_guess3 = @s dc_b3 run scoreboard players set #correct dc_ctx 0
execute if score @s dc_state matches 8 unless score @s dc_guess1 = @s dc_b1 run scoreboard players set #correct dc_ctx 0
execute if score @s dc_state matches 8 unless score @s dc_guess2 = @s dc_b2 run scoreboard players set #correct dc_ctx 0
execute if score @s dc_state matches 8 unless score @s dc_guess3 = @s dc_b3 run scoreboard players set #correct dc_ctx 0
# 拦截答案须保留到己方解码也提交后，才一并揭示与计分。
execute if score #phase dc_ctx matches 5 run scoreboard players operation @s dc_bg1 = @s dc_guess1
execute if score #phase dc_ctx matches 5 run scoreboard players operation @s dc_bg2 = @s dc_guess2
execute if score #phase dc_ctx matches 5 run scoreboard players operation @s dc_bg3 = @s dc_guess3
execute if score #phase dc_ctx matches 5 run scoreboard players operation @s dc_binter = #correct dc_ctx
execute if score #phase dc_ctx matches 7 run scoreboard players operation @s dc_wg1 = @s dc_guess1
execute if score #phase dc_ctx matches 7 run scoreboard players operation @s dc_wg2 = @s dc_guess2
execute if score #phase dc_ctx matches 7 run scoreboard players operation @s dc_wg3 = @s dc_guess3
execute if score #phase dc_ctx matches 7 run scoreboard players operation @s dc_winter = #correct dc_ctx
execute if score #phase dc_ctx matches 6 unless score #correct dc_ctx matches 1 run scoreboard players add @s dc_we 1
execute if score #phase dc_ctx matches 6 unless score @s dc_round matches 1 if score @s dc_binter matches 1 run scoreboard players add @s dc_bi 1
execute if score #phase dc_ctx matches 8 unless score #correct dc_ctx matches 1 run scoreboard players add @s dc_be 1
execute if score #phase dc_ctx matches 8 unless score @s dc_round matches 1 if score @s dc_winter matches 1 run scoreboard players add @s dc_wi 1
execute if score #phase dc_ctx matches 6 if score @s dc_mode matches 4 unless score @s dc_round matches 1 run tellraw @a[tag=dc.player] [{text:'[白队密码揭示] ',color:'white',bold:true},{text:'黑队拦截：',color:'gray'},{score:{name:'@s',objective:'dc_bg1'}},{text:'-'},{score:{name:'@s',objective:'dc_bg2'}},{text:'-'},{score:{name:'@s',objective:'dc_bg3'}},{text:'　白队解码：',color:'gray'},{score:{name:'@s',objective:'dc_guess1'}},{text:'-'},{score:{name:'@s',objective:'dc_guess2'}},{text:'-'},{score:{name:'@s',objective:'dc_guess3'}},{text:'　正确密码：',color:'gold'},{score:{name:'@s',objective:'dc_w1'}},{text:'-'},{score:{name:'@s',objective:'dc_w2'}},{text:'-'},{score:{name:'@s',objective:'dc_w3'}}]
execute if score #phase dc_ctx matches 6 if score @s dc_mode matches 4 if score @s dc_round matches 1 run tellraw @a[tag=dc.player] [{text:'[白队密码揭示] ',color:'white',bold:true},{text:'第一轮不拦截。白队解码：',color:'gray'},{score:{name:'@s',objective:'dc_guess1'}},{text:'-'},{score:{name:'@s',objective:'dc_guess2'}},{text:'-'},{score:{name:'@s',objective:'dc_guess3'}},{text:'　正确密码：',color:'gold'},{score:{name:'@s',objective:'dc_w1'}},{text:'-'},{score:{name:'@s',objective:'dc_w2'}},{text:'-'},{score:{name:'@s',objective:'dc_w3'}}]
execute if score #phase dc_ctx matches 6 if score #correct dc_ctx matches 1 run tellraw @a[tag=dc.player] [{text:'白队成功解码。',color:'green'}]
execute if score #phase dc_ctx matches 6 unless score #correct dc_ctx matches 1 run tellraw @a[tag=dc.player] [{text:'白队错误传讯，获得1枚红色标记。',color:'red'}]
execute if score #phase dc_ctx matches 6 unless score @s dc_round matches 1 if score @s dc_binter matches 1 run tellraw @a[tag=dc.player] [{text:'黑队成功拦截，获得1枚绿色标记。',color:'green'}]
execute if score #phase dc_ctx matches 8 unless score @s dc_round matches 1 run tellraw @a[tag=dc.player] [{text:'[黑队密码揭示] ',color:'dark_gray',bold:true},{text:'白队拦截：',color:'gray'},{score:{name:'@s',objective:'dc_wg1'}},{text:'-'},{score:{name:'@s',objective:'dc_wg2'}},{text:'-'},{score:{name:'@s',objective:'dc_wg3'}},{text:'　黑队解码：',color:'gray'},{score:{name:'@s',objective:'dc_guess1'}},{text:'-'},{score:{name:'@s',objective:'dc_guess2'}},{text:'-'},{score:{name:'@s',objective:'dc_guess3'}},{text:'　正确密码：',color:'gold'},{score:{name:'@s',objective:'dc_b1'}},{text:'-'},{score:{name:'@s',objective:'dc_b2'}},{text:'-'},{score:{name:'@s',objective:'dc_b3'}}]
execute if score #phase dc_ctx matches 8 if score @s dc_round matches 1 run tellraw @a[tag=dc.player] [{text:'[黑队密码揭示] ',color:'dark_gray',bold:true},{text:'第一轮不拦截。黑队解码：',color:'gray'},{score:{name:'@s',objective:'dc_guess1'}},{text:'-'},{score:{name:'@s',objective:'dc_guess2'}},{text:'-'},{score:{name:'@s',objective:'dc_guess3'}},{text:'　正确密码：',color:'gold'},{score:{name:'@s',objective:'dc_b1'}},{text:'-'},{score:{name:'@s',objective:'dc_b2'}},{text:'-'},{score:{name:'@s',objective:'dc_b3'}}]
execute if score #phase dc_ctx matches 8 if score #correct dc_ctx matches 1 run tellraw @a[tag=dc.player] [{text:'黑队成功解码。',color:'green'}]
execute if score #phase dc_ctx matches 8 unless score #correct dc_ctx matches 1 run tellraw @a[tag=dc.player] [{text:'黑队错误传讯，获得1枚红色标记。',color:'red'}]
execute if score #phase dc_ctx matches 8 unless score @s dc_round matches 1 if score @s dc_winter matches 1 run tellraw @a[tag=dc.player] [{text:'白队成功拦截，获得1枚绿色标记。',color:'green'}]
function decrypto:marker/update
execute if score #phase dc_ctx matches 6 run function decrypto:notes/add_white
execute if score #phase dc_ctx matches 8 run function decrypto:notes/add_black
execute if score #phase dc_ctx matches 5 run scoreboard players set @s dc_state 6
execute if score #phase dc_ctx matches 6 if score @s dc_mode matches 4 run function decrypto:round/start_black
execute if score #phase dc_ctx matches 7 run scoreboard players set @s dc_state 8
execute if score #phase dc_ctx matches 8 run function decrypto:round/next
execute if score #phase dc_ctx matches 6 if score @s dc_mode matches 3 run function decrypto:round/next
execute if score #phase dc_ctx matches 5 run function decrypto:round/open_guess
execute if score #phase dc_ctx matches 7 run function decrypto:round/open_guess
