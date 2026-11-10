tag @s remove ll.choice_pending
function love_letter:input/context
execute unless entity @s[tag=ll.actor] run return 0
execute unless entity @e[tag=ll.current,scores={ll_state=2,ll_phase=2..5,ll_anim=0},limit=1] run return 0
execute unless score @s ll_seat = @e[tag=ll.current,limit=1] ll_actor run return 0
execute unless score @s ll_seen = @e[tag=ll.current,limit=1] ll_epoch run return 0
function love_letter:ui/open
