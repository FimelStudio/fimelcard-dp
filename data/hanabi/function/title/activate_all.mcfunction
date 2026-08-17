# 当前执行者是花火控制器。
function hanabi:log {text:"开始为本桌玩家构建屏幕左侧手牌面板"}
scoreboard players operation #ctx_id hb_ctx = @s hb_id
execute as @a[tag=hb.player] if score @s hb_id = #ctx_id hb_ctx run function hanabi:title/activate_player
function hanabi:title/update_all
