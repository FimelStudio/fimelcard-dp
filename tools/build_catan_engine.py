"""生成21号卡坦岛纯NBT规则引擎；不依赖真人/展示实体，不改其他模块。"""
from pathlib import Path
from textwrap import dedent
import json
from catan_topology import *

ROOT=Path(__file__).resolve().parents[1]/'data/catan/function/engine'

def put(name,text):
    p=ROOT/(name+'.mcfunction');p.parent.mkdir(parents=True,exist_ok=True)
    p.write_text('\n'.join(s.strip() for s in dedent(text).strip().splitlines())+'\n',encoding='utf-8')

def snbt(v):return json.dumps(v,separators=(',',':'),ensure_ascii=False)
def fail(n):return f'return run function catan:engine/error {{id:{n}}}'
def guard(cond,n):return f'execute {cond} run '+fail(n)
def lines(*items):return '\n'.join(str(x) for item in items for x in (item if isinstance(item,list) else [item]))

def build():
    put('install',lines('scoreboard objectives add ca_ctx dummy','scoreboard players set #minus ca_ctx -1','scoreboard players set #two ca_ctx 2',
        'data modify storage catan:topology data set value '+snbt(TOPOLOGY),
        'data modify storage catan:topology numbers set value '+snbt(NUMBER_SEQUENCE)))
    put('error','$scoreboard players set #error ca_ctx $(id)\nscoreboard players set #ok ca_ctx 0\nreturn 0')
    player={'resources':[0]*5,'dev':[0]*5,'fresh':[0]*5,'knights':0,'roads_left':15,'settlements_left':5,'cities_left':4,'discard_due':0,'road_length':0,'vp':0,'public_vp':0,'resource_count':0,'dev_count':0}
    initial={'version':1,'n':4,'phase':1,'turn':1,'epoch':1,'setup_step':0,'setup_vertex':-1,'terrain':FIXED_TERRAIN,'numbers':FIXED_NUMBERS,
        'vertex_owner':[0]*54,'vertex_level':[0]*54,'road_owner':[0]*72,'port_types':PORT_RESOURCES,
        'robber':0,'bank':[19]*5,'dev_deck':[],'dev_discard':[0]*5,'used_dev':0,'dice':[0,0],'longest':0,'army':0,'winner':0,
        'last':{'code':0,'actor':0,'target':-1,'a':-1,'b':-1,'production':[]},**{'p'+str(p):player.copy() for p in range(1,5)}}
    put('init',lines(guard('unless score #players ca_ctx matches 3..4',2),
        'data modify storage catan:engine state set value '+snbt(initial),
        'execute store result storage catan:engine state.n int 1 run scoreboard players get #players ca_ctx',
        'execute store result storage catan:engine rng.seed int 1 run random value 0..2147483647',
        'data modify storage catan:engine state.seed set from storage catan:engine rng.seed',
        'function catan:engine/init_rng with storage catan:engine rng',
        'execute if score #layout ca_ctx matches 1 run function catan:engine/init_terrain',
        'function catan:engine/init_deck','data modify entity @s data.catan set from storage catan:engine state',
        'scoreboard players set #ok ca_ctx 1','scoreboard players set #error ca_ctx 0'))
    put('init_rng','$random reset catan:shuffle $(seed) false false')
    put('init_deck',lines('data modify storage catan:engine bag set value '+snbt([0]*14+[1]*2+[2]*2+[3]*2+[4]*5),
        [f'function catan:engine/draw_deck {{max:{24-i}}}' for i in range(25)],'data remove storage catan:engine bag'))
    put('draw_deck','$execute store result storage catan:engine rng.pick int 1 run random value 0..$(max) catan:shuffle\nfunction catan:engine/pick_deck with storage catan:engine rng')
    put('pick_deck','$data modify storage catan:engine state.dev_deck append from storage catan:engine bag[$(pick)]\n$data remove storage catan:engine bag[$(pick)]')
    put('init_terrain',lines('data modify storage catan:engine bag set value '+snbt(FIXED_TERRAIN),
        [f'function catan:engine/draw_terrain {{hex:{h},max:{18-h}}}' for h in range(19)],
        'data remove storage catan:engine bag','scoreboard players set #number ca_ctx 0',
        [f'function catan:engine/number_hex {{hex:{h}}}' for h in SPIRAL_HEXES]))
    put('draw_terrain','$execute store result storage catan:engine rng.pick int 1 run random value 0..$(max) catan:shuffle\n$data modify storage catan:engine rng.hex set value $(hex)\nfunction catan:engine/pick_terrain with storage catan:engine rng')
    put('pick_terrain','$data modify storage catan:engine state.terrain[$(hex)] set from storage catan:engine bag[$(pick)]\n$data modify storage catan:engine state.numbers[$(hex)] set value 0\n$data remove storage catan:engine bag[$(pick)]')
    put('number_hex', '''
        $execute store result score #terrain ca_ctx run data get storage catan:engine state.terrain[$(hex)]
        $execute if score #terrain ca_ctx matches 5 run data modify storage catan:engine state.robber set value $(hex)
        execute if score #terrain ca_ctx matches 5 run return 0
        $data modify storage catan:engine rng.hex set value $(hex)
        execute store result storage catan:engine rng.pick int 1 run scoreboard players get #number ca_ctx
        function catan:engine/set_number with storage catan:engine rng
        scoreboard players add #number ca_ctx 1
    ''')
    put('set_number','$data modify storage catan:engine state.numbers[$(hex)] set from storage catan:topology numbers[$(pick)]')
    cache=[f'execute store result score #{key} ca_ctx run data get storage catan:engine state.{key}' for key in ('n','phase','turn','epoch','setup_step','setup_vertex','robber','used_dev','longest','army','winner')]
    cache += [f'execute store result score #bank{r} ca_ctx run data get storage catan:engine state.bank[{r}]' for r in range(5)]
    cache += [f'execute store result score #vo{v} ca_ctx run data get storage catan:engine state.vertex_owner[{v}]\nexecute store result score #vl{v} ca_ctx run data get storage catan:engine state.vertex_level[{v}]' for v in range(54)]
    cache += [f'execute store result score #eo{e} ca_ctx run data get storage catan:engine state.road_owner[{e}]' for e in range(72)]
    cache += [f'execute store result score #ht{h} ca_ctx run data get storage catan:engine state.terrain[{h}]\nexecute store result score #hn{h} ca_ctx run data get storage catan:engine state.numbers[{h}]' for h in range(19)]
    cache += [f'execute store result score #res{p}_{r} ca_ctx run data get storage catan:engine state.p{p}.resources[{r}]' for p in range(1,5) for r in range(5)]
    put('cache',lines(cache))
    put('context','data modify storage catan:engine state set from entity @s data.catan\nfunction catan:engine/cache')
    put('load_actor',lines([f'$scoreboard players operation #r{r} ca_ctx = #res$(actor)_{r} ca_ctx' for r in range(5)],
        [f'$execute store result score #dev{r} ca_ctx run data get storage catan:engine state.p$(actor).dev[{r}]' for r in range(5)],
        [f'$execute store result score #fresh{r} ca_ctx run data get storage catan:engine state.p$(actor).fresh[{r}]' for r in range(5)],
        [f'$execute store result score #{field} ca_ctx run data get storage catan:engine state.p$(actor).{field}' for field in ('knights','roads_left','settlements_left','cities_left','discard_due')]))
    put('save_resources',lines([f'$execute store result storage catan:engine state.p$(actor).resources[{r}] int 1 run scoreboard players get #r{r} ca_ctx' for r in range(5)]))
    put('load_other',lines([f'$scoreboard players operation #o{r} ca_ctx = #res$(target)_{r} ca_ctx' for r in range(5)]))
    put('save_other',lines([f'$execute store result storage catan:engine state.p$(target).resources[{r}] int 1 run scoreboard players get #o{r} ca_ctx' for r in range(5)]))
    put('save_bank',lines([f'execute store result storage catan:engine state.bank[{r}] int 1 run scoreboard players get #bank{r} ca_ctx' for r in range(5)]))
    put('save_dev',lines([f'$execute store result storage catan:engine state.p$(actor).dev[{r}] int 1 run scoreboard players get #dev{r} ca_ctx' for r in range(5)],
        [f'$execute store result storage catan:engine state.p$(actor).fresh[{r}] int 1 run scoreboard players get #fresh{r} ca_ctx' for r in range(5)]))
    put('action', '''
        scoreboard players set #ok ca_ctx 0
        scoreboard players set #error ca_ctx 9
        scoreboard players set #changed ca_ctx 0
        execute unless data entity @s data.catan{version:1} run return run function catan:engine/error {id:1}
        function catan:engine/context
        data modify storage catan:engine request set value {actor:0,code:0,target:-1,a:-1,b:-1,epoch:-1,offer:[0,0,0,0,0],want:[0,0,0,0,0]}
        data modify storage catan:engine request merge from storage catan:action input
        execute store result score #actor ca_ctx run data get storage catan:engine request.actor
        execute store result score #code ca_ctx run data get storage catan:engine request.code
        execute store result score #target ca_ctx run data get storage catan:engine request.target
        execute store result score #a ca_ctx run data get storage catan:engine request.a
        execute store result score #b ca_ctx run data get storage catan:engine request.b
        execute store result score #given_epoch ca_ctx run data get storage catan:engine request.epoch
        execute unless score #actor ca_ctx matches 1..4 run return run function catan:engine/error {id:2}
        execute if score #actor ca_ctx > #n ca_ctx run return run function catan:engine/error {id:2}
        execute unless score #given_epoch ca_ctx = #epoch ca_ctx run return run function catan:engine/error {id:3}
        execute if score #phase ca_ctx matches 10..11 run return run function catan:engine/error {id:12}
        function catan:engine/load_actor with storage catan:engine request
        data modify storage catan:engine state.last set value {code:0,actor:0,target:-1,a:-1,b:-1,production:[]}
        data modify storage catan:engine state.last.code set from storage catan:engine request.code
        data modify storage catan:engine state.last.actor set from storage catan:engine request.actor
        data modify storage catan:engine state.last.target set from storage catan:engine request.target
        data modify storage catan:engine state.last.a set from storage catan:engine request.a
        data modify storage catan:engine state.last.b set from storage catan:engine request.b
        function catan:engine/dispatch
        execute unless score #ok ca_ctx matches 1 run return 0
        function catan:engine/commit
        return 1
    ''')
    dispatch={1:'setup/settlement',2:'setup/road',10:'roll',11:'discard',12:'robber/move',13:'robber/steal',20:'build/road',21:'build/settlement',22:'build/city',23:'development/buy',29:'end_turn',30:'development/play',31:'development/finish_roads',40:'trade/offer',41:'trade/accept',42:'trade/reject',50:'trade/bank'}
    put('dispatch',lines([f'execute if score #code ca_ctx matches {code} run return run function catan:engine/{path}' for code,path in dispatch.items()],fail(9)))
    put('commit', '''
        function catan:engine/cache
        function catan:engine/stats
        scoreboard players add #epoch ca_ctx 1
        execute store result storage catan:engine state.epoch int 1 run scoreboard players get #epoch ca_ctx
        execute store result storage catan:engine state.last.epoch int 1 run scoreboard players get #epoch ca_ctx
        data modify entity @s data.catan set from storage catan:engine state
        scoreboard players set #error ca_ctx 0
        scoreboard players set #ok ca_ctx 1
    ''')
    put('turn_guard',lines(guard('unless score #actor ca_ctx = #turn ca_ctx',4),'scoreboard players set #valid ca_ctx 1'))
    for name,cost in {'road':[1,1,0,0,0],'settlement':[1,1,1,1,0],'city':[0,0,0,2,3],'development':[0,0,1,1,1]}.items():
        put('cost/'+name,lines([guard(f'if score #r{r} ca_ctx matches ..{n-1}',6) for r,n in enumerate(cost) if n],
            [f'scoreboard players remove #r{r} ca_ctx {n}\nscoreboard players add #bank{r} ca_ctx {n}' for r,n in enumerate(cost) if n],
            'function catan:engine/save_resources with storage catan:engine request','function catan:engine/save_bank','scoreboard players set #valid ca_ctx 1'))
    build_building()
    build_production()
    build_robber()
    build_trade()
    build_development()
    build_job()
    build_stats()
    print('Generated CATAN rules:',len(list(ROOT.rglob('*.mcfunction'))))


