
scoreboard objectives add fcs_fw dummy
scoreboard objectives add fcs_fw_time dummy
scoreboard objectives add fcs_fw_trigger trigger

data modify storage fimel_sklibs:firework temp set value {}

kill @e[type=minecraft:marker,tag=fimel.skfirework.e]
# 重载会清空延时命令存储，因此同步清理尚未完成的升空烟花，避免残留实体反复读取空参数。
kill @e[type=minecraft:firework_rocket,tag=fimel.skfirework.lau]

function fimel_sklibs:skfirework/ui/init
