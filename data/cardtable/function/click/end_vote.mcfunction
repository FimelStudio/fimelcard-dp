advancement revoke @s only cardtable:click/end_vote
advancement revoke @s only cardtable:click/end_vote_attack
execute unless entity @s[tag=ct.player] run return fail

scoreboard players operation #ctx_id ct_ctx = @s ct_id
tag @s add ct.voter
tag @e[tag=ct.vote_controller] remove ct.vote_controller
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_state=1}] if score @s ct_id = #ctx_id ct_ctx run tag @s add ct.vote_controller
execute as @e[tag=ct.vote_controller,limit=1] at @s run function cardtable:vote/accept
tag @e[tag=ct.vote_controller] remove ct.vote_controller
tag @s remove ct.voter
