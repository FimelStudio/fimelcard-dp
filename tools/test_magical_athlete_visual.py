# -*- coding: utf-8 -*-
"""原版26.2隔离GameTest：两桌路径、六面骰最终朝向、队列动画、暂停及音乐。"""
import json
import math
from boardgame_assets import PACK
from test_catan_engine import Suite as Base,run,TABLE,OTHER


class Suite(Base):
    def call(self,name,table=101):return [f'execute as {TABLE if table==101 else OTHER} at @s run function magical_athlete:{name}']
    def set(self,path,value,table=101):return [f'data modify entity {TABLE if table==101 else OTHER} data.magical_athlete.{path} set value '+json.dumps(value,separators=(',',':'))]
    def setup(self,cap=4,orient=0,table=101,reset=True):
        who=TABLE if table==101 else OTHER
        out=(['kill @e[tag=ma.visual]','kill @e[tag=ce.fixture]'] if reset else [])+[f'execute positioned {8 if table==101 else 40} 64 8 summon minecraft:marker run function catan_engine_test:table {{table:{table}}}']
        out +=[f'scoreboard players set {who} {key} {value}' for key,value in dict(ct_id=table,ct_game=23,ct_state=1,ct_capacity=cap,ct_paused=0,ma_orient=orient,ma_speed=0,ma_music=1,ma_anim=0).items()]
        out +=['scoreboard players set #players ma_ctx 6']+self.call('engine/init',table)
        racers=[dict(owner=i+1,char=i,power=i,pos=i,trip=0,status=0,first=1,done=0) for i in range(6)]
        out +=self.set('racers',racers,table)+self.set('phase',3,table)+self.set('turn',1,table)+self.set('pending',dict(kind='',owner=0,pawn=-1,options=[]),table)
        for p in range(1,7):out+=self.set(f'p{p}.name',{'text':f'Team{p}'},table)
        return out+self.call('game/sync',table)+self.call('visual/refresh',table)
    def count(self,selector,n,name):return ['scoreboard players set #count ce 0',f'execute as {selector} run scoreboard players add #count ce 1']+self.score('#count','ce',n,name)
    def number(self,who,path,value,name):
        scaled=round(value*100000)
        return [f'execute store result score #num ce run data get entity {who} {path} 100000']+self.score('#num','ce',f'{scaled-8}..{scaled+8}',name)
    def racer(self,index=0,table=101):return f'@e[tag=ma.racer,scores={{ct_id={table},ma_vid={index}}},limit=1]'
    def pose(self,cap,orient,pawn,pos,count=1):
        layout=json.loads((PACK/'tools/magical_athlete_track.json').read_text(encoding='utf-8'))['layout']
        size=layout['footprints'][str(cap)];x,z=layout['positions'][pos]
        x=(x-8)*size/16;z=(z-8)*size/16
        if count==6:
            x+=(pawn%3-1)*size*.027;z+=(pawn//3-.5)*size*.036
        return (-z,x) if orient else (x,z)
    def pose_checks(self,cap,orient,pawn,pos,name,table=101,count=1):
        x,z=self.pose(cap,orient,pawn,pos,count)
        who=self.racer(pawn,table)
        return self.number(who,'transformation.translation[0]',x,name+'_x')+self.number(who,'transformation.translation[2]',z,name+'_z')+[
            f'execute store result score #bottom ce run data get entity {who} transformation.translation[1] 1000000',
        ]+self.score('#bottom','ce','11995..12005',name+'_feet_above_board')
    def event(self,kind=1,pawn=0,start=0,end=1,die=0,amount=0,source=-2):
        return dict(kind=kind,pawn=pawn,**{'from':start},to=end,source=source,amount=amount,die=die)
    def timeline(self,name,body,ticks,checks):
        self.case(name,body+[f'schedule function catan_engine_test:timeline/{name}/1 1t'])
        self.waiting.add(name);self.file('done/'+name,[])
        for tick in range(1,ticks+1):
            lines=self.call('visual/tick')+checks.get(tick,[])
            lines += [f'function catan_engine_test:done/{name}'] if tick==ticks else [f'schedule function catan_engine_test:timeline/{name}/{tick+1} 1t']
            self.file(f'timeline/{name}/{tick}',lines)
    def snapshot(self,path='racers'):
        return [f'data modify storage catan_engine_test:snapshot {path} set from entity {TABLE} data.magical_athlete.{path}']
    def unchanged(self,name,path='racers'):
        return [f'execute store success score #different ce run data modify storage catan_engine_test:snapshot {path} set from entity {TABLE} data.magical_athlete.{path}']+self.score('#different','ce',0,name)
    def build(self):
        path=json.loads((PACK/'tools/magical_athlete_track.json').read_text(encoding='utf-8'))['layout']
        for cap in (4,8):
            for orient in (0,1):
                key=f'c{cap}o{orient}';size=path['footprints'][str(cap)]
                x=(2-8)*size/16;z=(14-8)*size/16
                if orient:x,z=-z,x
                body=self.setup(cap,orient)+self.count('@e[tag=ma.visual,scores={ct_id=101}]',8,key+'_bounded_entities')
                body+=self.count('@e[type=minecraft:interaction,tag=ma.hit,scores={ma_dtype=3}]',0,key+'_no_grid_interactions')
                body+=self.number(self.racer(),'transformation.translation[0]',x,key+'_racer_x')+self.number(self.racer(),'transformation.translation[2]',z,key+'_racer_z')
                # Independent quaternion expectation: positions use (x,z)->(-z,x), i.e. Y -90 degrees.
                for axis,value in enumerate((0,-math.sqrt(.5),0,math.sqrt(.5)) if orient else (0,0,0,1)):
                    body+=self.number('@e[tag=ma.board,scores={ct_id=101},limit=1]',f'transformation.left_rotation[{axis}]',value,key+'_board_rotation_'+str(axis))
                body+=self.number('@e[tag=ma.board,scores={ct_id=101},limit=1]','transformation.scale[0]',size,key+'_board_fits_table')
                body+=self.number('@e[tag=ma.board,scores={ct_id=101},limit=1]','Pos[1]',65.035,key+'_board_table_height')
                # Hide other five racer models before scanning every cell, so the single
                # runner stays centered rather than deliberately using crowd separation.
                for other in range(1,6):body+=self.set(f'racers[{other}].status',2)
                for position in range(31):
                    body+=self.set('racers[0].pos',position)+self.call('visual/refresh')
                    body+=self.pose_checks(cap,orient,0,position,key+'_cell'+str(position))
                body+=self.call('visual/refresh')+self.count('@e[tag=ma.visual,scores={ct_id=101}]',8,key+'_refresh_idempotent')
                self.case(key,body)
        for cap in (4,8):
            for orient in (0,1):
                key=f'stacked_c{cap}o{orient}'
                body=self.setup(cap,orient)+[f'data modify entity {TABLE} data.magical_athlete.racers[{i}].pos set value 15' for i in range(6)]+self.call('visual/refresh')
                for pawn in range(6):
                    body+=self.pose_checks(cap,orient,pawn,15,key+'_pawn'+str(pawn),count=6)
                    body+=self.number(self.racer(pawn),'transformation.scale[0]',path['footprints'][str(cap)]*.03,key+'_crowded_scale'+str(pawn))
                body+=self.count('@e[tag=ma.racer,scores={ct_id=101}]',6,key+'_six_distinct_entities')
                body+=self.count('@e[type=minecraft:interaction,tag=ma.hit,scores={ma_dtype=3}]',0,key+'_no_grid_interactions')
                self.case(key,body)
        # 招募使用独立实体生成路径：必须检查真实位置，而非仅检查比赛 pose。
        for cap in (4,8):
            for orient in (0,1):
                label=f'draft_c{cap}o{orient}'
                body=self.setup(cap,orient)+self.set('phase',1)+self.set('pool',list(range(12)))+self.call('game/sync')+self.call('visual/refresh')
                pool='@e[tag=ma.pool,scores={ct_id=101,ma_did=0},limit=1]'
                body+=self.count('@e[tag=ma.pool,scores={ct_id=101}]',12,label+'_twelve_sculptures')
                body+=self.number(pool,'Pos[1]',65.055,label+'_feet_clear_of_board')
                body+=self.number(pool,'transformation.scale[0]',.26,label+'_scale')
                body+=self.check(f'data entity {pool} item.components.\"minecraft:item_model\"',label+'_native_3d_model')
                body+=self.number('@e[tag=ma.hit,scores={ct_id=101,ma_dtype=1,ma_did=0},limit=1]','height',.36,label+'_upright_hitbox')
                self.case(label,body)
        body=self.setup()+self.setup(8,1,202,False)+self.call('visual/clear')
        body+=self.count('@e[tag=ma.visual,scores={ct_id=101}]',0,'clear_own')+self.count('@e[tag=ma.visual,scores={ct_id=202}]',8,'clear_preserves_other')
        self.case('two_tables',body)
        body=self.setup()+self.setup(8,1,202,False)
        body+=self.set('events',[self.event(7,amount=1)])+self.set('events',[self.event(2,pawn=0,start=0,end=12)],202)+self.set('racers[0].pos',12,202)
        body+=self.call('visual/animate')+self.call('visual/animate',202)+self.call('visual/tick')+self.call('visual/tick',202)
        body+=self.count('@e[tag=ma.event_prop,scores={ct_id=101}]',1,'two_tables_own_prop')+self.count('@e[tag=ma.event_prop,scores={ct_id=202}]',1,'two_tables_other_prop')
        body+=self.call('visual/clear')+self.count('@e[tag=ma.visual,scores={ct_id=101}]',0,'active_clear_own_all')
        body+=self.count('@e[tag=ma.event_prop,scores={ct_id=202}]',1,'active_clear_preserves_other_prop')+self.score(OTHER,'ma_vtimer',11,'active_clear_other_timer_unaffected')
        body+=self.call('visual/tick',202)*11+self.score(OTHER,'ma_anim',0,'other_table_queue_completes')+self.pose_checks(8,1,0,12,'other_table_final_position',202)
        self.case('two_table_events',body)
        half=math.sqrt(.5)
        quats={1:[0,0,0,1],2:[half,0,0,half],3:[0,0,half,half],4:[0,0,-half,half],5:[-half,0,0,half],6:[1,0,0,0]}
        for die,q in quats.items():
            body=self.setup()+self.set('dice',die)+self.call('visual/refresh')
            for j,num in enumerate(q):body+=self.number('@e[tag=ma.die,scores={ct_id=101},limit=1]',f'transformation.left_rotation[{j}]',num,f'die{die}_q{j}')
            self.case('die'+str(die),body)
        events=[dict(kind=9,pawn=0,**{'from':0},to=0,source=-2,amount=0,die=6),dict(kind=1,pawn=0,**{'from':0},to=10,source=-2,amount=10,die=0),dict(kind=2,pawn=1,**{'from':1},to=20,source=17,amount=0,die=0)]
        body=self.setup()+self.set('events',events)+self.set('dice',6)+self.set('racers[0].pos',10)+self.set('racers[1].pos',20)+self.call('visual/animate')
        body+=self.score(TABLE,'ma_anim',1,'queue_locks_input')+[f'schedule function catan_engine_test:timeline/1 1t']
        self.case('timeline',body);self.waiting.add('timeline');self.file('done/timeline',[])
        for tick in range(1,37):
            lines=self.call('visual/tick')
            if tick==5:
                lines += [f'scoreboard players set {TABLE} ct_paused 1']+self.call('visual/tick')+self.score(TABLE,'ma_vframe',5,'pause_holds_animation_frame')+[f'scoreboard players set {TABLE} ct_paused 0']
            if tick==12:lines+=self.number('@e[tag=ma.die,scores={ct_id=101},limit=1]','transformation.left_rotation[0]',1,'animated_six_finishes_up')
            if tick==36:
                lines+=self.score(TABLE,'ma_anim',0,'queue_unlocks_input')+self.count('@e[tag=ma.event_prop]',0,'transient_props_cleaned')+self.count('@e[tag=ma.visual,scores={ct_id=101}]',8,'animation_no_entity_leak')
                lines+=self.number(TABLE,'data.magical_athlete.racers[0].pos',10,'animation_does_not_recommit_rules')
                lines+=['function catan_engine_test:done/timeline']
            else:lines +=[f'schedule function catan_engine_test:timeline/{tick+1} 1t']
            self.file('timeline/'+str(tick),lines)
        body=self.setup()+self.call('sound/start')+self.score(TABLE,'ma_music_tick',640,'music_exact_length')+self.call('sound/tick')+self.score(TABLE,'ma_music_tick',639,'music_progress')
        body +=[f'scoreboard players set {TABLE} ct_paused 1']+self.call('sound/pause')+self.score(TABLE,'ma_music_tick',0,'music_pause_stops')
        body +=[f'scoreboard players set {TABLE} ct_paused 0']+self.call('sound/resume')+self.score(TABLE,'ma_music_tick',640,'music_resume_restarts')
        self.case('sound',body)
        # Each production event kind is exercised on real ticks. The queue reads committed
        # snapshots, while the controller already holds the final board and score.
        events=[self.event(9,die=2),self.event(1,start=0,end=10,amount=10),self.event(2,pawn=1,start=1,end=20,source=17),
                self.event(3,pawn=2,start=2,end=2,source=1),self.event(4,pawn=2,start=2,end=2,source=1),
                self.event(5,pawn=2,start=2,end=2,source=25),self.event(6,pawn=3,start=3,end=30,source=3),
                self.event(7,pawn=0,start=10,end=10,amount=1,source=-1),self.event(8,pawn=4,start=4,end=4,source=27)]
        body=self.setup(8,1)+self.set('events',events)+self.set('dice',2)+self.set('racers[0].pos',10)+self.set('racers[1].pos',20)+self.set('racers[2].status',2)+self.set('racers[3].pos',30)+self.set('p1.points',9)
        body+=self.snapshot()+self.snapshot('p1')+self.call('visual/animate')
        checks={
            6:self.number('@e[tag=ma.die,scores={ct_id=101},limit=1]','transformation.translation[1]',.54,'dice_midair_arc'),
            12:self.number('@e[tag=ma.die,scores={ct_id=101},limit=1]','transformation.left_rotation[0]',math.sqrt(.5),'dice_event_final_two'),
            18:self.pose_checks(8,1,0,5,'move_halfway_cell5'),
            24:self.pose_checks(8,1,0,10,'move_final_cell10'),
            29:self.pose_checks(8,1,1,1,'warp_keeps_origin_before_half'),
            30:self.pose_checks(8,1,1,20,'warp_changes_at_half'),
            37:self.check('entity @e[tag=ma.event_prop,nbt={item:{components:{"minecraft:item_model":"card:magical_athlete/prop/trip"}}}]','trip_uses_trip_prop'),
            49:self.check('entity @e[tag=ma.event_prop,nbt={item:{components:{"minecraft:item_model":"card:magical_athlete/prop/flag"}}}]','recover_uses_flag_prop'),
            61:self.check('entity @e[tag=ma.event_prop,nbt={item:{components:{"minecraft:item_model":"card:magical_athlete/prop/trip"}}}]','elimination_has_prop'),
            73:self.check('entity @e[tag=ma.event_prop,nbt={item:{components:{"minecraft:item_model":"card:magical_athlete/prop/medal_gold"}}}]','finish_has_medal_prop'),
            85:self.check('entity @e[tag=ma.event_prop,nbt={item:{components:{"minecraft:item_model":"card:magical_athlete/prop/coin"}}}]','points_has_coin_prop'),
            97:self.check('entity @e[tag=ma.event_prop,nbt={item:{components:{"minecraft:item_model":"card:magical_athlete/prop/rocket"}}}]','skill_has_rocket_prop'),
            108:self.score(TABLE,'ma_anim',0,'all_events_unlock')+self.count('@e[tag=ma.event_prop]',0,'all_events_remove_props')+self.count('@e[tag=ma.visual,scores={ct_id=101}]',8,'all_events_entity_bound')+
                self.pose_checks(8,1,0,10,'all_events_final_move')+self.pose_checks(8,1,1,20,'all_events_final_warp')+
                self.number(self.racer(2),'transformation.scale[0]',.001,'eliminated_racer_hidden')+
                self.unchanged('all_events_no_rule_replay')+self.unchanged('all_events_no_points_replay','p1')}
        self.timeline('all_events',body,108,checks)
        body=self.setup()+[f'scoreboard players set {TABLE} ma_speed 1']+self.set('events',[self.event(9,die=4),self.event(1,start=0,end=12,amount=12),self.event(2,pawn=1,start=1,end=25)])+self.set('dice',4)+self.set('racers[0].pos',12)+self.set('racers[1].pos',25)+self.call('visual/animate')
        checks={6:self.number('@e[tag=ma.die,scores={ct_id=101},limit=1]','transformation.left_rotation[2]',-math.sqrt(.5),'fast_dice_final_four'),
                9:self.pose_checks(4,0,0,6,'fast_move_halfway'),
                12:self.pose_checks(4,0,0,12,'fast_move_final'),
                14:self.pose_checks(4,0,1,1,'fast_warp_origin'),
                15:self.pose_checks(4,0,1,25,'fast_warp_halfway'),
                18:self.score(TABLE,'ma_anim',0,'fast_queue_unlock')+self.pose_checks(4,0,1,25,'fast_queue_final')}
        self.timeline('fast_events',body,18,checks)
        body=self.setup()+self.set('events',[self.event(1,start=0,end=14,amount=14)])+self.set('racers[0].pos',14)+self.set('p1.points',7)+self.call('visual/animate')+self.call('visual/tick')*4
        body+=self.snapshot('visual_queue')+self.snapshot('visual_event')
        body+=[f'scoreboard players set {TABLE} ct_paused 1']+self.call('visual/tick')*20
        body+=self.score(TABLE,'ma_vframe',4,'pause_twenty_ticks_holds_frame')+self.score(TABLE,'ma_vtimer',8,'pause_holds_timer')+self.pose_checks(4,0,0,4,'pause_holds_transform')
        body+=self.unchanged('pause_preserves_event_queue','visual_queue')+self.unchanged('pause_preserves_active_event','visual_event')
        body+=self.call('visual/clear')+self.count('@e[tag=ma.visual,scores={ct_id=101}]',0,'paused_cleanup_allowed')
        self.case('pause_freeze',body)
        body=self.setup()+self.set('events',[self.event(1,start=0,end=14,amount=14),self.event(7,amount=2)])+self.set('racers[0].pos',14)+self.set('dice',5)+self.set('p1.points',11)+self.snapshot()+self.snapshot('p1')+self.call('visual/animate')+self.call('visual/tick')*4
        body+=self.call('system/reload')
        body+=self.score(TABLE,'ma_anim',0,'reload_discards_animation_lock')+self.count('@e[tag=ma.event_prop]',0,'reload_removes_old_props')
        body+=self.number(TABLE,'data.magical_athlete.racers[0].pos',14,'reload_final_position_committed')
        body+=['scoreboard players set #queued ce 0',f'execute if data entity {TABLE} data.magical_athlete.visual_queue[0] run scoreboard players set #queued ce 1']+self.score('#queued','ce',0,'reload_discards_old_event_queue')
        body+=self.pose_checks(4,0,0,14,'reload_draws_committed_position')+self.number('@e[tag=ma.die,scores={ct_id=101},limit=1]','transformation.left_rotation[0]',-math.sqrt(.5),'reload_restores_saved_die')
        body+=self.call('game/tick')*8+self.unchanged('reload_does_not_replay_movement')+self.unchanged('reload_does_not_replay_points','p1')+self.count('@e[tag=ma.visual,scores={ct_id=101}]',8,'reload_no_entity_leak')
        self.case('reload_committed',body)
        self.finish();return self


def prepare(target):
    (target/'data/minecraft/tags/function/load.json').write_text(json.dumps({'values':['cardtable:load','magical_athlete:load']}),encoding='utf-8')


if __name__=='__main__':raise SystemExit(run(Suite().build(),full=True,prepare_target=prepare,prefix='fimel-magical-athlete-visual-',setup_ticks=450))
