execute if items entity @s hotbar.* *[minecraft:custom_data~{decrypto:{clue:1b}}] run return 0
execute if items entity @s inventory.* *[minecraft:custom_data~{decrypto:{clue:1b}}] run return 0
execute if items entity @s weapon.offhand *[minecraft:custom_data~{decrypto:{clue:1b}}] run return 0
execute if items entity @s hotbar.* *[minecraft:custom_data~{decrypto:{tool:"prompt"}}] run return 0
execute if items entity @s inventory.* *[minecraft:custom_data~{decrypto:{tool:"prompt"}}] run return 0
function decrypto:prompt/give_selected
