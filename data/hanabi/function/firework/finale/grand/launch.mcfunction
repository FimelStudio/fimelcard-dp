# colors 是 start 根据本局实际接牌颜色动态构造的列表，SK Firework 会为每条分枝随机选取其中一组。

$function sklibs:skfirework/fx/launch {config:{life:$(grand_life),cmdv:[{cmd:"playsound minecraft:entity.firework_rocket.large_blast master @a[distance=..64] ~ ~ ~ 1.35 0.82"},{cmd:"function sklibs:skfirework/fx/spread",args:{config:{pitch:[-180,180],yaw:[-80,-18],t:[$(t0),$(t1)],n:$(grand_branches),v:$(v),g:$(g),tick_cmdv:[{cmd:"particle minecraft:firework ~ ~ ~ 0 0 0 0 2 force"}],cmdv:[{cmd:"function sklibs:skfirework/fx/firework",args:{config:{shape:$(grand_shape),colors:$(colors),n:1,trail:true,twinkle:true}}}]}}}]}}
