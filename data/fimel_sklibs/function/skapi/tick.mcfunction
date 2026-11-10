# uninstall-guard: begin (tools/build_uninstall.py)
execute if data storage cardtable:uninstall active run return 0
execute unless score #version ct_ctx matches 1.. run return 0
# uninstall-guard: end
execute as @e[scores={fcs_life=0..}] run function fimel_sklibs:skapi/deathtimer/_tick