def build_building():
    for v in range(54):
        body=['scoreboard players set #valid ca_ctx 0',f'execute unless score #vo{v} ca_ctx matches 0 run return 0']
        body += [f'execute unless score #vo{w} ca_ctx matches 0 run return 0' for w in VERTEX_NEIGHBORS[v]]
        body += ['execute if score #phase ca_ctx matches 1 run return run scoreboard players set #valid ca_ctx 1']
        body += [f'execute if score #eo{e} ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1' for e in VERTEX_EDGES[v]]
        put(f'legal/v{v}',lines(body))
    for e,(a,b) in enumerate(EDGES):
        body=['scoreboard players set #valid ca_ctx 0',f'execute unless score #eo{e} ca_ctx matches 0 run return 0']
        body += [f'execute if score #phase ca_ctx matches 2 unless score #setup_vertex ca_ctx matches {a} unless score #setup_vertex ca_ctx matches {b} run return 0']
        for v in (a,b):
            body += [f'execute if score #vo{v} ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1']
            body += [f'execute if score #vo{v} ca_ctx matches 0 if score #eo{w} ca_ctx = #actor ca_ctx run return run scoreboard players set #valid ca_ctx 1' for w in VERTEX_EDGES[v] if w!=e]
        put(f'legal/e{e}',lines(body))
    put('legal/vertex','$function catan:engine/legal/v$(target)')
    put('legal/edge','$function catan:engine/legal/e$(target)')
    put('build/place_v', '''
        $execute store result storage catan:engine state.vertex_owner[$(target)] int 1 run scoreboard players get #actor ca_ctx
        $data modify storage catan:engine state.vertex_level[$(target)] set value 1
        scoreboard players remove #settlements_left ca_ctx 1
        $execute store result storage catan:engine state.p$(actor).settlements_left int 1 run scoreboard players get #settlements_left ca_ctx
    ''')
    put('build/place_e', '''
        $execute store result storage catan:engine state.road_owner[$(target)] int 1 run scoreboard players get #actor ca_ctx
        scoreboard players remove #roads_left ca_ctx 1
        $execute store result storage catan:engine state.p$(actor).roads_left int 1 run scoreboard players get #roads_left ca_ctx
    ''')
    settlement_guard=[guard('unless score #actor ca_ctx = #turn ca_ctx',4),guard('unless score #target ca_ctx matches 0..53',5),guard('unless score #settlements_left ca_ctx matches 1..',7),
        'function catan:engine/legal/vertex with storage catan:engine request',guard('unless score #valid ca_ctx matches 1',5)]
    put('setup/settlement',lines(guard('unless score #phase ca_ctx matches 1',4),settlement_guard,
        'function catan:engine/build/place_v with storage catan:engine request',
        'data modify storage catan:engine state.setup_vertex set from storage catan:engine request.target',
        'data modify storage catan:engine state.phase set value 2',
        'execute if score #setup_step ca_ctx >= #n ca_ctx run function catan:engine/setup/resources with storage catan:engine request',
        'scoreboard players set #ok ca_ctx 1'))
    put('setup/resources','$function catan:engine/setup/resources_v$(target)\nfunction catan:engine/save_resources with storage catan:engine request\nfunction catan:engine/save_bank')
    for v in range(54):
        put(f'setup/resources_v{v}',lines([f'execute if score #ht{h} ca_ctx matches {r} if score #bank{r} ca_ctx matches 1.. run function catan:engine/setup/give {{resource:{r},hex:{h}}}' for h in VERTEX_HEXES[v] for r in range(5)]))
    put('setup/give', '''
        $scoreboard players add #r$(resource) ca_ctx 1
        $scoreboard players remove #bank$(resource) ca_ctx 1
        $data modify storage catan:engine state.last.production append value {owner:0,hex:$(hex),resource:$(resource),amount:1}
        execute store result storage catan:engine state.last.production[-1].owner int 1 run scoreboard players get #actor ca_ctx
    ''')
    put('setup/road',lines(guard('unless score #phase ca_ctx matches 2',4),guard('unless score #actor ca_ctx = #turn ca_ctx',4),guard('unless score #target ca_ctx matches 0..71',5),guard('unless score #roads_left ca_ctx matches 1..',7),
        'function catan:engine/legal/edge with storage catan:engine request',guard('unless score #valid ca_ctx matches 1',5),
        'function catan:engine/build/place_e with storage catan:engine request','scoreboard players add #setup_step ca_ctx 1',
        'execute store result storage catan:engine state.setup_step int 1 run scoreboard players get #setup_step ca_ctx',
        'scoreboard players operation #twon ca_ctx = #n ca_ctx','scoreboard players operation #twon ca_ctx *= #two ca_ctx',
        'execute if score #setup_step ca_ctx >= #twon ca_ctx run return run function catan:engine/setup/finish',
        'scoreboard players operation #turn ca_ctx = #setup_step ca_ctx',
        'execute if score #setup_step ca_ctx < #n ca_ctx run scoreboard players add #turn ca_ctx 1',
        'execute if score #setup_step ca_ctx >= #n ca_ctx run scoreboard players operation #turn ca_ctx = #twon ca_ctx',
        'execute if score #setup_step ca_ctx >= #n ca_ctx run scoreboard players operation #turn ca_ctx -= #setup_step ca_ctx',
        'execute store result storage catan:engine state.turn int 1 run scoreboard players get #turn ca_ctx',
        'data modify storage catan:engine state.phase set value 1','data modify storage catan:engine state.setup_vertex set value -1','scoreboard players set #ok ca_ctx 1'))
    put('setup/finish','data modify storage catan:engine state.turn set value 1\ndata modify storage catan:engine state.setup_vertex set value -1\nscoreboard players set #resume ca_ctx 3\nfunction catan:engine/job/start\nscoreboard players set #ok ca_ctx 1')
    put('build/road',lines(guard('unless score #phase ca_ctx matches 4 unless score #phase ca_ctx matches 8',4),guard('unless score #actor ca_ctx = #turn ca_ctx',4),guard('unless score #target ca_ctx matches 0..71',5),guard('unless score #roads_left ca_ctx matches 1..',7),
        'function catan:engine/legal/edge with storage catan:engine request',guard('unless score #valid ca_ctx matches 1',5),
        'scoreboard players set #valid ca_ctx 0','execute if score #phase ca_ctx matches 4 run function catan:engine/cost/road',
        'execute if score #phase ca_ctx matches 8 run scoreboard players set #valid ca_ctx 1',guard('unless score #valid ca_ctx matches 1',6),
        'function catan:engine/build/place_e with storage catan:engine request','scoreboard players set #resume ca_ctx 4',
        'execute if score #phase ca_ctx matches 8 run function catan:engine/development/road_placed','function catan:engine/job/start','scoreboard players set #ok ca_ctx 1'))
    put('build/settlement',lines(guard('unless score #phase ca_ctx matches 4',4),settlement_guard,
        'scoreboard players set #valid ca_ctx 0','function catan:engine/cost/settlement',guard('unless score #valid ca_ctx matches 1',6),
        'function catan:engine/build/place_v with storage catan:engine request','scoreboard players set #resume ca_ctx 4','function catan:engine/job/start','scoreboard players set #ok ca_ctx 1'))
    put('build/city',lines(guard('unless score #phase ca_ctx matches 4',4),guard('unless score #actor ca_ctx = #turn ca_ctx',4),guard('unless score #target ca_ctx matches 0..53',5),guard('unless score #cities_left ca_ctx matches 1..',7),
        'function catan:engine/build/check_city with storage catan:engine request',guard('unless score #valid ca_ctx matches 1',5),
        'scoreboard players set #valid ca_ctx 0','function catan:engine/cost/city',guard('unless score #valid ca_ctx matches 1',6),
        'function catan:engine/build/place_city with storage catan:engine request','scoreboard players set #ok ca_ctx 1'))
    put('build/check_city','scoreboard players set #valid ca_ctx 0\n$execute if score #vo$(target) ca_ctx = #actor ca_ctx if score #vl$(target) ca_ctx matches 1 run scoreboard players set #valid ca_ctx 1')
    put('build/place_city', '''
        $data modify storage catan:engine state.vertex_level[$(target)] set value 2
        scoreboard players add #settlements_left ca_ctx 1
        scoreboard players remove #cities_left ca_ctx 1
        $execute store result storage catan:engine state.p$(actor).settlements_left int 1 run scoreboard players get #settlements_left ca_ctx
        $execute store result storage catan:engine state.p$(actor).cities_left int 1 run scoreboard players get #cities_left ca_ctx
    ''')


