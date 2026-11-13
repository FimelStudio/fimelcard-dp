# -*- coding: utf-8 -*-
"""原版26.2公开牌面、动作轨迹、隐私和两桌隔离验收。"""
import hashlib
import itertools
import json
import math
import re
import subprocess
import wave
from boardgame_assets import CARD, RP, PACK
from build_guandan_visual import MODELS
from test_guandan_game import Suite as Base, TABLE, OTHER, part, person, prepare_target as prepare_game
from test_guandan_cards import run


class Suite(Base):
    def playable(self,*args,**kwargs):
        table=kwargs.get('table',args[2] if len(args)>2 else 101)
        return super().playable(*args,**kwargs)+self.call('visual/tick',table)*12

    def numeric(self,entity,path,value,name):
        n=round(value*100000)
        return [f'execute store result score #number gt run data get entity {entity} {path} 100000']+self.score('#number','gt',f'{n-3}..{n+3}',name)

    def public(self,seat,types,table=101):
        return [f'data modify entity {part(seat,table)} data.last_play set value {json.dumps(types)}',f'data modify entity {part(seat,table)} data.last_label set value "public"']

    def build(self):
        self.prepare()
        for cap,seats in ((4,(1,2,3,4)),(8,(2,3,6,7))):
            key=f'layout{cap}'
            c=self.playable(cap,seats)
            for seat in seats:c+=self.public(seat,[52,53])
            c+=self.call('visual/refresh')+self.call('visual/setup')
            for tag,count in (('box',2),('face',8),('label',4),('status',1)):
                c+=self.count(f'@e[tag=gd.{tag},scores={{ct_id=101}}]',count,f'{key}_{tag}')
            for seat in seats:
                c+=self.count(f'@e[tag=gd.face,scores={{ct_id=101,gd_v_seat={seat}}},nbt={{item:{{components:{{"minecraft:item_model":"card:poker/j_2"}}}}}}]',1,f'{key}_{seat}_smalljoker')
                c+=self.count(f'@e[tag=gd.face,scores={{ct_id=101,gd_v_seat={seat}}},nbt={{item:{{components:{{"minecraft:item_model":"card:poker/j_1"}}}}}}]',1,f'{key}_{seat}_bigjoker')
            self.case(key,c)
        for index,model in enumerate(MODELS):
            c=self.playable()+self.public(1,[index])+self.call('visual/refresh')
            c+=self.count(f'@e[tag=gd.face,scores={{ct_id=101}},nbt={{item:{{components:{{"minecraft:item_model":"card:poker/{model}"}}}}}}]',1,f'model{index}')
            self.case(f'model{index}',c)
        # 10张炸弹的全部物理牌显示在同一组，牌面上扬后落到桌面。
        values=[1,14,27,40,55,68,81,94,26,80]
        c=self.playable()+self.fixture_hands({1:values+[2],2:(3,4),3:(5,6),4:(7,8)})+[f'scoreboard players set {TABLE} gd_turn 1']+self.play(values)
        c+=self.count('@e[tag=gd.playing]',10,'ten_bomb_all_visible')+self.count('@e[tag=gd.box]',2,'boxes_stay_during_play')
        face='@e[tag=gd.playing,scores={gd_v_seat=1},limit=1]'
        c+=self.numeric(face,'transformation.translation[1]',.38,'play_starts_above')
        c+=self.call('visual/refresh')+self.count('@e[tag=gd.face]',10,'refresh_no_static_duplicate')
        c+=self.call('visual/tick')*8+self.count('@e[tag=gd.playing]',0,'eight_ticks_settled')+self.count('@e[tag=gd.face]',10,'settled_remains')
        c+=self.numeric('@e[tag=gd.face,limit=1]','transformation.translation[1]',.43/16,'card_front_above_table')
        c+=self.public(1,[])+self.call('visual/collect')+self.count('@e[tag=gd.collecting]',10,'old_trick_animated')
        c+=self.call('visual/tick')*8+self.count('@e[tag=gd.face]',0,'collect_reclaimed')+self.count('@e[tag=gd.box]',2,'boxes_stay_after_collect')
        self.case('play_collect',c)
        c=self.playable()+[f'data modify entity {TABLE} data.guandan.exchange set value [{{from:1,to:3,type:53,id:53}},{{from:2,to:4,type:52,id:52}}]']+self.call('visual/tribute')
        c+=self.count('@e[tag=gd.exchange]',2,'double_tribute_both_animated')+self.call('visual/refresh')+self.count('@e[tag=gd.exchange]',2,'tribute_survives_refresh')
        c+=self.call('visual/tick')*12+self.count('@e[tag=gd.exchange]',0,'tribute_reclaimed')
        c+=[f'scoreboard players set {TABLE} gd_steps 3']+self.call('visual/upgrade')+self.count('@e[tag=gd.upgrade]',1,'upgrade_animated')+self.call('visual/tick')*30+self.count('@e[tag=gd.upgrade]',0,'upgrade_reclaimed')
        self.case('exchange_upgrade',c)
        c=self.playable()+self.playable(8,(2,3,6,7),202,False)+['scoreboard players set @e[tag=gt.person] gt 0']
        for name in ('start','play','pass','bomb','straight_flush','tribute','round_win','end','illegal'):
            c+=self.call('sound/'+name)
        for seat in (1,2,3,4):c+=self.score(person(seat),'gt',9,f'sound_own_{seat}')
        for seat in (2,3,6,7):c+=self.score(person(seat,202),'gt',0,f'sound_other_{seat}')
        c+=[f'tag {person(1)} remove gd.player',f'scoreboard players set {person(2)} gd_table 202',f'scoreboard players set {person(3)} ct_id 303']
        c+=self.call('sound/play')+self.score(person(1),'gt',9,'sound_excludes_former_player')+self.score(person(2),'gt',9,'sound_excludes_wrong_game_table')+self.score('@e[tag=gt.person,scores={ct_id=303},limit=1]','gt',9,'sound_excludes_wrong_common_table')+self.score(person(4),'gt',10,'sound_current_player_hears')
        self.case('sound_routing',c)
        c=self.playable()+self.public(1,[1,2])+self.call('visual/refresh')+self.playable(8,(2,3,6,7),202,False)+self.public(2,[52,53],202)+self.call('visual/refresh',202)
        c+=self.call('visual/clear')+self.count('@e[tag=gd.visual,scores={ct_id=101}]',0,'clear_own')+self.count('@e[tag=gd.face,scores={ct_id=202}]',2,'clear_keeps_other_faces')+self.count('@e[tag=gd.box,scores={ct_id=202}]',2,'clear_keeps_other_boxes')
        c+=self.call('system/reload',202)+self.count('@e[tag=gd.face,scores={ct_id=202}]',2,'reload_restores_exact_public')+self.count('@e[tag=gd.box,scores={ct_id=202}]',2,'reload_no_duplicate_box')
        self.case('isolation',c)
        self.finish()


