execute unless entity @s[type=minecraft:player,tag=ll.player,tag=ct.player] run return 0
execute unless score @s ct_id = @s ll_table run return 0
execute unless entity @e[tag=ll.current,scores={ct_game=17,ll_state=1..4},limit=1] run return 0
scoreboard players operation #hud_table ll_ctx = @s ll_table
execute unless score @e[tag=ll.current,limit=1] ct_id = #hud_table ll_ctx run return 0
function love_letter:hud/build
