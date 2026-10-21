execute if score @s ct_voice_cd matches 1.. run return run tellraw @s {text:"语音冷却中，请稍后再发（每5秒一次）。",color:"gray"}
scoreboard players set @s ct_voice_cd 100
execute if score #meme ct_ctx matches 101 at @s run playsound meme:dedede player @a[distance=..16] ~ ~ ~ 1 1 0
execute if score #meme ct_ctx matches 102 at @s run playsound meme:nw_laugh player @a[distance=..16] ~ ~ ~ 1 1 0
