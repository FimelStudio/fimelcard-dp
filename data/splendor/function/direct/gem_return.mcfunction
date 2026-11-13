function splendor:input/context
execute unless entity @s[tag=sp.actor] run return 0
$execute unless score @s sp_table matches $(table) run return 0
$execute unless score @s sp_side matches $(owner) run return 0
execute unless score @s sp_side = @e[tag=sp.current,limit=1] sp_turn run return run function splendor:hud/notice {"text":{"text":"尚未轮到你行动。","color":"yellow"}}
execute unless entity @e[tag=sp.current,scores={sp_state=2,sp_anim=0},limit=1] run return run function splendor:hud/notice {"text":{"text":"只有筹码超过十颗时才需要退珠。","color":"yellow"}}
execute unless score @s sp_select_epoch = @e[tag=sp.current,limit=1] sp_epoch run function splendor:direct/reset
$scoreboard players set @s sp_target $(color)
function splendor:direct/gem
