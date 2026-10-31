execute unless entity @s[tag=ct.player,tag=gm.player] run return 0
execute unless score @s ct_id = #ui_click_table gm_ctx run return 0
execute unless score @s gm_table = #ui_click_table gm_ctx run return 0
function gomoku:input/context
execute unless entity @s[tag=gm.actor] run return 0
execute unless entity @e[tag=gm.current,scores={gm_state=1},limit=1] run return 0
execute unless score @s gm_side = @e[tag=gm.current,limit=1] gm_turn run return 0
function gomoku:input/ray
execute if score #ray_ok gm_ctx matches 1 as @e[tag=gm.current,limit=1] at @s run function gomoku:game/click
