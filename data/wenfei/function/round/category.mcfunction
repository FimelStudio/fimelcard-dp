scoreboard players operation @s wq_cat = #choice wq_ctx
execute store result storage wenfei:io draw.category int 1 run scoreboard players remove #choice wq_ctx 1
function wenfei:deck/select with storage wenfei:io draw
scoreboard players set @s wq_state 2
function wenfei:input/clear_category_menu
function wenfei:round/new_epoch
function wenfei:player/mark_audience
tellraw @a[tag=wq.audience] {text:"[问非所答] 类别已选定。其他玩家秘密看题，按本桌设置用书或对话框提交答案；全部提交后才公开。",color:"yellow"}
execute as @a[tag=wq.audience,scores={wq_guess=0}] run function wenfei:input/give_answer
function wenfei:log {text:"抽取五题完成：开始秘密回答"}
function wenfei:hud/update
function wenfei:ui/open_all
