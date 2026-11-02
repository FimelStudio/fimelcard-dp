$execute unless score @s ca_side = @e[tag=ca.current,limit=1] ca_turn unless score @e[tag=ca.current,limit=1] ca_turn matches $(side) run return 0
$function catan:ui/named_button {side:$(side),code:$(code)}
