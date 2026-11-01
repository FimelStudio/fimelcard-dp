"""中国象棋纯 mcfunction 规则：90 交点、红正黑负，所有入口以本桌控制器执行。

只生成 engine/；几何走法与被攻击判断不读取其他牌桌，不修改真实棋盘。
重复规则采用完整局面键；三次同局面判和，只有一方全程连续将军则该方负。
复杂长捉与一将一捉不自动裁判，非吃子 120 半回合采用明确的休闲简化规则。
"""
from pathlib import Path
from textwrap import dedent
import re

ROOT = Path(__file__).resolve().parents[1] / 'data/xiangqi/function/engine'


def put(name, text):
    path = ROOT / (name + '.mcfunction')
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text('\n'.join(re.sub(r' {2,}', ' ', s.strip()) for s in dedent(text).strip().splitlines())+'\n', encoding='utf-8')


def sq(f, r):
    return r*9+f if 0 <= f < 9 and 0 <= r < 10 else None


def palace(f, r, side):
    return 3 <= f <= 5 and (0 <= r <= 2 if side == 1 else 7 <= r <= 9)


def shapes(start, kind, side, revealed=False):
    """(target, intervening cells, exact occupied count); no own/other side occupancy rules."""
    f, r = start % 9, start // 9
    result = []
    for to in range(90):
        tf, tr = to % 9, to // 9
        df, dr = tf-f, tr-r
        if not (df or dr):
            continue
        if kind == 1 and ((df == 0 and dr == side) or ((r >= 5 if side == 1 else r <= 4) and abs(df) == 1 and dr == 0)):
            result.append((to, [], 0))
        elif kind == 2 and sorted((abs(df), abs(dr))) == [1, 2]:
            leg = sq(f+(1 if df > 0 else -1), r) if abs(df) == 2 else sq(f, r+(1 if dr > 0 else -1))
            result.append((to, [leg], 0))
        elif kind == 3 and abs(df) == abs(dr) == 2 and (revealed or (tr <= 4 if side == 1 else tr >= 5)):
            result.append((to, [sq(f+df//2, r+dr//2)], 0))
        elif kind in (4, 5) and ((df == 0) != (dr == 0)):
            stepf, stepr = (df > 0)-(df < 0), (dr > 0)-(dr < 0)
            path = [sq(f+stepf*d,r+stepr*d) for d in range(1,max(abs(df),abs(dr)))]
            result.append((to,path,0 if kind == 4 else -1))
        elif kind == 6 and abs(df)+abs(dr) == 1 and palace(tf,tr,side) and palace(f,r,side):
            result.append((to,[],0))
        elif kind == 7 and abs(df) == abs(dr) == 1 and (revealed or (palace(tf,tr,side) and palace(f,r,side))):
            result.append((to,[],0))
    return result


def free(path):
    return ' '.join(f'if score #b{x} xq_ctx matches 0' for x in path)


put('cache', '''
    scoreboard players operation #side xq_ctx = @s xq_turn
    scoreboard players set #variant xq_ctx 0
    execute if score @s xq_variant matches 1 run scoreboard players set #variant xq_ctx 1
    scoreboard players set #wking xq_ctx -1
    scoreboard players set #bking xq_ctx -1
    scoreboard players set #cache_ok xq_ctx 1
    execute store result score #cache_size xq_ctx if entity @e[type=minecraft:marker,tag=xq.board]
    execute unless score #cache_size xq_ctx matches 90 run scoreboard players set #cache_ok xq_ctx 0
    execute as @e[type=minecraft:marker,tag=xq.board] unless score @s xq_piece matches -7..7 run scoreboard players set #cache_ok xq_ctx 0
    execute store result score #king_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_piece=6}]
    execute unless score #king_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
    execute store result score #king_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_piece=-6}]
    execute unless score #king_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
''' + '\n'.join(
    f'scoreboard players set #b{i} xq_ctx 0\n'
    f'execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={{xq_sq={i}}}]\n'
    f'execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0\n'
    f'scoreboard players operation #b{i} xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={{xq_sq={i}}},limit=1] xq_piece\n'
    f'scoreboard players set #q{i} xq_ctx 0\n'
    f'execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={{xq_sq={i}}},limit=1] xq_covered matches 1 run scoreboard players set #q{i} xq_ctx 1\n'
    f'execute if score #b{i} xq_ctx matches 6 run scoreboard players set #wking xq_ctx {i}\n'
    f'execute if score #b{i} xq_ctx matches -6 run scoreboard players set #bking xq_ctx {i}' for i in range(90)))

initial = [0]*90
for i,p in enumerate([4,2,3,7,6,7,3,2,4]):
    initial[i],initial[81+i] = p,-p
for i in (19,25): initial[i] = 5
for i in (64,70): initial[i] = -5
for i in (27,29,31,33,35): initial[i] = 1
for i in (54,56,58,60,62): initial[i] = -1
put('init_board','''
    function xiangqi:system/context
    scoreboard players set @s xq_turn 1
    scoreboard players set @s xq_half 0
    scoreboard players set @s xq_full 1
    scoreboard players set @s xq_result 0
    scoreboard players set @s xq_reason 0
    scoreboard players set @s xq_check 0
    scoreboard players set @s xq_repetition 0
    data modify entity @s data.xiangqi.history set value []
    data remove entity @s data.xiangqi.last
'''+'\n'.join(f'scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={{xq_sq={i}}},limit=1] xq_piece {p}\n'
              f'scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={{xq_sq={i}}},limit=1] xq_hidden {p}\n'
              f'scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={{xq_sq={i}}},limit=1] xq_covered 0' for i,p in enumerate(initial))+'''
    execute if score @s xq_variant matches 1 run function xiangqi:engine/covered/init
    function xiangqi:engine/cache
    execute unless score #cache_ok xq_ctx matches 1 run return 0
    function xiangqi:engine/history/record
''')
put('try_move','''
    function xiangqi:system/context
    function xiangqi:engine/cache
    scoreboard players set #legal xq_ctx 0
    execute unless score @s xq_state matches 1 run return 0
    function xiangqi:engine/check_move
    execute unless score #legal xq_ctx matches 1 run return 0
    function xiangqi:engine/commit
    return 1
''')
put('check','''
    function xiangqi:system/context
    function xiangqi:engine/cache
    function xiangqi:engine/check_move
    return run scoreboard players get #legal xq_ctx
''')
put('check_move','''
    scoreboard players set #legal xq_ctx 0
    execute unless score #cache_ok xq_ctx matches 1 run return 0
    execute unless score #side xq_ctx matches -1 unless score #side xq_ctx matches 1 run return 0
    execute unless score #from xq_ctx matches 0..89 run return 0
    execute unless score #to xq_ctx matches 0..89 run return 0
    execute if score #from xq_ctx = #to xq_ctx run return 0
    scoreboard players set #shape xq_ctx 0
    scoreboard players set #promotion xq_ctx 0
    scoreboard players set #capture_sq xq_ctx -1
    scoreboard players set #rook_from xq_ctx -1
    scoreboard players set #rook_to xq_ctx -1
    execute store result storage xiangqi:engine scratch.from int 1 run scoreboard players get #from xq_ctx
    execute store result storage xiangqi:engine scratch.to int 1 run scoreboard players get #to xq_ctx
    function xiangqi:engine/get_pieces with storage xiangqi:engine scratch
    execute if score #side xq_ctx matches 1 unless score #piece xq_ctx matches 1..7 run return 0
    execute if score #side xq_ctx matches -1 unless score #piece xq_ctx matches -7..-1 run return 0
    execute if score #side xq_ctx matches 1 if score #target xq_ctx matches 1..7 run return 0
    execute if score #side xq_ctx matches -1 if score #target xq_ctx matches -7..-1 run return 0
    execute if score #target xq_ctx matches 6 run return 0
    execute if score #target xq_ctx matches -6 run return 0
    scoreboard players operation #kind xq_ctx = #piece xq_ctx
    execute if score #kind xq_ctx matches ..-1 run scoreboard players operation #kind xq_ctx *= #minus xq_ctx
    execute store result storage xiangqi:engine scratch.kind int 1 run scoreboard players get #kind xq_ctx
    execute store result storage xiangqi:engine scratch.side int 1 run scoreboard players get #side xq_ctx
    function xiangqi:engine/dispatch_shape with storage xiangqi:engine scratch
    execute unless score #shape xq_ctx matches 1 run return 0
    scoreboard players operation #placed xq_ctx = #piece xq_ctx
    execute unless score #target xq_ctx matches 0 run scoreboard players operation #capture_sq xq_ctx = #to xq_ctx
    function xiangqi:engine/simulate
    execute if score #attacked xq_ctx matches 0 run scoreboard players set #legal xq_ctx 1
    return run scoreboard players get #legal xq_ctx
''')
put('get_pieces','$scoreboard players operation #piece xq_ctx = #b$(from) xq_ctx\n$scoreboard players operation #target xq_ctx = #b$(to) xq_ctx\n$scoreboard players operation #covered xq_ctx = #q$(from) xq_ctx\n$scoreboard players operation #target_covered xq_ctx = #q$(to) xq_ctx')
put('dispatch_shape','''
$execute if score #variant xq_ctx matches 1 if score #covered xq_ctx matches 0 if score #kind xq_ctx matches 3 run return run function xiangqi:engine/revealed/side$(side)/p3/s$(from)
$execute if score #variant xq_ctx matches 1 if score #covered xq_ctx matches 0 if score #kind xq_ctx matches 7 run return run function xiangqi:engine/revealed/side$(side)/p7/s$(from)
$function xiangqi:engine/shape/side$(side)/p$(kind)/s$(from)
''')
for side in (1,-1):
    for kind in range(1,8):
        for start in range(90):
            lines=[]
            for to,path,count in shapes(start,kind,side):
                condition=f'execute if score #to xq_ctx matches {to}'
                if count == -1:
                    lines.append(condition+' if score #target xq_ctx matches 0 '+free(path)+' run scoreboard players set #shape xq_ctx 1')
                    if path:
                        for screen in path:
                            cond=free([s for s in path if s!=screen])
                            lines.append(condition+f' unless score #target xq_ctx matches 0 unless score #b{screen} xq_ctx matches 0 '+cond+' run scoreboard players set #shape xq_ctx 1')
                else:
                    lines.append(condition+' '+free(path)+' run scoreboard players set #shape xq_ctx 1')
            # 一个源格/目标格只可能有一条合法形状；命中后不再扫描无关目标。
            lines=[line.replace('run scoreboard players set #shape xq_ctx 1',
                                'run return run scoreboard players set #shape xq_ctx 1') for line in lines]
            put(f'shape/side{side}/p{kind}/s{start}', '\n'.join(lines) or 'return 0')
            if kind in (3, 7):
                extended = [f'execute if score #to xq_ctx matches {to} '+free(path)+' run return run scoreboard players set #shape xq_ctx 1'
                            for to,path,_ in shapes(start,kind,side,revealed=True)]
                put(f'revealed/side{side}/p{kind}/s{start}', '\n'.join(extended) or 'return 0')

put('attack','''
    scoreboard players set #attacked xq_ctx 0
    execute unless score #attack_sq xq_ctx matches 0..89 run return 0
    execute unless score #attacker xq_ctx matches -1 unless score #attacker xq_ctx matches 1 run return 0
    execute store result storage xiangqi:engine attack.sq int 1 run scoreboard players get #attack_sq xq_ctx
    execute store result storage xiangqi:engine attack.side int 1 run scoreboard players get #attacker xq_ctx
    function xiangqi:engine/attack_dispatch with storage xiangqi:engine attack
    return run scoreboard players get #attacked xq_ctx
''')
put('attack_dispatch','$function xiangqi:engine/attack/side$(side)/s$(sq)')
attacks={(side,t):[] for side in (1,-1) for t in range(90)}
for side in (1,-1):
    for kind in range(1,8):
        for start in range(90):
            for target,path,count in shapes(start,kind,side):
                prefix=f'execute if score #b{start} xq_ctx matches {side*kind}'
                if count == -1:
                    for screen in path:
                        attacks[side,target].append(prefix+f' unless score #b{screen} xq_ctx matches 0 '+free([s for s in path if s!=screen])+' run return run scoreboard players set #attacked xq_ctx 1')
                else:
                    attacks[side,target].append(prefix+' '+free(path)+' run return run scoreboard players set #attacked xq_ctx 1')
            if kind in (3,7):
                ordinary={target for target,_,_ in shapes(start,kind,side)}
                for target,path,_ in shapes(start,kind,side,revealed=True):
                    if target not in ordinary:
                        attacks[side,target].append(f'execute if score #variant xq_ctx matches 1 if score #q{start} xq_ctx matches 0 if score #b{start} xq_ctx matches {side*kind} '+free(path)+' run return run scoreboard players set #attacked xq_ctx 1')
    # 将帅同一纵线且无其他棋子时相互攻击，不能以普通吃子来吃掉对方将帅。
    for target in range(90):
        f,r=target%9,target//9
        for kr in range(10):
            start=sq(f,kr)
            if start==target: continue
            path=[sq(f,k) for k in range(min(r,kr)+1,max(r,kr))]
            attacks[side,target].append(f'execute if score #b{start} xq_ctx matches {side*6} if score #b{target} xq_ctx matches {-side*6} '+free(path)+' run return run scoreboard players set #attacked xq_ctx 1')
for (side,target),lines in attacks.items(): put(f'attack/side{side}/s{target}','\n'.join(lines))
for target in range(90):
    # 保留早期直接探测路径；正常 attack 分派只进入已确定的攻击方。
    put(f'attack/s{target}',f'execute if score #attacker xq_ctx matches 1 run return run function xiangqi:engine/attack/side1/s{target}\nexecute if score #attacker xq_ctx matches -1 run return run function xiangqi:engine/attack/side-1/s{target}')
put('simulate','''
    function xiangqi:engine/apply_cache with storage xiangqi:engine scratch
    scoreboard players operation #attack_sq xq_ctx = #wking xq_ctx
    execute if score #side xq_ctx matches -1 run scoreboard players operation #attack_sq xq_ctx = #bking xq_ctx
    execute if score #kind xq_ctx matches 6 run scoreboard players operation #attack_sq xq_ctx = #to xq_ctx
    scoreboard players operation #attacker xq_ctx = #side xq_ctx
    scoreboard players operation #attacker xq_ctx *= #minus xq_ctx
    function xiangqi:engine/attack
    function xiangqi:engine/restore_cache with storage xiangqi:engine scratch
''')
put('apply_cache','$scoreboard players set #b$(from) xq_ctx 0\n$scoreboard players operation #b$(to) xq_ctx = #placed xq_ctx\n$scoreboard players set #q$(from) xq_ctx 0\n$scoreboard players operation #q$(to) xq_ctx = #covered xq_ctx')
put('restore_cache','$scoreboard players operation #b$(from) xq_ctx = #piece xq_ctx\n$scoreboard players operation #b$(to) xq_ctx = #target xq_ctx\n$scoreboard players operation #q$(from) xq_ctx = #covered xq_ctx\n$scoreboard players operation #q$(to) xq_ctx = #target_covered xq_ctx')
put('commit','''
    # 只有真实提交可以读取暗子身份；合法判定、提示和人机模拟只处理公开模板。
    function xiangqi:engine/covered/reveal with storage xiangqi:engine scratch
    data modify entity @s data.xiangqi.last set value {from:0,to:0,piece:0,captured:0,capture_sq:-1,rook_from:-1,rook_to:-1,promotion:0,was_covered:0,captured_covered:0,moved_template:0}
    scoreboard players operation #captured xq_ctx = #target xq_ctx
'''+'\n'.join(f'execute store result entity @s data.xiangqi.last.{field} int 1 run scoreboard players get {score} xq_ctx' for field,score in [('from','#from'),('to','#to'),('piece','#placed'),('captured','#captured'),('capture_sq','#capture_sq'),('was_covered','#covered'),('captured_covered','#target_covered'),('moved_template','#piece')])+'''
    function xiangqi:engine/apply_cache with storage xiangqi:engine scratch
    function xiangqi:engine/covered/apply_real with storage xiangqi:engine scratch
    scoreboard players add @s xq_half 1
    execute unless score #captured xq_ctx matches 0 run scoreboard players set @s xq_half 0
    execute if score #side xq_ctx matches -1 run scoreboard players add @s xq_full 1
    scoreboard players operation @s xq_turn *= #minus xq_ctx
    scoreboard players operation #side xq_ctx = @s xq_turn
'''+'\n'.join(f'scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={{xq_sq={i}}},limit=1] xq_piece = #b{i} xq_ctx' for i in range(90))+'''
    function xiangqi:engine/cache
    function xiangqi:engine/history/record
    scoreboard players set #legal xq_ctx 1
    function xiangqi:game/after_move
''')

put('has_move','scoreboard players set #found xq_ctx 0\n'+'\n'.join(
    f'execute if score #found xq_ctx matches 0 if score #side xq_ctx matches {side} if score #b{start} xq_ctx matches {"1..7" if side==1 else "-7..-1"} run function xiangqi:engine/search/s{start}'
    for start in range(90) for side in (1,-1))+'\nreturn run scoreboard players get #found xq_ctx')
for start in range(90):
    put(f'search/s{start}', f'scoreboard players set #from xq_ctx {start}\n'+'\n'.join(
        f'execute if score #found xq_ctx matches 0 if score #b{start} xq_ctx matches {side*kind} run function xiangqi:engine/search/side{side}/p{kind}/s{start}' for side in (1,-1) for kind in range(1,8)))
    for side in (1,-1):
        for kind in range(1,8):
            targets=sorted({t for t,_,_ in shapes(start,kind,side,revealed=(kind in (3,7)))},key=lambda t:(abs(t%9-start%9)+abs(t//9-start//9),t))
            put(f'search/side{side}/p{kind}/s{start}', '\n'.join(f'execute if score #found xq_ctx matches 0 run function xiangqi:engine/probe {{to:{to}}}' for to in targets) or 'return 0')
put('probe','$scoreboard players set #to xq_ctx $(to)\nfunction xiangqi:engine/check_move\nexecute if score #legal xq_ctx matches 1 run scoreboard players set #found xq_ctx 1')
put('evaluate','''
    function xiangqi:system/context
    function xiangqi:engine/cache
    scoreboard players set @s xq_result 0
    scoreboard players set @s xq_reason 0
    execute unless score #cache_ok xq_ctx matches 1 run return run function xiangqi:engine/invalid_board
    function xiangqi:engine/check_current
    scoreboard players operation @s xq_check = #attacked xq_ctx
    function xiangqi:engine/has_move
    execute if score #found xq_ctx matches 0 run function xiangqi:engine/mate
    execute unless score @s xq_result matches 0 run return 1
    function xiangqi:engine/material
    execute if score #dead xq_ctx matches 1 run function xiangqi:engine/draw {reason:3}
    execute unless score @s xq_result matches 0 run return 1
    execute if score @s xq_repetition matches 3.. run function xiangqi:engine/history/adjudicate
    execute unless score @s xq_result matches 0 run return 1
    execute if score @s xq_half matches 120.. run function xiangqi:engine/draw {reason:5}
    return run scoreboard players get @s xq_result
''')
put('check_current','''
    scoreboard players operation #attack_sq xq_ctx = #wking xq_ctx
    execute if score #side xq_ctx matches -1 run scoreboard players operation #attack_sq xq_ctx = #bking xq_ctx
    scoreboard players operation #attacker xq_ctx = #side xq_ctx
    scoreboard players operation #attacker xq_ctx *= #minus xq_ctx
    function xiangqi:engine/attack
''')
put('mate','''
    scoreboard players set @s xq_reason 1
    execute if score @s xq_check matches 0 run scoreboard players set @s xq_reason 2
    execute if score #side xq_ctx matches 1 run scoreboard players set @s xq_result 2
    execute if score #side xq_ctx matches -1 run scoreboard players set @s xq_result 1
''')
put('invalid_board','scoreboard players set @s xq_result 3\nscoreboard players set @s xq_reason 11\nscoreboard players set @s xq_check 0\nreturn 3')
put('draw','scoreboard players set @s xq_result 3\n$scoreboard players set @s xq_reason $(reason)')
put('material','scoreboard players set #dead xq_ctx 1\n'+'\n'.join(f'execute if score #b{i} xq_ctx matches {p} run scoreboard players set #dead xq_ctx 0' for i in range(90) for p in (1,2,4,5,-1,-2,-4,-5))+'\nreturn run scoreboard players get #dead xq_ctx')
put('can_mate','''
    scoreboard players operation #mate_side xq_ctx = #side xq_ctx
    function xiangqi:system/context
    function xiangqi:engine/cache
    scoreboard players operation #side xq_ctx = #mate_side xq_ctx
    scoreboard players set #can_mate xq_ctx 1
    execute unless score #cache_ok xq_ctx matches 1 run return 1
    scoreboard players set #can_mate xq_ctx 0
'''+'\n'.join(f'execute if score #side xq_ctx matches {side} if score #b{i} xq_ctx matches {side*p} run scoreboard players set #can_mate xq_ctx 1' for i in range(90) for side in (1,-1) for p in (1,2,4,5))+'\nreturn run scoreboard players get #can_mate xq_ctx')
put('history/record','''
    # 元信息和局面计数同放 history 列表，悔棋复制 history 即完整恢复重复裁判状态。
    scoreboard players set #history_initial xq_ctx 0
    execute unless data entity @s data.xiangqi.history[{meta:1}] run scoreboard players set #history_initial xq_ctx 1
    execute if score #history_initial xq_ctx matches 1 run data modify entity @s data.xiangqi.history set value [{meta:1,rquiet:0,bquiet:0,loser:0}]
    scoreboard players set #rquiet xq_ctx 0
    scoreboard players set #bquiet xq_ctx 0
    execute store result score #rquiet xq_ctx run data get entity @s data.xiangqi.history[0].rquiet
    execute store result score #bquiet xq_ctx run data get entity @s data.xiangqi.history[0].bquiet
    function xiangqi:engine/check_current
    execute if score #history_initial xq_ctx matches 0 if score #side xq_ctx matches -1 if score #attacked xq_ctx matches 0 run scoreboard players add #rquiet xq_ctx 1
    execute if score #history_initial xq_ctx matches 0 if score #side xq_ctx matches 1 if score #attacked xq_ctx matches 0 run scoreboard players add #bquiet xq_ctx 1
    execute store result entity @s data.xiangqi.history[0].rquiet int 1 run scoreboard players get #rquiet xq_ctx
    execute store result entity @s data.xiangqi.history[0].bquiet int 1 run scoreboard players get #bquiet xq_ctx
    data modify storage xiangqi:engine history set value {key:"",piece:0,covered:0,turn:1}
'''+'\n'.join(f'execute store result storage xiangqi:engine history.piece int 1 run scoreboard players get #b{i} xq_ctx\nexecute store result storage xiangqi:engine history.covered int 1 run scoreboard players get #q{i} xq_ctx\nfunction xiangqi:engine/history/append with storage xiangqi:engine history' for i in range(90))+'''
    execute store result storage xiangqi:engine history.turn int 1 run scoreboard players get #side xq_ctx
    function xiangqi:engine/history/key with storage xiangqi:engine history
    function xiangqi:engine/history/count with storage xiangqi:engine history
''')
put('history/append','''
$execute if score #variant xq_ctx matches 1 run return run data modify storage xiangqi:engine history.key set value "$(key)$(piece):$(covered),"
$data modify storage xiangqi:engine history.key set value "$(key)$(piece),"
''')
put('history/key','$data modify storage xiangqi:engine history.key set value "$(key)/$(turn)"')
put('history/count','''
    scoreboard players set #rep xq_ctx 0
    $execute if data entity @s data.xiangqi.history[{key:"$(key)"}] store result score #rep xq_ctx run data get entity @s data.xiangqi.history[{key:"$(key)"}].count
    scoreboard players add #rep xq_ctx 1
    $execute unless data entity @s data.xiangqi.history[{key:"$(key)"}] run data modify entity @s data.xiangqi.history append value {key:"$(key)",count:0,rquiet:0,bquiet:0}
    $execute if score #rep xq_ctx matches 1 store result entity @s data.xiangqi.history[{key:"$(key)"}].rquiet int 1 run scoreboard players get #rquiet xq_ctx
    $execute if score #rep xq_ctx matches 1 store result entity @s data.xiangqi.history[{key:"$(key)"}].bquiet int 1 run scoreboard players get #bquiet xq_ctx
    $execute store result entity @s data.xiangqi.history[{key:"$(key)"}].count int 1 run scoreboard players get #rep xq_ctx
    scoreboard players operation @s xq_repetition = #rep xq_ctx
    data modify entity @s data.xiangqi.history[0].loser set value 0
    execute if score #rep xq_ctx matches 3.. run function xiangqi:engine/history/long_check with storage xiangqi:engine history
''')
put('history/long_check','''
    scoreboard players set #old_rquiet xq_ctx -1
    scoreboard players set #old_bquiet xq_ctx -1
    $execute store result score #old_rquiet xq_ctx run data get entity @s data.xiangqi.history[{key:"$(key)"}].rquiet
    $execute store result score #old_bquiet xq_ctx run data get entity @s data.xiangqi.history[{key:"$(key)"}].bquiet
    execute if score #old_rquiet xq_ctx = #rquiet xq_ctx unless score #old_bquiet xq_ctx = #bquiet xq_ctx run data modify entity @s data.xiangqi.history[0].loser set value 1
    execute if score #old_bquiet xq_ctx = #bquiet xq_ctx unless score #old_rquiet xq_ctx = #rquiet xq_ctx run data modify entity @s data.xiangqi.history[0].loser set value -1
''')
put('history/adjudicate','''
    scoreboard players set @s xq_reason 4
    scoreboard players set @s xq_result 3
    execute if data entity @s data.xiangqi.history[{meta:1,loser:1}] run scoreboard players set @s xq_result 2
    execute if data entity @s data.xiangqi.history[{meta:1,loser:-1}] run scoreboard players set @s xq_result 1
''')
put('covered/init', '''
    # 每方十五子独立不放回随机；将帅始终明置，不写入公共展示数据。
    data modify storage xiangqi:private bag set value [1,1,1,1,1,2,2,3,3,4,4,5,5,7,7]
'''+'\n'.join(f'function xiangqi:engine/covered/draw {{sq:{i},max:{14-index}}}' for index,i in enumerate(i for i,p in enumerate(initial) if p>0 and p!=6))+'''
    data modify storage xiangqi:private bag set value [-1,-1,-1,-1,-1,-2,-2,-3,-3,-4,-4,-5,-5,-7,-7]
'''+'\n'.join(f'function xiangqi:engine/covered/draw {{sq:{i},max:{14-index}}}' for index,i in enumerate(i for i,p in enumerate(initial) if p<0 and p!=-6))+'''
    data remove storage xiangqi:private bag
    data remove storage xiangqi:private pick
''')
put('covered/draw', '''
$execute store result storage xiangqi:private pick.slot int 1 run random value 0..$(max)
$data modify storage xiangqi:private pick.sq set value $(sq)
function xiangqi:engine/covered/pick with storage xiangqi:private pick
''')
put('covered/pick', '''
$execute store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=$(sq)},limit=1] xq_hidden run data get storage xiangqi:private bag[$(slot)]
$scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=$(sq)},limit=1] xq_covered 1
$data remove storage xiangqi:private bag[$(slot)]
''')
put('covered/reveal', '''
# 从模板到真实身份仅发生于真实落子提交，吃掉暗子不读取其身份。
$execute if score #covered xq_ctx matches 1 run scoreboard players operation #placed xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=$(from)},limit=1] xq_hidden
''')
put('covered/apply_real', '''
$scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=$(from)},limit=1] xq_hidden 0
$scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=$(from)},limit=1] xq_covered 0
$scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=$(to)},limit=1] xq_hidden = #placed xq_ctx
$scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=$(to)},limit=1] xq_covered 0
''')
# 揭棋的士、象可以越宫过河；不能沿用标准象棋的“仅防守子即和棋”。
for path,score in [('material','#dead'),('can_mate','#can_mate')]:
    target=ROOT/(path+'.mcfunction')
    original=target.read_text(encoding='utf-8').splitlines()
    extra=[]
    for i in range(90):
        for side in (1,-1):
            side_guard='' if path=='material' else f'if score #side xq_ctx matches {side} '
            for kind in (3,7):
                extra.append(f'execute if score #variant xq_ctx matches 1 {side_guard}if score #b{i} xq_ctx matches {kind*side} run scoreboard players set {score} xq_ctx {0 if path=="material" else 1}')
    put(path,'\n'.join(original[:-1]+extra+original[-1:]))
print(f'Generated {len(list(ROOT.rglob("*.mcfunction")))} Xiangqi engine functions.')
