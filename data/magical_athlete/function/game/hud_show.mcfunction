$execute if score @s ma_state matches 1 run tellraw @a[tag=ma.audience] [{text:"[胡闹运动会] 轮到 ",color:"gold"},{nbt:"data.magical_athlete.p$(turn).name",entity:"@s",interpret:true},{text:" 选角，请用紫色染料Q选择。",color:"yellow"}]
execute if score @s ma_state matches 2 run tellraw @a[tag=ma.audience] {text:"[胡闹运动会] 请各队用紫色染料Q选择本场出场选手。",color:"yellow"}
$execute if score @s ma_state matches 3 if score @s ma_pending matches 0 run tellraw @a[tag=ma.audience] [{text:"[胡闹运动会] 第$(round)场，轮到 ",color:"gold"},{nbt:"data.magical_athlete.p$(turn).name",entity:"@s",interpret:true},{text:" 行动：骰子Q开始，接受/重掷/技能使用快捷栏选项Q确认。",color:"yellow"}]
execute if score @s ma_state matches 4 run tellraw @a[tag=ma.audience] {text:"[胡闹运动会] 本场结束，请用紫色染料Q确认进入下一场。",color:"gold"}
