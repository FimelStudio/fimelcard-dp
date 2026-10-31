# multi_action 至少需要一个按钮；先分发，避免空列表导致宏整条命令解析失败。
execute if data storage xiangqi:ui buttons[0] run return run function xiangqi:ui/actions_show with storage xiangqi:ui
function xiangqi:ui/notice_show with storage xiangqi:ui
