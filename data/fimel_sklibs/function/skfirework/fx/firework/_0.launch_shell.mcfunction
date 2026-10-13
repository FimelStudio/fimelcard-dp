# launch 专用的无爆炸升空空壳；保留公开 API 原有的 FireworksItem 与标签结构。

data modify storage fimel_sklibs:firework temp.args02 set value {s:{Tags:[],LifeTime:0,Life:0,FireworksItem:{id:"minecraft:firework_rocket",count:1,components:{"minecraft:fireworks":{explosions:[]}}}}}
data modify storage fimel_sklibs:firework temp.args02.s.LifeTime set from storage fimel_sklibs:firework temp.input02.life
data modify storage fimel_sklibs:firework temp.args02.s.Tags set from storage fimel_sklibs:firework temp.input02.tags
scoreboard players set in.n1 fcs_fw 1
function fimel_sklibs:skfirework/fx/firework/_2
return 1
