execute unless score @e[tag=dd.current,limit=1] dd_state matches 3 run return 0
execute unless score @s dd_seat = @e[tag=dd.current,limit=1] dd_turn run return run function doudizhu:action/not_turn
function doudizhu:rules/classify
execute if score #type dd_ctx matches 0 run tellraw @s {text:"所选牌不组成合法牌型，请重新选择。",color:"red"}
execute if score #type dd_ctx matches 0 run return 0
scoreboard players set #beats dd_ctx 0
execute if score @e[tag=dd.current,limit=1] dd_type matches 0 run scoreboard players set #beats dd_ctx 1
execute if score #type dd_ctx matches 14 run scoreboard players set #beats dd_ctx 1
execute if score #type dd_ctx matches 13 if score @e[tag=dd.current,limit=1] dd_type matches 1..12 run scoreboard players set #beats dd_ctx 1
execute if score #type dd_ctx = @e[tag=dd.current,limit=1] dd_type if score #n dd_ctx = @e[tag=dd.current,limit=1] dd_len if score #high dd_ctx > @e[tag=dd.current,limit=1] dd_high run scoreboard players set #beats dd_ctx 1
execute unless score #beats dd_ctx matches 1 run tellraw @s {text:"所选牌不能压过上一手。",color:"red"}
execute unless score #beats dd_ctx matches 1 run return 0
scoreboard players set #submitted dd_ctx 1
function doudizhu:visual/play
function doudizhu:hud/record_play
function doudizhu:hand/build_play
data modify entity @e[tag=dd.current,limit=1] data.doudizhu.last_play set from storage doudizhu:ui played
execute as @e[tag=dd.current,limit=1] run function doudizhu:player/audience
execute if score #type dd_ctx matches 13..14 as @a[tag=dd.audience] at @s run playsound minecraft:entity.generic.explode player @s ~ ~ ~ 0.7 1
tellraw @a[tag=dd.audience] [{selector:"@s",color:"yellow"},{text:" 出牌：",color:"gray"},{nbt:"played",storage:"doudizhu:ui",interpret:true}]
scoreboard players operation @e[tag=dd.current,limit=1] dd_type = #type dd_ctx
scoreboard players operation @e[tag=dd.current,limit=1] dd_high = #high dd_ctx
scoreboard players operation @e[tag=dd.current,limit=1] dd_len = #n dd_ctx
scoreboard players operation @e[tag=dd.current,limit=1] dd_last = @s dd_seat
scoreboard players set @e[tag=dd.current,limit=1] dd_passes 0
execute if score #type dd_ctx matches 13..14 run scoreboard players operation @e[tag=dd.current,limit=1] dd_mult += @e[tag=dd.current,limit=1] dd_mult
scoreboard players add @s dd_plays 1
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=1}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=2}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=3}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=4}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=5}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=6}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=7}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=8}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=9}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=10}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=11}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=12}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=13}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=14}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=15}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=16}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=17}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=18}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=19}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=20}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=21}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=22}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=23}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=24}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=25}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=26}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=27}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=28}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=29}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=30}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=31}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=32}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=33}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=34}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=35}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=36}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=37}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=38}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=39}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=40}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=41}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=42}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=43}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=44}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=45}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=46}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=47}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=48}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=49}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=50}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=51}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=52}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=53}] run function doudizhu:deck/collect
execute as @e[tag=dd.hand,scores={dd_selected=1,dd_card=54}] run function doudizhu:deck/collect
scoreboard players set @e[tag=dd.hand,scores={dd_selected=1}] dd_owner -1
scoreboard players set @e[tag=dd.hand] dd_selected 0
scoreboard players set #remaining dd_ctx 0
execute as @e[tag=dd.hand] if score @s dd_owner = #owner dd_ctx run scoreboard players add #remaining dd_ctx 1
# 包括从三张直接出到一张的情况，机器人同样触发。
# 本桌每局只提醒第一次，不受音乐开关影响。
execute unless score @e[tag=dd.current,limit=1] dd_counts matches 0 if score #remaining dd_ctx matches 1..2 unless entity @e[tag=dd.current,tag=dd.low_cards_announced,limit=1] run tellraw @a[tag=dd.audience] [{text:"[斗地主] 注意：",color:"gold"},{selector:"@s",color:"yellow"},{text:"仅剩 ",color:"gold"},{score:{name:"#remaining",objective:"dd_ctx"},color:"red",bold:true},{text:" 张牌！",color:"gold"}]
execute if score #remaining dd_ctx matches 1..2 run tag @e[tag=dd.current,limit=1] add dd.low_cards_announced
execute if score #remaining dd_ctx matches 1..2 run tag @e[tag=dd.current,limit=1] add dd.music_exciting
# 合法炸弹或王炸同样触发紧张音乐，保持到本局结束。
execute if score #type dd_ctx matches 13..14 run tag @e[tag=dd.current,limit=1] add dd.music_exciting
execute if score #remaining dd_ctx matches 0 run scoreboard players operation #winner dd_ctx = @s dd_seat
execute if score #remaining dd_ctx matches 0 as @e[tag=dd.current,limit=1] at @s run return run function doudizhu:game/finish
execute as @e[tag=dd.current,limit=1] run function doudizhu:music/table_tick
execute as @e[tag=dd.current,limit=1] run function doudizhu:round/advance
tag @a[tag=dd.audience] remove dd.audience
tag @e[tag=dd.actors] remove dd.actors
