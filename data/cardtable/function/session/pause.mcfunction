scoreboard players set @s ct_wait 0
execute as @a[tag=ct.player] if score @s ct_id = #session_table ct_ctx run dialog clear @s
execute as @a[tag=ct.player] if score @s ct_id = #session_table ct_ctx run tellraw @s {text:"[牌桌] 有玩家离线，对局已暂停；全部玩家回来后继续，也可投票结束游戏。",color:"yellow"}
