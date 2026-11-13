# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players reset @s sp_action
scoreboard players reset @s sp_nonce
function splendor:hud/notice {"text":{"text":"直接右键桌面的宝石、发展卡和牌堆；左键取消选择。","color":"yellow"}}
