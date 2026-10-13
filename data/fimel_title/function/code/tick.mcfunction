# 离线玩家重连时补做旧版面板迁移；新安装世界不读取外部状态。
execute if score #legacy fv_ctx matches 1 as @a[tag=ct.player,tag=!fimel.vendor_migrated] run function fimel_vendor:migrate_player
# 本包退出界面后恢复外部 BetterTitle 的面板。
execute as @a[tag=fimel.bt_paused] unless score @s fbt_panel matches 1.. run function fimel_vendor:hud/release

# 26.2 不再接受空列表作为文本组件；仅对已经绑定有效面板的玩家发送 Actionbar
# 分层测试时暂时放行原版 Actionbar，便于把数据问题和着色器问题拆开检查
execute as @a[tag=!hb.title_test_direct,scores={fbt_panel=1..}] run function fimel_title:code/player_tick
