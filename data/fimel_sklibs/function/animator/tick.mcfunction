# uninstall-guard: begin (tools/build_uninstall.py)
execute if data storage cardtable:uninstall active run return 0
execute unless score #version ct_ctx matches 1.. run return 0
# uninstall-guard: end
execute as @e[tag=fimel.skanimator.text] at @s run function fimel_sklibs:animator/tick/textanimator/_0
execute as @e[tag=fimel.skanimator.phy] at @s run function fimel_sklibs:animator/tick/physical/_0
