# 私有结果仅发送给合法知情人；从不将秘密牌值写入公共行、桌面或广播。
execute unless data entity @s data.ll_private.kind run return 0
function love_letter:system/context
data modify storage love_letter:private result set from entity @s data.ll_private
execute store result score #private_actor ll_ctx run data get entity @s data.ll_private.seat
execute store result score #private_target ll_ctx run data get entity @s data.ll_private.target
execute store result score #ui_card ll_ctx run data get entity @s data.ll_private.actor_card
function love_letter:ui/role
data modify storage love_letter:private actor_card set from storage love_letter:ui role
execute store result score #ui_card ll_ctx run data get entity @s data.ll_private.target_card
function love_letter:ui/role
data modify storage love_letter:private target_card set from storage love_letter:ui role
tag @a[tag=ll.private_viewer] remove ll.private_viewer
execute as @a[tag=ll.audience] if score @s ll_seat = #private_actor ll_ctx run tag @s add ll.private_viewer
execute unless data entity @s data.ll_private{kind:"priest"} as @a[tag=ll.audience] if score @s ll_seat = #private_target ll_ctx run tag @s add ll.private_viewer
execute if data entity @s data.ll_private{kind:"priest"} run tellraw @a[tag=ll.private_viewer] [{text:"[情书 · 私密] 目标留牌：",color:"light_purple"},{nbt:"target_card",storage:"love_letter:private",interpret:true}]
execute if data entity @s data.ll_private{kind:"baron"} run tellraw @a[tag=ll.private_viewer] [{text:"[情书 · 私密] 男爵比较：行动者 ",color:"light_purple"},{nbt:"actor_card",storage:"love_letter:private",interpret:true},{text:"；目标 "},{nbt:"target_card",storage:"love_letter:private",interpret:true}]
execute if data entity @s data.ll_private{kind:"king"} run tellraw @a[tag=ll.private_viewer] [{text:"[情书 · 私密] 国王交换前：行动者 ",color:"light_purple"},{nbt:"actor_card",storage:"love_letter:private",interpret:true},{text:"；目标 "},{nbt:"target_card",storage:"love_letter:private",interpret:true}]
tag @a[tag=ll.private_viewer] remove ll.private_viewer
data remove entity @s data.ll_private
data remove storage love_letter:private result
data remove storage love_letter:private actor_card
data remove storage love_letter:private target_card
