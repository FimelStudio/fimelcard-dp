"""在独立临时世界中运行原版 26.2 展示、隐私边界与动画检查。"""
import json
import hashlib
import subprocess
import wave
from pathlib import Path
from PIL import Image
from test_aeroplane_chess import Suite as Base, TABLE, OTHER, run
from boardgame_assets import PACK, RP, CARD


class Suite(Base):
    def call(self,name,table=101):
        return [f'execute as {TABLE if table==101 else OTHER} at @s run function love_letter:{name}']

    def numeric(self,entity,path,value,name):
        expected=round(value*100000)
        return [f'execute store result score #numeric ag run data get entity {entity} {path} 100000']+self.check(
            f'score #numeric ag matches {expected-3}..{expected+3}',name)

    def setup(self,cap=4,seats=(1,3),table=101,reset=True):
        commands=['function aeroplane_test:reset'] if reset else []
        commands += [f'execute positioned {8.0 if table==101 else 40.0} 64.0 8.0 summon minecraft:marker run function aeroplane_test:table {{table:{table},cap:{cap}}}']
        for seat in seats:
            commands += [f'execute positioned {8.0 if table==101 else 40.0} 64.0 8.0 summon minecraft:marker run function aeroplane_test:part {{table:{table},seat:{seat}}}']
        return commands+self.call('visual/refresh',table)

    def build(self):
        self.file('reset',['kill @e[tag=ag.table]','kill @e[tag=ll.part]','kill @e[tag=ll.visual]'])
        self.file('table','''
tag @s add ag.table
tag @s add ct.controller
tag @s add ll.controller
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ct_capacity $(cap)
scoreboard players set @s ct_game 17
scoreboard players set @s ct_state 1
scoreboard players set @s ll_state 2
scoreboard players set @s ll_players 2
data merge entity @s {data:{love_letter:{public:[2,6,8],action:{actor:1,card:7,target:3,guess:0,eliminated:[],forced:-1}},ll_private:{secrets:[9,9,9]}}}
''')
        self.file('part','''
tag @s add ll.part
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ll_seat $(seat)
scoreboard players set @s ll_alive 1
scoreboard players set @s ll_protect 0
scoreboard players set @s ll_hand 9
scoreboard players set @s ll_extra 9
scoreboard players set @s ll_spy 0
scoreboard players set @s ll_points 0
data merge entity @s {data:{discards:[1,3,4]}}
''')
        layouts={4:[(0,-.88),(.88,0),(0,.88),(-.88,0)],
                 8:[(-.75,-1.30),(.75,-1.30),(1.30,-.75),(1.30,.75),(.75,1.30),(-.75,1.30),(-1.30,.75),(-1.30,-.75)]}
        for cap,seats in ((4,(1,3)),(8,(1,2,4,5,7,8))):
            key=f'layout_{cap}'
            c=self.setup(cap,seats)
            for tag,count in (('ll.box',1),('ll.face',len(seats)),('ll.label',len(seats)),('ll.public',3)):
                c+=self.count(f'@e[tag={tag},scores={{ct_id=101}}]',count,key+'_'+tag.replace('.','_'))
            for seat in seats:
                face=f'@e[tag=ll.face,scores={{ct_id=101,ll_v_seat={seat}}},limit=1]'
                x,z=layouts[cap][seat-1]
                c+=self.numeric(face,'Pos[0]',8+x,key+f'_seat{seat}_x')
                c+=self.numeric(face,'Pos[2]',8+z,key+f'_seat{seat}_z')
                c+=self.check(f'data entity {face} item.components{{"minecraft:item_model":"card:love_letter/handmaid"}}',key+f'_seat{seat}_discard_only')
                c+=self.check(f'data entity {face} {{view_range:0.5f}}',key+f'_seat{seat}_view_range')
            c+=self.count('@e[tag=ll.visual,nbt={item:{components:{"minecraft:item_model":"card:love_letter/princess"}}}]',0,key+'_private_princess_never_displayed')
            c+=self.call('visual/refresh')+self.call('visual/setup')+self.count('@e[tag=ll.box]',1,key+'_refresh_keeps_single_box')
            c+=[f'scoreboard players set @e[tag=ll.part,scores={{ct_id=101,ll_seat={seats[0]}}}] ll_protect 1']+self.call('visual/refresh')
            c+=self.count('@e[tag=ll.protect]',1,key+'_one_protected_frame')
            self.case(key,c)
        c=self.setup()+[f'scoreboard players set @e[tag=ll.part,scores={{ct_id=101,ll_seat=1}}] ll_points 2']+self.call('visual/refresh')
        c+=self.count('@e[tag=ll.favor]',1,'favor_static_mark')+self.count('@e[tag=ll.fx,scores={ll_v_kind=2}]',1,'favor_new_score_animated')
        c+=self.call('visual/refresh')+self.count('@e[tag=ll.fx,scores={ll_v_kind=2}]',1,'favor_refresh_does_not_repeat')
        c+=self.call('visual/tick')*12
        token='@e[tag=ll.fx,scores={ll_v_kind=2},limit=1]'
        c+=self.numeric(token,'transformation.translation[0]',-.36,'favor_arrives_player_x')
        c+=self.numeric(token,'transformation.translation[2]',-.88,'favor_arrives_player_z')
        c+=self.call('visual/tick')+self.count('@e[tag=ll.fx]',0,'favor_fx_reclaimed')
        self.case('favor',c)
        for role in range(10):
            c=self.setup()+[f'data modify entity {TABLE} data.love_letter.action set value {{actor:1,card:{role},target:3,guess:8,eliminated:[],forced:-1}}']
            c+=self.call('visual/event')+self.call('visual/refresh')
            c+=self.count('@e[tag=ll.fx]',3 if role==7 else 1,f'role{role}_event_survives_refresh')
            face=f'@e[tag=ll.fx,scores={{ll_v_seat=1}},nbt={{item:{{components:{{"minecraft:item_model":"card:love_letter/{("spy","guard","priest","baron","handmaid","prince","chancellor","king","countess","princess")[role]}"}}}}}},limit=1]'
            c+=self.numeric(face,'transformation.translation[1]',.48,f'role{role}_starts_above_table')
            c+=self.call('visual/tick')*8
            c+=self.numeric(face,'transformation.translation[1]',.022,f'role{role}_settles_after_eight_ticks')
            c+=self.call('visual/tick')*6+self.count('@e[tag=ll.fx]',0,f'role{role}_fx_reclaimed')
            self.case(f'event_{role}',c)
        c=self.setup()+[f'data modify entity {TABLE} data.love_letter.action set value {{actor:1,card:1,target:3,guess:8,eliminated:[],forced:-1}}']
        c+=self.call('visual/event')+['scoreboard players set #frame ag 0','schedule function aeroplane_test:real_tick 1t']
        self.case('real_motion',c)
        motion='@e[tag=ll.fx,scores={ll_v_seat=1},limit=1]'
        middle=self.numeric(motion,'transformation.translation[1]',.301,'actual_fourth_tick_midpoint')
        ending=self.numeric(motion,'transformation.translation[1]',.022,'actual_eighth_tick_endpoint')
        self.file('real_middle',middle)
        self.file('real_ending',ending)
        self.file('real_tick',['scoreboard players add #frame ag 1']+self.call('visual/tick')+[
            'execute if score #frame ag matches 4 run function aeroplane_test:real_middle',
            'execute if score #frame ag matches 8 run function aeroplane_test:real_ending',
            'execute if score #frame ag matches ..8 run schedule function aeroplane_test:real_tick 1t',
            'execute if score #frame ag matches 9 run schedule function aeroplane_test:case/isolation 1t'])
        c=self.setup()+self.setup(8,(2,5),202,False)+self.call('visual/clear')
        c+=self.count('@e[tag=ll.visual,scores={ct_id=101}]',0,'clear_only_own_table')
        c+=self.count('@e[tag=ll.visual,scores={ct_id=202}]',8,'clear_other_table_preserved')
        c+=self.call('visual/refresh',202)+self.count('@e[tag=ll.box,scores={ct_id=202}]',1,'other_table_box_not_duplicated')
        self.case('isolation',c)
        self.file('bootstrap',['forceload add -16 -16 63 31','scoreboard objectives add ag dummy',
                               'function love_letter:load','schedule function aeroplane_test:case/'+self.cases[0]+' 20t'])
        self.file('finish',['function aeroplane_test:reset','say AEROPLANE_FINISHED'])
        for i,name in enumerate(self.cases):
            if name=='real_motion':continue
            self.files['case/'+name]+='schedule function aeroplane_test:'+('case/'+self.cases[i+1] if i+1<len(self.cases) else 'finish')+' 1t\n'


