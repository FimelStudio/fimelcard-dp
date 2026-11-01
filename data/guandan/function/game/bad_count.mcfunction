scoreboard players operation #table gd_ctx = @s ct_id
execute as @a[tag=ct.player] if score @s ct_id = #table gd_ctx run tellraw @s {text:"[掼蛋] 需要1～4名真人，不足4人自动补测试人机。",color:"yellow"}
return fail
