execute unless score #count ma_ctx matches 1.. run return 0
data modify storage magical_athlete:engine s.pool append from storage magical_athlete:engine s.deck[0]
data remove storage magical_athlete:engine s.deck[0]
scoreboard players remove #count ma_ctx 1
function magical_athlete:engine/draft/deal
