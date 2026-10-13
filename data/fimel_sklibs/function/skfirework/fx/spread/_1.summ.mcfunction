
data modify entity @s NoGravity set value 1b
$data modify entity @s Rotation set value [$(pitch)f,$(yaw)f]
tag @s add fimel.skfirework.spd
tag @s add fimel.skfirework.e

$execute at @s run function fimel_sklibs:animator/new/physical {config:{v:$(v),g:$(g),t:$(t),cmdv:$(cmdv),tick_cmdv:$(tick_cmdv)}}

