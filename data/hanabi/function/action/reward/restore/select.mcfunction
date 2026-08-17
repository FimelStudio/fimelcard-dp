# #restore_option来自本次trigger，只有当前桌、当前弃牌堆且序号仍匹配的标记有效
tag @e[tag=hb.restore_selected] remove hb.restore_selected
execute as @e[type=minecraft:marker,tag=hb.discard] if score @s hb_id = #ctx_id hb_ctx if score @s hb_option = #restore_option hb_ctx run tag @s add hb.restore_selected
execute unless entity @e[tag=hb.restore_selected,limit=1] run tellraw @a[tag=hb.action_actor,limit=1] [{text:"[花火] ",color:"light_purple"},{text:"该弃牌选项已经失效，请重新选择。",color:"yellow"}]
execute unless entity @e[tag=hb.restore_selected,limit=1] as @a[tag=hb.action_actor,limit=1] run function hanabi:dialog/restore/open
execute unless entity @e[tag=hb.restore_selected,limit=1] run return 0

execute as @e[tag=hb.restore_selected,limit=1] run function hanabi:card/load_definition
function hanabi:player/tag_audience
function hanabi:message/restore with storage hanabi:card def
playsound minecraft:block.enchantment_table.use master @a[tag=hb.audience] ~ ~ ~ 0.8 1.2
playsound minecraft:item.bundle.insert master @a[tag=hb.audience] ~ ~ ~ 0.8 0.9

tag @e[tag=hb.restore_selected,limit=1] remove hb.discard
tag @e[tag=hb.restore_selected,limit=1] add hb.deck
scoreboard players set @e[tag=hb.restore_selected,limit=1] hb_seat 0
scoreboard players set @e[tag=hb.restore_selected,limit=1] hb_slot 0
scoreboard players set @e[tag=hb.restore_selected,limit=1] hb_known_c 0
scoreboard players set @e[tag=hb.restore_selected,limit=1] hb_known_n 0
scoreboard players set @e[tag=hb.restore_selected,limit=1] hb_option 0
scoreboard players set @e[tag=hb.restore_selected,limit=1] hb_discard_order 0
tag @e[tag=hb.restore_selected] remove hb.restore_selected
scoreboard players add @s hb_deck_count 1

tag @a[tag=hb.action_actor,limit=1] remove hb.restore_pending
function hanabi:log {text:"弃牌恢复奖励完成：目标弃牌已放回普通牌库"}
function hanabi:hud/update
function hanabi:reward/finish
