function love_letter:system/context
function love_letter:engine/start_turn
function love_letter:game/bump_epoch
scoreboard players set @s ll_anim 8
scoreboard players set @s ll_timeout 0
scoreboard players operation @s ll_clock = @s ll_time_setting
scoreboard players set #twenty ll_ctx 20
scoreboard players operation @s ll_clock *= #twenty ll_ctx
scoreboard players operation #deal_seat ll_ctx = @s ll_turn
function love_letter:deal/launch
function love_letter:visual/refresh
function love_letter:hud/refresh

scoreboard players operation #announce_turn ll_ctx = @s ll_turn
execute as @e[tag=ll.audience] if score @s ll_seat = #announce_turn ll_ctx run tellraw @a[tag=ll.audience] [{text:"[情书] 轮到 ",color:"gold"},{selector:"@s"},{text:" 行动，请选择一张手牌打出。",color:"yellow"}]
