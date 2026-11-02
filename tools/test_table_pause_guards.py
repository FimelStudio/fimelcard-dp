"""原版 26.2 隔离世界：21游戏逐刻冻结、跨桌继续和暂停期间管理员清理。"""
from pathlib import Path
import json
import re
import shutil
import subprocess
import sys
from build_table_pause_guards import GAMES, BEGIN, PACK
from test_guandan_cards import Suite as BaseSuite, run

JAVA = 'C:/Temp/fimel-java25-validation/jdk-25.0.5+8-jre/bin/java.exe'
CTRL = '@e[type=minecraft:marker,tag=pg.table,limit=1]'
IDS = {n: i for i, n in enumerate(GAMES, 1)}
IDS.update(ito=19, weiqi=20)


def static_checks():
    manifest = json.loads((PACK/'tools/table_pause_guard_manifest.json').read_text(encoding='utf-8'))
    for namespace, names in manifest.items():
        root = PACK/f'data/{namespace}/function'
        for name in names:
            text = (root/(name+'.mcfunction')).read_text(encoding='utf-8')
            assert BEGIN in text, (namespace, name)
        for name in ('game/abort', 'admin/abort', 'player/clear_state', 'game/cleanup', 'game/remove'):
            path = root/(name+'.mcfunction')
            if path.exists(): assert BEGIN not in path.read_text(encoding='utf-8'), (namespace, name)
    print('Static pause coverage:', len(manifest), 'games,', sum(map(len,manifest.values())), 'entrypoints', flush=True)


