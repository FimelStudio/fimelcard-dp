from __future__ import annotations

import re
import shutil
from dataclasses import dataclass
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
DOCS = ROOT / "docs"
TARGET = Path(r"C:\Users\柳浪一\Desktop\卡牌数据包资源包发布版\游戏规则")


@dataclass(frozen=True)
class Game:
    number: int
    title: str
    source: str
    namespace: str
    players: str
    table: str
    permission: str
    shot: str
    tip: str

    @property
    def filename(self) -> str:
        return f"{self.number:02d}-{self.title}.md"


GAMES = [
    Game(1, "Fast Card", "Fast Card.md", "fast_card", "4 人", "四座桌或八座桌", "普通玩家无需管理员权限", "传牌中的四人牌桌、桌心抢按按钮与积分显示", "先观察传牌方向和别人是否已经抢按；凑成高价值组合时，反应速度和牌型判断同样重要。"),
    Game(2, "赌命德州扑克", "赌命德州扑克.md", "liars_holdem", "2～8 人", "2～4 人用四座桌，5～8 人用八座桌", "普通玩家无需管理员权限", "公共牌、玩家手牌 HUD 与 Call／Fold 操作物", "换牌不消耗本阶段行动；ALL IN 会让所有尚未弃牌的玩家立即作出最终选择。"),
    Game(3, "花火", "花火.md", "hanabi", "2～5 人", "2～4 人用四座桌，5 人用八座桌", "普通玩家无需管理员权限", "自己的隐藏手牌、队友公开手牌和烟花进度", "提示必须覆盖目标手中所有同色或同数字的牌；记住别人已经获得的信息比频繁提示更重要。"),
    Game(4, "出包魔法师", "出包魔法师.md", "abraca", "2～5 人", "2～4 人用四座桌，5 人用八座桌", "普通玩家无需管理员权限", "咒语石 HUD、生命显示与施法操作牌", "连续施法的编号只能不降；安全结束回合有时比继续赌一张未知咒语更划算。"),
    Game(5, "瞎掰王", "瞎掰王.md", "bullshit", "3～8 人", "3～4 人用四座桌，5～8 人用八座桌", "普通玩家无需管理员权限", "阅读题目、自由问答和最终指认三个阶段", "老实人也要说得自然，瞎掰人则应利用关键词保持前后一致；大聪明可以用追问验证细节。"),
    Game(6, "谍报风云", "谍报风云.md", "decrypto", "3～8 人", "3～4 人用四座桌，5～8 人用八座桌", "书模式无需管理员权限；文字对话框提交提示需要 OP", "秘密词语、三条提示输入与历轮密电记录", "提示既要让队友理解，又要避免给对手建立稳定对应关系；不要使用私人暗号。"),
    Game(7, "临界点", "临界点.md", "critical_point", "3～6 人", "3～4 人用四座桌，5～6 人用八座桌", "普通玩家无需管理员权限", "表态、秘密出牌与最终投票界面", "表态可以制造信息但不约束实际出牌；狼人需要让总数或投票结果偏离村民预期。"),
    Game(8, "问非所答", "问非所答.md", "wenfei", "2～8 人", "2～4 人用四座桌，5～8 人用八座桌", "书模式无需管理员权限；文字对话框提交回答需要 OP", "秘密问题、公开答案与五档评分界面", "回答应能提示真正的问题，又不要直接暴露题目；猜题者必须把 0～4 分各使用一次。"),
    Game(9, "骷髅牌", "骷髅牌.md", "skull", "2～6 人", "2～4 人用四座桌，5～6 人用八座桌", "普通玩家无需管理员权限", "各玩家扣牌堆、叫号窗口与翻牌结果", "挑战者必须先翻完自己的牌；记住别人曾经如何放牌，比单纯抬高叫号更可靠。"),
    Game(10, "经典斗地主", "斗地主.md", "doudizhu", "1～3 名真人，不足三人由测试人机补位", "四座桌或八座桌", "普通玩家无需管理员权限", "BetterTitle 手牌 HUD、选牌窗口和桌面出牌", "先辨认牌型主体再比较大小；炸弹与春天会叠乘倍数，残局中保留控制牌通常更有价值。"),
    Game(11, "UNO", "UNO.md", "uno", "2～8 人", "2～4 人用四座桌，5～8 人用八座桌", "普通玩家无需管理员权限", "手牌 HUD、选牌窗口、牌盒与座位前的弃牌", "只剩一张牌时要及时喊 UNO；变色 +4 的合法性由系统按出牌前的手牌自动判断。"),
    Game(12, "国际象棋", "国际象棋.md", "chess", "1～2 人，单人自动对战人机", "四座桌或八座桌", "普通玩家无需管理员权限", "棋盘全景、可走格提示、计时与吃子区", "白方始终先行；先选棋子再选目标格，系统会拦截使己方王暴露的非法走法。"),
    Game(13, "中国象棋", "中国象棋.md", "xiangqi", "1～2 人，单人自动对战人机", "四座桌或八座桌", "普通玩家无需管理员权限", "棋盘全景、选中棋子与右侧吃子区", "将帅不能照面；揭棋模式下，暗子第一次按所在位置对应棋子的走法行动，翻开后使用真实身份。"),
    Game(14, "五子棋", "五子棋.md", "gomoku", "1～2 人，单人自动对战人机", "四座桌或八座桌", "普通玩家无需管理员权限", "13／15／19 路棋盘、最后一手与五连高亮", "当前没有禁手，黑白双方都以横、竖或斜线先连成五子为胜。"),
    Game(15, "飞行棋", "飞行棋.md", "aeroplane_chess", "1～4 人；关闭人机补位时至少 2 人", "四座桌或八座桌", "普通玩家无需管理员权限", "完整棋盘、四方飞机、骰子动画和可选棋子", "只有己方回合才会获得骰子；掷出可行动结果后，再从系统给出的合法飞机中选择。"),
    Game(16, "阿瓦隆", "阿瓦隆.md", "avalon", "5～8 人", "仅八座桌", "普通玩家无需管理员权限", "身份查看、组队、任务投票和刺杀阶段", "善良方需要通过队伍与任务结果交换信息；梅林应提供方向，同时避免被刺客准确识别。"),
    Game(17, "情书", "情书.md", "love_letter", "2～6 人", "四座桌或八座桌", "普通玩家无需管理员权限", "手牌 HUD、角色牌说明和目标选择窗口", "每回合只保留一张牌；通过已打出的角色和其他玩家的行动推断其手牌。"),
    Game(18, "掼蛋", "掼蛋.md", "guandan", "1～4 名真人，空位由测试人机补齐", "四座桌或八座桌", "普通玩家无需管理员权限", "BetterTitle 双副牌手牌、叠牌选择与桌面出牌", "同队玩家隔座而坐；先判断本局级牌和逢人配，再按牌型与张数比较。"),
    Game(19, "命悬一线", "命悬一线.md", "ito", "2～8 人", "2～4 人用四座桌，5～8 人用八座桌", "文字对话框提交需要 OP", "蛛丝合作排序或红线配对抢分的完整一轮", "发言只能围绕题目的相对程度，不应直接说出自己的数字。"),
    Game(20, "围棋", "围棋.md", "weiqi", "1～2 人，单人可对战基础人机", "四座桌或八座桌", "普通玩家无需管理员权限", "13／15／19 路棋盘、占地估算和死子确认", "黑先，落子后无气的棋串会被提走；终局需要双方停一手并共同确认死子。"),
    Game(21, "卡坦岛", "卡坦岛.md", "catan", "3～4 名真人", "四座桌或八座桌", "普通玩家无需管理员权限", "六边形岛屿、资源产出、道路与聚落模型", "前两轮放置决定整局资源结构；数字概率、港口和最长道路应一起考虑。"),
    Game(22, "璀璨宝石", "璀璨宝石.md", "splendor", "2～4 名真人", "四座桌或八座桌", "普通玩家无需管理员权限", "三层发展卡、宝石筹码、黄金和贵族区", "永久折扣会降低后续卡牌成本；黄金可以代替任意颜色，但通常需要通过预留获得。"),
    Game(23, "胡闹运动会", "胡闹运动会.md", "magical_athlete", "2～6 名真人", "2～4 人用四座桌，5～6 人用八座桌", "普通玩家无需管理员权限", "运动场棋盘、选手棋子、骰子与能力选择", "整场进行四场比赛；招募阶段要兼顾单卡能力、组合联动和不同赛道的风险。"),
]


