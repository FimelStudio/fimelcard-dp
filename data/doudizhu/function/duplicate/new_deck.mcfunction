data modify storage doudizhu:deck duplicate set value []
execute if score @s dd_noshuffle matches 1 run return run function doudizhu:duplicate/ordered_deck
data modify storage doudizhu:deck queue set value [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54]
scoreboard players set #remaining dd_ctx 54
function doudizhu:duplicate/shuffle
data modify entity @s data.dd_duplicate.deck set from storage doudizhu:deck duplicate
