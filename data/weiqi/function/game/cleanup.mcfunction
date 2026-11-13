function weiqi:system/context
scoreboard players set @s go_state 0
scoreboard players set @s go_sel -1
scoreboard players set @s go_undo 0
scoreboard players set @s go_autoplay 0
data modify entity @s data.weiqi.review set value 1b
execute store result score @s go_review run data get entity @s data.weiqi.history
scoreboard players remove @s go_review 1
function weiqi:ai/reset
function weiqi:visual/finish_move
execute as @e[type=minecraft:text_display,tag=go.clock] if score @s ct_id = #table go_ctx run kill @s
execute as @a[tag=go.audience] run scoreboard players set @s go_revelig 1
execute as @a[tag=go.audience] run scoreboard players operation @s go_reviewtable = @s ct_id
execute as @a[tag=go.audience] run function weiqi:input/give
execute as @e[type=minecraft:firework_rocket,tag=go.firework] if score @s ct_id = #table go_ctx run kill @s
function cardtable:game/return_lobby
