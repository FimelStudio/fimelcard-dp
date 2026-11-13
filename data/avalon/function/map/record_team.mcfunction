# 结算前按座位记录实际投过任务票的出征者，只保存头像。
data modify storage avalon:map portraits set value []
execute as @a[tag=av.audience,scores={av_selected=1,av_mission=1..2,av_seat=1}] run function avalon:map/record_portrait
execute as @a[tag=av.audience,scores={av_selected=1,av_mission=1..2,av_seat=2}] run function avalon:map/record_portrait
execute as @a[tag=av.audience,scores={av_selected=1,av_mission=1..2,av_seat=3}] run function avalon:map/record_portrait
execute as @a[tag=av.audience,scores={av_selected=1,av_mission=1..2,av_seat=4}] run function avalon:map/record_portrait
execute as @a[tag=av.audience,scores={av_selected=1,av_mission=1..2,av_seat=5}] run function avalon:map/record_portrait
execute as @a[tag=av.audience,scores={av_selected=1,av_mission=1..2,av_seat=6}] run function avalon:map/record_portrait
execute as @a[tag=av.audience,scores={av_selected=1,av_mission=1..2,av_seat=7}] run function avalon:map/record_portrait
execute as @a[tag=av.audience,scores={av_selected=1,av_mission=1..2,av_seat=8}] run function avalon:map/record_portrait
execute unless data entity @s data.avalon.mission_teams run data modify entity @s data.avalon.mission_teams set value {}
execute store result storage avalon:map round int 1 run scoreboard players get @s av_round
function avalon:map/save_portraits with storage avalon:map
