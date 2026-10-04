scoreboard players operation #tool_table dd_ctx = @s dd_id
scoreboard players operation #tool_turn dd_ctx = @s dd_turn
scoreboard players operation #tool_phase dd_ctx = @s dd_state
execute as @a[tag=dd.player] if score @s dd_id = #tool_table dd_ctx run function doudizhu:input/sync_player
