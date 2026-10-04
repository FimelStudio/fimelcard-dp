function wenfei:input/clear_category_menu
scoreboard players add @s wq_round 1
execute if score @s wq_round > @s wq_total run return run function wenfei:game/finish
function wenfei:player/mark_audience
execute as @a[tag=wq.audience] run function wenfei:title/release
scoreboard players operation #turn wq_ctx = @s wq_turn
scoreboard players set @a[tag=wq.audience] wq_guess 0
scoreboard players set @a[tag=wq.audience] wq_done 0
execute as @a[tag=wq.audience] if score @s wq_seat = #turn wq_ctx run scoreboard players set @s wq_guess 1
clear @a[tag=wq.audience] minecraft:writable_book[minecraft:custom_data~{wenfei:{tool:"answer"}}]
clear @a[tag=wq.audience] minecraft:written_book[minecraft:custom_data~{wenfei:{tool:"answer"}}]
clear @a[tag=wq.audience] minecraft:purple_dye[minecraft:custom_data~{wenfei:{tool:"answer_dialog"}}]
data modify entity @s data.wenfei.answers set value {}
data modify entity @s data.wenfei.placed set value []
data modify entity @s data.wenfei.used set value {}
scoreboard players set @s wq_gain 0
scoreboard players set @s wq_index 0
scoreboard players set @s wq_state 1
function wenfei:round/new_epoch
tellraw @a[tag=wq.audience] [{text:"[问非所答] 第 ",color:"gold"},{score:{name:"@s",objective:"wq_round"}},{text:" / "},{score:{name:"@s",objective:"wq_total"}},{text:" 轮，猜题者："},{selector:"@a[tag=wq.audience,scores={wq_guess=1},limit=1]"}]
function wenfei:log {text:"新回合：等待猜题者选择类别"}
function wenfei:hud/update
function wenfei:ui/open_all
