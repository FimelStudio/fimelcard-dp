"""原版 26.2 检查中国象棋的红黑分配、真实座椅乘客及重载恢复。

只在独立临时世界把服务端参与者选择器改为测试盔甲架；生产规则、
公共 seat/mount 与座椅实体实现保持原样，不读取或修改玩家存档。
"""
from pathlib import Path
import argparse
import json
import re
import shutil
import subprocess
import tempfile
import time

from test_xiangqi import Suite as BaseSuite, PACK


TABLE = '@e[type=minecraft:marker,tag=cs.table,scores={ct_id=101},limit=1]'
OTHER = '@e[type=minecraft:marker,tag=cs.table,scores={ct_id=202},limit=1]'


def player(number):
    return f'@e[type=minecraft:armor_stand,tag=cs.p{number},limit=1]'


class Suite(BaseSuite):
    def count(self, selector, value, name):
        return ['scoreboard players set #count cs 0', f'execute as {selector} run scoreboard players add #count cs 1'] + self.score('#count','cs',value,name)

    def call(self, name, table=101):
        return [f'execute as {TABLE if table == 101 else OTHER} at @s run function xiangqi:{name}']

    def setup(self, cap=4, orient=0, mode=0, seats=(1, 3), table=101, reset=True):
        lines = ['function xiangqi_seat_test:reset'] if reset else []
        lines += [f'execute positioned {8 if table == 101 else 40} 64 8 summon minecraft:marker run function xiangqi_seat_test:table {{table:{table},cap:{cap},orient:{orient},mode:{mode}}}']
        for index, seat in enumerate(seats, 1 if table == 101 else 3):
            lines += [f'execute positioned {8 if table == 101 else 40} 64 8 summon minecraft:armor_stand run function xiangqi_seat_test:person {{number:{index},seat:{seat},table:{table}}}',
                      f'execute as {player(index)} at @s run function cardtable:seat/mount']
        return lines

    def mounted(self, number, side, first, last, prefix):
        p = player(number)
        lines = [f'scoreboard players set #mounted cs 0',
                 f'execute as {p} on vehicle if entity @s[type=minecraft:interaction,tag=ct.seat,scores={{ct_id=101,ct_seat={first}..{last}}}] run scoreboard players set #mounted cs 1']
        lines += self.score('#mounted', 'cs', 1, prefix + '_mounted')
        lines += self.score(p, 'xq_side', side, prefix + '_side')
        lines += self.score(p, 'ct_seat', f'{first}..{last}', prefix + '_ct_seat')
        lines += self.check(f'score {p} xq_seat = {p} ct_seat', prefix + '_seat_sync')
        return lines

    def board_sides(self, cap, orient, prefix):
        sides = {(4,0):((3,3),(1,1)), (4,1):((4,4),(2,2)),
                 (8,0):((5,6),(1,2)), (8,1):((7,8),(3,4))}
        red, black = sides[cap, orient]
        lines = []
        for side, bounds, side_name in [(1, red, 'red'), (-1, black, 'black')]:
            p = f'@e[tag=cs.person,tag=xq.player,scores={{xq_table=101,xq_side={side}}},limit=1]'
            lines += self.count(p, 1, prefix + '_' + side_name + '_unique')
            lines += self.score(p, 'ct_seat', f'{bounds[0]}..{bounds[1]}', prefix + '_' + side_name + '_correct_edge')
            lines += self.check(f'score {p} xq_seat = {p} ct_seat', prefix + '_' + side_name + '_seat_synced')
            lines += self.check(f'score {TABLE} xq_{side_name} = {p} xq_seat', prefix + '_' + side_name + '_controller_synced')
            lines += [f'scoreboard players set #mounted cs 0',
                      f'execute as {p} on vehicle if entity @s[type=minecraft:interaction,tag=ct.seat,scores={{ct_id=101,ct_seat={bounds[0]}..{bounds[1]}}}] run scoreboard players set #mounted cs 1']
            lines += self.score('#mounted', 'cs', 1, prefix + '_' + side_name + '_actual_vehicle')
        lines += self.score(TABLE, 'xq_turn', 1, prefix + '_red_always_moves_first')
        lines += [f'scoreboard players set #passengers cs 0',
                  'execute as @e[type=minecraft:interaction,tag=ct.seat,scores={ct_id=101}] on passengers if entity @s[tag=cs.person] run scoreboard players add #passengers cs 1']
        lines += self.score('#passengers', 'cs', 2, prefix + '_exactly_two_passengers')
        lines += ['scoreboard players set #same_seat cs 0',
                  f'execute if score {player(1)} ct_seat = {player(2)} ct_seat run scoreboard players set #same_seat cs 1']
        lines += self.score('#same_seat', 'cs', 0, prefix + '_different_seats')
        return lines

    def build(self):
        self.file('reset', ['kill @e[tag=cs.fixture]', 'kill @e[tag=xq.visual]', 'kill @e[tag=xq.square]', 'kill @e[tag=ct.menu]', 'kill @e[tag=ct.vote]'])
        self.file('table', '''
tag @s add cs.fixture
tag @s add cs.table
tag @s add ct.controller
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ct_capacity $(cap)
$scoreboard players set @s xq_orient $(orient)
$scoreboard players set @s xq_first $(mode)
scoreboard players set @s ct_game 13
scoreboard players set @s ct_state 0
scoreboard players set @s ct_joined 2
scoreboard players set @s ct_start 0
data merge entity @s {data:{cardtable:{menu_version:13,rules_version:5,chairs_version:1,vote_version:1}}}
function cardtable:table/ensure_seats
scoreboard players operation #fixture_table cs = @s ct_id
execute as @e[tag=ct.seat] if score @s ct_id = #fixture_table cs run tag @s add cs.fixture
''')
        self.file('person', '''
tag @s add cs.fixture
tag @s add cs.person
$tag @s add cs.p$(number)
tag @s add ct.player
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ct_seat $(seat)
scoreboard players set @s ct_online 1
data merge entity @s {NoGravity:1b,Invisible:1b,Invulnerable:1b}
''')
        sides = {(4,0):((3,3),(1,1)), (4,1):((4,4),(2,2)),
                 (8,0):((5,6),(1,2)), (8,1):((7,8),(3,4))}
        for (cap, orient), (red, black) in sides.items():
            # 自行选边，两种方向及八人桌每边的第二座都必须保留。
            name = f'self_{cap}_{orient}'
            lines = self.setup(cap, orient, 1, (red[1], black[1])) + self.call('game/start')
            lines += self.score(TABLE, 'ct_start', 1, name + '_starts')
            lines += self.mounted(1, 1, red[1], red[1], name + '_p1')
            lines += self.mounted(2, -1, black[1], black[1], name + '_p2')
            lines += self.board_sides(cap, orient, name)
            self.case(name, lines)
            # 从侧面或同一侧入座，随机分配后必须回到相对底线。
            pairs = [(1,2), (red[0],black[0])]
            if cap == 8:
                pairs += [(red[0],red[1]), (black[0],black[1])]
            for index, seats in enumerate(pairs):
                name = f'random_{cap}_{orient}_{index}'
                lines = self.setup(cap, orient, 0, seats) + self.call('game/start')
                lines += self.score(TABLE, 'ct_start', 1, name + '_starts') + self.board_sides(cap, orient, name)
                self.case(name, lines)
            # 强制互换两方，检验旧载具乘客被同时释放。
            name = f'swap_{cap}_{orient}'
            lines = self.setup(cap, orient, 1, (red[0],black[0])) + self.call('game/start')
            lines += [f'scoreboard players set {player(1)} xq_side -1', f'scoreboard players set {player(2)} xq_side 1']
            lines += self.call('game/reseat')
            lines += self.mounted(1,-1,*black,name+'_p1') + self.mounted(2,1,*red,name+'_p2') + self.board_sides(cap,orient,name)
            self.case(name,lines)
            # 同一桌连续随机重开，覆盖双方互换及目标座位被上一局对方占用。
            self.case(f'repeated_setup_{cap}_{orient}', self.setup(cap, orient, 0, (red[1], black[1])))
            for repeat in range(12):
                prefix = f'repeated_{cap}_{orient}_{repeat}'
                lines = [f'scoreboard players set {TABLE} ct_state 0', f'scoreboard players set {TABLE} ct_start 0',
                         f'scoreboard players set {TABLE} ct_joined 2']
                lines += self.call('game/start') + self.score(TABLE,'ct_start',1,prefix+'_started')
                lines += self.board_sides(cap, orient, prefix)
                self.case(prefix, lines)
            # 即使旧状态中两位乘客挤在同一实体，按阵营重新落座也会恢复。
            name = f'repair_stacked_{cap}_{orient}'
            lines = self.setup(cap, orient, 1, (red[1],black[1])) + self.call('game/start')
            lines += [f'execute as {player(2)} run ride @s dismount',
                      f'execute as {player(2)} run ride @s mount @e[tag=ct.seat,scores={{ct_id=101,ct_seat={red[1]}}},limit=1]']
            lines += ['scoreboard players set #stacked cs 0',
                      f'execute as @e[tag=ct.seat,scores={{ct_id=101,ct_seat={red[1]}}},limit=1] on passengers if entity @s[tag=cs.person] run scoreboard players add #stacked cs 1']
            lines += self.score('#stacked','cs',2,name+'_fixture_reproduces_two_on_one_chair')
            lines += self.call('game/reseat') + self.board_sides(cap, orient, name)
            self.case(name, lines)
            # 自行选边时，两人同一桌边或其中一人坐侧边必须拒绝，身份不变。
            bad = (red[0],red[1]) if cap == 8 else (red[0],2 if orient == 0 else 1)
            name = f'reject_{cap}_{orient}'
            lines = self.setup(cap,orient,1,bad) + self.call('game/start')
            lines += self.score(TABLE,'ct_start',0,name+'_not_started')
            lines += self.count('@e[tag=cs.person,tag=xq.player]',0,name+'_no_game_identity')
            for i,seat in enumerate(bad,1):
                lines += self.score(player(i),'ct_seat',seat,name+f'_p{i}_original_seat')
            self.case(name,lines)
            # 重载不随机阵营、不动棋局或时钟；重建缺失座椅后重新骑乘。
            name = f'reload_{cap}_{orient}'
            lines = self.setup(cap,orient,1,(red[1],black[1])) + self.call('game/start')
            lines += [f'scoreboard players set {TABLE} ct_state 1', f'scoreboard players set {TABLE} xq_turn -1',
                      f'scoreboard players set {TABLE} xq_btime 9876', f'scoreboard players set {TABLE} xq_half 11',
                      f'execute as {player(1)} run ride @s dismount',
                      f'kill @e[type=minecraft:interaction,tag=ct.seat,scores={{ct_id=101,ct_seat={red[1]}}}]']
            lines += self.call('system/reload')
            lines += self.mounted(1,1,red[1],red[1],name+'_p1') + self.mounted(2,-1,black[1],black[1],name+'_p2')
            lines += self.score(TABLE,'xq_turn',-1,name+'_turn_preserved') + self.score(TABLE,'xq_btime',9876,name+'_clock_preserved')
            lines += self.score(TABLE,'xq_half',11,name+'_quiet_count_preserved')
            lines += self.count('@e[tag=ct.seat,scores={ct_id=101}]',cap,name+'_seat_count')
            self.case(name,lines)
        # 在一桌交换阵营不能移动另一桌的玩家或乘客。
        lines = self.setup(4,0,1,(3,1)) + self.call('game/start')
        lines += self.setup(8,1,1,(8,4),table=202,reset=False) + self.call('game/start',202)
        lines += [f'scoreboard players set {player(1)} xq_side -1', f'scoreboard players set {player(2)} xq_side 1'] + self.call('game/reseat')
        lines += self.board_sides(4,0,'isolation_active_table')
        lines += self.score(player(3),'ct_seat',8,'isolation_red_seat') + self.score(player(4),'ct_seat',4,'isolation_black_seat')
        lines += self.score(OTHER,'xq_red',8,'isolation_controller_red') + self.score(OTHER,'xq_black',4,'isolation_controller_black')
        lines += ['scoreboard players set #passengers cs 0','execute as @e[tag=ct.seat,scores={ct_id=202}] on passengers if entity @s[tag=cs.person] run scoreboard players add #passengers cs 1']
        lines += self.score('#passengers','cs',2,'isolation_passengers')
        self.case('isolation',lines)
        # 新桌与旧非法值默认按座位，显式随机设置仍保留。
        lines = self.setup() + [f'scoreboard players reset {TABLE} xq_first'] + self.call('game/init_table')
        lines += self.score(TABLE,'xq_first',1,'fresh_table_defaults_by_seat')
        lines += [f'scoreboard players set {TABLE} xq_first 0'] + self.call('game/init_table')
        lines += self.score(TABLE,'xq_first',0,'explicit_random_preserved')
        self.case('default_setting',lines)
        lines = self.setup() + self.call('game/start') + [f'scoreboard players set {TABLE} ct_state 1', f'scoreboard players set {TABLE} xq_first 8', f'scoreboard players set {TABLE} xq_turn -1','function xiangqi:load']
        lines += self.score(TABLE,'xq_first',1,'legacy_first_reset') + self.score(TABLE,'xq_turn',-1,'legacy_reload_keeps_turn')
        self.case('legacy_setting',lines)
        # 单人选白／选黑：真实玩家骑乘对应侧，虚拟对手只保留逻辑座位。
        for (cap, orient), (red, black) in sides.items():
            for human_side, own, opponent in [(1, red, black), (-1, black, red)]:
                name = f'solo_{cap}_{orient}_{"red" if human_side == 1 else "black"}'
                lines = self.setup(cap, orient, 1, (own[1],))
                lines += [f'scoreboard players set {TABLE} ct_joined 1'] + self.call('game/start')
                lines += self.score(TABLE,'ct_start',1,name+'_started')
                lines += self.score(TABLE,'xq_bot',-human_side,name+'_opposite_bot')
                lines += self.mounted(1,human_side,own[1],own[1],name+'_human')
                lines += self.score(TABLE,'xq_red' if human_side == 1 else 'xq_black',own[1],name+'_human_nominal_seat')
                lines += self.score(TABLE,'xq_black' if human_side == 1 else 'xq_red',opponent[0],name+'_bot_nominal_seat')
                lines += self.score(TABLE,'xq_turn',1,name+'_red_first')
                lines += self.count('@e[tag=cs.person,tag=xq.player]',1,name+'_one_actual_participant')
                lines += [f'scoreboard players set {TABLE} ct_state 1'] + self.call('system/heartbeat')
                lines += self.score(TABLE,'xq_state',1,name+'_solo_heartbeat_keeps_game')
                lines += self.call('system/reload') + self.score(TABLE,'xq_bot',-human_side,name+'_reload_keeps_bot')
                lines += self.mounted(1,human_side,own[1],own[1],name+'_reload_human')
                self.case(name,lines)
        # 随机分配允许从侧边入座；不增造假玩家，开局后总是面对己方底线。
        for cap,orient in [(4,0),(8,1)]:
            name=f'solo_random_{cap}_{orient}'
            red,black=sides[cap,orient]
            lines=self.setup(cap,orient,0,(2,))+[f'scoreboard players set {TABLE} ct_joined 1']+self.call('game/start')
            lines+=self.score(TABLE,'ct_start',1,name+'_started')
            lines+=self.score(TABLE,'xq_bot','-1..1',name+'_valid_bot')
            lines += [f'scoreboard players operation #opposite cs = {player(1)} xq_side',
                      'scoreboard players operation #opposite cs *= #minus xq_ctx']
            lines+=self.check(f'score {TABLE} xq_bot = #opposite cs',name+'_opposite_sides')
            for side,bounds in [(1,red),(-1,black)]:
                lines += [f'execute if score {player(1)} xq_side matches {side} run scoreboard players operation #solo_seat cs = {player(1)} ct_seat',
                          f'execute unless score {player(1)} xq_side matches {side} run scoreboard players set #solo_seat cs {bounds[0]}']
                lines+=self.score('#solo_seat','cs',f'{bounds[0]}..{bounds[1]}',name+f'_edge_{side+1}')
            self.case(name,lines)
        # 单人坐侧边自行选边仍须拒绝，零／三人不能启动。
        lines=self.setup(4,0,1,(2,))+[f'scoreboard players set {TABLE} ct_joined 1']+self.call('game/start')
        lines+=self.score(TABLE,'ct_start',0,'solo_sideways_rejected')
        self.case('solo_sideways',lines)
        for count in [0,3]:
            lines=self.setup()+[f'scoreboard players set {TABLE} ct_joined {count}']+self.call('game/start')
            lines+=self.score(TABLE,'ct_start',0,'start_rejects_'+str(count))
            self.case('solo_bad_count_'+str(count),lines)
        # 人机同意悔棋，回到真人上一步之前；对手应手和时钟一并回退。
        lines=self.setup(4,0,1,(3,))+[f'scoreboard players set {TABLE} ct_joined 1']+self.call('game/start')
        lines += [f'scoreboard players set {TABLE} ct_state 1',f'tag {player(1)} add xq.actor']
        for source,target in [(27,36),(54,45)]:
            lines += self.call('game/snapshot')+['scoreboard players set #from xq_ctx '+str(source),
                'scoreboard players set #to xq_ctx '+str(target)]
            lines += self.call('engine/try_move') + self.call('game/animation_done')
        lines += self.call('game/offer_undo')
        lines += self.score('@e[tag=xq.square,scores={ct_id=101,xq_sq=27},limit=1]','xq_piece',1,'solo_undo_restores_human_pawn')
        lines += self.score('@e[tag=xq.square,scores={ct_id=101,xq_sq=54},limit=1]','xq_piece',-1,'solo_undo_restores_bot_response')
        lines += self.score(TABLE,'xq_turn',1,'solo_undo_back_to_human')
        lines += self.score(TABLE,'xq_rtime',12000,'solo_undo_restores_clock')
        lines += [f'execute store success score #has_snapshot cs if data entity {TABLE} data.xiangqi.ai_undo']
        lines += self.score('#has_snapshot','cs',0,'solo_undo_consumes_snapshot')
        lines += self.call('game/offer_draw')+self.score(TABLE,'xq_state',4,'solo_draw_auto_agreed')
        lines += self.score(TABLE,'xq_result',3,'solo_draw_is_draw')
        self.case('solo_undo_draw',lines)
        # 回大厅保留终局；再次经真实开局入口开始才重摆棋面。
        lines=self.setup(4,0,1,(3,1))+self.call('game/start')+[f'scoreboard players set {TABLE} ct_state 1']
        lines += self.call('game/snapshot')+['scoreboard players set #from xq_ctx 27','scoreboard players set #to xq_ctx 36']
        lines += self.call('engine/try_move')+self.call('game/animation_done')
        lines += [f'scoreboard players set {TABLE} xq_result 3',f'scoreboard players set {TABLE} xq_reason 8']+self.call('game/finish')
        lines += [f'scoreboard players set {TABLE} xq_timer 1']+self.call('game/result_tick')
        lines += self.score(TABLE,'ct_state',0,'restart_review_in_lobby')
        lines += self.score('@e[tag=xq.square,scores={ct_id=101,xq_sq=36},limit=1]','xq_piece',1,'restart_keeps_final_before_start')
        lines += self.call('game/start')
        lines += self.score(TABLE,'ct_start',1,'restart_starts_again')
        lines += self.score('@e[tag=xq.square,scores={ct_id=101,xq_sq=27},limit=1]','xq_piece',1,'restart_resets_pawn_home')
        lines += self.score('@e[tag=xq.square,scores={ct_id=101,xq_sq=36},limit=1]','xq_piece',0,'restart_clears_final_pawn')
        lines += [f'execute store success score #review cs if data entity {TABLE} data.xiangqi.review']
        lines += self.score('#review','cs',0,'restart_consumes_review_flag')
        self.case('review_restart',lines)
        self.file('finish',['function xiangqi_seat_test:reset','say XIANGQI_GAME_FINISHED'])
        self.file('bootstrap',['forceload add -16 -16 63 31','scoreboard objectives add cs dummy','function xiangqi:load','schedule function xiangqi_seat_test:case/'+self.cases[0]+' 40t'])
        for index,name in enumerate(self.cases):
            self.files['case/'+name] += 'schedule function xiangqi_seat_test:' + ('case/'+self.cases[index+1] if index+1 < len(self.cases) else 'finish') + ' 2t\n'


