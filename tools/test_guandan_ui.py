# -*- coding: utf-8 -*-
"""原版26.2掼蛋UI：实卡多选、百搭解释、贡还、即时设置、过期窗口及两桌隔离。"""
from pathlib import Path
import re
import sys
import json
from PIL import Image
from test_guandan_game import Suite as GameSuite, PACK, TABLE, OTHER, part, person, card, prepare_target as prepare_game
from test_guandan_cards import run
from build_guandan_settings import FIELDS


def check_fonts():
    """检查真实资源的图集、切片对应及HUD等宽回退，避免只验证服务器状态。"""
    root=PACK.parents[3]/'resourcepacks/fimelcard-rp/assets/card'
    fonts=root/'font/guandan'
    for depth in range(8):
        data=json.loads((fonts/f'hand_{depth}.json').read_text(encoding='utf8'))
        chars=set()
        for provider in data['providers']:
            assert provider['height']==56 and provider['ascent']==56-10*depth
            path=root/'textures'/provider['file'].split(':',1)[1]
            with Image.open(path) as image:
                assert image.size==(324,288)
                assert image.width%len(provider['chars'][0])==0
                assert image.height%len(provider['chars'])==0
            chars.update(''.join(provider['chars']))
        assert len(chars)==216
    data=json.loads((fonts/'stack.json').read_text(encoding='utf8'))
    chars=set()
    for variant,provider in enumerate(data['providers']):
        assert provider['height']==9 and provider['ascent']==7
        assert len(provider['chars'])==36 and len(set(map(len,provider['chars'])))==1
        for row in range(6):
            for part in range(6):
                assert provider['chars'][row*6+part]==''.join(chr(0xF000+variant*54*6+(row*9+col)*6+part) for col in range(9))
        chars.update(''.join(provider['chars']))
    assert len(chars)==1296
    with Image.open(root/'textures/font/guandan/selected_wild.png') as image:
        assert image.getpixel((0,3))[:3]==(255,224,88)
        assert image.getpixel((2,2))[:3]==(217,71,233)
    negative=json.loads((fonts/'hud_neg.json').read_text(encoding='utf8'))['providers'][0]['advances']
    assert all(negative[chr(base+n)]==-21.5 for base in (0xEC00,0xED00,0xEE00,0xEF00) for n in range(54))
    print('Guandan font atlas checks: 8 depths, 216 card variants, 1296 clickable slices',flush=True)


