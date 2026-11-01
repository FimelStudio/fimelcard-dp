"""独立原版 26.2 掼蛋牌型测试；Python 暴力替换 oracle 与运行时缺口算法互相校验。"""
from pathlib import Path
from collections import Counter
import argparse
import itertools
import json
import random
import re
import shutil
import subprocess
import tempfile
import time

PACK=Path(__file__).resolve().parents[1]
TABLE='@e[type=minecraft:marker,tag=gt.table,scores={ct_id=101},limit=1]'
OTHER='@e[type=minecraft:marker,tag=gt.table,scores={ct_id=202},limit=1]'


def point(card):
    card%=54
    return card%13+2 if card<52 else card-37


def strength(rank,level):
    return rank+1 if rank>=15 else 15 if rank==level else rank


def oracle(cards,level):
    """独立枚举百搭的自然点数，再按精确牌形分类；不复用生成器的缺口检查。"""
    if not 1<=len(cards)<=10 or len(set(cards))!=len(cards) or any(c<0 or c>107 for c in cards):return set()
    wild=[c for c in cards if c%54==26+level-2]
    real=[c for c in cards if c not in wild]
    ranks=[point(c) for c in real]
    n=len(cards);out=set()
    if n==1:return {(1,1,strength(point(cards[0]),level),0,-1)}
    natural_flush=not wild and len({c%54//13 for c in real})==1
    flush_suit=next(iter({c%54//13 for c in real})) if real and all(c%54<52 for c in real) and len({c%54//13 for c in real})==1 else -1
    for replacement in itertools.product(range(2,15),repeat=len(wild)):
        values=ranks+list(replacement);counts=Counter(values)
        if len(counts)==1:
            r=values[0]
            if n==2:out.add((2,2,strength(r,level),0,-1))
            if n==3 and r<=14:out.add((3,3,strength(r,level),0,-1))
            if 4<=n<=10 and r<=14:out.add((8,n,strength(r,level),n if n<=5 else n+1,-1))
        if n==5 and sorted(counts.values())==[2,3]:
            trip=next(r for r,c in counts.items() if c==3)
            if trip<=14:out.add((4,5,strength(trip,level),0,-1))
        if n==4 and counts=={15:2,16:2}:out.add((10,4,17,99,-1))
        for low_ace in (False,True):
            seq=sorted(1 if low_ace and r==14 else r for r in counts)
            if not seq or max(seq)>14 or not all(a+1==b for a,b in zip(seq,seq[1:])):continue
            if n==6 and len(counts)==3 and set(counts.values())=={2}:out.add((5,6,max(seq),0,-1))
            if n==6 and len(counts)==2 and set(counts.values())=={3}:out.add((6,6,max(seq),0,-1))
            if n==5 and len(counts)==5:
                if not natural_flush:out.add((7,5,max(seq),0,-1))
                if flush_suit>=0:out.add((9,5,max(seq),6,flush_suit))
    return out


def beats(candidate,last=None):
    if not last or last[0]==0:return True
    kind,size,high,power,_=candidate;lk,ls,lh,lp,*_=last
    return power>lp or power==lp and kind==lk and size==ls and high>lh


def pick(ranks,suits=None,level=2):
    """把自然点数/王映射为真实、互异的两副 physical id。"""
    used=set();out=[]
    for i,rank in enumerate(ranks):
        suits_for_card=[suits[i]] if suits else [0,1,2,3]
        candidates=[52 if rank==15 else 53] if rank>=15 else [s*13+rank-2 for s in suits_for_card]
        if rank<15 and not suits:candidates.sort(key=lambda c:c==26+level-2)
        chosen=next(c+deck*54 for deck in range(2) for c in candidates if c+deck*54 not in used)
        used.add(chosen);out.append(chosen)
    return tuple(out)


class Suite:
    def __init__(self):self.files,self.cases,self.expected={},[],[]
    def file(self,name,lines):self.files[name]=('\n'.join(lines) if isinstance(lines,list) else lines).strip()+'\n'
    def check(self,condition,name):
        assert name not in self.expected,name
        self.expected.append(name)
        return [f'execute if {condition} run say GUANDAN_PASS {name}',f'execute unless {condition} run say GUANDAN_FAIL {name}']
    def score(self,target,obj,value,name):return self.check(f'score {target} {obj} matches {value}',name)
    def data(self,target,path,value,name):
        return [f'data modify storage guandan_test:run cmp set value {json.dumps(value,separators=(",",":"))}',f'execute store success score #source gt run data get entity {target} {path}',f'execute store success score #different gt run data modify storage guandan_test:run cmp set from entity {target} {path}','execute unless score #source gt matches 1 run scoreboard players set #different gt 1']+self.score('#different','gt',0,name)
    def count(self,selector,expected,name):return ['scoreboard players set #count gt 0',f'execute as {selector} run scoreboard players add #count gt 1']+self.score('#count','gt',expected,name)
    def call(self,name,table=101):return [f'execute as {TABLE if table==101 else OTHER} at @s run function guandan:{name}']
    def case(self,name,lines):self.cases.append(name);self.file('case/'+name,lines)
    def setup(self,cards,level=2,last=None,table=101,reset=True):
        ctrl=TABLE if table==101 else OTHER
        lines=['function guandan_test:reset'] if reset else []
        lines +=[f'execute positioned {8.0 if table==101 else 40.0} 64.0 8.0 summon minecraft:marker run function guandan_test:table {{table:{table},level:{level}}}']
        for card in cards:lines +=[f'execute positioned 8.0 64.0 8.0 summon minecraft:marker run function guandan_test:card {{table:{table},id:{card},type:{card%54}}}']
        if last:
            for obj,v in zip(('gd_lastkind','gd_lastsize','gd_lasthi','gd_lastpow'),last):lines+=[f'scoreboard players set {ctrl} {obj} {v}']
        return lines
    def compare_options(self,cards,level,key,last=None):
        expected=oracle(cards,level)
        c=self.setup(cards,level,last)+self.call('cards/analyze')+self.score('#options','gd_ctx',len(expected),key+'_count')
        for kind,size,high,power,suit in sorted(expected):
            suffix=f'{kind}_{size}_{high}_{suit+1}'
            c+=self.check(f'data entity {TABLE} data.guandan.options[{{kind:{kind},size:{size},high:{high},power:{power},suit:{suit},beat:{int(beats((kind,size,high,power,suit),last))}}}]',key+'_'+suffix)
        self.case(key,c)
    def prepare(self):
        self.file('reset',['kill @e[tag=gt.fixture]'])
        self.file('table','''
tag @s add gt.fixture
tag @s add gt.table
tag @s add ct.controller
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s gd_level $(level)
scoreboard players set @s gd_lastkind 0
scoreboard players set @s gd_lastsize 0
scoreboard players set @s gd_lasthi 0
scoreboard players set @s gd_lastpow 0
data modify entity @s data set value {guandan:{options:[]}}
''')
        self.file('card','''
tag @s add gt.fixture
tag @s add gd.card
tag @s add gd.selected
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s gd_id $(id)
$scoreboard players set @s gd_type $(type)
scoreboard players set @s gd_owner 1
scoreboard players set @s gd_sel 1
scoreboard players set @s gd_used 0
''')
    def finish(self):
        objectives=['ct_id','gd_level','gd_id','gd_type','gd_owner','gd_sel','gd_used']
        self.file('bootstrap',['forceload add 0 0 47 15','scoreboard objectives add gt dummy']+[f'scoreboard objectives add {o} dummy' for o in objectives]+['function guandan:cards/install','function guandan:cards/constants','function guandan_test:reset',f'schedule function guandan_test:case/{self.cases[0]} 2t'])
        self.file('finish','say GUANDAN_FINISHED')
        for i,name in enumerate(self.cases):self.files['case/'+name]+='schedule function guandan_test:'+('case/'+self.cases[i+1] if i+1<len(self.cases) else 'finish')+' 1t\n'
    def build(self):
        self.prepare();index=0
        for level in range(2,15):
            for card in range(54):
                self.compare_options((card,),level,f'single_{level}_{card}')
            # 所有等级下，级牌/大小王/百搭的基本、炸弹及三带二组合。
            for r in (2,5,level,14,15,16):
                for size in range(2,11 if r<15 and r!=level else 9 if r==level else 3):
                    try:cards=pick([r]*size,level=level)
                    except StopIteration:continue
                    self.compare_options(cards,level,f'same_{level}_{r}_{size}_{index}');index+=1
            wild=26+level-2
            for r in dict.fromkeys((2,5,level,14)):
                for n in range(1,9):
                    for nw in (1,2):
                        if n+nw>10:continue
                        try:cards=list(pick([r]*n,level=level))
                        except StopIteration:continue
                        if wild in cards or wild+54 in cards:continue
                        cards +=[wild]+([wild+54] if nw==2 else [])
                        self.compare_options(tuple(cards),level,f'wild_{level}_{r}_{n}_{nw}')
            for trip,pair in ((2,3),(5,14),(level,15),(14,16)):
                cards=pick([trip]*3+[pair]*2,level=level)
                self.compare_options(cards,level,f'full_{level}_{trip}_{pair}_{index}');index+=1
            for low,length,multi in itertools.product((1,2,7,10,12,13),(2,3,5),(1,2,3)):
                if (length,multi) not in ((2,3),(3,2),(5,1)) or low+length>15:continue
                ranks=[14 if r==1 else r for r in range(low,low+length) for _ in range(multi)]
                cards=pick(ranks,level=level)
                self.compare_options(cards,level,f'seq_{level}_{low}_{length}_{multi}')
                # 移除一张普通牌、换入一个逢人配；检查由自然牌诱导出的全部百搭解释。
                if wild not in cards:
                    self.compare_options((wild,)+cards[1:],level,f'seq_wild_{level}_{low}_{length}_{multi}')
            self.compare_options(pick([15,15,16,16]),level,f'four_joker_{level}')
            for low,suit,nw in itertools.product((1,2,7,10),range(4),range(3)):
                ranks=[14 if r==1 else r for r in range(low,low+5)]
                cards=list(pick(ranks,suits=[suit]*5,level=level))
                if any(c%54==wild for c in cards):continue
                if nw:cards=cards[:-nw]+[wild]+([wild+54] if nw==2 else [])
                self.compare_options(tuple(cards),level,f'flush_{level}_{low}_{suit}_{nw}')
        # 任意非法/混合牌及三带二双百搭歧义，使用固定随机种子保证可重现。
        rng=random.Random(260218)
        for i in range(250):
            level=rng.randrange(2,15);n=rng.randrange(2,11)
            cards=tuple(rng.sample(range(108),n))
            self.compare_options(cards,level,f'random_{i}')
        for level in (2,7,14):
            wild=26+level-2
            for ranks in ((3,3,4),(3,4,4),(3,3,3),(15,15,3),(15,16,3),(3,4,5),(14,2,3),(12,13,14)):
                cards=pick(ranks,level=level)
                if wild not in cards:self.compare_options(cards+(wild,wild+54),level,f'ambiguous_{level}_{"_".join(map(str,ranks))}')
        # 所有三带二点数组合：王只能为自然对子，不能被逢人配补足。
        for trip,pair,level in itertools.product(range(2,15),range(2,17),(2,7,14)):
            if trip==pair:continue
            cards=pick([trip]*3+[pair]*2,level=level)
            self.compare_options(cards,level,f'full_all_{level}_{trip}_{pair}')
            wild=26+level-2
            if wild not in cards and wild+54 not in cards:
                self.compare_options(cards[:3]+cards[4:]+(wild,),level,f'full_missing_pair_{level}_{trip}_{pair}')
        # 非法的长顺、四连对、三组三张、JQKA2，以及任何含王的序列。
        for i,ranks in enumerate(((2,3,4,5,6,7),(2,2,3,3,4,4,5,5),(3,3,3,4,4,4,5,5,5),(11,12,13,14,2),(10,11,12,13,15),(2,3,4,15,16))):
            self.compare_options(pick(ranks,level=8),8,f'invalid_shape_{i}')
        self.compare_options(tuple(range(11)),8,'over_ten_rejected')
        self.compare_options((),8,'empty_rejected')
        # 牌型比较穷举：同级不盖、普通牌型须相同、炸弹张数压点数、同花顺的夹层。
        candidates=[(1,1,2,0,-1),(1,1,15,0,-1),(1,1,16,0,-1),(1,1,17,0,-1),(2,2,14,0,-1),(3,3,14,0,-1),(4,5,14,0,-1),(5,6,3,0,-1),(5,6,14,0,-1),(6,6,2,0,-1),(6,6,14,0,-1),(7,5,5,0,-1),(7,5,14,0,-1),(8,4,2,4,-1),(8,4,15,4,-1),(8,5,2,5,-1),(8,5,15,5,-1),(9,5,5,6,0),(9,5,14,6,3)]+[(8,n,2,n+1,-1) for n in range(6,11)]+[(10,4,17,99,-1)]
        for i,(candidate,last) in enumerate(itertools.product(candidates,candidates+[(0,0,0,0,-1)])):
            c=self.setup((),last=last)
            c +=[f'scoreboard players set {TABLE} {o} {v}' for o,v in zip(('gd_kind','gd_size','gd_high','gd_power'),candidate)]
            c+=self.call('cards/compare')+self.score('#beats','gd_ctx',int(beats(candidate,last)),f'compare_{i}')
            self.case(f'compare_{i}',c)
        # 桌隔离：另一桌带 selected 的牌不能污染牌型。
        c=self.setup(pick([3,3]))+self.setup(pick([4,4,4]),table=202,reset=False)+self.call('cards/analyze')+self.score('#options','gd_ctx',1,'tables_first_count')+self.check(f'data entity {TABLE} data.guandan.options[{{kind:2,high:3}}]','tables_first_pair')+self.call('cards/analyze',202)+self.check(f'data entity {OTHER} data.guandan.options[{{kind:3,high:4}}]','tables_second_trip')
        self.case('tables',c)
        # 旧候选在上手更新后必须重新比较；无效候选不写控制器或消耗选中牌。
        c=self.setup(pick([3,3]))+self.call('cards/analyze')+['scoreboard players set #choice gd_ctx 0']+self.call('cards/choose')+self.score('#ok','gd_ctx',1,'choose_accept')+self.score(TABLE,'gd_kind',2,'choose_pair')
        c +=[f'scoreboard players set {TABLE} gd_lastkind 2',f'scoreboard players set {TABLE} gd_lastsize 2',f'scoreboard players set {TABLE} gd_lasthi 14',f'scoreboard players set {TABLE} gd_lastpow 0','scoreboard players set #choice gd_ctx 0']+self.call('cards/choose')+self.score('#ok','gd_ctx',0,'choose_stale_recompares')
        c +=['scoreboard players set #choice gd_ctx 99']+self.call('cards/choose')+self.score('#ok','gd_ctx',0,'choose_oob_rejects')+self.count('@e[tag=gd.card,scores={gd_owner=1,gd_sel=1,gd_used=0}]',2,'choose_no_cards_consumed')
        self.case('choose',c)
        self.finish()


def run(suite,isolated=True,prefix='fimel-guandan-cards-',prepare_target=None):
    """可供整局/UI/动画测试复用；默认隔离牌型模块，永不写玩家世界。"""
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--java',type=Path,default=Path('C:/Temp/fimel-uno-java25/jdk-25.0.5+8-jre/bin/java.exe'))
    parser.add_argument('--minecraft-root',type=Path,default=Path('D:/PCL2/MinecraftPcl'))
    parser.add_argument('--version',default='26.2-Fabric_0.19.3')
    parser.add_argument('--case')
    args=parser.parse_args()
    if args.case:
        if args.case not in suite.cases:raise SystemExit('Unknown case: '+args.case)
        suite.cases=[args.case]
        suite.files['case/'+args.case]=re.sub(r'schedule function guandan_test:[a-z_0-9/]+ 1t','schedule function guandan_test:finish 1t',suite.files['case/'+args.case])
        suite.files['bootstrap']=re.sub(r'schedule function guandan_test:case/[a-z_0-9/]+ 2t',f'schedule function guandan_test:case/{args.case} 2t',suite.files['bootstrap'])
        suite.expected=re.findall(r'GUANDAN_PASS ([a-z0-9_]+)',suite.files['case/'+args.case])
    out=Path(tempfile.mkdtemp(prefix=prefix));target=out/'packs/fimel_cards'
    if isolated:shutil.copytree(PACK/'data/guandan/function/cards',target/'data/guandan/function/cards')
    else:shutil.copytree(PACK/'data',target/'data')
    shutil.copy2(PACK/'pack.mcmeta',target/'pack.mcmeta')
    tagdir=target/'data/minecraft/tags/function';tagdir.mkdir(parents=True,exist_ok=True)
    (tagdir/'tick.json').write_text('{"values":[]}',encoding='utf-8')
    if isolated:(tagdir/'load.json').write_text('{"values":[]}',encoding='utf-8')
    if prepare_target:prepare_target(target)
    for name,body in suite.files.items():
        dest=target/'data/guandan_test/function'/(name+'.mcfunction');dest.parent.mkdir(parents=True,exist_ok=True);dest.write_text(body,encoding='utf-8')
    for name,body in {'test_environment/default.json':{'type':'minecraft:function','setup':'guandan_test:bootstrap'},'test_instance/game.json':{'type':'minecraft:function','environment':'guandan_test:default','function':'minecraft:always_pass','max_ticks':1,'setup_ticks':getattr(suite,'setup_ticks',len(suite.cases)+100),'required':True,'structure':'minecraft:empty'}}.items():
        dest=target/'data/guandan_test'/name;dest.parent.mkdir(parents=True,exist_ok=True);dest.write_text(json.dumps(body),encoding='utf-8')
    launch=args.minecraft_root/'versions'/args.version/(args.version+'.json');meta=json.loads(launch.read_text(encoding='utf-8-sig'));cp=[launch.with_suffix('.jar')]
    for lib in meta['libraries']:
        entry=lib.get('downloads',{}).get('artifact',{});path=args.minecraft_root/'libraries'/entry.get('path','')
        if entry.get('path') and path.is_file():cp.append(path)
    options=['-Xms256M','-Xmx1536M','-Djava.awt.headless=true','-Dfile.encoding=UTF-8','--enable-native-access=ALL-UNNAMED','-cp',';'.join(map(str,cp)),'net.minecraft.gametest.Main','--packs',str(out/'packs'),'--universe',str(out/'universe'),'--tests','guandan_test:*','--report',str(out/'gametest.xml')]
    argfile=out/'java-args.txt';argfile.write_text('\n'.join('"'+v.replace('\\','\\\\').replace('"','\\"')+'"' for v in options),encoding='utf-8')
    print('Guandan GameTest: '+str(out),flush=True);start=time.monotonic()
    proc=subprocess.run([str(args.java),'@'+str(argfile)],cwd=out,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True,encoding='utf-8',errors='replace',timeout=480)
    (out/'game.log').write_text(proc.stdout,encoding='utf-8')
    passed=set(re.findall(r'GUANDAN_PASS ([a-z0-9_]+)',proc.stdout));failed=sorted(set(re.findall(r'GUANDAN_FAIL ([a-z0-9_]+)',proc.stdout)))
    errors=[line for line in proc.stdout.splitlines() if any(s in line for s in ['[ERROR]','/ERROR]','Failed to load','Failed to parse','Unknown function','Unknown or incomplete command',"Couldn't parse",'Command execution stopped'])]
    result={'exit_code':proc.returncode,'seconds':round(time.monotonic()-start,1),'assertions':len(suite.expected),'passed':len(passed),'failed':failed,'missing':sorted(set(suite.expected)-passed),'errors':errors,'finished':'GUANDAN_FINISHED' in proc.stdout,'isolated':isolated,'output':str(out)}
    (out/'result.json').write_text(json.dumps(result,ensure_ascii=False,indent=2),encoding='utf-8')
    printable=dict(result);printable['missing']=printable['missing'][:25];printable['failed']=printable['failed'][:25]
    print(json.dumps(printable,ensure_ascii=False,indent=2),flush=True)
    return int(bool(proc.returncode or failed or result['missing'] or errors or not result['finished']))


if __name__=='__main__':
    suite=Suite();suite.build();raise SystemExit(run(suite))
