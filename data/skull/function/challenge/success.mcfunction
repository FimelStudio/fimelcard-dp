scoreboard players operation #lead sk_ctx = @s sk_lead
execute as @a[tag=sk.audience] if score @s sk_seat = #lead sk_ctx run scoreboard players add @s sk_wins 1
execute as @a[tag=sk.audience] if score @s sk_seat = #lead sk_ctx run tellraw @a[tag=sk.audience] [{selector:"@s"},{text:" 挑战成功！累计胜利：",color:"green"},{score:{name:"@s",objective:"sk_wins"}},{text:" / 2"}]
function skull:log {text:"挑战成功并增加胜利标记"}
function skull:round/settle
