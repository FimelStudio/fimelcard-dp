# 掉线者记分仍记录旧曲，但客户端音频已经中断；恢复时全桌统一重播。
function guandan:music/pause
tag @s remove gd.music_suspended
