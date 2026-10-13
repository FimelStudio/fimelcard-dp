
$data modify storage fimel_sklibs:firework temp.input03 set value $(config)

data modify storage fimel_sklibs:firework temp.args03 set value {config:{shape:-1,life:0,tags:["fimel.skfirework.laut","fimel.skfirework.lau"]}}
data modify storage fimel_sklibs:firework temp.args03.config.life set from storage fimel_sklibs:firework temp.input03.life

function fimel_sklibs:skfirework/fx/firework with storage fimel_sklibs:firework temp.args03
execute as @e[tag=fimel.skfirework.laut] run function fimel_sklibs:skfirework/fx/launch/_0.summ with entity @s


# function fimel_sklibs:skfirework/fx/launch
