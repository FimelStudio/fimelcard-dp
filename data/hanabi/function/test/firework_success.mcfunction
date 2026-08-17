# 26.2 独立测试：在执行者位置上方播放一次“成功接上蓝色5”的效果。

execute positioned ~ ~0.35 ~ summon minecraft:marker run function hanabi:test/firework_success/run
tellraw @s [{text:"[花火烟花测试] ",color:"light_purple"},{text:"已模拟成功接上蓝色5。",color:"green"}]
