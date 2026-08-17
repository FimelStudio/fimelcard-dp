function hanabi:score/update
execute if score @s hb_reason matches 1 run scoreboard players set @s hb_score 0
function hanabi:player/tag_audience
tellraw @a[tag=hb.audience] [{text:"════════ 花火结算 ════════",color:"light_purple",bold:true}]
execute if score @s hb_reason matches 1 run tellraw @a[tag=hb.audience] [{text:"失误次数达到本桌上限（",color:"red"},{score:{name:"@s",objective:"hb_strike_max"},color:"gold"},{text:"），整场烟花熄灭，本局失败。",color:"red"}]
execute if score @s hb_reason matches 2 run tellraw @a[tag=hb.audience] [{text:"牌库与所有普通手牌均已用完，烟花表演完成。",color:"gold"}]
execute if score @s hb_reason matches 3 if score @s hb_storm matches 0 run tellraw @a[tag=hb.audience] [{text:"五种烟花全部完成，完美的25分！",color:"green",bold:true}]
execute if score @s hb_reason matches 3 if score @s hb_storm matches 1 run tellraw @a[tag=hb.audience] [{text:"六种烟花全部完成，神圣的30分彩色风暴！",color:"light_purple",bold:true}]
execute if score @s hb_reason matches 4 run tellraw @a[tag=hb.audience] [{text:"没有可继续行动的玩家，牌局结束。",color:"yellow"}]
execute if score @s hb_storm matches 0 run tellraw @a[tag=hb.audience] [{text:"最终得分：",color:"gray"},{score:{name:"@s",objective:"hb_score"},color:"gold",bold:true},{text:" / 25",color:"gray"}]
execute if score @s hb_storm matches 1 run tellraw @a[tag=hb.audience] [{text:"最终得分：",color:"gray"},{score:{name:"@s",objective:"hb_score"},color:"gold",bold:true},{text:" / 30",color:"light_purple"}]
execute if score @s hb_score matches 0..5 run tellraw @a[tag=hb.audience] [{text:"评价：烟火刚刚起步，再试一次吧。",color:"gray"}]
execute if score @s hb_score matches 6..10 run tellraw @a[tag=hb.audience] [{text:"评价：平凡但完整的表演。",color:"white"}]
execute if score @s hb_score matches 11..15 run tellraw @a[tag=hb.audience] [{text:"评价：很精彩，配合已经相当不错。",color:"aqua"}]
execute if score @s hb_score matches 16..20 run tellraw @a[tag=hb.audience] [{text:"评价：华丽的烟花大会！",color:"light_purple"}]
execute if score @s hb_score matches 21..24 run tellraw @a[tag=hb.audience] [{text:"评价：大师级合作，只差最后一点。",color:"yellow"}]
execute if score @s hb_storm matches 1 if score @s hb_score matches 25 run tellraw @a[tag=hb.audience] [{text:"评价：传说中的完美烟花，无论成年人还是小孩子都看得瞠目结舌。",color:"gold",bold:true}]
execute if score @s hb_storm matches 1 if score @s hb_score matches 26..29 run tellraw @a[tag=hb.audience] [{text:"评价：超越传说，彩色风暴距离神圣只差一步。",color:"light_purple"}]
execute if score @s hb_storm matches 1 if score @s hb_score matches 30 run tellraw @a[tag=hb.audience] [{text:"评价：神圣的花火，比星星更加璀璨夺目。",color:"aqua",bold:true}]
# 按最终得分、各颜色完成进度生成本局专属终场烟花。
function hanabi:firework/finale/start
