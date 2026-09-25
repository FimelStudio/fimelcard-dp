$execute if data entity @s data.wenfei.used.p$(points) run return run function wenfei:ui/open_all
$data modify entity @s data.wenfei.used.p$(points) set value 1b
$data modify storage wenfei:io placement.component set value {text:"$(points)分：",extra:[]}
data modify storage wenfei:io question set value {text:""}
data modify storage wenfei:io question.text set from entity @s data.wenfei.current.text
data modify storage wenfei:io placement.component.extra append from storage wenfei:io question
data modify storage wenfei:io placement.component.extra append value {text:"\n"}
data modify entity @s data.wenfei.placed append from storage wenfei:io placement.component
function wenfei:player/mark_audience
$tellraw @a[tag=wq.audience] [{text:"[问非所答] ",color:"gold"},{selector:"@a[tag=wq.audience,scores={wq_guess=1},limit=1]"},{text:" 将「"},{nbt:"question.text",storage:"wenfei:io"},{text:"」评为 $(points) 分。",color:"aqua"}]
execute store result score #id wq_ctx run data get entity @s data.wenfei.current.id
execute store result score #correct wq_ctx run data get entity @s data.wenfei.correct.id
$execute if score #id wq_ctx = #correct wq_ctx run scoreboard players set @s wq_gain $(points)
scoreboard players add @s wq_index 1
function wenfei:log {text:"猜题者锁定当前题目的分数位置"}
execute if score @s wq_index matches 5 run return run function wenfei:round/resolve
function wenfei:round/new_epoch
function wenfei:round/current
function wenfei:ui/open_all
