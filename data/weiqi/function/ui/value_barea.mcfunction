scoreboard players set #ui_value go_ctx 0
execute if score @e[tag=go.current,limit=1] go_barea = @e[tag=go.current,limit=1] go_barea run scoreboard players operation #ui_value go_ctx = @e[tag=go.current,limit=1] go_barea
execute store result storage weiqi:ui barea int 1 run scoreboard players get #ui_value go_ctx
