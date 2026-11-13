# 仅清表现；不改变牌库、预约、last、回合或已提交的支付。
function splendor:visual/clear
execute at @s run function splendor:visual/refresh_at
