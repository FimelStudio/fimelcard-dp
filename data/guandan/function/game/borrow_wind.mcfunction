scoreboard players operation #wind_team gd_ctx = @s gd_team
execute as @e[tag=gd.board,scores={gd_rank=0}] if score @s gd_team = #wind_team gd_ctx run scoreboard players operation @e[tag=gd.current,limit=1] gd_turn = @s gd_seat
tellraw @a[tag=gd.audience] {text:"[掼蛋] 对家接风，重新领出。",color:"aqua"}
