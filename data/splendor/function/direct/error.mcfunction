execute if score #error sp_ctx matches 1 run return run function splendor:hud/notice {"text":{"text":"当前没有可用的璀璨宝石对局。","color":"yellow"}}
execute if score #error sp_ctx matches 2 run return run function splendor:hud/notice {"text":{"text":"你不是这局的有效参与者。","color":"yellow"}}
execute if score #error sp_ctx matches 3 run return run function splendor:hud/notice {"text":{"text":"局面已更新，请重新选择。","color":"yellow"}}
execute if score #error sp_ctx matches 4 run return run function splendor:hud/notice {"text":{"text":"尚未轮到你行动。","color":"yellow"}}
execute if score #error sp_ctx matches 5 run return run function splendor:hud/notice {"text":{"text":"请先完成退珠或贵族选择；每回合只进行一次主行动。","color":"yellow"}}
execute if score #error sp_ctx matches 6 run return run function splendor:hud/notice {"text":{"text":"拿珠须选三色，或在该色库存至少四颗时拿两颗；不能直接拿黄金。","color":"yellow"}}
execute if score #error sp_ctx matches 7 run return run function splendor:hud/notice {"text":{"text":"退珠数量不正确，请恰好退到十颗。","color":"yellow"}}
execute if score #error sp_ctx matches 8 run return run function splendor:hud/notice {"text":{"text":"卡牌或牌堆已经用完，请重新选择。","color":"yellow"}}
execute if score #error sp_ctx matches 9 run return run function splendor:hud/notice {"text":{"text":"这个操作当前不可用。","color":"yellow"}}
execute if score #error sp_ctx matches 10 run return run function splendor:hud/notice {"text":{"text":"操作数据无效，请重新选择。","color":"yellow"}}
execute if score #error sp_ctx matches 11 run return run function splendor:hud/notice {"text":{"text":"最多同时预定三张发展卡，请先购买已有预定牌。","color":"yellow"}}
execute if score #error sp_ctx matches 12 run return run function splendor:hud/notice {"text":{"text":"宝石不足，无法支付这张发展卡的费用。","color":"yellow"}}
execute if score #error sp_ctx matches 13 run return run function splendor:hud/notice {"text":{"text":"有玩家离线，游戏暂停中。","color":"yellow"}}
execute if score #error sp_ctx matches 14 run return run function splendor:hud/notice {"text":{"text":"这位贵族的发展卡要求尚未满足。","color":"yellow"}}
function splendor:hud/notice {"text":{"text":"操作未完成，请重新选择。","color":"yellow"}}
