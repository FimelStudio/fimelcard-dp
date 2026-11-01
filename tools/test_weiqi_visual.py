# -*- coding: utf-8 -*-
"""原版26.2围棋展示：单交互、三尺寸、占地压缩、提子动画和邻桌隔离。"""
import hashlib
import json
import subprocess
import wave
from pathlib import Path
from PIL import Image
from boardgame_assets import PACK, RP, CARD
from test_guandan_cards import Suite as Base, run
from build_gomoku_visual import position

C='@e[type=minecraft:marker,tag=gv.table,scores={ct_id=101},limit=1]'
D='@e[type=minecraft:marker,tag=gv.table,scores={ct_id=202},limit=1]'


def cell(sq,table=101):return f'@e[tag=go.square,scores={{ct_id={table},go_sq={sq}}},limit=1]'


class Suite(Base):
    def call(self,name,table=101):return [f'execute as {C if table==101 else D} at @s run function weiqi:{name}']
    def setup(self,size=19,cap=4,orient=0,table=101,reset=True):
        c=['function guandan_test:reset'] if reset else []
        c+=[f'execute positioned {8.0 if table==101 else 40.0} 64.0 8.0 summon minecraft:marker run function guandan_test:table {{table:{table},size:{size},cap:{cap},orient:{orient}}}']
        return c+self.call('system/create_board',table)+self.call('engine/init_board',table)+self.call('visual/setup',table)
    def numeric(self,who,path,value,name):
        n=round(value*100000)
        return [f'execute store result score #number gt run data get entity {who} {path} 100000']+self.score('#number','gt',f'{n-4}..{n+4}',name)
    def build(self):
        self.file('reset','kill @e[tag=gv.fixture]\nkill @e[tag=go.square]\nkill @e[tag=go.visual]')
        self.file('table',r'''
tag @s add gv.fixture
tag @s add gv.table
tag @s add ct.controller
tag @s add go.controller
$scoreboard players set @s ct_id $(table)
scoreboard players set @s ct_game 20
scoreboard players set @s ct_state 1
$scoreboard players set @s ct_capacity $(cap)
$scoreboard players set @s go_size $(size)
$scoreboard players set @s go_orient $(orient)
scoreboard players set @s go_board 0
scoreboard players set @s go_coords 1
scoreboard players set @s go_mark 1
scoreboard players set @s go_sel -1
scoreboard players set @s go_state 1
scoreboard players set @s go_turn 1
scoreboard players set @s go_komi 15
scoreboard players set @s go_bot 0
scoreboard players set @s go_time 10
scoreboard players set @s go_btime 12000
scoreboard players set @s go_wtime 12000
''')
        for size in (13,15,19):
            for cap in (4,8):
                for orient in (0,1):
                    key=f'layout{size}_{cap}_{orient}'
                    c=self.setup(size,cap,orient)
                    c+=self.count('@e[tag=go.cell]',1,key+'_one_client_hitbox')+self.count('@e[tag=go.man]',0,key+'_empty_no_stones')+self.count('@e[tag=go.square]',size*size,key+'_server_points')
                    sq=(size-1)*19+size-1;x,z=position(size,cap,orient,sq)
                    c+=self.numeric(cell(sq),'Pos[0]',8+x,key+'_corner_x')+self.numeric(cell(sq),'Pos[2]',8+z,key+'_corner_z')
                    c+=self.call('visual/refresh')+self.count('@e[tag=go.cell]',1,key+'_refresh_one')
                    self.case(key,c)
        # 一颗黑子，其余360空点归黑；最多只需要每行一条带，绝不生成360个占地实体。
        for orient in (0,1):
            c=self.setup(19,8,orient)+[f'scoreboard players set {cell(0)} go_piece 1']+self.call('engine/score')+self.call('visual/estimate')
            c+=self.count('@e[tag=go.territory]',19,f'area_{orient}_nineteen_strips')
            c+=['scoreboard players set #covered gt 0','execute as @e[tag=go.territory] run scoreboard players operation #covered gt += @s go_v_len']+self.score('#covered','gt',360,f'area_{orient}_covers_360')
            c+=self.numeric('@e[tag=go.territory,limit=1]','transformation.translation[1]',.06,f'area_{orient}_above_board')
            c+=self.call('visual/estimate')+self.count('@e[tag=go.territory]',19,f'area_{orient}_idempotent')+self.call('visual/clear_estimate')+self.count('@e[tag=go.territory]',0,f'area_{orient}_close_clears')
            self.case(f'area_{orient}',c)
        c=self.setup(13)+[f'scoreboard players set {cell(40)} go_piece -1',f'scoreboard players set {cell(39)} go_piece 1',f'scoreboard players set {cell(41)} go_piece 1',f'scoreboard players set {cell(21)} go_piece 1']+self.call('visual/refresh')+['scoreboard players set #to go_ctx 59']+self.call('engine/try_move')+self.call('visual/place')+self.call('visual/capture')
        c+=self.count('@e[tag=go.falling]',1,'placed_falling')+self.count('@e[tag=go.retracting]',1,'captured_retracts')+self.call('visual/tick')+self.call('visual/finish_move')+self.count('@e[tag=go.retracting]',0,'captured_reclaimed')+self.count('@e[tag=go.man]',4,'capture_visual_matches_board')+self.count('@e[tag=go.cell]',1,'move_keeps_single_hitbox')
        self.case('capture',c)
        c=self.setup(19)+['scoreboard players set @e[tag=go.board] go_piece -1',f'scoreboard players set {cell(360)} go_piece 0']+self.call('visual/refresh')+self.count('@e[tag=go.man]',360,'large_setup_360_displays')
        self.case('large_prepare',c)
        c=['scoreboard players set #to go_ctx 360']+self.call('engine/try_move')+self.score('#legal','go_ctx',1,'large_capture_committed')+self.call('game/after_move')+self.count('@e[tag=go.retracting]',360,'large_capture_360_animated')+self.call('visual/tick')+self.call('visual/finish_move')+self.count('@e[tag=go.man]',1,'large_capture_one_remains')
        self.case('large_capture',c)
        c=self.setup(13)+[f'scoreboard players set {cell(40)} go_piece -1',f'scoreboard players set {cell(41)} go_piece -1','scoreboard players set #to go_ctx 40']+self.call('engine/toggle_dead')+self.call('engine/score')+self.call('visual/estimate')+self.count('@e[tag=go.dead_mark]',2,'dead_cross_each_stone')+self.call('visual/clear_estimate')+self.count('@e[tag=go.dead_mark]',0,'dead_cross_cleared')
        self.case('dead_marks',c)
        c=self.setup(13)+self.setup(15,8,1,202,False)+self.call('visual/clear')+self.count('@e[tag=go.visual,scores={ct_id=101}]',0,'clear_own')+self.count('@e[tag=go.cell,scores={ct_id=202}]',1,'clear_keeps_other')+self.count('@e[tag=go.square,scores={ct_id=202}]',225,'clear_keeps_other_logic')
        self.case('isolation',c)
        self.file('bootstrap',['forceload add 0 0 47 15','scoreboard objectives add gt dummy','function weiqi:load',f'schedule function guandan_test:case/{self.cases[0]} 2t'])
        self.file('finish','say GUANDAN_FINISHED')
        for i,name in enumerate(self.cases):self.files['case/'+name]+='schedule function guandan_test:'+('case/'+self.cases[i+1] if i+1<len(self.cases) else 'finish')+' 1t\n'


