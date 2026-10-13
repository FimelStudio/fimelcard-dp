# 保持 SK Firework 的公开 API 参数结构，便于日后替换或继续升级前置。

$function fimel_sklibs:skfirework/fx/launch {config:{life:$(life),cmdv:[{cmd:"playsound minecraft:entity.firework_rocket.large_blast master @a[distance=..32] ~ ~ ~ 0.9 1.18"},{cmd:"function fimel_sklibs:skfirework/fx/firework",args:{config:{shape:$(shape),colors:{from:[I;$(primary),$(accent)],to:[I;$(fade)]},n:$(count),trail:true,twinkle:$(twinkle)}}}]}}
