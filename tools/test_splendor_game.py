"""璀璨宝石26.2生产UI/生命周期回归，沿用marker参与者桥接。

客户端专属命令原样保留，实际展开所有Dialog宏并由原版解析；桥接仅让
无客户端GameTest能覆盖参与者分派，不声称替代真实客户端画面/音效验证。
"""
from pathlib import Path
import json
import re
from test_catan_engine import Suite as BaseSuite, run

PACK = Path(__file__).resolve().parents[1]
TABLE = '@e[type=minecraft:marker,tag=sg.table,scores={ct_id=101},limit=1]'
OTHER = TABLE.replace('101', '202')


def person(side=1, table=101):
    return f'@e[type=minecraft:marker,tag=sg.person,scores={{sg_pid={table*10+side}}},limit=1]'


def stable(side=1, table=101):
    return person(side, table).replace('tag=sg.person', 'tag=sg.identity')


class Suite(BaseSuite):
    def call(self, path, table=101):
        return [f'execute as {TABLE if table==101 else OTHER} at @s run function splendor:{path}']

    def player(self, path, side=1, table=101):
        return [f'execute as {person(side,table)} at @s run function splendor:{path}']

    def set(self, path, value, table=101):
        return [f'data modify entity {TABLE if table==101 else OTHER} data.splendor.{path} set value '+json.dumps(value, ensure_ascii=False, separators=(',',':'))]

    def data(self, path, expected, name, table=101):
        return self.storage_equal(f'entity {TABLE if table==101 else OTHER} data.splendor.{path}', expected, name)

    def storage_equal(self, source, expected, name):
        return ['data modify storage splendor_game_test:run cmp set value '+json.dumps(expected,ensure_ascii=False,separators=(',',':')),
                f'execute store success score #present ce run data get {source}',
                f'execute store success score #different ce run data modify storage splendor_game_test:run cmp set from {source}',
                'execute unless score #present ce matches 1 run scoreboard players set #different ce 1']+self.score('#different','ce',0,name)

    def absent(self, who, objective, name):
        return [f'execute store success score #present ce run scoreboard players get {who} {objective}']+self.score('#present','ce',0,name)

    def setup(self, state=1, n=2, table=101, reset=True):
        out=(['kill @e[tag=sg.fixture]','scoreboard players set #dialog ce 0','scoreboard players set #setting_dialog ce 0'] if reset else [])
        out += [f'execute positioned {8 if table==101 else 40} 64 8 summon minecraft:marker run function catan_engine_test:table {{table:{table},state:{state},n:{n}}}']
        for side in range(1,n+1):
            out += [f'execute positioned {8 if table==101 else 40} 64 8 summon minecraft:marker run function catan_engine_test:person {{table:{table},side:{side},seat:{side*2},pid:{table*10+side}}}']
        out += [f'scoreboard players set #players sp_ctx {n}']+self.call('engine/init',table)+self.call('game/sync',table)
        for side in range(1,n+1):
            out += self.set(f'p{side}.name',{'text':f'Player{side}'},table)+self.set(f'p{side}.seat',side*2,table)
        return out+self.call('system/context',table)

    def click(self, code, side=1, table=101):
        who=person(side,table)
        return [f'scoreboard players operation {who} sp_action = {who} sp_nonce', f'scoreboard players operation {who} sp_action *= #factor sp_ctx',f'scoreboard players add {who} sp_action {code}']+self.player('ui/handle',side,table)

    def open_settings(self, table=101):
        return [f'tag {person(1,table)} add ct.settings_actor']+self.call('settings/open',table)+[f'tag {person(1,table)} remove ct.settings_actor']

    def setting(self, field, value, side=1, table=101):
        who=person(side,table)
        return [f'scoreboard players operation {who} sp_settings = {who} sp_setnonce', f'scoreboard players operation {who} sp_settings *= #factor sp_ctx',f'scoreboard players add {who} sp_settings {field*100+value}']+self.player('settings/save',side,table)

    def snapshot(self, table=101):
        return [f'data modify storage splendor_game_test:snapshot saved set from entity {TABLE if table==101 else OTHER} data.splendor']

    def unchanged(self, name, table=101):
        return [f'execute store success score #different ce run data modify storage splendor_game_test:snapshot saved set from entity {TABLE if table==101 else OTHER} data.splendor']+self.score('#different','ce',0,name)

    def build(self):
        self.file('table', '''
tag @s add sg.fixture
tag @s add sg.table
tag @s add ct.controller
tag @s add sp.controller
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ct_state $(state)
$scoreboard players set @s ct_joined $(n)
scoreboard players set @s ct_game 22
scoreboard players set @s ct_capacity 8
scoreboard players set @s ct_chairs 8
scoreboard players set @s ct_ch_epoch 1
scoreboard players set @s ct_paused 0
scoreboard players set @s sp_anim 0
scoreboard players set @s sp_finish 0
scoreboard players set @s sp_first 0
scoreboard players set @s sp_music 0
scoreboard players set @s sp_pulse 0
''')
        self.file('person', '''
tag @s add sg.fixture
tag @s add sg.person
tag @s add sg.identity
tag @s add ct.player
tag @s add sp.player
$scoreboard players set @s sg_pid $(pid)
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ct_seat $(seat)
$scoreboard players set @s sp_table $(table)
$scoreboard players set @s sp_side $(side)
$scoreboard players set @s sp_seat $(seat)
scoreboard players set @s ct_paused 0
data modify entity @s data.name set value {text:"Fixture"}
''')
        c=self.setup()+self.player('ui/open')+self.score('#dialog','ce',1,'root_dialog_codec')+self.storage_equal('storage splendor:ui hand.reserve',[],'private_own_hand')
        for code,panel,name in ((2,4,'market'),(5,5,'reserved'),(6,6,'assets'),(7,7,'nobles'),(4,8,'blind'),(3,1,'take')):
            c+=self.click(code)+self.score(person(),'sp_panel',panel,name+'_panel')+self.click(1)
        c+=self.check('data storage splendor:ui public.extra','public_summary_populated')
        self.case('basic_pages',c)
        for code,name in ((2,'market'),(5,'reserved'),(6,'assets'),(7,'nobles'),(4,'blind'),(3,'take')):
            self.case('codec_'+name,self.setup()+self.player('ui/open')+self.click(code)+self.score('#dialog','ce',2,name+'_dialog_codec'))

        c=self.setup()+self.set('market',list(range(12)))+self.set('p1.reserve',[50,89])+self.player('ui/open')+self.click(2)
        for slot in range(12):
            c+=self.click(100+slot)+self.score(person(),'sp_target',slot,f'detail_target_{slot}')+self.storage_equal('storage splendor:ui card.id',slot,f'detail_card_{slot}')+self.click(2)
        c+=self.click(5)+self.click(120)+self.storage_equal('storage splendor:ui card.id',50,'reserve_detail_first')+self.click(5)+self.click(121)+self.storage_equal('storage splendor:ui card.id',89,'reserve_detail_second')
        c+=self.player('ui/open',side=2)+self.click(5,side=2)+self.storage_equal('storage splendor:ui hand.reserve',[],'other_cannot_see_reserved')
        self.case('card_indices_privacy',c)

        c=self.setup()+self.player('ui/open')+self.click(3)
        for code in (201,203,205):c+=self.click(code)
        c+=self.score(person(),'sp_pick0',1,'take_editor_white')+self.score(person(),'sp_pick1',1,'take_editor_blue')+self.score(person(),'sp_pick2',1,'take_editor_green')+self.click(10)
        c+=self.data('p1.tokens',[1,1,1,0,0,0],'take_ui_commits')+self.score(TABLE,'sp_turn',2,'take_ui_advances')
        c+=self.score(TABLE,'sp_anim',12,'take_animation_lock')+self.snapshot()+self.player('ui/open',2)+self.click(3,2)+self.click(10,2)+self.unchanged('animation_cannot_submit')
        self.case('take_editor_action',c)

        c=self.setup()+self.set('market[0]',0)+self.set('p1.tokens',[0,2,0,0,0,1])+self.set('bank',[7,5,7,7,7,4])+self.player('ui/open')+self.click(2)+self.click(100)
        c+=self.score(person(),'sp_pick1',2,'autopay_colored')+self.score(person(),'sp_pick5',1,'autopay_gold')+self.click(12)+self.data('p1.cards',[0],'purchase_ui_commits')+self.data('p1.bonus[0]',1,'purchase_bonus_commits')
        c+=self.setup()+self.set('market[0]',0)+self.player('ui/open')+self.click(100)+self.click(13)+self.data('p1.reserve',[0],'reserve_ui_commits')
        c+=self.setup()+self.player('ui/open')+self.click(4)+self.click(142)+['execute store result score #reserved_count ce run data get entity '+TABLE+' data.splendor.p1.reserve']+self.score('#reserved_count','ce',1,'blind_ui_count')+self.data('p1.tokens[5]',1,'blind_ui_gold')
        self.case('buy_reserve',c)

        c=self.setup()+self.set('p1.tokens',[2,2,2,2,1,0])+self.player('ui/open')+self.click(3)
        for code in (201,203,205):c+=self.click(code)
        c+=self.click(10)+self.data('phase',2,'return_ui_pending')+[f'scoreboard players set {TABLE} sp_anim 0']+self.player('ui/open')+self.click(20)+self.click(201)+self.click(209)+self.click(11)
        c+=self.data('p1.token_count',10,'return_ui_exact_ten')+self.data('phase',1,'return_ui_main_phase')
        c+=self.setup()+self.set('nobles',[0,1,-1,-1,-1])+self.set('p1.bonus',[4,4,4,0,0])+self.player('ui/open')+self.click(4)+self.click(140)+self.data('phase',3,'noble_ui_pending')+[f'scoreboard players set {TABLE} sp_anim 0']+self.player('ui/open')+self.click(7)+self.click(161)+self.data('p1.nobles',[1],'noble_ui_chosen')+self.data('p1.vp',3,'noble_ui_points')
        self.case('return_noble',c)

        for label,changes in {
            'epoch':[f'scoreboard players add {TABLE} sp_epoch 1'],
            'load':['scoreboard players add #ui_load sp_ctx 1'],
            'table':[f'scoreboard players set {person()} sp_ui_table 202'],
            'role':[f'tag {person()} remove ct.player'],
            'paused':[f'scoreboard players set {TABLE} ct_paused 1'],
        }.items():
            c=self.setup()+self.player('ui/open')+self.click(3)+self.snapshot()+changes+self.click(10)+self.unchanged('stale_'+label+'_no_commit')
            self.case('ui_stale_'+label,c)

        c=self.setup(state=0)+self.open_settings()+self.score('#setting_dialog','ce',1,'settings_codec')+self.setting(1,1)+self.score(TABLE,'sp_first',1,'settings_first_immediate')+self.score('#setting_dialog','ce',2,'settings_refresh_same_page')+self.setting(2,1)+self.score(TABLE,'sp_music',1,'settings_music_immediate')
        c+=[f'scoreboard players reset {person()} sp_settings',f'execute store success score #enabled ce run scoreboard players enable {person()} sp_settings']+self.score('#enabled','ce',1,'settings_trigger_enabled')
        self.case('settings_immediate',c)

        for label,changes in {
            'seat':[f'scoreboard players add {person()} ct_seat 1'],
            'table':[f'scoreboard players set {person()} ct_id 202'],
            'layout':[f'scoreboard players add {TABLE} ct_ch_epoch 1'],
            'epoch':[f'scoreboard players add {TABLE} sp_epoch 1'],
            'load':['scoreboard players add #settings_load sp_ctx 1'],
            'game':[f'scoreboard players set {TABLE} ct_game 1'],
            'active':[f'scoreboard players set {TABLE} ct_state 1'],
            'leave':[f'tag {person()} remove ct.player'],
        }.items():
            c=self.setup(state=0)+self.open_settings()+changes+self.setting(1,1)+self.score(TABLE,'sp_first',0,'settings_stale_'+label)
            self.case('settings_stale_'+label,c)

        c=self.setup(state=0)+self.setup(state=0,table=202,reset=False)+self.open_settings()+self.setting(1,1)+self.score(TABLE,'sp_first',1,'settings_own_changed')+self.score(OTHER,'sp_first',0,'settings_other_unchanged')
        c+=self.open_settings()+[f'scoreboard players operation #saved ce = {person()} sp_setnonce','scoreboard players operation #saved ce *= #factor sp_ctx','scoreboard players add #saved ce 200']+self.setting(2,0)+[f'scoreboard players operation {person()} sp_settings = #saved ce']+self.player('settings/save')+self.score('#setting_dialog','ce',4,'settings_replay_not_reopened')
        self.case('settings_isolation_replay',c)

        c=self.setup()+self.set('p1.reserve',[15,35])+self.set('p1.tokens',[1,2,0,0,0,1])+self.set('epoch',9)+self.call('game/sync')+self.snapshot()+self.call('system/reload')+self.unchanged('reload_state_preserved')+self.score(TABLE,'sp_epoch',9,'reload_epoch_preserved')+self.data('p1.reserve',[15,35],'reload_private_reserve_preserved')
        c+=self.player('ui/open')+['function splendor:load']+self.absent(person(),'sp_nonce','reload_old_nonce_invalid')+self.data('p1.reserve',[15,35],'load_private_reserve_preserved')
        self.case('reload_preserve',c)

        c=self.setup()+self.set('p1.reserve',[25,55])+self.set('epoch',12)+self.call('game/sync')+self.snapshot()
        self.case('server_reload',c)
        self.file('after_server_reload',self.unchanged('server_reload_full_state_preserved')+self.data('p1.reserve',[25,55],'server_reload_private_preserved')+self.score(TABLE,'sp_epoch',12,'server_reload_epoch_preserved'))

        c=self.setup(state=0)+[f'scoreboard players set {TABLE} ct_capacity 4',f'execute as {TABLE} at @s run function cardtable:game/start']+self.score(TABLE,'ct_start',1,'four_table_start')+self.score(TABLE,'ct_state',1,'four_table_active')+self.score(TABLE,'ct_expected',2,'four_table_session_members')
        self.case('four_seat_table',c)

        c=self.setup(state=0,n=2)+[f'execute as {TABLE} at @s run function cardtable:game/start']+self.score(TABLE,'ct_start',1,'start_handshake')+self.score(person(),'sp_side',1,'seat_order_first')+self.score(person(2),'sp_side',2,'seat_order_second')+self.data('p1.seat',2,'sparse_seat_metadata')+self.data('p2.seat',4,'sparse_second_seat')
        c+=[f'tag {person(2)} remove sg.person',f'execute as {TABLE} run function cardtable:session/check_table']+self.score(TABLE,'ct_paused',1,'disconnect_pauses_table')+self.snapshot()+self.call('game/tick')+self.unchanged('paused_tick_no_rules')
        c+=[f'tag {stable(2)} add sg.person',f'execute as {TABLE} run function cardtable:session/check_table']+self.score(TABLE,'ct_paused',0,'reconnect_resumes_table')
        c+=[f'tag {person(2)} remove sg.person']+self.call('game/cleanup')+self.score(TABLE,'ct_state',0,'cleanup_returns_lobby')+self.check('entity @e[tag=sg.identity,tag=sp.player,scores={sg_pid=1012}]','offline_old_state_still_present')
        c+=[f'tag {stable(2)} add sg.person',f'execute as {person(2)} at @s run function cardtable:session/reconcile_player']+self.check('entity @e[tag=sg.identity,tag=!sp.player,scores={sg_pid=1012}]','offline_after_end_cleared')+self.absent(person(2),'sp_side','offline_after_end_scores_cleared')
        self.case('start_session_cleanup',c)

        table_fixture = self.files['table']
        self.finish()
        self.files['table'] = table_fixture
        reload_case=self.files['case/server_reload'].splitlines()
        following=reload_case.pop()
        self.files['case/server_reload']='\n'.join(reload_case+['schedule function catan_engine_test:after_server_reload 10t','reload'])+'\n'
        self.files['after_server_reload']+=following+'\n'
        self.files['bootstrap']='\n'.join(['forceload add 0 0 63 31','scoreboard objectives add ce dummy','scoreboard objectives add sg_pid dummy','scoreboard objectives add ct_ctx dummy','function cardtable:system/install','scoreboard objectives add ct_chairs dummy','scoreboard objectives add ct_ch_epoch dummy','function cardtable:session/load','function splendor:load',f'schedule function catan_engine_test:case/{next(iter(self.cases))} 5t'])+'\n'
        self.files['finish']='kill @e[tag=sg.fixture]\nsay CATAN_FINISHED\n'
        return self


