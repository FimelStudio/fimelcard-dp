# 提示册、密码选择与结算会由本模块的阶段函数驱动；离线时安全结束本局。
# 普通玩家通过设置对话框提交的trigger只在非零时处理；0表示取消。
execute as @a[scores={dc_settings=1..}] run function decrypto:settings/save
scoreboard players add #clock dc_ctx 1
execute if score #clock dc_ctx matches 10.. as @e[type=minecraft:marker,tag=dc.controller] at @s run function decrypto:system/maintenance
execute if score #clock dc_ctx matches 10.. run scoreboard players set #clock dc_ctx 0
# 加密对话框工具按实际丢出者识别，不占用拦截/解密染料。
execute as @e[type=minecraft:item] at @s if items entity @s contents minecraft:purple_dye[minecraft:custom_data~{decrypto:{tool:'prompt'}}] run function decrypto:prompt/drop
# 丢弃统计可能在重载或物品规则变化后漏报；附近存在掉落物时主动扫描兜底。
execute as @a[tag=dc.player] at @s if entity @e[type=minecraft:item,distance=..3] run function decrypto:input/find_drop
execute as @a[tag=dc.player,scores={dc_drop=1..}] at @s run function decrypto:input/find_drop
execute as @a[tag=dc.player,scores={dc_drop_book=1..}] at @s run function decrypto:input/find_note_drop
execute as @a[tag=dc.player,scores={dc_drop_guess=1..}] at @s run function decrypto:input/find_drop
execute as @e[type=minecraft:marker,tag=dc.controller] unless score @s dc_state matches 5..8 run function decrypto:input/clear_guess
execute as @a[tag=dc.player,scores={dc_action=1..}] run function decrypto:action/handle

# 只有内容超过两行时计时，每5秒刷新显示页。
execute as @e[type=minecraft:marker,tag=dc.controller,scores={dc_state=1..8,dc_pages=2..}] at @s run function decrypto:title/page_tick
