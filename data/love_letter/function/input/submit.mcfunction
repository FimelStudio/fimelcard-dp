scoreboard players operation @s ll_ui_tmp = @s ll_action
scoreboard players set @s ll_action 0
scoreboard players enable @s ll_action
function love_letter:input/context
execute unless entity @s[tag=ll.actor] run return run function love_letter:input/invalid
execute unless score @s ll_ui_load = #ui_load ll_ctx run return run function love_letter:input/invalid
scoreboard players set #ui_factor ll_ctx 1000
scoreboard players operation #ui_epoch ll_ctx = @s ll_ui_tmp
scoreboard players operation #ui_epoch ll_ctx /= #ui_factor ll_ctx
execute unless score #ui_epoch ll_ctx = @s ll_seen run return run function love_letter:input/invalid
execute unless score #ui_epoch ll_ctx = @e[tag=ll.current,limit=1] ll_epoch run return run function love_letter:input/invalid
scoreboard players operation #ui_action ll_ctx = @s ll_ui_tmp
scoreboard players operation #ui_action ll_ctx %= #ui_factor ll_ctx
execute if score #ui_action ll_ctx matches 1 run return run function love_letter:ui/open
execute if score #ui_action ll_ctx matches 2 run return run function love_letter:ui/menu
execute if score #ui_action ll_ctx matches 3 run return run function love_letter:ui/public
execute if score #ui_action ll_ctx matches 4 run return run function love_letter:rules/player
execute if score #ui_action ll_ctx matches 5 run return run function love_letter:ui/resign
execute if score #ui_action ll_ctx matches 6 run return run function love_letter:input/resign
execute if score #ui_action ll_ctx matches 10..11 run return run function love_letter:input/select
execute if score #ui_action ll_ctx matches 20 run return run function love_letter:input/play
dialog clear @s
scoreboard players set #ok ll_ctx 0
execute if score #ui_action ll_ctx matches 101..108 run function love_letter:input/target
execute if score #ui_action ll_ctx matches 200..209 unless score #ui_action ll_ctx matches 201 run function love_letter:input/guess
execute if score #ui_action ll_ctx matches 300..302 run function love_letter:input/keep
execute if score #ui_action ll_ctx matches 400..401 run function love_letter:input/bottom
execute unless score #ok ll_ctx matches 1 run function love_letter:input/invalid
