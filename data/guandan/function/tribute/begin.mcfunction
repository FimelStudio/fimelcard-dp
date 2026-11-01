function guandan:system/context
execute if score @s gd_round matches 1 run return run function guandan:game/first_turn
scoreboard players set @s gd_state 2
scoreboard players set @s gd_phase 1
scoreboard players set @s gd_tribn 1
scoreboard players set #headteam gd_ctx -1
execute as @e[tag=gd.board,scores={gd_prevrank=1}] run scoreboard players operation #headteam gd_ctx = @s gd_team
execute as @e[tag=gd.board,scores={gd_prevrank=1}] run scoreboard players operation @e[tag=gd.current,limit=1] gd_first = @s gd_seat
execute as @e[tag=gd.board,scores={gd_prevrank=2}] if score @s gd_team = #headteam gd_ctx run scoreboard players set @e[tag=gd.current,limit=1] gd_tribn 2
scoreboard players set @e[tag=gd.board,scores={gd_prevrank=4}] gd_tribute 1
execute if score @s gd_tribn matches 2 run scoreboard players set @e[tag=gd.board,scores={gd_prevrank=3}] gd_tribute 1
scoreboard players set #bigjokers gd_ctx 0
execute as @e[tag=gd.board,scores={gd_tribute=1}] run function guandan:tribute/count_jokers
execute if score #bigjokers gd_ctx matches 2 run return run function guandan:tribute/resist
function guandan:game/bump_epoch
function guandan:clock/reset
tellraw @a[tag=gd.audience] {text:"[掼蛋] 进入贡牌阶段，请进贡手中最大的牌（红桃级牌除外）。",color:"gold"}
function guandan:visual/refresh
function guandan:hud/refresh
function guandan:ui/refresh
