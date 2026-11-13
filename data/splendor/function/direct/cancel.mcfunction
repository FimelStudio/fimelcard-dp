function splendor:input/context
execute unless entity @s[tag=sp.actor] run return 0
$execute unless score @s sp_table matches $(table) run return run function splendor:direct/stale
$execute unless score @e[tag=sp.current,limit=1] sp_epoch matches $(epoch) run return run function splendor:direct/stale
execute unless score @s sp_side = @e[tag=sp.current,limit=1] sp_turn run return run function splendor:hud/notice {"text":{"text":"尚未轮到你行动。","color":"yellow"}}
execute unless entity @e[tag=sp.current,scores={sp_anim=0},limit=1] run return run function splendor:hud/notice {"text":{"text":"正在结算上次行动，请稍候。","color":"yellow"}}
execute if entity @e[tag=sp.current,scores={sp_state=4},limit=1] run return run function splendor:hud/notice {"text":{"text":"游戏已经结束。","color":"yellow"}}
execute unless score @s sp_select_epoch = @e[tag=sp.current,limit=1] sp_epoch run function splendor:direct/reset
$scoreboard players set @s sp_target $(id)
$execute if predicate {type:"minecraft:int_value_check",value:$(kind),test:4} run return run function splendor:direct/gem_cancel
function splendor:direct/reset
execute as @e[tag=sp.current,limit=1] at @s run function splendor:visual/selection
function splendor:hud/notice {"text":{"text":"已取消选择。","color":"yellow"}}
