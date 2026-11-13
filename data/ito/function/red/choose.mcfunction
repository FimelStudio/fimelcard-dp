# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function ito:red/validate
execute unless score #red_valid it_ctx matches 1 run return 0
execute unless score @s it_win_epoch = @e[tag=it.current,limit=1] it_epoch run return 0
execute unless score #choice it_ctx matches 31..38 unless score #choice it_ctx matches 40 run return 0
execute unless score @e[tag=it.current,limit=1] it_state matches 2 run return 0
execute if score @s it_done matches 1 run return 0
execute if score #choice it_ctx matches 40 run return run function ito:red/solo
scoreboard players operation #target it_ctx = #choice it_ctx
scoreboard players remove #target it_ctx 30
execute if score #target it_ctx = @s it_seat run return 0
tag @a[tag=it.partner] remove it.partner
execute as @a[tag=it.audience,scores={it_done=0}] if score @s it_seat = #target it_ctx run tag @s add it.partner
execute unless entity @a[tag=it.partner,limit=1] run return 0
scoreboard players operation @s it_offer = #target it_ctx
tellraw @a[tag=it.partner] [{selector:"@s"},{text:" 邀请你配对。按Q使用数字牌，选择对方即可确认。",color:"yellow"}]
tellraw @s {text:"邀请已记录；对方选择你后才会配对亮牌。",color:"green"}
execute unless score @a[tag=it.partner,limit=1] it_offer = @s it_seat run return 0
scoreboard players set @s it_sum 0
scoreboard players set #sum it_ctx 0
execute as @e[tag=it.cards,scores={it_used=0}] if score @s it_owner = #actor it_ctx run scoreboard players operation #sum it_ctx += @s it_number
execute as @e[tag=it.cards,scores={it_used=0}] if score @s it_owner = #target it_ctx run scoreboard players operation #sum it_ctx += @s it_number
tellraw @a[tag=it.audience] [{selector:"@s"},{text:" 与 "},{selector:"@a[tag=it.partner]"},{text:" 配对亮牌，合计 "},{score:{name:"#sum",objective:"it_ctx"}},{text:"。",color:"gold"}]
scoreboard players operation @s it_sum = #sum it_ctx
scoreboard players operation @a[tag=it.partner,limit=1] it_sum = #sum it_ctx
scoreboard players set @s it_done 1
scoreboard players set @a[tag=it.partner] it_done 1
execute as @e[tag=it.cards,scores={it_used=0}] if score @s it_owner = #actor it_ctx run function ito:game/reveal
execute as @e[tag=it.cards,scores={it_used=0}] if score @s it_owner = #target it_ctx run function ito:game/reveal
execute if score #sum it_ctx matches 100 run tellraw @a[tag=it.audience] [{text:"合计100，搭档立即获胜：",color:"gold"},{selector:"@s"},{text:" 与 "},{selector:"@a[tag=it.partner]"}]
execute if score #sum it_ctx matches 100 run function cardtable:game/result/title {audience:"@a[tag=it.audience]",title:{text:"最终胜利者",color:"gold",bold:true},subtitle:[{selector:"@s"},{text:"、"},{selector:"@a[tag=it.partner]"}]}
execute if score #sum it_ctx matches 100 as @e[tag=it.current,limit=1] at @s run return run function ito:game/finish
execute as @e[tag=it.current,limit=1] at @s run function ito:red/check
