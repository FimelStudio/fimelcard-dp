function guandan:cards/compare_candidate
execute store result storage guandan:cards candidate.kind int 1 run scoreboard players get #kind gd_ctx
execute store result storage guandan:cards candidate.size int 1 run scoreboard players get #size gd_ctx
execute store result storage guandan:cards candidate.high int 1 run scoreboard players get #high gd_ctx
execute store result storage guandan:cards candidate.point int 1 run scoreboard players get #point gd_ctx
execute store result storage guandan:cards candidate.power int 1 run scoreboard players get #power gd_ctx
execute store result storage guandan:cards candidate.suit int 1 run scoreboard players get #suit gd_ctx
execute store result storage guandan:cards candidate.beat int 1 run scoreboard players get #beats gd_ctx
scoreboard players operation #code gd_ctx = #kind gd_ctx
scoreboard players operation #code gd_ctx *= #100000 gd_ctx
scoreboard players operation #temp gd_ctx = #size gd_ctx
scoreboard players operation #temp gd_ctx *= #1000 gd_ctx
scoreboard players operation #code gd_ctx += #temp gd_ctx
scoreboard players operation #temp gd_ctx = #high gd_ctx
scoreboard players operation #temp gd_ctx *= #10 gd_ctx
scoreboard players operation #code gd_ctx += #temp gd_ctx
scoreboard players operation #code gd_ctx += #suit gd_ctx
scoreboard players add #code gd_ctx 1
execute store result storage guandan:cards candidate.code int 1 run scoreboard players get #code gd_ctx
data modify entity @s data.guandan.options append from storage guandan:cards candidate
scoreboard players add #options gd_ctx 1
