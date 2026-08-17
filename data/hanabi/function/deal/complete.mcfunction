# 第一位玩家纯随机选择，不与座位号或上一局状态绑定
scoreboard players set @s hb_state 2
scoreboard players set @s hb_phase 0
scoreboard players set @s hb_timer 0
scoreboard players operation #ctx_id hb_ctx = @s hb_id
tag @a[tag=hb.first_pool] remove hb.first_pool
tag @a[tag=hb.first_turn] remove hb.first_turn
execute as @a[tag=hb.player] if score @s hb_id = #ctx_id hb_ctx run tag @s add hb.first_pool
tag @a[tag=hb.first_pool,sort=random,limit=1] add hb.first_turn
tag @a[tag=hb.first_turn,limit=1] add hb.turn
scoreboard players operation @s hb_turn = @a[tag=hb.first_turn,limit=1] hb_seat
tag @a[tag=hb.first_pool] remove hb.first_pool
tag @a[tag=hb.first_turn] remove hb.first_turn

function hanabi:hud/spawn
function hanabi:hud/update
function hanabi:ui/discard_pile/spawn
function hanabi:title/activate_all
function hanabi:player/tag_audience
execute as @a[tag=hb.player] if score @s hb_id = #ctx_id hb_ctx run function hanabi:hand/sync
function hanabi:input/restore_table
execute if score @s hb_storm matches 0 run tellraw @a[tag=hb.audience] [{text:"[花火] ",color:"light_purple"},{text:"游戏开始！请共同完成五色烟花。",color:"gold"}]
execute if score @s hb_storm matches 1 run tellraw @a[tag=hb.audience] [{text:"[花火] ",color:"light_purple"},{text:"彩色风暴来临！请共同完成六色烟花。",color:"light_purple",bold:true}]
tellraw @a[tag=hb.audience] [{text:"[花火] ",color:"light_purple"},{text:"首先轮到 ",color:"gray"},{selector:"@a[tag=hb.turn,tag=hb.audience,limit=1]",color:"yellow"},{text:"。",color:"gray"}]
playsound minecraft:entity.firework_rocket.launch master @a[tag=hb.audience] ~ ~ ~ 0.8 1.15
function hanabi:log {text:"起始手牌发放完成，随机第一回合开始"}
