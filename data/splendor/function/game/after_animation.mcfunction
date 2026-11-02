scoreboard players set @s sp_anim 0
execute as @a[tag=sp.audience] if score @s sp_side = @e[tag=sp.current,limit=1] sp_turn if entity @e[tag=sp.current,scores={sp_state=2..3},limit=1] run function splendor:ui/open
