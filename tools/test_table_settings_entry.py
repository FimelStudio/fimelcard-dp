"""从实际公共点击入口验证UNO、各棋盘游戏、情书及掼蛋设置和Dialog编译。

隔离测试副本仅将参与者选择器适配为 marker，保留真实 dialog 命令目标；
宏末尾添加哨兵，确保整条 Dialog 通过原版编译，避免静默宏失败被漏检。
"""
from pathlib import Path
import json
import test_chess as base

ACTOR = '@e[type=minecraft:marker,tag=se.actor,limit=1]'
TABLE = '@e[type=minecraft:marker,tag=se.table,limit=1]'
OTHER = '@e[type=minecraft:marker,tag=se.other,limit=1]'
ACTOR2 = '@e[type=minecraft:marker,tag=se.actor2,limit=1]'
GAMES=[(11,'uno','un'),(12,'chess','ch'),(13,'xiangqi','xq'),(14,'gomoku','gm'),(15,'aeroplane_chess','ac'),(17,'love_letter','ll'),(18,'guandan','gd'),(20,'weiqi','go')]


def session_table(prefix):
    return prefix+'_settable' if prefix in ('ll','gd') else prefix+'_set_table'


def defaults(game,prefix,target=TABLE):
    if game in (12,13):values={'board':0,'palette':0,'orient':0,'first':0,'time':10,'level':2,'hints':1,'epoch':1}
    elif game==14:values={'size':15,'board':0,'palette':0,'orient':0,'first':0,'time':10,'level':2,'mark':1,'coords':1,'confirm':0,'epoch':1}
    elif game==15:values={'takeoff':0,'extra':1,'triple':0,'jump':1,'fly':1,'finish':0,'palette':0,'orient':0,'first':0,'speed':0,'hints':1,'fill':0,'ranking':0,'assign':0,'epoch':1}
    elif game==17:values={'first_setting':0,'goal_setting':0,'time_setting':0,'discards_setting':1,'epoch':1}
    elif game==18:values={'pair':0,'startlevel':2,'mode':0,'rounds':3,'show':1,'limit':0,'epoch':1}
    elif game==20:values={'size':19,'board':0,'orient':0,'first':1,'time':10,'komi':15,'level':2,'coords':1,'mark':1,'confirm':0,'estimate':1,'epoch':1,'state':0}
    else:values={}
    return [f'scoreboard players set {target} {prefix}_{objective} {value}' for objective,value in values.items()]


