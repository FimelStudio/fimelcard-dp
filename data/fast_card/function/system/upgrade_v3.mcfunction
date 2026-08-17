# 第三版加入小局过场、逐张发牌和积分变化动画所需的状态记分项
# 不修改正在运行的牌桌状态；旧牌局会在下一次进入对应阶段时自动初始化
scoreboard objectives add fc_phase dummy
scoreboard objectives add fc_deal dummy
scoreboard objectives add fc_delta dummy
scoreboard players set #version fc_ctx 3