def assets():
    roles=('spy','guard','priest','baron','handmaid','prince','chancellor','king','countess','princess')
    for role in roles:
        for suffix in ('','_selected'):
            image=Image.open(CARD/f'textures/item/love_letter/{role}{suffix}.png')
            assert image.size==(256,384),(role,image.size)
        model=json.loads((CARD/f'models/item/love_letter/{role}.json').read_text(encoding='utf-8'))
        assert model['textures']['front']==f'card:item/love_letter/{role}'
        assert model['textures']['back']=='card:item/love_letter/back'
    for path in (CARD/'models/item/love_letter').rglob('*.json'):
        model=json.loads(path.read_text(encoding='utf-8'))
        for key,texture in model['textures'].items():
            namespace,name=texture.split(':')
            assert (RP/f'assets/{namespace}/textures/{name}.png').is_file(),(path,texture)
    for name in ('dialog','dialog_selected'):
        providers=json.loads((CARD/f'font/love_letter/{name}.json').read_text(encoding='utf-8'))['providers']
        assert len(providers)==10
        assert [p['chars'][0] for p in providers]==[chr(0xe800+i) for i in range(10)]
        assert all(p['height']==54 and p['ascent']==50 for p in providers)
    for path in (PACK/'data/love_letter/function/visual').rglob('*.mcfunction'):
        body='\n'.join(line for line in path.read_text(encoding='utf-8').splitlines() if not line.startswith('#'))
        assert 'll_hand' not in body and 'll_extra' not in body and 'll_private' not in body,path
    manifest=json.loads((RP/'.source/love_letter/audio_manifest.json').read_text(encoding='utf-8'))
    sounds=json.loads((CARD/'sounds.json').read_text(encoding='utf-8'))
    assert len(manifest)==8
    for sound in manifest:
        output=RP/sound['output'];source=RP/sound['source']
        assert hashlib.sha256(output.read_bytes()).hexdigest()==sound['sha256']
        with wave.open(str(source),'rb') as audio:
            assert (audio.getnchannels(),audio.getframerate(),audio.getsampwidth())==(1,44100,2)
        metadata=json.loads(subprocess.check_output(['ffprobe','-v','error','-show_streams','-of','json',str(output)]))['streams'][0]
        assert metadata['codec_name']=='vorbis' and metadata['channels']==1
        assert 'love_letter.'+sound['name'] in sounds
    print('Love Letter static art, model, font and world-display privacy checks passed.')


if __name__=='__main__':
    assets();suite=Suite();suite.build();raise SystemExit(run(suite))
