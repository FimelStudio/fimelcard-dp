# 被换掉的槽位已经为空，give会把新牌放入该空位且不会覆盖另一张手牌
$give @s minecraft:paper[minecraft:item_model="$(model)",minecraft:item_name="$(name)",minecraft:custom_data={liars_holdem:{card:1b,id:$(id),rank:$(rank),suit:$(suit),slot:$(slot),table:$(table)}},minecraft:max_stack_size=1] 1
