scoreboard players add @s dc_page_tick 1
execute unless score @s dc_page_tick matches 100.. run return 0
scoreboard players set @s dc_page_tick 0
scoreboard players add @s dc_page 1
execute if score @s dc_page >= @s dc_pages run scoreboard players set @s dc_page 0
function decrypto:title/render_all
