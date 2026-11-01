execute as @a[tag=ct.player] if score @s ct_id = #table ll_ctx run tellraw @s {text:"[情书] 请先腾空快捷栏第1格与最后一格。",color:"yellow"}
return fail
