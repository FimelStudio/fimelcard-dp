scoreboard players set @s dc_drop 0
scoreboard players set @s dc_drop_guess 0
scoreboard players operation #ctx dc_ctx = @s dc_id
tag @e[tag=dc.guess_drop] remove dc.guess_drop
execute at @s as @e[type=minecraft:item,distance=..3,sort=nearest] if items entity @s contents minecraft:purple_dye[minecraft:custom_data~{decrypto:{tool:'guess'}}] run tag @s add dc.guess_drop
execute if entity @e[tag=dc.guess_drop,limit=1] run function decrypto:input/use_guess
tag @e[tag=dc.guess_drop] remove dc.guess_drop
# 普通密电记录仍走原流程；提示册仅由本轮加密者提交。
execute unless score @s dc_encoder matches 1 run return 0
data modify storage decrypto:input submitter_uuid set from entity @s UUID
tag @s add dc.submitter
execute at @s as @e[type=minecraft:item,tag=!dc.book_rejected,distance=..3,sort=nearest] if items entity @s contents minecraft:writable_book[minecraft:custom_data~{decrypto:{clue:1b}}] run function decrypto:input/check_book_drop
execute at @s as @e[type=minecraft:item,tag=!dc.book_rejected,distance=..3,sort=nearest] if items entity @s contents minecraft:written_book[minecraft:custom_data~{decrypto:{clue:1b}}] run function decrypto:input/check_book_drop
tag @s remove dc.submitter
