scoreboard players set @s it_done 1
scoreboard players set @s it_sum 0
execute as @e[tag=it.cards,scores={it_used=0}] if score @s it_owner = #actor it_ctx run function ito:game/reveal
execute as @e[tag=it.current,limit=1] at @s run function ito:red/check
