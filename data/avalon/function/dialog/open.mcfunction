execute unless entity @e[tag=av.current,limit=1] run return 0
scoreboard players add #nonce av_ctx 100
execute if score #nonce av_ctx matches 2000000000.. run scoreboard players set #nonce av_ctx 100
scoreboard players operation @s av_ui_base = #nonce av_ctx
scoreboard players operation @s av_ui_epoch = @e[tag=av.current,limit=1] av_epoch
scoreboard players set @s av_action 0
scoreboard players enable @s av_action
scoreboard players operation #viewer av_ctx = @s av_seat
scoreboard players operation #role av_ctx = @s av_role
scoreboard players operation #state av_ctx = @e[tag=av.current,limit=1] av_state
scoreboard players operation #leader av_ctx = @e[tag=av.current,limit=1] av_leader
execute as @e[tag=av.current,limit=1] run function avalon:context
data modify storage avalon:ui dialog set value {"type":"minecraft:multi_action","title":{"text":"阿瓦隆 · 本轮操作","color":"gold"},"body":[],"actions":[],"columns":2,"exit_action":{"label":{"text":"返回游戏（Q重开）"}},"pause":false}
scoreboard players set #target av_ctx 0
scoreboard players operation #target av_ctx = @s av_target
function avalon:dialog/names
execute store result storage avalon:ui id int 1 run scoreboard players get @s av_id
execute store result storage avalon:ui leader int 1 run scoreboard players get #leader av_ctx
execute store result storage avalon:ui need int 1 run scoreboard players get @e[tag=av.current,limit=1] av_need
function avalon:dialog/public with storage avalon:ui
execute if score #state av_ctx matches 1 if score #viewer av_ctx = #leader av_ctx as @a[tag=av.audience] run function avalon:dialog/team_button
execute if score #state av_ctx matches 1 if score #viewer av_ctx = #leader av_ctx run function avalon:dialog/button {code:10,label:"选好队伍，开始投票／强制出征"}
execute if score #state av_ctx matches 1..3 if score #role av_ctx matches 5 run function avalon:dialog/button {code:40,label:"提前翻牌刺杀…"}
execute if score #state av_ctx matches 4 if score #role av_ctx matches 5 as @a[tag=av.audience,scores={av_role=1..3}] run function avalon:dialog/target_button
execute if score #state av_ctx matches 4 if score #role av_ctx matches 5 if score @s av_target matches 1..8 run function avalon:dialog/button {code:60,label:"确认刺杀所选玩家（结束游戏）"}
function avalon:dialog/button {code:99,label:"刷新／等待其他玩家"}
function avalon:player/private_info
scoreboard players set #show_ui av_ctx 0
execute if score #state av_ctx matches 1 if score #viewer av_ctx = #leader av_ctx run scoreboard players set #show_ui av_ctx 1
execute if score #state av_ctx matches 4 if score #role av_ctx matches 5 run scoreboard players set #show_ui av_ctx 1
execute if score #manual_ui av_ctx matches 1 run scoreboard players set #show_ui av_ctx 1
execute if score #show_ui av_ctx matches 1 run function avalon:dialog/show with storage avalon:ui
function avalon:player/ballots
