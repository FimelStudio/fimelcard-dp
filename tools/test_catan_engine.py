"""原版26.2卡坦岛隔离GameTest；直接执行生产mcfunction，默认命令上限。"""
from pathlib import Path
import argparse
import json
import re
import shutil
import subprocess
import tempfile
import time
from catan_topology import *

PACK=Path(__file__).resolve().parents[1]
TABLE='@e[type=minecraft:marker,tag=ce.table,scores={ce_id=101},limit=1]'
OTHER='@e[type=minecraft:marker,tag=ce.table,scores={ce_id=202},limit=1]'
C=TABLE

class Suite:
    def __init__(self):self.files,self.cases,self.expected,self.waiting={},{},[],set()
    def file(self,name,body):self.files[name]=('\n'.join(body) if isinstance(body,list) else body).strip()+'\n'
    def check(self,condition,name):
        assert name not in self.expected,name
        self.expected.append(name)
        return [f'execute if {condition} run say CATAN_PASS {name}',f'execute unless {condition} run say CATAN_FAIL {name}']
    def score(self,holder,obj,value,name):return self.check(f'score {holder} {obj} matches {value}',name)
    def data(self,path,value,name,table=101):
        who=TABLE if table==101 else OTHER
        return [f'execute store result score #value ce run data get entity {who} data.catan.{path}']+self.score('#value','ce',value,name)
    def call(self,name,table=101):return [f'execute as {TABLE if table==101 else OTHER} at @s run function catan:engine/{name}']
    def setup(self,n=4,layout=0,table=101,reset=True):
        return (['kill @e[tag=ce.fixture]'] if reset else [])+[f'execute positioned {8 if table==101 else 40} 64 8 summon minecraft:marker run function catan_engine_test:table {{table:{table}}}',f'scoreboard players set #players ca_ctx {n}',f'scoreboard players set #layout ca_ctx {layout}']+self.call('init',table)
    def set(self,path,value,table=101):return [f'data modify entity {TABLE if table==101 else OTHER} data.catan.{path} set value '+json.dumps(value,separators=(',',':'),ensure_ascii=False)]
    def action(self,actor,code,target=-1,a=-1,b=-1,offer=None,want=None,epoch=None,table=101):
        request={'actor':actor,'code':code,'target':target,'a':a,'b':b,'offer':offer or [0]*5,'want':want or [0]*5,'epoch':epoch or -1}
        out=['data modify storage catan:action input set value '+json.dumps(request,separators=(',',':'))]
        if epoch is None:out += [f'data modify storage catan:action input.epoch set from entity {TABLE if table==101 else OTHER} data.catan.epoch']
        return out+self.call('action',table)
    def resources(self,holdings):
        out=[]
        for p,r in holdings.items():out+=self.set(f'p{p}.resources',r)
        out+=self.set('bank',[19-sum(r[k] for r in holdings.values()) for k in range(5)])
        return out
    def conservation(self,name,table=101):
        who=TABLE if table==101 else OTHER
        out=[]
        for r in range(5):
            out += [f'execute store result score #total ce run data get entity {who} data.catan.bank[{r}]']
            for p in range(1,5):out += [f'execute store result score #part ce run data get entity {who} data.catan.p{p}.resources[{r}]','scoreboard players operation #total ce += #part ce']
            out+=self.score('#total','ce',19,name+'_resource_'+str(r))
        return out
    def snapshot(self,table=101):return [f'data modify storage catan_engine_test:snapshot saved set from entity {TABLE if table==101 else OTHER} data.catan']
    def unchanged(self,name,table=101):return [f'execute store success score #different ce run data modify storage catan_engine_test:snapshot saved set from entity {TABLE if table==101 else OTHER} data.catan']+self.score('#different','ce',0,name)
    def case(self,name,body,checks=None,wait=False,tables=(101,)):
        assert name not in self.cases,name
        self.cases[name]=True
        if not wait:self.file('case/'+name,body+(checks or []));return
        self.waiting.add(name)
        self.file('case/'+name,body+['scoreboard players set #jobticks ce 0',f'schedule function catan_engine_test:wait/{name} 1t'])
        tick=['scoreboard players add #jobticks ce 1']
        for table in tables:tick+=self.call('tick',table)
        tick+=['scoreboard players set #waiting ce 0']
        for table in tables:tick += [f'execute if data entity {TABLE if table==101 else OTHER} data.catan{{phase:10}} run scoreboard players set #waiting ce 1']
        tick += [f'execute if score #waiting ce matches 1 if score #jobticks ce matches ..999 run return run schedule function catan_engine_test:wait/{name} 1t',f'function catan_engine_test:done/{name}']
        self.file('wait/'+name,tick)
        self.file('done/'+name,self.score('#jobticks','ce','..999',name+'_bounded')+(checks or []))
    def finish(self):
        self.file('table','tag @s add ce.fixture\ntag @s add ce.table\n$scoreboard players set @s ce_id $(table)')
        self.file('finish','kill @e[tag=ce.fixture]\nsay CATAN_FINISHED')
        names=list(self.cases)
        self.file('bootstrap',['forceload add 0 0 63 31','scoreboard objectives add ce dummy','scoreboard objectives add ce_id dummy',f'schedule function catan_engine_test:case/{names[0]} 5t'])
        for i,name in enumerate(names):
            key=('done/' if name in self.waiting else 'case/')+name
            self.files[key]+='schedule function catan_engine_test:'+('case/'+names[i+1] if i+1<len(names) else 'finish')+' 1t\n'