def build_production():
    put('save_all_resources',lines([f'execute store result storage catan:engine state.p{p}.resources[{r}] int 1 run scoreboard players get #res{p}_{r} ca_ctx' for p in range(1,5) for r in range(5)]))
    put('roll',lines(guard('unless score #phase ca_ctx matches 3',4),guard('unless score #actor ca_ctx = #turn ca_ctx',4),
        'execute store result score #d1 ca_ctx run random value 1..6 catan:play','execute store result score #d2 ca_ctx run random value 1..6 catan:play',
        'function catan:engine/roll_result','scoreboard players set #ok ca_ctx 1'))
    put('roll_result',lines('execute store result storage catan:engine state.dice[0] int 1 run scoreboard players get #d1 ca_ctx',
        'execute store result storage catan:engine state.dice[1] int 1 run scoreboard players get #d2 ca_ctx',
        'scoreboard players operation #sum ca_ctx = #d1 ca_ctx','scoreboard players operation #sum ca_ctx += #d2 ca_ctx',
        'execute if score #sum ca_ctx matches 7 run return run function catan:engine/seven',
        'data modify storage catan:engine state.phase set value 4','function catan:engine/production'))
    put('production',lines([f'scoreboard players set #need{p}_{r} ca_ctx 0' for p in range(1,5) for r in range(5)],
        [f'execute if score #hn{h} ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches {h} run function catan:engine/production/demand_h{h}' for h in range(19)],
        [f'function catan:engine/production/grant {{resource:{r}}}' for r in range(5)],
        [f'execute if score #hn{h} ca_ctx = #sum ca_ctx unless score #robber ca_ctx matches {h} run function catan:engine/production/give_h{h}' for h in range(19)],
        'function catan:engine/save_all_resources','function catan:engine/save_bank'))
    for h in range(19):
        put(f'production/demand_h{h}',lines([f'execute if score #ht{h} ca_ctx matches {r} if score #vo{v} ca_ctx matches {p} run scoreboard players operation #need{p}_{r} ca_ctx += #vl{v} ca_ctx' for v in HEX_VERTICES[h] for p in range(1,5) for r in range(5)]))
        put(f'production/give_h{h}',lines([f'execute if score #ht{h} ca_ctx matches {r} if score #vo{v} ca_ctx matches {p} if score #grant{p}_{r} ca_ctx matches 1.. run function catan:engine/production/give {{owner:{p},resource:{r},hex:{h},vertex:{v}}}' for v in HEX_VERTICES[h] for p in range(1,5) for r in range(5)]))
    put('production/grant',lines('scoreboard players set #total ca_ctx 0','scoreboard players set #receivers ca_ctx 0',
        [f'$scoreboard players operation #total ca_ctx += #need{p}_$(resource) ca_ctx\n$execute if score #need{p}_$(resource) ca_ctx matches 1.. run scoreboard players add #receivers ca_ctx 1' for p in range(1,5)],
        [f'$scoreboard players set #grant{p}_$(resource) ca_ctx 0\n$execute if score #bank$(resource) ca_ctx >= #total ca_ctx run scoreboard players operation #grant{p}_$(resource) ca_ctx = #need{p}_$(resource) ca_ctx\n$execute if score #bank$(resource) ca_ctx < #total ca_ctx if score #receivers ca_ctx matches 1 if score #need{p}_$(resource) ca_ctx matches 1.. run scoreboard players operation #grant{p}_$(resource) ca_ctx = #bank$(resource) ca_ctx' for p in range(1,5)]))
    put('production/give', '''
        $scoreboard players operation #amount ca_ctx = #vl$(vertex) ca_ctx
        $scoreboard players operation #amount ca_ctx < #grant$(owner)_$(resource) ca_ctx
        $scoreboard players operation #res$(owner)_$(resource) ca_ctx += #amount ca_ctx
        $scoreboard players operation #grant$(owner)_$(resource) ca_ctx -= #amount ca_ctx
        $scoreboard players operation #bank$(resource) ca_ctx -= #amount ca_ctx
        $data modify storage catan:engine state.last.production append value {owner:$(owner),hex:$(hex),resource:$(resource),amount:0}
        execute store result storage catan:engine state.last.production[-1].amount int 1 run scoreboard players get #amount ca_ctx
    ''')
    put('seven',lines('data modify storage catan:engine state.phase set value 6','data modify storage catan:engine state.robber_return set value 4',
        'scoreboard players set #all_due ca_ctx 0',
        [lines(f'scoreboard players set #total ca_ctx 0',[f'scoreboard players operation #total ca_ctx += #res{p}_{r} ca_ctx' for r in range(5)],
            'scoreboard players set #due ca_ctx 0','execute if score #total ca_ctx matches 8.. run scoreboard players operation #due ca_ctx = #total ca_ctx',
            'scoreboard players operation #due ca_ctx /= #two ca_ctx',f'execute store result storage catan:engine state.p{p}.discard_due int 1 run scoreboard players get #due ca_ctx',
            'scoreboard players operation #all_due ca_ctx += #due ca_ctx') for p in range(1,5)],
        'execute if score #all_due ca_ctx matches 1.. run data modify storage catan:engine state.phase set value 5'))
    put('discard',lines(guard('unless score #phase ca_ctx matches 5',4),guard('unless score #discard_due ca_ctx matches 1..',11),
        'function catan:engine/read_offer','scoreboard players set #offer_total ca_ctx 0',
        [lines(guard(f'if score #offer{r} ca_ctx matches ..-1',8),guard(f'if score #offer{r} ca_ctx > #r{r} ca_ctx',6),f'scoreboard players operation #offer_total ca_ctx += #offer{r} ca_ctx') for r in range(5)],
        guard('unless score #offer_total ca_ctx = #discard_due ca_ctx',8),
        [f'scoreboard players operation #r{r} ca_ctx -= #offer{r} ca_ctx\nscoreboard players operation #bank{r} ca_ctx += #offer{r} ca_ctx' for r in range(5)],
        'function catan:engine/save_resources with storage catan:engine request','function catan:engine/save_bank',
        'function catan:engine/discard_done with storage catan:engine request','scoreboard players set #all_due ca_ctx 0',
        [f'execute store result score #due ca_ctx run data get storage catan:engine state.p{p}.discard_due\nscoreboard players operation #all_due ca_ctx += #due ca_ctx' for p in range(1,5)],
        'execute if score #all_due ca_ctx matches 0 run data modify storage catan:engine state.phase set value 6','scoreboard players set #ok ca_ctx 1'))
    put('discard_done','$data modify storage catan:engine state.p$(actor).discard_due set value 0')
    put('end_turn',lines(guard('unless score #phase ca_ctx matches 4',4),guard('unless score #actor ca_ctx = #turn ca_ctx',4),
        'data remove storage catan:engine state.trade','scoreboard players add #turn ca_ctx 1','execute if score #turn ca_ctx > #n ca_ctx run scoreboard players set #turn ca_ctx 1',
        'execute store result storage catan:engine state.turn int 1 run scoreboard players get #turn ca_ctx','data modify storage catan:engine state.phase set value 3',
        'data modify storage catan:engine state.used_dev set value 0','execute store result storage catan:engine tmp.actor int 1 run scoreboard players get #turn ca_ctx',
        'function catan:engine/age_cards with storage catan:engine tmp','scoreboard players set #ok ca_ctx 1'))
    put('age_cards',lines([f'$execute store result score #old ca_ctx run data get storage catan:engine state.p$(actor).dev[{r}]\n$execute store result score #new ca_ctx run data get storage catan:engine state.p$(actor).fresh[{r}]\nscoreboard players operation #old ca_ctx += #new ca_ctx\n$execute store result storage catan:engine state.p$(actor).dev[{r}] int 1 run scoreboard players get #old ca_ctx\n$data modify storage catan:engine state.p$(actor).fresh[{r}] set value 0' for r in range(5)]))


