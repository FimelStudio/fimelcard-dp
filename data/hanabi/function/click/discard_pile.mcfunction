# uninstall-guard: begin (tools/build_uninstall.py)
execute if data storage cardtable:uninstall active run return 0
execute unless score #version ct_ctx matches 1.. run return 0
# uninstall-guard: end
advancement revoke @s only hanabi:click/discard_pile
advancement revoke @s only hanabi:click/discard_pile_attack
# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end

# 从实际点击位置附近的入口读取桌号，允许未参赛的附近玩家查看公开弃牌信息
scoreboard players set #discard_target hb_ctx 0
execute if entity @e[type=minecraft:interaction,tag=hb.discard_button,distance=..6,sort=nearest,limit=1] run scoreboard players set #discard_target hb_ctx 1
execute as @e[type=minecraft:interaction,tag=hb.discard_button,distance=..6,sort=nearest,limit=1] run scoreboard players operation #ctx_id hb_ctx = @s hb_id
execute unless score #discard_target hb_ctx matches 1 run return fail

scoreboard players set #discard_active hb_ctx 0
execute as @e[type=minecraft:marker,tag=hb.controller,scores={hb_state=2..3}] if score @s hb_id = #ctx_id hb_ctx run scoreboard players set #discard_active hb_ctx 1
execute unless score #discard_active hb_ctx matches 1 run return fail
function hanabi:dialog/discard/open_public
playsound minecraft:item.book.page_turn master @s ~ ~ ~ 0.65 1.1
function hanabi:log {text:"玩家点击桌角弃牌堆并打开公开Dialog"}
