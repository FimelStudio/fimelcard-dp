# 当前执行者是控制器；#action为1201..1205
scoreboard players operation #reward_slot hb_ctx = #action hb_ctx
scoreboard players remove #reward_slot hb_ctx 1200
scoreboard players operation #ctx_id hb_ctx = @s hb_id
scoreboard players operation #target_seat hb_ctx = @a[tag=hb.action_actor,limit=1] hb_target
tag @e[tag=hb.full_hint_selected] remove hb.full_hint_selected
execute as @e[type=minecraft:marker,tag=hb.hand] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #target_seat hb_ctx if score @s hb_slot = #reward_slot hb_ctx run tag @s add hb.full_hint_selected
execute unless entity @e[tag=hb.full_hint_selected,limit=1] run return run function hanabi:reward/full_hint/open_card

scoreboard players set @e[tag=hb.full_hint_selected,limit=1] hb_known_c 1
scoreboard players set @e[tag=hb.full_hint_selected,limit=1] hb_known_n 1
execute as @e[tag=hb.full_hint_selected,limit=1] run function hanabi:card/load_definition
# 手牌界面重建会反复复用hanabi:card，因此先保存本次真正公开的牌名
data modify storage hanabi:reward full_hint_revealed_name set from storage hanabi:card def.name
tag @a[tag=hb.full_hint_target] remove hb.full_hint_target
execute as @a[tag=hb.player] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #target_seat hb_ctx run tag @s add hb.full_hint_target
execute as @a[tag=hb.full_hint_target,limit=1] run function hanabi:ui/player/rebuild
function hanabi:player/tag_audience
tellraw @a[tag=hb.audience] [{text:"[花火] ",color:"light_purple"},{selector:"@a[tag=hb.action_actor,limit=1]",color:"yellow"},{text:" 用完全提示公开了 ",color:"gray"},{selector:"@a[tag=hb.full_hint_target,limit=1]",color:"aqua"},{text:" 的一张手牌：",color:"gray"},{storage:"hanabi:reward",nbt:"full_hint_revealed_name",color:"gold"},{text:"。",color:"gray"}]
playsound minecraft:block.enchantment_table.use master @a[tag=hb.audience] ~ ~ ~ 0.9 1.4
playsound minecraft:block.note_block.pling master @a[tag=hb.audience] ~ ~ ~ 0.75 1.8
tag @e[tag=hb.full_hint_selected] remove hb.full_hint_selected
tag @a[tag=hb.full_hint_target] remove hb.full_hint_target
function hanabi:log {text:"完全提示奖励已公开目标牌的颜色和数字"}
function hanabi:reward/finish
