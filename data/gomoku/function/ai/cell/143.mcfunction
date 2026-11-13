execute unless score #b143 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b103 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b103 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b104 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b104 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b105 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b105 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b106 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b106 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b107 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b107 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b122 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b122 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b123 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b123 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b124 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b124 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b125 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b125 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b126 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b126 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b141 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b141 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b142 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b142 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b144 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b144 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b145 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b145 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b160 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b160 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b161 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b161 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b162 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b162 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b163 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b163 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b164 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b164 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b179 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b179 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b180 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b180 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b181 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b181 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b182 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b182 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b183 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b183 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 143
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/143
function gomoku:ai/score/143
function gomoku:ai/consider
