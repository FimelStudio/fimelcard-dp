scoreboard objectives add dd_ctx dummy
execute unless score #version dd_ctx matches 1.. run function doudizhu:system/install
# 重载保留牌局；重新启用操作入口并恢复手牌显示。
execute as @a[tag=dd.player] run scoreboard players enable @s dd_action