def build_robber():
    put('robber/scan',lines([f'scoreboard players set #victim{p} ca_ctx 0' for p in range(1,5)],'$function catan:engine/robber/hex$(hex)'))
    for h in range(19):
        put(f'robber/hex{h}',lines([f'execute unless score #actor ca_ctx matches {p} if score #n ca_ctx matches {p}.. if score #vo{v} ca_ctx matches {p} run scoreboard players set #victim{p} ca_ctx 1' for v in HEX_VERTICES[h] for p in range(1,5)]))
    put('robber/move',lines(guard('unless score #phase ca_ctx matches 6',4),guard('unless score #actor ca_ctx = #turn ca_ctx',4),guard('unless score #target ca_ctx matches 0..18',5),guard('if score #target ca_ctx = #robber ca_ctx',5),
        'data modify storage catan:engine state.robber set from storage catan:engine request.target','data modify storage catan:engine rng.hex set from storage catan:engine request.target',
        'function catan:engine/robber/scan with storage catan:engine rng','data modify storage catan:engine state.eligible set value []',
        [f'execute if score #victim{p} ca_ctx matches 1 run data modify storage catan:engine state.eligible append value {p}' for p in range(1,5)],
        'data modify storage catan:engine state.phase set value 7','execute unless data storage catan:engine state.eligible[0] run function catan:engine/robber/return','scoreboard players set #ok ca_ctx 1'))
    put('robber/return','data modify storage catan:engine state.phase set from storage catan:engine state.robber_return\ndata remove storage catan:engine state.eligible')
    put('robber/steal',lines(guard('unless score #phase ca_ctx matches 7',4),guard('unless score #actor ca_ctx = #turn ca_ctx',4),guard('unless score #target ca_ctx matches 1..4',5),guard('if score #target ca_ctx > #n ca_ctx',5),
        'data modify storage catan:engine rng.hex set from storage catan:engine state.robber','function catan:engine/robber/scan with storage catan:engine rng',
        'function catan:engine/robber/check_victim with storage catan:engine request',guard('unless score #valid ca_ctx matches 1',5),
        'function catan:engine/load_other with storage catan:engine request','scoreboard players set #total ca_ctx 0',
        [f'scoreboard players operation #total ca_ctx += #o{r} ca_ctx' for r in range(5)],
        'data modify storage catan:engine state.last.stolen set value 0','execute if score #total ca_ctx matches 1.. run function catan:engine/robber/draw',
        'function catan:engine/robber/return','scoreboard players set #ok ca_ctx 1'))
    put('robber/check_victim','scoreboard players set #valid ca_ctx 0\n$execute if score #victim$(target) ca_ctx matches 1 run scoreboard players set #valid ca_ctx 1')
    put('robber/draw',lines('scoreboard players operation #max ca_ctx = #total ca_ctx','scoreboard players remove #max ca_ctx 1',
        'execute store result storage catan:engine rng.max int 1 run scoreboard players get #max ca_ctx','function catan:engine/robber/random with storage catan:engine rng',
        'scoreboard players set #chosen ca_ctx -1',
        [f'execute if score #chosen ca_ctx matches -1 if score #draw ca_ctx < #o{r} ca_ctx run scoreboard players set #chosen ca_ctx {r}\nexecute if score #chosen ca_ctx matches -1 run scoreboard players operation #draw ca_ctx -= #o{r} ca_ctx' for r in range(5)],
        [f'execute if score #chosen ca_ctx matches {r} run scoreboard players remove #o{r} ca_ctx 1\nexecute if score #chosen ca_ctx matches {r} run scoreboard players add #r{r} ca_ctx 1' for r in range(5)],
        'function catan:engine/save_resources with storage catan:engine request','function catan:engine/save_other with storage catan:engine request','data modify storage catan:engine state.last.stolen set value 1'))
    put('robber/random','$execute store result score #draw ca_ctx run random value 0..$(max) catan:play')


