# Q丢纸统计和附近物品扫描都只作事件入口；真正对象必须匹配本桌、本座位的花火手牌
scoreboard players set @s hb_drop_card 0
tag @e[tag=hb.dropped_owned] remove hb.dropped_owned
scoreboard players set #drop_found hb_ctx 0
execute store result storage hanabi:input table int 1 run scoreboard players get @s hb_id
execute store result storage hanabi:input seat int 1 run scoreboard players get @s hb_seat
function hanabi:input/find_card_drop with storage hanabi:input
execute unless entity @e[tag=hb.dropped_owned,limit=1] run return 0

scoreboard players set #slot hb_ctx 0
execute if items entity @e[tag=hb.dropped_owned,limit=1] contents minecraft:paper[minecraft:custom_data~{hanabi:{slot:1}}] run scoreboard players set #slot hb_ctx 1
execute if items entity @e[tag=hb.dropped_owned,limit=1] contents minecraft:paper[minecraft:custom_data~{hanabi:{slot:2}}] run scoreboard players set #slot hb_ctx 2
execute if items entity @e[tag=hb.dropped_owned,limit=1] contents minecraft:paper[minecraft:custom_data~{hanabi:{slot:3}}] run scoreboard players set #slot hb_ctx 3
execute if items entity @e[tag=hb.dropped_owned,limit=1] contents minecraft:paper[minecraft:custom_data~{hanabi:{slot:4}}] run scoreboard players set #slot hb_ctx 4
execute if items entity @e[tag=hb.dropped_owned,limit=1] contents minecraft:paper[minecraft:custom_data~{hanabi:{slot:5}}] run scoreboard players set #slot hb_ctx 5
kill @e[tag=hb.dropped_owned,limit=1]

execute unless score #slot hb_ctx matches 1..5 run function hanabi:hand/sync
execute unless score #slot hb_ctx matches 1..5 run return 0
# 非本人回合时销毁掉落副本，再从权威手牌标记恢复，等效于无法丢弃
execute unless entity @s[tag=hb.turn] run function hanabi:hand/sync
execute unless entity @s[tag=hb.turn] run return 0

# 本人回合中，Q始终对应弃牌动作；未满时返还1枚提示标记，已满时保持上限
scoreboard players operation @s hb_action = #slot hb_ctx
scoreboard players add @s hb_action 200
function hanabi:action/handle
execute if entity @s[tag=hb.player] run function hanabi:hand/sync
