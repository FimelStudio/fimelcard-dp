execute unless entity @a[tag=ct.settings_actor,tag=ct.player,limit=1] run return 0
execute unless score @s ct_game matches 20 run return 0
execute unless score @s ct_state matches 0 run return 0
execute if score @s go_state matches 5 run tellraw @a[tag=ct.settings_actor,limit=1] {text:"[围棋] 请先退出复盘，再修改游戏设置。",color:"yellow"}
execute if score @s go_state matches 5 run return 0
scoreboard players operation #ui_setting_table go_ctx = @s ct_id
execute unless score @a[tag=ct.settings_actor,limit=1] ct_id = #ui_setting_table go_ctx run return 0
function weiqi:settings/begin
function weiqi:settings/root