def build_trade():
    put('read_offer',lines([f'scoreboard players set #offer{r} ca_ctx 0\nscoreboard players set #want{r} ca_ctx 0\nexecute store result score #offer{r} ca_ctx run data get storage catan:engine request.offer[{r}]\nexecute store result score #want{r} ca_ctx run data get storage catan:engine request.want[{r}]' for r in range(5)]))
    put('trade/offer',lines(guard('unless score #phase ca_ctx matches 4',4),guard('unless score #target ca_ctx matches 1..4',5),guard('if score #target ca_ctx > #n ca_ctx',5),guard('if score #target ca_ctx = #actor ca_ctx',5),
        guard('unless score #actor ca_ctx = #turn ca_ctx unless score #target ca_ctx = #turn ca_ctx',4),
        'function catan:engine/load_other with storage catan:engine request','function catan:engine/read_offer','scoreboard players set #offer_total ca_ctx 0','scoreboard players set #want_total ca_ctx 0',
        [lines(guard(f'unless score #offer{r} ca_ctx matches 0..19',8),guard(f'unless score #want{r} ca_ctx matches 0..19',8),
            guard(f'if score #offer{r} ca_ctx matches 1.. if score #want{r} ca_ctx matches 1..',8),
            guard(f'if score #offer{r} ca_ctx > #r{r} ca_ctx',6),
            f'scoreboard players operation #offer_total ca_ctx += #offer{r} ca_ctx',f'scoreboard players operation #want_total ca_ctx += #want{r} ca_ctx') for r in range(5)],
        guard('unless score #offer_total ca_ctx matches 1..',8),guard('unless score #want_total ca_ctx matches 1..',8),
        'data modify storage catan:engine state.trade set value {id:0,from:0,to:0,offer:[0,0,0,0,0],want:[0,0,0,0,0]}',
        'scoreboard players operation #trade_id ca_ctx = #epoch ca_ctx','scoreboard players add #trade_id ca_ctx 1',
        'execute store result storage catan:engine state.trade.id int 1 run scoreboard players get #trade_id ca_ctx',
        'execute store result storage catan:engine state.trade.from int 1 run scoreboard players get #actor ca_ctx',
        'execute store result storage catan:engine state.trade.to int 1 run scoreboard players get #target ca_ctx',
        'data modify storage catan:engine state.last.from set from storage catan:engine state.trade.from','data modify storage catan:engine state.last.to set from storage catan:engine state.trade.to',
        [f'execute store result storage catan:engine state.trade.offer[{r}] int 1 run scoreboard players get #offer{r} ca_ctx\nexecute store result storage catan:engine state.trade.want[{r}] int 1 run scoreboard players get #want{r} ca_ctx' for r in range(5)],
        'scoreboard players set #ok ca_ctx 1'))
    put('trade/read',lines('scoreboard players set #valid ca_ctx 0','execute unless data storage catan:engine state.trade run return 0',
        [f'execute store result score #trade_{field} ca_ctx run data get storage catan:engine state.trade.{field}' for field in ('id','from','to')],
        'execute unless score #target ca_ctx = #trade_id ca_ctx run return 0',
        'data modify storage catan:engine state.last.from set from storage catan:engine state.trade.from','data modify storage catan:engine state.last.to set from storage catan:engine state.trade.to',
        [f'execute store result score #offer{r} ca_ctx run data get storage catan:engine state.trade.offer[{r}]\nexecute store result score #want{r} ca_ctx run data get storage catan:engine state.trade.want[{r}]' for r in range(5)],
        'scoreboard players set #valid ca_ctx 1'))
    put('trade/accept',lines(guard('unless score #phase ca_ctx matches 4',4),'function catan:engine/trade/read',guard('unless score #valid ca_ctx matches 1',11),
        guard('unless score #actor ca_ctx = #trade_to ca_ctx',11),
        'execute store result storage catan:engine request.target int 1 run scoreboard players get #trade_from ca_ctx','function catan:engine/load_other with storage catan:engine request',
        [lines(guard(f'if score #offer{r} ca_ctx > #o{r} ca_ctx',6),guard(f'if score #want{r} ca_ctx > #r{r} ca_ctx',6)) for r in range(5)],
        [f'scoreboard players operation #r{r} ca_ctx += #offer{r} ca_ctx\nscoreboard players operation #r{r} ca_ctx -= #want{r} ca_ctx\nscoreboard players operation #o{r} ca_ctx += #want{r} ca_ctx\nscoreboard players operation #o{r} ca_ctx -= #offer{r} ca_ctx' for r in range(5)],
        'function catan:engine/save_resources with storage catan:engine request','function catan:engine/save_other with storage catan:engine request','data remove storage catan:engine state.trade','scoreboard players set #ok ca_ctx 1'))
    put('trade/reject',lines(guard('unless score #phase ca_ctx matches 4',4),'function catan:engine/trade/read',guard('unless score #valid ca_ctx matches 1',11),
        guard('unless score #actor ca_ctx = #trade_from ca_ctx unless score #actor ca_ctx = #trade_to ca_ctx',11),
        'data remove storage catan:engine state.trade','scoreboard players set #ok ca_ctx 1'))
    put('trade/bank',lines(guard('unless score #phase ca_ctx matches 4',4),guard('unless score #actor ca_ctx = #turn ca_ctx',4),guard('unless score #target ca_ctx matches 0..4',5),guard('unless score #a ca_ctx matches 0..4',5),guard('if score #target ca_ctx = #a ca_ctx',8),
        'execute if score #b ca_ctx matches -1 run scoreboard players set #b ca_ctx 1',guard('unless score #b ca_ctx matches 1..19',8),
        'scoreboard players set #ratio ca_ctx 4',
        [lines(f'execute store result score #port_type ca_ctx run data get storage catan:engine state.port_types[{p["id"]}]',
            [f'execute if score #vo{v} ca_ctx = #actor ca_ctx run function catan:engine/trade/port_ratio' for v in p['vertices']]) for p in PORTS],
        'function catan:engine/trade/bank_exchange with storage catan:engine request',guard('unless score #valid ca_ctx matches 1',6),
        'function catan:engine/save_resources with storage catan:engine request','function catan:engine/save_bank','scoreboard players set #ok ca_ctx 1'))
    put('trade/port_ratio','execute if score #port_type ca_ctx matches -1 if score #ratio ca_ctx matches 4 run scoreboard players set #ratio ca_ctx 3\nexecute if score #port_type ca_ctx = #target ca_ctx run scoreboard players set #ratio ca_ctx 2')
    put('trade/bank_exchange',lines('scoreboard players set #valid ca_ctx 0','scoreboard players operation #cost ca_ctx = #ratio ca_ctx','scoreboard players operation #cost ca_ctx *= #b ca_ctx',
        '$execute if score #r$(target) ca_ctx < #cost ca_ctx run return 0','$execute if score #bank$(a) ca_ctx < #b ca_ctx run return 0',
        '$scoreboard players operation #r$(target) ca_ctx -= #cost ca_ctx','$scoreboard players operation #bank$(target) ca_ctx += #cost ca_ctx',
        '$scoreboard players operation #r$(a) ca_ctx += #b ca_ctx','$scoreboard players operation #bank$(a) ca_ctx -= #b ca_ctx','scoreboard players set #valid ca_ctx 1'))