class Suite(GameSuite):
    def ui(self,name='open',seat=1,table=101):
        return ['scoreboard players set #ui_compiled gt 0',f'execute as {person(seat,table)} at @s run function guandan:ui/{name}']

    def submit(self,code,seat=1,table=101):
        p=person(seat,table)
        return [f'scoreboard players operation #ui_code gt = {p} gd_seen','scoreboard players set #factor gt 10000','scoreboard players operation #ui_code gt *= #factor gt',f'scoreboard players add #ui_code gt {code}',f'scoreboard players operation {p} gd_action = #ui_code gt',f'execute as {p} at @s run function guandan:input/submit']

    def settings(self,field,value,seat=1,table=101):
        p=person(seat,table)
        return [f'scoreboard players operation #setting_code gt = {p} gd_setnonce','scoreboard players set #factor gt 100000','scoreboard players operation #setting_code gt *= #factor gt',f'scoreboard players add #setting_code gt {field*1000+value}',f'scoreboard players operation {p} gd_settings = #setting_code gt',f'execute as {p} at @s run function guandan:settings/save']

    def ui_hands(self,table=101,reset=True):
        return self.playable(table=table,reset=reset)+self.fixture_hands({1:(1,55,2,56),2:(3,4),3:(5,6),4:(7,8)},table)+[f'scoreboard players set {TABLE if table==101 else OTHER} gd_turn 1']

    def finish(self):
        if self.single:
            if self.single not in self.cases:raise SystemExit('Unknown case: '+self.single)
            self.cases=[self.single]
            self.expected=re.findall(r'GUANDAN_PASS ([a-z0-9_]+)',self.files['case/'+self.single])
        super().finish()
        self.files['bootstrap']=self.files['bootstrap'].replace('function guandan_test:reset','scoreboard players set #ui_serial gd_ctx 0\nfunction guandan_test:reset')
        # 每次点击来自不同客户端请求。分刻提交测试操作，避免把整局发牌及多次重画
        # 人为挤进一个命令链；生产仍使用原版默认65536上限。
        ticks=100
        for name in self.cases:
            lines=self.files['case/'+name].splitlines()
            final=lines.pop()
            chunks=[lines[n:n+16] for n in range(0,len(lines),16)]
            ticks+=len(chunks)
            for i,chunk in enumerate(chunks):
                key='case/'+name if i==0 else f'step/{name}/{i}'
                tail=f'schedule function guandan_test:step/{name}/{i+1} 1t' if i<len(chunks)-1 else final
                self.file(key,chunk+[tail])
        self.setup_ticks=ticks

    def build(self,single=None):
        self.single=single
        self.prepare()
        self.file('hud_snapshot','$data modify storage guandan_test:run hud_panel set from storage fimel_title:io panels[$(panel_id)]')
        c=self.ui_hands()+self.ui()+self.score('#ui_compiled','gt',1,'hand_dialog_codec')
        c+=self.check('data storage guandan:ui rows.extra[{extra:[{text:"测试1"}]}]','names_resolved_literal_component')
        c+=self.submit(101)+self.score(card(1),'gd_sel',1,'first_physical_selected')+self.score(card(55),'gd_sel',0,'duplicate_copy_not_selected')
        c+=self.check('data storage guandan:ui grid.extra[{text:"'+chr(0xF000+54*6+1*6)+'"}]','selected_card_gold_slice')
        c+=self.check('data storage guandan:hud hand.extra[{text:"'+chr(0xED01)+'"}]','selected_card_gold_hud')
        c+=self.submit(155)+self.score(card(1),'gd_sel',1,'multiselect_keeps_first')+self.score(card(55),'gd_sel',1,'multiselect_second_copy')
        c+=self.submit(101)+self.score(card(1),'gd_sel',0,'same_physical_deselect')+self.score(card(55),'gd_sel',1,'other_copy_remains')
        c+=self.submit(22)+self.count('@e[tag=gd.cards,scores={gd_sel=1}]',0,'clear_selection_all_own')
        c+=self.submit(101)+self.submit(20)+self.score(card(1),'gd_owner',-2,'play_routes_exact_physical')+self.score(card(55),'gd_owner',1,'play_keeps_duplicate_copy')+self.score(part(),'gd_count',3,'play_decrements_one')
        c+=self.score('#dialog_clear','gt',1,'successful_play_closes_dialog')
        self.case('multiselect_play',c)
        c=self.ui_hands()+[f'scoreboard players set {TABLE} gd_turn 2']+self.ui()+self.submit(101)+self.submit(20)+self.score(card(1),'gd_owner',1,'wrong_turn_no_discard')+self.score(card(1),'gd_sel',1,'wrong_turn_can_prepare_hand')
        c+=self.submit(103)+self.score(card(3),'gd_sel',0,'cannot_select_other_hand')
        self.case('ownership_turn',c)
        # 八张同点数必须独立露头：两副同花牌也不能合并成一张计数。
        cards=(0,13,26,39,54,67,80,93)
        c=self.playable()+self.fixture_hands({1:cards,2:(1,),3:(2,),4:(3,)})+self.ui()
        c+=['execute store result score #columns gt run data get storage guandan:ui stack_columns','execute store result score #stacked gt run data get storage guandan:ui stack_columns[0].cards']
        c+=self.score('#columns','gt',1,'eight_same_rank_one_column')+self.score('#stacked','gt',8,'eight_cards_not_merged')+self.score('#hud_maxdepth','gd_ctx',7,'eight_hud_depth_seven')
        c+=self.check('data storage guandan:hud hand.extra[{font:"card:guandan/hand_7"}]','eight_hud_bottom_font')
        c+=self.check('data storage guandan_test:run hud_panel[3][0].extra[0].extra[{font:"card:guandan/hud_neg"}]','hud_invisible_centering_rewind')
        c+=self.check('data storage guandan_test:run hud_panel[4][0].extra[0].extra[{font:"card:guandan/hand_7"}]','hud_real_art_keeps_per_card_depth')
        for value in (0,26):
            c+=self.submit(100+value)+self.score(card(value),'gd_sel',1,'eight_select_'+str(value))
        c+=self.check('data storage guandan:hud hand.extra[{text:"'+chr(0xEF00+26)+'"}]','wild_selected_purple_corner')
        c+=self.score(card(54),'gd_sel',0,'eight_same_face_other_copy_unselected')
        c+=self.count('@e[tag=gd.cards,scores={gd_sel=1}]',2,'eight_distinct_selected')
        self.case('eight_stack',c)
        # 高低王、级牌及普通点数各自成列，排序必须基于聚合最大值而非execute fork旧值。
        c=self.playable()+self.fixture_hands({1:(53,107,52,106,0,13,26,39,12,11,10,9,8,7,6,5,4,3,2,1),2:(14,),3:(15,),4:(16,)})+self.ui()
        c+=self.score('#hud_groups','gd_ctx',15,'all_fifteen_strength_columns')
        c+=self.check('data storage guandan:ui stack_columns[0].cards[{name:"大王"}]','big_joker_first_column')+self.check('data storage guandan:ui stack_columns[1].cards[{name:"小王"}]','small_joker_second_column')
        c+=self.check('data storage guandan:ui stack_columns[2].cards[{name:"红桃2"}]','level_third_column')
        c+=self.check('data storage guandan:hud hand.extra[{font:"card:guandan/spacing_dense"}]','many_columns_keep_full_art_with_tight_gap')
        c+=self.check('data storage guandan_test:run hud_panel[3][0].extra[0].extra[{font:"card:guandan/hud_neg_dense"}]','dense_centering_matches_gap')
        self.case('full_rank_order',c)
        c=self.ui_hands()+self.ui()+[f'scoreboard players operation #oldcode gt = {person()} gd_seen','scoreboard players set #factor gt 10000','scoreboard players operation #oldcode gt *= #factor gt','scoreboard players add #oldcode gt 101']+self.ui()+[f'scoreboard players operation {person()} gd_action = #oldcode gt',f'execute as {person()} run function guandan:input/submit']+self.score(card(1),'gd_sel',0,'old_same_turn_window_rejected')
        self.case('stale_serial',c)
        for name,commands in [('epoch',[f'scoreboard players add {TABLE} gd_epoch 1']),('reload',['scoreboard players add #ui_load gd_ctx 1']),('table',[f'scoreboard players set {person()} gd_table 202']),('game',[f'scoreboard players set {TABLE} ct_game 17']),('inactive',[f'scoreboard players set {TABLE} ct_state 0'])]:
            c=self.ui_hands()+self.ui()+commands+self.submit(101)+self.score(card(1),'gd_sel',0,'stale_'+name+'_rejected')+self.score(card(1),'gd_owner',1,'stale_'+name+'_no_mutation')
            self.case('stale_'+name,c)
        # 同一百搭组可有多种顺/同花顺解释，展示全部候选；选择后才提交实卡。
        c=self.playable()+self.fixture_hands({1:(1,2,3,4,26,10),2:(5,6),3:(7,8),4:(9,11)})+[f'scoreboard players set {TABLE} gd_turn 1']+self.ui()
        for value in (1,2,3,4,26):c+=self.submit(100+value)
        c+=self.submit(20)+self.score('#ui_compiled','gt',1,'ambiguity_dialog_codec')+self.score('#options','gd_ctx','2..','ambiguity_multiple_options')+self.score(card(26),'gd_owner',1,'ambiguity_before_choice_keeps_hand')
        c+=self.check('data storage guandan:ui buttons[0].action','ambiguity_first_choice_clickable')+self.submit(1000)+self.score(card(26),'gd_owner',-2,'ambiguity_choice_submits')+self.score(part(),'gd_count',1,'ambiguity_count_correct')
        self.case('interpretation',c)
        # 为可压及不可压两类候选编译真实Dialog；灰色候选无click命令。
        options=[{'kind':7,'size':5,'high':5,'power':0,'suit':-1,'code':705049,'beat':0,'label':'顺子 · 5高'}, {'kind':9,'size':5,'high':6,'power':6,'suit':0,'code':905061,'beat':1,'label':'同花顺 · 6高'}]
        import json
        c=self.ui_hands()+[f'data modify entity {TABLE} data.guandan.options set value '+json.dumps(options,ensure_ascii=False,separators=(',',':'))]+self.ui('interpret')+self.score('#ui_compiled','gt',1,'mixed_options_codec')
        c+=self.check('data storage guandan:ui buttons[{label:{color:"dark_gray"}}]','unbeatable_option_gray')
        c+=['execute store success score #has_action gt if data storage guandan:ui buttons[0].action']+self.score('#has_action','gt',0,'unbeatable_option_no_action')
        c+=self.check('data storage guandan:ui buttons[1].action','beatable_option_has_action')
        self.case('unbeatable_option',c)
        for state in (1,4,5):
            c=self.ui_hands()+[f'scoreboard players set {TABLE} gd_state {state}']+self.ui()+self.score('#ui_compiled','gt',1,f'state_{state}_dialog_codec')
            c+=self.submit(101)+self.score(card(1),'gd_sel',0,f'state_{state}_selection_blocked')
            self.case('state_'+str(state),c)
        c=self.ui_hands()+self.ui('menu')+self.score('#ui_compiled','gt',1,'menu_codec')+[f'tag {person()} add ct.rules_actor','scoreboard players set #rules_compiled gt 0']+self.call('rules/show')+self.score('#rules_compiled','gt',1,'controller_rules_codec')+[f'execute as {person()} run function guandan:rules/player']+self.score('#rules_compiled','gt',2,'player_rules_codec')
        self.case('menu_rules',c)
        c=self.ui_hands()+[f'scoreboard players set {TABLE} gd_show 0']+self.ui()+self.check('data storage guandan:ui rows.extra[0].extra[{text:" · 队0 ▶\\n"}]','hide_other_counts')
        self.case('hide_counts',c)
        # 单贡的真实状态机：捐者一次仅选一张，最大牌确认后转入受贡者还牌。
        c=self.playable()+self.fixture_hands({1:(1,2,10),2:(3,4),3:(5,6),4:(52,7,8)})+[f'scoreboard players set {TABLE} gd_round 2']
        for seat,rank in {1:1,2:2,3:3,4:4}.items():c+=[f'scoreboard players set {part(seat)} gd_prevrank {rank}']
        c+=self.call('tribute/begin')+self.ui(seat=4)+self.submit(107,seat=4)+self.submit(152,seat=4)+self.score(card(7),'gd_sel',0,'tribute_selection_transfers')+self.score(card(52),'gd_sel',1,'tribute_one_real_card')+self.submit(23,seat=4)+self.score(card(52),'gd_owner',1,'tribute_submit_transfers')+self.score(TABLE,'gd_phase',2,'tribute_enters_return')
        c+=self.ui()+self.submit(101)+self.submit(23)+self.score(card(1),'gd_owner',4,'return_submit_transfers')+self.score(TABLE,'gd_state',3,'return_enters_play')
        self.case('tribute_return',c)
        # 两桌私人手牌分别构建，自己桌的选择不触及邻桌相同physical id。
        c=self.ui_hands()+self.ui_hands(202,False)+self.ui()+self.submit(101)+self.score(card(1),'gd_sel',1,'two_tables_own_selection')+self.score(card(1,202),'gd_sel',0,'two_tables_other_selection')+self.ui(table=202)+self.score('#last_viewer_table','gt',202,'two_tables_right_viewer')
        self.case('two_tables',c)
        for field,key,_,choices in FIELDS:
            for value,_ in choices:
                name=f'setting_{key}_{value}'
                c=self.setup_game()+[f'tag {person()} add ct.settings_actor','scoreboard players set #settings_compiled gt 0']+self.call('settings/open')+self.score('#settings_compiled','gt',1,name+'_codec')+self.settings(field,value)+self.score(TABLE,'gd_'+key,value,name+'_instant')
                self.case(name,c)
        for label,commands in [('start',[f'scoreboard players set {TABLE} ct_state 1']),('table',[f'scoreboard players set {person()} ct_id 202']),('game',[f'scoreboard players set {TABLE} ct_game 17']),('reload',['scoreboard players add #ui_load gd_ctx 1'])]:
            c=self.setup_game()+[f'tag {person()} add ct.settings_actor']+self.call('settings/open')+commands+self.settings(2,14)+self.score(TABLE,'gd_startlevel',2,'stale_settings_'+label)
            self.case('settings_stale_'+label,c)
        for field,value in [(0,1),(1,2),(2,1),(2,15),(3,2),(4,0),(4,4),(5,2),(6,45),(7,0)]:
            name=f'invalid_setting_{field}_{value}'
            c=self.setup_game()+[f'tag {person()} add ct.settings_actor']+self.call('settings/open')+self.settings(field,value)+self.score(TABLE,'gd_startlevel',2,name+'_unchanged')
            self.case(name,c)
        c=self.setup_game()+self.setup_game(table=202,reset=False)+[f'tag {person()} add ct.settings_actor']+self.call('settings/open')+self.settings(2,14)+self.score(TABLE,'gd_startlevel',14,'settings_own_table_changes')+self.score(OTHER,'gd_startlevel',2,'settings_other_table_unchanged')
        self.case('settings_two_tables',c)
        self.finish()


