
$data modify storage fimel_sklibs:arrays temp.runcmdv set from storage fimel_sklibs:firework temp.laucmds[{uuid:"$(UUID)"}].cmds
execute at @s run function fimel_sklibs:skapi_arrays/runcmdv
$data remove storage fimel_sklibs:firework temp.laucmds[{uuid:"$(UUID)"}]
tag @s remove fimel.skfirework.lau
