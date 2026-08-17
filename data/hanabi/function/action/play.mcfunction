function hanabi:action/select_card
execute unless entity @e[tag=hb.chosen,limit=1] run return run execute as @a[tag=hb.action_actor,limit=1] run function hanabi:hand/sync

scoreboard players operation #played_color hb_ctx = @e[tag=hb.chosen,limit=1] hb_color
scoreboard players operation #played_rank hb_ctx = @e[tag=hb.chosen,limit=1] hb_rank
scoreboard players set #stack hb_ctx 0
execute if score #played_color hb_ctx matches 1 run scoreboard players operation #stack hb_ctx = @s hb_wstack
execute if score #played_color hb_ctx matches 2 run scoreboard players operation #stack hb_ctx = @s hb_rstack
execute if score #played_color hb_ctx matches 3 run scoreboard players operation #stack hb_ctx = @s hb_bstack
execute if score #played_color hb_ctx matches 4 run scoreboard players operation #stack hb_ctx = @s hb_ystack
execute if score #played_color hb_ctx matches 5 run scoreboard players operation #stack hb_ctx = @s hb_gstack
execute if score #played_color hb_ctx matches 6 run scoreboard players operation #stack hb_ctx = @s hb_mstack
scoreboard players add #stack hb_ctx 1

execute if score #played_rank hb_ctx = #stack hb_ctx run return run function hanabi:action/play_success
function hanabi:action/play_failure