def build_development():
    put('development/buy',lines(guard('unless score #phase ca_ctx matches 4',4),guard('unless score #actor ca_ctx = #turn ca_ctx',4),guard('unless data storage catan:engine state.dev_deck[-1]',7),
        'scoreboard players set #valid ca_ctx 0','function catan:engine/cost/development',guard('unless score #valid ca_ctx matches 1',6),
        'execute store result storage catan:engine request.dev int 1 run data get storage catan:engine state.dev_deck[-1]',
        'data remove storage catan:engine state.dev_deck[-1]','function catan:engine/development/add_fresh with storage catan:engine request',
        'function catan:engine/save_dev with storage catan:engine request','scoreboard players set #ok ca_ctx 1'))
    put('development/add_fresh','$scoreboard players add #fresh$(dev) ca_ctx 1')
    put('development/play',lines(guard('unless score #phase ca_ctx matches 3..4',4),guard('unless score #actor ca_ctx = #turn ca_ctx',4),guard('unless score #target ca_ctx matches 0..4',5),
        'execute if score #target ca_ctx matches 4 run return run function catan:engine/development/vp with storage catan:engine request',
        guard('unless score #used_dev ca_ctx matches 0',10),
        'function catan:engine/development/take with storage catan:engine request',guard('unless score #valid ca_ctx matches 1',10),
        'data modify storage catan:engine state.used_dev set value 1','execute store result storage catan:engine state.dev_return int 1 run scoreboard players get #phase ca_ctx',
        'function catan:engine/save_dev with storage catan:engine request',
        [f'execute if score #target ca_ctx matches {kind} run return run function catan:engine/development/{name}' for kind,name in [(0,'knight'),(1,'roads'),(2,'monopoly'),(3,'invention')]],fail(10)))
    put('development/take', '''
        scoreboard players set #valid ca_ctx 0
        $execute unless score #dev$(target) ca_ctx matches 1.. run return 0
        $scoreboard players remove #dev$(target) ca_ctx 1
        $execute store result score #discarded ca_ctx run data get storage catan:engine state.dev_discard[$(target)]
        execute unless score #target ca_ctx matches 0 run scoreboard players add #discarded ca_ctx 1
        $execute store result storage catan:engine state.dev_discard[$(target)] int 1 run scoreboard players get #discarded ca_ctx
        scoreboard players set #valid ca_ctx 1
    ''')
    put('development/vp', '''
        $execute store result score #vp ca_ctx run data get storage catan:engine state.p$(actor).vp
        execute unless score #vp ca_ctx matches 10.. run return run function catan:engine/error {id:10}
        scoreboard players set #ok ca_ctx 1
    ''')
    put('development/knight','scoreboard players add #knights ca_ctx 1\nfunction catan:engine/development/save_knights with storage catan:engine request\ndata modify storage catan:engine state.robber_return set from storage catan:engine state.dev_return\ndata modify storage catan:engine state.phase set value 6\nscoreboard players set #ok ca_ctx 1')
    put('development/save_knights','$execute store result storage catan:engine state.p$(actor).knights int 1 run scoreboard players get #knights ca_ctx')
    put('development/roads',lines(guard('unless score #roads_left ca_ctx matches 1..',7),'data modify storage catan:engine state.phase set value 8',
        'data modify storage catan:engine state.free_left set value 2','execute if score #roads_left ca_ctx matches 1 run data modify storage catan:engine state.free_left set value 1','scoreboard players set #ok ca_ctx 1'))
    put('development/road_placed', '''
        execute store result score #free_left ca_ctx run data get storage catan:engine state.free_left
        scoreboard players remove #free_left ca_ctx 1
        execute store result storage catan:engine state.free_left int 1 run scoreboard players get #free_left ca_ctx
        execute store result score #resume ca_ctx run data get storage catan:engine state.dev_return
        execute if score #free_left ca_ctx matches 1.. if score #roads_left ca_ctx matches 1.. run scoreboard players set #resume ca_ctx 8
    ''')
    put('development/finish_roads',lines(guard('unless score #phase ca_ctx matches 8',4),guard('unless score #actor ca_ctx = #turn ca_ctx',4),
        'data modify storage catan:engine state.free_left set value 0','data modify storage catan:engine state.phase set from storage catan:engine state.dev_return','scoreboard players set #ok ca_ctx 1'))
    put('development/monopoly',lines(guard('unless score #a ca_ctx matches 0..4',5),
        'function catan:engine/development/monopoly_take with storage catan:engine request','function catan:engine/save_resources with storage catan:engine request','scoreboard players set #ok ca_ctx 1'))
    put('development/monopoly_take',lines([f'$execute unless score #actor ca_ctx matches {p} run scoreboard players operation #r$(a) ca_ctx += #res{p}_$(a) ca_ctx\n$execute unless score #actor ca_ctx matches {p} run data modify storage catan:engine state.p{p}.resources[$(a)] set value 0' for p in range(1,5)]))
    put('development/invention',lines(guard('unless score #a ca_ctx matches 0..4',5),guard('unless score #b ca_ctx matches 0..4',5),
        'function catan:engine/development/invention_take with storage catan:engine request',guard('unless score #valid ca_ctx matches 1',6),
        'function catan:engine/save_resources with storage catan:engine request','function catan:engine/save_bank','scoreboard players set #ok ca_ctx 1'))
    put('development/invention_take', '''
        scoreboard players set #valid ca_ctx 0
        $execute unless score #bank$(a) ca_ctx matches 1.. run return 0
        $execute unless score #bank$(b) ca_ctx matches 1.. run return 0
        $execute if score #a ca_ctx = #b ca_ctx unless score #bank$(a) ca_ctx matches 2.. run return 0
        $scoreboard players remove #bank$(a) ca_ctx 1
        $scoreboard players remove #bank$(b) ca_ctx 1
        $scoreboard players add #r$(a) ca_ctx 1
        $scoreboard players add #r$(b) ca_ctx 1
        scoreboard players set #valid ca_ctx 1
    ''')


