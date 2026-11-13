# 执行位置为赢家真实座椅或赢家本人；每次入口至多发射一次。
execute unless score #u_fw_done un_ctx matches 0 run return 0
scoreboard players set #u_fw_done un_ctx 1
# 直接使用 SK Firework 公开接口；四色球升空后爆炸，不复制库的实现。
# 标签与桌号属于本桌，烟花自然结束，无需按距离删除任何其他特效。
tag @e[type=minecraft:firework_rocket,tag=un.firework.new] remove un.firework.new
playsound minecraft:entity.firework_rocket.launch master @a[distance=..32] ~ ~1 ~ 0.9 1.1
execute positioned ~ ~1 ~ run function fimel_sklibs:skfirework/fx/firework {config:{life:20,shape:1,colors:{from:[I;16733525,16777045,5635925,5592575],to:[I;16777215]},n:1,trail:true,twinkle:true,tags:["un.firework","un.firework.new"]}}
scoreboard players operation @e[type=minecraft:firework_rocket,tag=un.firework.new] ct_id = #u_fw_table un_ctx
scoreboard players operation @e[type=minecraft:firework_rocket,tag=un.firework.new] un_seat = #u_fw_seat un_ctx
tag @e[type=minecraft:firework_rocket,tag=un.firework.new] remove un.firework.new
return 1
