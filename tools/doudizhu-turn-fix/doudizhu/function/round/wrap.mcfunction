# 回到三名参与者中座号最小的一位，不受实体枚举顺序影响。
execute as @e[tag=dd.actors] run scoreboard players operation #next dd_ctx < @s dd_seat
