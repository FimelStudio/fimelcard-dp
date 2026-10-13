# 26.2 独立测试：升空约1秒后生成带踪迹、闪烁的五色星形烟花。

function fimel_sklibs:skfirework/fx/launch {config:{life:20,cmdv:[{cmd:"playsound minecraft:entity.firework_rocket.large_blast master @a[distance=..48] ~ ~ ~ 1.0 1.0"},{cmd:"function fimel_sklibs:skfirework/fx/firework",args:{config:{shape:2,colors:{from:[I;16777215,16733525,5592575,16777045,5635925],to:[I;16755200,5636095]},n:2,trail:true,twinkle:true}}}]}}
tellraw @s [{text:"[SK Firework 26.2 测试] ",color:"gold"},{text:"测试烟花已发射。",color:"green"}]
