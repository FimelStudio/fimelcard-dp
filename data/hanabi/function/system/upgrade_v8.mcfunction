# 第八版把道具牌从普通牌库移出，加入固定六张的独立奖励牌堆
scoreboard objectives add hb_reward_left dummy
scoreboard objectives add hb_reward_pending dummy

# 旧版运行中牌局的牌库结构无法无损转换；升级时安全返回牌桌大厅，避免旧道具被当作普通烟花牌
execute as @e[type=minecraft:marker,tag=hb.controller,scores={hb_state=1..3}] at @s run function hanabi:game/abort
scoreboard players set #version hb_ctx 8
tellraw @a [{text:"[花火] ",color:"light_purple"},{text:"奖励牌系统已升级：完成烟花序列后立即抽取并结算奖励。",color:"green"}]
