function ito:input/context
execute unless score #valid it_ctx matches 1 run return 0
scoreboard players add #window_serial it_ctx 1
execute if score #window_serial it_ctx matches 10000001.. run scoreboard players set #window_serial it_ctx 1
scoreboard players operation @s it_window = #window_serial it_ctx
scoreboard players operation @s it_win_epoch = @e[tag=it.current,limit=1] it_epoch
scoreboard players operation #base it_ctx = @s it_window
scoreboard players operation #base it_ctx *= #hundred it_ctx
data modify storage ito:ui dialog set value {"type":"minecraft:multi_action","title":{"text":"命悬一线 · 私密手牌"},"body":[{"type":"minecraft:plain_message","width":440,"contents":{"text":"描述不要透露数字。书本模式：第一页填写后Q提交；对话框模式：点击修改描述。输入方式在开局前的游戏设置中选择。"}}],"actions":[],"columns":2,"pause":false,"after_action":"close"}
execute if score @e[tag=it.current,limit=1] it_state matches 1 run function ito:ui/topics
execute if score @e[tag=it.current,limit=1] it_state matches 2 run function ito:ui/cards
execute unless data storage ito:ui dialog.actions[0] run data modify storage ito:ui dialog.actions append value {label:{text:"等待下一阶段"}}
function ito:ui/show with storage ito:ui
