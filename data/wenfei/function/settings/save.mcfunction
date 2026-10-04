scoreboard players operation #setting wq_ctx = @s wq_settings
scoreboard players set @s wq_settings 0
# duo、multi、input、7 拼接；拒绝旧版窗口只提交猜题次数。
execute unless score #setting wq_ctx matches 1107..6617 run return 0
scoreboard players operation #input wq_ctx = #setting wq_ctx
scoreboard players operation #input wq_ctx %= #ten wq_ctx
execute unless score #input wq_ctx matches 7 run return 0
scoreboard players operation #setting wq_ctx /= #ten wq_ctx
scoreboard players operation #input wq_ctx = #setting wq_ctx
scoreboard players operation #input wq_ctx %= #ten wq_ctx
execute unless score #input wq_ctx matches 0..1 run return 0
scoreboard players operation #setting wq_ctx /= #ten wq_ctx
execute unless entity @s[tag=ct.player] run return 0
execute unless score @s ct_id = @s wq_settable run return 0
scoreboard players operation #duo wq_ctx = #setting wq_ctx
scoreboard players operation #duo wq_ctx /= #ten wq_ctx
scoreboard players operation #multi wq_ctx = #setting wq_ctx
scoreboard players operation #multi wq_ctx %= #ten wq_ctx
execute unless score #duo wq_ctx matches 1..6 run return 0
execute unless score #multi wq_ctx matches 1..6 run return 0
scoreboard players operation #ctx wq_ctx = @s wq_settable
scoreboard players set #saved wq_ctx 0
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_state=0,ct_game=8}] if score @s ct_id = #ctx wq_ctx run function wenfei:settings/apply
execute if score #saved wq_ctx matches 1 run tellraw @s {text:"[问非所答] 本桌猜题次数和答案输入方式已保存。",color:"green"}
execute unless score #saved wq_ctx matches 1 run tellraw @s {text:"[问非所答] 原牌桌已开始或切换游戏，未保存。",color:"red"}
