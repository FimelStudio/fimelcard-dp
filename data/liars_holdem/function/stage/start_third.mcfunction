function liars_holdem:transition/cleanup
scoreboard players set @s lh_state 9
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @a[tag=lh.player,scores={lh_alive=1,lh_fold=0}] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_done 0
scoreboard players operation @s lh_turn = @s lh_dealer
function liars_holdem:turn/advance
