function love_letter:input/context
execute unless entity @s[tag=ll.actor] run return 0
$execute unless score @s ll_table matches $(table) run return run function love_letter:input/give
$execute unless score @s ll_seat matches $(owner) run return run function love_letter:input/give
$execute unless score @e[tag=ll.current,limit=1] ll_epoch matches $(epoch) run return run function love_letter:input/give
execute unless entity @e[tag=ll.current,scores={ll_state=2,ll_phase=1,ll_anim=0},limit=1] run return run function love_letter:input/give
execute unless score @s ll_seat = @e[tag=ll.current,limit=1] ll_turn run return run function love_letter:input/give
$scoreboard players set @s ll_pick $(slot)
function love_letter:input/play
function love_letter:input/give
