scoreboard players operation #ctx cp_ctx = @s cp_id
execute as @a[tag=cp.player,scores={cp_locked=0}] if score @s cp_id = #ctx cp_ctx run function critical_point:input/give_vote_reopen
