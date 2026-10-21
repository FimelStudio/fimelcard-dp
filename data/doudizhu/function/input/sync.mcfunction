scoreboard players operation #tool_table dd_ctx = @s dd_id
scoreboard players operation #tool_turn dd_ctx = @s dd_turn
scoreboard players operation #tool_phase dd_ctx = @s dd_state
execute if score @s dd_state matches 2 if score @s dd_bidmode matches 2 run scoreboard players set #tool_turn dd_ctx -1
execute as @a[tag=dd.player] if score @s dd_id = #tool_table dd_ctx run function doudizhu:input/sync_player
