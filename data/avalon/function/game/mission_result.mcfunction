scoreboard players set #fail av_ctx 0
execute as @a[tag=av.audience,scores={av_selected=1,av_mission=2}] run scoreboard players add #fail av_ctx 1
scoreboard players operation #success av_ctx = @s av_need
scoreboard players operation #success av_ctx -= #fail av_ctx
scoreboard players set #threshold av_ctx 1
execute if score @s av_players matches 7.. if score @s av_round matches 4 run scoreboard players set #threshold av_ctx 2
tellraw @a[tag=av.audience] [{text:"任务结果：成功 ",color:"gold"},{score:{name:"#success",objective:"av_ctx"}},{text:" 票，失败 "},{score:{name:"#fail",objective:"av_ctx"}},{text:" 票。"}]
execute if score #fail av_ctx >= #threshold av_ctx run scoreboard players add @s av_evil 1
execute if score #fail av_ctx < #threshold av_ctx run scoreboard players add @s av_good 1
execute if score #fail av_ctx >= #threshold av_ctx run data modify entity @s data.avalon.results append value {text:"✗ ",color:"red"}
execute if score #fail av_ctx < #threshold av_ctx run data modify entity @s data.avalon.results append value {text:"✓ ",color:"green"}
execute at @s run function avalon:map/render
execute if score @s av_evil matches 3.. run return run function avalon:game/evil_win
execute if score @s av_good matches 3.. run return run function avalon:game/assassination
scoreboard players add @s av_round 1
function avalon:game/next_leader
function avalon:game/team
