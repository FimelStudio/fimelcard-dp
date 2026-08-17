# 根据颜色与数字写入统一牌面定义；颜色1至6依次为白、红、蓝、黄、绿、彩色
scoreboard players operation #def hb_ctx = @s hb_color
scoreboard players remove #def hb_ctx 1
scoreboard players set #five hb_ctx 5
scoreboard players operation #def hb_ctx *= #five hb_ctx
scoreboard players operation #def hb_ctx += @s hb_rank

execute if score #def hb_ctx matches 1 run data modify storage hanabi:card def set value {color:1,rank:1,model:"card:hanabi/w_1",name:"白色1",glyph:"\uE101",color_glyph:"\uE011",rank_glyph:"\uE021"}
execute if score #def hb_ctx matches 2 run data modify storage hanabi:card def set value {color:1,rank:2,model:"card:hanabi/w_2",name:"白色2",glyph:"\uE102",color_glyph:"\uE011",rank_glyph:"\uE022"}
execute if score #def hb_ctx matches 3 run data modify storage hanabi:card def set value {color:1,rank:3,model:"card:hanabi/w_3",name:"白色3",glyph:"\uE103",color_glyph:"\uE011",rank_glyph:"\uE023"}
execute if score #def hb_ctx matches 4 run data modify storage hanabi:card def set value {color:1,rank:4,model:"card:hanabi/w_4",name:"白色4",glyph:"\uE104",color_glyph:"\uE011",rank_glyph:"\uE024"}
execute if score #def hb_ctx matches 5 run data modify storage hanabi:card def set value {color:1,rank:5,model:"card:hanabi/w_5",name:"白色5",glyph:"\uE105",color_glyph:"\uE011",rank_glyph:"\uE025"}

execute if score #def hb_ctx matches 6 run data modify storage hanabi:card def set value {color:2,rank:1,model:"card:hanabi/r_1",name:"红色1",glyph:"\uE201",color_glyph:"\uE012",rank_glyph:"\uE021"}
execute if score #def hb_ctx matches 7 run data modify storage hanabi:card def set value {color:2,rank:2,model:"card:hanabi/r_2",name:"红色2",glyph:"\uE202",color_glyph:"\uE012",rank_glyph:"\uE022"}
execute if score #def hb_ctx matches 8 run data modify storage hanabi:card def set value {color:2,rank:3,model:"card:hanabi/r_3",name:"红色3",glyph:"\uE203",color_glyph:"\uE012",rank_glyph:"\uE023"}
execute if score #def hb_ctx matches 9 run data modify storage hanabi:card def set value {color:2,rank:4,model:"card:hanabi/r_4",name:"红色4",glyph:"\uE204",color_glyph:"\uE012",rank_glyph:"\uE024"}
execute if score #def hb_ctx matches 10 run data modify storage hanabi:card def set value {color:2,rank:5,model:"card:hanabi/r_5",name:"红色5",glyph:"\uE205",color_glyph:"\uE012",rank_glyph:"\uE025"}

execute if score #def hb_ctx matches 11 run data modify storage hanabi:card def set value {color:3,rank:1,model:"card:hanabi/b_1",name:"蓝色1",glyph:"\uE301",color_glyph:"\uE013",rank_glyph:"\uE021"}
execute if score #def hb_ctx matches 12 run data modify storage hanabi:card def set value {color:3,rank:2,model:"card:hanabi/b_2",name:"蓝色2",glyph:"\uE302",color_glyph:"\uE013",rank_glyph:"\uE022"}
execute if score #def hb_ctx matches 13 run data modify storage hanabi:card def set value {color:3,rank:3,model:"card:hanabi/b_3",name:"蓝色3",glyph:"\uE303",color_glyph:"\uE013",rank_glyph:"\uE023"}
execute if score #def hb_ctx matches 14 run data modify storage hanabi:card def set value {color:3,rank:4,model:"card:hanabi/b_4",name:"蓝色4",glyph:"\uE304",color_glyph:"\uE013",rank_glyph:"\uE024"}
execute if score #def hb_ctx matches 15 run data modify storage hanabi:card def set value {color:3,rank:5,model:"card:hanabi/b_5",name:"蓝色5",glyph:"\uE305",color_glyph:"\uE013",rank_glyph:"\uE025"}

