scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run function liars_holdem:player/protect
# 正常回合切换会立即全桌清理；此处每秒再回收一次非当前玩家的异常残留操作物品
execute as @a[tag=lh.player,tag=!lh.turn] if score @s lh_id = #ctx_id lh_ctx run function liars_holdem:util/clear_items_actions

# 每个仍存活的座位都必须能找到对应在线玩家；找不到时直接淘汰该座位并继续游戏
function liars_holdem:system/check_seat {seat:1,alive:"lh_a1"}
function liars_holdem:system/check_seat {seat:2,alive:"lh_a2"}
function liars_holdem:system/check_seat {seat:3,alive:"lh_a3"}
function liars_holdem:system/check_seat {seat:4,alive:"lh_a4"}

# 游戏进行阶段每秒按座位核对子弹实体；正常时只读记分，不重建实体
execute if score @s lh_state matches 1..15 run function liars_holdem:hud/ensure
