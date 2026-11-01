# 每次重画更换独立 nonce；旧选择窗即使同一回合也不能重放。
scoreboard players add #ui_serial gd_ctx 1
execute if score #ui_serial gd_ctx matches 200001.. run scoreboard players add #ui_load gd_ctx 1
execute if score #ui_serial gd_ctx matches 200001.. run scoreboard players set #ui_serial gd_ctx 1
scoreboard players operation @s gd_seen = #ui_serial gd_ctx
scoreboard players operation @s gd_uiepoch = @e[tag=gd.current,limit=1] gd_epoch
scoreboard players operation @s gd_ui_load = #ui_load gd_ctx
scoreboard players operation #ui_base gd_ctx = #ui_serial gd_ctx
scoreboard players set #ui_factor gd_ctx 10000
scoreboard players operation #ui_base gd_ctx *= #ui_factor gd_ctx
scoreboard players set @s gd_action 0
scoreboard players enable @s gd_action
data modify storage guandan:ui buttons set value []
data modify storage guandan:ui rows set value {text:"",extra:[]}
data modify storage guandan:ui phase set value {text:"等待出牌。",color:"gray"}
data modify storage guandan:ui info set value {text:"",extra:[]}
data modify storage guandan:ui grid set value {text:"",shadow_color:0,extra:[]}
data modify storage guandan:ui cards0 set value {text:"",shadow_color:0,extra:[]}
data modify storage guandan:ui cards1 set value {text:"",shadow_color:0,extra:[]}
data modify storage guandan:ui cards2 set value {text:"",shadow_color:0,extra:[]}
data modify storage guandan:ui title set value "掼蛋 · 手牌"