SKIP_HEADINGS = {
    "验收",
    "制作与维护",
    "制作与接口",
    "维护入口",
    "维护",
    "资源与性能",
    "资源与重建",
    "来源与维护",
    "制作与规则来源",
}


def remove_repo_links(text: str) -> str:
    def replace_link(match: re.Match[str]) -> str:
        label, href = match.group(1), match.group(2)
        if href.startswith(("http://", "https://", "#")):
            return match.group(0)
        return label

    text = re.sub(r"\[([^\]]+)\]\(([^)]+)\)", replace_link, text)
    text = re.sub(r"\s*安装和建桌见\s*(?:README|主说明|玩家指南)[^。]*。", "", text)
    text = text.replace("[README](../README.md)", "项目安装说明")
    text = text.replace("[主说明](../README.md)", "项目安装说明")
    text = text.replace("[玩家指南与通用管理命令](../README.md)", "项目安装说明")
    return text


def clean_source(game: Game) -> str:
    source = (DOCS / game.source).read_text(encoding="utf-8").replace("\r\n", "\n")
    lines = source.splitlines()
    out: list[str] = []
    skip_section = False
    first_h1 = False
    in_fence = False
    paragraph: list[str] = []

    def flush_paragraph() -> None:
        nonlocal paragraph
        if not paragraph:
            return
        joined = "\n".join(paragraph)
        developer_markers = (
            "运行 `node tools/",
            "运行 `python tools/",
            "生成器为 `tools/",
            "维护入口：",
            "资源重建：",
            "源图保存在资源包",
            "已有原版 26.2",
            "现有检查覆盖",
            "人工复测",
            "客户端待测",
            "客户端仍需检查",
            "服务端检查不代替",
            "主要接口：",
            "题库由 `tools/",
            "维护题目时同步",
            "八套主题源图",
        )
        developer_fragments = ("tools/", ".mcfunction", "../data/", "skull-art/")
        if not any(marker in joined for marker in developer_markers) and not any(
            fragment in joined for fragment in developer_fragments
        ):
            out.extend(paragraph)
            out.append("")
        paragraph = []

    for line in lines:
        if line.startswith("# ") and not first_h1:
            first_h1 = True
            continue
        if line.startswith("## "):
            flush_paragraph()
            heading = line[3:].strip()
            skip_section = heading in SKIP_HEADINGS
            if not skip_section:
                out.append(line)
                out.append("")
            continue
        if skip_section:
            continue
        if line.startswith("```"):
            flush_paragraph()
            in_fence = not in_fence
            out.append(line)
            continue
        if in_fence:
            out.append(line)
            continue
        if not line.strip():
            flush_paragraph()
            continue
        paragraph.append(line)
    flush_paragraph()

    text = "\n".join(out).strip()
    text = remove_repo_links(text)
    text = re.sub(r"(?m)^(?:游戏编号|编号)\s+[^\n。]*。\s*", "", text)
    text = text.replace("安装与建桌见项目 README。", "")
    text = text.replace("测试人机", "补位人机（测试版）")
    text = text.replace("19 号为同伴的命悬一线，编号不变。", "")
    text = text.replace("可编辑模型与生成脚本保存在资源包 `.source/xiangqi/`；", "")
    text = text.replace("原文件、来源及哈希随资源包保留。", "")
    text = text.replace("原文件、来源、许可、哈希及制作脚本保留在资源包 `.source/catan/`。", "")
    text = re.sub(r"角色插画、牌背、牌盒与标记由本项目制作，[^。]*\.source/love_letter/`。", "", text)
    heading_replacements = {
        "## 管理员与维护": "## 管理员命令与对局恢复",
        "## 管理与维护": "## 管理员命令与对局恢复",
        "## 管理与中断": "## 管理员命令与对局恢复",
        "## 管理与资源": "## 管理员命令与对局恢复",
        "## 设置、命令与维护": "## 游戏设置与管理员命令",
        "## 命令与维护": "## 操作命令与对局恢复",
    }
    for old, new in heading_replacements.items():
        text = text.replace(old, new)
    text = re.sub(r"\n{3,}", "\n\n", text)
    return text


