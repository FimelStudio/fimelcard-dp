# 三次失误导致0分时不放华丽烟花，以熄灭、卡响效果明确表现失败。

playsound minecraft:entity.firework_rocket.twinkle_far master @a[distance=..32] ~ ~ ~ 1.0 0.55
particle minecraft:smoke ~ ~1.1 ~ 0.45 0.25 0.45 0.025 34 force
particle minecraft:ash ~ ~1.25 ~ 0.55 0.3 0.55 0.015 22 force
function hanabi:log {text:"最终得分为0，播放熄火结算效果"}
