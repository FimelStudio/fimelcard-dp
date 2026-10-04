# 当前执行者为本桌控制器；三人局与4至8人分队局使用各自独立的胜负规则。
execute if score @s dc_mode matches 3 run return run function decrypto:game/check_win_three
execute if score @s dc_mode matches 4 run return run function decrypto:game/check_win_four