def insert_before_first(text: str, patterns: tuple[str, ...], addition: str) -> str:
    matches = []
    for pattern in patterns:
        found = re.search(pattern, text, flags=re.MULTILINE)
        if found:
            matches.append(found.start())
    if not matches:
        return text + "\n\n" + addition
    pos = min(matches)
    return text[:pos].rstrip() + "\n\n" + addition + "\n\n" + text[pos:].lstrip()


def build_game(game: Game) -> str:
    body = clean_source(game)
    operation_shot = (
        f"> 📷 **截图位：核心操作**  \n"
        f"> 建议补充“{game.shot}”的实机截图。文件可命名为 "
        f"`images/screenshots/{game.number:02d}-{game.title}-操作.webp`。"
    )
    setting_shot = (
        f"> 📷 **截图位：设置界面**  \n"
        f"> 建议补充本游戏设置对话框，文件可命名为 "
        f"`images/screenshots/{game.number:02d}-{game.title}-设置.webp`。"
    )
    body = insert_before_first(body, (r"^## .*操作", r"^## 玩法", r"^## 开始", r"^## 开局"), operation_shot)
    body = insert_before_first(body, (r"^## .*设置", r"^## 设置"), setting_shot)

    special = ""
    if game.number == 16:
        special = "\n\n## 流程图\n\n![阿瓦隆流程路线图](images/extra/16-阿瓦隆路线图.png)\n"
    elif game.number == 21:
        special = "\n\n## 棋盘结构示意\n\n![卡坦岛六边形棋盘结构](images/extra/21-卡坦岛棋盘结构.svg)\n"

    return f"""# {game.title}

![{game.title} 游戏图标](images/icons/{game.number:02d}.png)

| 项目 | 内容 |
| --- | --- |
| 游戏编号 | {game.number} |
| 支持人数 | {game.players} |
| 牌桌要求 | {game.table} |
| 游戏命名空间 | `{game.namespace}` |
| 游玩权限 | {game.permission} |
| 适用版本 | Fimel Cards 1.1／Minecraft Java 版 26.2 |

> 📷 **截图位：游戏全景**  
> 建议补充一张包含完整牌桌、玩家座位和主要信息区的截图。文件可命名为 `images/screenshots/{game.number:02d}-{game.title}-全景.webp`。

{body}

## 初次游玩建议

{game.tip}

## 通用说明

- 所有人入座后，由桌主在牌桌大厅选择本游戏并调整设置，再点击“开始游戏”。四座桌与八座桌会按各自尺寸自动调整展示。
- 游戏过程中若有参与者离线，整桌会暂停；原参与者全部上线后继续，也可以通过牌桌菜单结束本局。
- 规则窗口不会替玩家自动作出选择。需要按 Q 的操作均指 Minecraft 默认“丢弃物品”键；若改过键位，请使用自己绑定的丢弃键。
- 管理员需要强制结束异常对局时，可站在目标桌 8 格内执行 `/function {game.namespace}:admin/abort`。该命令保留牌桌并返回大厅。
{special}
---

[返回游戏规则目录](README.md)
"""


