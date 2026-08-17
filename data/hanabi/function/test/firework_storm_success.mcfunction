# 独立测试：在执行者位置上方播放一次“成功接上彩色5”的五色烟花
execute positioned ~ ~0.35 ~ summon minecraft:marker run function hanabi:test/firework_storm_success/run
tellraw @s [{text:"[花火烟花测试] ",color:"light_purple"},{text:"已模拟成功接上彩色5。",color:"green"}]
