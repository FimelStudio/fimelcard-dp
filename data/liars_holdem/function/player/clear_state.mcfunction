function liars_holdem:util/clear_items
dialog clear @s

tag @s remove lh.player
tag @s remove lh.turn
tag @s remove lh.action_actor
tag @s remove lh.gun_target
tag @s remove lh.showdown
tag @s remove lh.winner
tag @s remove lh.return_owner

scoreboard players reset @s lh_id
scoreboard players reset @s lh_seat
scoreboard players reset @s lh_alive
scoreboard players reset @s lh_fold
scoreboard players reset @s lh_wait
scoreboard players reset @s lh_done
scoreboard players reset @s lh_bullets
scoreboard players reset @s lh_swap
scoreboard players reset @s lh_swap_slot
scoreboard players reset @s lh_swap_pending
scoreboard players reset @s lh_drop_retry
scoreboard players reset @s lh_pending_gun
scoreboard players reset @s lh_hand_count
scoreboard players reset @s lh_cat
scoreboard players reset @s lh_value
scoreboard players reset @s lh_k1
scoreboard players reset @s lh_k2
scoreboard players reset @s lh_k3
scoreboard players reset @s lh_k4
scoreboard players reset @s lh_k5
scoreboard players reset @s lh_b1
scoreboard players reset @s lh_b2
scoreboard players reset @s lh_b3
scoreboard players reset @s lh_b4
scoreboard players reset @s lh_b5
scoreboard players reset @s lh_place
scoreboard players reset @s lh_in_showdown
scoreboard players reset @s lh_is_winner
scoreboard players reset @s lh_shown
scoreboard players reset @s lh_drop_card
scoreboard players reset @s lh_drop_call
scoreboard players reset @s lh_drop_fold
scoreboard players reset @s lh_swap_pick
