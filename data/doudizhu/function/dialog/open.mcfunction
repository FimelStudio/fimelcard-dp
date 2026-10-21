function doudizhu:action/context
execute unless entity @e[tag=dd.current,limit=1] run return 0
execute if score @e[tag=dd.current,limit=1] dd_state matches 1 run tellraw @s {text:"正在发牌，请稍候。",color:"gray"}
execute if score @e[tag=dd.current,limit=1] dd_state matches 1 run return run function doudizhu:action/clear_context
execute unless score @e[tag=dd.current,limit=1] dd_state matches 2..3 run return run function doudizhu:action/clear_context
function doudizhu:bid/can_operate
execute unless score #can_operate dd_ctx matches 1 run return run function doudizhu:input/reject
scoreboard players set @s dd_action 0
scoreboard players enable @s dd_action
function doudizhu:hand/build
function doudizhu:hud/build
function doudizhu:dialog/grid
data modify storage doudizhu:ui controls set value []
data modify storage doudizhu:ui status set value {text:"等待其他玩家操作。",color:"gray"}
execute if score @s dd_seat = @e[tag=dd.current,limit=1] dd_turn run data modify storage doudizhu:ui status set value {text:"轮到你操作。点击牌面切换选中，金色边框表示选中。",color:"green"}
execute if score @e[tag=dd.current,limit=1] dd_state matches 2 run function doudizhu:dialog/bid_buttons
execute if score @e[tag=dd.current,limit=1] dd_state matches 3 run function doudizhu:dialog/play_buttons
data modify storage doudizhu:ui last_play set value {text:"还没有出牌，或等待重新领出。",color:"gray"}
execute if score @e[tag=dd.current,limit=1] dd_type matches 1.. run data modify storage doudizhu:ui last_play set from entity @e[tag=dd.current,limit=1] data.doudizhu.last_play
function doudizhu:dialog/show with storage doudizhu:ui
tag @e[tag=dd.hand] remove dd.hand
tag @e[tag=dd.current] remove dd.current
