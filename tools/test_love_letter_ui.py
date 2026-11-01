"""情书 UI 独立原版26.2验收：真实宏编译、触发器路由、设置及秘密消息受众。"""
from pathlib import Path
import json
import re
import shutil
from test_love_letter_engine import Suite as BaseSuite, run, TABLE, OTHER, part

PACK = Path(__file__).resolve().parents[1]


def person(seat=1, table=101):
    return f'@e[type=minecraft:armor_stand,tag=lt.person,scores={{ll_table={table},ll_seat={seat}}},limit=1]'


class Suite(BaseSuite):
    def setup(self, hands=(2,3,4), seats=None, extra=1, deck=(0,1,2,3,4,5,6,7,8,9), reserve=9, table=101, reset=True):
        lines=super().setup(hands,seats,extra,deck,reserve,table,reset)
        seats=seats or tuple(range(1,len(hands)+1))
        ctrl=TABLE if table==101 else OTHER
        lines += [f'tag {ctrl} add ll.controller', f'scoreboard players set {ctrl} ll_epoch 12345',
                  f'scoreboard players set {ctrl} ll_goal_setting 0',f'scoreboard players set {ctrl} ll_first_setting 0',
                  f'scoreboard players set {ctrl} ll_time_setting 0',f'scoreboard players set {ctrl} ll_discards_setting 1']
        for seat in seats:
            lines += [f'execute positioned {8.0 if table==101 else 40.0} 64.0 8.0 summon minecraft:armor_stand run function love_letter_test:person {{table:{table},seat:{seat}}}']
        return lines+self.call('system/context',table)

    def open(self,name='open',seat=1,table=101):
        return ['scoreboard players set #ui_compiled lt 0',f'execute as {person(seat,table)} at @s run function love_letter:ui/{name}']

    def submit(self,code,seat=1,table=101):
        return [f'scoreboard players set {person(seat,table)} ll_action {12345000+code}',
                f'execute as {person(seat,table)} at @s run function love_letter:input/submit']

    def settings(self,field,value,seat=1,table=101):
        return [f'scoreboard players operation #setting_code lt = {person(seat,table)} ll_setnonce',
                'scoreboard players set #factor lt 100000','scoreboard players operation #setting_code lt *= #factor lt',
                f'scoreboard players add #setting_code lt {field*1000+value}',
                f'scoreboard players operation {person(seat,table)} ll_settings = #setting_code lt',
                f'execute as {person(seat,table)} at @s run function love_letter:settings/save']

    def build(self):
        self.prepare()
        self.file('person','''
tag @s add lt.fixture
tag @s add lt.person
tag @s add ll.player
tag @s add ct.player
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ll_table $(table)
$scoreboard players set @s ll_seat $(seat)
$scoreboard players set @s ct_seat $(seat)
scoreboard players set @s ll_pick -1
scoreboard players set @s ll_secret 0
data merge entity @s {NoGravity:1b,Invisible:1b,Invulnerable:1b}
''')
        c=self.setup((7,9,6),extra=3)+self.open()+self.score('#ui_compiled','lt',1,'main_dialog_codec')
        c+=self.check('data storage love_letter:ui cards.extra[{extra:[{text:"'+chr(0xE807)+'",font:"card:love_letter/dialog"}]}]','own_king_card_only')
        c+=self.submit(10)+self.score(person(),'ll_pick',0,'first_card_select')+self.check('data storage love_letter:ui cards.extra[{extra:[{font:"card:love_letter/dialog_selected"}]}]','selected_gold_font')
        c+=self.submit(10)+self.score(person(),'ll_pick',-1,'same_card_deselect')
        c+=self.submit(10)+self.submit(11)+self.score(person(),'ll_pick',1,'other_card_transfer')
        c+=self.submit(20)+self.score(TABLE,'ll_card',3,'selected_card_routes_play')+self.score(part(),'ll_hand',7,'play_keeps_other_card')+self.score(TABLE,'ll_phase',2,'play_awaits_target')
        self.case('select_play',c)
        for role in (1,2,3,5,7):
            c=self.setup((8,9,6),extra=-1)+[f'scoreboard players set {TABLE} ll_phase 2',f'scoreboard players set {TABLE} ll_actor 1',f'scoreboard players set {TABLE} ll_card {role}',f'scoreboard players set {part(3)} ll_protect 1']+self.open()
            c+=self.score('#ui_compiled','lt',1,f'target_role_{role}_codec')
            c+=[f'execute store result score #buttons lt run data get storage love_letter:ui buttons']+self.score('#buttons','lt',4 if role==5 else 3,f'target_role_{role}_legal_count')
            c+=self.check('data storage love_letter:ui buttons[{action:{command:"trigger ll_action set 12345102"}}]',f'target_role_{role}_other_present')
            c+=['execute store success score #protected_present lt if data storage love_letter:ui buttons[{action:{command:"trigger ll_action set 12345103"}}]']+self.score('#protected_present','lt',0,f'target_role_{role}_protected_hidden')
            c+=self.submit(102)+self.score(TABLE,'ll_target',2,f'target_role_{role}_routed')
            self.case('targets_'+str(role),c)
        c=self.setup((8,9,6),extra=-1)+[f'scoreboard players set {TABLE} ll_phase 3',f'scoreboard players set {TABLE} ll_actor 1',f'scoreboard players set {TABLE} ll_card 1',f'scoreboard players set {TABLE} ll_target 2']+self.open()+self.score('#ui_compiled','lt',1,'guess_codec')
        c+=[f'execute store result score #buttons lt run data get storage love_letter:ui buttons']+self.score('#buttons','lt',11,'guard_nine_allowed_guesses')+self.submit(209)+self.score(part(2),'ll_alive',0,'guess_princess_routes_elimination')
        self.case('guess',c)
        for phase,buffer in [(4,[8,5,7]),(5,[5,7])]:
            c=self.setup((8,9,6),extra=-1)+[f'scoreboard players set {TABLE} ll_phase {phase}',f'scoreboard players set {TABLE} ll_actor 1',f'data modify entity {TABLE} data.ll_buffer set value {buffer}']+self.open()+self.score('#ui_compiled','lt',1,f'chancellor_{phase}_codec')
            c+=['execute store result score #cards lt run data get storage love_letter:ui cards.extra']+self.score('#cards','lt',len(buffer),f'chancellor_{phase}_all_private_candidates')
            c+=self.submit(301 if phase==4 else 401)
            c+=self.score(part(),'ll_hand',5,f'chancellor_{phase}_routes_keep') if phase==4 else self.data(TABLE,'data.love_letter.deck',list(range(10))+[7,5],'chancellor_routes_bottom_order')
            self.case('chancellor_'+str(phase),c)
        c=self.setup((8,9,6),extra=4)+[f'data modify entity {part(2)} data.discards set value [1,2]',f'data modify entity {TABLE} data.love_letter.public set value [0,4,5]']
        for panel in ['menu','resign','public']:
            c+=self.open(panel)+self.score('#ui_compiled','lt',1,panel+'_codec')
        c+=self.data(part(2),'data.discards',[1,2],'history_readonly')+self.score(part(2),'ll_hand',9,'history_hidden_hand_untouched')
        c+=['scoreboard players set #rules_compiled lt 0',f'tag {person()} add ct.rules_actor']+self.call('rules/show')+self.score('#rules_compiled','lt',1,'rules_controller_codec')
        c+=[f'execute as {person()} run function love_letter:rules/player']+self.score('#rules_compiled','lt',2,'rules_player_codec')
        self.case('menus_public_rules',c)
        c=self.setup((8,9,6),extra=4)+[f'scoreboard players set {part()} ll_alive 0',f'scoreboard players set {part()} ll_hand -1',f'scoreboard players set {part()} ll_extra -1']+self.open()+self.score('#ui_compiled','lt',1,'eliminated_empty_hand_dialog_codec')
        c+=self.submit(10)+self.score(person(),'ll_pick',-1,'eliminated_player_cannot_select')
        c+=self.open('menu')+self.score('#ui_compiled','lt',1,'eliminated_menu_dialog_codec')
        c+=['execute store success score #resign_present lt if data storage love_letter:ui buttons[{action:{command:"trigger ll_action set 12345005"}}]']+self.score('#resign_present','lt',0,'eliminated_player_no_resign_button')
        self.case('eliminated_menu',c)
        for phase in (1,2,3,4,5):
            c=self.setup((7,9,6),extra=3)+[f'scoreboard players set {TABLE} ll_phase {phase}',f'scoreboard players set {TABLE} ll_actor 2',f'data modify entity {TABLE} data.ll_buffer set value [8,7,5]']+self.call('ui/refresh')
            c+=self.score('#last_viewer','lt',1 if phase==1 else 2,f'refresh_{phase}_only_decider')
            self.case('refresh_'+str(phase),c)
        for change,commands in [('epoch',[f'scoreboard players add {TABLE} ll_epoch 1']),('reload',['scoreboard players add #ui_load ll_ctx 1']),('game',[f'scoreboard players set {TABLE} ct_game 16']),('table',[f'scoreboard players set {person()} ct_id 202']),('inactive',[f'scoreboard players set {TABLE} ct_state 0'])]:
            actual=person()
            c=self.setup((7,9,6),extra=3)+self.open()+commands+[f'scoreboard players set {actual} ll_action 12345010',f'execute as {actual} at @s run function love_letter:input/submit']+self.score(actual,'ll_pick',-1,'stale_'+change+'_rejected')+self.data(part(),'data.discards',[],'stale_'+change+'_no_discard')
            self.case('stale_'+change,c)
        # 原版消息本身保留；测试副本只在同一条件后记录收到消息的测试实体。
        for kind in ('priest','baron','king'):
            c=self.setup((8,9,6),extra=-1)+[f'data modify entity {TABLE} data.ll_private set value '+json.dumps({'kind':kind,'seat':1,'target':2,'actor_card':8,'target_card':9},separators=(',',':'))]+self.call('ui/private')
            for seat in (1,2,3):c+=self.score(person(seat),'ll_secret',int(seat==1 or seat==2 and kind!='priest'),kind+f'_private_p{seat}')
            c+=self.check(f'entity {TABLE}',kind+'_controller_survives')+self.data(TABLE,'data.ll_buffer',[],kind+'_buffer_untouched')
            c+=['execute store success score #private_exists lt if data entity '+TABLE+' data.ll_private']+self.score('#private_exists','lt',0,kind+'_private_consumed')
            c+=self.call('ui/private')+self.score(person(),'ll_secret',1,kind+'_no_duplicate_message')
            self.case('private_'+kind,c)
        for field,obj,values in [(1,'first',[0,1]),(2,'goal',range(11)),(3,'discards',[0,1]),(4,'time',[0,30,60,90,120])]:
            for value in values:
                key=f'setting_{field}_{value}'
                c=self.setup()+[f'scoreboard players set {TABLE} ct_state 0',f'scoreboard players set {TABLE} ll_state 0',f'tag {person()} add ct.settings_actor','scoreboard players set #settings_compiled lt 0']+self.call('settings/open')+self.score('#settings_compiled','lt',1,key+'_codec')
                c+=self.settings(field,value)+self.score(TABLE,'ll_'+obj+'_setting',value,key+'_instant')
                self.case(key,c)
        for change,commands in [('start',[f'scoreboard players set {TABLE} ct_state 1']),('table',[f'scoreboard players set {person()} ct_id 202']),('game',[f'scoreboard players set {TABLE} ct_game 16']),('reload',['scoreboard players add #ui_load ll_ctx 1'])]:
            c=self.setup()+[f'scoreboard players set {TABLE} ct_state 0',f'tag {person()} add ct.settings_actor']+self.call('settings/open')+commands+self.settings(2,10)+self.score(TABLE,'ll_goal_setting',0,'stale_settings_'+change)
            self.case('stale_settings_'+change,c)
        c=self.setup()+self.setup(table=202,reset=False)+[f'scoreboard players set {TABLE} ct_state 0',f'scoreboard players set {OTHER} ct_state 0',f'tag {person()} add ct.settings_actor']+self.call('settings/open')+self.settings(2,10)+self.score(TABLE,'ll_goal_setting',10,'settings_own_table_changes')+self.score(OTHER,'ll_goal_setting',0,'settings_other_table_unchanged')
        self.case('two_tables',c)
        c=self.setup()+self.setup(table=202,reset=False)+[f'data modify entity {TABLE} data.ll_private set value {{kind:"priest",seat:1,target:2,actor_card:8,target_card:9}}']+self.call('ui/private')
        c+=self.score(person(),'ll_secret',1,'private_own_table_authorized')
        for seat in (1,2,3):c+=self.score(person(seat,202),'ll_secret',0,f'private_other_table_p{seat}_isolated')
        self.case('private_two_tables',c)
        for field,value in [(0,1),(1,2),(2,11),(3,2),(4,45),(5,0)]:
            key=f'invalid_setting_{field}_{value}'
            c=self.setup()+[f'scoreboard players set {TABLE} ct_state 0',f'tag {person()} add ct.settings_actor']+self.call('settings/open')+self.settings(field,value)
            for obj,original in [('first',0),('goal',0),('discards',1),('time',0)]:c+=self.score(TABLE,'ll_'+obj+'_setting',original,key+'_'+obj+'_unchanged')
            self.case(key,c)
        self.finish()
        self.files['bootstrap']=self.files['bootstrap'].replace('function love_letter_test:reset','scoreboard objectives add ct_seat dummy\nscoreboard objectives add ll_secret dummy\nscoreboard players set #ui_load ll_ctx 1\nscoreboard players set #setting_serial ll_ctx 0\nfunction love_letter_test:reset')


