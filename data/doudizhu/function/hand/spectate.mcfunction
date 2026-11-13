# 临时绑定地主牌，仅生成 HUD 的手牌文本。
tag @e[tag=dd.hand] remove dd.hand
execute as @e[type=minecraft:marker,tag=dd.card] if score @s dd_id = #hud_table dd_ctx if score @s dd_owner = #hud_pov dd_ctx run tag @s add dd.hand
function doudizhu:hand/build
tag @e[tag=dd.hand] remove dd.hand
data modify storage doudizhu:ui buttons set value []
