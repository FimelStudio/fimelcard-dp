scoreboard players set #hud_bullets lh_ctx 0
$execute as @a[tag=lh.player,scores={lh_alive=1,lh_seat=$(seat)}] if score @s lh_id = #ctx_id lh_ctx run scoreboard players operation #hud_bullets lh_ctx = @s lh_bullets
