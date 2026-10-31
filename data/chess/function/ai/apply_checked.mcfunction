function chess:engine/apply_cache with storage chess:engine scratch
execute if score #capture_sq ch_ctx matches 0..63 unless score #capture_sq ch_ctx = #to ch_ctx run function chess:engine/ep_remove with storage chess:engine scratch
execute if score #rook_from ch_ctx matches 0..63 run function chess:engine/rook_apply with storage chess:engine scratch
