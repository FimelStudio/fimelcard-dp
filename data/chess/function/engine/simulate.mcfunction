execute store result storage chess:engine scratch.capture_sq int 1 run scoreboard players get #capture_sq ch_ctx
execute store result storage chess:engine scratch.rook_from int 1 run scoreboard players get #rook_from ch_ctx
execute store result storage chess:engine scratch.rook_to int 1 run scoreboard players get #rook_to ch_ctx
function chess:engine/apply_cache with storage chess:engine scratch
execute if score #capture_sq ch_ctx matches 0..63 unless score #capture_sq ch_ctx = #to ch_ctx run function chess:engine/ep_remove with storage chess:engine scratch
execute if score #rook_from ch_ctx matches 0..63 run function chess:engine/rook_apply with storage chess:engine scratch
scoreboard players operation #attack_sq ch_ctx = #wking ch_ctx
execute if score #side ch_ctx matches -1 run scoreboard players operation #attack_sq ch_ctx = #bking ch_ctx
execute if score #kind ch_ctx matches 6 run scoreboard players operation #attack_sq ch_ctx = #to ch_ctx
scoreboard players operation #attacker ch_ctx = #side ch_ctx
scoreboard players operation #attacker ch_ctx *= #minus ch_ctx
function chess:engine/attack
# 恢复模拟缓存；包括吃过路被吃兵与易位的车。
function chess:engine/restore_cache with storage chess:engine scratch
execute if score #capture_sq ch_ctx matches 0..63 unless score #capture_sq ch_ctx = #to ch_ctx run function chess:engine/ep_restore with storage chess:engine scratch
execute if score #rook_from ch_ctx matches 0..63 run function chess:engine/rook_restore with storage chess:engine scratch
