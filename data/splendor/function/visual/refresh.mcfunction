# 仅清表现；不改变牌库、预约、last、回合或已提交的支付。
function splendor:visual/clear
execute at @s run function splendor:visual/refresh_at
# terminal-review: 仅终局显示，保留至新局／拆桌。
function splendor:result/show
