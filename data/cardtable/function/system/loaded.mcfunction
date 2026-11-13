# uninstall-guard: begin (tools/build_uninstall.py)
execute if data storage cardtable:uninstall active run return 0
# uninstall-guard: end
# 所有模块加载完成后统一提示；首次安装与后续重载共用此入口。
tellraw @a [{text:"fimel card",color:"gold"},{text:" 数据包加载完成，祝你游戏愉快！",color:"green"}]
