游戏图标：1至21.png均为256×256。原有10个PNG取自原作者提供的icon文件夹；新增11个图标沿用所提供SVG风格制作，源SVG与导出PNG保留。四人桌20项、八人桌21项，按5列显示，悬停显示名称和人数；每图8条纹理切片映射同一安全trigger命令。

日常只重建选游窗口：在数据包根目录运行 `python tools/game_picker_ui.py`。该工具依据本目录的 `picker4-original.json`、`picker8-original.json` 重建JSON界面，不生成纹理、不修改资源包；游戏注册脚本也通过同一适配器保留图标布局与已登记游戏。

旧工具 `tools/build_game_icons.py` 依赖原作者本机的原画目录及Sharp缓存路径，末尾还会复制到另一个资源包。它保留为制作过程记录，不能作为通用自动重建入口；重新制作原画时须先核对这些路径及复制目标。

检查：`node tools/check_game_picker.mjs` 验证21张PNG、字体切片、字距、人数与命令；`python tools/test_game_picker_icons.py --java <Java25路径>` 验证原版窗口宏；`python tools/test_boardgame_registration.py` 在临时副本检查注册幂等及未来编号保留。客户端外观和真人点击仍需游戏内验收。
