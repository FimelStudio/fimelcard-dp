scoreboard players set #owned_drop dc_ctx 0
execute on origin if entity @s[tag=dc.sync_drop_owner] run scoreboard players set #owned_drop dc_ctx 1
execute unless score #owned_drop dc_ctx matches 1 run return 0
scoreboard players set #has_owned_drop dc_ctx 1
kill @s
