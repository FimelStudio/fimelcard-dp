# 26.2 独立测试：模拟18分、五色均有进度的第四档终场烟花。

execute summon minecraft:marker run function hanabi:test/firework_finale/run
tellraw @s [{text:"[花火烟花测试] ",color:"light_purple"},{text:"已模拟18分五色终场，完整效果约4秒。",color:"green"}]
