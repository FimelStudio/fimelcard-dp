scoreboard players operation #request it_ctx = @s it_action
scoreboard players set @s it_action 0
scoreboard players enable @s it_action
function ito:input/context
execute unless score #valid it_ctx matches 1 run return 0
scoreboard players operation #choice it_ctx = #request it_ctx
scoreboard players operation #choice it_ctx %= #hundred it_ctx
scoreboard players operation #request it_ctx /= #hundred it_ctx
execute unless score #request it_ctx = @s it_window run return 0
execute unless score @s it_win_epoch = @e[tag=it.current,limit=1] it_epoch run return 0
execute if score #choice it_ctx matches 1..2 run return run function ito:themes/vote
scoreboard players operation #slot it_ctx = #choice it_ctx
execute if score #choice it_ctx matches 11..13 run scoreboard players remove #slot it_ctx 10
execute if score #choice it_ctx matches 11..13 run return run function ito:form/open
execute if score #choice it_ctx matches 21..23 run scoreboard players remove #slot it_ctx 20
execute if score #choice it_ctx matches 21..23 as @e[tag=it.current,limit=1] at @s run function ito:game/play
