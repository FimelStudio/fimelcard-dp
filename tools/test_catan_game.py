"""原版26.2隔离世界：21号接入、生命周期、准确几何拾取与跨桌清理。

服务器真人选择仅在临时副本替换为盔甲架；客户端命令保留玩家选择器。
不会打开用户存档，不改变默认65536命令链预算。
"""
from pathlib import Path
import re
import sys
import subprocess
import math
from test_guandan_cards import Suite as BaseSuite, run, PACK
from catan_topology import HEXES, VERTICES, EDGES, hex_position, vertex_position

C='@e[type=minecraft:marker,tag=cg.table,scores={ct_id=101},limit=1]'
D=C.replace('101','202')
JAVA='C:/Temp/fimel-java25-validation/jdk-25.0.5+8-jre/bin/java.exe'


def person(p,table=101):return f'@e[type=minecraft:armor_stand,tag=cg.person,scores={{cg_id={table*10+p}}},limit=1]'


def fixture_hook(target):
    for module in ('game','system','player','input','ui'):
        for path in (target/f'data/catan/function/{module}').rglob('*.mcfunction'):
            result=[]
            for line in path.read_text(encoding='utf-8').splitlines():
                if 'if items entity' in line or 'run function catan:input/give' in line:continue
                if 'function catan:name/capture' in line:line='data modify storage catan:runtime name.value set value {text:"测试玩家"}'
                if not any(c in line for c in ('tellraw ','title ','dialog ','playsound ','stopsound ','item replace ','clear @')):
                    line=line.replace('@a[tag=','@e[type=minecraft:armor_stand,tag=cg.person,tag=')
                result.append(line)
            path.write_text('\n'.join(result)+'\n',encoding='utf-8')


