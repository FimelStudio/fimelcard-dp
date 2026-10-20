scoreboard players operation @a[tag=ct.settings_actor,limit=1] ct_skin_table = @s ct_id
scoreboard players set @a[tag=ct.settings_actor,limit=1] ct_skin_pick 0
scoreboard players enable @a[tag=ct.settings_actor,limit=1] ct_skin_pick
execute if score @s ct_skin matches 0 run function cardtable:skin/dialog {current:"默认"}
execute if score @s ct_skin matches 1 run function cardtable:skin/dialog {current:"典雅"}
execute if score @s ct_skin matches 2 run function cardtable:skin/dialog {current:"电子音乐"}
execute if score @s ct_skin matches 3 run function cardtable:skin/dialog {current:"玩偶乐园"}
execute if score @s ct_skin matches 4 run function cardtable:skin/dialog {current:"欧式复古"}
execute if score @s ct_skin matches 5 run function cardtable:skin/dialog {current:"竹影茶室"}
execute if score @s ct_skin matches 6 run function cardtable:skin/dialog {current:"春日花园"}
