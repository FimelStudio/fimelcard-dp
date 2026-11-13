function cardtable:animation/deal/box/cleanup_legacy
scoreboard players operation #deal_box_owner ct_ctx = @s ct_id
$execute positioned ~ ~1.4 ~ summon minecraft:item_display run function cardtable:animation/deal/box/init {model:"$(model)"}