class Suite(BaseSuite):
    def call(self,name,table=101):return [f'execute as {C if table==101 else D} at @s run function catan:{name}']
    def setup(self,cap=4,n=3,orient=0,first=1,table=101,reset=True):
        c=['function guandan_test:reset'] if reset else []
        c += [f'execute positioned {8 if table==101 else 40} 64 8 summon minecraft:marker run function guandan_test:table {{table:{table},cap:{cap},n:{n},orient:{orient},first:{first}}}']
        seats=range(1,n+1) if cap==4 else (1,3,5,7)[:n]
        for p,seat in enumerate(seats,1):c += [f'execute positioned {8 if table==101 else 40} 64 8 summon minecraft:armor_stand run function guandan_test:person {{id:{table*10+p},seat:{seat},table:{table}}}']
        return c
    def start(self,**kw):return self.setup(**kw)+self.call('game/start',kw.get('table',101))+[f'scoreboard players set {C if kw.get("table",101)==101 else D} ct_state 1']
    def prepare(self):
        self.file('reset',['kill @e[tag=cg.fixture]','kill @e[tag=ca.visual]','kill @e[tag=ca.surface]','kill @e[tag=ca.firework]','kill @e[tag=ct.menu]','kill @e[tag=ct.vote]'])
        self.file('table','''
tag @s add cg.fixture
tag @s add cg.table
tag @s add ct.controller
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ct_capacity $(cap)
$scoreboard players set @s ct_joined $(n)
$scoreboard players set @s ca_orient $(orient)
$scoreboard players set @s ca_first $(first)
scoreboard players set @s ca_music 0
scoreboard players set @s ca_layout 0
scoreboard players set @s ca_epoch 1
scoreboard players set @s ct_game 21
scoreboard players set @s ct_state 0
scoreboard players set @s ct_start 0
data merge entity @s {data:{cardtable:{menu_version:20,rules_version:5,chairs_version:1,vote_version:1}}}
function catan:game/init_table
''')
        self.file('person','''
tag @s add cg.fixture
tag @s add cg.person
tag @s add ct.player
$scoreboard players set @s cg_id $(id)
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ct_seat $(seat)
data merge entity @s {NoGravity:1b,Invisible:1b,Invulnerable:1b}
''')
    def finish(self):
        self.file('bootstrap',['forceload add 0 0 63 31','scoreboard objectives add gt dummy','scoreboard objectives add cg_id dummy','function catan:load','function guandan_test:reset',f'schedule function guandan_test:case/{self.cases[0]} 2t'])
        self.file('finish',['function guandan_test:reset','say GUANDAN_FINISHED'])
        for i,name in enumerate(self.cases):self.files['case/'+name]+='schedule function guandan_test:'+('case/'+self.cases[i+1] if i+1<len(self.cases) else 'finish')+' 2t\n'
        self.setup_ticks=len(self.cases)*2+200
    def build(self):
        self.prepare()
        for cap in (4,8):
            for n in (3,4):
                for orient in (0,1):
                    for first in (0,1):
                        name=f'start_{cap}_{n}_{orient}_{first}'
                        c=self.start(cap=cap,n=n,orient=orient,first=first)
                        c+=self.score(C,'ct_start',1,name+'_starts')+self.score(C,'ca_state',1,name+'_setup')+self.score(C,'ca_turn',1,name+'_turn')
                        c+=self.count('@e[tag=ca.surface,scores={ct_id=101}]',1,name+'_one_surface')
                        for p in range(1,n+1):
                            c+=self.count(f'@e[tag=ca.player,scores={{ca_table=101,ca_side={p}}}]',1,name+f'_side_{p}')
                            c+=self.check(f'data entity {C} data.catan.p{p}.name',name+f'_name_{p}')
                            c+=self.check(f'data entity {C} data.catan.p{p}.seat',name+f'_seat_{p}')
                        c+=self.call('system/reload')+self.score(C,'ca_state',1,name+'_reload_phase')+self.count('@e[tag=ca.surface,scores={ct_id=101}]',1,name+'_reload_single_surface')
                        self.case(name,c)
        # 同一脚本直接覆盖全54顶点、72边和19地块中心；不是按实现重写oracle。
        for cap,r in ((4,.25),(8,.35)):
            c=self.setup(cap=cap)+self.call('system/context')
            targets=[(1,h['id'],hex_position(h['id'],r)) for h in HEXES]+[(2,v['id'],vertex_position(v['id'],r)) for v in VERTICES]+[(3,i,tuple((a+b)/2 for a,b in zip(vertex_position(e[0],r),vertex_position(e[1],r)))) for i,e in enumerate(EDGES)]
            for batch in range(0,len(targets),10):
                c=self.setup(cap=cap)+self.call('system/context')
                for mode,idx,(x,z) in targets[batch:batch+10]:
                    c += [f'scoreboard players set #mode ca_ctx {mode}',f'scoreboard players set #x ca_ctx {round(x*4096)}',f'scoreboard players set #z ca_ctx {round(z*4096)}','scoreboard players set #target ca_ctx -1','scoreboard players set #best ca_ctx 2147483647',f'function catan:input/pick{cap}']
                    c+=self.score('#target','ca_ctx',idx,f'pick_{cap}_{mode}_{idx}')
                self.case(f'geometry_{cap}_{batch}',c)
            c=self.setup(cap=cap)+self.call('system/context')
            c+=['scoreboard players set #mode ca_ctx 1','scoreboard players set #x ca_ctx 16000','scoreboard players set #z ca_ctx 16000','scoreboard players set #target ca_ctx -1',f'function catan:input/pick{cap}']+self.score('#target','ca_ctx',-1,f'outside_{cap}')
            self.case(f'outside_{cap}',c)
        # 从真实全局相对位置二分提取本地坐标，旋转0/1各一遍。
        for orient in (0,1):
            c=self.setup(orient=orient)+self.call('system/context')+[f'scoreboard players set {C} ca_mode 1','execute positioned 9.3660254 65.025 8.5 summon minecraft:marker run tag @s add ca.ray']+self.call('input/ray_target')
            c+=self.score('#x','ca_ctx',('3540..3555' if orient==0 else '-4..4'),f'local_x_{orient}')+self.score('#z','ca_ctx',('-4..4' if orient==0 else '-3555..-3540'),f'local_z_{orient}')
            c+=['kill @e[tag=ca.ray]'];self.case(f'local_{orient}',c)
        c=self.start()+self.start(table=202,reset=False)+self.call('game/abort')+self.score(C,'ct_state',0,'abort_lobby')+self.score(D,'ct_state',1,'other_game_alive')+self.count('@e[tag=ca.surface,scores={ct_id=101}]',0,'abort_surface_cleared')+self.count('@e[tag=ca.surface,scores={ct_id=202}]',1,'abort_other_surface_kept')+self.count('@e[tag=ca.player,scores={ca_table=101}]',0,'abort_clears_identity')+self.count('@e[tag=ca.player,scores={ca_table=202}]',3,'abort_other_identity_kept')
        self.case('isolation_cleanup',c)
        c=self.start()+[f'scoreboard players set {C} ca_winner 1']+self.call('game/win')+self.score(C,'ca_finish',100,'win_waits')+self.call('game/cleanup')+self.score(C,'ct_state',0,'win_lobby')+self.call('game/remove')+self.check(f'entity {C}[tag=!ca.controller]','remove_controller_tag')
        # @e[...] 二次方括号无效，独立完整selector。
        c=[line.replace(C+'[tag=!ca.controller]',C.replace('tag=cg.table','tag=cg.table,tag=!ca.controller')) for line in c]
        self.case('winner_cleanup',c)
        # 真正穿过 UI nonce -> actor/table -> 引擎 -> 动画桥接，非绕过前台直接改状态。
        c=self.start()
        for mode,pick in ((2,0),(3,0)):
            c += [f'execute as {person(1)} run function catan:ui/open',f'scoreboard players set {person(1)} ca_mode {mode}',f'scoreboard players set {person(1)} ca_pick {pick}',f'execute as {person(1)} run function catan:ui/confirm',f'scoreboard players operation {person(1)} ca_action = {person(1)} ca_nonce',f'scoreboard players operation {person(1)} ca_action *= #factor ca_ctx',f'scoreboard players add {person(1)} ca_action 300',f'execute as {person(1)} run function catan:ui/handle']
            if mode==2:
                c+=self.check(f'data entity {C} data.catan{{vertex_owner:[1]}}','ui_build_engine_committed')+self.score(C,'ca_state',2,'ui_setup_road_next')+self.score(C,'ca_vkind',2,'ui_settlement_animation')
                c+=self.check(f'data entity {C} data.catan.p1.name','ui_engine_preserves_name')
            else:
                c+=self.check(f'data entity {C} data.catan{{road_owner:[1]}}','ui_road_engine_committed')+self.score(C,'ca_turn',2,'ui_setup_next_player')
            c+=self.call('game/tick')*25
        self.case('ui_engine_bridge',c)
        c=self.start()+[f'data modify entity {C} data.catan.vertex_owner[0] set value 1',f'data modify entity {C} data.catan.vertex_level[0] set value 1',f'data modify entity {C} data.catan.last set value {{kind:"settlement",owner:1,target:0}}']+self.call('visual/update')+self.call('visual/animate')
        c+=self.score(C,'ca_vtimer','1..','abort_during_animation')+self.call('game/abort')+self.score(C,'ca_vtimer',0,'abort_resolves_animation')+self.check(f'data entity {C} data.catan{{review:1b}}','abort_retains_public_review')
        c+=self.call('system/reload')+self.check(f'data entity {C} data.catan{{vertex_owner:[1]}}','lobby_reload_retains_building')+self.count('@e[tag=ca.surface,scores={ct_id=101}]',0,'lobby_reload_no_interaction')
        c+=self.call('game/start')+self.check(f'data entity {C} data.catan{{vertex_owner:[0,0,0]}}','new_game_clears_review')
        self.case('cleanup_animation_reload',c)
        c=self.start()+[f'tag {person(3)} remove ca.player',f'scoreboard players set {C} ca_offline 199']+self.call('game/tick')+self.score(C,'ct_state',0,'offline_timeout_aborts')
        self.case('offline_timeout',c)
        self.finish()


if __name__=='__main__':
    if '--java' not in sys.argv:sys.argv+=['--java',JAVA]
    real_run=subprocess.run
    def heap(command,*args,**kw):
        if len(command)>1 and str(command[1]).startswith('@'):
            p=Path(str(command[1])[1:]);p.write_text(p.read_text(encoding='utf-8').replace('-Xmx1536M','-Xmx3072M'),encoding='utf-8')
        return real_run(command,*args,**kw)
    subprocess.run=heap
    suite=Suite();suite.build();raise SystemExit(run(suite,isolated=False,prefix='fimel-catan-game-',prepare_target=fixture_hook))
