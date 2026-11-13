clear @s *[minecraft:custom_data~{avalon:{ballot:1b}}]
execute unless entity @e[tag=av.current,limit=1] run return 0
execute store result storage avalon:ballot table int 1 run scoreboard players get @s av_id
execute store result storage avalon:ballot epoch int 1 run scoreboard players get @e[tag=av.current,limit=1] av_epoch
execute if score @e[tag=av.current,limit=1] av_state matches 2 if score @s av_vote matches 0 run function avalon:player/team_ballots
execute if score @e[tag=av.current,limit=1] av_state matches 3 if score @s av_selected matches 1 if score @s av_mission matches 0 run function avalon:player/mission_ballots
