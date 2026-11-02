# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set @s sp_panel 3
function splendor:ui/begin
function splendor:ui/read_target
execute unless score #card sp_ctx matches 0..89 run return run function splendor:ui/market
function splendor:ui/card_icon {id:0}
function splendor:ui/card_picture with storage splendor:ui
function splendor:ui/autopay
function splendor:ui/editor_show
