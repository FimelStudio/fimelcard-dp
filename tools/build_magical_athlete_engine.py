# -*- coding: utf-8 -*-
"""Generate the native, transactional Magical Athlete rules and bounded event queue.

Rules: CMYK 36-racer edition, with August 2026 simultaneous-arrival clarification.
Only factual game rules are transcribed; no publisher artwork/code is incorporated.
"""
from pathlib import Path
from textwrap import dedent
import json
from build_table_pause_guards import write_guarded

PACK=Path(__file__).resolve().parents[1]
ROOT=PACK/'data/magical_athlete/function/engine'
CHARS=json.loads((PACK/'tools/magical_athlete_characters.json').read_text(encoding='utf-8'))
TRACK=json.loads((PACK/'tools/magical_athlete_track.json').read_text(encoding='utf-8'))
NS='magical_athlete'
S='storage magical_athlete:engine'
O='ma_ctx'

def js(v): return json.dumps(v,ensure_ascii=False,separators=(',',':'))
def fn(n): return 'function '+NS+':engine/'+n
def put(n,b):
    p=ROOT/(n+'.mcfunction');p.parent.mkdir(parents=True,exist_ok=True)
    if isinstance(b,list):b='\n'.join(b)
    lines=dedent(b).strip().splitlines()
    # Mojang rejects a macro-prefixed line which contains no substitutions.
    lines=[line[1:] if line.startswith('$') and '$(' not in line else line for line in lines]
    write_guarded(p,'\n'.join(lines)+'\n',encoding='utf-8')
def get(score,path):return f'execute store result score #{score} {O} run data get {S} s.{path}'
def save(path,score):return f'execute store result {S} s.{path} int 1 run scoreboard players get #{score} {O}'
def err(n):return f'return run {fn("error")} {{id:{n}}}'
def reject(cond,n):return 'execute '+cond+' run '+err(n)
def queue(t,**kw):return f'data modify {S} s.queue append value '+js(dict(type=t,**kw))
def front(t,**kw):return f'data modify {S} s.queue prepend value '+js(dict(type=t,**kw))
def event(k,p=0,fr=0,to=0,source=-2,amount=0,die=0):return f'data modify {S} s.events append value '+js(dict(kind=k,pawn=p,**{'from':fr},to=to,source=source,amount=amount,die=die))

def build():
    put('install',['scoreboard objectives add ma_ctx dummy','data modify storage magical_athlete:rules characters set value '+js(CHARS),'data modify storage magical_athlete:rules track set value '+js(TRACK)])
    put('error','$scoreboard players set #error ma_ctx $(id)\nscoreboard players set #ok ma_ctx 0\nreturn 0')
    player=dict(hand=[],selected=[],points=0,race_points=0)
    racer=dict(owner=0,char=-1,power=-1,copy=-1,pos=0,trip=0,status=2,first=1,prediction=-1,done=0)
    state=dict(version=1,n=0,phase=1,epoch=1,round=1,track=0,turn=1,pawn=-1,active=-1,start_pos=0,next_override=-1,extra=-1,forced=-1,dice=0,rerolls=0,merchant=0,prediction=0,bomb=0,skip=0,pre_done=0,draft_mode=0,track_mode=0,draft_batch=1,draft_at=0,draft_first=1,draft_order=[],pool=[],deck=[],racers=[racer.copy() for _ in range(6)],pending=dict(kind='',owner=0,pawn=-1,options=[]),queue=[],events=[],seen=[],finishers=[],history=[],eliminated=[],winners=[],ticks=0,loop=0)
    state['copy_locks']=[0]*6
    state.update({'p'+str(i):player.copy() for i in range(1,7)})
    put('init',[reject('unless score #players ma_ctx matches 2..6',2),'data modify '+S+' s set value '+js(state),save('n','players'),'scoreboard players set #draft ma_ctx 0','scoreboard players set #track ma_ctx 0','execute store result score #draft ma_ctx run scoreboard players get @s ma_draft','execute store result score #track ma_ctx run scoreboard players get @s ma_track',save('draft_mode','draft'),save('track_mode','track'),fn('shuffle'),fn('rolloff'),save('draft_first','winner'),fn('draft/init'),fn('commit')])
    put('shuffle',['data modify '+S+' bag set value '+js(list(range(36)))]+[fn('shuffle_one')+f' {{max:{i}}}' for i in range(35,-1,-1)])
    put('shuffle_one',f'$execute store result {S} pick.index int 1 run random value 0..$(max)\n'+fn('shuffle_pick')+' with storage magical_athlete:engine pick')
    put('shuffle_pick',f'$data modify {S} s.deck append from {S} bag[$(index)]\n$data remove {S} bag[$(index)]')
    roll=['scoreboard players set #winner ma_ctx 0']
    for p in range(1,7):roll+=[f'scoreboard players set #r{p} ma_ctx 0',f'execute if score #players ma_ctx matches {p}.. run execute store result score #r{p} ma_ctx run random value 1..6']
    for d in range(6,0,-1):
        roll+=['scoreboard players set #ties ma_ctx 0']+[f'execute if score #r{p} ma_ctx matches {d} run scoreboard players add #ties ma_ctx 1' for p in range(1,7)]
        for p in range(1,7):roll +=[f'execute if score #winner ma_ctx matches 0 if score #ties ma_ctx matches 1 if score #r{p} ma_ctx matches {d} run scoreboard players set #winner ma_ctx {p}']
    roll+=['execute if score #winner ma_ctx matches 0 run '+fn('rolloff')]
    put('rolloff',roll)
    put('context',[f'data modify {S} s set from entity @s data.magical_athlete',fn('cache')])
    put('cache',[get(k,k) for k in ('n','phase','epoch','round','turn','pawn','active','track')]+['scoreboard players operation #players ma_ctx = #n ma_ctx'])
    put('commit',[f'data modify entity @s data.magical_athlete set from {S} s','scoreboard players set #ok ma_ctx 1','scoreboard players set #error ma_ctx 0'])
    action=['scoreboard players set #ok ma_ctx 0',reject('if score @s ct_paused matches 1',13),reject('unless data entity @s data.magical_athlete{version:1}',1),fn('context'),f'data modify {S} request set value {{actor:0,code:0,target:-1,epoch:-1}}',f'data modify {S} request merge from storage magical_athlete:action input',f'data modify {S} normalized set from {S} request']
    for k in ('actor','code','target','epoch'):
        sc='given_epoch' if k=='epoch' else k
        action +=[f'scoreboard players set #{sc} ma_ctx -999',f'execute store result score #{sc} ma_ctx run data get {S} request.{k}',f'execute store result {S} normalized.{k} int 1 run scoreboard players get #{sc} ma_ctx']
    action +=[f'execute store success score #different ma_ctx run data modify {S} normalized set from {S} request',reject('if score #different ma_ctx matches 1',10),reject('unless score #actor ma_ctx matches 1..6',2),reject('if score #actor ma_ctx > #n ma_ctx',2),reject('unless score #given_epoch ma_ctx = #epoch ma_ctx',3),reject('if score #phase ma_ctx matches 5',5),f'data modify {S} s.events set value []',f'data modify {S} s.seen set value []','scoreboard players set #ok ma_ctx 0',fn('dispatch'),'execute unless score #ok ma_ctx matches 1 run return 0',fn('drain'),fn('advance_epoch'),fn('commit')]
    put('action',action)
    put('dispatch',[f'execute if score #code ma_ctx matches {c} run return run {fn(path)}' for c,path in [(1,'draft/pick'),(2,'lineup/pick'),(3,'turn/start'),(4,'choice'),(5,'next_race')]]+[err(9)])
    put('advance_epoch',[get('epoch','epoch'),'scoreboard players add #epoch ma_ctx 1',save('epoch','epoch')])
    put('pump',[reject('if score @s ct_paused matches 1',13),fn('context'),f'execute if data {S} s.pending.options[0] run return 0',f'execute unless data {S} s.queue[0] run return 0',f'data modify {S} s.events set value []',fn('drain'),fn('advance_epoch'),fn('commit')])
    put('drain',['scoreboard players set #budget ma_ctx 12',fn('drain_loop')])
    put('drain_loop',[f'execute if data {S} s.pending.options[0] run return 0',f'execute unless data {S} s.queue[0] run return 0','execute unless score #budget ma_ctx matches 1.. run return 0','scoreboard players remove #budget ma_ctx 1',f'data modify {S} job set from {S} s.queue[0]',f'data remove {S} s.queue[0]',fn('cache'),fn('powers'),fn('job_dispatch'),f'execute if data {S} s.pending.options[0] run return 0',f'execute if data {S} s.queue[0] run {fn("drain_loop")}'])
    types=['begin','pre','roll','roll_done','main','move','land','power','turn_end','advance','prerace','finish','warp','trip','points','duel','cheer','party','swap','follow','postmove','react']
    put('job_dispatch',[f'execute if data {S} job{{type:"{t}"}} run return run {fn("jobs/"+t)} with storage magical_athlete:engine job' for t in types])
    build_draft();build_lineup();build_choices();build_turn();build_movement();build_reactions();build_race();build_refinements()
    print('Generated Magical Athlete engine',len(list(ROOT.rglob('*.mcfunction'))))

def build_draft():
    put('draft/init',[get('n','n'),f'data modify {S} s.pool set value []',f'data modify {S} s.draft_order set value []','scoreboard players set #count ma_ctx 0','scoreboard players operation #count ma_ctx = #n ma_ctx','scoreboard players operation #count ma_ctx += #n ma_ctx','execute if score #n ma_ctx matches 2 run scoreboard players set #count ma_ctx 8',fn('draft/deal'),get('first','draft_first'),get('batch','draft_batch'),'execute if score #batch ma_ctx matches 2 run scoreboard players add #first ma_ctx 1','execute if score #first ma_ctx > #n ma_ctx run scoreboard players set #first ma_ctx 1',fn('draft/order'),f'data modify {S} s.draft_at set value 0',f'data modify {S} s.turn set from {S} s.draft_order[0]',get('draft','draft_mode'),'execute if score #draft ma_ctx matches 1 run '+fn('draft/random')])
    put('draft/deal',['execute unless score #count ma_ctx matches 1.. run return 0',f'data modify {S} s.pool append from {S} s.deck[0]',f'data remove {S} s.deck[0]','scoreboard players remove #count ma_ctx 1',fn('draft/deal')])
    order=[]
    for n in range(2,7):
        for first in range(1,n+1):
            clockwise=list(range(first,n+1))+list(range(1,first));a=clockwise+clockwise[::-1]
            if n==2:a=a+a
            order +=[f'execute if score #n ma_ctx matches {n} if score #first ma_ctx matches {first} run data modify {S} s.draft_order set value {js(a)}']
    put('draft/order',order)
    put('draft/pick',[reject('unless score #phase ma_ctx matches 1',5),reject('unless score #actor ma_ctx = #turn ma_ctx',4),reject('unless score #target ma_ctx matches 0..35',8),f'data modify {S} probe set value {{id:0}}',f'execute store result {S} probe.id int 1 run scoreboard players get #target ma_ctx',fn('draft/has')+' with storage magical_athlete:engine request',reject('unless score #found ma_ctx matches 1',8),fn('draft/advance'),'scoreboard players set #ok ma_ctx 1'])
    put('draft/has',[f'$execute unless data {S} s.pool[$(target)] run {fn("draft/find")} with storage magical_athlete:engine request',f'$execute unless data {S} s.pool[$(target)] run return 0'])
    # Selection is by character ID, not its changing position in the market.
    put('draft/has',fn('draft/find')+' with storage magical_athlete:engine request\nexecute unless score #found ma_ctx matches 1 run '+err(8))
    find=['scoreboard players set #found ma_ctx 0']
    for i in range(12):find +=['scoreboard players set #id ma_ctx -999',f'$execute if data {S} s.pool[{i}] run execute store result score #id ma_ctx run data get {S} s.pool[{i}]',f'execute if score #id ma_ctx = #target ma_ctx unless score #found ma_ctx matches 1 run '+fn('draft/take')+f' {{slot:{i}}}']
    put('draft/find',find)
    put('draft/take',[f'$data modify {S} chosen set from {S} s.pool[$(slot)]',f'$data remove {S} s.pool[$(slot)]',fn('draft/add')+' with storage magical_athlete:engine request','scoreboard players set #found ma_ctx 1'])
    put('draft/add',f'$data modify {S} s.p$(actor).hand append from {S} chosen')
    put('draft/advance',[get('at','draft_at'),'scoreboard players add #at ma_ctx 1',save('draft_at','at'),f'execute store result {S} index.at int 1 run scoreboard players get #at ma_ctx',fn('draft/turn')+' with storage magical_athlete:engine index',f'execute if data {S} s.pool[0] run return 0',get('batch','draft_batch'),f'execute if score #batch ma_ctx matches 1 run data modify {S} s.draft_batch set value 2',f'execute if score #batch ma_ctx matches 1 run return run {fn("draft/init")}',f'data modify {S} s.phase set value 2',fn('rolloff'),save('turn','winner')])
    put('draft/turn',f'$execute if data {S} s.draft_order[$(at)] run data modify {S} s.turn set from {S} s.draft_order[$(at)]')
    put('draft/random',[f'execute unless data {S} s.pool[0] run return 0',fn('cache'),f'data modify {S} request.actor set from {S} s.turn',f'data modify {S} chosen set from {S} s.pool[0]',f'data remove {S} s.pool[0]',fn('draft/add')+' with storage magical_athlete:engine request',fn('draft/advance'),f'execute if data {S} s{{phase:1}} if data {S} s.pool[0] run {fn("draft/random")}'])

