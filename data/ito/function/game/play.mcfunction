execute unless score @s it_state matches 2 run return 0
scoreboard players set #missing it_ctx 0
execute as @e[tag=it.cards,scores={it_owner=1..8,it_used=0},nbt={data:{description:""}}] run scoreboard players add #missing it_ctx 1
execute if score #missing it_ctx matches 1.. run tellraw @a[tag=it.actor] {text:"请先让所有人描述每张手牌，再讨论出牌顺序。",color:"yellow"}
execute if score #missing it_ctx matches 1.. run return 0
tag @e[tag=it.selected] remove it.selected
execute as @e[tag=it.cards,scores={it_used=0}] if score @s it_owner = #actor it_ctx if score @s it_slot = #slot it_ctx run tag @s add it.selected
execute unless entity @e[tag=it.selected,limit=1] run return 0
scoreboard players operation #played it_ctx = @e[tag=it.selected,limit=1] it_number
scoreboard players set #penalty it_ctx 0
execute as @e[tag=it.cards,scores={it_owner=1..8,it_used=0}] if score @s it_number < #played it_ctx run function ito:game/skip
scoreboard players operation @s it_life -= #penalty it_ctx
execute if score @s it_life matches ..0 run scoreboard players set @s it_life 0
execute as @e[tag=it.selected,limit=1] run function ito:game/reveal
execute if score #penalty it_ctx matches 1.. run tellraw @a[tag=it.audience] [{text:"[命悬一线] 等一下！跳过 ",color:"red"},{score:{name:"#penalty",objective:"it_ctx"}},{text:" 张更小的牌，扣除同等生命。"}]
execute as @a[tag=it.audience] run function ito:input/clear_spent_books
scoreboard players set #remaining it_ctx 0
execute as @e[tag=it.cards,scores={it_owner=1..8,it_used=0}] run scoreboard players add #remaining it_ctx 1
execute if score @s it_life matches 0 run return run function ito:game/lose
execute if score #remaining it_ctx matches 0 if score @s it_round matches 3 run return run function ito:game/win
execute if score #remaining it_ctx matches 0 run function ito:round/clear
function ito:visual/refresh
function ito:hud/refresh
