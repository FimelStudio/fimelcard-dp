execute unless entity @e[tag=sp.current,scores={sp_state=1},limit=1] run return 0
execute if score @s sp_target matches 5 run return run tellraw @s {text:"黄金只能通过预约开发卡获得",color:"yellow"}
execute unless score @s sp_seen = @e[tag=sp.current,limit=1] sp_epoch run function splendor:direct/reset
execute unless score @s sp_panel matches 1 run function splendor:direct/reset
scoreboard players set #total_pick sp_ctx 0
scoreboard players set #available_pick sp_ctx 0
scoreboard players set #double_pick sp_ctx 0
execute store result score #stock0 sp_ctx run data get entity @e[tag=sp.current,limit=1] data.splendor.bank[0]
execute if score #stock0 sp_ctx matches 1.. run scoreboard players add #available_pick sp_ctx 1
execute if score @s sp_target matches 0 if score #stock0 sp_ctx matches 1.. run scoreboard players add @s sp_pick0 1
execute if score @s sp_pick0 matches 2 unless score #stock0 sp_ctx matches 4.. run scoreboard players set @s sp_pick0 0
execute if score @s sp_pick0 matches 3.. run scoreboard players set @s sp_pick0 0
scoreboard players operation #total_pick sp_ctx += @s sp_pick0
execute if score @s sp_pick0 matches 2 run scoreboard players add #double_pick sp_ctx 1
execute store result score #stock1 sp_ctx run data get entity @e[tag=sp.current,limit=1] data.splendor.bank[1]
execute if score #stock1 sp_ctx matches 1.. run scoreboard players add #available_pick sp_ctx 1
execute if score @s sp_target matches 1 if score #stock1 sp_ctx matches 1.. run scoreboard players add @s sp_pick1 1
execute if score @s sp_pick1 matches 2 unless score #stock1 sp_ctx matches 4.. run scoreboard players set @s sp_pick1 0
execute if score @s sp_pick1 matches 3.. run scoreboard players set @s sp_pick1 0
scoreboard players operation #total_pick sp_ctx += @s sp_pick1
execute if score @s sp_pick1 matches 2 run scoreboard players add #double_pick sp_ctx 1
execute store result score #stock2 sp_ctx run data get entity @e[tag=sp.current,limit=1] data.splendor.bank[2]
execute if score #stock2 sp_ctx matches 1.. run scoreboard players add #available_pick sp_ctx 1
execute if score @s sp_target matches 2 if score #stock2 sp_ctx matches 1.. run scoreboard players add @s sp_pick2 1
execute if score @s sp_pick2 matches 2 unless score #stock2 sp_ctx matches 4.. run scoreboard players set @s sp_pick2 0
execute if score @s sp_pick2 matches 3.. run scoreboard players set @s sp_pick2 0
scoreboard players operation #total_pick sp_ctx += @s sp_pick2
execute if score @s sp_pick2 matches 2 run scoreboard players add #double_pick sp_ctx 1
execute store result score #stock3 sp_ctx run data get entity @e[tag=sp.current,limit=1] data.splendor.bank[3]
execute if score #stock3 sp_ctx matches 1.. run scoreboard players add #available_pick sp_ctx 1
execute if score @s sp_target matches 3 if score #stock3 sp_ctx matches 1.. run scoreboard players add @s sp_pick3 1
execute if score @s sp_pick3 matches 2 unless score #stock3 sp_ctx matches 4.. run scoreboard players set @s sp_pick3 0
execute if score @s sp_pick3 matches 3.. run scoreboard players set @s sp_pick3 0
scoreboard players operation #total_pick sp_ctx += @s sp_pick3
execute if score @s sp_pick3 matches 2 run scoreboard players add #double_pick sp_ctx 1
execute store result score #stock4 sp_ctx run data get entity @e[tag=sp.current,limit=1] data.splendor.bank[4]
execute if score #stock4 sp_ctx matches 1.. run scoreboard players add #available_pick sp_ctx 1
execute if score @s sp_target matches 4 if score #stock4 sp_ctx matches 1.. run scoreboard players add @s sp_pick4 1
execute if score @s sp_pick4 matches 2 unless score #stock4 sp_ctx matches 4.. run scoreboard players set @s sp_pick4 0
execute if score @s sp_pick4 matches 3.. run scoreboard players set @s sp_pick4 0
scoreboard players operation #total_pick sp_ctx += @s sp_pick4
execute if score @s sp_pick4 matches 2 run scoreboard players add #double_pick sp_ctx 1
execute if score #available_pick sp_ctx matches 4.. run scoreboard players set #available_pick sp_ctx 3
execute if score #double_pick sp_ctx matches 1 if score #total_pick sp_ctx matches 2 run return run function splendor:ui/submit_take
execute if score #double_pick sp_ctx matches 0 if score #total_pick sp_ctx = #available_pick sp_ctx if score #total_pick sp_ctx matches 1.. run return run function splendor:ui/submit_take
execute if score #double_pick sp_ctx matches 1.. run function splendor:direct/reset
tellraw @s [{text:"已选：白",color:"white"},{score:{name:"@s",objective:"sp_pick0"}},{text:" 蓝"},{score:{name:"@s",objective:"sp_pick1"}},{text:" 绿"},{score:{name:"@s",objective:"sp_pick2"}},{text:" 红"},{score:{name:"@s",objective:"sp_pick3"}},{text:" 黑"},{score:{name:"@s",objective:"sp_pick4"}},{text:"；选三色或同色两颗，再点可取消。"}]