def assets():
    for path in (CARD/'models/item/weiqi').rglob('*.json'):
        model=json.loads(path.read_text(encoding='utf8'))
        if 'parent' in model:
            namespace,name=model['parent'].split(':');assert (RP/f'assets/{namespace}/models/{name}.json').is_file()
        for value in model.get('textures',{}).values():
            namespace,name=value.split(':');assert (RP/f'assets/{namespace}/textures/{name}.png').is_file()
    for size in (13,15,19):
        image=Image.open(CARD/f'textures/item/weiqi/board/classic_{size}_coords.png');assert image.size==(1024,1024)
    for name in ('start','move','capture','pass','illegal','score','undo','end'):
        code=(PACK/f'data/weiqi/function/sound/{name}.mcfunction').read_text(encoding='utf8')
        assert 'go.audience' in code and 'go_ctx' in code and 'go_table' in code
        assert 'gd.' not in code and 'll.' not in code and 'wq.' not in code
    manifest=json.loads((RP/'.source/weiqi/audio_manifest.json').read_text(encoding='utf8'));assert len(manifest)==8
    for sound in manifest:
        p=RP/sound['output'];assert hashlib.sha256(p.read_bytes()).hexdigest()==sound['sha256']
        with wave.open(str(RP/sound['source'])) as wav:assert (wav.getnchannels(),wav.getframerate(),wav.getsampwidth())==(1,44100,2)
        stream=json.loads(subprocess.check_output(['ffprobe','-v','error','-show_streams','-of','json',str(p)]))['streams'][0]
        assert stream['channels']==1 and stream['codec_name']=='vorbis'
    print('Go model reuse, coordinate textures and eight original audio hashes verified.')


if __name__=='__main__':
    assets();suite=Suite();suite.build();raise SystemExit(run(suite,isolated=False,prefix='fimel-weiqi-visual-'))