def assets():
    for model in MODELS+['back']:
        assert (CARD/f'items/poker/{model}.json').is_file(),model
    assert (CARD/'items/cardbox.json').is_file()
    # 独立读取实际生成的位置并变换原模型边界，四方最大牌组不得在桌角相互覆盖。
    generated=(PACK/'data/guandan/function/visual/load.mcfunction').read_text(encoding='utf8')
    model=json.loads((CARD/'models/item/fake_card.json').read_text(encoding='utf8'))
    corners=[]
    for cube in model['elements']:
        for xyz in itertools.product(*zip(cube['from'],cube['to'])):corners.append([(v-8)/16 for v in xyz])
    geometry=0
    for cap in (4,8):
        boxes={}
        for seat in range(1,cap+1):
            line=next(x for x in generated.splitlines() if f' c{cap}.s{seat}.n10 set value ' in x)
            cards=json.loads(line.split(' set value ',1)[1]);points=[]
            for card in cards:
                x,y,z,w=[card[k] for k in ('qx','qy','qz','qw')]
                m=((1-2*y*y-2*z*z,2*x*y-2*z*w,2*x*z+2*y*w),
                   (2*x*y+2*z*w,1-2*x*x-2*z*z,2*y*z-2*x*w),
                   (2*x*z-2*y*w,2*y*z+2*x*w,1-2*x*x-2*y*y))
                for p in corners:
                    points.append([sum(m[a][b]*p[b]*card['scale'] for b in range(3))+card['position'][a] for a in range(3)])
                # 牌正面法线为-Z，组合旋转后必须朝上。
                assert -m[1][2]>.999
                geometry+=1
            boxes[seat]=(min(p[0] for p in points),max(p[0] for p in points),min(p[2] for p in points),max(p[2] for p in points))
        choices=[(1,2,3,4)] if cap==4 else itertools.product((1,2),(3,4),(5,6),(7,8))
        for seats in choices:
            for a,b in itertools.combinations(seats,2):
                first,second=boxes[a],boxes[b]
                overlap_x=min(first[1],second[1])-max(first[0],second[0])
                overlap_z=min(first[3],second[3])-max(first[2],second[2])
                assert overlap_x<=0 or overlap_z<=0,(cap,a,b,overlap_x,overlap_z)
                geometry+=1
    print(f'Guandan card face normals and maximum-group non-overlap: {geometry} checks passed.')
    for p in (PACK/'data/guandan/function/visual').rglob('*.mcfunction'):
        s='\n'.join(line for line in p.read_text(encoding='utf8').splitlines() if not line.startswith('#'))
        assert 'gd_owner' not in s and 'gd_hand' not in s and 'gd.selected' not in s,p
    manifest=json.loads((RP/'.source/guandan/audio_manifest.json').read_text(encoding='utf8'))
    sounds=json.loads((CARD/'sounds.json').read_text(encoding='utf8'))
    assert len(manifest)==9
    for sound in manifest:
        p=RP/sound['output'];assert hashlib.sha256(p.read_bytes()).hexdigest()==sound['sha256']
        with wave.open(str(RP/sound['source'])) as audio:assert (audio.getnchannels(),audio.getsampwidth(),audio.getframerate())==(1,2,44100)
        info=json.loads(subprocess.check_output(['ffprobe','-v','error','-show_streams','-of','json',str(p)]))['streams'][0]
        assert info['channels']==1 and info['codec_name']=='vorbis'
        assert 'guandan.'+sound['name'] in sounds
        code=(PACK/f'data/guandan/function/sound/{sound["name"]}.mcfunction').read_text(encoding='utf8')
        assert 'll.' not in code and 'll_ctx' not in code and 'll_table' not in code
    print('Existing poker assets, display privacy and nine original sound hashes verified.')


def prepare_target(target):
    prepare_game(target)
    # 仅用计数器代替客户端声音输出；保留生产接收者、桌号与身份过滤。
    for p in (target/'data/guandan/function/sound').glob('*.mcfunction'):
        lines=[]
        for line in p.read_text(encoding='utf8').splitlines():
            if ' run playsound ' in line:
                line=line.split(' run playsound ',1)[0].replace('@a[','@e[')+' run scoreboard players add @s gt 1'
            lines.append(line)
        p.write_text('\n'.join(lines)+'\n',encoding='utf8')


if __name__=='__main__':
    assets();suite=Suite();suite.build();raise SystemExit(run(suite,isolated=False,prefix='fimel-guandan-visual-',prepare_target=prepare_target))
