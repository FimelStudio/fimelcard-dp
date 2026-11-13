scoreboard players operation #announce_leader av_ctx = @s av_leader
execute if score @s av_state matches 1 as @a[tag=av.audience] if score @s av_seat = #announce_leader av_ctx run tellraw @a[tag=av.audience] [{text:"[阿瓦隆] 队长 ",color:"gold"},{selector:"@s"},{text:" 请选择出征队员并提交队伍。",color:"yellow"}]
execute if score @s av_state matches 2 run tellraw @a[tag=av.audience] {text:"[阿瓦隆] 队伍已提交，请所有玩家投赞成或反对票。",color:"yellow"}
execute if score @s av_state matches 3 run tellraw @a[tag=av.audience] [{text:"[阿瓦隆] 请出征队员执行任务：",color:"yellow"},{selector:"@a[tag=av.audience,scores={av_selected=1}]"}]
execute if score @s av_state matches 4 run tellraw @a[tag=av.audience] {text:"[阿瓦隆] 进入刺杀阶段，请刺客选择目标。",color:"red"}
