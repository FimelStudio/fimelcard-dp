scoreboard players set @s sp_anim 0
execute as @a[tag=sp.audience] if score @s sp_side = @e[tag=sp.current,limit=1] sp_turn run function splendor:direct/pending