def build_index() -> str:
    rows = []
    for game in GAMES:
        rows.append(
            f"| {game.number} | [{game.title}]({game.filename.replace(' ', '%20')}) | {game.players} | {game.table} |"
        )
    return """# Fimel Cards 游戏规则

本目录收录 Fimel Cards 当前 23 款游戏的网站版规则。内容依据 Minecraft Java 版 26.2 数据包的实际实现整理，涵盖游戏目标、准备、回合流程、胜负条件、操作方式和可调设置。

网站发布时建议保留每篇开头的游戏信息表。文中的“截图位”是给后续实机截图预留的位置；补图后可将提示块替换为标准 Markdown 图片。游戏图标和现有流程图已经放入 `images` 目录。

## 开始前

- 玩家需要同时安装 Fimel Cards 数据包和配套资源包，并使用 Minecraft Java 版 26.2。
- 先创建四座或八座牌桌，再入座、选择游戏和调整设置。不同游戏的人数限制见下表。
- 默认按 Q 触发的操作，使用的是 Minecraft“丢弃物品”按键；改键玩家按自己的绑定键。
- 谍报风云、问非所答和命悬一线的文字输入对话框存在权限要求，详情见对应规则；其他普通游戏操作不要求玩家拥有 OP。
- 参与者离线时，对局会暂停并等待其重连；管理员也可在目标桌附近使用对应游戏的 `admin/abort` 函数结束异常对局。

## 游戏目录

| 编号 | 游戏 | 支持人数 | 牌桌 |
| ---: | --- | --- | --- |
""" + "\n".join(rows) + """

## 配图与发布

- [截图拍摄清单](截图拍摄清单.md)列出了每款游戏建议补充的画面。
- `images/icons` 为游戏图标，可直接用于网站卡片或文章封面。
- `images/extra` 收录当前已有的流程图和结构示意图。
- `images/screenshots` 用于放置实机截图，推荐使用 WebP 或 PNG，宽度至少 1600 像素。
"""


