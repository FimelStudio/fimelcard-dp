scoreboard players operation @a[tag=ct.settings_actor,limit=1] ct_skin_table = @s ct_id
scoreboard players set @a[tag=ct.settings_actor,limit=1] ct_skin_pick 0
scoreboard players enable @a[tag=ct.settings_actor,limit=1] ct_skin_pick
execute if score @s ct_skin matches 0 run function cardtable:skin/dialog {current:"默认"}
execute if score @s ct_skin matches 1 run function cardtable:skin/dialog {current:"典雅"}
