# 正式结算后轮换叫分的轮空座位，与上一局出牌时的轮空座位无关。
scoreboard players set @s dd_out 0
function doudizhu:player/audience
scoreboard players operation @s dd_turn = @s dd_bidbye
function doudizhu:round/select_next
scoreboard players operation @s dd_bidbye = @s dd_turn
