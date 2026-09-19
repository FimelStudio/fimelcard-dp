# 仅绘制当前页，不修改原始记录。
data modify storage decrypto:page lines set from entity @s data.decrypto.note_lines
scoreboard players operation #page dc_ctx = @s dc_page
function decrypto:hud/load_keywords
scoreboard players operation #ctx dc_ctx = @s dc_id
tag @e[tag=dc.title_controller] remove dc.title_controller
tag @s add dc.title_controller
execute as @a[tag=dc.player] if score @s dc_id = #ctx dc_ctx run function decrypto:title/build_player
tag @s remove dc.title_controller