def build_lineup():
    body=[reject('unless score #phase ma_ctx matches 2',5),reject('unless score #target ma_ctx matches 0..35',8),'scoreboard players set #found ma_ctx 0',fn('lineup/find')+' with storage magical_athlete:engine request',reject('unless score #found ma_ctx matches 1',8),'scoreboard players set #ready ma_ctx 0']
    for p in range(1,7):body +=[f'execute if score #n ma_ctx matches {p}.. run execute store result score #len ma_ctx run data get {S} s.p{p}.selected',f'execute if score #n ma_ctx matches 2 if score #n ma_ctx matches {p}.. if score #len ma_ctx matches 2 run scoreboard players add #ready ma_ctx 1',f'execute if score #n ma_ctx matches 3.. if score #n ma_ctx matches {p}.. if score #len ma_ctx matches 1 run scoreboard players add #ready ma_ctx 1']
    body +=['execute if score #ready ma_ctx = #n ma_ctx run '+fn('lineup/reveal'),'scoreboard players set #ok ma_ctx 1']
    put('lineup/pick',body)
    find=[f'$execute store result score #len ma_ctx run data get {S} s.p$(actor).selected',reject('if score #n ma_ctx matches 2 if score #len ma_ctx matches 2..',6),reject('if score #n ma_ctx matches 3.. if score #len ma_ctx matches 1..',6)]
    for i in range(8):find +=['scoreboard players set #id ma_ctx -999',f'$execute if data {S} s.p$(actor).hand[{i}] run execute store result score #id ma_ctx run data get {S} s.p$(actor).hand[{i}]',f'execute if score #id ma_ctx = #target ma_ctx unless score #found ma_ctx matches 1 run '+fn('lineup/take')+f' {{slot:{i}}}']
    put('lineup/find',find)
    put('lineup/take',[f'execute store result {S} request.slot int 1 run data get {S} job.slot' if False else '$data modify storage magical_athlete:engine request.slot set value $(slot)',fn('lineup/add')+' with storage magical_athlete:engine request','scoreboard players set #found ma_ctx 1'])
    put('lineup/add',[f'$data modify {S} s.p$(actor).selected append from {S} s.p$(actor).hand[$(slot)]',f'$data remove {S} s.p$(actor).hand[$(slot)]'])
    reveal=[f'data modify {S} s.phase set value 3',f'data modify {S} s.queue set value []',f'data modify {S} s.finishers set value []',f'data modify {S} s.eliminated set value []',f'data modify {S} s.seen set value []',f'data modify {S} s.active set value -1',f'data modify {S} s.pawn set value -1',f'data modify {S} s.forced set value -1',f'data modify {S} s.next_override set value -1',f'data modify {S} s.extra set value -1']
    for p in range(1,7):reveal +=[f'data modify {S} s.p{p}.race_points set value 0']
    for i in range(6):
        racer=dict(owner=i+1,char=-1,power=-1,copy=-1,pos=0,trip=0,status=2,first=1,prediction=-1,done=0)
        reveal +=[f'data modify {S} s.racers[{i}] set value '+js(racer),f'execute if score #n ma_ctx matches 3.. if score #n ma_ctx matches {i+1}.. run data modify {S} s.racers[{i}].status set value 0',f'execute if score #n ma_ctx matches 3.. if score #n ma_ctx matches {i+1}.. run data modify {S} s.racers[{i}].char set from {S} s.p{i+1}.selected[0]']
        if i<4:reveal +=[f'execute if score #n ma_ctx matches 2 run data modify {S} s.racers[{i}].owner set value {i//2+1}',f'execute if score #n ma_ctx matches 2 run data modify {S} s.racers[{i}].status set value 0',f'execute if score #n ma_ctx matches 2 run data modify {S} s.racers[{i}].char set from {S} s.p{i//2+1}.selected[{i%2}]']
        reveal +=[f'data modify {S} s.racers[{i}].power set from {S} s.racers[{i}].char',queue('prerace',pawn=i)]
    put('lineup/reveal',reveal)

def pending(kind,owner='owner',pawn='i',options=None):
    out=[f'data modify {S} s.pending set value '+js(dict(kind=kind,owner=0,pawn=-1,options=options or []))]
    out +=[save('pending.owner',owner),save('pending.pawn',pawn)]
    return out

def build_choices():
    put('choice',[f'execute unless data {S} s.pending.options[0] run '+err(5),get('owner','pending.owner'),reject('unless score #actor ma_ctx = #owner ma_ctx',4),f'data modify {S} check.target set from {S} request.target',fn('choice_valid')+' with storage magical_athlete:engine check',reject('unless score #found ma_ctx matches 1',8),f'data modify {S} choice set from {S} s.pending',f'data modify {S} s.pending set value {{kind:"",owner:0,pawn:-1,options:[]}}',fn('choice_dispatch')+' with storage magical_athlete:engine choice','scoreboard players set #ok ma_ctx 1'])
    put('choice_valid',[f'$execute store success score #found ma_ctx if data {S} s.pending.options[$(target)]' if False else f'$execute store success score #found ma_ctx if data {S} s.pending{{options:[$(target)]}}'])
    kinds=['cheerleader','hypnotist','flip','genius','legs','mastermind','thirdwheel','egg','twin','alchemist','rocket','reroll','duel','suckerfish','copycat']
    put('choice_dispatch',[f'$execute if data {S} choice{{kind:"{k}"}} run return run {fn("choices/"+k)} with storage magical_athlete:engine choice' for k in kinds])
    put('choices/egg',fn('choices/replace')+' with storage magical_athlete:engine choice')
    put('choices/twin',['execute if score #target ma_ctx matches -1 run return 1',fn('choices/replace')+' with storage magical_athlete:engine choice'])
    put('choices/replace',[f'$data modify {S} s.racers[$(pawn)].power set from {S} request.target',f'$data modify {S} job set value {{type:"prerace",pawn:$(pawn),inherited:1}}',fn('powers'),fn('jobs/prerace')+' with storage magical_athlete:engine job'])
    put('choices/genius',[save('prediction','target'),queue('roll')])
    put('choices/legs',['execute if score #target ma_ctx matches 0 run '+queue('roll'),f'execute if score #target ma_ctx matches 1 run data modify {S} s.dice set value 0',f'execute if score #target ma_ctx matches 1 run data modify {S} s.distance set value 5','execute if score #target ma_ctx matches 1 run '+queue('main')])
    put('choices/mastermind',[f'$data modify {S} s.racers[$(pawn)].prediction set from {S} request.target',queue('pre')])
    put('choices/cheerleader',['execute if score #target ma_ctx matches 1 run '+front('cheer'),queue('roll')])
    put('choices/hypnotist',['execute if score #target ma_ctx matches 0..5 run '+fn('choices/pull')+' with storage magical_athlete:engine choice',queue('roll')])
    put('choices/pull',[f'$data modify {S} append set value {{type:"warp",pawn:0,to:0,source:17}}',f'data modify {S} append.pawn set from {S} request.target',f'$data modify {S} append.to set from {S} s.racers[$(pawn)].pos',f'data modify {S} s.queue prepend from {S} append'])
    put('choices/flip',['execute if score #target ma_ctx matches -1 run '+queue('roll'),'execute if score #target ma_ctx matches 0..5 run '+queue('swap'),f'execute if score #target ma_ctx matches 0..5 run data modify {S} s.swap set from {S} request.target','execute if score #target ma_ctx matches 0..5 run '+queue('turn_end')])
    put('choices/thirdwheel',['execute if score #target ma_ctx matches 0..29 run '+fn('choices/third_warp')+' with storage magical_athlete:engine choice',queue('roll')])
    put('choices/third_warp',[f'$data modify {S} append set value {{type:"warp",pawn:$(pawn),to:0,source:34}}',f'data modify {S} append.to set from {S} request.target',f'data modify {S} s.queue prepend from {S} append'])
    put('choices/alchemist',[f'execute if score #target ma_ctx matches 1 run data modify {S} s.distance set value 4',queue('roll_done')])
    put('choices/rocket',[f'execute if score #target ma_ctx matches 1 run data modify {S} s.bomb set value 1',get('distance','distance'),'execute if score #target ma_ctx matches 1 run scoreboard players operation #distance ma_ctx += #distance ma_ctx',save('distance','distance'),queue('roll_done')])
    put('choices/reroll',['execute if score #target ma_ctx matches 0 run '+queue('roll_accept'),'execute if score #target ma_ctx matches 1 run '+fn('reroll')])
    put('choices/copycat',[f'$data modify {S} s.racers[$(pawn)].copy set from {S} request.target'])
    put('choices/duel',['execute if score #target ma_ctx matches -1 run return 1',f'data modify {S} choice.target set from {S} request.target',fn('duel_roll')+' with storage magical_athlete:engine choice'])
    put('choices/suckerfish',[f'$execute if score #target ma_ctx matches 1 run data modify {S} s.followers append value $(pawn)',f'execute if score #target ma_ctx matches 1 run data modify {S} job set value {{type:"power",pawn:0}}',f'$execute if score #target ma_ctx matches 1 run data modify {S} job.pawn set value $(pawn)',f'execute if score #target ma_ctx matches 1 run '+fn('jobs/power')+' with storage magical_athlete:engine job'])
    # Main roll acceptance is its own job, so every reroll discards the previous number entirely.
    put('jobs/roll_accept',fn('roll_accept'))
    path=ROOT/'job_dispatch.mcfunction';text=path.read_text(encoding='utf-8');text+=f'execute if data {S} job{{type:"roll_accept"}} run return run {fn("roll_accept")}\n';write_guarded(path,text,encoding='utf-8')