def prepare_target(target):
    """仅替换视觉生命周期回调；所有 UI、Dialog、规则引擎和设置均使用生产文件。"""
    for folder in ['ui','input','settings','rules','name']:
        shutil.copytree(PACK/'data/love_letter/function'/folder,target/'data/love_letter/function'/folder,dirs_exist_ok=True)
    shutil.copytree(PACK/'data/love_letter/loot_table',target/'data/love_letter/loot_table',dirs_exist_ok=True)
    for name,body in {'game/init_table':'# 此验收只检查已有合法设置，不创建桌面视觉。',
                      'game/resign':'function love_letter:engine/resign',
                      'game/bump_epoch':'scoreboard players add @s ll_epoch 1'}.items():
        dest=target/'data/love_letter/function'/(name+'.mcfunction');dest.parent.mkdir(parents=True,exist_ok=True);dest.write_text(body+'\n',encoding='utf-8')
    for path in (target/'data/love_letter/function').rglob('*.mcfunction'):
        lines=[]
        for line in path.read_text(encoding='utf-8').splitlines():
            if not any(token in line for token in ['tellraw ','dialog ','title ','playsound ','input/give','input/clear','clear @s','give @s','item replace']):
                line=line.replace('@a[','@e[')
            lines.append(line)
            if 'run tellraw @a[tag=ll.private_viewer]' in line:
                lines.append(line.split('run tellraw')[0]+'run execute as @e[tag=ll.private_viewer] run scoreboard players add @s ll_secret 1')
        if path.name=='show.mcfunction' and path.parent.name=='ui':lines+=['scoreboard players set #ui_compiled lt 1','scoreboard players operation #last_viewer lt = @s ll_seat']
        if path.name=='show.mcfunction' and path.parent.name=='settings':lines+=['scoreboard players set #settings_compiled lt 1']
        if path.parent.name=='rules':lines+=['scoreboard players add #rules_compiled lt 1']
        path.write_text('\n'.join(lines)+'\n',encoding='utf-8')


if __name__=='__main__':
    suite=Suite();suite.build();raise SystemExit(run(suite,prepare_target=prepare_target,prefix='fimel-loveletter-ui-'))
