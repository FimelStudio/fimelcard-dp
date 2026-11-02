execute store result score #jp ca_ctx run data get storage catan:engine state.job.player
data modify storage catan:engine state.job.best set value 0
data modify storage catan:engine state.job.bits set value [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
data modify storage catan:engine state.job.stack set value []
scoreboard players set #nextbit ca_ctx 1
execute if score #eo0 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:0}
execute if score #eo1 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:1}
execute if score #eo2 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:2}
execute if score #eo3 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:3}
execute if score #eo4 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:4}
execute if score #eo5 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:5}
execute if score #eo6 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:6}
execute if score #eo7 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:7}
execute if score #eo8 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:8}
execute if score #eo9 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:9}
execute if score #eo10 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:10}
execute if score #eo11 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:11}
execute if score #eo12 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:12}
execute if score #eo13 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:13}
execute if score #eo14 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:14}
execute if score #eo15 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:15}
execute if score #eo16 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:16}
execute if score #eo17 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:17}
execute if score #eo18 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:18}
execute if score #eo19 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:19}
execute if score #eo20 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:20}
execute if score #eo21 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:21}
execute if score #eo22 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:22}
execute if score #eo23 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:23}
execute if score #eo24 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:24}
execute if score #eo25 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:25}
execute if score #eo26 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:26}
execute if score #eo27 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:27}
execute if score #eo28 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:28}
execute if score #eo29 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:29}
execute if score #eo30 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:30}
execute if score #eo31 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:31}
execute if score #eo32 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:32}
execute if score #eo33 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:33}
execute if score #eo34 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:34}
execute if score #eo35 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:35}
execute if score #eo36 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:36}
execute if score #eo37 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:37}
execute if score #eo38 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:38}
execute if score #eo39 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:39}
execute if score #eo40 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:40}
execute if score #eo41 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:41}
execute if score #eo42 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:42}
execute if score #eo43 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:43}
execute if score #eo44 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:44}
execute if score #eo45 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:45}
execute if score #eo46 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:46}
execute if score #eo47 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:47}
execute if score #eo48 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:48}
execute if score #eo49 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:49}
execute if score #eo50 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:50}
execute if score #eo51 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:51}
execute if score #eo52 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:52}
execute if score #eo53 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:53}
execute if score #eo54 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:54}
execute if score #eo55 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:55}
execute if score #eo56 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:56}
execute if score #eo57 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:57}
execute if score #eo58 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:58}
execute if score #eo59 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:59}
execute if score #eo60 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:60}
execute if score #eo61 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:61}
execute if score #eo62 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:62}
execute if score #eo63 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:63}
execute if score #eo64 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:64}
execute if score #eo65 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:65}
execute if score #eo66 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:66}
execute if score #eo67 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:67}
execute if score #eo68 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:68}
execute if score #eo69 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:69}
execute if score #eo70 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:70}
execute if score #eo71 ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {edge:71}
scoreboard players set #connected ca_ctx 0
execute if score #eo0 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo1 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:0,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo2 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo3 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:1,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo4 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo5 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:2,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo0 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo6 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:3,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo1 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo2 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo7 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:4,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo3 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo4 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo8 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:5,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo5 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo9 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:6,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo6 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo10 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo11 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:7,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo7 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo12 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo13 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:8,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo8 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo14 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo15 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:9,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo9 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo16 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo17 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:10,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo10 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo18 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:11,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo11 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo12 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo19 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:12,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo13 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo14 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo20 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:13,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo15 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo16 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo21 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:14,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo17 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo22 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:15,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo18 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo23 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo24 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:16,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo19 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo25 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo26 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:17,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo20 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo27 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo28 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:18,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo21 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo29 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo30 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:19,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo22 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo31 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo32 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:20,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo23 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo33 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:21,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo24 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo25 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo34 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:22,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo26 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo27 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo35 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:23,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo28 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo29 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo36 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:24,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo30 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo31 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo37 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:25,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo32 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo38 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:26,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo33 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo39 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:27,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo34 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo40 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo41 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:28,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo35 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo42 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo43 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:29,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo36 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo44 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo45 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:30,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo37 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo46 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo47 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:31,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo38 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo48 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:32,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo39 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo40 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo49 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:33,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo41 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo42 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo50 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:34,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo43 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo44 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo51 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:35,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo45 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo46 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo52 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:36,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo47 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo48 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo53 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:37,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo49 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo54 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:38,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo50 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo55 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo56 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:39,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo51 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo57 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo58 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:40,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo52 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo59 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo60 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:41,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo53 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo61 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:42,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo54 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo55 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo62 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:43,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo56 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo57 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo63 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:44,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo58 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo59 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo64 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:45,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo60 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo61 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo65 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:46,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo62 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo66 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:47,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo63 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo67 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo68 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:48,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo64 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo69 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo70 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:49,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo65 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo71 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:50,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo66 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo67 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:51,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo68 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo69 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:52,mask:0,length:0}
scoreboard players set #connected ca_ctx 0
execute if score #eo70 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #eo71 ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1
execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {vertex:53,mask:0,length:0}
