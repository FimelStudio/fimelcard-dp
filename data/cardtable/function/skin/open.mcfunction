# 控制器执行；保持各游戏自己的设置分派不变。
execute unless score @s ct_skin matches 0..1 run scoreboard players set @s ct_skin 0
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ct_skin_table = @s ct_id
scoreboard players set @a[tag=ct.settings_actor,limit=1] ct_skin_pick 0
scoreboard players enable @a[tag=ct.settings_actor,limit=1] ct_skin_pick
function cardtable:game/open_settings
