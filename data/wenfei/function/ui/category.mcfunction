# 仅选择类别阶段、仅当前猜题者打开对话框并领取重开工具。
execute unless score @s wq_state matches 1 run return 0
execute unless entity @a[tag=wq.actor,scores={wq_guess=1}] run return 0
data modify storage wenfei:ui dialog set value {type:"minecraft:multi_action",title:{text:"问非所答·选择类别",color:"gold"},body:[{type:"minecraft:plain_message",width:450,contents:{text:"选择本轮问题类别。关闭后可手持紫色染料按Q重新打开。"}}],actions:[],columns:2,exit_action:{label:{text:"暂时关闭"}},pause:false}
data modify storage wenfei:ui button.label set value "玩家"
scoreboard players operation #value wq_ctx = #base wq_ctx
execute store result storage wenfei:ui button.value int 1 run scoreboard players add #value wq_ctx 1
function wenfei:ui/category_button with storage wenfei:ui button
data modify storage wenfei:ui button.label set value "数字"
scoreboard players operation #value wq_ctx = #base wq_ctx
execute store result storage wenfei:ui button.value int 1 run scoreboard players add #value wq_ctx 2
function wenfei:ui/category_button with storage wenfei:ui button
data modify storage wenfei:ui button.label set value "动物"
scoreboard players operation #value wq_ctx = #base wq_ctx
execute store result storage wenfei:ui button.value int 1 run scoreboard players add #value wq_ctx 3
function wenfei:ui/category_button with storage wenfei:ui button
data modify storage wenfei:ui button.label set value "食物"
scoreboard players operation #value wq_ctx = #base wq_ctx
execute store result storage wenfei:ui button.value int 1 run scoreboard players add #value wq_ctx 4
function wenfei:ui/category_button with storage wenfei:ui button
data modify storage wenfei:ui button.label set value "物品"
scoreboard players operation #value wq_ctx = #base wq_ctx
execute store result storage wenfei:ui button.value int 1 run scoreboard players add #value wq_ctx 5
function wenfei:ui/category_button with storage wenfei:ui button
data modify storage wenfei:ui button.label set value "名人"
scoreboard players operation #value wq_ctx = #base wq_ctx
execute store result storage wenfei:ui button.value int 1 run scoreboard players add #value wq_ctx 6
function wenfei:ui/category_button with storage wenfei:ui button

execute store result storage wenfei:io menu.table int 1 run scoreboard players get @s wq_id
execute store result storage wenfei:io menu.epoch int 1 run scoreboard players get @s wq_epoch
clear @a[tag=wq.actor,limit=1] *[minecraft:custom_data~{wenfei:{tool:"menu"}}]
execute as @a[tag=wq.actor,limit=1] run function wenfei:input/give_category_menu with storage wenfei:io menu
execute as @a[tag=wq.actor,limit=1] run function wenfei:ui/show with storage wenfei:ui
