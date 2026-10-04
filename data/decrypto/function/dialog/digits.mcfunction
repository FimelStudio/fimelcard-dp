scoreboard players operation #ctx dc_ctx = @s dc_id
scoreboard players set #digit_pos dc_ctx 0
execute as @e[type=minecraft:marker,tag=dc.controller] if score @s dc_id = #ctx dc_ctx run function decrypto:dialog/read_used
execute unless score #digit_pos dc_ctx matches 1..3 run return 0
data modify storage decrypto:digits dialog set value {type:'minecraft:multi_action',title:{text:'选择密码数字',color:'aqua',bold:true},body:[{type:'minecraft:plain_message',contents:{text:'请选择当前这一位数字，已选数字不能重复。',color:'gray'}}],actions:[],columns:4,exit_action:{label:{text:'暂时关闭'}},pause:false}
# 根据本桌阶段补充提示；解密只加入当前玩家所属队伍的词条。
scoreboard players operation #digit_team dc_ctx = @s dc_team
execute as @e[type=minecraft:marker,tag=dc.controller] if score @s dc_id = #ctx dc_ctx run function decrypto:dialog/guess_context
execute unless score #digit_used1 dc_ctx matches 1 unless score #digit_used2 dc_ctx matches 1 run data modify storage decrypto:digits dialog.actions append value {label:{text:'1',color:'gold',bold:true},width:60,action:{type:'minecraft:run_command',command:'trigger dc_action set 101'}}
execute unless score #digit_used1 dc_ctx matches 2 unless score #digit_used2 dc_ctx matches 2 run data modify storage decrypto:digits dialog.actions append value {label:{text:'2',color:'gold',bold:true},width:60,action:{type:'minecraft:run_command',command:'trigger dc_action set 102'}}
execute unless score #digit_used1 dc_ctx matches 3 unless score #digit_used2 dc_ctx matches 3 run data modify storage decrypto:digits dialog.actions append value {label:{text:'3',color:'gold',bold:true},width:60,action:{type:'minecraft:run_command',command:'trigger dc_action set 103'}}
execute unless score #digit_used1 dc_ctx matches 4 unless score #digit_used2 dc_ctx matches 4 run data modify storage decrypto:digits dialog.actions append value {label:{text:'4',color:'gold',bold:true},width:60,action:{type:'minecraft:run_command',command:'trigger dc_action set 104'}}
scoreboard players enable @s dc_action
function decrypto:dialog/show_digits with storage decrypto:digits
