
data modify storage fimel_sklibs:firework temp.laucmds append value {uuid:"",cmds:[]}
$data modify storage fimel_sklibs:firework temp.laucmds[-1].uuid set value "$(UUID)"
data modify storage fimel_sklibs:firework temp.laucmds[-1].cmds set from storage fimel_sklibs:firework temp.input03.cmdv

execute store result score @s fcs_fw_time run data get storage fimel_sklibs:firework temp.input03.life

tag @s remove fimel.skfirework.laut
