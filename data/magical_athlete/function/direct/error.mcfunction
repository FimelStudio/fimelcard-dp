function magical_athlete:hud/notice {"text":{"text":"操作未完成：请检查当前阶段、行动顺序和可选目标。","color":"red"}}
execute if score #error ma_ctx matches 1 run function magical_athlete:hud/notice {"text":{"text":"对局状态不可用。","color":"red"}}
execute if score #error ma_ctx matches 2 run function magical_athlete:hud/notice {"text":{"text":"你不在本局名单中。","color":"red"}}
execute if score #error ma_ctx matches 3 run function magical_athlete:hud/notice {"text":{"text":"局面已变化，请重新选择。","color":"red"}}
execute if score #error ma_ctx matches 4 run function magical_athlete:hud/notice {"text":{"text":"当前不轮到你，或目标不在可选范围。","color":"red"}}
execute if score #error ma_ctx matches 5 run function magical_athlete:hud/notice {"text":{"text":"本场已结束。","color":"red"}}
execute if score #error ma_ctx matches 6 run function magical_athlete:hud/notice {"text":{"text":"这名选手当前不能行动，或行动顺序不符。","color":"red"}}
execute if score #error ma_ctx matches 7 run function magical_athlete:hud/notice {"text":{"text":"目标不在当前技能的可选范围。","color":"red"}}
execute if score #error ma_ctx matches 8 run function magical_athlete:hud/notice {"text":{"text":"这名角色当前不可选。","color":"red"}}
execute if score #error ma_ctx matches 9 run function magical_athlete:hud/notice {"text":{"text":"当前阶段不能执行这项操作。","color":"red"}}
execute if score #error ma_ctx matches 10 run function magical_athlete:hud/notice {"text":{"text":"操作数据已过期，请重新选择。","color":"red"}}
execute if score #error ma_ctx matches 13 run function magical_athlete:hud/notice {"text":{"text":"有玩家离线，整桌已暂停。","color":"red"}}
