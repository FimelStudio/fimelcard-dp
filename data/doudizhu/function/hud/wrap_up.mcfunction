execute as @e[tag=dd.actor] if score @s dd_id = #hud_table dd_ctx unless score @s dd_seat = #hud_out dd_ctx run scoreboard players operation #hud_up dd_ctx > @s dd_seat
