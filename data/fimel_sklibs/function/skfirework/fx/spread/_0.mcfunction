

function fimel_sklibs:skfirework/fx/spread/_0.macro_0 with storage fimel_sklibs:firework temp.args01_a

execute summon marker run function fimel_sklibs:skfirework/fx/spread/_1.summ with storage fimel_sklibs:firework temp.args01

scoreboard players remove in.n fcs_fw 1
execute if score in.n fcs_fw matches 1.. run function fimel_sklibs:skfirework/fx/spread/_0

