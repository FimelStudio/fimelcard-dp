execute as @a[tag=ct.player] if score @s ct_id = #table ll_ctx run tellraw @s {text:"[情书] 头颅精准选择需要使用快捷栏，请先腾空全部9格。",color:"yellow"}
return fail
