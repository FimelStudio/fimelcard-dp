
scoreboard players operation dec._1 fcs_math = dec.input fcs_math
scoreboard players operation dec._2 fcs_math = dec.input fcs_math

scoreboard players operation dec._1 fcs_math %= 16 fcs_math

execute if score dec._1 fcs_math matches 0..9 run function fimel_sklibs:skapi_math/private/dec2hex/_2.0to9
execute if score dec._1 fcs_math matches 10..15 run function fimel_sklibs:skapi_math/private/dec2hex/_2.atof

scoreboard players operation dec._2 fcs_math /= 16 fcs_math
scoreboard players operation dec.input fcs_math = dec._2 fcs_math

execute if score dec.input fcs_math matches 1.. run function fimel_sklibs:skapi_math/private/dec2hex/_1
