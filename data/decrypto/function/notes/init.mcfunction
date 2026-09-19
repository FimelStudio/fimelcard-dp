data modify storage decrypto:notes white set value {'1':[],'2':[],'3':[],'4':[]}
data modify storage decrypto:notes black set value {'1':[],'2':[],'3':[],'4':[]}
# 显示缓存只在新局清空，原始记录与缓存都跨回合累积。
data modify entity @s data.decrypto.note_lines set value {white:{'1':[],'2':[],'3':[],'4':[]},black:{'1':[],'2':[],'3':[],'4':[]}}
scoreboard players set @s dc_page 0
scoreboard players set @s dc_pages 1
scoreboard players set @s dc_page_tick 0