execute if score #def hb_ctx matches 16 run data modify storage hanabi:card def set value {color:4,rank:1,model:"card:hanabi/y_1",name:"黄色1",glyph:"\uE401",color_glyph:"\uE014",rank_glyph:"\uE021"}
execute if score #def hb_ctx matches 17 run data modify storage hanabi:card def set value {color:4,rank:2,model:"card:hanabi/y_2",name:"黄色2",glyph:"\uE402",color_glyph:"\uE014",rank_glyph:"\uE022"}
execute if score #def hb_ctx matches 18 run data modify storage hanabi:card def set value {color:4,rank:3,model:"card:hanabi/y_3",name:"黄色3",glyph:"\uE403",color_glyph:"\uE014",rank_glyph:"\uE023"}
execute if score #def hb_ctx matches 19 run data modify storage hanabi:card def set value {color:4,rank:4,model:"card:hanabi/y_4",name:"黄色4",glyph:"\uE404",color_glyph:"\uE014",rank_glyph:"\uE024"}
execute if score #def hb_ctx matches 20 run data modify storage hanabi:card def set value {color:4,rank:5,model:"card:hanabi/y_5",name:"黄色5",glyph:"\uE405",color_glyph:"\uE014",rank_glyph:"\uE025"}

execute if score #def hb_ctx matches 21 run data modify storage hanabi:card def set value {color:5,rank:1,model:"card:hanabi/g_1",name:"绿色1",glyph:"\uE501",color_glyph:"\uE015",rank_glyph:"\uE021"}
execute if score #def hb_ctx matches 22 run data modify storage hanabi:card def set value {color:5,rank:2,model:"card:hanabi/g_2",name:"绿色2",glyph:"\uE502",color_glyph:"\uE015",rank_glyph:"\uE022"}
execute if score #def hb_ctx matches 23 run data modify storage hanabi:card def set value {color:5,rank:3,model:"card:hanabi/g_3",name:"绿色3",glyph:"\uE503",color_glyph:"\uE015",rank_glyph:"\uE023"}
execute if score #def hb_ctx matches 24 run data modify storage hanabi:card def set value {color:5,rank:4,model:"card:hanabi/g_4",name:"绿色4",glyph:"\uE504",color_glyph:"\uE015",rank_glyph:"\uE024"}
execute if score #def hb_ctx matches 25 run data modify storage hanabi:card def set value {color:5,rank:5,model:"card:hanabi/g_5",name:"绿色5",glyph:"\uE505",color_glyph:"\uE015",rank_glyph:"\uE025"}

execute if score #def hb_ctx matches 26 run data modify storage hanabi:card def set value {color:6,rank:1,model:"card:hanabi/m_1",name:"彩色1",glyph:"\uE601",color_glyph:"\uE016",rank_glyph:"\uE021"}
execute if score #def hb_ctx matches 27 run data modify storage hanabi:card def set value {color:6,rank:2,model:"card:hanabi/m_2",name:"彩色2",glyph:"\uE602",color_glyph:"\uE016",rank_glyph:"\uE022"}
execute if score #def hb_ctx matches 28 run data modify storage hanabi:card def set value {color:6,rank:3,model:"card:hanabi/m_3",name:"彩色3",glyph:"\uE603",color_glyph:"\uE016",rank_glyph:"\uE023"}
execute if score #def hb_ctx matches 29 run data modify storage hanabi:card def set value {color:6,rank:4,model:"card:hanabi/m_4",name:"彩色4",glyph:"\uE604",color_glyph:"\uE016",rank_glyph:"\uE024"}
execute if score #def hb_ctx matches 30 run data modify storage hanabi:card def set value {color:6,rank:5,model:"card:hanabi/m_5",name:"彩色5",glyph:"\uE605",color_glyph:"\uE016",rank_glyph:"\uE025"}

# 本体道具牌覆盖颜色/数字定义；完整图片在所有公开视图中共用
execute if score @s hb_reward matches 1 run data modify storage hanabi:card def set value {color:0,rank:0,model:"card:hanabi/tool_hint",name:"提示牌",glyph:"\uE701",color_glyph:"\uE701",rank_glyph:"\uE701"}
execute if score @s hb_reward matches 2 run data modify storage hanabi:card def set value {color:0,rank:0,model:"card:hanabi/tool_restore",name:"恢复牌",glyph:"\uE702",color_glyph:"\uE702",rank_glyph:"\uE702"}
