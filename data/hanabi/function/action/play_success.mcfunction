execute if score #played_color hb_ctx matches 1 run scoreboard players operation @s hb_wstack = #played_rank hb_ctx
execute if score #played_color hb_ctx matches 2 run scoreboard players operation @s hb_rstack = #played_rank hb_ctx
execute if score #played_color hb_ctx matches 3 run scoreboard players operation @s hb_bstack = #played_rank hb_ctx
execute if score #played_color hb_ctx matches 4 run scoreboard players operation @s hb_ystack = #played_rank hb_ctx
execute if score #played_color hb_ctx matches 5 run scoreboard players operation @s hb_gstack = #played_rank hb_ctx
execute if score #played_color hb_ctx matches 6 run scoreboard players operation @s hb_mstack = #played_rank hb_ctx

execute as @e[tag=hb.chosen,limit=1] run function hanabi:card/load_definition
function hanabi:player/tag_audience
function hanabi:message/play_success with storage hanabi:card def
# 使用 SK Firework 发射与本次成功接牌颜色一致的烟花；完成数字5时自动升级效果。
execute positioned ~ ~0.35 ~ run function hanabi:firework/success
function hanabi:log {text:"合法出牌成功，更新烟花堆并尝试补牌"}

# 完成一色的5会返还一个提示标记，但不会超过当前牌桌设置的上限
execute if score #played_rank hb_ctx matches 5 run scoreboard players add @s hb_clues 1
execute if score @s hb_clues > @s hb_clue_max run scoreboard players operation @s hb_clues = @s hb_clue_max

kill @e[tag=hb.chosen,limit=1]
function hanabi:score/update

# 每一列（包括最后完成的整场目标）都必须先抽取并立即处理奖励
execute if score #played_rank hb_ctx matches 5 if score @s hb_reward_left matches 1.. run return run function hanabi:reward/start

execute if score @s hb_storm matches 0 if score @s hb_score matches 25 run scoreboard players set @s hb_reason 3
execute if score @s hb_storm matches 1 if score @s hb_score matches 30 run scoreboard players set @s hb_reason 3
execute if score @s hb_reason matches 3 run function hanabi:hud/update
execute if score @s hb_reason matches 3 run return run function hanabi:game/finish
function hanabi:card/draw_to_slot
function hanabi:hud/update
function hanabi:turn/advance
