scoreboard players set @s ma_pulse 0
scoreboard players set #announce ma_ctx 0
execute unless score @s ma_chatturn = @s ma_turn run scoreboard players set #announce ma_ctx 1
execute unless score @s ma_chatpending = @s ma_pending run scoreboard players set #announce ma_ctx 1
execute unless score @s ma_chatstate = @s ma_state run scoreboard players set #announce ma_ctx 1
execute store result score #chat_round ma_ctx run data get entity @s data.magical_athlete.round
execute unless score @s ma_chatround = #chat_round ma_ctx run scoreboard players set #announce ma_ctx 1
execute unless score #announce ma_ctx matches 1 run return 0
scoreboard players operation @s ma_chatturn = @s ma_turn
scoreboard players operation @s ma_chatpending = @s ma_pending
scoreboard players operation @s ma_chatstate = @s ma_state
scoreboard players operation @s ma_chatround = #chat_round ma_ctx
function magical_athlete:game/hud_show with entity @s data.magical_athlete
execute if score @s ma_pending matches 1.. run function magical_athlete:direct/chat_pending with entity @s data.magical_athlete.pending
