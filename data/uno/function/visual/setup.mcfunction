# 只清本桌牌面和文字，不移除整局常驻牌盒、其他游戏或家具。
function uno:visual/clear_cards
function uno:visual/ensure_box
scoreboard players set #seat un_ctx 0
function uno:visual/play
