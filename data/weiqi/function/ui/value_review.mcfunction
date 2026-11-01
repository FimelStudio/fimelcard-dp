scoreboard players set #ui_value go_ctx 0
execute if score @e[tag=go.current,limit=1] go_review = @e[tag=go.current,limit=1] go_review run scoreboard players operation #ui_value go_ctx = @e[tag=go.current,limit=1] go_review
execute store result storage weiqi:ui review int 1 run scoreboard players get #ui_value go_ctx
