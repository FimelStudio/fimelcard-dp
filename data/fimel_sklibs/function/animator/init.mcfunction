
# 清缓存
data modify storage fimel_sklibs:animator temp set value {}

# textanimator

    # 当前帧
    scoreboard objectives add fcs_an_frame dummy

    # 目标帧
    scoreboard objectives add fcs_an_target dummy

    # 颜色
    scoreboard objectives add fcs_an_color dummy

# physical

    # 视线方向速度，垂直方向速度，重力加速度
    scoreboard objectives add fcs_an_vx dummy
    scoreboard objectives add fcs_an_vy dummy
    scoreboard objectives add fcs_an_g dummy
    scoreboard objectives add fcs_an_t dummy

