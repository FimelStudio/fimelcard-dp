
scoreboard players remove @s fcs_fw_time 1
# tellraw @a [{"type": "score","score": {"name": "@s","objective": "fcs_fw_time"}},{"type": "nbt","entity": "@s","nbt":"UUID"},{"color": "aqua","type": "text","text":"OOO"},{"type": "nbt","entity": "@s","nbt":"Life"}]
execute if score @s fcs_fw_time matches ..1 run function fimel_sklibs:skfirework/fx/launch/_tick_1.runc with entity @s