def build_turn():
    powers=[]
    for i in range(6):
        for score,key in [('o','owner'),('c','char'),('p','power'),('x','pos'),('t','trip'),('s','status')]:powers +=[get(score+str(i),f'racers[{i}].{key}')]
    # Copycat follows the current, unfinished leader. A stored tied-leader choice
    # remains in force until that racer ceases to share the lead.
    for i in range(6):
        powers +=[f'execute if score #p{i} ma_ctx matches 7 run '+fn('copy/'+str(i))]
        body=['scoreboard players set #lead ma_ctx -1','scoreboard players set #picked ma_ctx -1',get('copy',f'racers[{i}].copy')]
        for j in range(6):
            if i!=j:body +=[f'execute if score #s{j} ma_ctx matches 0 if score #x{j} ma_ctx > #lead ma_ctx run scoreboard players operation #lead ma_ctx = #x{j} ma_ctx']
        for j in range(6):
            if i!=j:body +=[f'execute if score #s{j} ma_ctx matches 0 if score #x{j} ma_ctx = #lead ma_ctx unless score #p{j} ma_ctx matches 7 if score #picked ma_ctx matches -1 run scoreboard players set #picked ma_ctx {j}']
        for j in range(6):
            if i!=j:body +=[f'execute if score #copy ma_ctx matches {j} if score #s{j} ma_ctx matches 0 if score #x{j} ma_ctx = #lead ma_ctx unless score #p{j} ma_ctx matches 7 run scoreboard players set #picked ma_ctx {j}']
        body +=[f'scoreboard players set #p{i} ma_ctx -1']
        for j in range(6):body +=[f'execute if score #picked ma_ctx matches {j} run scoreboard players operation #p{i} ma_ctx = #p{j} ma_ctx']
        put('copy/'+str(i),body)
    put('powers',powers)
    put('pawn_context',[f'$execute store result score #i ma_ctx run data get {S} job.pawn',f'$execute store result score #owner ma_ctx run data get {S} s.racers[$(pawn)].owner',f'$execute store result score #power ma_ctx run data get {S} s.racers[$(pawn)].power',f'$execute store result score #position ma_ctx run data get {S} s.racers[$(pawn)].pos',f'$execute store result score #status ma_ctx run data get {S} s.racers[$(pawn)].status']+[f'execute if score #i ma_ctx matches {i} run scoreboard players operation #power ma_ctx = #p{i} ma_ctx' for i in range(6)])
    start=[reject('unless score #phase ma_ctx matches 3',5),reject('unless score #actor ma_ctx = #turn ma_ctx',4),reject('unless score #target ma_ctx matches 0..5',8),f'execute if data {S} s.pending.options[0] run '+err(5),f'execute if data {S} s.queue[0] run '+err(5),f'data modify {S} job set value {{pawn:0}}',f'data modify {S} job.pawn set from {S} request.target',fn('powers'),fn('pawn_context')+' with storage magical_athlete:engine job',reject('unless score #owner ma_ctx = #actor ma_ctx',4),reject('unless score #status ma_ctx matches 0',8),fn('turn/validate_pawn')+' with storage magical_athlete:engine job',reject('unless score #valid ma_ctx matches 1',8),f'data modify {S} s.active set from {S} request.target',f'data modify {S} s.pawn set from {S} request.target',save('start_pos','position'),f'data modify {S} s.dice set value 0',f'data modify {S} s.rerolls set value 0',f'data modify {S} s.merchant set value 0',f'data modify {S} s.prediction set value 0',f'data modify {S} s.bomb set value 0',f'data modify {S} s.skip set value 0',f'data modify {S} s.pre_done set value 0',f'data modify {S} s.extra set value -1',f'data modify {S} s.next_override set value -1',queue('begin'),'scoreboard players set #ok ma_ctx 1']
    put('turn/start',start)
    put('turn/validate_pawn',['scoreboard players set #valid ma_ctx 1',f'$execute store result score #done ma_ctx run data get {S} s.racers[$(pawn)].done','execute if score #done ma_ctx matches 1 run scoreboard players set #valid ma_ctx 0',get('forced','forced'),'execute if score #forced ma_ctx matches 0..5 unless score #forced ma_ctx = #target ma_ctx run scoreboard players set #valid ma_ctx 0'])
    put('active_context',[f'data modify {S} job.pawn set from {S} s.active',fn('pawn_context')+' with storage magical_athlete:engine job'])
    begin=[fn('active_context'),f'data modify {S} temp.pawn set from {S} s.active',fn('turn/mark')+' with storage magical_athlete:engine temp','execute if score #status ma_ctx matches 1.. run '+queue('turn_end'),'execute if score #status ma_ctx matches 1.. run return 0',f'execute store result score #first ma_ctx run data get {S} s.racers' if False else fn('turn/first')+' with storage magical_athlete:engine temp',f'execute if data {S} s.pending.options[0] run return 0',queue('pre')]
    put('jobs/begin',begin)
    put('turn/mark',f'$data modify {S} s.racers[$(pawn)].done set value 1')
    put('turn/first',[f'$execute store result score #first ma_ctx run data get {S} s.racers[$(pawn)].first',f'$data modify {S} s.racers[$(pawn)].first set value 0','execute if score #first ma_ctx matches 1 if score #power ma_ctx matches 24 run '+fn('turn/mastermind')])
    opts=[pending('mastermind',options=[])][0]
    for j in range(6):opts +=[f'execute if score #s{j} ma_ctx matches 0 run data modify {S} s.pending.options append value {j}']
    put('turn/mastermind',opts)
    pre=[fn('active_context'),fn('turn/trip')+' with storage magical_athlete:engine job','execute if score #tripped ma_ctx matches 1 run return 0','scoreboard players set #lead ma_ctx -1','scoreboard players set #last ma_ctx 31','scoreboard players set #alone ma_ctx 1']
    for j in range(6):pre +=[f'execute if score #s{j} ma_ctx matches 0 if score #x{j} ma_ctx > #lead ma_ctx run scoreboard players operation #lead ma_ctx = #x{j} ma_ctx',f'execute if score #s{j} ma_ctx matches 0 if score #x{j} ma_ctx < #last ma_ctx run scoreboard players operation #last ma_ctx = #x{j} ma_ctx',f'execute unless score #i ma_ctx matches {j} if score #s{j} ma_ctx matches 0 if score #x{j} ma_ctx = #position ma_ctx run scoreboard players set #alone ma_ctx 0']
    pre +=['execute if score #power ma_ctx matches 14 if score #position ma_ctx = #lead ma_ctx if score #alone ma_ctx matches 1 run '+queue('turn_end'),'execute if score #power ma_ctx matches 14 if score #position ma_ctx = #lead ma_ctx if score #alone ma_ctx matches 1 run return 0','execute if score #power ma_ctx matches 22 if score #position ma_ctx = #last ma_ctx if score #alone ma_ctx matches 1 run '+fn('turn/loser'), 'execute if score #power ma_ctx matches 26 run '+fn('turn/party'), 'execute if score #power ma_ctx matches 26 run return 0']
    for power,k,options in [(5,'cheerleader',[0,1]),(17,'hypnotist',[-1]),(11,'flip',[-1]),(12,'genius',[0,1,2,3,4,5,6]),(21,'legs',[0,1]),(34,'thirdwheel',[-1])]:
        pre +=[f'execute if score #power ma_ctx matches {power} run '+fn('turn/offer_'+k),f'execute if score #power ma_ctx matches {power} run return 0']
        b=pending(k,options=options)
        if k in ('hypnotist','flip'):
            for j in range(6):b +=[f'execute unless score #i ma_ctx matches {j} if score #s{j} ma_ctx matches 0 run data modify {S} s.pending.options append value {j}']
        if k=='thirdwheel':
            for pos in range(30):
                b +=['scoreboard players set #count ma_ctx 0']+[f'execute if score #s{j} ma_ctx matches 0 if score #x{j} ma_ctx matches {pos} run scoreboard players add #count ma_ctx 1' for j in range(6)]+[f'execute if score #count ma_ctx matches 2 run data modify {S} s.pending.options append value {pos}']
        put('turn/offer_'+k,b)
    pre +=[queue('roll')]
    put('jobs/pre',pre)
    put('turn/trip',['scoreboard players set #tripped ma_ctx 0',f'$execute store result score #tripped ma_ctx run data get {S} s.racers[$(pawn)].trip','execute unless score #tripped ma_ctx matches 1 run return 0',f'$data modify {S} s.racers[$(pawn)].trip set value 0',f'$data modify {S} s.events append value {{kind:4,pawn:$(pawn),from:0,to:0,source:-2,amount:0,die:0}}',queue('turn_end'),'scoreboard players set #tripped ma_ctx 1'])
    put('turn/loser',[f'data modify {S} job set value {{type:"points",pawn:0,amount:1,source:22}}',f'data modify {S} job.pawn set from {S} s.active',fn('jobs/points')+' with storage magical_athlete:engine job',f'data modify {S} job set value {{pawn:0}}',f'data modify {S} job.pawn set from {S} s.active',fn('jobs/power')+' with storage magical_athlete:engine job'])
    put('turn/party',[queue('party'),queue('roll')])
    put('jobs/roll',[fn('active_context'),f'execute store result {S} s.dice int 1 run random value 1..6',fn('roll_offer')])
    offer=[fn('active_context'),get('die','dice'),'scoreboard players set #can ma_ctx 0',get('rerolls','rerolls'),get('merchant','merchant'),'execute if score #power ma_ctx matches 23 if score #rerolls ma_ctx matches ..1 run scoreboard players set #can ma_ctx 1']
    for j in range(6):offer +=[f'execute if score #s{j} ma_ctx matches 0 if score #p{j} ma_ctx matches 8 if score #merchant ma_ctx matches 0 run scoreboard players set #can ma_ctx 1']
    offer +=[fn('dice_event'),'execute if score #can ma_ctx matches 1 run '+fn('offer_reroll'),'execute if score #can ma_ctx matches 0 run '+queue('roll_accept')]
    put('roll_offer',offer);put('offer_reroll',pending('reroll',options=[0,1]))
    reroll=[fn('active_context'),get('rerolls','rerolls'),'scoreboard players set #native ma_ctx 0','execute if score #power ma_ctx matches 23 if score #rerolls ma_ctx matches ..1 run scoreboard players set #native ma_ctx 1','execute if score #native ma_ctx matches 1 run scoreboard players add #rerolls ma_ctx 1',save('rerolls','rerolls'),f'execute if score #native ma_ctx matches 0 run data modify {S} s.merchant set value 1']
    for j in range(6):reroll +=[f'execute if score #native ma_ctx matches 0 if score #s{j} ma_ctx matches 0 if score #p{j} ma_ctx matches 8 unless score #i ma_ctx matches {j} run '+queue('move',pawn=j,amount=1,source=8)]
    reroll +=[f'data modify {S} job.pawn set from {S} s.active',fn('jobs/power')+' with storage magical_athlete:engine job',queue('roll')]
    put('reroll',reroll)
    put('dice_event',[f'data modify {S} e set value {{kind:9,pawn:0,from:0,to:0,source:-2,amount:0,die:0}}',f'data modify {S} e.pawn set from {S} s.active',f'data modify {S} e.die set from {S} s.dice',f'data modify {S} s.events append from {S} e'])
    accept=[fn('active_context'),get('die','dice'),save('distance','die')]
    accept +=['execute if score #power ma_ctx matches 0 if score #die ma_ctx matches 1..2 run '+fn('offer_alchemist'),'execute if score #power ma_ctx matches 0 if score #die ma_ctx matches 1..2 run return 0','execute if score #power ma_ctx matches 27 run '+fn('offer_rocket'),'execute if score #power ma_ctx matches 27 run return 0',queue('roll_done')]
    put('roll_accept',accept);put('offer_alchemist',pending('alchemist',options=[0,1]));put('offer_rocket',pending('rocket',options=[0,1]))
    done=[fn('active_context'),get('die','dice'),get('prediction','prediction'),'execute if score #power ma_ctx matches 12 if score #prediction ma_ctx = #die ma_ctx run data modify '+S+' s.extra set from '+S+' s.active']
    for j in range(6):done +=[f'execute if score #s{j} ma_ctx matches 0 if score #p{j} ma_ctx matches 31 if score #die ma_ctx matches 1 run data modify {S} s.next_override set value {j}',f'execute if score #s{j} ma_ctx matches 0 if score #p{j} ma_ctx matches 18 if score #die ma_ctx matches 1 unless score #i ma_ctx matches {j} run data modify {S} s.skip set value 1',f'execute if score #s{j} ma_ctx matches 0 if score #p{j} ma_ctx matches 18 if score #die ma_ctx matches 1 unless score #i ma_ctx matches {j} run '+queue('move',pawn=j,amount=1,source=18),f'execute if score #s{j} ma_ctx matches 0 if score #p{j} ma_ctx matches 19 if score #die ma_ctx matches 6 unless score #i ma_ctx matches {j} run '+queue('move',pawn=j,amount=2,source=19)]
    done +=['execute if score #power ma_ctx matches 30 if score #die ma_ctx matches 6 run '+fn('turn/sisyphus'),queue('main')]
    put('jobs/roll_done',done)
    put('turn/sisyphus',[f'data modify {S} s.skip set value 1',f'data modify {S} add set value {{type:"warp",pawn:0,to:0,source:30}}',f'data modify {S} add.pawn set from {S} s.active',f'data modify {S} s.queue append from {S} add',f'data modify {S} add set value {{type:"points",pawn:0,amount:-1,source:30}}',f'data modify {S} add.pawn set from {S} s.active',f'data modify {S} s.queue append from {S} add'])
    main=[fn('active_context'),get('skip','skip'),'execute if score #skip ma_ctx matches 1 run '+queue('turn_end'),'execute if score #skip ma_ctx matches 1 run return 0',get('distance','distance'),get('start','start_pos'),'execute if score #power ma_ctx matches 3 if score #start ma_ctx matches ..14 run scoreboard players add #distance ma_ctx 3','execute if score #power ma_ctx matches 3 if score #start ma_ctx matches 15.. run scoreboard players remove #distance ma_ctx 1','execute if score #power ma_ctx matches 14 run scoreboard players add #distance ma_ctx 2']
    for j in range(6):main +=[f'execute if score #s{j} ma_ctx matches 0 if score #p{j} ma_ctx matches 6 if score #x{j} ma_ctx = #position ma_ctx run scoreboard players add #distance ma_ctx 1',f'execute if score #s{j} ma_ctx matches 0 if score #p{j} ma_ctx matches 13 unless score #i ma_ctx matches {j} run scoreboard players remove #distance ma_ctx 1',f'execute if score #power ma_ctx matches 26 unless score #i ma_ctx matches {j} if score #s{j} ma_ctx matches 0 if score #x{j} ma_ctx = #position ma_ctx run scoreboard players add #distance ma_ctx 1']
    main +=['execute if score #distance ma_ctx matches ..-1 run scoreboard players set #distance ma_ctx 0',f'data modify {S} add set value {{type:"move",pawn:0,amount:0,source:-2}}',f'data modify {S} add.pawn set from {S} s.active',f'execute store result {S} add.amount int 1 run scoreboard players get #distance ma_ctx',f'data modify {S} s.queue append from {S} add',get('bomb','bomb'),f'execute if score #bomb ma_ctx matches 1 run data modify {S} add set value {{type:"trip",pawn:0,source:27}}',f'execute if score #bomb ma_ctx matches 1 run data modify {S} add.pawn set from {S} s.active',f'execute if score #bomb ma_ctx matches 1 run data modify {S} s.queue append from {S} add',queue('turn_end')]
    put('jobs/main',main)

