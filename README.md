# Fimel Cards 26.3

Minecraft Java 26.3 多人卡牌桌游数据包。作者：歪浪Ylong、水晶Cesmos。

[下载](https://studiofimel.com/#/works/fimel-card) · [配套资源包](https://github.com/FimelStudio/fimelcard-rp) · [完整文档](docs/README.md) · [仓库](https://github.com/FimelStudio/fimelcard-dp)

## 安装与游玩前提

1. 将 `fimelcard-datapack` 放入存档的 `datapacks`，确认 `pack.mcmeta` 位于数据包根目录。
2. 每位玩家将配套的 `fimelcard-resourcepack` 放入客户端 `resourcepacks` 并启用。
3. 进入世界执行 `/reload`；更新资源包后按 `F3+T`。
4. 开局前清空全部九格快捷栏，按下表准备人数；花火还需腾空副手。创建、删除和调试命令需要命令权限，局内游玩的权限要求见下表。

部分游戏使用到了前置 [文本动画库](https://space.bilibili.com/648638421)、[BetterTitle](https://github.com/Huoyuyuyu/BetterTitle)、[SK Firework](https://space.bilibili.com/1546917549)，无需另装前置数据包。

牌桌皮肤使用到了16bit制作组的[NyaaWork喵工坊家具](https://space.bilibili.com/2907002)。本包仅将使用到的家具模型加至资源包中，资源归原作者所有。

## 兼容性

本分支适配 Minecraft Java 26.3。Fabric 和钠仅在 26.2 由作者实测兼容，26.3 的联机与画面表现待实测。

| 环境         | 兼容情况                     |
| ------------ | ---------------------------- |
| 原版         | 本包的目标环境，无需额外模组 |
| Fabric       | 26.2 已实测兼容；26.3 待实测                   |
| 钠（Sodium） | 26.2 已实测兼容；26.3 待实测                   |
| Forge        | 尚未验证                     |
| OptiFine     | 尚未验证                     |

额外光影或覆盖字体、文字着色器的资源包组合需另行验证。

## 创建、删除牌桌

在空地执行创建命令，当前位置的高度对应桌面方块层。

**建桌的最小检查距离为 6 格**，按建桌执行位置到已有桌心计算，并非两桌边缘之间需要空出 6 格。四座桌连座椅占地 **5×5**，八座桌占地 **6×6**；同一高度沿直线并排摆放时，两张八座桌想留一格通道，桌心间距至少取 **7 格**。新桌会对齐方块网格，摆放时以最终桌心位置为准。

```mcfunction
# 四座桌：3×3 桌面，含座椅占地 5×5
/function cardtable:admin/create

# 八座桌：4×4 桌面，含座椅占地 6×6
/function cardtable:admin/create8

# 删除 8 格内最近一张牌桌的会话、座椅和交互实体
/function cardtable:admin/remove
```

删除会中止该桌游戏，保留方块桌面；使用主题皮肤的桌子先恢复为默认木桌。剩余方块可自行拆除。

已有桌面可用以下命令注册，不改动方块：四座桌站在 3×3 桌面中心方块上；八座桌站在 4×4 桌面的中心交界点上。

```mcfunction
/function cardtable:admin/create_safe
/function cardtable:admin/create8_safe
```

右键空座入座，在中央选择游戏、调整设置并开始；桌边“规则介绍”随时可看。大厅潜行下马即离桌；游戏中下马保留参与身份，右键原座可坐回。点击“结束游戏”投票提前结束，所需票数显示在按钮上。

## 游戏

人数为游戏上限，四座桌最多容纳 4 人；超过 4 人请使用八座桌。斗地主可用人机补位。下表标注局内正常操作的权限；建桌、删桌、调试和管理员中止命令仍需管理员权限（OP）。

| 游戏介绍与命令                      | 人数          | 玩家权限                                | 玩法                               |
| ----------------------------------- | ------------- | --------------------------------------- | ---------------------------------- |
| [Fast Card](<docs/Fast%20Card.md>)   | 4             | 无需 OP                                 | 轮流传牌，凑出牌型后抢按按钮       |
| [赌命德州扑克](docs/赌命德州扑克.md) | 2～8          | 无需 OP                                 | 跟注、换牌与全押，败者接受左轮判定 |
| [花火](docs/花火.md)                 | 2～5          | 无需 OP                                 | 看见他人手牌，通过提示合作接出烟花 |
| [出包魔法师](docs/出包魔法师.md)     | 2～5          | 无需 OP                                 | 猜测自己的隐藏咒语石，施法争取积分 |
| [瞎掰王](docs/瞎掰王.md)             | 3～8          | 无需 OP                                 | 围绕题目即兴作答，辨认真话与瞎掰   |
| [谍报风云](docs/谍报风云.md)         | 3～8          | 书模式无需；文字对话框提交需加密者有 OP | 编写线索、解码己方密码并拦截对手   |
| [临界点](docs/临界点.md)             | 3～6          | 无需 OP                                 | 隐藏身份，秘密出牌与最终投票       |
| [问非所答](docs/问非所答.md)         | 2～8          | 书模式无需；文字对话框提交需回答者有 OP | 根据他人的回答猜题，再由回答者评分 |
| [骷髅牌](docs/骷髅牌.md)             | 2～6          | 无需 OP                                 | 秘密扣牌、竞价翻牌，避开骷髅       |
| [斗地主](docs/斗地主.md)             | 3（可含人机） | 无需 OP                                 | 叫地主、组合出牌，支持多局累计计分 |

**十款游戏在默认设置下均可由普通玩家游玩。** 谍报风云、问非所答默认使用书模式；切换为文字对话框输入时，提交文字的玩家需要 OP。

## 调试与局内命令模板

以下由有权限的玩家在聊天栏执行。中止附近的游戏无需填写桌号：

```mcfunction
# 中止 8 格内最近一场斗地主，返回大厅并保留牌桌
/function doudizhu:admin/abort
```

十个游戏均支持 `/function <命名空间>:admin/abort`，命名空间见[文档索引](docs/README.md)。命令只中止同维度 8 格内最近一场对应游戏，其他桌不受影响，无需填写桌号；各游戏文档提供完整命令。

需要精确指定某张桌子时，再查询自己所属的桌号：

```mcfunction
/scoreboard players get @s ct_id
```

将下面的 `1` 换成该桌号，可查询游戏编号或精确中止对局；`game/abort` 是供控制器执行的内部入口：

```mcfunction
/scoreboard players get @e[type=minecraft:marker,tag=ct.controller,scores={ct_id=1},limit=1] ct_game

# 中止这张桌子的斗地主并回大厅；其他游戏替换命名空间和游戏编号
/execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_id=1,ct_game=10,ct_state=1},limit=1] at @s run function doudizhu:game/abort
```

游戏编号与命名空间见[文档索引](docs/README.md)，可用命令见各游戏介绍。控制器命令在该桌所在维度、区块已加载时执行；`/trigger` 仅在游戏开放的阶段可用，具体参数见各游戏文档。

```mcfunction
# 自己接收 Debug 日志 / 停止接收
/tag @s add ct.debug
/tag @s remove ct.debug

# 手动测试日志
/function cardtable:log {text:"测试牌桌日志"}
```

只有带 `ct.debug` 标签的玩家接收日志，入座不会自动开启。卡桌时记录游戏名、桌号、操作阶段和日志；座位缺失可先尝试 `/reload`，仍无法继续时按对应游戏命令中止。

皮肤、表情包、语音及内置库资料见[牌桌与互动](docs/牌桌与互动.md)；开发见[新卡牌游戏接入规范](docs/新卡牌游戏接入规范.md)，发布前检查见[验收清单](docs/验收清单.md)。
