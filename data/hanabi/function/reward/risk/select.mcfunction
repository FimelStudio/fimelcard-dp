# 当前执行者是控制器；#action为1300..1302
scoreboard players operation #risk_amount hb_ctx = #action hb_ctx
scoreboard players remove #risk_amount hb_ctx 1300
execute unless score #risk_amount hb_ctx matches 0..2 run return run function hanabi:reward/risk/open

scoreboard players operation @s hb_clues += #risk_amount hb_ctx
execute if score @s hb_clues > @s hb_clue_max run scoreboard players operation @s hb_clues = @s hb_clue_max
scoreboard players operation @s hb_strikes += #risk_amount hb_ctx
function hanabi:player/tag_audience
tellraw @a[tag=hb.audience] [{text:"[花火] 奖励牌：",color:"light_purple"},{text:"风险调整",color:"red",bold:true},{text:"——提示与失误同时增加 ",color:"gray"},{score:{name:"#risk_amount",objective:"hb_ctx"},color:"gold"},{text:"。",color:"gray"}]
playsound minecraft:block.note_block.bass master @a[tag=hb.audience] ~ ~ ~ 0.9 0.75
execute if score #risk_amount hb_ctx matches 1.. run playsound minecraft:entity.firework_rocket.twinkle master @a[tag=hb.audience] ~ ~ ~ 0.7 1.25
function hanabi:hud/update

# 风险牌可以当场把失误推到上限；此时立即失败，不再补牌或推进回合
execute if score @s hb_strikes >= @s hb_strike_max run scoreboard players set @s hb_reason 1
execute if score @s hb_reason matches 1 run tag @a[tag=hb.action_actor,limit=1] remove hb.reward_pending
execute if score @s hb_reason matches 1 run scoreboard players set @s hb_reward_pending 0
execute if score @s hb_reason matches 1 run scoreboard players set @s hb_pending_slot 0
execute if score @s hb_reason matches 1 run function hanabi:log {text:"风险调整奖励使失误达到上限，游戏立即失败"}
execute if score @s hb_reason matches 1 run return run function hanabi:game/finish

function hanabi:log {text:"风险调整奖励已完成，继续原回合"}
function hanabi:reward/finish