def run(suite,full=False,prepare_target=None,prefix='fimel-catan-engine-',setup_ticks=1600):
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--java',type=Path,default=Path('C:/Temp/fimel-java25-validation/jdk-25.0.5+8-jre/bin/java.exe'))
    parser.add_argument('--minecraft-root',type=Path,default=Path('D:/PCL2/MinecraftPcl'))
    parser.add_argument('--version',default='26.2-Fabric_0.19.3')
    args=parser.parse_args()
    output=Path(tempfile.mkdtemp(prefix=prefix));target=output/'packs/fimel_cards'
    if full:shutil.copytree(PACK/'data',target/'data')
    else:shutil.copytree(PACK/'data/catan/function/engine',target/'data/catan/function/engine')
    shutil.copy2(PACK/'pack.mcmeta',target/'pack.mcmeta')
    for name,body in suite.files.items():
        path=target/'data/catan_engine_test/function'/(name+'.mcfunction');path.parent.mkdir(parents=True,exist_ok=True);path.write_text(body,encoding='utf-8')
    for name,body in {
        'minecraft/tags/function/load.json':{'values':['catan:engine/install'] if not full else ['cardtable:load','catan:load']},
        'minecraft/tags/function/tick.json':{'values':[]},
        'catan_engine_test/test_environment/default.json':{'type':'minecraft:function','setup':'catan_engine_test:bootstrap'},
        'catan_engine_test/test_instance/rules.json':{'type':'minecraft:function','environment':'catan_engine_test:default','function':'minecraft:always_pass','max_ticks':1,'required':True,'setup_ticks':setup_ticks,'structure':'minecraft:empty'},
    }.items():
        path=target/'data'/name;path.parent.mkdir(parents=True,exist_ok=True);path.write_text(json.dumps(body),encoding='utf-8')
    if prepare_target:prepare_target(target)
    launch=args.minecraft_root/'versions'/args.version/(args.version+'.json')
    meta=json.loads(launch.read_text(encoding='utf-8-sig'));classpath=[launch.with_suffix('.jar')]
    for library in meta['libraries']:
        entry=library.get('downloads',{}).get('artifact',{});path=args.minecraft_root/'libraries'/entry.get('path','')
        if entry.get('path') and path.is_file():classpath.append(path)
    opts=['-Xms256M','-Xmx3072M','-Djava.awt.headless=true','-Dfile.encoding=UTF-8','--enable-native-access=ALL-UNNAMED','-cp',';'.join(map(str,classpath)),'net.minecraft.gametest.Main','--packs',str(output/'packs'),'--universe',str(output/'universe'),'--tests','catan_engine_test:*','--report',str(output/'gametest.xml')]
    argfile=output/'java-args.txt';argfile.write_text('\n'.join('"'+v.replace('\\','\\\\').replace('"','\\"')+'"' for v in opts),encoding='utf-8')
    print('CATAN GameTest: '+str(output),flush=True);started=time.monotonic()
    process=subprocess.run([str(args.java),'@'+str(argfile)],cwd=output,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True,encoding='utf-8',errors='replace',timeout=360)
    (output/'game.log').write_text(process.stdout,encoding='utf-8')
    passed=set(re.findall(r'CATAN_PASS ([a-z0-9_]+)',process.stdout));failed=sorted(set(re.findall(r'CATAN_FAIL ([a-z0-9_]+)',process.stdout)))
    errors=[s for s in process.stdout.splitlines() if any(x in s for x in ('[ERROR]','/ERROR]','Failed to load','Failed to parse','Unknown function','Unknown or incomplete command',"Couldn't parse",'Command execution stopped'))]
    result={'exit_code':process.returncode,'seconds':round(time.monotonic()-started,1),'assertions':len(suite.expected),'passed':len(passed),'failed':failed,'missing':sorted(set(suite.expected)-passed),'errors':errors,'finished':'CATAN_FINISHED' in process.stdout,'output':str(output)}
    (output/'result.json').write_text(json.dumps(result,ensure_ascii=False,indent=2),encoding='utf-8');print(json.dumps(result,ensure_ascii=False,indent=2),flush=True)
    return int(bool(process.returncode or failed or result['missing'] or errors or not result['finished']))


