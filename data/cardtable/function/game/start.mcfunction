# 通用层只负责界面和生命周期；人数范围、快捷栏等开局条件由所选游戏自行校验
function cardtable:log {text:"收到开始游戏请求"}

scoreboard players set @s ct_start 0
execute if score @s ct_joined > @s ct_capacity run return fail
execute if score @s ct_game matches 1 run function fast_card:game/start
execute if score @s ct_game matches 2 run function liars_holdem:game/start
execute if score @s ct_game matches 3 run function hanabi:game/start
execute if score @s ct_game matches 4 run function abraca:game/start
execute if score @s ct_game matches 5 run function bullshit:game/start
execute if score @s ct_game matches 6 run function decrypto:game/start
execute if score @s ct_game matches 7 run function critical_point:game/start
execute if score @s ct_game matches 8 run function wenfei:game/start
execute if score @s ct_game matches 9 run function skull:game/start
execute if score @s ct_game matches 10 run function doudizhu:game/start
execute if score @s ct_game matches 11 run function uno:game/start
execute if score @s ct_game matches 12 run function chess:game/start
execute if score @s ct_game matches 13 run function xiangqi:game/start
execute unless score @s ct_start matches 1 run return fail

# 游戏确认成功后才隐藏中央菜单并生成结束投票按钮
function cardtable:log {text:"游戏模块启动成功，切换到游戏界面"}
scoreboard players set @s ct_state 1
scoreboard players set @s ct_votes 0
scoreboard players operation #ctx_id ct_ctx = @s ct_id
# 开局即废弃本桌所有未提交的游戏选择窗口。
execute as @a if score @s ct_pick_table = #ctx_id ct_ctx run scoreboard players reset @s ct_pick_table
execute as @a[tag=ct.player] if score @s ct_id = #ctx_id ct_ctx run scoreboard players set @s ct_voted 0
execute as @e[tag=ct.menu] if score @s ct_id = #ctx_id ct_ctx run kill @s
function cardtable:vote/render