def build_movement():
    move=[fn('pawn_context')+' with storage magical_athlete:engine job','execute unless score #status ma_ctx matches 0 run return 0',f'$scoreboard players set #amount ma_ctx $(amount)','execute if score #amount ma_ctx matches 0 run return 0',f'data modify {S} s.motion set value {{pawn:0,from:0,to:0,source:-2,group:[],before:[]}}',f'data modify {S} s.motion.pawn set from {S} job.pawn',save('motion.from','position'),f'data modify {S} s.motion.source set from {S} job.source','scoreboard players operation #destination ma_ctx = #position ma_ctx','scoreboard players operation #destination ma_ctx += #amount ma_ctx','execute if score #destination ma_ctx matches ..-1 run scoreboard players set #destination ma_ctx 0','execute if score #power ma_ctx matches 20 run '+fn('move/leap')]
    for j in range(6):move +=[f'execute if score #s{j} ma_ctx matches 0 if score #p{j} ma_ctx matches 32 unless score #i ma_ctx matches {j} if score #destination ma_ctx matches 31.. run return 0']
    move +=['execute if score #destination ma_ctx matches 31.. run scoreboard players set #destination ma_ctx 30',save('motion.to','destination'),f'$data modify {S} s.motion.group append value $(pawn)']
    for j in range(6):move +=[f'data modify {S} s.motion.before append from {S} s.racers[{j}].pos']
    move +=[front('postmove')]
    for j in reversed(range(6)):move +=[f'execute unless score #i ma_ctx matches {j} if score #s{j} ma_ctx matches 0 if score #p{j} ma_ctx matches 33 if score #x{j} ma_ctx = #position ma_ctx run '+front('follow',pawn=j)]
    put('jobs/move',move)
    leap=['scoreboard players operation #remaining ma_ctx = #amount ma_ctx','scoreboard players set #direction ma_ctx 1','execute if score #remaining ma_ctx matches ..-1 run scoreboard players set #direction ma_ctx -1','execute if score #remaining ma_ctx matches ..-1 run scoreboard players operation #remaining ma_ctx *= #-1 ma_ctx' if False else 'execute if score #remaining ma_ctx matches ..-1 run scoreboard players operation #remaining ma_ctx *= #minus ma_ctx','scoreboard players operation #destination ma_ctx = #position ma_ctx','scoreboard players set #walk_budget ma_ctx 96',fn('move/leap_step')]
    leap.insert(0,'scoreboard players set #minus ma_ctx -1')
    put('move/leap',leap)
    step=['execute unless score #remaining ma_ctx matches 1.. run return 0','execute unless score #walk_budget ma_ctx matches 1.. run return 0','scoreboard players remove #walk_budget ma_ctx 1','scoreboard players operation #destination ma_ctx += #direction ma_ctx','execute if score #destination ma_ctx matches ..0 run scoreboard players set #destination ma_ctx 0','execute if score #destination ma_ctx matches 30.. run return 0','scoreboard players set #occupied ma_ctx 0']
    for j in range(6):step +=[f'execute unless score #i ma_ctx matches {j} if score #s{j} ma_ctx matches 0 if score #x{j} ma_ctx = #destination ma_ctx run scoreboard players set #occupied ma_ctx 1']
    step +=['execute if score #occupied ma_ctx matches 0 run scoreboard players remove #remaining ma_ctx 1','execute if score #destination ma_ctx matches 0 run return 0',fn('move/leap_step')]
    put('move/leap_step',step)
    put('jobs/follow',[fn('pawn_context')+' with storage magical_athlete:engine job','execute unless score #status ma_ctx matches 0 run return 0',*pending('suckerfish',options=[0,1])])
    # Choices only record membership; follow triggers are emitted after the
    # entire simultaneous arrival, so no nested move can overwrite the motion.
    put('choices/suckerfish',[f'$execute if score #target ma_ctx matches 1 run data modify {S} s.motion.group append value $(pawn)'])
    post=[fn('powers')]
    for j in range(6):post +=[f'execute if data {S} s.motion{{group:[{j}]}} run '+fn('move/apply')+f' {{pawn:{j}}}']
    # Huge Baby changes where another racer is placed; this is a warp-like
    # placement rather than a new movement, but still a stopping event.
    post +=[fn('powers')]
    for baby in range(6):
        for j in range(6):
            if j==baby:continue
            post +=[f'execute if score #s{baby} ma_ctx matches 0 if score #p{baby} ma_ctx matches 16 if score #x{baby} ma_ctx matches 1..29 if score #s{j} ma_ctx matches 0 if score #x{j} ma_ctx = #x{baby} ma_ctx run '+fn('move/baby')+f' {{pawn:{j},baby:{baby}}}']
    # Hooks are prepended in reverse to preserve track, active-player, clockwise.
    for j in reversed(range(6)):post +=[f'execute if data {S} s.motion{{group:[{j}]}} run '+fn('move/hooks')+f' {{pawn:{j}}}']
    put('jobs/postmove',post)
    put('move/apply',[f'$data modify {S} s.racers[$(pawn)].pos set from {S} s.motion.to',f'$data modify {S} e set value {{kind:1,pawn:$(pawn),from:0,to:0,source:-2,amount:0,die:0}}',f'data modify {S} e.from set from {S} s.motion.from',f'data modify {S} e.to set from {S} s.motion.to',f'data modify {S} e.source set from {S} s.motion.source',f'data modify {S} s.events append from {S} e'])
    put('move/baby',[f'$execute store result score #destination ma_ctx run data get {S} s.racers[$(baby)].pos','scoreboard players remove #destination ma_ctx 1',f'$execute store result {S} s.racers[$(pawn)].pos int 1 run scoreboard players get #destination ma_ctx',f'$data modify {S} e set value {{kind:2,pawn:$(pawn),from:0,to:0,source:16,amount:0,die:0}}',f'data modify {S} e.from set from {S} s.motion.to',f'execute store result {S} e.to int 1 run scoreboard players get #destination ma_ctx',f'data modify {S} s.events append from {S} e'])
    hooks=[f'$data modify {S} hook set value {{type:"land",pawn:$(pawn),from:0,to:0,source:-2,group:[],before:[],moved:1}}',f'data modify {S} hook.from set from {S} s.motion.from',f'$data modify {S} hook.to set from {S} s.racers[$(pawn)].pos',f'data modify {S} hook.source set from {S} s.motion.source',f'data modify {S} hook.group set from {S} s.motion.group',f'data modify {S} hook.before set from {S} s.motion.before',f'data modify {S} s.queue prepend from {S} hook']
    put('move/hooks',hooks)
    warp=[fn('pawn_context')+' with storage magical_athlete:engine job','execute unless score #status ma_ctx matches 0 run return 0',f'$scoreboard players set #destination ma_ctx $(to)',save('warp_from','position'),fn('move/warp_apply')+' with storage magical_athlete:engine job']
    put('jobs/warp',warp)
    put('move/warp_apply',[f'$data modify {S} s.racers[$(pawn)].pos set value $(to)',f'$data modify {S} e set value {{kind:2,pawn:$(pawn),from:0,to:$(to),source:$(source),amount:0,die:0}}',f'data modify {S} e.from set from {S} s.warp_from',f'data modify {S} s.events append from {S} e',f'$data modify {S} hook set value {{type:"land",pawn:$(pawn),from:0,to:$(to),source:$(source),group:[$(pawn)],before:[],moved:0}}',f'data modify {S} hook.from set from {S} s.warp_from',f'data modify {S} s.queue prepend from {S} hook'])
    swap=[fn('active_context'),get('target','swap')]
    for j in range(6):swap +=[f'execute if score #target ma_ctx matches {j} run '+fn('swap/with')+f' {{target:{j}}}']
    put('jobs/swap',swap)
    put('swap/with',[f'$data modify {S} swap_target set from {S} s.racers[$(target)].pos',f'data modify {S} swap_self set from {S} s.active',f'$data modify {S} swap_index set value {{target:$(target),pawn:0}}',f'data modify {S} swap_index.pawn set from {S} s.active',fn('swap/apply')+' with storage magical_athlete:engine swap_index'])
    put('swap/apply',[f'$data modify {S} swap_old set from {S} s.racers[$(pawn)].pos',f'$data modify {S} s.racers[$(pawn)].pos set from {S} swap_target',f'$data modify {S} s.racers[$(target)].pos set from {S} swap_old',f'$data modify {S} e set value {{kind:2,pawn:$(pawn),from:0,to:0,source:11,amount:0,die:0}}',f'data modify {S} e.from set from {S} swap_old',f'data modify {S} e.to set from {S} swap_target',f'data modify {S} s.events append from {S} e',f'$data modify {S} e.pawn set value $(target)',f'data modify {S} e.from set from {S} swap_target',f'data modify {S} e.to set from {S} swap_old',f'data modify {S} s.events append from {S} e',f'$data modify {S} hook set value {{type:"land",pawn:$(target),from:0,to:0,source:11,group:[$(pawn),$(target)],before:[],moved:0}}',f'data modify {S} hook.from set from {S} swap_target',f'data modify {S} hook.to set from {S} swap_old',f'data modify {S} s.queue prepend from {S} hook',f'$data modify {S} hook.pawn set value $(pawn)',f'data modify {S} hook.from set from {S} swap_old',f'data modify {S} hook.to set from {S} swap_target',f'data modify {S} s.queue prepend from {S} hook'])
    land=[fn('pawn_context')+' with storage magical_athlete:engine job','execute unless score #status ma_ctx matches 0 run return 0',f'$scoreboard players set #destination ma_ctx $(to)','execute if score #destination ma_ctx matches 30.. run return run '+fn('jobs/finish')+' with storage magical_athlete:engine job',fn('cycle/check')+' with storage magical_athlete:engine job','execute if score #repeated ma_ctx matches 1 run return 0',f'data modify {S} landed set from {S} job',fn('land/queue_reactions'),fn('land/track')+' with storage magical_athlete:engine landed']
    put('jobs/land',land)
    # Detect repeated, identical event+physical-state combinations. Scores are
    # deliberately omitted: a score-generating stationary loop must also stop.
    put('cycle/check',[f'data modify {S} signature.sig set value {{event:{{}},racers:[]}}',f'data modify {S} signature.sig.event set from {S} job',f'data modify {S} signature.sig.racers set from {S} s.racers',fn('cycle/match')+' with storage magical_athlete:engine signature','execute if score #repeated ma_ctx matches 1 run return 0',f'data modify {S} s.seen append from {S} signature.sig'])
    put('cycle/match',[f'$execute store success score #repeated ma_ctx if data {S} s.seen[$(sig)]',f'execute if score #repeated ma_ctx matches 1 run data modify {S} s.loop set value 1'])
    track=[f'execute unless data {S} s{{track:1}} run return 0']
    for pos,feature in TRACK['wild'].items():
        if 'move'in feature:track +=[f'$execute if score #destination ma_ctx matches {pos} run '+front('move',pawn='PAWN',amount=feature['move'],source=-1).replace('"PAWN"','$(pawn)')]
        if 'trip'in feature:track +=[f'$execute if score #destination ma_ctx matches {pos} run '+front('trip',pawn='PAWN',source=-1).replace('"PAWN"','$(pawn)')]
        if 'points'in feature:track +=[f'$execute if score #destination ma_ctx matches {pos} run '+front('points',pawn='PAWN',amount=1,source=-1).replace('"PAWN"','$(pawn)')]
    put('land/track',track)
    # Current player's racers precede other players, then clockwise owner order.
    order=[]
    for turn in range(1,7):
        ordered=list(range(turn,7))+list(range(1,turn))
        for owner in reversed(ordered):
            for j in reversed(range(6)):
                order +=[f'execute if score #turn ma_ctx matches {turn} if score #o{j} ma_ctx matches {owner} if score #s{j} ma_ctx matches 0 run '+fn('land/reaction')+f' {{reactor:{j}}}']
    put('land/queue_reactions',order)
    put('land/reaction',[f'data modify {S} reaction set from {S} landed',f'data modify {S} reaction.type set value "react"',f'$data modify {S} reaction.reactor set value $(reactor)',f'data modify {S} s.queue prepend from {S} reaction'])

