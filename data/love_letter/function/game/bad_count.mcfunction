scoreboard players operation #table ll_ctx = @s ct_id
execute as @a[tag=ct.player] if score @s ct_id = #table ll_ctx run tellraw @s {text:"[情书] 需要2～6人；四人桌最多4人。",color:"yellow"}
function love_letter:log {text:"拒绝开局：人数或桌型不符合情书要求"}
return fail
