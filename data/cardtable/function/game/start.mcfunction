# 通用层只负责界面和生命周期；人数范围、快捷栏等开局条件由所选游戏自行校验
function cardtable:log {text:"收到开始游戏请求"}

scoreboard players set @s ct_start 0
execute if score @s ct_game matches 1 run function fast_card:game/start
execute if score @s ct_game matches 2 run function liars_holdem:game/start
execute if score @s ct_game matches 3 run function hanabi:game/start
execute unless score @s ct_start matches 1 run return fail

# 游戏确认成功后才隐藏中央菜单并生成结束投票按钮
function cardtable:log {text:"游戏模块启动成功，切换到游戏界面"}
scoreboard players set @s ct_state 1
scoreboard players set @s ct_votes 0
scoreboard players operation #ctx_id ct_ctx = @s ct_id
execute as @a[tag=ct.player] if score @s ct_id = #ctx_id ct_ctx run scoreboard players set @s ct_voted 0
execute as @e[tag=ct.menu] if score @s ct_id = #ctx_id ct_ctx run kill @s
function cardtable:vote/render
