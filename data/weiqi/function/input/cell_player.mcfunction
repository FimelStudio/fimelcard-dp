execute unless entity @s[tag=ct.player,tag=go.player] run return 0
execute unless score @s ct_id = #ui_click_table go_ctx run return 0
execute unless score @s go_table = #ui_click_table go_ctx run return 0
function weiqi:input/context
execute unless entity @s[tag=go.actor] run return 0
execute unless entity @e[tag=go.current,scores={go_state=1},limit=1] unless entity @e[tag=go.current,scores={go_state=3},limit=1] run return 0
execute if entity @e[tag=go.current,scores={go_state=1},limit=1] unless score @s go_side = @e[tag=go.current,limit=1] go_turn run return 0
function weiqi:input/ray
execute unless score #ray_ok go_ctx matches 1 run return 0
execute if entity @e[tag=go.current,scores={go_state=1},limit=1] as @e[tag=go.current,limit=1] at @s run function weiqi:game/click
execute if entity @e[tag=go.current,scores={go_state=3},limit=1] as @e[tag=go.current,limit=1] at @s run function weiqi:game/toggle_dead
