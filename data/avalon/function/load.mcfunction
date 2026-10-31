scoreboard objectives add av_ctx dummy
scoreboard objectives add av_id dummy
scoreboard objectives add av_seat dummy
scoreboard objectives add av_role dummy
scoreboard objectives add av_state dummy
scoreboard objectives add av_round dummy
scoreboard objectives add av_good dummy
scoreboard objectives add av_evil dummy
scoreboard objectives add av_reject dummy
scoreboard objectives add av_need dummy
scoreboard objectives add av_leader dummy
scoreboard objectives add av_players dummy
scoreboard objectives add av_epoch dummy
scoreboard objectives add av_selected dummy
scoreboard objectives add av_vote dummy
scoreboard objectives add av_mission dummy
scoreboard objectives add av_timer dummy
scoreboard objectives add av_ui_epoch dummy
scoreboard objectives add av_ui_base dummy
scoreboard objectives add av_action trigger
scoreboard objectives add av_clock dummy
scoreboard objectives add av_target dummy
scoreboard players reset * av_action
execute unless score #nonce av_ctx matches 0.. run scoreboard players set #nonce av_ctx 0

title @a[tag=av.player] actionbar {text:""}
execute as @a[tag=av.player] run function avalon:player/identity

execute as @e[type=minecraft:marker,tag=av.controller,scores={av_state=1..5}] at @s run function avalon:map/render
