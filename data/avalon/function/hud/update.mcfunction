function avalon:context
execute as @e[type=minecraft:text_display,tag=av.game_entity] if score @s av_id = #table av_ctx unless entity @s[tag=av.map] run kill @s
scoreboard players operation #leader av_ctx = @s av_leader
scoreboard players set #target av_ctx 0
function avalon:dialog/names
execute store result storage avalon:hud round int 1 run scoreboard players get @s av_round
execute store result storage avalon:hud good int 1 run scoreboard players get @s av_good
execute store result storage avalon:hud evil int 1 run scoreboard players get @s av_evil
execute store result storage avalon:hud reject int 1 run scoreboard players get @s av_reject
execute store result storage avalon:hud need int 1 run scoreboard players get @s av_need
function avalon:hud/text with storage avalon:hud
data modify storage avalon:hud leader set from storage avalon:names leader
data modify storage avalon:hud leader.color set value "white"
execute if data storage avalon:hud leader.extra[2] run data modify storage avalon:hud leader.extra[2].color set value "white"
data modify storage avalon:hud text.extra append from storage avalon:hud leader
data modify storage avalon:hud text.extra append value {text:"\n队员：",color:"gray"}
data modify storage avalon:hud team set from storage avalon:names team
execute if data storage avalon:hud team[{text:""}].extra[2] run data modify storage avalon:hud team[{text:""}].extra[2].color set value "white"
data modify storage avalon:hud text.extra append from storage avalon:hud team[]
data modify storage avalon:hud text.extra append value {text:"\n任务记录：",color:"gray"}
data modify storage avalon:hud text.extra append from entity @s data.avalon.results[]
execute at @s positioned ~ ~2.2 ~ summon minecraft:text_display run function avalon:hud/init with storage avalon:hud
