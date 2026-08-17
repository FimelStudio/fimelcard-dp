# 奖励牌“提示恢复”：抽到后立即生效，不占普通手牌，也不额外消耗回合
function hanabi:player/tag_audience
tellraw @a[tag=hb.audience] [{text:"[花火] 奖励牌：",color:"light_purple"},{text:"提示恢复",color:"aqua",bold:true},{text:"——恢复1枚提示标记。",color:"gray"}]
playsound minecraft:block.amethyst_block.resonate master @a[tag=hb.audience] ~ ~ ~ 0.9 1.35
playsound minecraft:block.note_block.chime master @a[tag=hb.audience] ~ ~ ~ 0.55 1.75
scoreboard players add @s hb_clues 1
execute if score @s hb_clues > @s hb_clue_max run scoreboard players operation @s hb_clues = @s hb_clue_max
function hanabi:log {text:"奖励牌提示恢复已立即结算"}
function hanabi:hud/update
function hanabi:reward/finish
