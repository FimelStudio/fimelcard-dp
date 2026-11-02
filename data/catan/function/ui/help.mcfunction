# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function catan:ui/begin
data modify storage catan:ui title set value "卡坦岛 · 新手入门"
data modify storage catan:ui note set value {"text":"","extra":[{"text":"两件操作物\n","color":"gold"},{"text":"第9格按 Q：菜单。第1格按 Q：瞄准放置；近处也可右键棋盘。位置先变金色，再确认，不会误点就扣费。\n\n","color":"white"},{"text":"交点、边、地块\n","color":"gold"},{"text":"村庄／城市放地块交会的交点；道路放两交点之间的边；强盗放六边形地块中央。先在菜单选择建什么，再回棋盘瞄准。\n\n","color":"white"},{"text":"开局先免费布置两组\n","color":"gold"},{"text":"每人依次放村庄＋相邻道路，再倒序各放第二组（末位连续放两组）。只有第二个村庄领取起始资源；村庄之间至少隔一个空交点。\n\n","color":"white"},{"text":"每轮该做什么\n","color":"gold"},{"text":"轮到你先从菜单投骰。按数字为所有相邻建筑生产资源；然后交易、建造、买／用开发牌，最后主动点击「结束回合」。7点须由所有超7张资源的玩家各弃一半，再由掷骰者移动强盗并选择偷谁。\n\n","color":"white"},{"text":"如何赢与卡住时怎么办\n","color":"gold"},{"text":"村庄1分、城市2分；最长道路与最大军队各2分，胜利点牌私下计分。自己回合先到10分获胜。缺资源可交易或用港口；没事可做就结束回合。看本菜单顶部和屏幕下方的个人提示即可找到下一步。","color":"white"}]}
function catan:ui/button {"code":280,"label":"返回对局菜单","color":"green"}
function catan:ui/show with storage catan:ui
