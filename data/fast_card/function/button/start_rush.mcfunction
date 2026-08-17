# 锁定胜利者和牌型，之后停止传牌
scoreboard players set @s fc_state 3
scoreboard players operation @s fc_mode = #hand fc_ctx
scoreboard players set @s fc_press 1
scoreboard players operation #ctx_id fc_ctx = @s fc_id

execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run tag @s remove fc.pressed
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run scoreboard players set @s fc_order 0
tag @a[tag=fc.clicker,limit=1] add fc.pressed
scoreboard players set @a[tag=fc.clicker,limit=1] fc_order 1

# 普通牌型加1分，三张加小丑牌加2分，四张加小丑牌的超级牌型加3分
execute if score #hand fc_ctx matches 1 run function fast_card:log {text:"有效抢按：四张同点数牌，进入普通抢按阶段"}
execute if score #hand fc_ctx matches 2 run function fast_card:log {text:"有效抢按：三张同点数牌加小丑牌，进入特殊抢按阶段"}
execute if score #hand fc_ctx matches 3 run function fast_card:log {text:"有效抢按：四张同点数牌加小丑牌，进入超级抢按阶段"}
execute if score #hand fc_ctx matches 1 run scoreboard players add @a[tag=fc.clicker,limit=1] fc_score 1
execute if score #hand fc_ctx matches 2 run scoreboard players add @a[tag=fc.clicker,limit=1] fc_score 2
execute if score #hand fc_ctx matches 3 run scoreboard players add @a[tag=fc.clicker,limit=1] fc_score 3

# 向本桌玩家播放对应提示并开始抢按
execute if score #hand fc_ctx matches 1 as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx at @s run playsound minecraft:block.note_block.bell master @s ~ ~ ~ 1.2 1.6
execute if score #hand fc_ctx matches 2 as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx at @s run playsound minecraft:entity.wither.spawn master @s ~ ~ ~ 0.8 1.25
execute if score #hand fc_ctx matches 3 as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx at @s run playsound minecraft:entity.wither.spawn master @s ~ ~ ~ 1.4 0.85
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run title @s title {text:'快按按钮！',color:'red',bold:true}
execute if score #hand fc_ctx matches 1 as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run tellraw @s [{text:'[Fast Card] ',color:'gold'},{selector:'@a[tag=fc.clicker,limit=1]',color:'yellow'},{text:' 凑齐了四张同点数牌！',color:'green'}]
execute if score #hand fc_ctx matches 2 as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run tellraw @s [{text:'[Fast Card] ',color:'gold'},{selector:'@a[tag=fc.clicker,limit=1]',color:'light_purple'},{text:' 凑齐了三张同点数牌和小丑牌！',color:'light_purple',bold:true}]
execute if score #hand fc_ctx matches 3 as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run tellraw @s [{text:'[Fast Card] ',color:'gold'},{selector:'@a[tag=fc.clicker,limit=1]',color:'yellow',bold:true},{text:' 凑齐了四张同点数牌和小丑牌——超级牌型！',color:'gold',bold:true}]
