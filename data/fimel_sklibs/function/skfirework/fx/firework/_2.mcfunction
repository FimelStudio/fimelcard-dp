

execute summon firework_rocket run function fimel_sklibs:skfirework/fx/firework/_3.summ with storage fimel_sklibs:firework temp.args02

scoreboard players remove in.n1 fcs_fw 1
execute if score in.n1 fcs_fw matches 1.. run function fimel_sklibs:skfirework/fx/firework/_2
