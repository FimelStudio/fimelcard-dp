tag @e[tag=un.selected] remove un.selected
tag @e[type=minecraft:marker,tag=un.cards,scores={un_owner=0,un_value=0..9},sort=random,limit=1] add un.selected
scoreboard players set @e[type=minecraft:marker,tag=un.selected,limit=1] un_owner -1
scoreboard players operation @s un_top = @e[type=minecraft:marker,tag=un.selected,limit=1] un_idx
scoreboard players operation @s un_color = @e[type=minecraft:marker,tag=un.selected,limit=1] un_color
scoreboard players operation @s un_value = @e[type=minecraft:marker,tag=un.selected,limit=1] un_value
scoreboard players operation #card un_ctx = @e[type=minecraft:marker,tag=un.selected,limit=1] un_card
scoreboard players set #seat un_ctx 0
function uno:visual/setup
function uno:round/turn_begin
