execute unless entity @s[tag=ct.player,tag=ch.player] run return 0
execute unless score @s ct_id = #ui_click_table ch_ctx run return 0
execute unless score @s ch_table = #ui_click_table ch_ctx run return 0
function chess:input/context
execute unless entity @s[tag=ch.actor] run return 0
execute unless entity @e[tag=ch.current,scores={ch_state=1},limit=1] run return 0
execute as @e[tag=ch.current,limit=1] at @s run function chess:game/click
