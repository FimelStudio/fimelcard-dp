# 执行者为本桌控制器，内容复制成静态组件供Dialog显示。
execute unless score @s dc_state matches 5..8 run return 0
execute unless data entity @s data.decrypto.active_clues run return 0
data modify storage decrypto:digits dialog.title set value {text:'拦截密码',color:'aqua',bold:true}
execute if score @s dc_state matches 6 run data modify storage decrypto:digits dialog.title set value {text:'解密密码',color:'aqua',bold:true}
execute if score @s dc_state matches 8 run data modify storage decrypto:digits dialog.title set value {text:'解密密码',color:'aqua',bold:true}
data modify storage decrypto:digits dialog.body set value [{type:'minecraft:plain_message',width:440,contents:{text:'本轮提示',color:'gold',bold:true}}]
data modify storage decrypto:digits row set value {type:'minecraft:plain_message',width:440,contents:{text:'1：',color:'aqua',extra:[]}}
data modify storage decrypto:digits row.contents.extra append from entity @s data.decrypto.active_clues.1
data modify storage decrypto:digits dialog.body append from storage decrypto:digits row
data modify storage decrypto:digits row set value {type:'minecraft:plain_message',width:440,contents:{text:'2：',color:'aqua',extra:[]}}
data modify storage decrypto:digits row.contents.extra append from entity @s data.decrypto.active_clues.2
data modify storage decrypto:digits dialog.body append from storage decrypto:digits row
data modify storage decrypto:digits row set value {type:'minecraft:plain_message',width:440,contents:{text:'3：',color:'aqua',extra:[]}}
data modify storage decrypto:digits row.contents.extra append from entity @s data.decrypto.active_clues.3
data modify storage decrypto:digits dialog.body append from storage decrypto:digits row
# 拦截阶段(5/7)不加入任何词条；解密阶段只复制己方词条。
execute if score @s dc_state matches 6 if score #digit_team dc_ctx matches 1 run data modify storage decrypto:digits dialog.body append value {type:'minecraft:plain_message',width:440,contents:{text:'己方词条',color:'gold',bold:true}}
execute if score @s dc_state matches 6 if score #digit_team dc_ctx matches 1 run data modify storage decrypto:digits row.contents set from entity @s data.decrypto.keywords.white
execute if score @s dc_state matches 6 if score #digit_team dc_ctx matches 1 run data modify storage decrypto:digits dialog.body append from storage decrypto:digits row
execute if score @s dc_state matches 8 if score #digit_team dc_ctx matches 2 run data modify storage decrypto:digits dialog.body append value {type:'minecraft:plain_message',width:440,contents:{text:'己方词条',color:'gold',bold:true}}
execute if score @s dc_state matches 8 if score #digit_team dc_ctx matches 2 run data modify storage decrypto:digits row.contents set from entity @s data.decrypto.keywords.black
execute if score @s dc_state matches 8 if score #digit_team dc_ctx matches 2 run data modify storage decrypto:digits dialog.body append from storage decrypto:digits row
data modify storage decrypto:digits dialog.body append value {type:'minecraft:plain_message',width:440,contents:{text:'请选择当前这一位数字，已选数字不能重复。',color:'gray'}}
data remove storage decrypto:digits row
