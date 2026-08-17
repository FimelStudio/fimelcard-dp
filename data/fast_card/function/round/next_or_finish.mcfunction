# 尚未达到总局数时播放下一局过场，否则进入最终排行
execute if score @s fc_round < @s fc_max run function fast_card:log {text:"尚未达到总局数，准备开始下一局"}
execute if score @s fc_round < @s fc_max run return run function fast_card:round/begin
function fast_card:log {text:"已达到总局数，进入最终排行"}
function fast_card:game/finish