def build_reactions():
    trip=[fn('pawn_context')+' with storage magical_athlete:engine job','execute unless score #status ma_ctx matches 0 run return 0',f'$data modify {S} s.racers[$(pawn)].trip set value 1',f'$data modify {S} s.events append value {{kind:3,pawn:$(pawn),from:0,to:0,source:$(source),amount:0,die:0}}']
    put('jobs/trip',trip)
    put('jobs/points',[fn('pawn_context')+' with storage magical_athlete:engine job',f'$scoreboard players set #amount ma_ctx $(amount)',fn('points/owner')+' with storage magical_athlete:engine job',f'$data modify {S} s.events append value {{kind:7,pawn:$(pawn),from:0,to:0,source:$(source),amount:$(amount),die:0}}'])
    for p in range(1,7):
        pass
    put('points/owner',[f'execute if score #owner ma_ctx matches {p} run '+fn('points/player')+f' {{owner:{p}}}' for p in range(1,7)])
    put('points/player',[f'$execute store result score #points ma_ctx run data get {S} s.p$(owner).points',f'$execute store result score #racepoints ma_ctx run data get {S} s.p$(owner).race_points','scoreboard players operation #old_points ma_ctx = #points ma_ctx','scoreboard players operation #points ma_ctx += #amount ma_ctx','execute if score #points ma_ctx matches ..-1 run scoreboard players set #points ma_ctx 0','scoreboard players operation #delta ma_ctx = #points ma_ctx','scoreboard players operation #delta ma_ctx -= #old_points ma_ctx','scoreboard players operation #racepoints ma_ctx += #delta ma_ctx',f'$execute store result {S} s.p$(owner).points int 1 run scoreboard players get #points ma_ctx',f'$execute store result {S} s.p$(owner).race_points int 1 run scoreboard players get #racepoints ma_ctx'])
    power=[fn('powers'),f'$scoreboard players set #author ma_ctx $(pawn)',f'$data modify {S} s.events append value {{kind:8,pawn:$(pawn),from:0,to:0,source:0,amount:0,die:0}}']
    for j in reversed(range(6)):power +=[f'execute unless score #author ma_ctx matches {j} if score #s{j} ma_ctx matches 0 if score #p{j} ma_ctx matches 29 run '+front('move',pawn=j,amount=1,source=29)]
    put('jobs/power',power)
    react=[f'$scoreboard players set #reactor ma_ctx $(reactor)',f'$scoreboard players set #mover ma_ctx $(pawn)',f'$scoreboard players set #from ma_ctx $(from)',f'$scoreboard players set #to ma_ctx $(to)',f'$scoreboard players set #moved ma_ctx $(moved)']
    for j in range(6):react +=[f'execute if score #reactor ma_ctx matches {j} run scoreboard players operation #rpower ma_ctx = #p{j} ma_ctx',f'execute if score #reactor ma_ctx matches {j} run scoreboard players operation #rstatus ma_ctx = #s{j} ma_ctx',f'execute if score #reactor ma_ctx matches {j} run scoreboard players operation #rpos ma_ctx = #x{j} ma_ctx']
    react +=['execute unless score #rstatus ma_ctx matches 0 run return 0',f'$execute store success score #joint ma_ctx if data {S} job{{group:[$(reactor)]}}','execute if score #rpower ma_ctx matches 2 if score #moved ma_ctx matches 1 unless score #reactor ma_ctx = #mover ma_ctx run '+fn('react/banana')+' with storage magical_athlete:engine job','execute if score #rpower ma_ctx matches 4 if score #moved ma_ctx matches 1 if score #reactor ma_ctx = #mover ma_ctx run '+fn('react/centaur')+' with storage magical_athlete:engine job','execute if score #rpower ma_ctx matches 1 run '+fn('react/baba')+' with storage magical_athlete:engine job','execute if score #rpower ma_ctx matches 25 if score #reactor ma_ctx = #mover ma_ctx run '+fn('react/mouth')+' with storage magical_athlete:engine job','execute if score #rpower ma_ctx matches 28 run '+fn('react/romantic')+' with storage magical_athlete:engine job','execute if score #rpower ma_ctx matches 9 run '+fn('react/duel')+' with storage magical_athlete:engine job']
    put('jobs/react',react)
    put('react/banana',[f'$execute store result score #r_old ma_ctx run data get {S} job.before[$(reactor)]','execute unless score #from ma_ctx < #r_old ma_ctx run return 0','execute unless score #to ma_ctx > #r_old ma_ctx run return 0',f'$'+front('trip',pawn='PAWN',source=2).replace('"PAWN"','$(pawn)'),f'$'+front('power',pawn='REACTOR').replace('"REACTOR"','$(reactor)')])
    centaur=[]
    for j in range(6):centaur +=[f'execute store result score #passed ma_ctx run data get {S} job.before[{j}]',f'execute if score #s{j} ma_ctx matches 0 unless score #mover ma_ctx matches {j} if score #from ma_ctx < #passed ma_ctx if score #to ma_ctx > #passed ma_ctx run '+front('move',pawn=j,amount=-2,source=4)]
    put('react/centaur',centaur)
    baba=['execute if score #reactor ma_ctx = #mover ma_ctx run '+fn('react/baba_moving')+' with storage magical_athlete:engine job','execute if score #reactor ma_ctx = #mover ma_ctx run return 0','execute if score #joint ma_ctx matches 1 run return 0','execute unless score #rpos ma_ctx = #to ma_ctx run return 0',f'$'+front('trip',pawn='PAWN',source=1).replace('"PAWN"','$(pawn)'),f'$'+front('power',pawn='REACTOR').replace('"REACTOR"','$(reactor)')]
    put('react/baba',baba)
    babam=[]
    for j in range(6):babam +=[f'execute unless data {S} job{{group:[{j}]}} if score #s{j} ma_ctx matches 0 if score #x{j} ma_ctx = #to ma_ctx run '+front('trip',pawn=j,source=1)]
    put('react/baba_moving',babam)
    count=['scoreboard players set #count ma_ctx 0','scoreboard players set #victim ma_ctx -1']
    for j in range(6):count +=[f'execute unless score #mover ma_ctx matches {j} if score #s{j} ma_ctx matches 0 if score #x{j} ma_ctx = #to ma_ctx run scoreboard players add #count ma_ctx 1',f'execute unless score #mover ma_ctx matches {j} if score #s{j} ma_ctx matches 0 if score #x{j} ma_ctx = #to ma_ctx run scoreboard players set #victim ma_ctx {j}']
    put('react/count',count)
    put('react/mouth',[fn('react/count'),'execute unless score #count ma_ctx matches 1 run return 0',save('victim','victim'),fn('react/mouth_target')+' with storage magical_athlete:engine s'])
    put('react/mouth_target',[f'$execute if data {S} job{{group:[$(victim)]}} run return 0',f'$data modify {S} s.racers[$(victim)].status set value 2',f'$data modify {S} s.eliminated append value $(victim)',f'$data modify {S} s.events append value {{kind:5,pawn:$(victim),from:0,to:0,source:25,amount:0,die:0}}',fn('race/survivor')])
    put('react/romantic',[fn('react/count'),'execute unless score #count ma_ctx matches 1 run return 0',save('victim','victim'),fn('react/romantic_target')+' with storage magical_athlete:engine s'])
    put('react/romantic_target',[f'$execute if data {S} job{{group:[$(victim)]}} run return 0',f'data modify {S} add set value {{type:"move",pawn:0,amount:2,source:28}}',f'data modify {S} add.pawn set from {S} job.reactor',f'data modify {S} s.queue prepend from {S} add'])
    duel=['execute unless score #reactor ma_ctx = #mover ma_ctx if score #joint ma_ctx matches 1 run return 0','execute unless score #reactor ma_ctx = #mover ma_ctx unless score #rpos ma_ctx = #to ma_ctx run return 0',f'data modify {S} s.pending set value {{kind:"duel",owner:0,pawn:0,options:[-1]}}',f'data modify {S} s.pending.pawn set from {S} job.reactor']
    for j in range(6):duel +=[f'execute if score #reactor ma_ctx matches {j} run data modify {S} s.pending.owner set from {S} s.racers[{j}].owner',f'execute unless score #reactor ma_ctx matches {j} if score #s{j} ma_ctx matches 0 if score #x{j} ma_ctx = #rpos ma_ctx run data modify {S} s.pending.options append value {j}']
    duel +=[f'execute unless data {S} s.pending.options[1] run data modify {S} s.pending set value {{kind:"",owner:0,pawn:-1,options:[]}}']
    put('react/duel',duel)
    put('duel_roll',['execute store result score #duel_a ma_ctx run random value 1..6','execute store result score #duel_b ma_ctx run random value 1..6',f'$data modify {S} add set value {{type:"move",pawn:$(pawn),amount:2,source:9}}',f'$execute if score #duel_a ma_ctx < #duel_b ma_ctx run data modify {S} add.pawn set value $(target)',f'data modify {S} s.queue prepend from {S} add'])
    # Cheerleader and Party Animal arrive as batches. Party Animal moves racers
    # towards its immutable starting position, not towards an already moved pawn.
    cheer=[fn('active_context'),'scoreboard players set #last ma_ctx 31']
    for j in range(6):cheer +=[f'execute if score #s{j} ma_ctx matches 0 if score #x{j} ma_ctx < #last ma_ctx run scoreboard players operation #last ma_ctx = #x{j} ma_ctx']
    cheer +=[f'data modify {S} add set value {{type:"move",pawn:0,amount:1,source:5}}',f'data modify {S} add.pawn set from {S} s.active',f'data modify {S} s.queue prepend from {S} add']
    for j in reversed(range(6)):cheer +=[f'execute if score #s{j} ma_ctx matches 0 if score #x{j} ma_ctx = #last ma_ctx run '+front('move',pawn=j,amount=2,source=5)]
    put('jobs/cheer',cheer)
    party=[fn('active_context')]
    for j in reversed(range(6)):party +=[f'execute unless score #i ma_ctx matches {j} if score #s{j} ma_ctx matches 0 if score #x{j} ma_ctx < #position ma_ctx run '+front('move',pawn=j,amount=1,source=26),f'execute unless score #i ma_ctx matches {j} if score #s{j} ma_ctx matches 0 if score #x{j} ma_ctx > #position ma_ctx run '+front('move',pawn=j,amount=-1,source=26)]
    put('jobs/party',party)

def build_race():
    end=[fn('active_context'),get('start','start_pos'),'scoreboard players operation #delta ma_ctx = #position ma_ctx','scoreboard players operation #delta ma_ctx -= #start ma_ctx']
    end +=[queue('advance')]
    for j in reversed(range(6)):end +=[f'execute if score #s{j} ma_ctx matches 0 if score #p{j} ma_ctx matches 15 if score #delta ma_ctx matches -1..1 run '+front('move',pawn=j,amount=2,source=15)]
    put('jobs/turn_end',end)
    advance=[fn('powers'),get('extra','extra'),get('override','next_override'),get('active','active'),get('turn','turn'),f'data modify {S} s.forced set value -1']
    for j in range(6):advance +=[f'execute if score #extra ma_ctx matches {j} if score #s{j} ma_ctx matches 0 run '+fn('advance/extra')+f' {{pawn:{j}}}']
    advance +=['execute if score #extra ma_ctx matches 0..5 if score #override ma_ctx matches -1 run return 0']
    for j in range(6):advance +=[f'execute if score #override ma_ctx matches {j} if score #s{j} ma_ctx matches 0 run '+fn('advance/skip')+f' {{pawn:{j}}}']
    advance +=['execute if score #override ma_ctx matches 0..5 run return 0','scoreboard players set #remaining ma_ctx 0']
    for j in range(6):advance +=[get('done',f'racers[{j}].done'),f'execute if score #s{j} ma_ctx matches 0 if score #o{j} ma_ctx = #turn ma_ctx unless score #done ma_ctx matches 1 run scoreboard players add #remaining ma_ctx 1']
    advance +=['execute if score #remaining ma_ctx matches 1.. run return 0',fn('advance/next')]
    put('jobs/advance',advance)
    put('advance/extra',[f'$data modify {S} s.racers[$(pawn)].done set value 0',f'$data modify {S} s.forced set value $(pawn)',f'data modify {S} s.extra set value -1'])
    put('advance/skip',[f'$data modify {S} s.turn set from {S} s.racers[$(pawn)].owner',f'$data modify {S} s.forced set value $(pawn)',f'data modify {S} s.next_override set value -1']+[f'data modify {S} s.racers[{j}].done set value 0' for j in range(6)])
    put('advance/next',['scoreboard players add #turn ma_ctx 1','execute if score #turn ma_ctx > #n ma_ctx run scoreboard players set #turn ma_ctx 1',save('turn','turn')]+[f'data modify {S} s.racers[{j}].done set value 0' for j in range(6)]+['scoreboard players set #remaining ma_ctx 0']+[f'execute if score #s{j} ma_ctx matches 0 if score #o{j} ma_ctx = #turn ma_ctx run scoreboard players add #remaining ma_ctx 1' for j in range(6)]+['execute if score #remaining ma_ctx matches 0 run '+fn('advance/next')])
    prerace=[fn('pawn_context')+' with storage magical_athlete:engine job','execute unless score #status ma_ctx matches 0 run return 0','execute if score #power ma_ctx matches 30 run '+fn('prerace/sisyphus')+' with storage magical_athlete:engine job','execute if score #power ma_ctx matches 10 run '+fn('prerace/egg'),'execute if score #power ma_ctx matches 35 run '+fn('prerace/twin')]
    put('jobs/prerace',prerace)
    put('prerace/sisyphus',[f'$data modify {S} job set value {{type:"points",pawn:$(pawn),amount:4,source:30}}',fn('jobs/points')+' with storage magical_athlete:engine job'])
    egg=pending('egg',options=[])
    for _ in range(3):egg +=[f'execute if data {S} s.deck[0] run data modify {S} s.pending.options append from {S} s.deck[0]',f'execute if data {S} s.deck[0] run data remove {S} s.deck[0]']
    put('prerace/egg',egg)
    put('prerace/twin',pending('twin',options=[-1])+[f'data modify {S} s.pending.options append from {S} s.history[]'])
    finish=[fn('pawn_context')+' with storage magical_athlete:engine job','execute unless score #status ma_ctx matches 0 run return 0',f'$data modify {S} s.racers[$(pawn)].status set value 1',f'$data modify {S} s.racers[$(pawn)].pos set value 30',f'$data modify {S} s.finishers append value $(pawn)',f'$data modify {S} s.events append value {{kind:6,pawn:$(pawn),from:30,to:30,source:-2,amount:0,die:0}}',f'execute store result score #finishers ma_ctx run data get {S} s.finishers',get('round','round'),'scoreboard players operation #award ma_ctx = #round ma_ctx','execute if score #finishers ma_ctx matches 1 run scoreboard players add #award ma_ctx 2',f'$data modify {S} job set value {{type:"points",pawn:$(pawn),amount:0,source:-2}}',f'execute store result {S} job.amount int 1 run scoreboard players get #award ma_ctx',fn('jobs/points')+' with storage magical_athlete:engine job','execute if score #finishers ma_ctx matches 1 run '+fn('race/mastermind'),'execute if score #finishers ma_ctx matches 2.. run '+fn('race/end')]
    put('jobs/finish',finish)
    mastermind=[fn('powers'),f'data modify {S} winner.pawn set from {S} s.finishers[0]','scoreboard players set #master ma_ctx -1']
    for j in range(6):mastermind +=[get('pred',f'racers[{j}].prediction'),f'execute store result score #won ma_ctx run data get {S} s.finishers[0]',f'execute if score #p{j} ma_ctx matches 24 if score #pred ma_ctx = #won ma_ctx run scoreboard players set #master ma_ctx {j}']
    for j in range(6):mastermind +=[f'execute if score #master ma_ctx matches {j} run '+fn('race/master_award')+f' {{pawn:{j}}}']
    put('race/mastermind',mastermind)
    put('race/master_award',[f'$data modify {S} s.finishers append value $(pawn)',f'$data modify {S} job set value {{type:"points",pawn:$(pawn),amount:0,source:24}}',f'data modify {S} job.amount set from {S} s.round',fn('jobs/points')+' with storage magical_athlete:engine job'])
    survivor=[fn('powers'),'scoreboard players set #alive ma_ctx 0','scoreboard players set #survivor ma_ctx -1']
    for j in range(6):survivor +=[f'execute if score #s{j} ma_ctx matches 0 run scoreboard players add #alive ma_ctx 1',f'execute if score #s{j} ma_ctx matches 0 run scoreboard players set #survivor ma_ctx {j}']
    for j in range(6):survivor +=[f'execute if score #alive ma_ctx matches 1 if score #survivor ma_ctx matches {j} run '+fn('jobs/finish')+f' {{pawn:{j}}}']
    survivor +=['execute if score #alive ma_ctx matches ..1 run '+fn('race/end')]
    put('race/survivor',survivor)
    race_end=[f'execute if data {S} s{{phase:4}} run return 0',f'data modify {S} s.phase set value 4',f'data modify {S} s.queue set value []',f'data modify {S} s.pending set value {{kind:"",owner:0,pawn:-1,options:[]}}',f'data modify {S} s.active set value -1',f'data modify {S} s.pawn set value -1',f'data modify {S} index.pawn set from {S} s.finishers[0]',fn('race/history')+' with storage magical_athlete:engine index',fn('race/next_starter'),get('round','round'),'execute if score #round ma_ctx matches 4 run '+fn('race/final')]
    put('race/end',race_end)
    put('race/history',f'$data modify {S} s.history append from {S} s.racers[$(pawn)].char')
    starter=[fn('powers'),'scoreboard players set #last ma_ctx 31','scoreboard players set #starter ma_ctx 1']
    for j in range(6):starter +=[f'execute if score #s{j} ma_ctx matches 0 if score #x{j} ma_ctx < #last ma_ctx run scoreboard players operation #starter ma_ctx = #o{j} ma_ctx',f'execute if score #s{j} ma_ctx matches 0 if score #x{j} ma_ctx < #last ma_ctx run scoreboard players operation #last ma_ctx = #x{j} ma_ctx']
    starter +=[f'execute if data {S} s.eliminated[0] run data modify {S} eliminated.index set from {S} s.eliminated[0]',f'execute if data {S} s.eliminated[0] run '+fn('race/eliminated_starter')+' with storage magical_athlete:engine eliminated',get('points1','p1.race_points'),get('points2','p2.race_points'),'execute if score #n ma_ctx matches 2 if score #points1 ma_ctx < #points2 ma_ctx run scoreboard players set #starter ma_ctx 1','execute if score #n ma_ctx matches 2 if score #points2 ma_ctx < #points1 ma_ctx run scoreboard players set #starter ma_ctx 2','execute if score #n ma_ctx matches 2 if score #points1 ma_ctx = #points2 ma_ctx run '+fn('rolloff'),'execute if score #n ma_ctx matches 2 if score #points1 ma_ctx = #points2 ma_ctx run scoreboard players operation #starter ma_ctx = #winner ma_ctx',save('turn','starter')]
    put('race/next_starter',starter)
    put('race/eliminated_starter',f'$execute store result score #starter ma_ctx run data get {S} s.racers[$(index)].owner')
    final=[f'data modify {S} s.phase set value 5',f'data modify {S} s.winners set value []','scoreboard players set #best ma_ctx -1']
    for p in range(1,7):final +=[get('points'+str(p),f'p{p}.points'),f'execute if score #n ma_ctx matches {p}.. if score #points{p} ma_ctx > #best ma_ctx run scoreboard players operation #best ma_ctx = #points{p} ma_ctx']
    for p in range(1,7):final +=[f'execute if score #n ma_ctx matches {p}.. if score #points{p} ma_ctx = #best ma_ctx run data modify {S} s.winners append value {p}']
    put('race/final',final)
    next_race=[reject('unless score #phase ma_ctx matches 4',5),get('round','round'),'scoreboard players add #round ma_ctx 1',save('round','round'),f'data modify {S} s.phase set value 2',f'data modify {S} s.pending set value {{kind:"",owner:0,pawn:-1,options:[]}}',get('mode','track_mode'),'scoreboard players operation #track ma_ctx = #round ma_ctx','scoreboard players set #two ma_ctx 2','scoreboard players operation #track ma_ctx %= #two ma_ctx','scoreboard players set #one ma_ctx 1','scoreboard players operation #track ma_ctx = #one ma_ctx' if False else 'scoreboard players operation #one ma_ctx -= #track ma_ctx','scoreboard players operation #track ma_ctx = #one ma_ctx','execute if score #mode ma_ctx matches 1 run scoreboard players set #track ma_ctx 0','execute if score #mode ma_ctx matches 2 run scoreboard players set #track ma_ctx 1',save('track','track')]
    for p in range(1,7):next_race +=[f'data modify {S} s.p{p}.selected set value []']
    next_race +=['scoreboard players set #ok ma_ctx 1'];put('next_race',next_race)

