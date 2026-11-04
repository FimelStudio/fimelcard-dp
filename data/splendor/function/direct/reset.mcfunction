scoreboard players set @s sp_pick0 0
scoreboard players set @s sp_pick1 0
scoreboard players set @s sp_pick2 0
scoreboard players set @s sp_pick3 0
scoreboard players set @s sp_pick4 0
scoreboard players set @s sp_pick5 0
scoreboard players operation @s sp_seen = @e[tag=sp.current,limit=1] sp_epoch
scoreboard players set @s sp_panel 1
