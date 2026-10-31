scoreboard players add @s av_clock 1
execute unless score @s av_clock matches 10.. run return 0
scoreboard players set @s av_clock 0
function avalon:context
scoreboard players set #online av_ctx 0
execute as @a[tag=av.audience] run scoreboard players add #online av_ctx 1
execute unless score #online av_ctx = @s av_players run tellraw @a[tag=av.audience] {text:"有玩家离线或离开牌桌，阿瓦隆已结束。",color:"yellow"}
execute unless score #online av_ctx = @s av_players run return run function avalon:game/abort
execute as @a[tag=av.audience] run function avalon:player/identity
