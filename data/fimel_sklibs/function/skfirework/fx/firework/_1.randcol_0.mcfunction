
execute store result score in.len fcs_fw run data get storage fimel_sklibs:firework temp.input02.colors
scoreboard players remove in.len fcs_fw 1


execute store result storage fimel_sklibs:firework temp.args02_01.len int 1 run scoreboard players get in.len fcs_fw

function fimel_sklibs:skfirework/fx/firework/_1.randcol_1 with storage fimel_sklibs:firework temp.args02_01