def build_job():
    put('job/start', '''
        data modify storage catan:engine state.job set value {player:1,best:0,bits:[],stack:[],resume:4}
        execute store result storage catan:engine state.job.resume int 1 run scoreboard players get #resume ca_ctx
        data modify storage catan:engine state.phase set value 10
        function catan:engine/cache
        function catan:engine/job/prepare
    ''')
    put('job/prepare',lines('execute store result score #jp ca_ctx run data get storage catan:engine state.job.player',
        'data modify storage catan:engine state.job.best set value 0','data modify storage catan:engine state.job.bits set value '+snbt([0]*72),
        'data modify storage catan:engine state.job.stack set value []','scoreboard players set #nextbit ca_ctx 1',
        [f'execute if score #eo{e} ca_ctx = #jp ca_ctx run function catan:engine/job/set_bit {{edge:{e}}}' for e in range(72)],
        [lines('scoreboard players set #connected ca_ctx 0',[f'execute if score #eo{e} ca_ctx = #jp ca_ctx run scoreboard players set #connected ca_ctx 1' for e in VERTEX_EDGES[v]],
            f'execute if score #connected ca_ctx matches 1 run data modify storage catan:engine state.job.stack append value {{vertex:{v},mask:0,length:0}}') for v in range(54)]))
    put('job/set_bit','$execute store result storage catan:engine state.job.bits[$(edge)] int 1 run scoreboard players get #nextbit ca_ctx\nscoreboard players operation #nextbit ca_ctx *= #two ca_ctx')
    put('tick',lines('scoreboard players set #changed ca_ctx 0','execute unless data entity @s data.catan{phase:10} run return 0',
        'function catan:engine/context',
        ['execute if data storage catan:engine state.job.stack[-1] run function catan:engine/job/step' for _ in range(64)],
        'execute unless data storage catan:engine state.job.stack[-1] run function catan:engine/job/advance',
        'execute unless score #changed ca_ctx matches 1 run data modify entity @s data.catan set from storage catan:engine state',
        'execute if score #changed ca_ctx matches 1 run function catan:engine/commit','return run scoreboard players get #changed ca_ctx'))
    put('job/step', '''
        data modify storage catan:engine node set from storage catan:engine state.job.stack[-1]
        data remove storage catan:engine state.job.stack[-1]
        execute store result score #node_v ca_ctx run data get storage catan:engine node.vertex
        execute store result score #node_mask ca_ctx run data get storage catan:engine node.mask
        execute store result score #node_length ca_ctx run data get storage catan:engine node.length
        execute store result score #best ca_ctx run data get storage catan:engine state.job.best
        execute store result score #jp ca_ctx run data get storage catan:engine state.job.player
        execute if score #node_length ca_ctx > #best ca_ctx store result storage catan:engine state.job.best int 1 run scoreboard players get #node_length ca_ctx
        function catan:engine/job/route with storage catan:engine node
    ''')
    put('job/route', '''
        $execute if score #node_length ca_ctx matches 1.. unless score #vo$(vertex) ca_ctx matches 0 unless score #vo$(vertex) ca_ctx = #jp ca_ctx run return 0
        execute if score #node_length ca_ctx matches 15.. run return 0
        $function catan:engine/job/expand_v$(vertex)
    ''')
    for v in range(54):
        put(f'job/expand_v{v}',lines([lines(f'execute store result score #bit ca_ctx run data get storage catan:engine state.job.bits[{e}]',
            f'execute if score #bit ca_ctx matches 1.. run function catan:engine/job/edge {{to:{EDGES[e][1] if EDGES[e][0]==v else EDGES[e][0]}}}') for e in VERTEX_EDGES[v]]))
    put('job/edge', '''
        scoreboard players operation #used ca_ctx = #node_mask ca_ctx
        scoreboard players operation #used ca_ctx /= #bit ca_ctx
        scoreboard players operation #used ca_ctx %= #two ca_ctx
        execute if score #used ca_ctx matches 1 run return 0
        scoreboard players operation #newmask ca_ctx = #node_mask ca_ctx
        scoreboard players operation #newmask ca_ctx += #bit ca_ctx
        scoreboard players operation #newlength ca_ctx = #node_length ca_ctx
        scoreboard players add #newlength ca_ctx 1
        $data modify storage catan:engine state.job.stack append value {vertex:$(to),mask:0,length:0}
        execute store result storage catan:engine state.job.stack[-1].mask int 1 run scoreboard players get #newmask ca_ctx
        execute store result storage catan:engine state.job.stack[-1].length int 1 run scoreboard players get #newlength ca_ctx
    ''')
    put('job/advance', '''
        data modify storage catan:engine tmp set from storage catan:engine state.job
        function catan:engine/job/save_length with storage catan:engine tmp
        execute store result score #jp ca_ctx run data get storage catan:engine state.job.player
        scoreboard players add #jp ca_ctx 1
        execute store result storage catan:engine state.job.player int 1 run scoreboard players get #jp ca_ctx
        execute if score #jp ca_ctx <= #n ca_ctx run return run function catan:engine/job/prepare
        function catan:engine/job/finish
    ''')
    put('job/save_length','$data modify storage catan:engine state.p$(player).road_length set value $(best)')
    put('job/finish',lines('data modify storage catan:engine state.phase set from storage catan:engine state.job.resume','data remove storage catan:engine state.job',
        'scoreboard players set #max_metric ca_ctx 4','scoreboard players set #metric_count ca_ctx 0','scoreboard players set #best_owner ca_ctx 0',
        [f'execute store result score #metric{p} ca_ctx run data get storage catan:engine state.p{p}.road_length' for p in range(1,5)],
        [f'execute if score #n ca_ctx matches {p}.. run function catan:engine/award/consider {{player:{p}}}' for p in range(1,5)],
        'scoreboard players operation #old_owner ca_ctx = #longest ca_ctx','function catan:engine/award/resolve',
        'execute store result storage catan:engine state.longest int 1 run scoreboard players get #new_owner ca_ctx',
        'data modify storage catan:engine state.last set value {code:90,actor:0,target:-1,a:-1,b:-1,production:[]}',
        'execute store result storage catan:engine state.last.actor int 1 run scoreboard players get #turn ca_ctx','scoreboard players set #changed ca_ctx 1'))
    put('award/consider', '''
        $execute if score #metric$(player) ca_ctx > #max_metric ca_ctx run return run function catan:engine/award/higher {player:$(player)}
        $execute if score #metric$(player) ca_ctx = #max_metric ca_ctx run scoreboard players add #metric_count ca_ctx 1
    ''')
    put('award/higher', '''
        $scoreboard players operation #max_metric ca_ctx = #metric$(player) ca_ctx
        $scoreboard players set #best_owner ca_ctx $(player)
        scoreboard players set #metric_count ca_ctx 1
    ''')
    put('award/resolve', '''
        scoreboard players set #new_owner ca_ctx 0
        execute if score #best_owner ca_ctx matches 1.. if score #metric_count ca_ctx matches 1 run scoreboard players operation #new_owner ca_ctx = #best_owner ca_ctx
        execute store result storage catan:engine tmp.owner int 1 run scoreboard players get #old_owner ca_ctx
        execute if score #best_owner ca_ctx matches 1.. if score #old_owner ca_ctx matches 1..4 run function catan:engine/award/keep with storage catan:engine tmp
    ''')
    put('award/keep','$execute if score #metric$(owner) ca_ctx = #max_metric ca_ctx run scoreboard players operation #new_owner ca_ctx = #old_owner ca_ctx')


