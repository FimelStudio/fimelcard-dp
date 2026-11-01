execute unless score @s gd_state matches 3 run return 0
execute if score @s gd_scored matches 1 run return 0
function guandan:system/context
scoreboard players set @s gd_scored 1
scoreboard players set @s gd_state 4
scoreboard players set @s gd_timer 120
scoreboard players set @s gd_anim 0
scoreboard players set @s gd_clock 0
scoreboard players operation #rank gd_ctx = @s gd_done
execute as @e[tag=gd.board,scores={gd_rank=0}] run function guandan:round/assign_remaining
scoreboard players operation #winner gd_ctx = @e[tag=gd.board,scores={gd_rank=1},limit=1] gd_team
scoreboard players operation @s gd_winner = #winner gd_ctx
scoreboard players set #partner_rank gd_ctx 4
execute as @e[tag=gd.board,scores={gd_rank=2..4}] if score @s gd_team = #winner gd_ctx run scoreboard players operation #partner_rank gd_ctx = @s gd_rank
scoreboard players set @s gd_steps 5
scoreboard players operation @s gd_steps -= #partner_rank gd_ctx
scoreboard players set #oldlevel gd_ctx 2
execute if score #winner gd_ctx matches 0 run scoreboard players operation #oldlevel gd_ctx = @s gd_team0
execute if score #winner gd_ctx matches 1 run scoreboard players operation #oldlevel gd_ctx = @s gd_team1
scoreboard players set @s gd_matchwin -1
execute if score #oldlevel gd_ctx matches 14 if score @s gd_level matches 14 if score #partner_rank gd_ctx matches 2..3 run scoreboard players operation @s gd_matchwin = #winner gd_ctx
# A必打；未过A最多停在A，下一副继续打A，不做三次退2。
scoreboard players operation #newlevel gd_ctx = #oldlevel gd_ctx
scoreboard players operation #newlevel gd_ctx += @s gd_steps
execute if score #newlevel gd_ctx matches 15.. run scoreboard players set #newlevel gd_ctx 14
execute if score #winner gd_ctx matches 0 run scoreboard players operation @s gd_team0 = #newlevel gd_ctx
execute if score #winner gd_ctx matches 1 run scoreboard players operation @s gd_team1 = #newlevel gd_ctx
execute as @e[tag=gd.board] if score @s gd_team = #winner gd_ctx run scoreboard players operation @s gd_points += @e[tag=gd.current,limit=1] gd_steps
execute as @e[tag=gd.board] run scoreboard players operation @s gd_prevrank = @s gd_rank
scoreboard players operation @s gd_playteam = #winner gd_ctx
scoreboard players operation @s gd_level = #newlevel gd_ctx
function guandan:game/bump_epoch
tellraw @a[tag=gd.audience] [{text:"[掼蛋] 本副结束，第",color:"gold"},{score:{name:"@s",objective:"gd_winner"}},{text:"队升 "},{score:{name:"@s",objective:"gd_steps"}},{text:" 级；双方级数 "},{score:{name:"@s",objective:"gd_team0"}},{text:" / "},{score:{name:"@s",objective:"gd_team1"}},{text:"。"}]
function guandan:visual/upgrade
function guandan:sound/round_win
execute if score @s gd_matchwin matches 0..1 run function guandan:round/match_over
execute if score @s gd_mode matches 1 if score @s gd_round >= @s gd_rounds run function guandan:round/fixed_over
function guandan:visual/refresh
function guandan:hud/refresh
function guandan:ui/refresh
