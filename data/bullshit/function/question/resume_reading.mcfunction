execute unless score @s bw_state matches 1 run return 0
scoreboard players operation #ctx bw_ctx = @s bw_id
execute as @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx run function bullshit:question/open_answer
