function guandan:game/validate_actor
execute unless score #ok gd_ctx matches 1 run return 0
execute if score @s gd_lastkind matches 0 run return run function guandan:game/reject
scoreboard players add @s gd_passes 1
scoreboard players set #remaining gd_ctx 0
execute as @e[tag=gd.board,scores={gd_rank=0}] run scoreboard players add #remaining gd_ctx 1
scoreboard players operation #leader gd_ctx = @s gd_lastseat
execute as @e[tag=gd.board,scores={gd_rank=0}] if score @s gd_seat = #leader gd_ctx run scoreboard players remove #remaining gd_ctx 1
function guandan:sound/pass
execute as @e[tag=gd.board] if score @s gd_seat = #actor gd_ctx run tellraw @a[tag=gd.audience] [{text:"[掼蛋] ",color:"gold"},{nbt:"data.gd_name",entity:"@s",interpret:true,color:"aqua"},{text:" 不出。",color:"gray"}]
execute if score @s gd_passes >= #remaining gd_ctx run return run function guandan:game/new_trick
function guandan:game/next_turn
function guandan:game/bump_epoch
function guandan:hud/refresh
function guandan:ui/refresh
scoreboard players set #ok gd_ctx 1
