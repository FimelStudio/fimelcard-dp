"""Catan geometry, redistributable source assets and native 26.2 visual regressions."""
import base64
import hashlib
import json
import math
from pathlib import Path
import re
import subprocess
import sys
from zipfile import ZipFile

from PIL import Image
from boardgame_assets import PACK, RP, CARD
from build_catan_visual import layouts, SIZES, FACE_ROTATIONS, multiply, OBJECTIVES
from catan_topology import HEXES, VERTICES, EDGES, PORTS, FIXED_TERRAIN, FIXED_NUMBERS, PORT_RESOURCES, vertex_position, hex_position
from test_catan_engine import Suite as Base, run, TABLE, OTHER


def close(a,b,epsilon=2e-7):
    assert abs(a-b)<epsilon,(a,b)


def assets():
    source=RP/'.source/catan'
    manifest=json.loads((source/'visual_manifest.json').read_text(encoding='utf-8'))
    archive=source/manifest['archive']
    assert manifest['license']=='CC0-1.0'
    assert hashlib.sha256(archive.read_bytes()).hexdigest()==manifest['archive_sha256']
    assert 'Creative Commons Zero' in (source/manifest['license_file']).read_text(encoding='utf-8')
    with ZipFile(archive) as zipped:
        for original in manifest['originals']:
            data=(source/'vendor/originals'/original['file']).read_bytes()
            assert data==zipped.read(original['file'])
            assert hashlib.sha256(data).hexdigest()==original['sha256']
    models=list((CARD/'models/item/catan').rglob('*.json'))
    assert len(models)>=45
    for path in models:
        model=json.loads(path.read_text(encoding='utf-8'))
        name=path.relative_to(CARD/'models/item/catan')
        item=json.loads((CARD/'items/catan'/name).read_text(encoding='utf-8'))
        assert item['model']['model']=='card:item/catan/'+name.with_suffix('').as_posix()
        source_model=json.loads((source/'models'/name.with_suffix('.bbmodel')).read_text(encoding='utf-8'))
        assert len(source_model['elements'])==len(model.get('elements',[]))
        texture_indices={}
        for key,texture in model.get('textures',{}).items():
            if texture.startswith('#'):continue
            namespace,resource=texture.split(':')
            texture_path=RP/f'assets/{namespace}/textures/{resource}.png'
            assert texture_path.is_file(),(path,key,texture)
            with Image.open(texture_path) as image:
                assert image.width>0 and image.height>0
            if key!='particle':
                index=len(texture_indices);texture_indices[key]=index
                editable_texture=source_model['textures'][index]
                assert base64.b64decode(editable_texture['source'].split(',',1)[1])==texture_path.read_bytes(),(path,key,'embedded texture diverged')
                assert editable_texture['uv_width']==editable_texture['uv_height']==16
        assert len(texture_indices)==len(source_model['textures'])
        for original,editable in zip(model.get('elements',[]),source_model['elements']):
            assert len(original['from'])==len(original['to'])==3
            assert all(-16<=n<=32 for n in original['from']+original['to'])
            if rotation:=original.get('rotation'):
                assert isinstance(editable['rotation'],list) and len(editable['rotation'])==3
                assert editable['origin']==rotation['origin']
                close(editable['rotation']['xyz'.index(rotation['axis'])],rotation['angle'])
            for side,face in original.get('faces',{}).items():
                assert face['texture'][1:] in model['textures']
                assert all(0<=n<=16 for n in face.get('uv',[0,0,16,16]))
                assert editable['faces'][side]['texture']==texture_indices[face['texture'][1:]]
    for name in ('forest','hills','pasture','fields','mountains','desert'):
        image=Image.open(CARD/f'textures/item/catan/tile/{name}.png').convert('RGBA')
        assert image.size==(128,128)
        assert image.getpixel((0,0))[3]==0 and image.getpixel((64,64))[3]==255
    for color in ('red','blue','white','orange'):
        settlement=json.loads((CARD/f'models/item/catan/settlement/{color}.json').read_text(encoding='utf-8'))
        city=json.loads((CARD/f'models/item/catan/city/{color}.json').read_text(encoding='utf-8'))
        assert len(settlement['elements'])>1 and len(city['elements'])>len(settlement['elements'])
        assert max(e['to'][1] for e in city['elements'])>max(e['to'][1] for e in settlement['elements'])
    for key,data in layouts().items():
        cap=int(key[1]);orientation=int(key[-1]);radius,outer=SIZES[cap]
        assert len(data['hexes'])==19 and len(data['vertices'])==54 and len(data['edges'])==72 and len(data['ports'])==9
        assert outer>=8*radius/math.sqrt(3)
        assert 2*outer<={4:3,8:4}[cap]
        for h in HEXES:
            p=data['hexes'][h['id']];x,z=hex_position(h['id'],radius,orientation)
            close(p['x'],x);close(p['z'],z);close(p['scale'],2*radius)
        for edge,(a,b) in zip(data['edges'],EDGES):
            x,z=vertex_position(a,radius,orientation);X,Z=vertex_position(b,radius,orientation)
            close(edge['x'],(x+X)/2);close(edge['z'],(z+Z)/2)
            angle=2*math.atan2(edge['qy'],edge['qw'])
            close(math.cos(angle),(X-x)/radius);close(-math.sin(angle),(Z-z)/radius)
        for p,expected in zip(data['ports'],PORTS):
            a,b=expected['vertices'];x,z=vertex_position(a,radius,orientation);X,Z=vertex_position(b,radius,orientation)
            close(p['dock']['x'],(x+X)/2);close(p['dock']['z'],(z+Z)/2)
            close(math.hypot(p['token']['x']-p['dock']['x'],p['token']['z']-p['dock']['z']),radius/4)
        for die in (1,2):
            for value in range(1,7):
                frames=data[f'die{die}'][f'r{value}']
                assert len(frames)==21
                assert max(p['y'] for p in frames)>frames[0]['y']+.2
                for p in frames:close(sum(p[k]**2 for k in ('qx','qy','qz','qw')),1)
                # The requested numbered face normal is upwards after its final quaternion.
                normal={1:(0,1,0),6:(0,-1,0),2:(0,0,-1),5:(0,0,1),3:(1,0,0),4:(-1,0,0)}[value]
                p=frames[0];q=tuple(p[k] for k in ('qx','qy','qz','qw'))
                rotated=multiply(multiply(q,normal+(0,)),(-q[0],-q[1],-q[2],q[3]))
                close(rotated[1],1)
    for path in (PACK/'data/catan/function/visual').rglob('*.mcfunction'):
        body=path.read_text(encoding='utf-8')
        assert not any(line.startswith('$') and '$(' not in line for line in body.splitlines()),path
        assert max(map(len,body.splitlines()),default=0)<32767,path
        assert not re.search(r'data\.catan\.p\$\(owner\)\.(?!color|seat)',body),path
        assert not re.search(r'data\.catan\.(?:resources|dev_|development|deck|rng)',body),path
        assert 'summon minecraft:interaction' not in body,path
    print(f'Catan: {len(models)} native models, CC0 source hashes, editable sources, all four table layouts and 48 final dice orientations passed.')


