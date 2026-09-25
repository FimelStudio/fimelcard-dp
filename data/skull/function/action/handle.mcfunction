scoreboard players operation #submitted sk_ctx = @s sk_action
scoreboard players set @s sk_action 0
execute unless entity @s[tag=ct.player] run return 0
execute unless score @s ct_id = @s sk_id run return 0
execute unless score @s sk_ui_table = @s sk_id run return 0
scoreboard players operation #ctx sk_ctx = @s sk_id
tag @a[tag=sk.actor] remove sk.actor
tag @s add sk.actor
scoreboard players operation #actor_seat sk_ctx = @s sk_seat
scoreboard players operation #epoch sk_ctx = #submitted sk_ctx
scoreboard players operation #epoch sk_ctx /= #hundred sk_ctx
scoreboard players operation #choice sk_ctx = #submitted sk_ctx
scoreboard players operation #choice sk_ctx %= #hundred sk_ctx
execute store result storage skull:io action.seat int 1 run scoreboard players get @s sk_seat
execute as @e[type=minecraft:marker,tag=sk.controller] at @s if score @s sk_id = #ctx sk_ctx if score @s sk_epoch = #epoch sk_ctx run function skull:action/dispatch
execute if entity @s[tag=sk.player] run scoreboard players enable @s sk_action
tag @a[tag=sk.actor] remove sk.actor
tag @a[tag=sk.audience] remove sk.audience
