$execute unless data entity @s data.skull.seats.s$(seat).owned[{slot:$(slot)}] run return 0
$data modify storage skull:io removed set from entity @s data.skull.seats.s$(seat).owned[{slot:$(slot)}]
$data remove entity @s data.skull.seats.s$(seat).owned[{slot:$(slot)}]
# 无论这张牌原来在手中还是已扣下，都永久失去，内容只告知挑战者。
$data remove entity @s data.skull.seats.s$(seat).hand[{slot:$(slot)}]
function skull:player/audience
scoreboard players operation #lead sk_ctx = @s sk_lead
execute as @a[tag=sk.audience] if score @s sk_seat = #lead sk_ctx run tellraw @s [{text:"[仅你可见] 永久弃置：",color:"red"},{nbt:"removed.name",storage:"skull:io"}]
execute as @a[tag=sk.audience] if score @s sk_seat = #lead sk_ctx run scoreboard players remove @s sk_left 1
execute as @a[tag=sk.audience] if score @s sk_seat = #lead sk_ctx run function skull:hand/sync
execute if entity @a[tag=sk.audience,scores={sk_left=0}] run scoreboard players remove @s sk_players 1
execute as @a[tag=sk.audience,scores={sk_left=0}] run function skull:player/eliminate
function cardtable:table/recount_players
function skull:round/settle