def extend(name,lines,prepend=False):
    path=ROOT/(name+'.mcfunction');old=path.read_text(encoding='utf-8').splitlines()
    put(name,list(lines)+old if prepend else old+list(lines))

def build_refinements():
    # The August 2026 update fixes the racer order before each race. The first
    # and second lineup picks are adjacent slots in the clockwise racer circle.
    validate=['scoreboard players set #valid ma_ctx 1',get('forced','forced'),'execute if score #forced ma_ctx matches 0..5 unless score #forced ma_ctx = #target ma_ctx run scoreboard players set #valid ma_ctx 0','execute if score #forced ma_ctx matches 0..5 run return 0','scoreboard players set #first_owned ma_ctx -1']
    for j in range(6):validate +=[f'execute if score #s{j} ma_ctx matches 0 if score #o{j} ma_ctx = #actor ma_ctx if score #first_owned ma_ctx matches -1 run scoreboard players set #first_owned ma_ctx {j}']
    validate +=['execute unless score #first_owned ma_ctx = #target ma_ctx run scoreboard players set #valid ma_ctx 0'];put('turn/validate_pawn',validate)
    advance=[fn('powers'),get('extra','extra'),get('override','next_override'),get('active','active'),f'data modify {S} s.forced set value -1']
    for j in range(6):advance +=[f'execute if score #extra ma_ctx matches {j} if score #s{j} ma_ctx matches 0 if score #override ma_ctx matches -1 run return run '+fn('advance/choose')+f' {{pawn:{j}}}']
    for j in range(6):advance +=[f'execute if score #override ma_ctx matches {j} if score #s{j} ma_ctx matches 0 run return run '+fn('advance/choose')+f' {{pawn:{j}}}']
    for active in range(6):
        for offset in range(1,7):
            j=(active+offset)%6
            advance +=[f'execute if score #active ma_ctx matches {active} if score #s{j} ma_ctx matches 0 run return run '+fn('advance/choose')+f' {{pawn:{j}}}']
    put('jobs/advance',advance+[fn('race/end')])
    put('advance/choose',[f'$data modify {S} s.turn set from {S} s.racers[$(pawn)].owner',f'$data modify {S} s.forced set value $(pawn)',f'data modify {S} s.extra set value -1',f'data modify {S} s.next_override set value -1']+[f'data modify {S} s.racers[{j}].done set value 0' for j in range(6)])
    # A tripped racer retains before-main powers. Recovery only replaces the
    # actual main move; it does not suppress Cheerleader, Hypnotist, etc.
    p=ROOT/'jobs/pre.mcfunction';b=p.read_text(encoding='utf-8').splitlines();b=[x for x in b if 'engine/turn/trip' not in x and '#tripped ma_ctx matches 1 run return' not in x];put('jobs/pre',b)
    extend('jobs/roll',[fn('active_context'),fn('turn/trip')+' with storage magical_athlete:engine job','execute if score #tripped ma_ctx matches 1 run return 0'],prepend=True)
    for k in ('flip','legs'):
        extend('turn/offer_'+k,[fn('turn/trip')+' with storage magical_athlete:engine job','execute if score #tripped ma_ctx matches 1 run return 0'],prepend=True)
    # Copycat has no power when it alone leads; a tied leader can be selected.
    for i in range(6):
        path='copy/'+str(i);b=(ROOT/(path+'.mcfunction')).read_text(encoding='utf-8').splitlines()
        b.insert(3,f'execute if score #s{i} ma_ctx matches 0 if score #x{i} ma_ctx > #lead ma_ctx run scoreboard players operation #lead ma_ctx = #x{i} ma_ctx')
        put(path,b)
    # Expose all tied leaders before the Copycat's turn. The choice is frozen
    # for that action and its power continues to track unique leaders off-turn.
    copyoffer=[fn('active_context'),f'data modify {S} copystate set from {S} job',f'execute store result score #basepower ma_ctx run data get {S} s.racers[0].power']
    # Separate job so choosing does not re-open the same offer on resume.
    original=(ROOT/'jobs/begin.mcfunction').read_text(encoding='utf-8').splitlines();put('jobs/begin_actual',original)
    for i in range(6):copyoffer +=[f'execute if score #i ma_ctx matches {i} run execute store result score #basepower ma_ctx run data get {S} s.racers[{i}].power']
    copyoffer +=[front('begin_actual'),'execute unless score #basepower ma_ctx matches 7 run return 0','scoreboard players set #lead ma_ctx -1']
    for j in range(6):copyoffer +=[f'execute if score #s{j} ma_ctx matches 0 if score #x{j} ma_ctx > #lead ma_ctx run scoreboard players operation #lead ma_ctx = #x{j} ma_ctx']
    copyoffer +=pending('copycat',options=[])
    for j in range(6):copyoffer +=[f'execute unless score #i ma_ctx matches {j} if score #s{j} ma_ctx matches 0 if score #x{j} ma_ctx = #lead ma_ctx unless score #p{j} ma_ctx matches -1 run data modify {S} s.pending.options append value {j}']
    copyoffer +=[f'execute store result score #count ma_ctx run data get {S} s.pending.options',f'execute unless score #count ma_ctx matches 2.. run data modify {S} s.pending set value {{kind:"",owner:0,pawn:-1,options:[]}}']
    put('jobs/begin',copyoffer);extend('job_dispatch',[f'execute if data {S} job{{type:"begin_actual"}} run return run {fn("jobs/begin_actual")}'])
    # Race one can also be all-wild when selected before starting.
    extend('init',[f'execute if data {S} s{{track_mode:2}} run data modify entity @s data.magical_athlete.track set value 1'])
    # Per-racer main-move modifiers activate separately for Scoocher. These
    # power notifications are queued ahead of the main movement, not rerolls.
    main=(ROOT/'jobs/main.mcfunction').read_text(encoding='utf-8').splitlines()
    # The base amount is saved before nested power notifications can reuse scores.
    mod=[]
    for j in range(6):
        mod +=[f'execute if score #s{j} ma_ctx matches 0 if score #p{j} ma_ctx matches 6 if score #x{j} ma_ctx = #position ma_ctx run '+queue('power',pawn=j),f'execute if score #s{j} ma_ctx matches 0 if score #p{j} ma_ctx matches 13 unless score #i ma_ctx matches {j} run '+queue('power',pawn=j)]
    idx=next(i for i,x in enumerate(main) if 's.queue append from' in x)
    main[idx:idx]=mod
    put('jobs/main',main)
    # Ordinary movement generated by a skill also records the responsible power
    # for Scoocher, including every occupied square skipped by Leaptoad.
    post=(ROOT/'jobs/postmove.mcfunction').read_text(encoding='utf-8').splitlines()
    post +=[fn('move/notify')]
    put('jobs/postmove',post)
    notify=[get('source','motion.source'),'execute unless score #source ma_ctx matches 0..35 run return 0','scoreboard players set #author ma_ctx -1']
    for j in range(6):notify +=[f'execute if score #s{j} ma_ctx matches 0 if score #p{j} ma_ctx = #source ma_ctx if score #author ma_ctx matches -1 run scoreboard players set #author ma_ctx {j}']
    notify +=[f'execute if score #source ma_ctx matches 29 run execute store result score #author ma_ctx run data get {S} s.motion.pawn']
    for j in range(6):notify +=[f'execute if score #author ma_ctx matches {j} run '+front('power',pawn=j)]
    for j in range(6):notify +=[f'execute if data {S} s.motion{{group:[{j}]}} if score #p{j} ma_ctx matches 33 unless data {S} s.motion{{pawn:{j}}} run '+front('power',pawn=j)]
    put('move/notify',notify)
    # Mastermind's prediction cannot survive its elimination.
    p=ROOT/'race/mastermind.mcfunction';b=p.read_text(encoding='utf-8').splitlines();b=[x.replace(f'if score #p{j} ma_ctx matches 24 if score #pred',f'unless score #s{j} ma_ctx matches 2 if score #p{j} ma_ctx matches 24 if score #pred') for x in b for j in [next((k for k in range(6) if f'#p{k} ma_ctx matches 24' in x),0)]];put('race/mastermind',b)
    build_batches()
    build_power_refinements()
    build_copy_interrupt()
    build_immediate_finish()
    build_activation_timing()
    build_warp_arrivals()
    build_batch_distance()
    # Per-turn allowances reset only after loading the controller state.
    start=(ROOT/'turn/start.mcfunction').read_text(encoding='utf-8').splitlines();start=[x for x in start if 's.used_merchants set value []' not in x and 's.transmuted set value 0' not in x];ix=next(i for i,x in enumerate(start) if 's.active set from' in x);start[ix:ix]=[f'data modify {S} s.used_merchants set value []',f'data modify {S} s.transmuted set value 0'];put('turn/start',start)
    finish=(ROOT/'jobs/finish.mcfunction').read_text(encoding='utf-8').splitlines();ix=next(i for i,x in enumerate(finish) if '#finishers ma_ctx matches 2..' in x);finish.insert(ix,f'execute store result score #finishers ma_ctx run data get {S} s.finishers');put('jobs/finish',finish)
    finish=(ROOT/'jobs/finish.mcfunction').read_text(encoding='utf-8').splitlines();ix=next(i for i,x in enumerate(finish) if 'score #finishers ma_ctx run data get' in x);finish.insert(ix+1,save('events[-1].amount','finishers'));put('jobs/finish',finish)
    action=(ROOT/'action.mcfunction').read_text(encoding='utf-8').splitlines();put('action',[('execute unless score #code ma_ctx matches 4 run '+x) if x==f'data modify {S} s.seen set value []' else x for x in action])

