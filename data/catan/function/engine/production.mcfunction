scoreboard players set #need1_0 ca_ctx 0
scoreboard players set #need1_1 ca_ctx 0
scoreboard players set #need1_2 ca_ctx 0
scoreboard players set #need1_3 ca_ctx 0
scoreboard players set #need1_4 ca_ctx 0
scoreboard players set #need2_0 ca_ctx 0
scoreboard players set #need2_1 ca_ctx 0
scoreboard players set #need2_2 ca_ctx 0
scoreboard players set #need2_3 ca_ctx 0
scoreboard players set #need2_4 ca_ctx 0
scoreboard players set #need3_0 ca_ctx 0
scoreboard players set #need3_1 ca_ctx 0
scoreboard players set #need3_2 ca_ctx 0
scoreboard players set #need3_3 ca_ctx 0
scoreboard players set #need3_4 ca_ctx 0
scoreboard players set #need4_0 ca_ctx 0
scoreboard players set #need4_1 ca_ctx 0
scoreboard players set #need4_2 ca_ctx 0
scoreboard players set #need4_3 ca_ctx 0
scoreboard players set #need4_4 ca_ctx 0
execute if score #hn0 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 0 run function catan:engine/production/demand_h0
execute if score #hn1 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 1 run function catan:engine/production/demand_h1
execute if score #hn2 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 2 run function catan:engine/production/demand_h2
execute if score #hn3 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 3 run function catan:engine/production/demand_h3
execute if score #hn4 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 4 run function catan:engine/production/demand_h4
execute if score #hn5 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 5 run function catan:engine/production/demand_h5
execute if score #hn6 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 6 run function catan:engine/production/demand_h6
execute if score #hn7 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 7 run function catan:engine/production/demand_h7
execute if score #hn8 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 8 run function catan:engine/production/demand_h8
execute if score #hn9 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 9 run function catan:engine/production/demand_h9
execute if score #hn10 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 10 run function catan:engine/production/demand_h10
execute if score #hn11 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 11 run function catan:engine/production/demand_h11
execute if score #hn12 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 12 run function catan:engine/production/demand_h12
execute if score #hn13 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 13 run function catan:engine/production/demand_h13
execute if score #hn14 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 14 run function catan:engine/production/demand_h14
execute if score #hn15 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 15 run function catan:engine/production/demand_h15
execute if score #hn16 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 16 run function catan:engine/production/demand_h16
execute if score #hn17 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 17 run function catan:engine/production/demand_h17
execute if score #hn18 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 18 run function catan:engine/production/demand_h18
function catan:engine/production/grant {resource:0}
function catan:engine/production/grant {resource:1}
function catan:engine/production/grant {resource:2}
function catan:engine/production/grant {resource:3}
function catan:engine/production/grant {resource:4}
execute if score #hn0 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 0 run function catan:engine/production/give_h0
execute if score #hn1 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 1 run function catan:engine/production/give_h1
execute if score #hn2 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 2 run function catan:engine/production/give_h2
execute if score #hn3 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 3 run function catan:engine/production/give_h3
execute if score #hn4 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 4 run function catan:engine/production/give_h4
execute if score #hn5 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 5 run function catan:engine/production/give_h5
execute if score #hn6 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 6 run function catan:engine/production/give_h6
execute if score #hn7 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 7 run function catan:engine/production/give_h7
execute if score #hn8 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 8 run function catan:engine/production/give_h8
execute if score #hn9 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 9 run function catan:engine/production/give_h9
execute if score #hn10 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 10 run function catan:engine/production/give_h10
execute if score #hn11 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 11 run function catan:engine/production/give_h11
execute if score #hn12 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 12 run function catan:engine/production/give_h12
execute if score #hn13 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 13 run function catan:engine/production/give_h13
execute if score #hn14 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 14 run function catan:engine/production/give_h14
execute if score #hn15 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 15 run function catan:engine/production/give_h15
execute if score #hn16 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 16 run function catan:engine/production/give_h16
execute if score #hn17 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 17 run function catan:engine/production/give_h17
execute if score #hn18 ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches 18 run function catan:engine/production/give_h18
function catan:engine/save_all_resources
function catan:engine/save_bank
