function catan:ui/begin
scoreboard players set @s ca_panel 3
data modify storage catan:ui title set value "卡坦岛 · 资源操作"
data modify storage catan:ui columns set value 2
execute if score @s ca_edit matches 2 run data modify storage catan:ui columns set value 4
execute if score @s ca_edit matches 2 run data modify storage catan:ui button_width set value 110
function catan:ui/editor_summary
execute if score @s ca_edit matches 1 run function catan:ui/icon_button {"code":1000,"label":"弃 木材 +","color":"yellow","icon":""}
execute if score @s ca_edit matches 1 run function catan:ui/icon_button {"code":1010,"label":"弃 木材 −","color":"gray","icon":""}
execute if score @s ca_edit matches 2 run function catan:ui/icon_button {"code":1000,"label":"给 木材 +","color":"yellow","icon":""}
execute if score @s ca_edit matches 2 run function catan:ui/icon_button {"code":1010,"label":"给 木材 −","color":"gray","icon":""}
execute if score @s ca_edit matches 2 run function catan:ui/icon_button {"code":1020,"label":"索 木材 +","color":"aqua","icon":""}
execute if score @s ca_edit matches 2 run function catan:ui/icon_button {"code":1030,"label":"索 木材 −","color":"gray","icon":""}
execute if score @s ca_edit matches 3 run function catan:ui/icon_button {"code":1100,"label":"支付 木材","color":"yellow","icon":""}
execute if score @s ca_edit matches 3 run function catan:ui/icon_button {"code":1110,"label":"换取 木材","color":"aqua","icon":""}
execute if score @s ca_edit matches 5 run function catan:ui/icon_button {"code":1120,"label":"第一张 木材","color":"aqua","icon":""}
execute if score @s ca_edit matches 4 run function catan:ui/icon_button {"code":1120,"label":"垄断 木材","color":"aqua","icon":""}
execute if score @s ca_edit matches 5 run function catan:ui/icon_button {"code":1130,"label":"第二张 木材","color":"yellow","icon":""}
execute if score @s ca_edit matches 1 run function catan:ui/icon_button {"code":1001,"label":"弃 砖块 +","color":"yellow","icon":""}
execute if score @s ca_edit matches 1 run function catan:ui/icon_button {"code":1011,"label":"弃 砖块 −","color":"gray","icon":""}
execute if score @s ca_edit matches 2 run function catan:ui/icon_button {"code":1001,"label":"给 砖块 +","color":"yellow","icon":""}
execute if score @s ca_edit matches 2 run function catan:ui/icon_button {"code":1011,"label":"给 砖块 −","color":"gray","icon":""}
execute if score @s ca_edit matches 2 run function catan:ui/icon_button {"code":1021,"label":"索 砖块 +","color":"aqua","icon":""}
execute if score @s ca_edit matches 2 run function catan:ui/icon_button {"code":1031,"label":"索 砖块 −","color":"gray","icon":""}
execute if score @s ca_edit matches 3 run function catan:ui/icon_button {"code":1101,"label":"支付 砖块","color":"yellow","icon":""}
execute if score @s ca_edit matches 3 run function catan:ui/icon_button {"code":1111,"label":"换取 砖块","color":"aqua","icon":""}
execute if score @s ca_edit matches 5 run function catan:ui/icon_button {"code":1121,"label":"第一张 砖块","color":"aqua","icon":""}
execute if score @s ca_edit matches 4 run function catan:ui/icon_button {"code":1121,"label":"垄断 砖块","color":"aqua","icon":""}
execute if score @s ca_edit matches 5 run function catan:ui/icon_button {"code":1131,"label":"第二张 砖块","color":"yellow","icon":""}
execute if score @s ca_edit matches 1 run function catan:ui/icon_button {"code":1002,"label":"弃 羊毛 +","color":"yellow","icon":""}
execute if score @s ca_edit matches 1 run function catan:ui/icon_button {"code":1012,"label":"弃 羊毛 −","color":"gray","icon":""}
execute if score @s ca_edit matches 2 run function catan:ui/icon_button {"code":1002,"label":"给 羊毛 +","color":"yellow","icon":""}
execute if score @s ca_edit matches 2 run function catan:ui/icon_button {"code":1012,"label":"给 羊毛 −","color":"gray","icon":""}
execute if score @s ca_edit matches 2 run function catan:ui/icon_button {"code":1022,"label":"索 羊毛 +","color":"aqua","icon":""}
execute if score @s ca_edit matches 2 run function catan:ui/icon_button {"code":1032,"label":"索 羊毛 −","color":"gray","icon":""}
execute if score @s ca_edit matches 3 run function catan:ui/icon_button {"code":1102,"label":"支付 羊毛","color":"yellow","icon":""}
execute if score @s ca_edit matches 3 run function catan:ui/icon_button {"code":1112,"label":"换取 羊毛","color":"aqua","icon":""}
execute if score @s ca_edit matches 5 run function catan:ui/icon_button {"code":1122,"label":"第一张 羊毛","color":"aqua","icon":""}
execute if score @s ca_edit matches 4 run function catan:ui/icon_button {"code":1122,"label":"垄断 羊毛","color":"aqua","icon":""}
execute if score @s ca_edit matches 5 run function catan:ui/icon_button {"code":1132,"label":"第二张 羊毛","color":"yellow","icon":""}
execute if score @s ca_edit matches 1 run function catan:ui/icon_button {"code":1003,"label":"弃 粮食 +","color":"yellow","icon":""}
execute if score @s ca_edit matches 1 run function catan:ui/icon_button {"code":1013,"label":"弃 粮食 −","color":"gray","icon":""}
execute if score @s ca_edit matches 2 run function catan:ui/icon_button {"code":1003,"label":"给 粮食 +","color":"yellow","icon":""}
execute if score @s ca_edit matches 2 run function catan:ui/icon_button {"code":1013,"label":"给 粮食 −","color":"gray","icon":""}
execute if score @s ca_edit matches 2 run function catan:ui/icon_button {"code":1023,"label":"索 粮食 +","color":"aqua","icon":""}
execute if score @s ca_edit matches 2 run function catan:ui/icon_button {"code":1033,"label":"索 粮食 −","color":"gray","icon":""}
execute if score @s ca_edit matches 3 run function catan:ui/icon_button {"code":1103,"label":"支付 粮食","color":"yellow","icon":""}
execute if score @s ca_edit matches 3 run function catan:ui/icon_button {"code":1113,"label":"换取 粮食","color":"aqua","icon":""}
execute if score @s ca_edit matches 5 run function catan:ui/icon_button {"code":1123,"label":"第一张 粮食","color":"aqua","icon":""}
execute if score @s ca_edit matches 4 run function catan:ui/icon_button {"code":1123,"label":"垄断 粮食","color":"aqua","icon":""}
execute if score @s ca_edit matches 5 run function catan:ui/icon_button {"code":1133,"label":"第二张 粮食","color":"yellow","icon":""}
execute if score @s ca_edit matches 1 run function catan:ui/icon_button {"code":1004,"label":"弃 矿石 +","color":"yellow","icon":""}
execute if score @s ca_edit matches 1 run function catan:ui/icon_button {"code":1014,"label":"弃 矿石 −","color":"gray","icon":""}
execute if score @s ca_edit matches 2 run function catan:ui/icon_button {"code":1004,"label":"给 矿石 +","color":"yellow","icon":""}
execute if score @s ca_edit matches 2 run function catan:ui/icon_button {"code":1014,"label":"给 矿石 −","color":"gray","icon":""}
execute if score @s ca_edit matches 2 run function catan:ui/icon_button {"code":1024,"label":"索 矿石 +","color":"aqua","icon":""}
execute if score @s ca_edit matches 2 run function catan:ui/icon_button {"code":1034,"label":"索 矿石 −","color":"gray","icon":""}
execute if score @s ca_edit matches 3 run function catan:ui/icon_button {"code":1104,"label":"支付 矿石","color":"yellow","icon":""}
execute if score @s ca_edit matches 3 run function catan:ui/icon_button {"code":1114,"label":"换取 矿石","color":"aqua","icon":""}
execute if score @s ca_edit matches 5 run function catan:ui/icon_button {"code":1124,"label":"第一张 矿石","color":"aqua","icon":""}
execute if score @s ca_edit matches 4 run function catan:ui/icon_button {"code":1124,"label":"垄断 矿石","color":"aqua","icon":""}
execute if score @s ca_edit matches 5 run function catan:ui/icon_button {"code":1134,"label":"第二张 矿石","color":"yellow","icon":""}
execute if score @s ca_edit matches 3 run function catan:ui/button {"code":1140,"label":"兑换批数 +","color":"yellow"}
execute if score @s ca_edit matches 3 run function catan:ui/button {"code":1141,"label":"兑换批数 −","color":"gray"}
execute if score @s ca_edit matches 1 run function catan:ui/button {"code":351,"label":"确认弃牌","color":"green"}
execute if score @s ca_edit matches 2 run function catan:ui/button {"code":350,"label":"提交报价","color":"green"}
execute if score @s ca_edit matches 3 run function catan:ui/button {"code":352,"label":"确认兑换","color":"green"}
execute if score @s ca_edit matches 4 run function catan:ui/button {"code":353,"label":"确认垄断","color":"green"}
execute if score @s ca_edit matches 5 run function catan:ui/button {"code":354,"label":"确认丰收","color":"green"}
function catan:ui/show with storage catan:ui