def build_batches():
    # Uniform and non-uniform multi-racer moves use one immutable before-image.
    # Landing hooks carry the entire arrival group, implementing the 2026 rule.
    apply=[f'$data modify {S} s.racers[$(pawn)].pos set from {S} s.motion.to',f'$execute if data {S} s.motion.targets[$(pawn)] run data modify {S} s.racers[$(pawn)].pos set from {S} s.motion.targets[$(pawn)]',f'$data modify {S} e set value {{kind:1,pawn:$(pawn),from:0,to:0,source:-2,amount:0,die:0}}',f'$data modify {S} e.from set from {S} s.motion.before[$(pawn)]',f'$data modify {S} e.to set from {S} s.racers[$(pawn)].pos',f'data modify {S} e.source set from {S} s.motion.source',f'data modify {S} s.events append from {S} e'];put('move/apply',apply)
    hooks=(ROOT/'move/hooks.mcfunction').read_text(encoding='utf-8').splitlines();hooks=[x.replace(f'hook.from set from {S} s.motion.from',f'hook.from set from {S} s.motion.before[$(pawn)]') for x in hooks];put('move/hooks',['$'+x if '$(pawn)' in x and not x.startswith('$') else x for x in hooks])
    batchbase=[fn('active_context'),f'data modify {S} s.motion set value {{pawn:0,from:0,to:0,source:0,group:[],before:[],targets:[]}}',f'data modify {S} s.motion.pawn set from {S} s.active',save('motion.from','position')]
    for j in range(6):batchbase +=[f'data modify {S} s.motion.before append from {S} s.racers[{j}].pos',f'data modify {S} s.motion.targets append from {S} s.racers[{j}].pos']
    cheer=batchbase+[f'data modify {S} s.motion.source set value 5','scoreboard players set #last ma_ctx 31']
    for j in range(6):cheer +=[f'execute if score #s{j} ma_ctx matches 0 if score #x{j} ma_ctx < #last ma_ctx run scoreboard players operation #last ma_ctx = #x{j} ma_ctx']
    for j in range(6):cheer +=[f'execute if score #s{j} ma_ctx matches 0 if score #x{j} ma_ctx = #last ma_ctx run '+fn('batch/cheer_one')+f' {{pawn:{j}}}']
    cheer +=[f'data modify {S} add set value {{type:"move",pawn:0,amount:1,source:5}}',f'data modify {S} add.pawn set from {S} s.active',f'data modify {S} s.queue prepend from {S} add',front('postmove')];put('jobs/cheer',cheer)
    put('batch/cheer_one',[f'$execute store result score #destination ma_ctx run data get {S} s.racers[$(pawn)].pos','scoreboard players add #destination ma_ctx 2','execute if score #destination ma_ctx matches 31.. run scoreboard players set #destination ma_ctx 30',f'$execute store result {S} s.motion.targets[$(pawn)] int 1 run scoreboard players get #destination ma_ctx',f'$data modify {S} s.motion.group append value $(pawn)'])
    party=batchbase+[f'data modify {S} s.motion.source set value 26']
    for j in range(6):party +=[f'execute unless score #i ma_ctx matches {j} if score #s{j} ma_ctx matches 0 unless score #x{j} ma_ctx = #position ma_ctx run '+fn('batch/party_one')+f' {{pawn:{j}}}']
    party +=[front('postmove')];put('jobs/party',party)
    put('batch/party_one',[f'$execute store result score #destination ma_ctx run data get {S} s.racers[$(pawn)].pos','execute if score #destination ma_ctx < #position ma_ctx run scoreboard players add #destination ma_ctx 1','execute if score #destination ma_ctx > #position ma_ctx run scoreboard players remove #destination ma_ctx 1',f'$execute store result {S} s.motion.targets[$(pawn)] int 1 run scoreboard players get #destination ma_ctx',f'$data modify {S} s.motion.group append value $(pawn)'])

def build_power_refinements():
    # Every bonus/penalty actually used is an independent power activation.
    main=(ROOT/'jobs/main.mcfunction').read_text(encoding='utf-8').splitlines()
    ix=next(i for i,x in enumerate(main) if 's.queue append from' in x)
    own=[]
    for p in (3,14):own +=[f'execute if score #power ma_ctx matches {p} run '+fn('notify_active')]
    own +=[f'execute if score #power ma_ctx matches 21 if data {S} s{{dice:0}} run '+fn('notify_active'),f'execute if score #power ma_ctx matches 0 if data {S} s{{transmuted:1}} run '+fn('notify_active'),f'execute if score #power ma_ctx matches 27 if data {S} s{{bomb:1}} run '+fn('notify_active')]
    main[ix:ix]=own;put('jobs/main',main)
    put('notify_active',[f'data modify {S} notify set value {{type:"power",pawn:0}}',f'data modify {S} notify.pawn set from {S} s.active',f'data modify {S} s.queue append from {S} notify'])
    extend('turn/start',[f'data modify {S} s.used_merchants set value []',f'data modify {S} s.transmuted set value 0'],prepend=True)
    extend('choices/alchemist',[f'execute if score #target ma_ctx matches 1 run data modify {S} s.transmuted set value 1'],prepend=True)
    # Replacements and passive events must also awaken Scoocher. Record these
    # at the moment their mandatory/optional rule actually takes effect.
    for name in ('choices/hypnotist','choices/thirdwheel'):
        extend(name,['execute if score #target ma_ctx matches 0.. run '+fn('notify_active')])
    extend('jobs/swap',[fn('notify_active')])
    extend('jobs/cheer',[fn('notify_active')])
    extend('jobs/party',[fn('notify_active')])
    # One reroll allowance belongs to each active Dicemonger, rather than one
    # global allowance; this matters when Copycat gains the same power.
    offer=[fn('active_context'),get('die','dice'),'scoreboard players set #can ma_ctx 0',get('rerolls','rerolls'),'execute if score #power ma_ctx matches 23 if score #rerolls ma_ctx matches ..1 run scoreboard players set #can ma_ctx 1']
    for j in range(6):offer +=[f'execute if score #s{j} ma_ctx matches 0 if score #p{j} ma_ctx matches 8 unless data {S} s{{used_merchants:[{j}]}} run scoreboard players set #can ma_ctx 1']
    offer +=[fn('dice_event'),'execute if score #can ma_ctx matches 1 run '+fn('offer_reroll'),'execute if score #can ma_ctx matches 0 run '+queue('roll_accept')];put('roll_offer',offer)
    reroll=[fn('active_context'),get('rerolls','rerolls'),'scoreboard players set #native ma_ctx 0','execute if score #power ma_ctx matches 23 if score #rerolls ma_ctx matches ..1 run scoreboard players set #native ma_ctx 1','execute if score #native ma_ctx matches 1 run scoreboard players add #rerolls ma_ctx 1',save('rerolls','rerolls'),'scoreboard players set #merchant_pawn ma_ctx -1']
    for j in range(6):reroll +=[f'execute if score #native ma_ctx matches 0 if score #s{j} ma_ctx matches 0 if score #p{j} ma_ctx matches 8 unless data {S} s{{used_merchants:[{j}]}} if score #merchant_pawn ma_ctx matches -1 run scoreboard players set #merchant_pawn ma_ctx {j}']
    reroll +=['execute if score #native ma_ctx matches 1 run '+fn('notify_active')]
    for j in range(6):reroll +=[f'execute if score #merchant_pawn ma_ctx matches {j} run data modify {S} s.used_merchants append value {j}',f'execute if score #merchant_pawn ma_ctx matches {j} unless score #i ma_ctx matches {j} run '+queue('move',pawn=j,amount=1,source=8),f'execute if score #merchant_pawn ma_ctx matches {j} if score #i ma_ctx matches {j} run '+queue('power',pawn=j)]
    reroll +=[queue('roll')];put('reroll',reroll)
    # Leaptoad activates once for each occupied square skipped, even if adjacent.
    extend('move/leap',['scoreboard players set #jumped ma_ctx 0'],prepend=True)
    leap=(ROOT/'move/leap_step.mcfunction').read_text(encoding='utf-8').splitlines();idx=next(i for i,x in enumerate(leap) if '#occupied ma_ctx matches 0 run scoreboard players remove' in x);leap[idx:idx]=['execute if score #occupied ma_ctx matches 1 run scoreboard players add #jumped ma_ctx 1'];put('move/leap_step',leap)
    move=(ROOT/'jobs/move.mcfunction').read_text(encoding='utf-8').splitlines();idx=next(i for i,x in enumerate(move) if 's.motion.to int' in x);move[idx:idx]=[f'execute if score #power ma_ctx matches 20 run data modify {S} s.motion.jumps set value 0',f'execute if score #power ma_ctx matches 20 run execute store result {S} s.motion.jumps int 1 run scoreboard players get #jumped ma_ctx'];put('jobs/move',move)
    notify=(ROOT/'move/notify.mcfunction').read_text(encoding='utf-8').splitlines();notify[0:0]=[f'execute if data {S} s.motion.jumps run '+fn('notify_jumps')];put('move/notify',notify)
    put('notify_jumps',[get('jump_count','motion.jumps'),f'data modify {S} jump_notify set value {{type:"power",pawn:0}}',f'data modify {S} jump_notify.pawn set from {S} s.motion.pawn',fn('notify_jump_loop')])
    put('notify_jump_loop',['execute unless score #jump_count ma_ctx matches 1.. run return 0',f'data modify {S} s.queue prepend from {S} jump_notify','scoreboard players remove #jump_count ma_ctx 1',fn('notify_jump_loop')])
    # Giant Baby displacements land on their final square, including its track
    # effects, while landing on Banana also counts as passing that Banana.
    baby=(ROOT/'move/baby.mcfunction').read_text(encoding='utf-8').splitlines()
    baby +=[f'$execute if score #p$(pawn) ma_ctx matches 2 if data {S} s.motion{{group:[$(baby)]}} run '+front('trip',pawn='BABY',source=2).replace('"BABY"','$(baby)'),f'$data modify {S} baby_hook set value {{type:"land",pawn:$(pawn),from:0,to:0,source:16,group:[$(pawn)],before:[],moved:0}}',f'$data modify {S} baby_hook.from set from {S} s.motion.before[$(pawn)]',f'$data modify {S} baby_hook.to set from {S} s.racers[$(pawn)].pos',f'data modify {S} baby_hook.before set from {S} s.motion.before',f'$execute unless data {S} s.motion{{group:[$(pawn)]}} run data modify {S} s.queue prepend from {S} baby_hook',f'$data modify {S} baby_hook set value {{type:"power",pawn:$(baby)}}',f'data modify {S} s.queue append from {S} baby_hook']
    put('move/baby',baby)
    # The above placement powers are subject to the same exact-state loop rule
    # as ordinary landings. A second blocked arrival is suppressed completely.
    post=(ROOT/'jobs/postmove.mcfunction').read_text(encoding='utf-8').splitlines();post.insert(0,fn('motion_cycle'));post.insert(1,'execute if score #motion_repeat ma_ctx matches 1 run return 0');put('jobs/postmove',post)
    put('motion_cycle',[f'data modify {S} motion_signature.sig set value {{motion:{{}},racers:[]}}',f'data modify {S} motion_signature.sig.motion set from {S} s.motion',f'data modify {S} motion_signature.sig.racers set from {S} s.racers',fn('motion_match')+' with storage magical_athlete:engine motion_signature','execute if score #motion_repeat ma_ctx matches 1 run return 0',f'data modify {S} s.seen append from {S} motion_signature.sig'])
    put('motion_match',[f'$execute store success score #motion_repeat ma_ctx if data {S} s.seen[$(sig)]',f'execute if score #motion_repeat ma_ctx matches 1 run data modify {S} s.loop set value 1'])

def build_copy_interrupt():
    # Copycat's tied-leader choice belongs to its owner, even on someone else's
    # turn. Freeze a choice throughout one action; allow a new choice next turn.
    action=(ROOT/'action.mcfunction').read_text(encoding='utf-8').splitlines();ix=next(i for i,x in enumerate(action) if x==fn('dispatch'));action[ix:ix]=[f'execute unless score #code ma_ctx matches 4 run data modify {S} s.copy_locks set value [0,0,0,0,0,0]'];put('action',action)
    drain=(ROOT/'drain_loop.mcfunction').read_text(encoding='utf-8').splitlines();ix=next(i for i,x in enumerate(drain) if x==fn('job_dispatch'));drain[ix:ix]=[fn('copy_interrupt'),f'execute if data {S} s.pending.options[0] run data modify {S} s.queue prepend from {S} job',f'execute if data {S} s.pending.options[0] run return 0'];put('drain_loop',drain)
    body=[]
    for j in range(6):body +=[get('raw',f'racers[{j}].power'),get('lock',f'copy_locks[{j}]'),f'execute if score #s{j} ma_ctx matches 0 if score #raw ma_ctx matches 7 if score #lock ma_ctx matches 0 run '+fn('copy/offer')+f' {{pawn:{j}}}',f'execute if data {S} s.pending.options[0] run return 0']
    put('copy_interrupt',body)
    offer=['scoreboard players set #lead ma_ctx -1']
    for j in range(6):offer +=[f'execute if score #s{j} ma_ctx matches 0 if score #x{j} ma_ctx > #lead ma_ctx run scoreboard players operation #lead ma_ctx = #x{j} ma_ctx']
    offer +=[f'$data modify {S} s.pending set value {{kind:"copycat",owner:0,pawn:$(pawn),options:[]}}',f'$data modify {S} s.pending.owner set from {S} s.racers[$(pawn)].owner',f'$data modify {S} s.copy_locks[$(pawn)] set value 1']
    for j in range(6):offer +=[f'execute if score #s{j} ma_ctx matches 0 if score #x{j} ma_ctx = #lead ma_ctx unless score #p{j} ma_ctx matches -1 run data modify {S} s.pending.options append value {j}']
    offer +=[f'execute store result score #count ma_ctx run data get {S} s.pending.options',f'execute unless score #count ma_ctx matches 2.. run data modify {S} s.pending set value {{kind:"",owner:0,pawn:-1,options:[]}}'];put('copy/offer',offer)
    # The universal interrupt supersedes the old owner-turn-only wrapper.
    put('jobs/begin',(ROOT/'jobs/begin_actual.mcfunction').read_text(encoding='utf-8'))

