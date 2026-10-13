
data modify storage fimel_sklibs:animator temp.phycmds append value {uuid:"",cmds:[],tick:[]}
$data modify storage fimel_sklibs:animator temp.phycmds[-1].uuid set value "$(UUID)"
data modify storage fimel_sklibs:animator temp.phycmds[-1].cmds set from storage fimel_sklibs:animator temp.input.cmdv
data modify storage fimel_sklibs:animator temp.phycmds[-1].tick_cmds set from storage fimel_sklibs:animator temp.input.tick_cmdv
