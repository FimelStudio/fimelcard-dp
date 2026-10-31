function chess:engine/restore_cache with storage chess:engine scratch
execute if score #capture_sq ch_ctx matches 0..63 unless score #capture_sq ch_ctx = #to ch_ctx run function chess:engine/ep_restore with storage chess:engine scratch
execute if score #rook_from ch_ctx matches 0..63 run function chess:engine/rook_restore with storage chess:engine scratch
