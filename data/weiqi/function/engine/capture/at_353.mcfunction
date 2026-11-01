execute as @e[tag=go.board,scores={go_sq=352},limit=1] unless score @s go_eff matches 0 unless score @s go_eff = #side go_ctx run function weiqi:engine/capture/group
execute as @e[tag=go.board,scores={go_sq=354},limit=1] unless score @s go_eff matches 0 unless score @s go_eff = #side go_ctx run function weiqi:engine/capture/group
execute as @e[tag=go.board,scores={go_sq=334},limit=1] unless score @s go_eff matches 0 unless score @s go_eff = #side go_ctx run function weiqi:engine/capture/group
