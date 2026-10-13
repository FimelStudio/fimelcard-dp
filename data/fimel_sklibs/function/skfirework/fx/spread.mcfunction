
$data modify storage fimel_sklibs:firework temp.input01 set value $(config)

# 循环次数
execute store result score in.n fcs_fw run data get storage fimel_sklibs:firework temp.input01.n

# 俯仰角随机数，偏航角随机数，飞行时间随机数
data modify storage fimel_sklibs:firework temp.args01_a set value {pitch0:-180,pitch1:180,yaw0:-90,yaw1:-20,t0:20,t1:60}
data modify storage fimel_sklibs:firework temp.args01_a.pitch0 set from storage fimel_sklibs:firework temp.input01.pitch[0]
data modify storage fimel_sklibs:firework temp.args01_a.pitch1 set from storage fimel_sklibs:firework temp.input01.pitch[1]
data modify storage fimel_sklibs:firework temp.args01_a.yaw0 set from storage fimel_sklibs:firework temp.input01.yaw[0]
data modify storage fimel_sklibs:firework temp.args01_a.yaw1 set from storage fimel_sklibs:firework temp.input01.yaw[1]
data modify storage fimel_sklibs:firework temp.args01_a.t0 set from storage fimel_sklibs:firework temp.input01.t[0]
data modify storage fimel_sklibs:firework temp.args01_a.t1 set from storage fimel_sklibs:firework temp.input01.t[1]

# 初速度，重力加速度
data modify storage fimel_sklibs:firework temp.args01.v set value 0.4
data modify storage fimel_sklibs:firework temp.args01.g set value 0.01
data modify storage fimel_sklibs:firework temp.args01.v set from storage fimel_sklibs:firework temp.input01.v
data modify storage fimel_sklibs:firework temp.args01.g set from storage fimel_sklibs:firework temp.input01.g

# 运行命令
# function fimel_sklibs:skfirework/fx/firework {config:{shape:0,colors:[{from:[I;0],to:[I;9999999]},{from:[I;11743532,49151],to:[I;114514,1919810]}],n:1}}
data modify storage fimel_sklibs:firework temp.args01.cmdv set value []
data modify storage fimel_sklibs:firework temp.args01.cmdv set from storage fimel_sklibs:firework temp.input01.cmdv
data modify storage fimel_sklibs:firework temp.args01.cmdv append value {cmd:"kill @s"}
data modify storage fimel_sklibs:firework temp.args01.tick_cmdv set value []
data modify storage fimel_sklibs:firework temp.args01.tick_cmdv set from storage fimel_sklibs:firework temp.input01.tick_cmdv


function fimel_sklibs:skfirework/fx/spread/_0
