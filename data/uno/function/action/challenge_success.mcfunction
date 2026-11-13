# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players operation #seat un_ctx = @s un_offender
scoreboard players set #amount un_ctx 4
function uno:deck/draw
scoreboard players set @s un_winner 0
tellraw @a[tag=un.audience] [{text:'[UNO] 质疑成功：出牌者当时仍有当前颜色牌，罚摸四张；质疑者正常行动。',color:'yellow'}]
scoreboard players operation @s un_turn = @s un_challenger
function uno:round/turn_begin
