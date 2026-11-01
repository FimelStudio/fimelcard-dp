execute unless score @s it_input matches 0..1 run scoreboard players set @s it_input 0
function ito:system/context
function ito:game/epoch
scoreboard players set @s it_state 1
execute as @e[tag=it.cards] run kill @s
execute as @e[tag=it.visual] if score @s ct_id = #table it_ctx run kill @s
execute as @a[tag=it.audience] run clear @s *[minecraft:custom_data~{ito:{tool:1b}}]
execute as @a[tag=it.audience] run scoreboard players set @s it_vote 0
execute as @a[tag=it.audience] run dialog clear @s
data modify entity @s data.ito.history set value []
scoreboard players set #build it_ctx 1
function ito:deck/create
function ito:system/context
execute as @a[tag=it.audience] run function ito:deal/player
execute if score @s it_round matches 3 run function ito:round/reference
function ito:themes/draw
function ito:system/context
execute as @a[tag=it.audience] run function ito:input/give
tellraw @a[tag=it.audience] {text:"[命悬一线] 按Q使用紫色染料查看手牌和出牌；输入方式以游戏设置为准。",color:"yellow"}
function ito:visual/refresh
function ito:hud/refresh
