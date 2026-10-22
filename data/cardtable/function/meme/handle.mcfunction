scoreboard players operation #meme ct_ctx = @s ct_meme
scoreboard players reset @s ct_meme
execute unless entity @s[tag=ct.player] run return 0
execute if score #meme ct_ctx matches 200 run return run function cardtable:meme/meme_dialog
execute if score #meme ct_ctx matches 201 run return run function cardtable:meme/picture_dialog
execute if score #meme ct_ctx matches 202 run return run function cardtable:meme/voice_dialog
execute if score #meme ct_ctx matches 1..72 run return run function cardtable:meme/picture
execute if score #meme ct_ctx matches 101..102 run function cardtable:meme/voice

execute if score #meme ct_ctx matches 3000 run return run function cardtable:meme/picture_page_0

execute if score #meme ct_ctx matches 3001 run return run function cardtable:meme/picture_page_1

execute if score #meme ct_ctx matches 3002 run return run function cardtable:meme/picture_page_2




execute if score #meme ct_ctx matches 1001..1034 run return run function cardtable:meme/voice
execute if score #meme ct_ctx matches 4000 run return run function cardtable:meme/voice_page_0
execute if score #meme ct_ctx matches 4001 run return run function cardtable:meme/voice_page_1
execute if score #meme ct_ctx matches 4002 run return run function cardtable:meme/voice_page_2
