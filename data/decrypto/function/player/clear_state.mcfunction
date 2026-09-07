clear @s minecraft:paper[minecraft:custom_data~{decrypto:{clue:1b}}]
clear @s minecraft:book[minecraft:custom_data~{decrypto:{tool:'notes'}}]
clear @s minecraft:paper[minecraft:custom_data~{decrypto:{tool:'guess'}}]
clear @s minecraft:purple_dye[minecraft:custom_data~{decrypto:{tool:'guess'}}]
experience set @s 0 levels
tag @s remove dc.player
tag @s remove dc.interceptor
tag @s remove dc.pick_pool
tag @s remove dc.encoder_pick
tag @s remove dc.next_encoder
tag @s remove dc.public_audience
tag @s remove dc.white_encoder
tag @s remove dc.white_decoder
tag @s remove dc.black_encoder
tag @s remove dc.black_decoder
tag @s remove dc.coop_encoder
tag @s remove dc.coop_decoder
tag @s remove dc.public_interceptor
scoreboard players reset @s dc_id
scoreboard players reset @s dc_team
scoreboard players reset @s dc_seat
scoreboard players reset @s dc_encoder
scoreboard players reset @s dc_drop
scoreboard players reset @s dc_drop_book
scoreboard players reset @s dc_drop_guess
