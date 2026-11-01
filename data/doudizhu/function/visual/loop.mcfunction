execute unless data storage doudizhu:table_cards cards[0] run return 0
execute unless data storage doudizhu:table_cards positions[0] run return 0
data modify storage doudizhu:table_cards args.model_index set from storage doudizhu:table_cards cards[0]
data modify storage doudizhu:table_cards card set from storage doudizhu:table_cards positions[0]
function doudizhu:visual/model with storage doudizhu:table_cards args
execute summon minecraft:item_display run function doudizhu:visual/face with storage doudizhu:table_cards card
data remove storage doudizhu:table_cards cards[0]
data remove storage doudizhu:table_cards positions[0]
function doudizhu:visual/loop
