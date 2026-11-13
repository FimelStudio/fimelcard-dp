"""注册璀璨宝石22；不覆盖既有游戏的菜单、规则或模型。"""
import contextlib
import io
import json
import register_boardgames as base
from game_picker_ui import set_label


def register_rules():
    source=base.PACK/'tools/game_rules.json'
    records=json.loads(source.read_text(encoding='utf-8'))
    if 'splendor' not in records:
        raise ValueError('Missing splendor rules in tools/game_rules.json')
    # 只生成本游戏窗口，不重写同伴正在修改的既有游戏手册。
    from build_game_rules import make_dialog
    from build_splendor_game import put
    dialog=make_dialog('splendor')
    dialog['after_action']='close'
    put('rules/show','function splendor:rules/panel')
    put('rules/panel','dialog show @a[tag=ct.rules_actor,limit=1] '+json.dumps(dialog,ensure_ascii=False,separators=(',',':')))


def main():
    base.GAMES = ((22, 'splendor', 'sp', '璀璨宝石', 4),)
    with contextlib.redirect_stdout(io.StringIO()):
        base.main()
    for cap in (4,8):
        set_label(base.PACK, cap, 22, '璀璨宝石（2–4人）')
    # 选游字体仍使用公共八切片协议；只追加22，不重画同伴的其他图标。
    from build_splendor_icon import build as build_icon
    build_icon()
    register_rules()
    print('已注册璀璨宝石22，保留所有既有游戏。')


if __name__ == '__main__':
    main()
