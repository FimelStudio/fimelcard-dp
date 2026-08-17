# 花火占用快捷栏第1至5格、第9格以及副手；开局前禁止覆盖玩家原物品
execute if items entity @s hotbar.0 * run scoreboard players set #blocked hb_ctx 1
execute if items entity @s hotbar.1 * run scoreboard players set #blocked hb_ctx 1
execute if items entity @s hotbar.2 * run scoreboard players set #blocked hb_ctx 1
execute if items entity @s hotbar.3 * run scoreboard players set #blocked hb_ctx 1
execute if items entity @s hotbar.4 * run scoreboard players set #blocked hb_ctx 1
execute if items entity @s hotbar.8 * run scoreboard players set #blocked hb_ctx 1
execute if items entity @s weapon.offhand * run scoreboard players set #blocked hb_ctx 1