class Suite(BaseSuite):
    def table(self, namespace, paused=1):
        prefix = GAMES[namespace]
        fields = set()
        for p in (PACK/f'data/{namespace}/function').rglob('*.mcfunction'):
            fields.update(re.findall(r'^scoreboard objectives add ('+prefix+r'_\S+) dummy\s*$',p.read_text(encoding='utf-8'),re.M))
        fields.discard(prefix+'_ctx')
        values = {k:123 for k in fields}
        values.update({prefix+'_state':1, prefix+'_id':101, prefix+'_table':101})
        if namespace == 'fast_card': values[prefix+'_phase']=0
        self.file('fixture/'+namespace, [
            'tag @s add pg.table','tag @s add ct.controller',f'tag @s add {prefix}.controller',
            'scoreboard players set @s ct_id 101','scoreboard players set @s ct_state 1',
            f'scoreboard players set @s ct_game {IDS[namespace]}','scoreboard players set @s ct_capacity 4',
            f'scoreboard players set @s ct_paused {paused}',
            *[f'scoreboard players set @s {k} {v}' for k,v in values.items() if k in fields],
        ])
        return values, fields

    def build(self):
        for namespace, prefix in GAMES.items():
            values, fields = self.table(namespace)
            c = ['kill @e[tag=pg.table]',f'execute positioned 8 64 8 summon minecraft:marker run function guandan_test:fixture/{namespace}',
                 f'scoreboard players set #clock {prefix}_ctx 20',f'function {namespace}:tick']
            c += self.score(CTRL, 'ct_state', 1,namespace+'_keeps_table_active')
            c += self.count('@e[tag=pg.table,tag='+prefix+'.controller]',1,namespace+'_keeps_controller')
            for obj in sorted(fields): c += self.score(CTRL,obj,values[obj],namespace+'_'+obj+'_frozen')
            self.case('paused_'+namespace,c)
        # 顶层tick中没有函数包裹的计数也必须冻结；另一桌继续，不能暂停全世界。
        self.file('timer_table',[
            'tag @s add pg.table','tag @s add ab.controller',
            'scoreboard players set @s ab_state 3','scoreboard players set @s ab_timer 123',
        ])
        c = ['kill @e[tag=pg.table]',
             'execute positioned 8 64 8 summon minecraft:marker run function guandan_test:timer_table',
             f'scoreboard players set {CTRL} ct_paused 1',f'tag {CTRL} add pg.paused',
             'execute positioned 40 64 8 summon minecraft:marker run function guandan_test:timer_table',
             'scoreboard players set @e[tag=pg.table,tag=!pg.paused] ct_paused 0',
             'function abraca:tick']
        c += self.score('@e[tag=pg.paused,limit=1]','ab_timer',123,'raw_timer_paused')
        c += self.score('@e[tag=pg.table,tag=!pg.paused,limit=1]','ab_timer',122,'other_table_continues')
        c += ['scoreboard players set @e[tag=pg.paused] ct_paused 0','function abraca:tick']
        c += self.score('@e[tag=pg.paused,limit=1]','ab_timer',122,'same_timer_resumes')
        self.case('timers_are_per_table',c)
        # 管理员中止在暂停状态仍完整清理并返回大厅。
        c=['kill @e[tag=pg.table]','execute positioned 8 64 8 summon minecraft:marker run function guandan_test:fixture/avalon',f'execute as {CTRL} at @s run function avalon:game/abort']
        c+=self.score(CTRL,'ct_state',0,'paused_admin_abort_returns_lobby')
        c+=self.score(CTRL,'av_state',0,'paused_admin_abort_clears_game')
        self.case('abort_still_allowed',c)
        c=['kill @e[tag=pg.table]',
           'summon minecraft:armor_stand 8 64 8 {Tags:["pg.table"],NoGravity:1b}',
           f'item replace entity {CTRL.replace("minecraft:marker","minecraft:armor_stand")} weapon.mainhand with minecraft:diamond[minecraft:custom_data={{original_offhand:17}}] 3',
           f'item replace entity {CTRL.replace("minecraft:marker","minecraft:armor_stand")} weapon.offhand with minecraft:paper[minecraft:custom_data={{hanabi:{{card:1b,slot:4}}}}] 1',
           f'execute as {CTRL.replace("minecraft:marker","minecraft:armor_stand")} at @s run function cardtable:session/return_paused_offhand']
        actor=CTRL.replace('minecraft:marker','minecraft:armor_stand')
        c+=self.check(f'items entity {actor} weapon.mainhand minecraft:paper[minecraft:custom_data~{{hanabi:{{card:1b,slot:4}}}}]','paused_f_restores_game_card')
        c+=self.check(f'items entity {actor} weapon.offhand minecraft:diamond[minecraft:custom_data~{{original_offhand:17}}]','paused_f_preserves_other_item_components')
        c+=self.count('@e[type=minecraft:item,tag=ct.pause_swap]',0,'paused_f_no_duplicate_temp_item')
        c+=[f'item replace entity {actor} weapon.mainhand with minecraft:air',f'item replace entity {actor} weapon.offhand with minecraft:paper[minecraft:custom_data={{hanabi:{{card:1b,slot:2}}}}] 1',f'execute as {actor} at @s run function cardtable:session/return_paused_offhand']
        c+=self.check(f'items entity {actor} weapon.mainhand minecraft:paper[minecraft:custom_data~{{hanabi:{{card:1b,slot:2}}}}]','paused_f_empty_hand_restores_card')
        c+=['scoreboard players set #offhand gt 0',f'execute if items entity {actor} weapon.offhand * run scoreboard players set #offhand gt 1']
        c+=self.score('#offhand','gt',0,'paused_f_empty_hand_clears_offhand')
        self.case('paused_offhand',c)
        a='@e[tag=pg.ito_active,limit=1]';b='@e[tag=pg.ito_paused,limit=1]'
        c=['kill @e[tag=pg.table]',
           'summon minecraft:marker 8 64 8 {Tags:["pg.table","it.controller","pg.ito_active"]}',
           'summon minecraft:marker 10 64 8 {Tags:["pg.table","it.controller","pg.ito_paused"]}',
           'scoreboard players set @e[tag=pg.table] it_state 4',
           'scoreboard players set @e[tag=pg.table] it_timer 123',
           'scoreboard players set @e[tag=pg.table] it_pulse 0',
           f'scoreboard players set {a} ct_paused 0',f'scoreboard players set {b} ct_paused 1','function ito:tick']
        c+=self.score(a,'it_timer',122,'ito_three_dimension_loop_ticks_once')+self.score(a,'it_pulse',1,'ito_three_dimension_loop_one_heartbeat')
        c+=self.score(b,'it_timer',123,'ito_three_dimension_paused_timer_frozen')+self.score(b,'it_pulse',0,'ito_three_dimension_paused_pulse_frozen')
        self.case('ito_dimensions',c)
        self.file('bootstrap',['forceload add 0 0 63 31','scoreboard objectives add gt dummy','schedule function guandan_test:case/'+self.cases[0]+' 2t'])
        self.file('finish',['kill @e[tag=pg.table]','say GUANDAN_FINISHED'])
        for i,name in enumerate(self.cases):self.files['case/'+name]+='schedule function guandan_test:'+('case/'+self.cases[i+1] if i+1<len(self.cases) else 'finish')+' 2t\n'
        self.setup_ticks=len(self.cases)*2+200


