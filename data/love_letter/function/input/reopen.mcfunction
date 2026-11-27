# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$execute unless score @s ll_table matches $(table) run return 0
function love_letter:input/context
execute unless entity @s[tag=ll.actor] run return 0
# 选人头颅期间，恢复入口先取消待选目标，再重开手牌窗口。
execute if score @e[tag=ll.current,limit=1] ll_select_epoch = @e[tag=ll.current,limit=1] ll_epoch if score @s ll_seat = @e[tag=ll.current,limit=1] ll_select_actor run function love_letter:targeting/cancel
function love_letter:input/give
function love_letter:ui/open
