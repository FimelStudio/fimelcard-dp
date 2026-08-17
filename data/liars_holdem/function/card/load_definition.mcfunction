# 根据执行者的lh_card把统一牌面定义写入临时storage
# id按黑桃、方块、红心、梅花各A至K连续编号；A在牌型计算中为14
execute if score @s lh_card matches 1 run data modify storage liars_holdem:card def set value {id:1,rank:14,suit:1,model:"card:poker/c_a",name:"黑桃A",glyph:"\u0101"}
execute if score @s lh_card matches 2 run data modify storage liars_holdem:card def set value {id:2,rank:2,suit:1,model:"card:poker/c_2",name:"黑桃2",glyph:"\u0102"}
execute if score @s lh_card matches 3 run data modify storage liars_holdem:card def set value {id:3,rank:3,suit:1,model:"card:poker/c_3",name:"黑桃3",glyph:"\u0103"}
execute if score @s lh_card matches 4 run data modify storage liars_holdem:card def set value {id:4,rank:4,suit:1,model:"card:poker/c_4",name:"黑桃4",glyph:"\u0104"}
execute if score @s lh_card matches 5 run data modify storage liars_holdem:card def set value {id:5,rank:5,suit:1,model:"card:poker/c_5",name:"黑桃5",glyph:"\u0105"}
execute if score @s lh_card matches 6 run data modify storage liars_holdem:card def set value {id:6,rank:6,suit:1,model:"card:poker/c_6",name:"黑桃6",glyph:"\u0106"}
execute if score @s lh_card matches 7 run data modify storage liars_holdem:card def set value {id:7,rank:7,suit:1,model:"card:poker/c_7",name:"黑桃7",glyph:"\u0107"}
execute if score @s lh_card matches 8 run data modify storage liars_holdem:card def set value {id:8,rank:8,suit:1,model:"card:poker/c_8",name:"黑桃8",glyph:"\u0108"}
execute if score @s lh_card matches 9 run data modify storage liars_holdem:card def set value {id:9,rank:9,suit:1,model:"card:poker/c_9",name:"黑桃9",glyph:"\u0109"}
execute if score @s lh_card matches 10 run data modify storage liars_holdem:card def set value {id:10,rank:10,suit:1,model:"card:poker/c_10",name:"黑桃10",glyph:"\u0110"}
execute if score @s lh_card matches 11 run data modify storage liars_holdem:card def set value {id:11,rank:11,suit:1,model:"card:poker/c_j",name:"黑桃J",glyph:"\u0111"}
execute if score @s lh_card matches 12 run data modify storage liars_holdem:card def set value {id:12,rank:12,suit:1,model:"card:poker/c_q",name:"黑桃Q",glyph:"\u0112"}
execute if score @s lh_card matches 13 run data modify storage liars_holdem:card def set value {id:13,rank:13,suit:1,model:"card:poker/c_k",name:"黑桃K",glyph:"\u0113"}

execute if score @s lh_card matches 14 run data modify storage liars_holdem:card def set value {id:14,rank:14,suit:2,model:"card:poker/d_a",name:"方块A",glyph:"\u0201"}
execute if score @s lh_card matches 15 run data modify storage liars_holdem:card def set value {id:15,rank:2,suit:2,model:"card:poker/d_2",name:"方块2",glyph:"\u0202"}
execute if score @s lh_card matches 16 run data modify storage liars_holdem:card def set value {id:16,rank:3,suit:2,model:"card:poker/d_3",name:"方块3",glyph:"\u0203"}
execute if score @s lh_card matches 17 run data modify storage liars_holdem:card def set value {id:17,rank:4,suit:2,model:"card:poker/d_4",name:"方块4",glyph:"\u0204"}
execute if score @s lh_card matches 18 run data modify storage liars_holdem:card def set value {id:18,rank:5,suit:2,model:"card:poker/d_5",name:"方块5",glyph:"\u0205"}
execute if score @s lh_card matches 19 run data modify storage liars_holdem:card def set value {id:19,rank:6,suit:2,model:"card:poker/d_6",name:"方块6",glyph:"\u0206"}
execute if score @s lh_card matches 20 run data modify storage liars_holdem:card def set value {id:20,rank:7,suit:2,model:"card:poker/d_7",name:"方块7",glyph:"\u0207"}
execute if score @s lh_card matches 21 run data modify storage liars_holdem:card def set value {id:21,rank:8,suit:2,model:"card:poker/d_8",name:"方块8",glyph:"\u0208"}
execute if score @s lh_card matches 22 run data modify storage liars_holdem:card def set value {id:22,rank:9,suit:2,model:"card:poker/d_9",name:"方块9",glyph:"\u0209"}
execute if score @s lh_card matches 23 run data modify storage liars_holdem:card def set value {id:23,rank:10,suit:2,model:"card:poker/d_10",name:"方块10",glyph:"\u0210"}
execute if score @s lh_card matches 24 run data modify storage liars_holdem:card def set value {id:24,rank:11,suit:2,model:"card:poker/d_j",name:"方块J",glyph:"\u0211"}
execute if score @s lh_card matches 25 run data modify storage liars_holdem:card def set value {id:25,rank:12,suit:2,model:"card:poker/d_q",name:"方块Q",glyph:"\u0212"}
execute if score @s lh_card matches 26 run data modify storage liars_holdem:card def set value {id:26,rank:13,suit:2,model:"card:poker/d_k",name:"方块K",glyph:"\u0213"}

