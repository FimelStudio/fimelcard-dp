"""掼蛋纯牌型引擎：按牌点缺口识别百搭，不枚举两张百搭的所有花色解释。"""
from pathlib import Path
import json

PACK = Path(__file__).resolve().parents[1]
ROOT = PACK / 'data/guandan/function'
KINDS = {1: '单张', 2: '对子', 3: '三同张', 4: '三带二', 5: '三连对', 6: '钢板', 7: '顺子', 8: '炸弹', 9: '同花顺', 10: '四大天王'}
OBJECTIVES = ['gd_ctx', 'gd_point', 'gd_suit', 'gd_wild', 'gd_strength', 'gd_kind', 'gd_size', 'gd_high', 'gd_power', 'gd_lastkind', 'gd_lastsize', 'gd_lasthi', 'gd_lastpow']


def rank_name(rank):
    return {1: 'A', 11: 'J', 12: 'Q', 13: 'K', 14: 'A', 15: '小王', 16: '大王'}.get(rank, str(rank))


def seq_ranks(low, length):
    return [14 if r == 1 else r for r in range(low, low+length)]


def build(root=ROOT):
    def put(name, lines):
        p = root / (name+'.mcfunction')
        p.parent.mkdir(parents=True, exist_ok=True)
        p.write_text(('\n'.join(lines) if isinstance(lines, list) else lines).strip()+'\n', encoding='utf-8')

    put('cards/install', ['# 仅补充牌型模块所用目标；由游戏 load 调用。'] + [f'scoreboard objectives add {o} dummy' for o in OBJECTIVES])
    put('cards/constants', [f'scoreboard players set #{n} gd_ctx {n}' for n in (10, 13, 54, 1000, 100000)])
    put('cards/normalize', '''
# 执行者为实体牌，#level gd_ctx 为本副级牌；不改所有权、选中、使用状态。
scoreboard players operation @s gd_point = @s gd_type
scoreboard players operation @s gd_point %= #13 gd_ctx
scoreboard players add @s gd_point 2
scoreboard players operation @s gd_suit = @s gd_type
scoreboard players operation @s gd_suit /= #13 gd_ctx
execute if score @s gd_type matches 52.. run scoreboard players set @s gd_suit -1
execute if score @s gd_type matches 52 run scoreboard players set @s gd_point 15
execute if score @s gd_type matches 53 run scoreboard players set @s gd_point 16
scoreboard players set @s gd_wild 0
execute if score @s gd_suit matches 2 if score @s gd_point = #level gd_ctx run scoreboard players set @s gd_wild 1
scoreboard players operation @s gd_strength = @s gd_point
execute if score @s gd_point = #level gd_ctx run scoreboard players set @s gd_strength 15
execute if score @s gd_type matches 52 run scoreboard players set @s gd_strength 16
execute if score @s gd_type matches 53 run scoreboard players set @s gd_strength 17
''')
    put('cards/context', '''
# 调用链内临时实体集合每次按桌号重建，不能依靠距离确定归属。
tag @e[tag=gd.cards] remove gd.cards
scoreboard players operation #card_table gd_ctx = @s ct_id
execute as @e[type=minecraft:marker,tag=gd.card] if score @s ct_id = #card_table gd_ctx run tag @s add gd.cards
scoreboard players operation #level gd_ctx = @s gd_level
''')
    put('cards/analyze', ['# 只读本桌 gd.selected，列举所有合法解释；上手比较不影响候选生成。', 'function guandan:cards/constants', 'function guandan:cards/context', 'data modify entity @s data.guandan.options set value []', 'scoreboard players set #options gd_ctx 0', 'scoreboard players set #cards gd_ctx 0', 'scoreboard players set #wild gd_ctx 0', 'scoreboard players set #bad gd_ctx 0', 'scoreboard players set #nonwild gd_ctx 0'] + [f'scoreboard players set #r{r} gd_ctx 0' for r in range(2,17)] + [f'scoreboard players set #s{s} gd_ctx 0' for s in range(4)] + ['execute as @e[tag=gd.cards,tag=gd.selected] run function guandan:cards/count', 'execute if score #bad gd_ctx matches 1.. run return 0', 'execute unless score #cards gd_ctx matches 1..10 run return 0', 'execute unless score #wild gd_ctx matches 0..2 run return 0', 'scoreboard players operation #nonwild gd_ctx = #cards gd_ctx', 'scoreboard players operation #nonwild gd_ctx -= #wild gd_ctx', 'execute if score #cards gd_ctx matches 1 run function guandan:cards/single', 'execute if score #cards gd_ctx matches 2..3 run function guandan:cards/same', 'execute if score #cards gd_ctx matches 4..10 run function guandan:cards/bomb', 'execute if score #cards gd_ctx matches 5 run function guandan:cards/full_house', 'execute if score #cards gd_ctx matches 5..6 run function guandan:cards/sequences', 'execute if score #cards gd_ctx matches 4 if score #r15 gd_ctx matches 2 if score #r16 gd_ctx matches 2 run function guandan:cards/four_jokers'])
    put('cards/count', ['scoreboard players add #cards gd_ctx 1', 'execute unless score @s gd_type matches 0..53 run scoreboard players add #bad gd_ctx 1', 'function guandan:cards/normalize', 'execute if score @s gd_wild matches 1 run scoreboard players add #wild gd_ctx 1'] + [f'execute if score @s gd_wild matches 0 if score @s gd_point matches {r} run scoreboard players add #r{r} gd_ctx 1' for r in range(2,17)] + [f'execute if score @s gd_wild matches 0 if score @s gd_suit matches {s} run scoreboard players add #s{s} gd_ctx 1' for s in range(4)])
    # 输出参数在 fake players；所有候选经统一 append 比较，缓存完整候选于本桌控制器。
    def candidate(kind, size, point, suit=-1, power=0, label=None):
        high = point
        lines = [f'scoreboard players set #kind gd_ctx {kind}', f'scoreboard players set #size gd_ctx {size}', f'scoreboard players set #point gd_ctx {point}', f'scoreboard players set #high gd_ctx {high}', f'scoreboard players set #power gd_ctx {power}', f'scoreboard players set #suit gd_ctx {suit}']
        if kind in (1,2,3,4,8) and point <= 14:
            lines += [f'execute if score #level gd_ctx matches {point} run scoreboard players set #high gd_ctx 15']
        elif kind in (1,2) and point >= 15:
            lines += [f'scoreboard players set #high gd_ctx {point+1}']
        text = label or f'{KINDS[kind]} {rank_name(point)}'
        lines += [f'data modify storage guandan:cards candidate set value {{"label":{json.dumps(text,ensure_ascii=False)}}}', 'function guandan:cards/append']
        return lines

    lines = []
    for r in range(2,17):
        lines += [f'execute if score #r{r} gd_ctx matches 1 run function guandan:cards/single_{r}']
        put(f'cards/single_{r}', candidate(1,1,r))
    # 红桃级牌单出必须为本身的级牌；只有搭配牌型时才可代替其他非王牌。
    lines += ['execute if score #wild gd_ctx matches 1 run function guandan:cards/single_wild']
    put('cards/single',lines)
    put('cards/single_wild', ['scoreboard players operation #point gd_ctx = #level gd_ctx', 'scoreboard players set #kind gd_ctx 1', 'scoreboard players set #size gd_ctx 1', 'scoreboard players set #high gd_ctx 15', 'scoreboard players set #power gd_ctx 0', 'scoreboard players set #suit gd_ctx -1', 'data modify storage guandan:cards candidate set value {label:"单张 级牌"}', 'function guandan:cards/append'])
    same = []
    for size,kind in ((2,2),(3,3)):
        for r in range(2,17 if size==2 else 15):
            condition = f'execute if score #cards gd_ctx matches {size} if score #r{r} gd_ctx = #nonwild gd_ctx'
            if r >=15:condition += ' if score #wild gd_ctx matches 0'
            same.append(condition+f' run function guandan:cards/same_{size}_{r}')
            put(f'cards/same_{size}_{r}',candidate(kind,size,r))
    put('cards/same',same)
    bomb=[]
    for size in range(4,11):
        for r in range(2,15):
            bomb.append(f'execute if score #cards gd_ctx matches {size} if score #r{r} gd_ctx = #nonwild gd_ctx run function guandan:cards/bomb_{size}_{r}')
            put(f'cards/bomb_{size}_{r}',candidate(8,size,r,power=size if size<=5 else size+1,label=f'{size}张炸弹 {rank_name(r)}'))
    put('cards/bomb',bomb)
    # 三带二只比较三张点数；相同三张而不同百搭对子解释合并成一个选项。
    full=[]
    for trip in range(2,15):
        body=['scoreboard players set #full gd_ctx 0']
        for pair in range(2,17):
            if pair==trip:continue
            body += [f'scoreboard players operation #inside gd_ctx = #r{trip} gd_ctx',f'scoreboard players operation #inside gd_ctx += #r{pair} gd_ctx', f'execute if score #r{trip} gd_ctx matches ..3 if score #r{pair} gd_ctx matches ..2 if score #inside gd_ctx = #nonwild gd_ctx'+(f' if score #r{pair} gd_ctx matches 2' if pair>=15 else '')+' run scoreboard players set #full gd_ctx 1']
        body+=['execute if score #full gd_ctx matches 1 run function guandan:cards/full_append_'+str(trip)]
        put(f'cards/full_{trip}',body)
        put(f'cards/full_append_{trip}',candidate(4,5,trip))
        full+=[f'function guandan:cards/full_{trip}']
    put('cards/full_house',full)
    seq=[]
    for kind,length,multi in ((5,3,2),(6,2,3),(7,5,1)):
        for low in range(1,16-length):
            ranks=seq_ranks(low,length);high=low+length-1;name=f'{kind}_{low}'
            body=['scoreboard players set #inside gd_ctx 0']+[f'scoreboard players operation #inside gd_ctx += #r{r} gd_ctx' for r in ranks]
            cond='execute if score #inside gd_ctx = #nonwild gd_ctx'+''.join(f' if score #r{r} gd_ctx matches ..{multi}' for r in ranks)
            if kind==7:
                # 天然五张同花只能为同花顺；有逢人配可声明不同花色，故仍有普通顺子解释。
                body+=['scoreboard players set #natural_flush gd_ctx 0']+[f'execute if score #wild gd_ctx matches 0 if score #s{s} gd_ctx matches 5 run scoreboard players set #natural_flush gd_ctx 1' for s in range(4)]
                body+=[cond+f' if score #natural_flush gd_ctx matches 0 run function guandan:cards/seq_append_{name}']
                for suit in range(4):
                    body+=[cond+f' if score #s{suit} gd_ctx = #nonwild gd_ctx run function guandan:cards/seq_flush_{low}_{suit}']
                    put(f'cards/seq_flush_{low}_{suit}',candidate(9,5,high,suit=suit,power=6,label='同花顺 '+''.join(rank_name(r) for r in range(low,low+length))+f'（{"梅花 方块 红桃 黑桃".split()[suit]}）'))
            else:body+=[cond+f' run function guandan:cards/seq_append_{name}']
            put(f'cards/seq_{name}',body)
            put(f'cards/seq_append_{name}',candidate(kind,length*multi,high,label=KINDS[kind]+' '+''.join(rank_name(r)*multi for r in range(low,low+length))))
            seq+=[f'execute if score #cards gd_ctx matches {length*multi} run function guandan:cards/seq_{name}']
    put('cards/sequences',seq)
    put('cards/four_jokers',candidate(10,4,17,power=99,label='四大天王'))
    put('cards/compare', '''
# 对外比较控制器已选定牌型；内部候选比较使用 compare_candidate。
scoreboard players operation #kind gd_ctx = @s gd_kind
scoreboard players operation #size gd_ctx = @s gd_size
scoreboard players operation #high gd_ctx = @s gd_high
scoreboard players operation #power gd_ctx = @s gd_power
function guandan:cards/compare_candidate
''')
    put('cards/compare_candidate', '''
# 比较临时 #kind/#size/#high/#power，不读花色；同牌同点不能盖。
scoreboard players set #beats gd_ctx 0
execute unless score @s gd_lastkind matches 1..10 run return run scoreboard players set #beats gd_ctx 1
execute if score #power gd_ctx > @s gd_lastpow run return run scoreboard players set #beats gd_ctx 1
execute unless score #power gd_ctx = @s gd_lastpow run return 0
execute unless score #kind gd_ctx = @s gd_lastkind run return 0
execute unless score #size gd_ctx = @s gd_lastsize run return 0
execute if score #high gd_ctx > @s gd_lasthi run scoreboard players set #beats gd_ctx 1
''')
    put('cards/append', '''
function guandan:cards/compare_candidate
execute store result storage guandan:cards candidate.kind int 1 run scoreboard players get #kind gd_ctx
execute store result storage guandan:cards candidate.size int 1 run scoreboard players get #size gd_ctx
execute store result storage guandan:cards candidate.high int 1 run scoreboard players get #high gd_ctx
execute store result storage guandan:cards candidate.point int 1 run scoreboard players get #point gd_ctx
execute store result storage guandan:cards candidate.power int 1 run scoreboard players get #power gd_ctx
execute store result storage guandan:cards candidate.suit int 1 run scoreboard players get #suit gd_ctx
execute store result storage guandan:cards candidate.beat int 1 run scoreboard players get #beats gd_ctx
scoreboard players operation #code gd_ctx = #kind gd_ctx
scoreboard players operation #code gd_ctx *= #100000 gd_ctx
scoreboard players operation #temp gd_ctx = #size gd_ctx
scoreboard players operation #temp gd_ctx *= #1000 gd_ctx
scoreboard players operation #code gd_ctx += #temp gd_ctx
scoreboard players operation #temp gd_ctx = #high gd_ctx
scoreboard players operation #temp gd_ctx *= #10 gd_ctx
scoreboard players operation #code gd_ctx += #temp gd_ctx
scoreboard players operation #code gd_ctx += #suit gd_ctx
scoreboard players add #code gd_ctx 1
execute store result storage guandan:cards candidate.code int 1 run scoreboard players get #code gd_ctx
data modify entity @s data.guandan.options append from storage guandan:cards candidate
scoreboard players add #options gd_ctx 1
''')
    put('cards/choose', '''
# 不消耗牌：出牌生命周期在 choose 成功后自行提交。
scoreboard players set #ok gd_ctx 0
execute unless score #choice gd_ctx matches 0..999 run return 0
execute store result score #options gd_ctx run data get entity @s data.guandan.options
execute unless score #choice gd_ctx < #options gd_ctx run return 0
execute store result storage guandan:cards choice.index int 1 run scoreboard players get #choice gd_ctx
function guandan:cards/choose_index with storage guandan:cards choice
''')
    put('cards/choose_index', '''
$data modify storage guandan:cards chosen set from entity @s data.guandan.options[$(index)]
execute store result score #kind gd_ctx run data get storage guandan:cards chosen.kind
execute store result score #size gd_ctx run data get storage guandan:cards chosen.size
execute store result score #high gd_ctx run data get storage guandan:cards chosen.high
execute store result score #power gd_ctx run data get storage guandan:cards chosen.power
# 即使候选旧缓存曾能盖，也以当前上一手重新比较，不能信任缓存 beat。
function guandan:cards/compare_candidate
execute unless score #beats gd_ctx matches 1 run return 0
scoreboard players operation @s gd_kind = #kind gd_ctx
scoreboard players operation @s gd_size = #size gd_ctx
scoreboard players operation @s gd_high = #high gd_ctx
scoreboard players operation @s gd_power = #power gd_ctx
data modify entity @s data.guandan.chosen set from storage guandan:cards chosen
scoreboard players set #ok gd_ctx 1
''')


if __name__=='__main__':
    build()
    print('掼蛋牌型识别与比较函数已生成。')
