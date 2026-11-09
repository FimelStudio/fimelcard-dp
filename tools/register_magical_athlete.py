"""注册胡闹运动会23，只追加新游戏及其规则，保留既有游戏。"""
import contextlib
import io
import json

import register_boardgames as base
from game_picker_ui import set_label
from build_table_pause_guards import write_guarded


def register_rules():
    path = base.PACK / 'tools/game_rules.json'
    records = json.loads(path.read_text(encoding='utf-8'))
    defaults = {'id': 23, 'name': '胡闹运动会', 'sections': {
        '人数与目标': [{'text': '2～6名真人。为自己的队伍招募奇妙选手，进行四场比赛，累计积分最高者获胜；总分相同共同获胜。四座桌最多4人，5～6人使用八座桌。'}],
        '操作方式': [{'text': '腾空快捷栏最后一格，手持「胡闹运动会 · 比赛菜单」按Q。选角、选择本场选手、掷骰、使用可选能力和指定目标均通过菜单操作；只有有待完成操作的玩家能提交。其他玩家可以查看赛况、公开角色能力与积分。'}],
        '对局流程': [
            {'heading': '招募与上场', 'text': '默认蛇形选角：先亮出人数两倍的角色，按顺时针再逆时针各选一次；随后从起选者左邻开始，重新亮牌再选两轮。也可在设置中改为随机发队。每场分别秘密选择一名未用选手，全部选好后同时公开；用过的选手退出后续比赛。'},
            {'heading': '轮流行动', 'text': '轮到自己时投骰，进行一次主移动。能力可能让自己或其他选手额外移动、换位、绊倒或获得积分。可选能力由对应玩家决定；强制能力自动处理。前两名到达终点后该场立即结束，按场次递增发放冠军和亚军奖励。下一场由上一场最落后、或最早被淘汰的选手所属玩家先行动。'}],
        '特殊规则': [
            {'heading': '两人双选手', 'text': '两人时每人招募8名选手，每场秘密选择两名，同时有4名选手参赛。按2026年8月更新，选入阵容的先后确定本场固定行动顺序，先完成一名的完整回合再行动下一名。能力中的其他选手也包括自己的另一名；第二场起，上场得分较少的玩家先行动，平分时重新投骰决定。'},
            {'heading': '主移动、传送与绊倒', 'text': '额外移动不属于主移动；传送不算移动，也不算经过其他选手。绊倒不截断当前移动，只跳过下一次主移动；期间能力仍能触发。移动0格不触发移动能力。起点也算一格。'},
            {'heading': '连锁与赛道', 'text': '默认依次比赛普通、狂野、普通、狂野赛道，可在开局前调整。狂野格会带来积分、推拉或绊倒。连锁按赛道、当前行动选手、其余选手的顺序结算，先完成一次移动再处理其触发。到达终点或淘汰后能力失效，角色明示的例外除外；共同到达的选手之间不互相触发同格能力。'}],
        '暂停与结束': [{'text': '任一真人离线，整桌暂停，投骰、移动动画和能力选择一起冻结；全部原玩家回来后继续。四场结算后公布总积分，平分共同获胜。提前结束可使用牌桌投票，管理员可中止。'}],
        '管理命令': []}}
    records.setdefault('magical_athlete', defaults)
    path.write_text(json.dumps(records, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    from build_game_rules import make_dialog
    dialog = make_dialog('magical_athlete')
    dialog['after_action'] = 'close'
    directory = base.PACK / 'data/magical_athlete/function/rules'
    directory.mkdir(parents=True, exist_ok=True)
    write_guarded(directory / 'show.mcfunction', 'function magical_athlete:rules/panel\n', encoding='utf-8')
    write_guarded(directory / 'panel.mcfunction', 'dialog show @a[tag=ct.rules_actor,limit=1] ' + json.dumps(dialog, ensure_ascii=False, separators=(',', ':')) + '\n', encoding='utf-8')


def main():
    base.GAMES = ((23, 'magical_athlete', 'ma', '胡闹运动会', 6),)
    base.MINIMUM[23] = 2
    with contextlib.redirect_stdout(io.StringIO()):
        base.main()
    for capacity in (4, 8):
        set_label(base.PACK, capacity, 23, f'胡闹运动会（2–{min(capacity, 6)}人）')
    register_rules()
    print('已注册胡闹运动会23，保留既有22个游戏与同伴界面。')


if __name__ == '__main__':
    main()
