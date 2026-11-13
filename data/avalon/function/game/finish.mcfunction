execute unless score @s av_state matches 1..4 run return 0
function avalon:context
execute as @a[tag=av.audience,scores={av_role=1}] run tellraw @a[tag=av.audience] [{"selector":"@s"},{"text":"：梅林","color":"aqua"}]
execute as @a[tag=av.audience,scores={av_role=2}] run tellraw @a[tag=av.audience] [{"selector":"@s"},{"text":"：派西维尔","color":"aqua"}]
execute as @a[tag=av.audience,scores={av_role=3}] run tellraw @a[tag=av.audience] [{"selector":"@s"},{"text":"：忠臣","color":"green"}]
execute as @a[tag=av.audience,scores={av_role=4}] run tellraw @a[tag=av.audience] [{"selector":"@s"},{"text":"：莫甘娜","color":"red"}]
execute as @a[tag=av.audience,scores={av_role=5}] run tellraw @a[tag=av.audience] [{"selector":"@s"},{"text":"：刺客","color":"red"}]
execute as @a[tag=av.audience,scores={av_role=6}] run tellraw @a[tag=av.audience] [{"selector":"@s"},{"text":"：奥伯伦","color":"red"}]
execute as @a[tag=av.audience,scores={av_role=7}] run tellraw @a[tag=av.audience] [{"selector":"@s"},{"text":"：爪牙","color":"red"}]
execute at @s run function avalon:hud/update
scoreboard players set @s av_state 5
scoreboard players set @s av_timer 100
scoreboard players add @s av_epoch 1
execute at @s run function avalon:reveal/start
execute as @a[tag=av.audience] run function avalon:player/clear
