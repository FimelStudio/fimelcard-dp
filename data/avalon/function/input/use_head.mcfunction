$execute unless score @s av_id matches $(table) run return 0
execute unless score @s av_id = @s ct_id run return 0
function avalon:bind
execute unless entity @e[tag=av.current,scores={av_state=1},limit=1] run return 0
$execute unless score @e[tag=av.current,limit=1] av_epoch matches $(epoch) run return 0
execute unless score @s av_seat = @e[tag=av.current,limit=1] av_leader run return 0
$scoreboard players set #action av_ctx $(seat)
execute as @e[tag=av.current,limit=1] run function avalon:context
execute as @e[tag=av.current,limit=1] run function avalon:input/toggle
execute as @e[tag=av.current,limit=1] run function avalon:player/heads
