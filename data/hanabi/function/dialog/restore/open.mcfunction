# 当前执行者是抽到弃牌恢复奖励、仍持有当前回合的玩家
execute unless entity @s[tag=hb.player,tag=hb.turn,tag=hb.reward_pending,tag=hb.restore_pending] run return fail
function hanabi:input/clear_actions
scoreboard players set @s hb_action 0
scoreboard players enable @s hb_action
scoreboard players operation #ctx_id hb_ctx = @s hb_id
dialog clear @s

data modify storage hanabi:dialog restore_view set value {text:"",font:"card:hanabi_ui",shadow_color:0,extra:[]}
scoreboard players set #restore_added hb_ctx 0
scoreboard players set #restore_option hb_ctx 0
execute as @e[type=minecraft:marker,tag=hb.discard] if score @s hb_id = #ctx_id hb_ctx run scoreboard players set @s hb_option 0
scoreboard players set #discard_scan hb_ctx 1
scoreboard players set #discard_max hb_ctx 0
execute as @e[type=minecraft:marker,tag=hb.controller] if score @s hb_id = #ctx_id hb_ctx run scoreboard players operation #discard_max hb_ctx = @s hb_discard_count
execute if score #discard_max hb_ctx matches 1.. run function hanabi:dialog/restore/scan
# 末行后补足牌面向下伸出的高度，防止只显示上半张牌
execute if score #restore_added hb_ctx matches 1.. run data modify storage hanabi:dialog restore_view.extra append value {text:"\n\n\n\n\n\n\n\n",font:"minecraft:default"}
function hanabi:dialog/restore/show with storage hanabi:dialog
