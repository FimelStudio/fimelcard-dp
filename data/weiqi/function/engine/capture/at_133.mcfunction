execute as @e[tag=go.board,scores={go_sq=134},limit=1] unless score @s go_eff matches 0 unless score @s go_eff = #side go_ctx run function weiqi:engine/capture/group
execute as @e[tag=go.board,scores={go_sq=114},limit=1] unless score @s go_eff matches 0 unless score @s go_eff = #side go_ctx run function weiqi:engine/capture/group
execute as @e[tag=go.board,scores={go_sq=152},limit=1] unless score @s go_eff matches 0 unless score @s go_eff = #side go_ctx run function weiqi:engine/capture/group
