scoreboard players set #occupied hb_ctx 0
execute if items entity @s hotbar.8 * run scoreboard players set #occupied hb_ctx 1
$execute unless score #occupied hb_ctx matches 1 run item replace entity @s hotbar.8 with minecraft:firework_star[minecraft:item_name="提示队友（Q）",minecraft:custom_data={hanabi:{action:"hint",table:$(table)}},minecraft:enchantment_glint_override=true,minecraft:max_stack_size=1]
$execute if score #occupied hb_ctx matches 1 run give @s minecraft:firework_star[minecraft:item_name="提示队友（Q）",minecraft:custom_data={hanabi:{action:"hint",table:$(table)}},minecraft:enchantment_glint_override=true,minecraft:max_stack_size=1]