def build_stats():
    put('stats',lines('scoreboard players set #max_metric ca_ctx 2','scoreboard players set #metric_count ca_ctx 0','scoreboard players set #best_owner ca_ctx 0',
        [f'execute store result score #metric{p} ca_ctx run data get storage catan:engine state.p{p}.knights' for p in range(1,5)],
        [f'execute if score #n ca_ctx matches {p}.. run function catan:engine/award/consider {{player:{p}}}' for p in range(1,5)],
        'scoreboard players operation #old_owner ca_ctx = #army ca_ctx','function catan:engine/award/resolve',
        'scoreboard players operation #army ca_ctx = #new_owner ca_ctx','execute store result storage catan:engine state.army int 1 run scoreboard players get #army ca_ctx',
        [f'execute if score #n ca_ctx matches {p}.. run function catan:engine/stats_p{p}' for p in range(1,5)]))
    for p in range(1,5):
        put(f'stats_p{p}',lines('scoreboard players set #public ca_ctx 0','scoreboard players set #resource_count ca_ctx 0','scoreboard players set #dev_count ca_ctx 0',
            [f'execute if score #vo{v} ca_ctx matches {p} run scoreboard players operation #public ca_ctx += #vl{v} ca_ctx' for v in range(54)],
            f'execute if score #longest ca_ctx matches {p} run scoreboard players add #public ca_ctx 2',f'execute if score #army ca_ctx matches {p} run scoreboard players add #public ca_ctx 2',
            [f'scoreboard players operation #resource_count ca_ctx += #res{p}_{r} ca_ctx' for r in range(5)],
            [f'execute store result score #old ca_ctx run data get storage catan:engine state.p{p}.dev[{r}]\nexecute store result score #new ca_ctx run data get storage catan:engine state.p{p}.fresh[{r}]\nscoreboard players operation #dev_count ca_ctx += #old ca_ctx\nscoreboard players operation #dev_count ca_ctx += #new ca_ctx' for r in range(5)],
            'scoreboard players operation #vp ca_ctx = #public ca_ctx','scoreboard players operation #vp ca_ctx += #old ca_ctx','scoreboard players operation #vp ca_ctx += #new ca_ctx',
            f'execute store result storage catan:engine state.p{p}.public_vp int 1 run scoreboard players get #public ca_ctx',f'execute store result storage catan:engine state.p{p}.vp int 1 run scoreboard players get #vp ca_ctx',
            f'execute store result storage catan:engine state.p{p}.resource_count int 1 run scoreboard players get #resource_count ca_ctx',f'execute store result storage catan:engine state.p{p}.dev_count int 1 run scoreboard players get #dev_count ca_ctx',
            f'execute if score #turn ca_ctx matches {p} if score #vp ca_ctx matches 10.. if score #phase ca_ctx matches 3..9 run function catan:engine/win {{player:{p}}}'))
    put('win','$data modify storage catan:engine state.winner set value $(player)\ndata modify storage catan:engine state.phase set value 11\ndata remove storage catan:engine state.trade\ndata remove storage catan:engine state.eligible')


if __name__=='__main__':
    build()
