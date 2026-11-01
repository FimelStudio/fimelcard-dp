tag @s add gd.visual
tag @s add gd.status
scoreboard players operation @s ct_id = #vis_table gd_ctx
data merge entity @s {text:{text:"掼蛋",color:"gold",extra:[{text:" · 本副 "},{score:{name:"@e[tag=gd.current,limit=1]",objective:"gd_round"}},{text:"\n队0 "},{score:{name:"@e[tag=gd.current,limit=1]",objective:"gd_team0"}},{text:"级 / 队1 "},{score:{name:"@e[tag=gd.current,limit=1]",objective:"gd_team1"}},{text:"级 · 打 "},{score:{name:"@e[tag=gd.current,limit=1]",objective:"gd_level"}},{text:"\n轮到 "},{score:{name:"@e[tag=gd.current,limit=1]",objective:"gd_turn"}},{text:" 号位 · 逆时针"}]},billboard:"center",background:0,shadow:1b,view_range:0.5f,line_width:340,transformation:{scale:[0.18f,0.18f,0.18f]}}
function guandan:visual/status_fields
# text_display 会立即解析 selector/score；刷新时上下文只包含当前桌。
execute if entity @e[tag=gd.current,scores={gd_state=0},limit=1] run data modify entity @s text set value {text:"掼蛋 · 四人对家",color:"gold"}
execute if entity @e[tag=gd.current,scores={gd_state=1},limit=1] run data modify entity @s text set value {text:"掼蛋 · 正在发牌",color:"gold"}
execute if entity @e[tag=gd.current,scores={gd_state=2,gd_phase=1},limit=1] run data modify entity @s text set value {text:"掼蛋 · 选择进贡",color:"gold"}
execute if entity @e[tag=gd.current,scores={gd_state=2,gd_phase=2},limit=1] run data modify entity @s text set value {text:"掼蛋 · 选择还牌",color:"gold"}
