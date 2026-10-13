

# 将当前帧转为16进制
scoreboard players operation dec.input fcs_math = @s fcs_an_frame
function fimel_sklibs:skapi_math/dec2hex
data modify storage fimel_sklibs:animator temp.args2.uni set from storage fimel_sklibs:math temp.hexString 

scoreboard players operation dec.input fcs_math = @s fcs_an_color
function fimel_sklibs:skapi_math/dec2hex
data modify storage fimel_sklibs:animator temp.args2.color set from storage fimel_sklibs:math temp.hexString 

function fimel_sklibs:animator/tick/textanimator/_1 with storage fimel_sklibs:animator temp.args2
data modify entity @s text set from storage fimel_sklibs:animator temp.text

scoreboard players add @s fcs_an_frame 1
execute if score @s fcs_an_frame = @s fcs_an_target run kill @s