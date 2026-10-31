execute unless entity @s[tag=ct.player,tag=xq.player] run return 0
execute unless score @s ct_id = #ui_click_table xq_ctx run return 0
execute unless score @s xq_table = #ui_click_table xq_ctx run return 0
function xiangqi:input/context
execute unless entity @s[tag=xq.actor] run return 0
execute unless entity @e[tag=xq.current,scores={xq_state=1},limit=1] run return 0
execute as @e[tag=xq.current,limit=1] at @s run function xiangqi:game/click
