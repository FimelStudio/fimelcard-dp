scoreboard players operation #table gd_ctx = @s ct_id
execute as @a[tag=ct.player] if score @s ct_id = #table gd_ctx run tellraw @s {text:"[掼蛋] 需要恰好4名玩家。",color:"yellow"}
return fail