class EntrySuite(base.Suite):
    def build(self):
        self.file('reset', ['kill @e[tag=se.fixture]'])
        self.file('missing_settings', ['say SETTINGS_UNEXPECTED_FALLBACK'])
        self.file('missing_rules', ['say RULES_UNEXPECTED_FALLBACK'])
        for cap in (4,8):
          for game, namespace, prefix in GAMES:
            key=namespace+'_'+str(cap)
            commands = ['function chess_game_test:reset',
                        'summon minecraft:marker 8 64 8 {Tags:["se.fixture","se.table","ct.controller"]}',
                        'summon minecraft:marker 9 64 8 {Tags:["se.fixture","se.actor","ct.player"]}',
                        f'scoreboard players set {TABLE} ct_id 101',
                        f'scoreboard players set {TABLE} ct_game {game}',
                        f'scoreboard players set {TABLE} ct_state 0',
                        f'scoreboard players set {TABLE} ct_capacity {cap}',
                        f'scoreboard players set {ACTOR} ct_id 101',
                        f'scoreboard players set {ACTOR} ct_seat 3',
                        f'scoreboard players set #dialog_compiled_{prefix} cg 0']
            commands += defaults(game,prefix)
            commands += [f'execute as {ACTOR} at @s run function cardtable:click/game_settings']
            commands += self.check(f'score {ACTOR} {session_table(prefix)} matches 101', key + '_common_click_creates_session')
            commands += self.check(f'score {ACTOR} {prefix}_setnonce matches 1..', key + '_common_click_nonce')
            commands += self.score(f'#dialog_compiled_{prefix}', 'cg', 1, key + '_common_click_dialog_compiles')
            commands += self.count('@e[tag=ct.settings_actor]', 0, key + '_common_click_clears_actor')
            commands += self.count('@e[tag=ct.settings_controller]', 0, key + '_common_click_clears_controller')
            if game in (18,20):
                commands += ['kill @e[type=minecraft:interaction,tag=ct.rules]',
                             'summon minecraft:interaction 9 64 9 {Tags:["se.fixture","se.rule","ct.rules"]}',
                             'scoreboard players set @e[type=minecraft:interaction,tag=se.rule,limit=1] ct_id 101',
                             f'scoreboard players set #rules_compiled_{prefix} cg 0',
                             f'execute as {ACTOR} at @s run function cardtable:click/game_rules']
                commands += self.score('#rules_compiled_'+prefix,'cg',1,key+'_common_rules_dialog_compiles')
                commands += self.count('@e[tag=ct.rules_actor]',0,key+'_common_rules_clears_actor')
                commands += self.count('@e[tag=ct.rules_controller]',0,key+'_common_rules_clears_controller')
            self.case(key + '_entry', commands)
        for game,namespace,prefix,field,value,objective,initial in [(14,'gomoku','gm',7,3,'level',2),(15,'aeroplane_chess','ac',10,1,'speed',0),(17,'love_letter','ll',2,10,'goal_setting',0),(18,'guandan','gd',2,14,'startlevel',2),(20,'weiqi','go',1,15,'size',19)]:
            commands=['function chess_game_test:reset',
                      'summon minecraft:marker 8 64 8 {Tags:["se.fixture","se.table","ct.controller"]}',
                      'summon minecraft:marker 40 64 8 {Tags:["se.fixture","se.other","ct.controller"]}',
                      'summon minecraft:marker 9 64 8 {Tags:["se.fixture","se.actor","ct.player"]}',
                      'summon minecraft:marker 41 64 8 {Tags:["se.fixture","se.actor2","ct.player"]}']
            for table,actor,identifier,cap in [(TABLE,ACTOR,101,4),(OTHER,ACTOR2,202,8)]:
                commands += [f'scoreboard players set {table} ct_id {identifier}',f'scoreboard players set {table} ct_game {game}',f'scoreboard players set {table} ct_capacity {cap}',f'scoreboard players set {table} ct_state 0',f'scoreboard players set {actor} ct_id {identifier}',f'scoreboard players set {actor} ct_seat 3']+defaults(game,prefix,table)
            commands += [f'execute as {ACTOR} at @s run function cardtable:click/game_settings',f'scoreboard players operation #nonce_before cg = {ACTOR} {prefix}_setnonce',f'execute as {ACTOR2} at @s run function cardtable:click/game_settings']
            commands += self.score(ACTOR,session_table(prefix),101,namespace+'_first_session_table')+self.score(ACTOR2,session_table(prefix),202,namespace+'_second_session_table')
            commands += self.check(f'score {ACTOR} {prefix}_setnonce = #nonce_before cg',namespace+'_other_open_keeps_first_nonce')
            scale,offset=(100000,1000) if prefix in ('ll','gd') else (10000,100)
            commands += [f'scoreboard players operation {ACTOR} {prefix}_settings = {ACTOR} {prefix}_setnonce',f'scoreboard players set #setting_scale cg {scale}',f'scoreboard players operation {ACTOR} {prefix}_settings *= #setting_scale cg',f'scoreboard players add {ACTOR} {prefix}_settings {field*offset+value}',f'execute as {ACTOR} at @s run function {namespace}:settings/save']
            commands += self.score(TABLE,prefix+'_'+objective,value,namespace+'_save_updates_own_table')+self.score(OTHER,prefix+'_'+objective,initial,namespace+'_save_keeps_other_table')
            self.case(namespace+'_two_tables',commands)
        for cap in (4,8):
          for change,mutations in [('start',[f'scoreboard players set {TABLE} ct_state 1']),('table',[f'scoreboard players set {ACTOR} ct_id 202']),('game',[f'scoreboard players set {TABLE} ct_game 16']),('reload',['function love_letter:load'])]:
            commands=['function chess_game_test:reset','summon minecraft:marker 8 64 8 {Tags:["se.fixture","se.table","ct.controller"]}',
                      'summon minecraft:marker 9 64 8 {Tags:["se.fixture","se.actor","ct.player"]}',
                      f'scoreboard players set {TABLE} ct_id 101',f'scoreboard players set {TABLE} ct_game 17',f'scoreboard players set {TABLE} ct_state 0',f'scoreboard players set {TABLE} ct_capacity {cap}',
                      f'scoreboard players set {ACTOR} ct_id 101',f'scoreboard players set {ACTOR} ct_seat 3']+defaults(17,'ll')
            commands += [f'execute as {ACTOR} at @s run function cardtable:click/game_settings',f'scoreboard players operation #old_input cg = {ACTOR} ll_setnonce',
                         'scoreboard players set #setting_scale cg 100000','scoreboard players operation #old_input cg *= #setting_scale cg','scoreboard players add #old_input cg 2010']+mutations
            commands += [f'scoreboard players operation {ACTOR} ll_settings = #old_input cg',f'execute as {ACTOR} at @s run function love_letter:settings/save']
            commands += self.score(TABLE,'ll_goal_setting',0,f'love_letter_{cap}_stale_{change}_rejected')
            self.case(f'love_letter_{cap}_stale_{change}',commands)
        self.file('dialogs', ['say CHESS_DIALOGS_END'])
        self.case('dialogs', ['function chess_game_test:dialogs'])
        self.file('finish', ['function chess_game_test:reset', 'say CHESS_GAME_FINISHED'])
        self.file('bootstrap', ['forceload add -16 -16 63 31', 'scoreboard objectives add cg dummy', 'schedule function chess_game_test:case/' + self.cases[0] + ' 40t'])
        for index, name in enumerate(self.cases):
            self.files['case/' + name] += 'schedule function chess_game_test:' + ('case/' + self.cases[index + 1] if index + 1 < len(self.cases) else 'finish') + ' 3t\n'


