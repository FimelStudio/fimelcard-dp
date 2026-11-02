scoreboard players set #chosen xq_ctx 0
execute as @e[type=minecraft:marker,tag=xq.board] if score @s xq_sq = #target xq_ctx run scoreboard players operation #chosen xq_ctx = @s xq_piece
scoreboard players operation #chosen xq_ctx *= @s xq_turn
execute unless score #chosen xq_ctx matches 1..7 run return 0
scoreboard players operation @s xq_sel = #target xq_ctx
function xiangqi:visual/select
execute if score #chosen xq_ctx matches 1 run title @a[tag=xq.actor] actionbar {text:"已选择：兵／卒",color:"gold"}
execute if score #chosen xq_ctx matches 2 run title @a[tag=xq.actor] actionbar {text:"已选择：马",color:"gold"}
execute if score #chosen xq_ctx matches 3 run title @a[tag=xq.actor] actionbar {text:"已选择：相／象",color:"gold"}
execute if score #chosen xq_ctx matches 4 run title @a[tag=xq.actor] actionbar {text:"已选择：车",color:"gold"}
execute if score #chosen xq_ctx matches 5 run title @a[tag=xq.actor] actionbar {text:"已选择：炮",color:"gold"}
execute if score #chosen xq_ctx matches 6 run title @a[tag=xq.actor] actionbar {text:"已选择：帅／将",color:"gold"}
execute if score #chosen xq_ctx matches 7 run title @a[tag=xq.actor] actionbar {text:"已选择：仕／士",color:"gold"}
