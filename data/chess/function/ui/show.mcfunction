# multi_action 至少需要一个按钮；先分发，避免空列表导致宏整条命令解析失败。
execute if data storage chess:ui buttons[0] run return run function chess:ui/actions_show with storage chess:ui
function chess:ui/notice_show with storage chess:ui
