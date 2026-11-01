scoreboard players set @s it_state 2
function ito:game/epoch
execute as @a[tag=it.audience] run dialog clear @s
tellraw @a[tag=it.audience] [{text:"[命悬一线] 本关主题：",color:"gold"},{nbt:"data.ito.theme.text",entity:"@s"}]
tellraw @a[tag=it.audience] {"text":"[命悬一线] 为每张牌写描述，可以随时修改。先讨论好，再由想出牌的人主动提交。","color":"yellow"}
execute if score @s it_round matches 3 run tellraw @a[tag=it.audience] [{text:"第三关公共参照数字：",color:"aqua"},{nbt:"data.ito.reference",entity:"@s"},{text:"。请大家先共同想一个对应的描述。"}]
function ito:hud/refresh
function ito:visual/refresh

