scoreboard players set #held sp_ctx 0
$execute store result score #part sp_ctx run data get storage splendor:engine state.p$(actor).tokens[0]
scoreboard players operation #held sp_ctx += #part sp_ctx
$execute store result score #part sp_ctx run data get storage splendor:engine state.p$(actor).tokens[1]
scoreboard players operation #held sp_ctx += #part sp_ctx
$execute store result score #part sp_ctx run data get storage splendor:engine state.p$(actor).tokens[2]
scoreboard players operation #held sp_ctx += #part sp_ctx
$execute store result score #part sp_ctx run data get storage splendor:engine state.p$(actor).tokens[3]
scoreboard players operation #held sp_ctx += #part sp_ctx
$execute store result score #part sp_ctx run data get storage splendor:engine state.p$(actor).tokens[4]
scoreboard players operation #held sp_ctx += #part sp_ctx
$execute store result score #part sp_ctx run data get storage splendor:engine state.p$(actor).tokens[5]
scoreboard players operation #held sp_ctx += #part sp_ctx
$execute store result storage splendor:engine state.p$(actor).token_count int 1 run scoreboard players get #held sp_ctx
$execute store result storage splendor:engine state.p$(actor).card_count int 1 run data get storage splendor:engine state.p$(actor).cards
