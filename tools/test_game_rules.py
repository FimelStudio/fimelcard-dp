"""校验21游戏规则统一格式、旧细则、真实花火参数及所有Dialog宏编译。"""
from pathlib import Path
import hashlib
import json
import shutil
import tempfile

from build_game_rules import PACK, SOURCE, SECTIONS, WIDTH, get_dialog, make_dialog, normalize_rule_output
from test_guandan_cards import Suite as BaseSuite, run

RECORDS=json.loads(SOURCE.read_text(encoding='utf-8'))
TABLE='@e[type=minecraft:marker,tag=gr.table,limit=1]'


def static_checks():
    assert len(RECORDS)==23
    for namespace,record in RECORDS.items():
        dialog=make_dialog(namespace)
        assert dialog['pause'] is False and dialog['can_close_with_escape'] is True
        assert dialog['title']['text']==record['name']+' · 游戏规则'
        assert [b['contents'][0]['text'].strip() for b in dialog['body']]==list(SECTIONS)
        assert all(b['width']==WIDTH for b in dialog['body'])
        assert (PACK/f'data/{namespace}/function/admin/abort.mcfunction').exists()
        for path in (PACK/f'data/{namespace}/function/rules').glob('*.mcfunction'):
            if path.stem not in ('show','open','player','show_dialog'):continue
            text=path.read_text(encoding='utf-8')
            assert normalize_rule_output(path,text)==text,str(path)
            if 'dialog show ' in text:
                parsed=get_dialog(text)
                assert parsed['pause'] is False
                assert all(b['width']==WIDTH for b in parsed['body'])
                assert len(text.encode('utf-8'))<32767,namespace
    # 关键规则不得在统一外壳时丢失，尤其同伴游戏及揭棋。
    expected={'xiangqi':['揭棋','被吃的暗子保持盖面','单方持续将军者判负'],
              'ito':['2～8人','1～48字','三关','每张扣1点生命','两人局不回血','OP'],
              'decrypto':['第一轮跳过拦截','每队2至4人','提交需要OP权限'],
              'wenfei':['提交需要OP权限','每个分值只能用一次'],
              'uno':['其余弃牌洗回牌库','+4','UNO'],
              'love_letter':['间谍','伯爵夫人','不以弃牌和破平'],
              'catan':['同一路段只能经过一次','新买的非胜利点牌不能用'],
              'chess':['逼和','五次重复','75回合','三次重复']}
    for namespace,words in expected.items():
        text=json.dumps(RECORDS[namespace],ensure_ascii=False)
        for word in words:assert word in text,(namespace,word)
    # 实际调用所有原生成器共用的写入入口，旧外壳不能重新覆盖统一正文。
    from build_table_pause_guards import write_guarded
    with tempfile.TemporaryDirectory(prefix='fimel-rules-source-') as root:
        for namespace in RECORDS:
            p=Path(root)/f'data/{namespace}/function/rules/show.mcfunction'
            p.parent.mkdir(parents=True,exist_ok=True)
            write_guarded(p,'dialog show @s {"type":"minecraft:notice","title":{"text":"old"},"body":[],"pause":false}\n',encoding='utf-8')
            parsed=get_dialog(p.read_text(encoding='utf-8'))
            assert parsed['title']['text']==RECORDS[namespace]['name']+' · 游戏规则'
            assert len(parsed['body'])==6


class Suite(BaseSuite):
    def build(self):
        self.file('reset','kill @e[tag=gr.fixture]')
        for namespace,record in RECORDS.items():
            # 强制宏化标题，哨兵仅在整条真实Dialog成功编译后才能执行。
            text=(PACK/f'data/{namespace}/function/rules'/('show_dialog.mcfunction' if namespace=='hanabi' else 'open.mcfunction' if namespace=='aeroplane_chess' else 'panel.mcfunction' if namespace in ('splendor','magical_athlete') else 'show.mcfunction')).read_text(encoding='utf-8')
            line=next(line for line in text.splitlines() if line.startswith(('dialog show ','$dialog show ')))
            line='$'+line.lstrip('$')
            title=json.dumps(record['name']+' · 游戏规则',ensure_ascii=False)
            assert title in line,namespace
            line=line.replace(title,'"$(rule_title)"',1)
            self.file('dialog/'+namespace,[line,f'scoreboard players set #compiled_{namespace} gt 1'])
            for cap in (4,8):
                name=namespace+'_'+str(cap)
                lines=['function guandan_test:reset','summon minecraft:marker 8.0 64.0 8.0 {Tags:["gr.fixture","gr.table"]}',f'scoreboard players set {TABLE} ct_id 101',f'scoreboard players set {TABLE} ct_capacity {cap}',f'scoreboard players set #compiled_{namespace} gt 0',
                       'data modify storage guandan_test:rules args set value '+json.dumps({'rule_title':record['name']+' · 游戏规则','clues':8,'strikes':3,'storm':{'text':'关闭','color':'gray'}},ensure_ascii=False,separators=(',',':')),
                       f'execute as {TABLE} at @s run function guandan_test:dialog/{namespace} with storage guandan_test:rules args']
                lines+=self.score('#compiled_'+namespace,'gt',1,name+'_whole_dialog_macro_compiles')
                self.case(name,lines)
        for storm in (0,1):
            lines=['function guandan_test:reset','summon minecraft:marker 8.0 64.0 8.0 {Tags:["gr.fixture","gr.table"]}',f'scoreboard players set {TABLE} ct_id 101',f'scoreboard players set {TABLE} hb_clue_max 11',f'scoreboard players set {TABLE} hb_strike_max 4',f'scoreboard players set {TABLE} hb_storm {storm}','scoreboard players set #hanabi_live gt 0',f'execute as {TABLE} at @s run function hanabi:rules/show']
            lines+=self.score('#hanabi_live','gt',1,f'hanabi_live_{storm}_macro_compiles')
            lines+=self.check('data storage hanabi:rules {clues:11,strikes:4}',f'hanabi_live_{storm}_preserves_dynamic_settings')
            self.case('hanabi_live_'+str(storm),lines)
        self.file('bootstrap',['forceload add 0 0 15 15','scoreboard objectives add gt dummy','scoreboard objectives add ct_id dummy','scoreboard objectives add ct_capacity dummy','scoreboard objectives add hb_clue_max dummy','scoreboard objectives add hb_strike_max dummy','scoreboard objectives add hb_storm dummy','scoreboard objectives add lh_help trigger',f'schedule function guandan_test:case/{self.cases[0]} 2t'])
        self.file('finish','say GUANDAN_FINISHED')
        for index,name in enumerate(self.cases):self.files['case/'+name]+='schedule function guandan_test:'+('case/'+self.cases[index+1] if index+1<len(self.cases) else 'finish')+' 1t\n'


def prepare(target):
    for namespace in RECORDS:
        source=PACK/f'data/{namespace}/function/rules'
        shutil.copytree(source,target/f'data/{namespace}/function/rules')
    for name in ('game/init_table.mcfunction','log.mcfunction'):
        source=PACK/'data/hanabi/function'/name;dest=target/'data/hanabi/function'/name
        dest.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(source,dest)
    p=target/'data/hanabi/function/rules/show_dialog.mcfunction'
    p.write_text(p.read_text(encoding='utf-8')+'scoreboard players set #hanabi_live gt 1\n',encoding='utf-8')


if __name__=='__main__':
    static_checks()
    suite=Suite();suite.build()
    raise SystemExit(run(suite,prefix='fimel-game-rules-',prepare_target=prepare))
