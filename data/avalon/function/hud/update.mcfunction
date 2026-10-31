scoreboard players operation #table av_ctx = @s av_id
execute as @e[type=minecraft:text_display,tag=av.game_entity] if score @s av_id = #table av_ctx run kill @s
scoreboard players operation #leader av_ctx = @s av_leader
scoreboard players set #target av_ctx 0
function avalon:dialog/names
execute store result storage avalon:hud round int 1 run scoreboard players get @s av_round
execute store result storage avalon:hud good int 1 run scoreboard players get @s av_good
execute store result storage avalon:hud evil int 1 run scoreboard players get @s av_evil
execute store result storage avalon:hud reject int 1 run scoreboard players get @s av_reject
execute store result storage avalon:hud need int 1 run scoreboard players get @s av_need
function avalon:hud/text with storage avalon:hud
data modify storage avalon:hud text.extra append from storage avalon:names leader
data modify storage avalon:hud text.extra append value {text:"\n队员："}
data modify storage avalon:hud text.extra append from storage avalon:names team[]
data modify storage avalon:hud text.extra append value {text:"\n任务记录："}
data modify storage avalon:hud text.extra append from entity @s data.avalon.results[]
execute summon minecraft:text_display run function avalon:hud/init
execute at @s run function avalon:map/render
