# UI 的玩家入口也可调用。保留 un.actor、un.current、un.selected。
execute unless entity @s[type=minecraft:player,tag=un.player,tag=ct.player] run return 0
execute unless score @s ct_id = @s un_table run return 0
scoreboard players operation #hud_table un_ctx = @s un_table
execute unless entity @e[type=minecraft:marker,tag=un.current,scores={ct_game=11,un_state=1..5},limit=1] run return 0
execute unless score @e[tag=un.current,limit=1] ct_id = #hud_table un_ctx run return 0
function uno:hud/build
