scoreboard players set #inv_count sp_ctx 0
$execute store result score #inv_count sp_ctx run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:3,noble:4}}] 0
execute if score #inv_count sp_ctx matches 1 run return 1
$clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:3,noble:4}}]
$data modify storage splendor:inventory ctx.stack set value "minecraft:paper[minecraft:custom_name={\"text\":\"贵族 · 3分\",\"color\":\"light_purple\",\"italic\":false},minecraft:item_model=\"card:splendor/noble/diamond_onyx\",minecraft:custom_data={splendor:{asset:1b,table:$(table),owner:$(owner),kind:3,noble:4}},minecraft:lore=[{\"text\":\"到访条件：钻石4张 缟玛瑙4张\",\"color\":\"gray\",\"italic\":false},{\"text\":\"已获贵族计入声望；物品丢失后会自动恢复。\",\"color\":\"gray\",\"italic\":false}]]"
data modify storage splendor:inventory ctx.count set value 1
function splendor:inventory/place with storage splendor:inventory ctx
