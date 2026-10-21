scoreboard players remove @a[scores={ct_meme_cd=1..}] ct_meme_cd 1
scoreboard players remove @a[scores={ct_voice_cd=1..}] ct_voice_cd 1
execute as @a[scores={ct_meme=1..}] at @s run function cardtable:meme/handle
scoreboard players enable @a[tag=ct.player] ct_meme
# 仅在按下空格时打开一次，防止持续按住反复弹窗。
execute as @a[tag=ct.player,tag=!ct.meme_jump] if predicate cardtable:open_meme_dialog run function cardtable:meme/meme_dialog
execute as @a[tag=ct.player] if predicate cardtable:open_meme_dialog run tag @s add ct.meme_jump
execute as @a[tag=ct.meme_jump] unless predicate cardtable:open_meme_dialog run tag @s remove ct.meme_jump
