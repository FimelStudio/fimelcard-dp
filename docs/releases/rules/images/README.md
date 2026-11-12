# 说明书图片与来源

这些图片与说明书一起存入仓库，可以把整个 `rules` 文件夹复制到发布目录或网站。图片使用相对链接，不依赖桌面路径。

## 内容

- `icons/`：23 个游戏的现用图标，`preview.png` 每行五个；22 号为当前璀璨宝石圆角图标。
- `components/`：卡牌实际正面与立体组件独立实图。棋子、骰子、建筑、棋盘均从资源包 Java 模型及 UV 渲染；扑克牌、身份牌、角色牌使用真实纹理正面，动画只取首帧。
- `catalogs/`：组件拼图，每格带中文名称。仅数字、花色、皮肤变化的重复版式选代表图；不同费用、不同能力的卡与选手完整保留。
- `boards/`：卡坦岛四座／八座、两方向的完整棋盘模型预览，取自资源包 `.source/catan/board_preview_*.png`。
- `extra/`：迁移保留的阿瓦隆路线图、卡坦岛结构示意，作为布局参考。
- `manifest.json`：独立组件实图的源资源标识、展示方式与 SHA-256；数字牌不展开 100 张。

图是资源预览，不冒充 Minecraft 游戏截图。光照、玩家皮肤、粒子、发光轮廓、实时 HUD、文字窗口随运行状态变化；这些内容由说明书的操作步骤解释，没有为它们留下必填截图任务。

## 更新方法

在数据包根目录执行：

```powershell
# 安装一次生成依赖
python -m pip install Pillow numpy
# 更新图鉴图片和说明书里的组件区，保留人工规则正文
python tools/build_release_rules.py
# 仅核对图片、哈希与所有说明书链接
python tools/build_release_rules.py --check
```

工具默认使用同版本相邻资源包 `resourcepacks/fimelcard-rp`，原版物品读取本机已安装的 Minecraft 客户端 JAR。矢量图标使用 `tools/build_splendor_icon.py --publish-dir docs/releases/rules/images/icons` 同步，按现有 SVG 生成，不重绘卡牌。

请直接修改每个游戏说明书的正文。`BEGIN COMPONENTS` 与 `END COMPONENTS` 之间是生成区，修改资源后重建会覆盖该区；不要把规则正文写进去。

## 署名与使用边界

资源仍遵守原资源的署名和许可。Minecraft 原版物品纹理属于 Mojang；牌桌使用的 NyaaWork／16bit 制作组家具与国际象棋模型等保留上游权利。卡坦岛的 Kenney 地形素材为 CC0，立体适配、胡闹运动会选手几何及本包自制牌面沿用项目内源文件说明。具体作者、来源和许可查配套资源包 `.source/` 及[仓库署名](../../../../README.md)。生成说明书图片不改变资源许可。
