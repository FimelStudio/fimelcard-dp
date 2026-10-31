# multi_action 至少需要一个按钮；先分发，避免空列表导致宏整条命令解析失败。
execute if data storage gomoku:ui buttons[0] run return run function gomoku:ui/actions_show with storage gomoku:ui
function gomoku:ui/notice_show with storage gomoku:ui
