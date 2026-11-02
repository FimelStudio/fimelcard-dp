"""注册璀璨宝石22；不覆盖既有游戏的菜单、规则或模型。"""
import contextlib
import io
import json
import register_boardgames as base
from game_picker_ui import set_label


def register_rules():
    source=base.PACK/'tools/game_rules.json'
    records=json.loads(source.read_text(encoding='utf-8'))
    records['splendor']={'id':22,'name':'璀璨宝石','sections':{
        '人数与目标':[{'text':'2～4名真人，无人机。用宝石购买开发卡，获得永久折扣和声望，吸引贵族。有人在回合末达到15分后完成当前整轮；声望高者赢，并列时已购开发卡较少者赢，再并列共同获胜。'}],
        '操作方式':[{'text':'腾空快捷栏最后一格，手持「璀璨宝石 · 市场」按Q打开菜单。点击市场牌面查看原价、折扣后费用，并选择购买或预约；拿珠、退珠和支付数量用同页加减，确认才提交。回合外可查看市场、贵族、公开资产和自己的预约牌。'}],
        '对局流程':[{'heading':'拿取或预约','text':'每回合只做一次主行动：拿3颗异色宝石（银行不足3种颜色时拿剩余全部种类）、拿同色2颗（拿前银行该色至少4颗）、预约1张开发卡，或购买1张开发卡。不能直接拿黄金或空拿跳回合。预约可选市场明牌或某级牌堆顶牌，最多3张且不能丢弃；有黄金时同时领取1颗，没有黄金仍可预约。'},
                    {'heading':'购买与补牌','text':'购买市场明牌或自己的预约牌。每张已购卡提供1枚对应颜色永久折扣，不会消耗；先扣折扣，再支付宝石，黄金可替代任意颜色。默认优先普通宝石，可手动改成黄金支付；必须恰好付清，不可超付。市场空位立即补同级牌，牌堆空则保留空位。'}],
        '特殊规则':[{'heading':'超额退珠','text':'包括黄金在内，回合结束时最多持有10颗筹码。超出时由本人选择恰好退至10颗；可退刚拿到的筹码，不能顺便多退。未退完不能推进回合。'},
                    {'heading':'贵族','text':'达到贵族要求的永久折扣后自动来访，不花筹码、不占主行动，每位3分。每回合最多一位；同时符合多位时由本人选择，不能拒绝来访。'},
                    {'heading':'人数与公开信息','text':'2／3／4人时每色普通宝石分别4／5／7颗，黄金始终5颗；随机展示人数加1位贵族。90张开发卡分三级，每级4张明牌。筹码、已购卡折扣及声望公开；预约牌仅持有者可查看。按座位或随机决定行动顺序，背景音乐可开关。'}],
        '暂停与结束':[{'text':'15分仅触发末轮，仍让每人完成相同回合数；期间仍可能被反超。终局保留公共市场，重新开局或切换游戏时清理。'}],
        '管理命令':[]}}
    source.write_text(json.dumps(records,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
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
