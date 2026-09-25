# 只能在全部答案公开后的评分阶段编译面板。
execute unless score @s wq_state matches 3 run return 0
data modify entity @s data.wenfei.answer_lines set value {}
function wenfei:title/compile {seat:1}
function wenfei:title/compile {seat:2}
function wenfei:title/compile {seat:3}
function wenfei:title/compile {seat:4}
scoreboard players set @s wq_page 0
scoreboard players set @s wq_ptick 0
function wenfei:title/render
