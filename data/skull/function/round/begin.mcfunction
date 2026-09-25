scoreboard players set @s sk_state 1
scoreboard players add @s sk_round 1
scoreboard players set @s sk_bid 0
scoreboard players set @s sk_total 0
scoreboard players set @s sk_flipped 0
scoreboard players set @s sk_lead 0
scoreboard players operation @s sk_turn = @s sk_first
function skull:round/epoch
function skull:player/audience
scoreboard players set @a[tag=sk.audience] sk_count 0
scoreboard players set @a[tag=sk.audience] sk_done 0
scoreboard players set @a[tag=sk.audience] sk_pass 0
function skull:round/reset_seat {seat:1}
function skull:round/reset_seat {seat:2}
function skull:round/reset_seat {seat:3}
function skull:round/reset_seat {seat:4}
tellraw @a[tag=sk.audience] [{text:"[骷髅牌] 第 ",color:"gold"},{score:{name:"@s",objective:"sk_round"}},{text:" 轮：每人选中一张手牌按Q秘密扣下；紫色染料按Q打开叫号等操作界面。"}]
execute as @a[tag=sk.audience] run function skull:hand/sync
function skull:hud/update
function skull:ui/refresh
function skull:log {text:"新回合：同步首次扣牌"}
