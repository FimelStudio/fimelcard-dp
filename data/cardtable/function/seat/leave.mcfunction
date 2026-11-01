execute if score @s it_setnonce matches 1.. run function ito:settings/clear_session
execute if score @s go_setnonce matches 1.. run function weiqi:settings/clear_session
execute if score @s gd_setnonce matches 1.. run function guandan:settings/clear_session
execute if score @s ll_setnonce matches 1.. run function love_letter:settings/clear_session
execute if score @s ac_setnonce matches 1.. run function aeroplane_chess:settings/clear_session
execute if score @s gm_setnonce matches 1.. run function gomoku:settings/clear_session
execute if score @s xq_setnonce matches 1.. run function xiangqi:input/clear
execute if score @s ch_setnonce matches 1.. run function chess:input/clear
execute if score @s un_setnonce matches 1.. run function uno:settings/clear_session
# 本函数只由大厅离座检测调用
scoreboard players operation #ctx_id ct_ctx = @s ct_id
tag @s add ct.leaver
tag @e[tag=ct.leave_controller] remove ct.leave_controller
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_state=0}] if score @s ct_id = #ctx_id ct_ctx run tag @s add ct.leave_controller

execute store result storage cardtable:debug seat int 1 run scoreboard players get @s ct_seat
function cardtable:debug/log_leave with storage cardtable:debug
ride @s dismount
tag @s remove ct.player
tag @s remove ct.leaver
scoreboard players reset @s ct_id
scoreboard players reset @s ct_seat
scoreboard players reset @s ct_voted
scoreboard players reset @s ct_online

# 离座提示保持静默；身份移除后从在线玩家重新统计并按需刷新菜单
execute as @e[tag=ct.leave_controller,limit=1] at @s run function cardtable:table/recount_players
tag @e[tag=ct.leave_controller] remove ct.leave_controller
