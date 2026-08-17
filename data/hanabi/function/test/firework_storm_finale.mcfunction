# 独立测试：模拟六组全部完成的30分彩色风暴终场烟花
execute summon minecraft:marker run function hanabi:test/firework_storm_finale/run
tellraw @s [{text:"[花火烟花测试] ",color:"light_purple"},{text:"已模拟30分彩色风暴终场，效果约5秒。",color:"green"}]
