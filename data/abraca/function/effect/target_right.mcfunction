scoreboard players operation #ctx ab_ctx = @s ab_id
scoreboard players operation #target ab_ctx = @a[tag=ab.actor,limit=1] ab_seat
scoreboard players set #found ab_ctx 0
function abraca:effect/find_right
execute if score #found ab_ctx matches 0 run function abraca:effect/find_right
execute if score #found ab_ctx matches 0 run function abraca:effect/find_right
execute if score #found ab_ctx matches 0 run function abraca:effect/find_right
execute if score #found ab_ctx matches 0 run function abraca:effect/find_right
execute if score #found ab_ctx matches 0 run function abraca:effect/find_right
execute if score #found ab_ctx matches 0 run function abraca:effect/find_right
execute if score #found ab_ctx matches 0 run function abraca:effect/find_right
