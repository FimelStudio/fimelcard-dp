function splendor:input/context
execute unless entity @s[tag=sp.actor] run return 0
$execute unless score @s sp_table matches $(table) run return run function splendor:direct/stale
$execute unless score @e[tag=sp.current,limit=1] sp_epoch matches $(epoch) run return run function splendor:direct/stale
execute unless score @s sp_side = @e[tag=sp.current,limit=1] sp_turn run return run function splendor:hud/notice {"text":{"text":"尚未轮到你行动。","color":"yellow"}}
execute unless entity @e[tag=sp.current,scores={sp_anim=0},limit=1] run return run function splendor:hud/notice {"text":{"text":"正在结算上次行动，请稍候。","color":"yellow"}}
execute if entity @e[tag=sp.current,scores={sp_state=4},limit=1] run return run function splendor:hud/notice {"text":{"text":"游戏已经结束。","color":"yellow"}}
$execute unless score @s sp_side matches $(owner) run return 0
execute unless entity @e[tag=sp.current,scores={sp_state=1},limit=1] run return run function splendor:hud/notice {"text":{"text":"请先完成当前待办，再购买预定牌。","color":"yellow"}}
execute unless score @s sp_select_epoch = @e[tag=sp.current,limit=1] sp_epoch run function splendor:direct/reset
$scoreboard players set @s sp_target $(slot)
execute unless score @s sp_target matches 0..2 run return run function splendor:hud/notice {"text":{"text":"这张预定牌的格位无效，请重新操作。","color":"yellow"}}
function splendor:direct/hand
scoreboard players set #select_kind sp_ctx 6
execute unless score @s sp_select_kind matches 6 run return run function splendor:direct/reserved_select
execute unless score @s sp_select_id = @s sp_target run return run function splendor:direct/reserved_select
scoreboard players add @s sp_target 12
function splendor:direct/read_card
execute unless score #card sp_ctx matches 0..89 run return run function splendor:hud/notice {"text":{"text":"这张预定牌已经失效，请重新操作。","color":"yellow"}}
function splendor:direct/quote
execute if score #quote_gold sp_ctx > #quote_owned sp_ctx run return run function splendor:hud/notice {"text":{"text":"宝石不足，暂时无法购买这张预定牌。","color":"yellow"}}
scoreboard players set #action_code sp_ctx 3
function splendor:direct/submit