original_copytree = base.shutil.copytree


def copytree(source, destination, *args, **kwargs):
    result = original_copytree(source, destination, *args, **kwargs)
    if Path(source) == base.PACK / 'data':
        root = Path(destination)
        paths = [root / 'cardtable/function/skin/open.mcfunction']
        for _,namespace,prefix in GAMES:
            paths += list((root / namespace / 'function/settings').glob('*.mcfunction'))
            macro = root / namespace / ('function/settings/show.mcfunction' if prefix in ('ll','gd') else 'function/settings/root_show.mcfunction')
            macro.write_text(macro.read_text(encoding='utf-8') + f'scoreboard players add #dialog_compiled_{prefix} cg 1\n', encoding='utf-8')
            if prefix in ('gd','go'):
                rules=root/namespace/'function/rules/show.mcfunction'
                rules.write_text(rules.read_text(encoding='utf-8')+f'scoreboard players add #rules_compiled_{prefix} cg 1\n',encoding='utf-8')
        for path in paths:
            lines = path.read_text(encoding='utf-8').splitlines()
            for index, line in enumerate(lines):
                if 'dialog show' not in line and 'tellraw' not in line:
                    lines[index] = line.replace('@a[tag=ct.settings_actor', '@e[type=minecraft:marker,tag=se.fixture,tag=ct.settings_actor')
            path.write_text('\n'.join(lines) + '\n', encoding='utf-8')
    return result


if __name__ == '__main__':
    # 真实右键/攻击入口均以 ct_kind=23 匹配；测试执行其实际奖励函数全链。
    for suffix in ('','_attack'):
        path=base.PACK/('data/cardtable/advancement/click/game_settings'+suffix+'.json')
        advancement=json.loads(path.read_text(encoding='utf-8'))
        assert advancement['rewards']['function']=='cardtable:click/game_settings'
        assert any(condition.get('scores',{}).get('ct_kind')==23
                   for criterion in advancement['criteria'].values()
                   for condition in criterion['conditions']['entity'])
    base.Suite = EntrySuite
    base.shutil.copytree = copytree
    raise SystemExit(base.main())