def prepare_target(target):
    prepare_game(target)
    hud=target/'data/guandan/function/hud/update.mcfunction'
    hud.write_text(hud.read_text(encoding='utf8').replace('type=minecraft:player','type=minecraft:armor_stand'),encoding='utf8')
    hud=target/'data/guandan/function/hud/build.mcfunction'
    hud.write_text(hud.read_text(encoding='utf8')+'function guandan_test:hud_snapshot with storage fimel_title:io\n',encoding='utf8')
    for name in ['ui/show','settings/show','rules/show','rules/player','input/play','input/choose','input/pass','input/tribute']:
        path=target/'data/guandan/function'/(name+'.mcfunction')
        text=path.read_text(encoding='utf8')
        if name=='ui/show':text+='scoreboard players set #ui_compiled gt 1\nscoreboard players operation #last_viewer_table gt = @s gd_table\n'
        elif name=='settings/show':text+='scoreboard players set #settings_compiled gt 1\n'
        elif name.startswith('rules/'):text+='scoreboard players add #rules_compiled gt 1\n'
        else:text=text.replace('execute if score #ok gd_ctx matches 1 run return run dialog clear @s','execute if score #ok gd_ctx matches 1 run scoreboard players add #dialog_clear gt 1\nexecute if score #ok gd_ctx matches 1 run return run dialog clear @s')
        path.write_text(text,encoding='utf8')


if __name__=='__main__':
    check_fonts()
    single=None
    if '--case' in sys.argv:
        index=sys.argv.index('--case');single=sys.argv[index+1];del sys.argv[index:index+2]
    suite=Suite();suite.build(single);raise SystemExit(run(suite,isolated=False,prefix='fimel-guandan-ui-',prepare_target=prepare_target))
