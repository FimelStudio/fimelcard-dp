# #side指定被检查一方。仅材料能够确定不可能将死时返回0，其余返回1。
scoreboard players operation #mate_side ch_ctx = #side ch_ctx
function chess:system/context
function chess:engine/cache
scoreboard players operation #side ch_ctx = #mate_side ch_ctx
scoreboard players set #can_mate ch_ctx 1
execute unless score #cache_ok ch_ctx matches 1 run return 1
function chess:engine/material
scoreboard players set #can_mate ch_ctx 1
execute if score #dead ch_ctx matches 1 run scoreboard players set #can_mate ch_ctx 0
scoreboard players set #own_minor ch_ctx 0
scoreboard players set #own_heavy ch_ctx 0
scoreboard players set #own_knights ch_ctx 0
scoreboard players set #opp_support ch_ctx 0
scoreboard players set #pawns ch_ctx 0
execute if score #side ch_ctx matches 1 if score #b0 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b0 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b0 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b0 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b0 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b0 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b0 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b0 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b0 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b0 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b0 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b0 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b1 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b1 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b1 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b1 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b1 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b1 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b1 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b1 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b1 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b1 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b1 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b1 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b2 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b2 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b2 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b2 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b2 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b2 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b2 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b2 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b2 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b2 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b2 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b2 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b3 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b3 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b3 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b3 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b3 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b3 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b3 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b3 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b3 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b3 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b3 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b3 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b4 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b4 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b4 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b4 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b4 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b4 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b4 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b4 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b4 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b4 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b4 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b4 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b5 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b5 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b5 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b5 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b5 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b5 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b5 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b5 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b5 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b5 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b5 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b5 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b6 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b6 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b6 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b6 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b6 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b6 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b6 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b6 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b6 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b6 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b6 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b6 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b7 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b7 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b7 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b7 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b7 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b7 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b7 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b7 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b7 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b7 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b7 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b7 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b8 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b8 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b8 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b8 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b8 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b8 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b8 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b8 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b8 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b8 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b8 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b8 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b9 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b9 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b9 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b9 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b9 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b9 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b9 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b9 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b9 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b9 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b9 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b9 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b10 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b10 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b10 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b10 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b10 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b10 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b10 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b10 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b10 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b10 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b10 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b10 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b11 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b11 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b11 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b11 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b11 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b11 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b11 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b11 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b11 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b11 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b11 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b11 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b12 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b12 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b12 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b12 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b12 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b12 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b12 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b12 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b12 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b12 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b12 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b12 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b13 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b13 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b13 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b13 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b13 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b13 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b13 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b13 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b13 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b13 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b13 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b13 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b14 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b14 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b14 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b14 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b14 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b14 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b14 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b14 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b14 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b14 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b14 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b14 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b15 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b15 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b15 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b15 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b15 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b15 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b15 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b15 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b15 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b15 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b15 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b15 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b16 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b16 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b16 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b16 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b16 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b16 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b16 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b16 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b16 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b16 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b16 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b16 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b17 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b17 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b17 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b17 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b17 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b17 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b17 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b17 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b17 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b17 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b17 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b17 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b18 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b18 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b18 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b18 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b18 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b18 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b18 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b18 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b18 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b18 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b18 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b18 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b19 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b19 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b19 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b19 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b19 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b19 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b19 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b19 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b19 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b19 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b19 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b19 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b20 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b20 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b20 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b20 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b20 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b20 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b20 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b20 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b20 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b20 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b20 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b20 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b21 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b21 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b21 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b21 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b21 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b21 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b21 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b21 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b21 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b21 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b21 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b21 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b22 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b22 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b22 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b22 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b22 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b22 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b22 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b22 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b22 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b22 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b22 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b22 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b23 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b23 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b23 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b23 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b23 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b23 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b23 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b23 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b23 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b23 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b23 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b23 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b24 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b24 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b24 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b24 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b24 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b24 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b24 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b24 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b24 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b24 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b24 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b24 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b25 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b25 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b25 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b25 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b25 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b25 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b25 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b25 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b25 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b25 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b25 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b25 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b26 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b26 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b26 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b26 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b26 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b26 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b26 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b26 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b26 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b26 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b26 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b26 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b27 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b27 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b27 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b27 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b27 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b27 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b27 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b27 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b27 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b27 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b27 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b27 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b28 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b28 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b28 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b28 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b28 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b28 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b28 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b28 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b28 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b28 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b28 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b28 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b29 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b29 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b29 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b29 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b29 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b29 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b29 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b29 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b29 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b29 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b29 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b29 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b30 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b30 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b30 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b30 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b30 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b30 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b30 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b30 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b30 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b30 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b30 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b30 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b31 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b31 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b31 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b31 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b31 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b31 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b31 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b31 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b31 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b31 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b31 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b31 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b32 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b32 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b32 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b32 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b32 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b32 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b32 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b32 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b32 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b32 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b32 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b32 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b33 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b33 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b33 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b33 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b33 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b33 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b33 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b33 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b33 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b33 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b33 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b33 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b34 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b34 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b34 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b34 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b34 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b34 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b34 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b34 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b34 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b34 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b34 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b34 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b35 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b35 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b35 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b35 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b35 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b35 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b35 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b35 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b35 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b35 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b35 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b35 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b36 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b36 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b36 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b36 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b36 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b36 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b36 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b36 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b36 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b36 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b36 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b36 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b37 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b37 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b37 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b37 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b37 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b37 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b37 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b37 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b37 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b37 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b37 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b37 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b38 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b38 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b38 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b38 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b38 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b38 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b38 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b38 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b38 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b38 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b38 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b38 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b39 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b39 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b39 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b39 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b39 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b39 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b39 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b39 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b39 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b39 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b39 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b39 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b40 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b40 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b40 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b40 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b40 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b40 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b40 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b40 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b40 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b40 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b40 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b40 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b41 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b41 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b41 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b41 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b41 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b41 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b41 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b41 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b41 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b41 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b41 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b41 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b42 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b42 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b42 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b42 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b42 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b42 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b42 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b42 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b42 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b42 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b42 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b42 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b43 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b43 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b43 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b43 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b43 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b43 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b43 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b43 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b43 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b43 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b43 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b43 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b44 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b44 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b44 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b44 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b44 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b44 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b44 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b44 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b44 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b44 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b44 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b44 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b45 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b45 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b45 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b45 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b45 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b45 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b45 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b45 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b45 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b45 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b45 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b45 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b46 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b46 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b46 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b46 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b46 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b46 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b46 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b46 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b46 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b46 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b46 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b46 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b47 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b47 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b47 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b47 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b47 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b47 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b47 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b47 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b47 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b47 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b47 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b47 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b48 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b48 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b48 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b48 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b48 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b48 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b48 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b48 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b48 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b48 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b48 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b48 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b49 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b49 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b49 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b49 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b49 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b49 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b49 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b49 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b49 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b49 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b49 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b49 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b50 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b50 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b50 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b50 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b50 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b50 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b50 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b50 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b50 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b50 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b50 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b50 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b51 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b51 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b51 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b51 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b51 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b51 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b51 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b51 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b51 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b51 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b51 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b51 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b52 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b52 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b52 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b52 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b52 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b52 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b52 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b52 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b52 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b52 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b52 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b52 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b53 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b53 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b53 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b53 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b53 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b53 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b53 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b53 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b53 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b53 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b53 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b53 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b54 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b54 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b54 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b54 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b54 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b54 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b54 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b54 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b54 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b54 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b54 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b54 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b55 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b55 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b55 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b55 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b55 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b55 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b55 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b55 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b55 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b55 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b55 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b55 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b56 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b56 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b56 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b56 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b56 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b56 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b56 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b56 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b56 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b56 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b56 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b56 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b57 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b57 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b57 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b57 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b57 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b57 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b57 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b57 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b57 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b57 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b57 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b57 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b58 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b58 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b58 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b58 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b58 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b58 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b58 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b58 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b58 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b58 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b58 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b58 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b59 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b59 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b59 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b59 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b59 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b59 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b59 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b59 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b59 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b59 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b59 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b59 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b60 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b60 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b60 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b60 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b60 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b60 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b60 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b60 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b60 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b60 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b60 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b60 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b61 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b61 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b61 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b61 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b61 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b61 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b61 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b61 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b61 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b61 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b61 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b61 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b62 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b62 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b62 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b62 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b62 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b62 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b62 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b62 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b62 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b62 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b62 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b62 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b63 ch_ctx matches 1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b63 ch_ctx matches 4..5 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b63 ch_ctx matches 2..3 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b63 ch_ctx matches 2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches 1 if score #b63 ch_ctx matches -4..-1 run scoreboard players add #opp_support ch_ctx 1
execute if score #b63 ch_ctx matches 1 run scoreboard players add #pawns ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b63 ch_ctx matches -1 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b63 ch_ctx matches -5..-4 run scoreboard players add #own_heavy ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b63 ch_ctx matches -3..-2 run scoreboard players add #own_minor ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b63 ch_ctx matches -2 run scoreboard players add #own_knights ch_ctx 1
execute if score #side ch_ctx matches -1 if score #b63 ch_ctx matches 1..4 run scoreboard players add #opp_support ch_ctx 1
execute if score #b63 ch_ctx matches -1 run scoreboard players add #pawns ch_ctx 1
execute if score #own_minor ch_ctx matches 0 if score #own_heavy ch_ctx matches 0 run scoreboard players set #can_mate ch_ctx 0
# 对方的后不能帮助单马完成合作将死；兵/马/象/车则可能帮助封死逃格。
execute if score #own_heavy ch_ctx matches 0 if score #own_minor ch_ctx matches 1 if score #own_knights ch_ctx matches 1 if score #opp_support ch_ctx matches 0 run scoreboard players set #can_mate ch_ctx 0
# 单色格象（可有多枚）对仅王/车/后/同色格象也无法将死。
execute if score #own_heavy ch_ctx matches 0 if score #own_knights ch_ctx matches 0 if score #pawns ch_ctx matches 0 if score #knights ch_ctx matches 0 if score #bishops_light ch_ctx matches 0 run scoreboard players set #can_mate ch_ctx 0
execute if score #own_heavy ch_ctx matches 0 if score #own_knights ch_ctx matches 0 if score #pawns ch_ctx matches 0 if score #knights ch_ctx matches 0 if score #bishops_dark ch_ctx matches 0 run scoreboard players set #can_mate ch_ctx 0
return run scoreboard players get #can_mate ch_ctx