def build_suite():
    s=Suite()
    def ok(name):return s.score('#ok','ca_ctx',1,name)
    def reject(name,request,error):
        return s.snapshot()+request+s.score('#ok','ca_ctx',0,name+'_rejected')+s.score('#error','ca_ctx',error,name+'_error')+s.unchanged(name+'_atomic')
    def board(vertices=None,roads=None):
        owners=[0]*54;levels=[0]*54;edges=[0]*72
        for v,(p,l) in (vertices or {}).items():owners[v]=p;levels[v]=l
        for e,p in (roads or {}).items():edges[e]=p
        return s.set('vertex_owner',owners)+s.set('vertex_level',levels)+s.set('road_owner',edges)
    def phase(n=4,value=4):return s.setup(n)+s.set('phase',value)
    def roll(d1,d2):
        return s.call('context')+['scoreboard players set #d1 ca_ctx '+str(d1),'scoreboard players set #d2 ca_ctx '+str(d2)]+s.call('roll_result')+s.call('commit')
    def recalc():return s.call('context')+s.call('commit')
    def job():return s.call('context')+['scoreboard players set #resume ca_ctx 4']+s.call('job/start')+s.call('commit')
    def dev_conservation(name):
        out=['execute store result score #cards ce run data get entity '+TABLE+' data.catan.dev_deck']
        for k in range(5):
            out += [f'execute store result score #part ce run data get entity {TABLE} data.catan.dev_discard[{k}]','scoreboard players operation #cards ce += #part ce']
            for p in range(1,5):
                for field in ('dev','fresh'):
                    out += [f'execute store result score #part ce run data get entity {TABLE} data.catan.p{p}.{field}[{k}]','scoreboard players operation #cards ce += #part ce']
        for p in range(1,5):out += [f'execute store result score #part ce run data get entity {TABLE} data.catan.p{p}.knights','scoreboard players operation #cards ce += #part ce']
        return out+s.score('#cards','ce',25,name)

    init=s.setup()+s.data('phase',1,'initial_phase')+s.data('n',4,'initial_four')+s.data('vertex_owner',54,'vertices_54')+s.data('road_owner',72,'edges_72')+s.data('terrain',19,'hexes_19')+s.data('port_types',9,'ports_9')+s.data('dev_deck',25,'dev_25')
    init += [f'scoreboard players set #kind{k} ce 0' for k in range(5)]
    for i in range(25):
        init += [f'execute store result score #kind ce run data get entity {TABLE} data.catan.dev_deck[{i}]']
        init += [f'execute if score #kind ce matches {k} run scoreboard players add #kind{k} ce 1' for k in range(5)]
    for k,n in enumerate((14,2,2,2,5)):init+=s.score(f'#kind{k}','ce',n,'deck_kind_'+str(k))
    init+=s.conservation('initial')+dev_conservation('initial_development_conserved')
    init+=s.set('p1.seat',8)+s.set('p1.name','PlayerOne')+s.set('p1.color',16711680)+s.set('phase',4)+s.action(1,29)+ok('metadata_action')+s.data('p1.seat',8,'metadata_seat')+s.data('p1.color',16711680,'metadata_color')
    init+=s.check(f'data entity {TABLE} data.catan.p1{{name:"PlayerOne"}}','metadata_name')
    s.case('initial',init)
    random=s.setup(3,1)+s.data('n',3,'random_three')
    for k in range(6):random += [f'scoreboard players set #terrain{k} ce 0']
    for k in range(13):random += [f'scoreboard players set #number{k} ce 0']
    for h in range(19):
        random += [f'execute store result score #kind ce run data get entity {TABLE} data.catan.terrain[{h}]']+[f'execute if score #kind ce matches {k} run scoreboard players add #terrain{k} ce 1' for k in range(6)]
        random += [f'execute store result score #number ce run data get entity {TABLE} data.catan.numbers[{h}]']
        random+=s.check('score #kind ce matches 0..5','random_terrain_range_'+str(h))
        random+=['scoreboard players set #map_valid ce 0','execute if score #kind ce matches 0..4 if score #number ce matches 2..12 unless score #number ce matches 7 run scoreboard players set #map_valid ce 1','execute if score #kind ce matches 5 if score #number ce matches 0 run scoreboard players set #map_valid ce 1']
        random+=s.score('#map_valid','ce',1,'random_number_matches_terrain_'+str(h))
        random += [f'execute if score #number ce matches {k} run scoreboard players add #number{k} ce 1' for k in range(13)]
        random += [f'execute if score #kind ce matches 5 store result score #desert ce run data get entity {TABLE} data.catan.robber',f'execute if score #kind ce matches 5 run scoreboard players remove #desert ce {h}','execute unless score #kind ce matches 5 run scoreboard players set #desert ce 0']
        random+=s.score('#desert','ce',0,'random_robber_on_desert_'+str(h))
    for k,n in enumerate((4,3,4,4,3,1)):random+=s.score(f'#terrain{k}','ce',n,'random_terrain_count_'+str(k))
    for k in range(13):random+=s.score(f'#number{k}','ce',FIXED_NUMBERS.count(k),'random_number_count_'+str(k))
    random+=s.data('dev_deck',25,'random_deck_size')
    s.case('random_map',random)
    dice=phase(value=3)+reject('roll_other_turn',s.action(2,10),4)+s.action(1,10)+ok('public_roll')+s.data('dice[0]','1..6','public_die_one')+s.data('dice[1]','1..6','public_die_two')+s.data('phase','4..6','public_roll_advances')
    dice+=reject('roll_cannot_repeat',s.action(1,10),4)
    s.case('public_roll',dice)

    # Initial draft is tested through public actions, with actual reverse order.
    for n in (3,4):
        chosen=[]
        for _ in range(2*n):chosen.append(next(v for v in sorted(range(54),key=lambda v:(-len(VERTEX_HEXES[v]),v)) if v not in chosen and not any(w in chosen for w in VERTEX_NEIGHBORS[v])))
        order=list(range(1,n+1))+list(range(n,0,-1));expected={p:[0]*5 for p in range(1,n+1)}
        for i,(p,v) in enumerate(zip(order,chosen)):
            body=(s.setup(n) if i==0 else [])+s.data('turn',p,f'draft{n}_turn_{i}')+s.action(p,1,v)+ok(f'draft{n}_v_{i}')+s.data('phase',2,f'draft{n}_road_phase_{i}')
            if i>=n:
                for h in VERTEX_HEXES[v]:
                    if FIXED_TERRAIN[h]<5:expected[p][FIXED_TERRAIN[h]]+=1
            body+=s.action(p,2,VERTEX_EDGES[v][0])+ok(f'draft{n}_e_{i}')
            final=[]
            if i==2*n-1:
                final=s.data('phase',3,f'draft{n}_ready')+s.data('turn',1,f'draft{n}_first')+s.conservation(f'draft{n}')
                for player in range(1,n+1):
                    final+=s.data(f'p{player}.settlements_left',3,f'draft{n}_villages_{player}')+s.data(f'p{player}.roads_left',13,f'draft{n}_roads_{player}')+s.data(f'p{player}.vp',2,f'draft{n}_vp_{player}')
                    for r in range(5):final+=s.data(f'p{player}.resources[{r}]',expected[player][r],f'draft{n}_starting_{player}_{r}')
            s.case(f'draft{n}_{i}',body,final,wait=i==2*n-1)

    h=9;v0,v1,v2=HEX_VERTICES[h][0],HEX_VERTICES[h][2],HEX_VERTICES[h][4]
    def production_fixture():
        return phase(value=3)+s.set('terrain',[0]*19)+s.set('numbers',[6 if k==h else 0 for k in range(19)])+s.set('robber',0)+board({v0:(1,2),v1:(2,1)})
    s.case('production',production_fixture()+roll(3,3)+s.data('p1.resources[0]',2,'city_production_two')+s.data('p2.resources[0]',1,'village_production_one')+s.data('last.production',2,'production_events_two')+s.conservation('production'))
    s.case('shortage_multiple',production_fixture()+s.resources({3:[17,0,0,0,0]})+roll(3,3)+s.data('p1.resources[0]',0,'short_multi_p1_none')+s.data('p2.resources[0]',0,'short_multi_p2_none')+s.data('bank[0]',2,'short_multi_bank_unchanged')+s.conservation('short_multi'))
    s.case('shortage_single',production_fixture()+board({v0:(1,2)})+s.resources({3:[18,0,0,0,0]})+roll(3,3)+s.data('p1.resources[0]',1,'short_single_partial')+s.data('bank[0]',0,'short_single_empty')+s.data('last.production[0].amount',1,'short_event_actual')+s.conservation('short_single'))
    s.case('robber_blocks',production_fixture()+s.set('robber',h)+roll(3,3)+s.data('p1.resources[0]',0,'robber_city_blocked')+s.data('p2.resources[0]',0,'robber_village_blocked'))

    seven=phase(value=3)+s.resources({1:[7,0,0,0,0],2:[0,8,0,0,0],3:[0,0,9,0,0]})+s.set('p1.dev',[0,0,0,0,5])+roll(3,4)
    seven+=s.data('phase',5,'seven_discard_phase')+s.data('p1.discard_due',0,'seven_cards_keep')+s.data('p2.discard_due',4,'eight_discard_four')+s.data('p3.discard_due',4,'nine_discard_four')
    seven+=reject('discard_wrong_amount',s.action(2,11,offer=[0,3,0,0,0]),8)+s.action(3,11,offer=[0,0,4,0,0])+ok('discard_any_owing_actor')+s.data('phase',5,'discard_wait_all')+s.action(2,11,offer=[0,4,0,0,0])+ok('discard_last')+s.data('phase',6,'discard_then_robber')+s.conservation('seven')
    s.case('seven',seven)
    robbery=phase(value=6)+s.set('robber_return',4)+board({v0:(2,1),v1:(3,1)})+s.resources({2:[0,0,0,0,3]})
    robbery+=reject('robber_same_hex',s.action(1,12,0),5)+s.action(1,12,h)+ok('robber_move')+s.data('phase',7,'robber_victim_phase')
    robbery+=reject('robber_nonadjacent',s.action(1,13,4),5)+s.action(1,13,2)+ok('robber_steal')+s.data('p1.resources[4]',1,'robber_actual_resource')+s.data('p2.resources[4]',2,'robber_victim_loses_one')+s.data('last.stolen',1,'robber_event_no_identity')+s.data('phase',4,'robber_returns')+s.conservation('robber')
    s.case('robbery',robbery)
    s.case('robber_empty',phase(value=6)+s.set('robber_return',3)+board({v0:(2,1)})+s.action(1,12,h)+s.action(1,13,2)+ok('robber_empty_victim_allowed')+s.data('last.stolen',0,'robber_empty_no_card')+s.data('phase',3,'knight_before_dice_returns_roll'))
    s.case('robber_no_victim',phase(value=6)+s.set('robber_return',4)+s.action(1,12,18)+ok('robber_empty_hex')+s.data('phase',4,'robber_no_victim_returns'))

    bank=phase()+s.resources({1:[8,0,0,0,0]})+s.action(1,50,0,1,2)+ok('bank_four_to_one')+s.data('p1.resources[0]',0,'bank_pays_eight')+s.data('p1.resources[1]',2,'bank_receives_two')+s.conservation('bank')
    bank+=reject('bank_same_resource',s.action(1,50,1,1,1),8)+reject('bank_other_turn',s.action(2,50,0,1,1),4)
    s.case('bank_trade',bank)
    for port in (next(p for p in PORTS if p['resource']==-1),next(p for p in PORTS if p['resource']==0)):
        ratio=3 if port['resource']==-1 else 2;name='generic' if ratio==3 else 'specific'
        body=phase()+board({port['vertices'][0]:(1,1)})+s.resources({1:[ratio,0,0,0,0]})+s.action(1,50,0,4,1)+ok(name+'_port')+s.data('p1.resources[0]',0,name+'_cost')+s.data('p1.resources[4]',1,name+'_gain')+s.conservation(name)
        s.case(name+'_port',body)
    offers=phase()+s.resources({1:[3,0,0,0,0],2:[0,2,0,0,0],3:[0,0,1,0,0]})
    offers+=reject('trade_third_party',s.action(2,40,3,offer=[0,1,0,0,0],want=[0,0,1,0,0]),4)+reject('trade_gift',s.action(1,40,2,offer=[1,0,0,0,0]),8)+reject('trade_same_resource',s.action(1,40,2,offer=[1,0,0,0,0],want=[1,0,0,0,0]),8)
    offers+=s.action(2,40,1,offer=[0,1,0,0,0],want=[2,0,0,0,0])+ok('trade_counteroffer')+s.data('trade.from',2,'trade_counter_from')
    # Read the assigned trade ID, while retaining the authenticated actor.
    offers+=['data modify storage catan_engine_test:trade id set from entity '+TABLE+' data.catan.trade.id']+s.action(1,41)
    # The above intentionally fails target=-1 without changing the pending offer.
    offers+=s.score('#ok','ca_ctx',0,'trade_bad_id_rejected')
    offers+=['data modify storage catan:action input.target set from storage catan_engine_test:trade id']+s.call('action')+ok('trade_accept')+s.data('p1.resources[0]',1,'trade_p1_pays_two')+s.data('p1.resources[1]',1,'trade_p1_gets_brick')+s.data('p2.resources[0]',2,'trade_p2_gets_wood')+s.data('p2.resources[1]',1,'trade_p2_pays_one')+s.data('last.from',2,'trade_event_from')+s.data('last.to',1,'trade_event_to')+s.conservation('player_trade')
    s.case('player_trade',offers)
    fail_trade=phase()+s.resources({1:[2,0,0,0,0],2:[0,1,0,0,0]})+s.action(1,40,2,offer=[2,0,0,0,0],want=[0,1,0,0,0])+s.set('p1.resources[0]',0)+s.snapshot()+s.action(2,41)
    fail_trade+=['data modify storage catan:action input.target set from entity '+TABLE+' data.catan.trade.id']+s.call('action')+s.score('#error','ca_ctx',6,'trade_accept_rechecks_resources')+s.unchanged('trade_failure_whole_state')
    s.case('trade_accept_atomic',fail_trade)
    hidden=phase()+s.resources({1:[1,0,0,0,0]})+s.action(1,40,2,offer=[1,0,0,0,0],want=[0,1,0,0,0])+ok('offer_cannot_probe_recipient_hand')
    hidden+=s.snapshot()+s.action(2,41)+['data modify storage catan:action input.target set from entity '+TABLE+' data.catan.trade.id']+s.call('action')+s.score('#error','ca_ctx',6,'recipient_checks_own_cards_on_accept')+s.unchanged('recipient_insufficient_atomic')
    hidden+=['data modify storage catan_engine_test:trade id set from entity '+TABLE+' data.catan.trade.id']+s.action(1,29)+ok('pending_end_turn')+s.check(f'data entity {TABLE} data.catan{{phase:3,turn:2}}','pending_end_turn_advances')
    hidden+=['scoreboard players set #pending ce 0',f'execute if data entity {TABLE} data.catan.trade run scoreboard players set #pending ce 1']+s.score('#pending','ce',0,'pending_trade_cleared_on_end_turn')
    hidden+=s.set('phase',4)+s.snapshot()+s.action(2,41)+['data modify storage catan:action input.target set from storage catan_engine_test:trade id']+s.call('action')+s.score('#error','ca_ctx',11,'previous_turn_trade_id_invalid')+s.unchanged('previous_turn_trade_rejected_atomic')
    s.case('trade_privacy',hidden)

    e=0;a,b=EDGES[e];next_e=next(x for x in VERTEX_EDGES[b] if x!=e);far=EDGES[next_e][1] if EDGES[next_e][0]==b else EDGES[next_e][0]
    build=phase()+board({a:(1,1)})+s.resources({1:[2,2,1,3,3]})
    build+=reject('build_other_turn',s.action(2,20,e),4)+reject('stale_epoch',s.action(1,20,e,epoch=-77),3)+reject('build_bad_edge',s.action(1,20,72),5)+s.action(1,20,e)+ok('road_built')
    s.case('road_build',build,s.data(f'road_owner[{e}]',1,'road_owner')+s.data('p1.resources[0]',1,'road_wood_cost')+s.data('p1.resources[1]',1,'road_brick_cost')+s.conservation('road_build'),wait=True)
    s.case('village_distance',reject('village_adjacent',s.action(1,21,b),5)+s.set('p1.settlements_left',4)+s.action(1,22,a)+ok('city_upgrade')+s.data(f'vertex_level[{a}]',2,'city_level')+s.data('p1.settlements_left',5,'city_returns_village_piece')+s.data('p1.cities_left',3,'city_inventory')+s.data('p1.resources[3]',1,'city_wheat_cost')+s.data('p1.resources[4]',0,'city_ore_cost')+s.conservation('city_build'))
    blocked=phase()+board({b:(2,1)},{e:1})+s.resources({1:[1,1,0,0,0]})+reject('road_enemy_blocks',s.action(1,20,next_e),5)
    s.case('road_blocked',blocked)
    s.case('build_no_inventory',phase()+board({a:(1,1)})+s.resources({1:[1,1,0,0,0]})+s.set('p1.roads_left',0)+reject('road_stock_empty',s.action(1,20,e),7))
    s.case('build_no_money',phase()+board({a:(1,1)})+reject('road_funds_atomic',s.action(1,20,e),6))
    s.case('settlement_build',phase()+board(roads={next_e:1})+s.resources({1:[1,1,1,1,0]})+s.action(1,21,far)+ok('new_village'),s.data(f'vertex_owner[{far}]',1,'new_village_owner')+s.data('p1.resources[0]',0,'village_wood_paid')+s.data('p1.resources[1]',0,'village_brick_paid')+s.data('p1.resources[2]',0,'village_wool_paid')+s.data('p1.resources[3]',0,'village_wheat_paid')+s.conservation('village_build'),wait=True)

    fresh=phase()+s.resources({1:[0,0,1,1,1]})+s.set('dev_deck',[0])+s.action(1,23)+ok('development_buy')+s.data('p1.fresh[0]',1,'development_new_private')+s.data('dev_deck',0,'development_draw_one')+s.data('last.target',-1,'development_event_no_identity')+reject('development_new_unplayable',s.action(1,30,0),10)
    fresh+=s.action(1,29)+s.set('phase',4)+s.action(2,29)+s.set('phase',4)+s.action(3,29)+s.set('phase',4)+s.action(4,29)+s.data('p1.dev[0]',1,'development_ages_next_own_turn')+s.data('p1.fresh[0]',0,'development_fresh_cleared')+s.action(1,30,0)+ok('knight_before_roll')+s.data('phase',6,'knight_moves_robber')+s.data('p1.knights',1,'knight_played_count')+s.data('p1.discard_due',0,'knight_does_not_discard')+s.action(1,12,18)+s.data('phase',3,'knight_returns_before_roll')
    s.case('fresh_development',fresh)
    monopoly=phase()+s.resources({1:[1,0,0,0,0],2:[2,0,0,0,0],3:[3,0,0,0,0],4:[4,0,0,0,0]})+s.set('p1.dev',[0,0,1,1,0])+s.action(1,30,2,0)+ok('monopoly')+s.data('p1.resources[0]',10,'monopoly_takes_all')+s.data('p2.resources[0]',0,'monopoly_clears_second')+s.data('p3.resources[0]',0,'monopoly_clears_third')+s.data('p4.resources[0]',0,'monopoly_clears_fourth')+s.data('dev_discard[2]',1,'monopoly_discarded')+reject('only_one_development',s.action(1,30,3,1,2),10)+s.conservation('monopoly')
    s.case('monopoly',monopoly)
    invention=phase(value=3)+s.set('p1.dev',[0,0,0,1,0])+s.resources({2:[0,18,0,0,0]})+reject('invention_no_two_bank_cards',s.action(1,30,3,1,1),6)+s.action(1,30,3,2,2)+ok('invention_same_type_two')+s.data('p1.resources[2]',2,'invention_gets_two')+s.data('phase',3,'invention_preserves_before_dice')+s.data('dev_discard[3]',1,'invention_discarded')+s.conservation('invention')
    s.case('invention',invention)
    roaddev=phase()+board({a:(1,1)})+s.set('p1.dev',[0,1,0,0,0])+s.action(1,30,1)+ok('road_card_played')+s.data('phase',8,'road_card_placement')+s.action(1,20,e)+ok('road_card_first')
    s.case('road_card_one',roaddev,s.data('phase',8,'road_card_second_pending')+s.data('free_left',1,'road_card_one_remaining')+s.data('p1.resources[0]',0,'road_card_no_resource_cost'),wait=True)
    s.case('road_card_two',s.action(1,20,next_e)+ok('road_card_second'),s.data('phase',4,'road_card_done')+s.data('free_left',0,'road_card_zero_remaining')+s.data('dev_discard[1]',1,'road_card_discarded'),wait=True)
    s.case('road_card_last_piece',phase()+board({a:(1,1)})+s.set('p1.dev',[0,1,0,0,0])+s.set('p1.roads_left',1)+s.action(1,30,1)+s.data('free_left',1,'road_card_one_stock')+s.action(1,20,e),s.data('phase',4,'road_card_one_stock_done')+s.data('p1.roads_left',0,'road_card_uses_last_piece'),wait=True)
    s.case('road_card_no_piece',phase()+s.set('p1.dev',[0,1,0,0,0])+s.set('p1.roads_left',0)+reject('road_card_stock_atomic',s.action(1,30,1),7))
    s.case('empty_development',phase()+s.resources({1:[0,0,1,1,1]})+s.set('dev_deck',[])+reject('empty_deck_atomic',s.action(1,23),7))
    # Buy the entire actual shuffled deck in affordable batches. Every payment
    # returns cards to the bank, so all 95 resource cards remain conserved.
    for batch in range(5):
        buy=(phase() if batch==0 else [])+s.resources({1:[0,0,5,5,5]})
        for i in range(5):buy+=s.action(1,23)+ok(f'full_deck_buy_{batch}_{i}')
        buy+=s.data('dev_deck',20-5*batch,f'full_deck_remaining_{batch}')+s.conservation('full_deck_'+str(batch))+dev_conservation('full_deck_card_conservation_'+str(batch))
        if batch==4:
            for k,n in enumerate((14,2,2,2,5)):buy+=s.data(f'p1.fresh[{k}]',n,'full_deck_drawn_kind_'+str(k))
            buy+=reject('full_deck_exhausted',s.action(1,23),7)
        s.case('full_deck_'+str(batch),buy)

    # An independent edge-trail oracle is only the expected answer. Vanilla runs
    # the actual persistent DFS, with its normal 64-node tick budget.
    def longest(roads,blocked=()):
        best=0
        def walk(v,used):
            nonlocal best
            best=max(best,len(used))
            if used and v in blocked:return
            for edge in VERTEX_EDGES[v]:
                if edge in roads and edge not in used:walk(EDGES[edge][1] if EDGES[edge][0]==v else EDGES[edge][0],used|{edge})
        for v in range(54):walk(v,set())
        return best
    cycle=set(HEX_EDGES[9]);junction=next(v for v in HEX_VERTICES[9] if len(VERTEX_EDGES[v])==3)
    tail=next(e for e in VERTEX_EDGES[junction] if e not in cycle);other=EDGES[tail][1] if EDGES[tail][0]==junction else EDGES[tail][0]
    tail2=next(e for e in VERTEX_EDGES[other] if e!=tail);ringtail=cycle|{tail,tail2}
    for label,occupied in [('cycle',{}),('enemy_cut',{junction:(2,1)}),('own_cross',{junction:(1,1)})]:
        expected=longest(ringtail,{v for v,(p,l) in occupied.items() if p!=1})
        s.case('longest_'+label,phase()+board(occupied,{e:1 for e in ringtail})+job(),s.data('p1.road_length',expected,'longest_'+label+'_exact')+s.data('longest',1,'longest_'+label+'_holder')+s.data('phase',4,'longest_'+label+'_resumed'),wait=True)
    # Disjoint six-edge hexagons make a tie without an accidental connection.
    first=next(h for h in range(19) if h!=9 and not set(HEX_EDGES[h])&cycle)
    tied={**{e:1 for e in cycle},**{e:2 for e in HEX_EDGES[first]}}
    s.case('longest_existing_tie',phase()+board(roads=tied)+s.set('longest',2)+job(),s.data('p1.road_length',6,'longest_tie_first_six')+s.data('p2.road_length',6,'longest_tie_second_six')+s.data('longest',2,'longest_tie_keeps_old'),wait=True)
    s.case('longest_lost_tie',phase()+board(roads=tied)+s.set('longest',3)+job(),s.data('longest',0,'longest_disqualified_tie_none'),wait=True)
    # Fifteen is the physical maximum and the bitset's required upper edge.
    def find_path(v,edges):
        if len(edges)==15:return edges
        for edge in VERTEX_EDGES[v]:
            if edge not in edges:
                found=find_path(EDGES[edge][1] if EDGES[edge][0]==v else EDGES[edge][0],edges+[edge])
                if found:return found
        return None
    path=find_path(0,[])
    s.case('longest_fifteen',phase()+board(roads={e:1 for e in path})+job(),s.data('p1.road_length',15,'longest_max_fifteen'),wait=True)
    s.case('army_tie',phase()+s.set('p1.knights',3)+s.set('p2.knights',3)+s.set('army',2)+recalc()+s.data('army',2,'army_equal_keeps_holder')+s.set('p1.knights',4)+recalc()+s.data('army',1,'army_higher_transfers')+s.data('p1.public_vp',2,'army_public_points'))

    points={v:(2,2) for v in range(4)}
    victory=phase()+board(points)+s.set('p2.dev',[0,0,0,0,2])+recalc()+s.data('p2.vp',10,'nonturn_ten_points')+s.data('winner',0,'nonturn_does_not_win')+s.action(1,29)+ok('endturn_to_ten')+s.data('phase',11,'start_turn_win_before_dice')+s.data('winner',2,'winner_current_player')+s.data('p2.public_vp',8,'secret_vp_not_public')
    victory+=reject('finished_rejects_action',s.action(2,10),12)
    s.case('victory_turn',victory)
    vp=phase()+board({v:(1,2) for v in range(4)})+s.set('p1.dev',[0,0,0,0,1])+s.set('used_dev',1)+s.resources({1:[0,0,1,1,1]})+s.set('dev_deck',[4])+s.action(1,23)+ok('fresh_vp_can_win')+s.data('winner',1,'bought_vp_wins_immediately')+s.data('p1.vp',10,'bought_vp_total')+s.data('p1.public_vp',8,'bought_vp_remains_private')
    s.case('victory_fresh_vp',vp)
    isolation=phase()+s.setup(3,1,202,False)+s.set('phase',4,202)+s.snapshot(202)+s.resources({1:[4,0,0,0,0]})+s.action(1,50,0,1,1)+ok('first_table_trade')+s.unchanged('other_table_untouched',202)
    isolation+=s.set('p1.seat',7)+board(roads={e:1 for e in ringtail})+job()+s.snapshot()+s.call('install')+s.unchanged('load_preserves_search_job')
    s.case('two_table_reload',isolation,s.data('p1.road_length',longest(ringtail),'resumed_job_result')+s.data('p1.seat',7,'resumed_metadata')+s.data('phase',4,'resumed_phase')+s.data('n',3,'other_table_players',202),wait=True,tables=(101,202))
    s.finish();return s


if __name__=='__main__':raise SystemExit(run(build_suite(),setup_ticks=3200))
