scoreboard players set #inv_count sp_ctx 0
$execute store result score #inv_count sp_ctx run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:2,reserve_slot:$(reserve_slot),epoch:$(epoch),card:43}}] 0
function splendor:inventory/reserve_check with storage splendor:inventory ctx
execute if score #inv_reserved_ok sp_ctx matches 1 run return 1
$clear @s *[minecraft:custom_data~{splendor:{asset:1b,kind:2,reserve_slot:$(reserve_slot)}}]
function splendor:inventory/reserve_free with storage splendor:inventory ctx
execute unless score #inv_room sp_ctx matches 1 run return 0
$data modify storage splendor:inventory ctx.stack set value "minecraft:paper[minecraft:custom_name={\"text\":\"钻石预定卡 · 2分\",\"color\":\"gold\",\"italic\":false},minecraft:item_model=\"card:splendor/reserved/tier2/diamond_04\",minecraft:custom_data={splendor:{asset:1b,table:$(table),owner:$(owner),kind:2,reserve_slot:$(reserve_slot),epoch:$(epoch),card:43}},minecraft:lore=[{\"text\":\"永久折扣：钻石 +1\",\"color\":\"gray\",\"italic\":false},{\"text\":\"花费：祖母绿1 红宝石4 缟玛瑙2\",\"color\":\"gray\",\"italic\":false},{\"text\":\"按 Q 选中，再按 Q 购买；预定牌最多3张。\",\"color\":\"gray\",\"italic\":false}]]"
function splendor:inventory/reserve_place with storage splendor:inventory ctx
