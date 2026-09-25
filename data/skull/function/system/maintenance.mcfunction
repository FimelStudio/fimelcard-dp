function skull:player/audience
scoreboard players set #online sk_ctx 0
execute as @a[tag=sk.audience] if entity @s[tag=ct.player] if score @s ct_id = #ctx sk_ctx run scoreboard players add #online sk_ctx 1
execute unless score #online sk_ctx = @s sk_players run return run function skull:game/player_left
