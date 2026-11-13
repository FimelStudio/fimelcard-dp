$execute unless score @s ll_table matches $(table) run return 0
$execute unless score @s ll_seat matches $(owner) run return 0
$execute unless score @e[tag=ll.current,limit=1] ll_epoch matches $(epoch) run return 0
$scoreboard players set #aim ll_ctx $(target)
