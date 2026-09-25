function skull:player/audience
execute as @a[tag=sk.audience,scores={sk_wins=2..}] run tellraw @a[tag=sk.audience] [{text:"[骷髅牌] ",color:"gold"},{selector:"@s"},{text:" 累计成功两次，赢得本局！",color:"green",bold:true}]
execute if score @s sk_players matches 1 as @a[tag=sk.audience] run tellraw @a[tag=sk.audience] [{text:"[骷髅牌] ",color:"gold"},{selector:"@s"},{text:" 成为唯一仍有牌的玩家，赢得本局！",color:"green",bold:true}]
function skull:log {text:"满足胜利条件，正常结束游戏"}
function skull:game/abort
