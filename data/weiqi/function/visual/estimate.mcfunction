function weiqi:system/context
function weiqi:visual/context
function weiqi:visual/clear_estimate
scoreboard players operation #v_size go_ctx = @s go_size
scoreboard players set #v_sq go_ctx 0
scoreboard players set #v_row go_ctx 0
scoreboard players set #v_col go_ctx 0
scoreboard players set #v_owner go_ctx 0
scoreboard players set #v_start go_ctx 0
scoreboard players set #v_length go_ctx 0
function weiqi:visual/territory_scan
execute as @e[type=minecraft:marker,tag=go.board,scores={go_dead=1}] run function weiqi:visual/dead_marker
