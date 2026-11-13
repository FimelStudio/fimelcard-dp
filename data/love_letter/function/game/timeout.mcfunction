function love_letter:system/context
execute if score @s ll_timeout matches 0 run tellraw @a[tag=ll.audience] {text:"[情书] 行动超时，自动完成当前回合。",color:"yellow"}
scoreboard players set @s ll_timeout 1
function love_letter:engine/auto
