# 八座和四座均按本局开始时人数检测离线，避免轮到离线玩家时卡住。
execute unless data entity @s data.bullshit.players run execute store result entity @s data.bullshit.players int 1 run scoreboard players get @s ct_joined
execute store result score #expected bw_ctx run data get entity @s data.bullshit.players
function bullshit:player/mark_audience
scoreboard players set #online bw_ctx 0
execute as @a[tag=bw.audience,tag=ct.player] if score @s ct_id = #ctx bw_ctx run scoreboard players add #online bw_ctx 1
execute unless score #online bw_ctx = #expected bw_ctx run tellraw @a[tag=bw.audience] {text:"[瞎掰王] 有玩家退出或离线，本局结束并返回大厅。",color:"yellow"}
tag @a[tag=bw.audience] remove bw.audience
execute unless score #online bw_ctx = #expected bw_ctx run function bullshit:game/abort
