scoreboard players set #chosen xq_ctx 0
scoreboard players set #chosen_covered xq_ctx 0
execute as @e[type=minecraft:marker,tag=xq.board] if score @s xq_sq = #target xq_ctx run scoreboard players operation #chosen xq_ctx = @s xq_piece
execute as @e[type=minecraft:marker,tag=xq.board] if score @s xq_sq = #target xq_ctx if score @s xq_covered matches 1 run scoreboard players set #chosen_covered xq_ctx 1
scoreboard players operation #chosen xq_ctx *= @s xq_turn
execute unless score #chosen xq_ctx matches 1..7 run return 0
scoreboard players operation @s xq_sel = #target xq_ctx
function xiangqi:visual/select
execute if score #chosen_covered xq_ctx matches 0 if score #chosen xq_ctx matches 1 run title @a[tag=xq.actor] actionbar {text:"已选择：兵／卒",color:"gold"}
execute if score #chosen_covered xq_ctx matches 0 if score #chosen xq_ctx matches 2 run title @a[tag=xq.actor] actionbar {text:"已选择：马",color:"gold"}
execute if score #chosen_covered xq_ctx matches 0 if score #chosen xq_ctx matches 3 run title @a[tag=xq.actor] actionbar {text:"已选择：相／象",color:"gold"}
execute if score #chosen_covered xq_ctx matches 0 if score #chosen xq_ctx matches 4 run title @a[tag=xq.actor] actionbar {text:"已选择：车",color:"gold"}
execute if score #chosen_covered xq_ctx matches 0 if score #chosen xq_ctx matches 5 run title @a[tag=xq.actor] actionbar {text:"已选择：炮",color:"gold"}
execute if score #chosen_covered xq_ctx matches 0 if score #chosen xq_ctx matches 6 run title @a[tag=xq.actor] actionbar {text:"已选择：帅／将",color:"gold"}
execute if score #chosen_covered xq_ctx matches 0 if score #chosen xq_ctx matches 7 run title @a[tag=xq.actor] actionbar {text:"已选择：仕／士",color:"gold"}
execute if score #chosen_covered xq_ctx matches 1 if score #chosen xq_ctx matches 1 run title @a[tag=xq.actor] actionbar {text:"暗子（按兵／卒走）",color:"gold"}
execute if score #chosen_covered xq_ctx matches 1 if score #chosen xq_ctx matches 2 run title @a[tag=xq.actor] actionbar {text:"暗子（按马走）",color:"gold"}
execute if score #chosen_covered xq_ctx matches 1 if score #chosen xq_ctx matches 3 run title @a[tag=xq.actor] actionbar {text:"暗子（按相／象走）",color:"gold"}
execute if score #chosen_covered xq_ctx matches 1 if score #chosen xq_ctx matches 4 run title @a[tag=xq.actor] actionbar {text:"暗子（按车走）",color:"gold"}
execute if score #chosen_covered xq_ctx matches 1 if score #chosen xq_ctx matches 5 run title @a[tag=xq.actor] actionbar {text:"暗子（按炮走）",color:"gold"}
execute if score #chosen_covered xq_ctx matches 1 if score #chosen xq_ctx matches 6 run title @a[tag=xq.actor] actionbar {text:"暗子（按帅／将走）",color:"gold"}
execute if score #chosen_covered xq_ctx matches 1 if score #chosen xq_ctx matches 7 run title @a[tag=xq.actor] actionbar {text:"暗子（按仕／士走）",color:"gold"}
