
# TEST

# summon minecraft:firework_rocket ~ ~1 ~ {LifeTime:10,Life:0,FireworksItem:{id:"minecraft:firework_rocket",count:1,components:{"minecraft:fireworks":{explosions:[{colors:[I;11743532],shape:"small_ball"}]}}}}

# summon minecraft:firework_rocket ~ ~1 ~ {LifeTime:0,Life:0,FireworksItem:{id:"minecraft:firework_rocket",count:1,components:{"minecraft:fireworks":{explosions:[{colors:[I;11743532,49151],fade_colors:[I;114514,1919810],shape:"creeper",has_twinkle:0}]}}}}


# function fimel_sklibs:skfirework/fx/firework {config:{shape:0,colors:{from:[I;11743532,49151],to:[I;114514,1919810]}}}


# function fimel_sklibs:skfirework/fx/firework {config:{life:20,shape:-1}}

$data modify storage fimel_sklibs:firework temp.input02 set value $(config)

# shape=-1 是 launch 使用的无爆炸升空空壳，不能进入普通烟花的随机颜色流程。
execute if data storage fimel_sklibs:firework temp.input02{shape:-1} run return run function fimel_sklibs:skfirework/fx/firework/_0.launch_shell

data modify storage fimel_sklibs:firework temp.args02_02 set value {}

execute unless data storage fimel_sklibs:firework temp.input02.colors.from run function fimel_sklibs:skfirework/fx/firework/_1.randcol_0

data modify storage fimel_sklibs:firework temp.args02_02.colors set from storage fimel_sklibs:firework temp.input02.colors.from
data modify storage fimel_sklibs:firework temp.args02_02.fade_colors set from storage fimel_sklibs:firework temp.input02.colors.to

data modify storage fimel_sklibs:firework temp.args02_02.has_trail set from storage fimel_sklibs:firework temp.input02.trail
data modify storage fimel_sklibs:firework temp.args02_02.has_twinkle set from storage fimel_sklibs:firework temp.input02.twinkle

execute if data storage fimel_sklibs:firework temp.input02{shape:0} run data modify storage fimel_sklibs:firework temp.args02_02.shape set value "small_ball"
execute if data storage fimel_sklibs:firework temp.input02{shape:1} run data modify storage fimel_sklibs:firework temp.args02_02.shape set value "large_ball"
execute if data storage fimel_sklibs:firework temp.input02{shape:2} run data modify storage fimel_sklibs:firework temp.args02_02.shape set value "star"
execute if data storage fimel_sklibs:firework temp.input02{shape:3} run data modify storage fimel_sklibs:firework temp.args02_02.shape set value "creeper"
execute if data storage fimel_sklibs:firework temp.input02{shape:4} run data modify storage fimel_sklibs:firework temp.args02_02.shape set value "burst"

data modify storage fimel_sklibs:firework temp.args02 set value {s:{Tags:[],LifeTime:0,Life:0,FireworksItem:{id:"minecraft:firework_rocket",count:1,components:{"minecraft:fireworks":{explosions:[]}}}}}
data modify storage fimel_sklibs:firework temp.args02.s.LifeTime set from storage fimel_sklibs:firework temp.input02.life
data modify storage fimel_sklibs:firework temp.args02.s.Tags set from storage fimel_sklibs:firework temp.input02.tags
data modify storage fimel_sklibs:firework temp.args02.s.FireworksItem.components."minecraft:fireworks".explosions append from storage fimel_sklibs:firework temp.args02_02

execute store result score in.n1 fcs_fw run data get storage fimel_sklibs:firework temp.input02.n 1

function fimel_sklibs:skfirework/fx/firework/_2
