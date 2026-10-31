execute if score #action av_ctx matches 41 if score @s av_state matches 1..3 if score @a[tag=av.actor,limit=1] av_role matches 5 run return run function avalon:game/assassination
execute if score @s av_state matches 1 if score @a[tag=av.actor,limit=1] av_seat = @s av_leader if score #action av_ctx matches 1..8 run function avalon:input/toggle
execute if score @s av_state matches 1 if score @a[tag=av.actor,limit=1] av_seat = @s av_leader if score #action av_ctx matches 10 run return run function avalon:game/submit_team
execute if score @s av_state matches 2 if score @a[tag=av.actor,limit=1] av_vote matches 0 if score #action av_ctx matches 20..21 run return run function avalon:input/vote
execute if score @s av_state matches 3 if score @a[tag=av.actor,limit=1] av_selected matches 1 if score @a[tag=av.actor,limit=1] av_mission matches 0 if score #action av_ctx matches 30..31 run return run function avalon:input/mission
execute if score @s av_state matches 4 if score @a[tag=av.actor,limit=1] av_role matches 5 if score #action av_ctx matches 51..58 run function avalon:input/target
execute if score @s av_state matches 4 if score @a[tag=av.actor,limit=1] av_role matches 5 if score #action av_ctx matches 60 run return run function avalon:input/kill
