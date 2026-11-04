execute unless entity @e[tag=sp.current,scores={sp_state=3},limit=1] run return 0
scoreboard players operation @s sp_seen = @e[tag=sp.current,limit=1] sp_epoch
function splendor:ui/submit_noble
