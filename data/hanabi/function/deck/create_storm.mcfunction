# 彩色风暴牌每个数字仅一张，作为可以独立提示的第六种颜色
scoreboard players set #deck_color hb_ctx 6
scoreboard players set #deck_copies hb_ctx 1
scoreboard players set #deck_rank hb_ctx 1
function hanabi:deck/create_one
scoreboard players set #deck_rank hb_ctx 2
function hanabi:deck/create_one
scoreboard players set #deck_rank hb_ctx 3
function hanabi:deck/create_one
scoreboard players set #deck_rank hb_ctx 4
function hanabi:deck/create_one
scoreboard players set #deck_rank hb_ctx 5
function hanabi:deck/create_one
