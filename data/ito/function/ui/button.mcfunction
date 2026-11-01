execute store result storage ito:ui action int 1 run scoreboard players get #button it_ctx
function ito:ui/button_value with storage ito:ui
data modify storage ito:ui button.label.text set from storage ito:ui label
data modify storage ito:ui dialog.actions append from storage ito:ui button
