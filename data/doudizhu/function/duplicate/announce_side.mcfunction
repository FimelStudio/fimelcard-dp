function doudizhu:duplicate/format_side
tellraw @a[tag=dd.audience] [{text:"本桌已结束，",color:"yellow"},{nbt:"side_text",storage:"doudizhu:ui",interpret:true},{text:"。等待另一桌完成。",color:"yellow"}]
