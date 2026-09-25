# 不重发提示册、不重抽词条/密码、不清空电报或已输入的数字。
execute unless score @s dc_state matches 1..8 run return 0
function decrypto:title/render_all
scoreboard players operation #ctx dc_ctx = @s dc_id
scoreboard players operation #resume_state dc_ctx = @s dc_state
scoreboard players operation #resume_mode dc_ctx = @s dc_mode
execute as @a[tag=dc.player] if score @s dc_id = #ctx dc_ctx run function decrypto:game/resume_player
