# 新增通用游戏选择窗口；升级不改变牌桌和牌局状态。
scoreboard objectives add ct_game_pick trigger
scoreboard objectives add ct_pick_table dummy
scoreboard objectives add ct_pick_base dummy
scoreboard players set #pick_nonce ct_ctx 0
scoreboard players set #version ct_ctx 5
