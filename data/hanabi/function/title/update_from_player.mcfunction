# 当前执行者是需要同步物品栏的玩家；找到所属控制器后统一刷新本桌各观察者面板。
scoreboard players operation #ctx_id hb_ctx = @s hb_id
execute as @e[type=minecraft:marker,tag=hb.controller,scores={hb_state=2}] if score @s hb_id = #ctx_id hb_ctx at @s run function hanabi:title/update_all