execute if score @s lh_card matches 27 run data modify storage liars_holdem:card def set value {id:27,rank:14,suit:3,model:"card:poker/h_a",name:"红心A",glyph:"\u0301"}
execute if score @s lh_card matches 28 run data modify storage liars_holdem:card def set value {id:28,rank:2,suit:3,model:"card:poker/h_2",name:"红心2",glyph:"\u0302"}
execute if score @s lh_card matches 29 run data modify storage liars_holdem:card def set value {id:29,rank:3,suit:3,model:"card:poker/h_3",name:"红心3",glyph:"\u0303"}
execute if score @s lh_card matches 30 run data modify storage liars_holdem:card def set value {id:30,rank:4,suit:3,model:"card:poker/h_4",name:"红心4",glyph:"\u0304"}
execute if score @s lh_card matches 31 run data modify storage liars_holdem:card def set value {id:31,rank:5,suit:3,model:"card:poker/h_5",name:"红心5",glyph:"\u0305"}
execute if score @s lh_card matches 32 run data modify storage liars_holdem:card def set value {id:32,rank:6,suit:3,model:"card:poker/h_6",name:"红心6",glyph:"\u0306"}
execute if score @s lh_card matches 33 run data modify storage liars_holdem:card def set value {id:33,rank:7,suit:3,model:"card:poker/h_7",name:"红心7",glyph:"\u0307"}
execute if score @s lh_card matches 34 run data modify storage liars_holdem:card def set value {id:34,rank:8,suit:3,model:"card:poker/h_8",name:"红心8",glyph:"\u0308"}
execute if score @s lh_card matches 35 run data modify storage liars_holdem:card def set value {id:35,rank:9,suit:3,model:"card:poker/h_9",name:"红心9",glyph:"\u0309"}
execute if score @s lh_card matches 36 run data modify storage liars_holdem:card def set value {id:36,rank:10,suit:3,model:"card:poker/h_10",name:"红心10",glyph:"\u0310"}
execute if score @s lh_card matches 37 run data modify storage liars_holdem:card def set value {id:37,rank:11,suit:3,model:"card:poker/h_j",name:"红心J",glyph:"\u0311"}
execute if score @s lh_card matches 38 run data modify storage liars_holdem:card def set value {id:38,rank:12,suit:3,model:"card:poker/h_q",name:"红心Q",glyph:"\u0312"}
execute if score @s lh_card matches 39 run data modify storage liars_holdem:card def set value {id:39,rank:13,suit:3,model:"card:poker/h_k",name:"红心K",glyph:"\u0313"}

execute if score @s lh_card matches 40 run data modify storage liars_holdem:card def set value {id:40,rank:14,suit:4,model:"card:poker/s_a",name:"梅花A",glyph:"\u0401"}
execute if score @s lh_card matches 41 run data modify storage liars_holdem:card def set value {id:41,rank:2,suit:4,model:"card:poker/s_2",name:"梅花2",glyph:"\u0402"}
execute if score @s lh_card matches 42 run data modify storage liars_holdem:card def set value {id:42,rank:3,suit:4,model:"card:poker/s_3",name:"梅花3",glyph:"\u0403"}
execute if score @s lh_card matches 43 run data modify storage liars_holdem:card def set value {id:43,rank:4,suit:4,model:"card:poker/s_4",name:"梅花4",glyph:"\u0404"}
execute if score @s lh_card matches 44 run data modify storage liars_holdem:card def set value {id:44,rank:5,suit:4,model:"card:poker/s_5",name:"梅花5",glyph:"\u0405"}
execute if score @s lh_card matches 45 run data modify storage liars_holdem:card def set value {id:45,rank:6,suit:4,model:"card:poker/s_6",name:"梅花6",glyph:"\u0406"}
execute if score @s lh_card matches 46 run data modify storage liars_holdem:card def set value {id:46,rank:7,suit:4,model:"card:poker/s_7",name:"梅花7",glyph:"\u0407"}
execute if score @s lh_card matches 47 run data modify storage liars_holdem:card def set value {id:47,rank:8,suit:4,model:"card:poker/s_8",name:"梅花8",glyph:"\u0408"}
execute if score @s lh_card matches 48 run data modify storage liars_holdem:card def set value {id:48,rank:9,suit:4,model:"card:poker/s_9",name:"梅花9",glyph:"\u0409"}
execute if score @s lh_card matches 49 run data modify storage liars_holdem:card def set value {id:49,rank:10,suit:4,model:"card:poker/s_10",name:"梅花10",glyph:"\u0410"}
execute if score @s lh_card matches 50 run data modify storage liars_holdem:card def set value {id:50,rank:11,suit:4,model:"card:poker/s_j",name:"梅花J",glyph:"\u0411"}
execute if score @s lh_card matches 51 run data modify storage liars_holdem:card def set value {id:51,rank:12,suit:4,model:"card:poker/s_q",name:"梅花Q",glyph:"\u0412"}
execute if score @s lh_card matches 52 run data modify storage liars_holdem:card def set value {id:52,rank:13,suit:4,model:"card:poker/s_k",name:"梅花K",glyph:"\u0413"}
