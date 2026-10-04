scoreboard players operation #ctx ab_ctx = @s ab_id
data modify storage abraca:hud text set value [{text:"生命",color:"red",bold:true}]
execute as @a[tag=ab.player,scores={ab_seat=1}] if score @s ab_id = #ctx ab_ctx at @s run function abraca:hud/append_player
execute as @a[tag=ab.player,scores={ab_seat=2}] if score @s ab_id = #ctx ab_ctx at @s run function abraca:hud/append_player
execute as @a[tag=ab.player,scores={ab_seat=3}] if score @s ab_id = #ctx ab_ctx at @s run function abraca:hud/append_player
execute as @a[tag=ab.player,scores={ab_seat=4}] if score @s ab_id = #ctx ab_ctx at @s run function abraca:hud/append_player
execute as @a[tag=ab.player,scores={ab_seat=5}] if score @s ab_id = #ctx ab_ctx at @s run function abraca:hud/append_player
execute as @a[tag=ab.player,scores={ab_seat=6}] if score @s ab_id = #ctx ab_ctx at @s run function abraca:hud/append_player
execute as @a[tag=ab.player,scores={ab_seat=7}] if score @s ab_id = #ctx ab_ctx at @s run function abraca:hud/append_player
execute as @a[tag=ab.player,scores={ab_seat=8}] if score @s ab_id = #ctx ab_ctx at @s run function abraca:hud/append_player
execute as @e[type=minecraft:text_display,tag=ab.info] if score @s ab_id = #ctx ab_ctx run function abraca:hud/render with storage abraca:hud
