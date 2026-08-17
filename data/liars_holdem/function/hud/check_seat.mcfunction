# 每秒只比较一次本座位的期望数量与实际实体数；相同则不做任何实体操作
scoreboard players set #hud_expected lh_ctx 0
$execute as @a[tag=lh.player,scores={lh_alive=1,lh_seat=$(seat)}] if score @s lh_id = #ctx_id lh_ctx run scoreboard players operation #hud_expected lh_ctx = @s lh_bullets
execute if score #hud_expected lh_ctx matches 9.. run scoreboard players set #hud_expected lh_ctx 8

scoreboard players set #hud_actual lh_ctx 0
$execute as @e[type=minecraft:item_display,tag=lh.bullet_hud,scores={lh_slot=$(seat)}] if score @s lh_id = #ctx_id lh_ctx run scoreboard players add #hud_actual lh_ctx 1
execute unless score #hud_actual lh_ctx = #hud_expected lh_ctx run scoreboard players set #hud_dirty lh_ctx 1
