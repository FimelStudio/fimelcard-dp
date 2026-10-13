

tp @s ~ ~100000 ~

execute if entity @s[gamemode= adventure] run scoreboard players set player.gamemode fcs_lib 0
execute if entity @s[gamemode= spectator] run scoreboard players set player.gamemode fcs_lib 1
execute if entity @s[gamemode= survival] run scoreboard players set player.gamemode fcs_lib 2
execute if entity @s[gamemode= creative] run scoreboard players set player.gamemode fcs_lib 3


$execute positioned ~ ~100000 ~ positioned ~$(x) ~$(y) ~$(z) run function fimel_sklibs:skapi_arrays/loop {i:{value:$(v)},execute:{value:"execute summon end_crystal run damage @s 1"}}


execute if score player.gamemode fcs_lib matches 0 run gamemode adventure @s
execute if score player.gamemode fcs_lib matches 1 run gamemode spectator @s
execute if score player.gamemode fcs_lib matches 2 run gamemode survival @s


tp @s ~ ~ ~
