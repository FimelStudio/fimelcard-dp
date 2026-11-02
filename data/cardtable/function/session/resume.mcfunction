scoreboard players set @s ct_wait 0
execute as @a[tag=ct.player] if score @s ct_id = #session_table ct_ctx run title @s actionbar {text:""}
execute as @a[tag=ct.player] if score @s ct_id = #session_table ct_ctx run tellraw @s {text:"[牌桌] 玩家已全部返回，对局继续。",color:"green"}
function cardtable:session/refresh_ui