if __name__=='__main__':
    static_checks()
    if '--java' not in sys.argv:sys.argv+=['--java',JAVA]
    real_run=subprocess.run
    def heap(command,*args,**kwargs):
        if len(command)>1 and str(command[1]).startswith('@'):
            p=Path(str(command[1])[1:]);p.write_text(p.read_text(encoding='utf-8').replace('-Xmx1536M','-Xmx3072M'),encoding='utf-8')
        return real_run(command,*args,**kwargs)
    subprocess.run=heap
    suite=Suite();suite.build()
    if '--ito-only' in sys.argv:
        sys.argv.remove('--ito-only')
        name='ito_dimensions';suite.cases=[name]
        suite.files={k:v for k,v in suite.files.items() if k in ('bootstrap','finish','case/'+name)}
        suite.files['bootstrap']=suite.files['bootstrap'].replace('case/paused_fast_card','case/'+name)
        suite.files['bootstrap']='\n'.join(f'scoreboard objectives add {x} {kind}' for x,kind in [('ct_paused','dummy'),('it_state','dummy'),('it_timer','dummy'),('it_pulse','dummy'),('it_action','trigger'),('it_settings','trigger')])+'\n'+suite.files['bootstrap']
        suite.expected=re.findall(r'GUANDAN_PASS ([a-z0-9_]+)',suite.files['case/'+name]);suite.setup_ticks=220
        def prepare(target):
            folder=target/'data/ito/function';folder.mkdir(parents=True,exist_ok=True)
            for name in ('tick','system/tick_dimension','game/tick'):
                dest=folder/(name+'.mcfunction');dest.parent.mkdir(parents=True,exist_ok=True)
                shutil.copy2(PACK/'data/ito/function'/(name+'.mcfunction'),dest)
        raise SystemExit(run(suite,isolated=True,prefix='fimel-table-pause-ito-',prepare_target=prepare))
    if '--offhand-only' in sys.argv:
        sys.argv.remove('--offhand-only')
        name='paused_offhand';suite.cases=[name]
        suite.files={k:v for k,v in suite.files.items() if k in ('bootstrap','finish','case/'+name)}
        suite.files['case/'+name]=re.sub(r'schedule function guandan_test:case/ito_dimensions 2t','schedule function guandan_test:finish 2t',suite.files['case/'+name])
        suite.files['bootstrap']=suite.files['bootstrap'].replace('case/paused_fast_card','case/'+name)
        suite.expected=re.findall(r'GUANDAN_PASS ([a-z0-9_]+)',suite.files['case/'+name])
        suite.setup_ticks=220
        def prepare(target):
            folder=target/'data/cardtable/function/session';folder.mkdir(parents=True,exist_ok=True)
            for function in ('return_paused_offhand','swap_paused_hands'):
                shutil.copy2(PACK/'data/cardtable/function/session'/(function+'.mcfunction'),folder/(function+'.mcfunction'))
        raise SystemExit(run(suite,isolated=True,prefix='fimel-table-pause-hands-',prepare_target=prepare))
    raise SystemExit(run(suite,isolated=False,prefix='fimel-table-pause-'))
