function wenfei:player/mark_audience
scoreboard players set #pending wq_ctx 0
execute as @a[tag=wq.audience,scores={wq_guess=0,wq_done=0}] run scoreboard players add #pending wq_ctx 1
execute if score #pending wq_ctx matches 1.. run tag @a[tag=wq.audience] remove wq.audience
execute if score #pending wq_ctx matches 1.. run return 0
scoreboard players set @s wq_state 3
function wenfei:round/new_epoch
# 保存当前控制器，逐人公开答案。展示内容不读取正确题。
data modify storage wenfei:io answers set from entity @s data.wenfei.answers
tellraw @a[tag=wq.audience] {text:"══ 大家的答案 ══",color:"gold"}
execute as @a[tag=wq.audience,scores={wq_guess=0}] run function wenfei:round/publish_answer
function wenfei:title/prepare
function wenfei:round/current
function wenfei:log {text:"全部答案已提交：逐张分配分数"}
function wenfei:hud/update
function wenfei:ui/open_all
