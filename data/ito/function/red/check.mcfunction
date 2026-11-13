# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute unless score @s ct_state matches 1 run return 0
execute unless score @s it_state matches 2 run return 0
execute unless score @s it_mode matches 1 run return 0
function ito:system/context
execute as @a[tag=it.audience] run function ito:input/clear_spent_books
function ito:hud/refresh
execute if entity @a[tag=it.audience,scores={it_done=0}] run return 0
execute as @a[tag=it.audience,scores={it_sum=1..99}] run function ito:red/score
execute as @a[tag=it.audience] run tellraw @a[tag=it.audience] [{selector:"@s"},{text:"：累计 "},{score:{name:"@s",objective:"it_total"}},{text:" 分"}]
scoreboard players set #aboard it_ctx 0
execute as @a[tag=it.audience,scores={it_total=5..}] run scoreboard players add #aboard it_ctx 1
execute if score #aboard it_ctx matches 1 run tellraw @a[tag=it.audience] [{text:"目前一人已登船：",color:"gold"},{selector:"@a[tag=it.audience,scores={it_total=5..}]"},{text:"；继续下一轮，合计100仍可直接夺胜。"}]
execute if score #aboard it_ctx matches 2.. run return run function ito:red/win
scoreboard players set @s it_state 3
scoreboard players set @s it_timer 100
tellraw @a[tag=it.audience] {text:"红线本轮结算完成，5秒后进入下一轮。",color:"gold"}