def fixture_line(line):
    # 保留玩家专属命令，宏真正解析；其他玩家分派替换为标记参与者。
    if any(x in line for x in ('dialog show ', 'dialog clear ', 'tellraw ', 'playsound ', 'stopsound ', 'title ')):
        return line
    return re.sub(r'@a\[', '@e[type=minecraft:marker,tag=sg.person,', line).replace('@a ', '@e[type=minecraft:marker,tag=sg.person] ')


def prepare(target):
    roots=[target/'data/splendor/function',target/'data/cardtable/function/session']
    extra=[target/'data/cardtable/function/game/remove_offline_player.mcfunction',target/'data/cardtable/function/game/return_lobby.mcfunction',target/'data/cardtable/function/game/start.mcfunction',target/'data/cardtable/function/seat/remove_player.mcfunction']
    for path in [p for root in roots for p in root.rglob('*.mcfunction')]+extra:
        if not path.exists():continue
        lines=[]
        for line in path.read_text(encoding='utf-8').splitlines():
            lines.append(fixture_line(line))
            if 'dialog show ' in line:
                lines.append('scoreboard players add #'+('setting_dialog' if '/settings/' in path.as_posix() else 'dialog')+' ce 1')
        path.write_text('\n'.join(lines)+'\n',encoding='utf-8')
    # 名称解析依赖玩家战利品上下文，桥接只替换该外部依赖，不改规则/界面。
    (target/'data/splendor/function/name/capture.mcfunction').write_text('data modify storage splendor:runtime name.value set from entity @s data.name\n',encoding='utf-8')
    load=target/'data/minecraft/tags/function/load.json'
    load.write_text(json.dumps({'values':['splendor:load']}),encoding='utf-8')


if __name__=='__main__':
    raise SystemExit(run(Suite().build(),full=True,prepare_target=prepare,prefix='fimel-splendor-game-',setup_ticks=3500))
