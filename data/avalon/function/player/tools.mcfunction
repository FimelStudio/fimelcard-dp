# Remove the retired purple menu tool; the role card is now the only Q menu entry.
clear @s *[minecraft:custom_data~{avalon:{menu:1b}}]
function avalon:player/identity
