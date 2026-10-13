

# detect
execute as @e[type=marker,tag=fimel.skfirework.load] at @s run function fimel_sklibs:skfirework/spawn_egg/load with entity @s data

# launch tick
execute as @e[type=minecraft:firework_rocket,tag=fimel.skfirework.lau] run function fimel_sklibs:skfirework/fx/launch/_tick_0

# Trigger
scoreboard players enable @a fcs_fw_trigger
execute as @a[scores={fcs_fw_trigger=1}] run function fimel_sklibs:skfirework/ui/give/from_ui1


