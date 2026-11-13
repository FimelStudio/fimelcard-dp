# 椅子数量与固定座号布局；重载回收未完成的临时重排标记。
scoreboard objectives add ct_chairs dummy
scoreboard objectives add ct_clmask dummy
scoreboard objectives add ct_clver dummy
scoreboard objectives add ct_c1 dummy
scoreboard objectives add ct_c2 dummy
scoreboard objectives add ct_c3 dummy
scoreboard objectives add ct_c4 dummy
scoreboard objectives add ct_c5 dummy
scoreboard objectives add ct_c6 dummy
scoreboard objectives add ct_c7 dummy
scoreboard objectives add ct_c8 dummy
tag @e[tag=ct.layout_busy] remove ct.layout_busy
tag @a[tag=ct.layout_remount] remove ct.layout_remount
