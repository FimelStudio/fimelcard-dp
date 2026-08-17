# 第八版牌桌：中央菜单改为通用“游戏设置”，具体dialog由当前游戏模块提供
scoreboard players operation #ctx_id ct_ctx = @s ct_id
tag @e[tag=ct.migrate_seat] remove ct.migrate_seat
execute as @e[type=minecraft:interaction,tag=ct.seat] if score @s ct_id = #ctx_id ct_ctx run tag @s add ct.migrate_seat

# 继续把旧座椅稳定在Y+0.17，兼容尚未执行第七版迁移的牌桌
tp @e[type=minecraft:interaction,tag=ct.migrate_seat,scores={ct_seat=1}] ~ ~0.17 ~-2
tp @e[type=minecraft:interaction,tag=ct.migrate_seat,scores={ct_seat=2}] ~2 ~0.17 ~
tp @e[type=minecraft:interaction,tag=ct.migrate_seat,scores={ct_seat=3}] ~ ~0.17 ~2
tp @e[type=minecraft:interaction,tag=ct.migrate_seat,scores={ct_seat=4}] ~-2 ~0.17 ~
execute as @e[type=minecraft:interaction,tag=ct.migrate_seat] run data merge entity @s {height:0.372f}
tag @e[tag=ct.migrate_seat] remove ct.migrate_seat

execute if score @s ct_state matches 0 run function cardtable:game/init_selected
execute if score @s ct_state matches 0 run function cardtable:menu/render
execute if score @s ct_state matches 1 run function cardtable:vote/render
data merge entity @s {data:{cardtable:{menu_version:8}}}
