
$scoreboard players set infoType fcs_arr_tmp $(type)

$execute if score infoType fcs_arr_tmp matches 0 run tellraw @s "\u00a77[Skapi Array] [DEBUG] $(text)"
$execute if score infoType fcs_arr_tmp matches 1 run tellraw @s "\u00a7f[Skapi Array] [INFO] $(text)"
$execute if score infoType fcs_arr_tmp matches 2 run tellraw @s "\u00a7e[Skapi Array] [WARNING] $(text)"
$execute if score infoType fcs_arr_tmp matches 3 run tellraw @s "\u00a7c[Skapi Array] [ERROR] $(text)"
$execute if score infoType fcs_arr_tmp matches 4 run tellraw @s "\u00a74[Skapi Array] [CRITICAL] $(text)"

execute if score infoType fcs_arr_tmp matches 2..4 run return 0