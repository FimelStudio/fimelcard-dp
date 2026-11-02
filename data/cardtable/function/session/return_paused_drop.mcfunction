# @s 是真实原主；不覆盖原有物品、不改变道具组件或牌面。
execute unless items entity @s hotbar.0 * run return run function cardtable:session/return_paused_drop_slot {slot:"hotbar.0"}
execute unless items entity @s hotbar.1 * run return run function cardtable:session/return_paused_drop_slot {slot:"hotbar.1"}
execute unless items entity @s hotbar.2 * run return run function cardtable:session/return_paused_drop_slot {slot:"hotbar.2"}
execute unless items entity @s hotbar.3 * run return run function cardtable:session/return_paused_drop_slot {slot:"hotbar.3"}
execute unless items entity @s hotbar.4 * run return run function cardtable:session/return_paused_drop_slot {slot:"hotbar.4"}
execute unless items entity @s hotbar.5 * run return run function cardtable:session/return_paused_drop_slot {slot:"hotbar.5"}
execute unless items entity @s hotbar.6 * run return run function cardtable:session/return_paused_drop_slot {slot:"hotbar.6"}
execute unless items entity @s hotbar.7 * run return run function cardtable:session/return_paused_drop_slot {slot:"hotbar.7"}
execute unless items entity @s hotbar.8 * run return run function cardtable:session/return_paused_drop_slot {slot:"hotbar.8"}
execute unless items entity @s inventory.0 * run return run function cardtable:session/return_paused_drop_slot {slot:"inventory.0"}
execute unless items entity @s inventory.1 * run return run function cardtable:session/return_paused_drop_slot {slot:"inventory.1"}
execute unless items entity @s inventory.2 * run return run function cardtable:session/return_paused_drop_slot {slot:"inventory.2"}
execute unless items entity @s inventory.3 * run return run function cardtable:session/return_paused_drop_slot {slot:"inventory.3"}
execute unless items entity @s inventory.4 * run return run function cardtable:session/return_paused_drop_slot {slot:"inventory.4"}
execute unless items entity @s inventory.5 * run return run function cardtable:session/return_paused_drop_slot {slot:"inventory.5"}
execute unless items entity @s inventory.6 * run return run function cardtable:session/return_paused_drop_slot {slot:"inventory.6"}
execute unless items entity @s inventory.7 * run return run function cardtable:session/return_paused_drop_slot {slot:"inventory.7"}
execute unless items entity @s inventory.8 * run return run function cardtable:session/return_paused_drop_slot {slot:"inventory.8"}
execute unless items entity @s inventory.9 * run return run function cardtable:session/return_paused_drop_slot {slot:"inventory.9"}
execute unless items entity @s inventory.10 * run return run function cardtable:session/return_paused_drop_slot {slot:"inventory.10"}
execute unless items entity @s inventory.11 * run return run function cardtable:session/return_paused_drop_slot {slot:"inventory.11"}
execute unless items entity @s inventory.12 * run return run function cardtable:session/return_paused_drop_slot {slot:"inventory.12"}
execute unless items entity @s inventory.13 * run return run function cardtable:session/return_paused_drop_slot {slot:"inventory.13"}
execute unless items entity @s inventory.14 * run return run function cardtable:session/return_paused_drop_slot {slot:"inventory.14"}
execute unless items entity @s inventory.15 * run return run function cardtable:session/return_paused_drop_slot {slot:"inventory.15"}
execute unless items entity @s inventory.16 * run return run function cardtable:session/return_paused_drop_slot {slot:"inventory.16"}
execute unless items entity @s inventory.17 * run return run function cardtable:session/return_paused_drop_slot {slot:"inventory.17"}
execute unless items entity @s inventory.18 * run return run function cardtable:session/return_paused_drop_slot {slot:"inventory.18"}
execute unless items entity @s inventory.19 * run return run function cardtable:session/return_paused_drop_slot {slot:"inventory.19"}
execute unless items entity @s inventory.20 * run return run function cardtable:session/return_paused_drop_slot {slot:"inventory.20"}
execute unless items entity @s inventory.21 * run return run function cardtable:session/return_paused_drop_slot {slot:"inventory.21"}
execute unless items entity @s inventory.22 * run return run function cardtable:session/return_paused_drop_slot {slot:"inventory.22"}
execute unless items entity @s inventory.23 * run return run function cardtable:session/return_paused_drop_slot {slot:"inventory.23"}
execute unless items entity @s inventory.24 * run return run function cardtable:session/return_paused_drop_slot {slot:"inventory.24"}
execute unless items entity @s inventory.25 * run return run function cardtable:session/return_paused_drop_slot {slot:"inventory.25"}
execute unless items entity @s inventory.26 * run return run function cardtable:session/return_paused_drop_slot {slot:"inventory.26"}
execute unless items entity @s weapon.offhand * run return run function cardtable:session/return_paused_drop_slot {slot:"weapon.offhand"}
# 满背包时保留实体并允许立即拾回；ct.paused_return 禁止其成为延迟输入。
data merge entity @e[type=minecraft:item,tag=ct.pause_candidate,limit=1] {PickupDelay:0s,Age:0s}
execute at @s run tp @e[type=minecraft:item,tag=ct.pause_candidate,limit=1] ~ ~ ~
