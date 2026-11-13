execute store result score #inv_needed sp_ctx run data get storage splendor:inventory counts.c51
scoreboard players set #inv_count sp_ctx 0
$execute store result score #inv_count sp_ctx run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:51}}] 0
execute if score #inv_count sp_ctx = #inv_needed sp_ctx run return 1
$clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:51}}]
$data modify storage splendor:inventory ctx.stack set value "minecraft:paper[minecraft:custom_name={\"text\":\"蓝宝石发展卡 · 1分\",\"color\":\"blue\",\"italic\":false},minecraft:item_model=\"card:splendor/tier2/sapphire_06\",minecraft:custom_data={splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:51}},minecraft:lore=[{\"text\":\"永久折扣：蓝宝石 +1\",\"color\":\"gray\",\"italic\":false},{\"text\":\"花费：蓝宝石2 祖母绿3 缟玛瑙3\",\"color\":\"gray\",\"italic\":false},{\"text\":\"已购发展卡永久生效，移动或丢出后会自动恢复。\",\"color\":\"gray\",\"italic\":false}]]"
execute store result storage splendor:inventory ctx.count int 1 run scoreboard players get #inv_needed sp_ctx
function splendor:inventory/place with storage splendor:inventory ctx
