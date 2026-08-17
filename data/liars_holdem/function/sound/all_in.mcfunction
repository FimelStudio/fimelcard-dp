# ALL IN是全桌最强的行动提示，但控制音量避免盖住聊天与后续回合声
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @a[tag=lh.action_actor] if score @s lh_id = #ctx_id lh_ctx at @s as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run playsound minecraft:entity.warden.heartbeat player @s ~ ~ ~ 0.62 0.70
execute as @a[tag=lh.action_actor] if score @s lh_id = #ctx_id lh_ctx at @s as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run playsound minecraft:block.end_portal_frame.fill player @s ~ ~ ~ 0.52 0.65
execute as @a[tag=lh.action_actor] if score @s lh_id = #ctx_id lh_ctx at @s as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run playsound minecraft:block.note_block.bass player @s ~ ~ ~ 0.75 0.55
