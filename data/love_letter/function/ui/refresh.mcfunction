# 只对当前决策玩家展开选择；旁观者与其他玩家不会被强制弹窗。
function love_letter:system/context
scoreboard players set @a[tag=ll.audience] ll_pick -1
scoreboard players set @a[tag=ll.audience] ll_action 0
scoreboard players enable @a[tag=ll.audience] ll_action
execute unless score @s ll_state matches 2 run return 0
execute unless score @s ll_anim matches 0 run return 0
scoreboard players operation #ui_decider ll_ctx = @s ll_actor
execute if score @s ll_phase matches 1 run scoreboard players operation #ui_decider ll_ctx = @s ll_turn
execute as @a[tag=ll.audience] if score @s ll_seat = #ui_decider ll_ctx run function love_letter:ui/open
