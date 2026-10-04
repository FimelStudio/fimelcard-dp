scoreboard players operation #ctx cp_ctx = @s cp_id
scoreboard players set #v1 cp_ctx 0
scoreboard players set #v2 cp_ctx 0
scoreboard players set #v3 cp_ctx 0
scoreboard players set #v4 cp_ctx 0
scoreboard players set #v5 cp_ctx 0
scoreboard players set #v6 cp_ctx 0
scoreboard players set #v7 cp_ctx 0
scoreboard players set #v8 cp_ctx 0
execute as @a[tag=cp.player,scores={cp_vote=1}] if score @s cp_id = #ctx cp_ctx run scoreboard players add #v1 cp_ctx 1
execute as @a[tag=cp.player,scores={cp_vote=2}] if score @s cp_id = #ctx cp_ctx run scoreboard players add #v2 cp_ctx 1
execute as @a[tag=cp.player,scores={cp_vote=3}] if score @s cp_id = #ctx cp_ctx run scoreboard players add #v3 cp_ctx 1
execute as @a[tag=cp.player,scores={cp_vote=4}] if score @s cp_id = #ctx cp_ctx run scoreboard players add #v4 cp_ctx 1
execute as @a[tag=cp.player,scores={cp_vote=5}] if score @s cp_id = #ctx cp_ctx run scoreboard players add #v5 cp_ctx 1
execute as @a[tag=cp.player,scores={cp_vote=6}] if score @s cp_id = #ctx cp_ctx run scoreboard players add #v6 cp_ctx 1
execute as @a[tag=cp.player,scores={cp_vote=7}] if score @s cp_id = #ctx cp_ctx run scoreboard players add #v7 cp_ctx 1
execute as @a[tag=cp.player,scores={cp_vote=8}] if score @s cp_id = #ctx cp_ctx run scoreboard players add #v8 cp_ctx 1
scoreboard players set #max cp_ctx 0
execute if score #v1 cp_ctx > #max cp_ctx run scoreboard players operation #max cp_ctx = #v1 cp_ctx
execute if score #v2 cp_ctx > #max cp_ctx run scoreboard players operation #max cp_ctx = #v2 cp_ctx
execute if score #v3 cp_ctx > #max cp_ctx run scoreboard players operation #max cp_ctx = #v3 cp_ctx
execute if score #v4 cp_ctx > #max cp_ctx run scoreboard players operation #max cp_ctx = #v4 cp_ctx
execute if score #v5 cp_ctx > #max cp_ctx run scoreboard players operation #max cp_ctx = #v5 cp_ctx
execute if score #v6 cp_ctx > #max cp_ctx run scoreboard players operation #max cp_ctx = #v6 cp_ctx
execute if score #v7 cp_ctx > #max cp_ctx run scoreboard players operation #max cp_ctx = #v7 cp_ctx
execute if score #v8 cp_ctx > #max cp_ctx run scoreboard players operation #max cp_ctx = #v8 cp_ctx
scoreboard players set #leaders cp_ctx 0
execute if score #v1 cp_ctx = #max cp_ctx run scoreboard players add #leaders cp_ctx 1
execute if score #v2 cp_ctx = #max cp_ctx run scoreboard players add #leaders cp_ctx 1
execute if score #v3 cp_ctx = #max cp_ctx run scoreboard players add #leaders cp_ctx 1
execute if score #v4 cp_ctx = #max cp_ctx run scoreboard players add #leaders cp_ctx 1
execute if score #v5 cp_ctx = #max cp_ctx run scoreboard players add #leaders cp_ctx 1
execute if score #v6 cp_ctx = #max cp_ctx run scoreboard players add #leaders cp_ctx 1
execute if score #v7 cp_ctx = #max cp_ctx run scoreboard players add #leaders cp_ctx 1
execute if score #v8 cp_ctx = #max cp_ctx run scoreboard players add #leaders cp_ctx 1
scoreboard players set #wolfseat cp_ctx 0
execute as @a[tag=cp.player,tag=cp.wolf] if score @s cp_id = #ctx cp_ctx run scoreboard players operation #wolfseat cp_ctx = @s cp_seat
scoreboard players set #caught cp_ctx 0
execute if score #wolfseat cp_ctx matches 1 if score #v1 cp_ctx = #max cp_ctx run scoreboard players set #caught cp_ctx 1
execute if score #wolfseat cp_ctx matches 2 if score #v2 cp_ctx = #max cp_ctx run scoreboard players set #caught cp_ctx 1
execute if score #wolfseat cp_ctx matches 3 if score #v3 cp_ctx = #max cp_ctx run scoreboard players set #caught cp_ctx 1
execute if score #wolfseat cp_ctx matches 4 if score #v4 cp_ctx = #max cp_ctx run scoreboard players set #caught cp_ctx 1
execute if score #wolfseat cp_ctx matches 5 if score #v5 cp_ctx = #max cp_ctx run scoreboard players set #caught cp_ctx 1
execute if score #wolfseat cp_ctx matches 6 if score #v6 cp_ctx = #max cp_ctx run scoreboard players set #caught cp_ctx 1
execute if score #wolfseat cp_ctx matches 7 if score #v7 cp_ctx = #max cp_ctx run scoreboard players set #caught cp_ctx 1
execute if score #wolfseat cp_ctx matches 8 if score #v8 cp_ctx = #max cp_ctx run scoreboard players set #caught cp_ctx 1
function critical_point:player/mark_audience
tellraw @a[tag=cp.audience] {text:"最终投票结果：",color:"gold"}
execute as @a[tag=cp.audience,scores={cp_seat=1}] run tellraw @a[tag=cp.audience] [{selector:"@s",color:"white"},{text:"：",color:"gray"},{score:{name:"#v1",objective:"cp_ctx"},color:"gold"},{text:"票",color:"gray"}]
execute as @a[tag=cp.audience,scores={cp_seat=2}] run tellraw @a[tag=cp.audience] [{selector:"@s",color:"white"},{text:"：",color:"gray"},{score:{name:"#v2",objective:"cp_ctx"},color:"gold"},{text:"票",color:"gray"}]
execute as @a[tag=cp.audience,scores={cp_seat=3}] run tellraw @a[tag=cp.audience] [{selector:"@s",color:"white"},{text:"：",color:"gray"},{score:{name:"#v3",objective:"cp_ctx"},color:"gold"},{text:"票",color:"gray"}]
execute as @a[tag=cp.audience,scores={cp_seat=4}] run tellraw @a[tag=cp.audience] [{selector:"@s",color:"white"},{text:"：",color:"gray"},{score:{name:"#v4",objective:"cp_ctx"},color:"gold"},{text:"票",color:"gray"}]
execute as @a[tag=cp.audience,scores={cp_seat=5}] run tellraw @a[tag=cp.audience] [{selector:"@s",color:"white"},{text:"：",color:"gray"},{score:{name:"#v5",objective:"cp_ctx"},color:"gold"},{text:"票",color:"gray"}]
execute as @a[tag=cp.audience,scores={cp_seat=6}] run tellraw @a[tag=cp.audience] [{selector:"@s",color:"white"},{text:"：",color:"gray"},{score:{name:"#v6",objective:"cp_ctx"},color:"gold"},{text:"票",color:"gray"}]
execute as @a[tag=cp.audience,scores={cp_seat=7}] run tellraw @a[tag=cp.audience] [{selector:"@s",color:"white"},{text:"：",color:"gray"},{score:{name:"#v7",objective:"cp_ctx"},color:"gold"},{text:"票",color:"gray"}]
execute as @a[tag=cp.audience,scores={cp_seat=8}] run tellraw @a[tag=cp.audience] [{selector:"@s",color:"white"},{text:"：",color:"gray"},{score:{name:"#v8",objective:"cp_ctx"},color:"gold"},{text:"票",color:"gray"}]
execute unless score #leaders cp_ctx matches 1 run tellraw @a[tag=cp.audience] [{text:'最高票平票。狼人获胜。',color:'dark_red',bold:true}]
execute if score #leaders cp_ctx matches 1 if score #caught cp_ctx matches 1 run tellraw @a[tag=cp.audience] [{text:'狼人被准确处决！',color:'green',bold:true}]
execute if score #leaders cp_ctx matches 1 unless score #caught cp_ctx matches 1 run tellraw @a[tag=cp.audience] [{text:'村民被错误处决。狼人获胜。',color:'dark_red',bold:true}]
tag @a[tag=cp.audience] remove cp.audience
execute unless score #leaders cp_ctx matches 1 run function critical_point:game/finish_wolf
execute if score #leaders cp_ctx matches 1 if score #caught cp_ctx matches 1 run function critical_point:game/finish_villagers
execute if score #leaders cp_ctx matches 1 unless score #caught cp_ctx matches 1 run function critical_point:game/finish_wolf

