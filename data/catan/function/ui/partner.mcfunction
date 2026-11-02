# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$execute unless score @s ca_side = @e[tag=ca.current,limit=1] ca_turn unless score @e[tag=ca.current,limit=1] ca_turn matches $(side) run return 0
$function catan:ui/named_button {side:$(side),code:$(code)}
