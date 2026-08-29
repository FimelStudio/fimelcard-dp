scoreboard players operation #ctx ab_ctx = @s ab_id
function abraca:log {text:"游戏正常结束，正在清理本桌状态"}
tellraw @a[tag=ab.player] [{text:'[出包魔法师] ',color:'dark_purple'},{text:'游戏结束。',color:'gold'}]
function abraca:hud/finalize
execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx run function abraca:player/clear_state
execute as @e[tag=ab.game_entity] if score @s ab_id = #ctx ab_ctx run kill @s
# 结算血量保留 6 秒；期间不重建大厅菜单，避免与结算面板重叠。
scoreboard players set @s ab_state 3
scoreboard players set @s ab_timer 120