def build_shot_list() -> str:
    lines = [
        "# 截图拍摄清单",
        "",
        "建议统一关闭聊天栏历史、保留必要 HUD，并使用相同视场角拍摄。全景图用于文章头图，操作图用于说明交互，设置图用于展示可调选项。建议 16:9、至少 1600×900。",
        "",
        "| 编号 | 游戏 | 全景图 | 核心操作图 | 设置图 |",
        "| ---: | --- | --- | --- | --- |",
    ]
    for game in GAMES:
        prefix = f"{game.number:02d}-{game.title}"
        lines.append(
            f"| {game.number} | {game.title} | `{prefix}-全景.webp` | `{prefix}-操作.webp`：{game.shot} | `{prefix}-设置.webp` |"
        )
    lines.extend(
        [
            "",
            "## 替换方法",
            "",
            "把图片放进 `images/screenshots` 后，将文章中的截图提示块替换为：",
            "",
            "```markdown",
            "![图片说明](images/screenshots/01-Fast Card-全景.webp)",
            "```",
            "",
            "图片说明应写出画面内容，便于无障碍阅读和搜索引擎理解；不要只写“截图”。",
        ]
    )
    return "\n".join(lines) + "\n"


def main() -> None:
    TARGET.mkdir(parents=True, exist_ok=True)
    icon_dir = TARGET / "images" / "icons"
    extra_dir = TARGET / "images" / "extra"
    screenshot_dir = TARGET / "images" / "screenshots"
    icon_dir.mkdir(parents=True, exist_ok=True)
    extra_dir.mkdir(parents=True, exist_ok=True)
    screenshot_dir.mkdir(parents=True, exist_ok=True)

    for game in GAMES:
        (TARGET / game.filename).write_text(build_game(game), encoding="utf-8")
        shutil.copy2(DOCS / "game-icons" / f"{game.number}.png", icon_dir / f"{game.number:02d}.png")

    shutil.copy2(DOCS / "阿瓦隆路线图.png", extra_dir / "16-阿瓦隆路线图.png")
    shutil.copy2(DOCS / "assets" / "catan-board-layout.svg", extra_dir / "21-卡坦岛棋盘结构.svg")
    (TARGET / "README.md").write_text(build_index(), encoding="utf-8")
    (TARGET / "截图拍摄清单.md").write_text(build_shot_list(), encoding="utf-8")
    (screenshot_dir / "README.md").write_text(
        "# 游戏截图\n\n请按根目录《截图拍摄清单》中的文件名放置实机截图。\n",
        encoding="utf-8",
    )


if __name__ == "__main__":
    main()
