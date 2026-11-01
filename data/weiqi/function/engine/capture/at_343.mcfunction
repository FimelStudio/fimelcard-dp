execute as @e[tag=go.board,scores={go_sq=342},limit=1] unless score @s go_eff matches 0 unless score @s go_eff = #side go_ctx run function weiqi:engine/capture/group
execute as @e[tag=go.board,scores={go_sq=344},limit=1] unless score @s go_eff matches 0 unless score @s go_eff = #side go_ctx run function weiqi:engine/capture/group
execute as @e[tag=go.board,scores={go_sq=324},limit=1] unless score @s go_eff matches 0 unless score @s go_eff = #side go_ctx run function weiqi:engine/capture/group
