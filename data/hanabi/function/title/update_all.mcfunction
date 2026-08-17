# 仅在手牌或参与者发生变化时重建，不做逐刻重建。
scoreboard players operation #ctx_id hb_ctx = @s hb_id
execute as @a[tag=hb.player] if score @s hb_id = #ctx_id hb_ctx run function hanabi:title/build_player