class Suite(Base):
    def call(self,name,table=101):
        return [f'execute as {TABLE if table==101 else OTHER} at @s run function catan:visual/{name}']

    def setup(self,cap=4,orient=0,table=101,reset=True):
        who=TABLE if table==101 else OTHER
        commands=['kill @e[tag=ca.visual]','kill @e[tag=ce.fixture]'] if reset else []
        commands += [f'execute positioned {8 if table==101 else 40} 64 8 summon minecraft:marker run function catan_engine_test:table {{table:{table}}}',
                     f'scoreboard players set {who} ct_id {table}',f'scoreboard players set {who} ct_capacity {cap}',
                     f'scoreboard players set {who} ca_orient {orient}','scoreboard players set #players ca_ctx 4',
                     'scoreboard players set #layout ca_ctx 0',f'execute as {who} at @s run function catan:engine/init']
        for p in range(1,5):
            commands+=self.set(f'p{p}.color',p,table)+self.set(f'p{p}.seat',p if cap==4 else 2*p-1,table)
        return commands+self.call('refresh',table)

    def count(self,selector,expected,name):
        return ['scoreboard players set #count ce 0',f'execute as {selector} run scoreboard players add #count ce 1']+self.score('#count','ce',expected,name)

    def numeric(self,entity,path,value,name):
        expected=round(value*100000)
        return [f'execute store result score #numeric ce run data get entity {entity} {path} 100000']+self.score('#numeric','ce',f'{expected-5}..{expected+5}',name)

    def display(self,kind,id=0,table=101):
        return f'@e[tag=ca.visual,scores={{ct_id={table},ca_vkind={kind},ca_vid={id}}},limit=1]'

    def event(self,value,table=101):
        return self.set('last',value,table)+self.call('animate',table)

    def timeline(self,name,setup,ticks,checks):
        """Advance one production visual tick per real scheduled server tick."""
        self.case(name,setup+[
            'execute store result score #timeline_start ce run time query gametime',
            f'schedule function catan_engine_test:timeline/{name}/1 1t'])
        # Base.finish must chain the next case after our final frame, rather
        # than after the setup function as it does for synchronous cases.
        self.waiting.add(name)
        self.file('done/'+name,[])
        for frame in range(1,ticks+1):
            commands=self.call('tick')+checks.get(frame,[])
            if frame==ticks:
                commands += ['execute store result score #timeline_end ce run time query gametime',
                    'scoreboard players operation #timeline_end ce -= #timeline_start ce']
                commands += self.score('#timeline_end','ce',ticks,name+'_real_elapsed_ticks')
                commands += [f'function catan_engine_test:done/{name}']
            else:
                commands += [f'schedule function catan_engine_test:timeline/{name}/{frame+1} 1t']
            self.file(f'timeline/{name}/{frame}',commands)

    def build(self):
        for cap in (4,8):
            for orient in (0,1):
                key=f'c{cap}o{orient}';layout=layouts()[key]
                c=self.setup(cap,orient)
                for kind,count in ((1,1),(2,19),(3,18),(4,9),(5,0),(6,0),(7,1),(8,2),(9,0),(11,9)):
                    c+=self.count(f'@e[tag=ca.visual,scores={{ct_id=101,ca_vkind={kind}}}]',count,key+'_kind'+str(kind))
                c+=self.count('@e[tag=ca.visual,scores={ct_id=101}]',59,key+'_total')
                c+=self.count('@e[type=minecraft:interaction]',0,key+'_no_per_cell_interactions')
                for id in (0,9,18):
                    who=self.display(2,id);point=layout['hexes'][id]
                    for axis,index in (('x',0),('z',2)):
                        c+=self.numeric(who,f'transformation.translation[{index}]',point[axis],key+f'_hex{id}_{axis}')
                for id in (0,4,8):
                    who=self.display(4,id);point=layout['ports'][id]['token']
                    c+=self.numeric(who,'transformation.translation[0]',point['x'],key+f'_port{id}_x')
                    c+=self.numeric(who,'transformation.translation[2]',point['z'],key+f'_port{id}_z')
                c+=self.check(f'data entity {self.display(1)} {{item_display:"none",view_range:0.5f}}',key+'_native_none_view_range')
                c+=self.check(f'data entity {self.display(1)} transformation{{right_rotation:[0.0f,1.0f,0.0f,0.0f]}}',key+'_renderer_y180_compensated')
                c+=self.call('refresh')+self.count('@e[tag=ca.visual,scores={ct_id=101}]',59,key+'_refresh_no_duplicates')
                self.case(key,c)
        c=self.setup()+self.set('vertex_owner[10]',1)+self.set('vertex_level[10]',1)+self.set('road_owner[17]',2)
        c+=self.set('p1.color',3)+self.set('p2.color',4)+self.call('update')
        c+=self.count('@e[tag=ca.visual,scores={ct_id=101}]',61,'built_only_occupied_objects')
        c+=self.check(f'data entity {self.display(6,10)} item.components{{"minecraft:item_model":"card:catan/settlement/white"}}','owner_public_color_settlement')
        c+=self.check(f'data entity {self.display(5,17)} item.components{{"minecraft:item_model":"card:catan/road/orange"}}','owner_public_color_road')
        point=layouts()['c4o0']['edges'][17]
        c+=self.numeric(self.display(5,17),'transformation.translation[0]',point['x'],'built_road_midpoint_x')
        c+=self.numeric(self.display(5,17),'transformation.translation[2]',point['z'],'built_road_midpoint_z')
        c+=self.event({'kind':'settlement','owner':1,'target':10,'code':21})
        c+=self.numeric(self.display(6,10),'transformation.scale[0]',.17/9,'building_starts_small')
        c+=self.call('tick')*4+self.numeric(self.display(6,10),'transformation.scale[0]',.17*5/9,'building_midpoint_scale')
        c+=self.call('tick')*4+self.numeric(self.display(6,10),'transformation.scale[0]',.17,'building_finishes_full_size')
        c+=self.score(TABLE,'ca_vtimer',0,'building_releases_visual_lock')
        c+=self.set('vertex_level[10]',2)+self.call('update')
        c+=self.check(f'data entity {self.display(6,10)} item.components{{"minecraft:item_model":"card:catan/city/white"}}','city_replaces_village')
        self.case('building',c)
        c=self.setup()+self.set('preview',{'type':1,'target':9,'building':1})+self.call('select')
        c+=self.count('@e[tag=ca.visual,scores={ca_vkind=9}]',1,'hex_selection_only_one')
        c+=self.check(f'data entity {self.display(9,9)} item.components{{"minecraft:item_model":"card:catan/highlight/hex"}}','hex_selection_model')
        c+=self.set('preview',{'type':2,'target':53,'building':2})+self.call('select')
        c+=self.count('@e[tag=ca.visual,scores={ca_vkind=9}]',1,'vertex_selection_replaces_hex')
        c+=self.check(f'data entity {self.display(9,53)} item.components{{"minecraft:item_model":"card:catan/highlight/vertex"}}','city_selection_vertex_ring')
        c+=self.set('preview',{'type':3,'target':71})+self.call('select')
        c+=self.check(f'data entity {self.display(9,71)} item.components{{"minecraft:item_model":"card:catan/highlight/edge"}}','road_selection_bar')
        c+=self.set('preview',{'type':3,'target':72})+self.call('select')
        c+=self.count('@e[tag=ca.visual,scores={ca_vkind=9}]',0,'invalid_selection_clears_old_target')
        self.case('selection',c)
        c=self.setup()+self.set('robber',18)+self.call('update')
        point=layouts()['c4o0']['hexes'][0]
        c+=self.numeric(self.display(7),'transformation.translation[0]',point['x'],'robber_update_preserves_old_x')
        c+=self.event({'kind':'robber','owner':1,'target':18})+self.call('tick')*4
        end=layouts()['c4o0']['hexes'][18]
        c+=self.numeric(self.display(7),'transformation.translation[0]',(point['x']+end['x'])/2,'robber_midpoint_x')
        c+=self.numeric(self.display(7),'transformation.translation[1]',.165/2+.024+.25,'robber_lift_arc')
        c+=self.call('tick')*4
        c+=self.numeric(self.display(7),'transformation.translation[0]',end['x'],'robber_arrives_x')
        c+=self.numeric(self.display(7),'transformation.translation[2]',end['z'],'robber_arrives_z')
        c+=self.numeric(self.display(7),'transformation.translation[1]',.165/2+.024,'robber_settles_above_tile')
        self.case('robber',c)
        c=self.setup(8,1)+self.set('dice',[2,4])+self.call('update')
        c+=self.event({'kind':'dice','owner':2,'die1':6,'die2':3})
        c+=self.set('dice',[5,5])+self.call('tick')*10
        c+=self.score(TABLE,'ca_vtimer',10,'dice_twenty_tick_lock_midpoint')
        c+=self.call('tick')*10
        c+=self.score(TABLE,'ca_vtimer',0,'dice_twenty_tick_lock_released')
        for id,value in ((0,6),(1,3)):
            point=layouts()['c8o1'][f'die{id+1}'][f'r{value}'][0]
            for k,index in (('qx',0),('qy',1),('qz',2),('qw',3)):
                c+=self.numeric(self.display(8,id),f'transformation.left_rotation[{index}]',point[k],f'dice{id}_snapshot_final_{k}')
        self.case('dice',c)
        c=self.setup()+self.set('p1.resources',[8,1,4,2,3])+self.set('p1.dev',[2,1,0,0,1])
        c+=self.event({'kind':'production','target':3,'owner':1,'resource':0,'amount':1})
        c+=self.event({'kind':'production','target':10,'owner':2,'resource':2,'amount':2})
        c+=self.event({'kind':'production','target':18,'owner':3,'resource':4,'amount':1})
        c+=self.set('last',{'kind':'road','target':71,'owner':4})
        c+=self.count('@e[tag=ca.visual,scores={ca_vkind=10}]',1,'production_first_event_starts')
        c+=self.call('tick')*2+self.count('@e[tag=ca.visual,scores={ca_vkind=10}]',2,'production_second_event_not_lost')
        c+=self.call('tick')*2+self.count('@e[tag=ca.visual,scores={ca_vkind=10}]',3,'production_third_event_not_lost')
        c+=self.check(f'data entity {TABLE} data.catan.visual_active{{target:18,owner:3,resource:4}}','queued_snapshot_survives_last_replacement')
        for resource in ('wood','wool','ore'):
            c+=self.count('@e[tag=ca.visual,scores={ca_vkind=10},nbt={item:{components:{"minecraft:item_model":"card:catan/resource/'+resource+'"}}}]',1,'production_public_icon_'+resource)
        c+=self.call('tick')*8+self.count('@e[tag=ca.visual,scores={ca_vkind=10}]',0,'production_flying_icons_reclaimed')
        c+=self.check(f'data entity {TABLE} data.catan{{visual_events:[],p1:{{resources:[8,1,4,2,3],dev:[2,1,0,0,1]}}}}','visual_queue_drained_private_state_unchanged')
        self.case('production',c)
        c=self.setup()+self.event({'kind':'trade','from_seat':1,'to_seat':3})
        c+=self.count('@e[tag=ca.visual,scores={ca_vkind=10},nbt={item:{components:{"minecraft:item_model":"card:catan/bag"}}}]',2,'trade_only_neutral_bags')
        c+=self.call('tick')*4
        for id in (0,):
            c+=self.numeric(self.display(10,id),'transformation.translation[2]',0,'trade_midpoint_between_seats')
        c+=self.call('tick')*4+self.count('@e[tag=ca.visual,scores={ca_vkind=10}]',0,'trade_bags_reclaimed')
        c+=self.event({'kind':'development','owner':4,'seat':4})
        c+=self.count('@e[tag=ca.visual,scores={ca_vkind=10},nbt={item:{components:{"minecraft:item_model":"card:catan/development_back"}}}]',1,'development_uniform_private_back')
        c+=self.call('tick')*8+self.count('@e[tag=ca.visual,scores={ca_vkind=10}]',0,'development_back_reclaimed')
        self.case('trade_development',c)
        c=self.setup()+self.setup(8,1,202,False)
        c+=self.event({'kind':'production','target':3,'owner':1,'resource':0},101)
        c+=self.event({'kind':'production','target':10,'owner':2,'resource':2},101)
        c+=self.set('robber',18)+self.set('vertex_owner[53]',4)+self.set('vertex_level[53]',2)
        c+=self.call('refresh')
        c+=self.count('@e[tag=ca.visual,scores={ct_id=101,ca_vkind=10}]',0,'refresh_removes_old_animation')
        c+=self.check(f'score {TABLE} ca_vtimer matches 0','refresh_clears_queue_lock')
        c+=self.check(f'data entity {TABLE} data.catan{{vertex_owner:[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4]}}','refresh_preserves_committed_building_array')
        c+=self.check(f'data entity {self.display(6,53)} item.components{{"minecraft:item_model":"card:catan/city/orange"}}','refresh_rebuilds_committed_city')
        c+=self.numeric(self.display(7),'transformation.translation[2]',layouts()['c4o0']['hexes'][18]['z'],'refresh_robber_final_committed_hex')
        c+=self.count('@e[tag=ca.visual,scores={ct_id=202}]',59,'other_table_unchanged_during_refresh')
        c+=self.call('clear')+self.count('@e[tag=ca.visual,scores={ct_id=101}]',0,'clear_own_visuals_only')
        c+=self.count('@e[tag=ca.visual,scores={ct_id=202}]',59,'clear_preserves_other_table')
        self.case('refresh_isolation',c)

        c=self.setup(8,1)+self.setup(4,0,202,False)
        c+=self.event({'kind':'dice','owner':2,'die1':6,'die2':3})+self.set('dice',[5,5])
        checks={10:self.score(TABLE,'ca_vtimer',10,'real_dice_midpoint_timer'),
                20:self.score(TABLE,'ca_vtimer',0,'real_dice_final_timer')+
                    self.count('@e[tag=ca.visual,scores={ct_id=202}]',59,'real_dice_other_table_unchanged')}
        for id,value in ((0,6),(1,3)):
            for frame,remaining in ((10,10),(20,0)):
                point=layouts()['c8o1'][f'die{id+1}'][f'r{value}'][remaining]
                for k,index in (('qx',0),('qy',1),('qz',2),('qw',3)):
                    checks[frame]+=self.numeric(self.display(8,id),f'transformation.left_rotation[{index}]',point[k],f'real_dice{id}_frame{frame}_{k}')
        self.timeline('real_dice',c,20,checks)

        c=self.setup()+self.set('road_owner[17]',1)+self.set('vertex_owner[10]',2)+self.set('vertex_level[10]',2)+self.call('update')
        c+=self.event({'kind':'road','owner':1,'target':17})+self.event({'kind':'city','owner':2,'target':10})
        self.timeline('real_build_queue',c,16,{
            4:self.numeric(self.display(5,17),'transformation.scale[0]',.25*.94*5/9,'real_road_half_scale'),
            8:self.numeric(self.display(5,17),'transformation.scale[0]',.25*.94,'real_road_finishes')+
                self.numeric(self.display(6,10),'transformation.scale[0]',.17/9,'real_queued_city_starts'),
            12:self.numeric(self.display(6,10),'transformation.scale[0]',.17*5/9,'real_city_half_scale'),
            16:self.numeric(self.display(6,10),'transformation.scale[0]',.17,'real_city_finishes')+
                self.score(TABLE,'ca_vtimer',0,'real_city_queue_lock_released')})

        c=self.setup(8,1)+self.set('robber',18)+self.call('update')+self.event({'kind':'robber','owner':1,'target':18})
        start,end=layouts()['c8o1']['hexes'][0],layouts()['c8o1']['hexes'][18]
        self.timeline('real_robber',c,8,{
            4:self.numeric(self.display(7),'transformation.translation[0]',(start['x']+end['x'])/2,'real_robber_midpoint_x')+
                self.numeric(self.display(7),'transformation.translation[1]',.35*.66/2+.024+.25,'real_robber_midpoint_arc'),
            8:self.numeric(self.display(7),'transformation.translation[0]',end['x'],'real_robber_final_x')+
                self.numeric(self.display(7),'transformation.translation[2]',end['z'],'real_robber_final_z')})

        c=self.setup()+self.set('p1.resources',[8,1,4,2,3])+self.set('p1.dev',[2,1,0,0,1])
        # Bank trades intentionally omit to_seat: the neutral bank is seat zero.
        c+=self.event({'kind':'trade','code':50,'from_seat':1,'owner':1})
        c+=self.event({'kind':'production','target':10,'owner':2,'resource':2,'amount':2})
        c+=self.event({'kind':'development','owner':4,'seat':4})+self.event({'kind':'win','owner':2})
        self.timeline('real_mixed_queue',c,18,{
            2:self.count('@e[tag=ca.visual,scores={ca_vkind=10}]',3,'real_bank_and_production_overlap'),
            4:self.numeric(self.display(10),'transformation.translation[2]',-.595,'real_bank_trade_centre_midpoint')+
                self.count('@e[tag=ca.visual,scores={ca_vkind=10}]',4,'real_development_not_lost'),
            6:self.score(TABLE,'ca_vkind',9,'real_win_queued_after_other_events'),
            12:self.count('@e[tag=ca.visual,scores={ca_vkind=10}]',0,'real_flying_icons_reclaimed'),
            18:self.score(TABLE,'ca_vtimer',0,'real_win_releases_timer')+
                self.check(f'data entity {TABLE} data.catan{{visual_events:[],p1:{{resources:[8,1,4,2,3],dev:[2,1,0,0,1]}}}}','real_animations_do_not_mutate_hand')})

        c=self.setup()+self.setup(8,1,202,False)+self.set('robber',18)
        c+=self.event({'kind':'robber','owner':1,'target':18})+self.event({'kind':'production','target':10,'owner':2,'resource':2})
        self.timeline('real_reload_refresh',c,8,{
            4:self.call('load')+self.call('refresh')+
                self.count('@e[tag=ca.visual,scores={ct_id=101,ca_vkind=10}]',0,'real_reload_clears_transient_entities')+
                self.score(TABLE,'ca_vtimer',0,'real_reload_clears_event_lock')+
                self.numeric(self.display(7),'transformation.translation[2]',layouts()['c4o0']['hexes'][18]['z'],'real_reload_snaps_committed_robber'),
            8:self.count('@e[tag=ca.visual,scores={ct_id=101}]',59,'real_reload_does_not_replay_production')+
                self.count('@e[tag=ca.visual,scores={ct_id=202}]',59,'real_reload_other_table_unchanged')})
        self.finish()
        self.files['bootstrap']='\n'.join(['forceload add 0 0 63 31','scoreboard objectives add ce dummy','scoreboard objectives add ce_id dummy',
            *[f'scoreboard objectives add {name} dummy' for name in ('ct_id','ct_capacity','ca_orient','ca_table',*OBJECTIVES)],
            'function catan:visual/load',f'schedule function catan_engine_test:case/{next(iter(self.cases))} 5t'])+'\n'
        self.files['finish']='kill @e[tag=ca.visual]\nkill @e[tag=ce.fixture]\nsay CATAN_FINISHED\n'


def prepare(target):
    # Full native parsing, but these fixtures intentionally execute only engine/visual hooks.
    path=target/'data/minecraft/tags/function/load.json'
    path.write_text(json.dumps({'values':['catan:engine/install']}),encoding='utf-8')


if __name__=='__main__':
    assets()
    suite=Suite();suite.build()
    raise SystemExit(run(suite,full=True,prepare_target=prepare,prefix='fimel-catan-visual-'))