def main(suite=None, prefix='fimel-xiangqi-seating-', setup_ticks=400, manual_tick=False, heap_mb=1536):
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--java',type=Path,default=Path('C:/Temp/fimel-uno-java25/jdk-25.0.5+8-jre/bin/java.exe'))
    parser.add_argument('--minecraft-root',type=Path,default=Path('D:/PCL2/MinecraftPcl'))
    parser.add_argument('--version',default='26.2-Fabric_0.19.3')
    args=parser.parse_args()
    output=Path(tempfile.mkdtemp(prefix=prefix))
    target=output/'packs/fimel_cards'
    shutil.copytree(PACK/'data',target/'data');shutil.copy2(PACK/'pack.mcmeta',target/'pack.mcmeta')
    if manual_tick:
        (target/'data/minecraft/tags/function/tick.json').write_text('{"values":[]}',encoding='utf-8')
    # 只替换服务端参与者；tellraw/title/dialog 的真人接收者保持原样。
    for name in ['game/start','game/assign_sides','game/solo_sides','game/random_first','game/chosen_first','game/reseat','system/reload','system/heartbeat']:
        path=target/f'data/xiangqi/function/{name}.mcfunction'
        lines=[]
        for line in path.read_text(encoding='utf-8').splitlines():
            if 'if items entity' in line or 'run function xiangqi:input/give' in line:
                continue
            if not any(command in line for command in ['tellraw ','title ','dialog ']):
                line=line.replace('@a[tag=ct.player]', '@e[tag=cs.person,tag=ct.player]')
                line=line.replace('@a[tag=xq.audience', '@e[tag=cs.person,tag=xq.audience')
            lines.append(line)
        path.write_text('\n'.join(lines)+'\n',encoding='utf-8')
    if suite is None:
        suite=Suite();suite.build()
    for name,body in suite.files.items():
        path=target/'data/xiangqi_seat_test/function'/(name+'.mcfunction');path.parent.mkdir(parents=True,exist_ok=True);path.write_text(body.replace('function xiangqi_game_test:', 'function xiangqi_seat_test:'),encoding='utf-8')
    for name,body in {
        'test_environment/default.json':{'type':'minecraft:function','setup':'xiangqi_seat_test:bootstrap'},
        'test_instance/seating.json':{'type':'minecraft:function','environment':'xiangqi_seat_test:default','function':'minecraft:always_pass','max_ticks':1,'setup_ticks':setup_ticks,'required':True,'structure':'minecraft:empty'},
    }.items():
        path=target/'data/xiangqi_seat_test'/name;path.parent.mkdir(parents=True,exist_ok=True);path.write_text(json.dumps(body),encoding='utf-8')
    launch=args.minecraft_root/'versions'/args.version/(args.version+'.json')
    meta=json.loads(launch.read_text(encoding='utf-8-sig'));classpath=[launch.with_suffix('.jar')]
    for lib in meta['libraries']:
        entry=lib.get('downloads',{}).get('artifact',{})
        if entry.get('path'):
            path=args.minecraft_root/'libraries'/entry['path']
            if path.is_file():classpath.append(path)
    options=['-Xms256M',f'-Xmx{heap_mb}M','-Djava.awt.headless=true','-Dfile.encoding=UTF-8','--enable-native-access=ALL-UNNAMED','-cp',';'.join(map(str,classpath)),'net.minecraft.gametest.Main','--packs',str(output/'packs'),'--universe',str(output/'universe'),'--tests','xiangqi_seat_test:*','--report',str(output/'gametest.xml')]
    argfile=output/'java-args.txt';argfile.write_text('\n'.join('"'+v.replace('\\','\\\\').replace('"','\\"')+'"' for v in options),encoding='utf-8')
    print('Xiangqi seating GameTest: '+str(output),flush=True);start=time.monotonic()
    try:
        process=subprocess.run([str(args.java),'@'+str(argfile)],cwd=output,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True,encoding='utf-8',errors='replace',timeout=max(180,setup_ticks/20+300))
    except subprocess.TimeoutExpired as error:
        body=error.stdout or ''
        if isinstance(body,bytes):body=body.decode('utf-8',errors='replace')
        (output/'game.log').write_text(body,encoding='utf-8')
        raise
    (output/'game.log').write_text(process.stdout,encoding='utf-8')
    passed=set(re.findall(r'XIANGQI_GAME_PASS ([a-z0-9_]+)',process.stdout));failed=sorted(set(re.findall(r'XIANGQI_GAME_FAIL ([a-z0-9_]+)',process.stdout)))
    errors=[line for line in process.stdout.splitlines() if any(s in line for s in ['[ERROR]','/ERROR]','Failed to load','Failed to parse','Unknown function','Unknown or incomplete command',"Couldn't parse",'Command execution stopped'])]
    result={'exit_code':process.returncode,'seconds':round(time.monotonic()-start,1),'assertions':len(suite.expected),'passed':len(passed),'failed':failed,'missing':sorted(set(suite.expected)-passed),'errors':errors,'finished':'XIANGQI_GAME_FINISHED' in process.stdout,'output':str(output)}
    (output/'result.json').write_text(json.dumps(result,ensure_ascii=False,indent=2),encoding='utf-8');print(json.dumps(result,ensure_ascii=False,indent=2),flush=True)
    return int(bool(process.returncode or failed or result['missing'] or errors or not result['finished']))


if __name__=='__main__':
    raise SystemExit(main())
