# 每次重画分配新的按钮编号，旧窗口无法写入新的草稿。
execute if score #guess_sequence dc_ctx matches 21474835.. run scoreboard players set #guess_sequence dc_ctx 0
scoreboard players add #guess_sequence dc_ctx 1
scoreboard players operation @s dc_gserial = #guess_sequence dc_ctx
scoreboard players set #guess_base dc_ctx 100
scoreboard players operation #guess_base dc_ctx *= @s dc_gserial
data modify storage decrypto:guess dialog set value {type:"minecraft:confirmation",title:{text:"拦截对方密码",color:"aqua",bold:true},body:[],yes:{label:{text:"确认提交",color:"green",bold:true},action:{type:"minecraft:run_command",command:""}},no:{label:{text:"暂时关闭"},action:{type:"minecraft:run_command",command:""}},pause:false,after_action:"none"}
execute if score #guess_phase dc_ctx matches 6 run function decrypto:guess/keywords {side:"white"}
execute if score #guess_phase dc_ctx matches 8 run function decrypto:guess/keywords {side:"black"}
data modify storage decrypto:guess dialog.body append value {type:"minecraft:plain_message",width:320,contents:{text:"每条提示选一个数字。确认前可随时更改，三个数字不能重复。",color:"gray"}}
execute if score #guess_invalid dc_ctx matches 1 run data modify storage decrypto:guess dialog.body append value {type:"minecraft:plain_message",width:320,contents:{text:"请为三条提示各选一个不同的数字。",color:"red"}}
data modify storage decrypto:guess clues set value [{text:""},{text:""},{text:""}]
data modify storage decrypto:guess clues[0] set from entity @e[type=minecraft:marker,tag=dc.guess_table,limit=1] data.decrypto.active_clues.1
data modify storage decrypto:guess clues[1] set from entity @e[type=minecraft:marker,tag=dc.guess_table,limit=1] data.decrypto.active_clues.2
data modify storage decrypto:guess clues[2] set from entity @e[type=minecraft:marker,tag=dc.guess_table,limit=1] data.decrypto.active_clues.3
execute if score @e[type=minecraft:marker,tag=dc.guess_table,limit=1] dc_sync matches 1 if score #guess_phase dc_ctx matches 5..6 run data modify storage decrypto:guess clues set from entity @e[type=minecraft:marker,tag=dc.guess_table,limit=1] data.decrypto.sync.white.clues
execute if score @e[type=minecraft:marker,tag=dc.guess_table,limit=1] dc_sync matches 1 if score #guess_phase dc_ctx matches 7..8 run data modify storage decrypto:guess clues set from entity @e[type=minecraft:marker,tag=dc.guess_table,limit=1] data.decrypto.sync.black.clues
scoreboard players operation #guess_selected dc_ctx = @s dc_g1
scoreboard players operation #guess_command dc_ctx = #guess_base dc_ctx
scoreboard players add #guess_command dc_ctx 10
function decrypto:guess/row {row:1,index:0}
scoreboard players operation #guess_selected dc_ctx = @s dc_g2
scoreboard players operation #guess_command dc_ctx = #guess_base dc_ctx
scoreboard players add #guess_command dc_ctx 20
function decrypto:guess/row {row:2,index:1}
scoreboard players operation #guess_selected dc_ctx = @s dc_g3
scoreboard players operation #guess_command dc_ctx = #guess_base dc_ctx
scoreboard players add #guess_command dc_ctx 30
function decrypto:guess/row {row:3,index:2}
scoreboard players operation #guess_command dc_ctx = #guess_base dc_ctx
scoreboard players add #guess_command dc_ctx 90
execute store result storage decrypto:guess command int 1 run scoreboard players get #guess_command dc_ctx
function decrypto:guess/confirm_button with storage decrypto:guess
scoreboard players add #guess_command dc_ctx 1
execute store result storage decrypto:guess command int 1 run scoreboard players get #guess_command dc_ctx
function decrypto:guess/close_button with storage decrypto:guess
scoreboard players enable @s dc_action
function decrypto:guess/show with storage decrypto:guess
