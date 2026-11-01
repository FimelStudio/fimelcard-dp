scoreboard players set #ui_value go_ctx 0
execute if score @e[tag=go.current,limit=1] go_bcap = @e[tag=go.current,limit=1] go_bcap run scoreboard players operation #ui_value go_ctx = @e[tag=go.current,limit=1] go_bcap
execute store result storage weiqi:ui bcap int 1 run scoreboard players get #ui_value go_ctx