def build_immediate_finish():
    # Crossing the finish line immediately disables powers. In particular a
    # Scoocher/follower arrival must not open another follow prompt at space 30.
    post=(ROOT/'jobs/postmove.mcfunction').read_text(encoding='utf-8').splitlines()
    ix=max(i for i,x in enumerate(post) if 'engine/move/apply' in x)+1
    post[ix:ix+0]=[fn('move/finish_arrivals'),f'execute if data {S} s{{phase:4}} run return 0',f'execute if data {S} s{{phase:5}} run return 0']
    put('jobs/postmove',post)
    finish=[]
    for turn in range(1,7):
        for owner in list(range(turn,7))+list(range(1,turn)):
            for j in range(6):
                finish +=[f'execute if score #turn ma_ctx matches {turn} if score #o{j} ma_ctx matches {owner} if data {S} s.motion{{group:[{j}]}} run '+fn('move/finish_one')+f' {{pawn:{j}}}',f'execute if data {S} s{{phase:4}} run return 0',f'execute if data {S} s{{phase:5}} run return 0']
    put('move/finish_arrivals',finish)
    put('move/finish_one',[f'$execute store result score #finished_pos ma_ctx run data get {S} s.racers[$(pawn)].pos',f'$execute store result score #finished_status ma_ctx run data get {S} s.racers[$(pawn)].status','execute unless score #finished_status ma_ctx matches 0 run return 0','execute unless score #finished_pos ma_ctx matches 30.. run return 0',f'$data modify {S} job set value {{pawn:$(pawn)}}',fn('jobs/finish')+' with storage magical_athlete:engine job'])

def build_activation_timing():
    # A skill's separate physical movements are not separate activations. A
    # Cheerleader use moves a group then herself, but awakens Scoocher once.
    notify=(ROOT/'move/notify.mcfunction').read_text(encoding='utf-8').splitlines()
    # Keep follower notifications independent, even for a group ability.
    followers=[x for x in notify if 's.motion{group:' in x]
    notify=[x for x in notify if x not in followers]
    ix=next(i for i,x in enumerate(notify) if 'unless score #source ma_ctx matches 0..35' in x)
    notify[ix:ix]=followers
    ix=next(i for i,x in enumerate(notify) if 'unless score #source ma_ctx matches 0..35' in x)
    notify[ix+1:ix+1]=['execute if score #source ma_ctx matches 5 run return 0','execute if score #source ma_ctx matches 26 run return 0','execute if score #source ma_ctx matches 20 run return 0']
    # The author is saved before moving, including when that author finishes.
    a=next(i for i,x in enumerate(notify) if 'scoreboard players set #author' in x)
    z=next(i for i,x in enumerate(notify) if x.startswith('execute if score #author'))
    notify[a:z]=[get('author','motion.author')]
    put('move/notify',notify)
    move=(ROOT/'jobs/move.mcfunction').read_text(encoding='utf-8').splitlines();ix=next(i for i,x in enumerate(move) if 's.motion.source set' in x);move[ix+1:ix+1]=[f'data modify {S} s.motion.author set from {S} job.pawn',f'execute if data {S} job.author run data modify {S} s.motion.author set from {S} job.author'];put('jobs/move',move)
    centaur=(ROOT/'react/centaur.mcfunction').read_text(encoding='utf-8').splitlines();put('react/centaur',[('$'+x.replace('"source":4}', '"source":4,"author":$(reactor)}')) if '"source":4}' in x else x for x in centaur])
    duel=(ROOT/'duel_roll.mcfunction').read_text(encoding='utf-8').splitlines();ix=next(i for i,x in enumerate(duel) if 's.queue prepend from' in x);duel.insert(ix,f'$data modify {S} add.author set value $(pawn)');put('duel_roll',duel)
    # All other actual activations (rather than predictions/declined choices).
    roll=(ROOT/'jobs/roll_done.mcfunction').read_text(encoding='utf-8').splitlines();ix=next(i for i,x in enumerate(roll) if 's.extra set from' in x);roll.insert(ix+1,'execute if score #power ma_ctx matches 12 if score #prediction ma_ctx = #die ma_ctx run '+fn('notify_active'))
    for j in range(6):roll +=[f'execute if score #s{j} ma_ctx matches 0 if score #p{j} ma_ctx matches 31 if score #die ma_ctx matches 1 run '+queue('power',pawn=j)]
    roll +=['execute if score #power ma_ctx matches 30 if score #die ma_ctx matches 6 run '+fn('notify_active')];put('jobs/roll_done',roll)
    pre=(ROOT/'jobs/pre.mcfunction').read_text(encoding='utf-8').splitlines();ix=next(i for i,x in enumerate(pre) if '#power ma_ctx matches 14' in x and 'turn_end' in x);pre.insert(ix,'execute if score #power ma_ctx matches 14 if score #position ma_ctx = #lead ma_ctx if score #alone ma_ctx matches 1 run '+fn('notify_active'));put('jobs/pre',pre)
    # When Baba Yaga arrives on multiple stationary racers, each trip is a
    # distinct trigger. No shared-arrival trigger is created between co-movers.
    baba=(ROOT/'react/baba_moving.mcfunction').read_text(encoding='utf-8').splitlines();extra=[]
    for j in range(6):extra +=[f'$execute unless data {S} job{{group:[{j}]}} if score #s{j} ma_ctx matches 0 if score #x{j} ma_ctx = #to ma_ctx run '+front('power',pawn='REACTOR').replace('"REACTOR"','$(reactor)')]
    put('react/baba_moving',baba+extra)
    mouth=(ROOT/'react/mouth_target.mcfunction').read_text(encoding='utf-8').splitlines();ix=next(i for i,x in enumerate(mouth) if 'race/survivor' in x);mouth[ix:ix]=[f'data modify {S} mouth_notify set value {{type:"power",pawn:0}}',f'data modify {S} mouth_notify.pawn set from {S} job.reactor',f'data modify {S} s.queue prepend from {S} mouth_notify'];put('react/mouth_target',mouth)
    extend('prerace/sisyphus',[f'$'+queue('power',pawn='PAWN').replace('"PAWN"','$(pawn)')])
    # On a blocked overshoot the moving racer stays still, but Stickler's power
    # did happen and can therefore move an active Scoocher.
    move=(ROOT/'jobs/move.mcfunction').read_text(encoding='utf-8').splitlines()
    for j in range(6):
        move=[x.replace('run return 0','run return run '+fn('stickler_block')+f' {{pawn:{j}}}') if f'if score #p{j} ma_ctx matches 32' in x and '31..' in x else x for x in move]
    put('jobs/move',move);put('stickler_block',f'$'+front('power',pawn='PAWN').replace('"PAWN"','$(pawn)')+'\nreturn 0')

def build_warp_arrivals():
    # Warps do not pass racers or carry Suckerfish, but they do stop on a
    # square. Therefore Huge Baby, track effects and stationary Baba Yaga all
    # use exactly the same arrival path as ordinary movements.
    warp=[fn('pawn_context')+' with storage magical_athlete:engine job','execute unless score #status ma_ctx matches 0 run return 0',f'data modify {S} s.motion set value {{pawn:0,from:0,to:0,source:-2,author:0,warp:1,group:[],before:[]}}',f'data modify {S} s.motion.pawn set from {S} job.pawn',f'data modify {S} s.motion.author set from {S} job.pawn',save('motion.from','position'),f'data modify {S} s.motion.to set from {S} job.to',f'data modify {S} s.motion.source set from {S} job.source',f'$data modify {S} s.motion.group append value $(pawn)']
    for j in range(6):warp +=[f'data modify {S} s.motion.before append from {S} s.racers[{j}].pos']
    warp +=[fn('jobs/postmove')];put('jobs/warp',warp)
    apply=(ROOT/'move/apply.mcfunction').read_text(encoding='utf-8').splitlines();ix=next(i for i,x in enumerate(apply) if 's.events append from' in x);apply.insert(ix,f'execute if data {S} s.motion{{warp:1}} run data modify {S} e.kind set value 2');put('move/apply',apply)
    hooks=(ROOT/'move/hooks.mcfunction').read_text(encoding='utf-8').splitlines();ix=next(i for i,x in enumerate(hooks) if 's.queue prepend from' in x);hooks.insert(ix,f'execute if data {S} s.motion{{warp:1}} run data modify {S} hook.moved set value 0');put('move/hooks',hooks)
    extend('move/notify',[f'execute if data {S} s.motion{{warp:1}} run return 0'],prepend=True)
    baby=(ROOT/'move/baby.mcfunction').read_text(encoding='utf-8').splitlines();put('move/baby',[x.replace('if score #p$(pawn)',f'unless data {S} s.motion{{warp:1}} if score #p$(pawn)') if '#p$(pawn) ma_ctx matches 2' in x else x for x in baby])
    swap=[fn('active_context'),f'data modify {S} s.motion set value {{pawn:0,from:0,to:0,source:11,author:0,warp:1,group:[],before:[],targets:[]}}',f'data modify {S} s.motion.pawn set from {S} s.active',f'data modify {S} s.motion.author set from {S} s.active',save('motion.from','position')]
    for j in range(6):swap +=[f'data modify {S} s.motion.before append from {S} s.racers[{j}].pos',f'data modify {S} s.motion.targets append from {S} s.racers[{j}].pos']
    swap +=[f'data modify {S} swap_args.pawn set from {S} s.active',f'data modify {S} swap_args.target set from {S} s.swap',fn('swap/targets')+' with storage magical_athlete:engine swap_args',fn('jobs/postmove'),fn('notify_active')];put('jobs/swap',swap)
    put('swap/targets',[f'$data modify {S} s.motion.targets[$(pawn)] set from {S} s.motion.before[$(target)]',f'$data modify {S} s.motion.targets[$(target)] set from {S} s.motion.before[$(pawn)]',f'$data modify {S} s.motion.group set value [$(pawn),$(target)]'])

def build_batch_distance():
    # A simultaneous group does not bypass the individual movement rules.
    # In particular Cheerleader cannot push someone through Stickler's finish
    # requirement, and Leaptoad still skips occupied squares in a group move.
    put('batch/cheer_one',[f'$'+fn('batch/arrive')+' {pawn:$(pawn),amount:2}'])
    party=[f'$execute store result score #other_pos ma_ctx run data get {S} s.racers[$(pawn)].pos','scoreboard players set #batch_amount ma_ctx 1','execute if score #other_pos ma_ctx > #position ma_ctx run scoreboard players set #batch_amount ma_ctx -1',f'$data modify {S} batch_args set value {{pawn:$(pawn),amount:1}}',f'execute store result {S} batch_args.amount int 1 run scoreboard players get #batch_amount ma_ctx',fn('batch/arrive')+' with storage magical_athlete:engine batch_args',fn('active_context')];put('batch/party_one',party)
    arrive=[f'$scoreboard players set #i ma_ctx $(pawn)',f'$scoreboard players set #amount ma_ctx $(amount)',f'$execute store result score #position ma_ctx run data get {S} s.racers[$(pawn)].pos',f'$scoreboard players operation #power ma_ctx = #p$(pawn) ma_ctx','scoreboard players operation #destination ma_ctx = #position ma_ctx','scoreboard players operation #destination ma_ctx += #amount ma_ctx','execute if score #power ma_ctx matches 20 run '+fn('move/leap')]
    for j in range(6):arrive +=[f'execute if score #s{j} ma_ctx matches 0 if score #p{j} ma_ctx matches 32 unless score #i ma_ctx matches {j} if score #destination ma_ctx matches 31.. run return run '+fn('stickler_block')+f' {{pawn:{j}}}']
    arrive +=['execute if score #destination ma_ctx matches 31.. run scoreboard players set #destination ma_ctx 30','execute if score #destination ma_ctx matches ..-1 run scoreboard players set #destination ma_ctx 0',f'$execute store result {S} s.motion.targets[$(pawn)] int 1 run scoreboard players get #destination ma_ctx',f'$data modify {S} s.motion.group append value $(pawn)',f'$execute if score #power ma_ctx matches 20 run '+fn('batch/leap_notify')+' {pawn:$(pawn)}'];put('batch/arrive',arrive)
    put('batch/leap_notify',['execute unless score #jumped ma_ctx matches 1.. run return 0',f'$'+queue('power',pawn='PAWN').replace('"PAWN"','$(pawn)'),'scoreboard players remove #jumped ma_ctx 1',f'$'+fn('batch/leap_notify')+' {pawn:$(pawn)}'])

if __name__=='__main__':build()
