# 改名纸张、密码选择与结算会由本模块的阶段函数驱动；离线时安全结束本局。
experience set @a[tag=dc.player] 114514 levels
# 普通玩家通过设置对话框提交的trigger只在非零时处理；0表示取消。
execute as @a[scores={dc_settings=1..}] run function decrypto:settings/save
# 游戏期间始终保留一块完好的中央铁砧；铁砧被使用损坏或意外消失时自动恢复。
execute as @e[type=minecraft:marker,tag=dc.controller,scores={dc_state=1..8}] at @s unless block ~ ~1 ~ minecraft:anvil run setblock ~ ~1 ~ minecraft:anvil
execute as @e[type=minecraft:marker,tag=dc.controller] at @s unless entity @a[tag=dc.player] run function decrypto:game/abort
execute as @e[type=minecraft:marker,tag=dc.controller,scores={dc_state=1..8}] run function decrypto:hud/keywords
# 丢弃统计可能在重载或物品规则变化后漏报；附近存在掉落物时主动扫描兜底。
execute as @a[tag=dc.player] at @s if entity @e[type=minecraft:item,distance=..3] run function decrypto:input/find_drop
execute as @a[tag=dc.player,scores={dc_drop=1..}] at @s run function decrypto:input/find_drop
execute as @a[tag=dc.player,scores={dc_drop_book=1..}] at @s run function decrypto:input/find_note_drop
execute as @a[tag=dc.player,scores={dc_drop_guess=1..}] at @s run function decrypto:input/find_drop
execute as @e[type=minecraft:marker,tag=dc.controller] unless score @s dc_state matches 5..8 run function decrypto:input/clear_guess
execute as @a[tag=dc.player,scores={dc_action=1..}] run function decrypto:action/handle
