"""Build variable chair layouts while preserving public, stable seat IDs."""
from build_table_pause_guards import write_guarded
from pathlib import Path
import re

PACK = Path(__file__).resolve().parents[1]
BASE = PACK / 'data/cardtable/function'
OBJECTIVES = {'ct_chairs': 'dummy', 'ct_clmask': 'dummy', 'ct_clver': 'dummy',
              **{f'ct_c{i}': 'dummy' for i in range(1, 9)}}
SEATS = {4: [(0,-2),(2,0),(0,2),(-2,0)],
         8: [(-1,-2.5),(1,-2.5),(2.5,-1),(2.5,1),(1,2.5),(-1,2.5),(-2.5,1),(-2.5,-1)]}
ORDER = {4: [1,3,2,4], 8: [1,5,3,7,2,6,4,8]}
MODELS = {1:'sofa',2:'electro_chair',3:'toys_chair',4:'vintage_chair',5:'bamboo_chair',6:'garden_chair'}


def write(name, lines):
    p = BASE / (name + '.mcfunction')
    p.parent.mkdir(parents=True, exist_ok=True)
    write_guarded(p, '\n'.join(lines) + '\n', encoding='utf-8')


def positions(cap, seat):
    x,z = SEATS[cap][seat-1]
    if cap == 4:
        return [('', x,z)]
    other = seat+1 if seat%2 else seat-1
    single = (0,z) if seat<=2 or 5<=seat<=6 else (x,0)
    return [(f'if score @s ct_c{other} matches 1 ',x,z),
            (f'unless score @s ct_c{other} matches 1 ',*single)]


def spawn_lines(cap, y, target):
    out=[]
    for seat in range(1,cap+1):
        out.append(f'scoreboard players set #new_seat ct_ctx {seat}')
        for condition,x,z in positions(cap,seat):
            out.append(f'execute if score @s ct_c{seat} matches 1 {condition}positioned ~{x} ~{y} ~{z} run {target}')
    return out


def build():
    write('chairs/layout/load', ['# 椅子数量与固定座号布局；重载回收未完成的临时重排标记。'] +
          [f'scoreboard objectives add {obj} {kind}' for obj,kind in OBJECTIVES.items()] +
          ['tag @e[tag=ct.layout_busy] remove ct.layout_busy',
           'tag @a[tag=ct.layout_remount] remove ct.layout_remount'])
    write('chairs/layout/apply', [
        '# Controller; caller has already validated the lobby setting request.',
        'execute unless score @s ct_state matches 0 run return fail',
        'function cardtable:chairs/layout/normalize',
        'scoreboard players set @s ct_clver 0',
        'function cardtable:chairs/layout/ensure',
        'scoreboard players add @s ct_ch_epoch 1',
    ])
    norm=[
        '# Keep occupied actual seat IDs, then fill opposite sides before doubling a side.',
        'execute unless score @s ct_ch_epoch matches 0.. run scoreboard players set @s ct_ch_epoch 0',
        'execute unless score @s ct_chairs matches 1..8 run scoreboard players operation @s ct_chairs = @s ct_capacity',
        'function cardtable:chairs/settings/minimum',
        'execute if score @s ct_chairs < #chair_min ct_ctx run scoreboard players operation @s ct_chairs = #chair_min ct_ctx',
        'execute if score @s ct_chairs > @s ct_capacity run scoreboard players operation @s ct_chairs = @s ct_capacity',
        'scoreboard players operation #chair_table ct_ctx = @s ct_id',
        'scoreboard players set #chair_count ct_ctx 0',
    ]
    for i in range(1,9):
        norm += [f'scoreboard players set #chair_old_{i} ct_ctx 0',
                 f'execute if score @s ct_c{i} matches 1 run scoreboard players set #chair_old_{i} ct_ctx 1',
                 f'scoreboard players set @s ct_c{i} 0',
                 f'execute as @a[tag=ct.player,scores={{ct_seat={i}}}] if score @s ct_id = #chair_table ct_ctx run scoreboard players set #chair_slot_{i} ct_ctx 1']
    # Occupancy temporaries must be cleared before reading players, including nested mounting.
    at=norm.index('scoreboard players set #chair_count ct_ctx 0')+1
    norm[at:at]=[f'scoreboard players set #chair_slot_{i} ct_ctx 0' for i in range(1,9)]
    for i in range(1,9):
        norm += [f'execute if score #chair_slot_{i} ct_ctx matches 1 run scoreboard players set @s ct_c{i} 1',
                 f'execute if score @s ct_c{i} matches 1 run scoreboard players add #chair_count ct_ctx 1']
    norm += ['execute if score @s ct_chairs < #chair_count ct_ctx run scoreboard players operation @s ct_chairs = #chair_count ct_ctx',
             'execute unless score @s ct_capacity matches 8 run function cardtable:chairs/layout/fill4',
             'execute if score @s ct_capacity matches 8 run function cardtable:chairs/layout/fill8',
             'scoreboard players set #chair_mask ct_ctx 0']
    for i in range(1,9):
        norm.append(f'execute if score @s ct_c{i} matches 1 run scoreboard players add #chair_mask ct_ctx {2**(i-1)}')
    write('chairs/layout/normalize',norm)
    for cap in (4,8):
        lines=[]
        for i in ORDER[cap]:
            lines += [f'execute if score #chair_count ct_ctx < @s ct_chairs unless score @s ct_c{i} matches 1 run scoreboard players add #chair_count ct_ctx 1',
                      f'execute if score #chair_count ct_ctx <= @s ct_chairs if score #chair_count ct_ctx matches 1.. unless score @s ct_c{i} matches 1 run function cardtable:chairs/layout/fill_slot_{i}']
        # A fill step must only set a slot when it was actually counted.
        lines=[]
        for i in ORDER[cap]:
            lines.append(f'execute if score #chair_count ct_ctx < @s ct_chairs unless score @s ct_c{i} matches 1 run function cardtable:chairs/layout/fill_slot_{i}')
        retained=[f'execute if score #chair_count ct_ctx < @s ct_chairs if score #chair_old_{i} ct_ctx matches 1 unless score @s ct_c{i} matches 1 run function cardtable:chairs/layout/fill_slot_{i}' for i in ORDER[cap]]
        lines=retained+lines
        write(f'chairs/layout/fill{cap}',lines)
    for i in range(1,9):
        write(f'chairs/layout/fill_slot_{i}',[f'scoreboard players set @s ct_c{i} 1','scoreboard players add #chair_count ct_ctx 1'])
    write('chairs/layout/ensure',[
        '# Controller at table center. Do not pull players back merely because they dismounted.',
        'execute if entity @s[tag=ct.layout_busy] run return 0',
        'execute unless loaded ~-3 ~ ~-3 run return 0',
        'execute unless loaded ~3 ~ ~-3 run return 0',
        'execute unless loaded ~-3 ~ ~3 run return 0',
        'execute unless loaded ~3 ~ ~3 run return 0',
        'function cardtable:chairs/layout/normalize',
        'execute unless score @s ct_clmask = #chair_mask ct_ctx run return run function cardtable:chairs/layout/reposition',
        'execute unless score @s ct_clver matches 1 run return run function cardtable:chairs/layout/reposition',
        'scoreboard players operation #seat_owner ct_ctx = @s ct_id',
        'execute unless score @s ct_capacity matches 8 run function cardtable:chairs/layout/ensure4',
        'execute if score @s ct_capacity matches 8 run function cardtable:chairs/layout/ensure8',
    ])
    reposition=[
        '# Preserve only passengers actually riding this table. Move all seats before remounting.',
        'tag @s add ct.layout_busy',
        'scoreboard players operation #seat_owner ct_ctx = @s ct_id',
        'scoreboard players operation @s ct_clmask = #chair_mask ct_ctx',
        'scoreboard players set @s ct_clver 1',
        'tag @a[tag=ct.layout_remount] remove ct.layout_remount',
        'execute as @e[type=minecraft:interaction,tag=ct.seat] if score @s ct_id = #seat_owner ct_ctx on passengers if entity @s[type=minecraft:player,tag=ct.player] if score @s ct_id = #seat_owner ct_ctx run tag @s add ct.layout_remount',
        'execute as @a[tag=ct.layout_remount] run ride @s dismount',
    ]
    for i in range(1,9):
        reposition.append(f'execute unless score @s ct_c{i} matches 1 as @e[type=minecraft:interaction,tag=ct.seat,scores={{ct_seat={i}}}] if score @s ct_id = #seat_owner ct_ctx run kill @s')
    reposition += [
        'execute unless score @s ct_capacity matches 8 run function cardtable:chairs/layout/ensure4',
        'execute if score @s ct_capacity matches 8 run function cardtable:chairs/layout/ensure8',
        'function cardtable:chairs/layout/rebuild_visual',
        'execute as @a[tag=ct.layout_remount] at @s run function cardtable:seat/mount',
        'tag @a[tag=ct.layout_remount] remove ct.layout_remount',
        'tag @s remove ct.layout_busy',
    ]
    write('chairs/layout/reposition',reposition)
    for cap in (4,8):
        write(f'chairs/layout/ensure{cap}',spawn_lines(cap,.32,'function cardtable:seat/ensure_one'))
    legacy=[f'execute as @e[type=minecraft:item_display,tag=ct.skin] if score @s ct_id = #seat_owner ct_ctx if items entity @s contents minecraft:paper[minecraft:item_model="card:table_skin/{model}"] run tag @s add ct.skin_chair' for model in MODELS.values()]
    write('chairs/layout/rebuild_visual',[
        '# Rebuild chairs only; preserve table, board and corner decorations.',
        'scoreboard players operation #seat_owner ct_ctx = @s ct_id',
        *legacy,
        'execute as @e[tag=ct.chair4] if score @s ct_id = #seat_owner ct_ctx run kill @s',
        'execute as @e[tag=ct.chair8] if score @s ct_id = #seat_owner ct_ctx run kill @s',
        'execute as @e[tag=ct.skin_chair] if score @s ct_id = #seat_owner ct_ctx run kill @s',
        'function cardtable:chairs/layout/spawn_visual',
    ])
    write('chairs/layout/spawn_visual',[
        'execute unless score @s ct_chairs matches 1..8 run function cardtable:chairs/layout/normalize',
        'scoreboard players operation #seat_owner ct_ctx = @s ct_id',
        'scoreboard players operation #skin_table ct_ctx = @s ct_id',
        'execute if score @s ct_skin matches 0 if entity @s[tag=ct.no_structure] run return 0',
        'execute unless score @s ct_capacity matches 8 run function cardtable:chairs/layout/visual4',
        'execute if score @s ct_capacity matches 8 run function cardtable:chairs/layout/visual8',
    ])
    for cap in (4,8):
        lines=[]
        for seat in range(1,cap+1):
            yaw=(0,90,-180,-90)[(seat-1)//2 if cap==8 else seat-1]
            lines += [f'scoreboard players set #new_seat ct_ctx {seat}']
            for condition,x,z in positions(cap,seat):
                prefix=f'execute if score @s ct_c{seat} matches 1 {condition}'
                lines.append(prefix+f'if score @s ct_skin matches 0 positioned ~{x} ~0 ~{z} summon minecraft:block_display run function cardtable:seat/chair{cap}_init')
                for skin,model in MODELS.items():
                    lines.append(prefix+f'if score @s ct_skin matches {skin} positioned ~{x} ~0.5 ~{z} summon minecraft:item_display run function cardtable:chairs/layout/skin_init {{model:"{model}",yaw:{yaw},seat:{seat}}}')
        write(f'chairs/layout/visual{cap}',lines)
    write('chairs/layout/skin_init',[
        '$function cardtable:skin/item {model:"$(model)",yaw:$(yaw)}',
        'tag @s add ct.skin_chair',
        '$scoreboard players set @s ct_seat $(seat)',
    ])
    # Public metadata for modules needing a seat target without an online player.
    for cap in (4,8):
        lines=[]
        for seat in range(1,cap+1):
            for condition,x,z in positions(cap,seat):
                lines.append(f'execute if score #layout_seat ct_ctx matches {seat} {condition}run data modify storage cardtable:layout position set value {{x:{float(x)}d,y:0.32d,z:{float(z)}d}}')
        write(f'chairs/layout/position{cap}',lines)
    write('chairs/layout/position',[
        '# Controller. Macro seat returns relative position in storage cardtable:layout position.',
        '$scoreboard players set #layout_seat ct_ctx $(seat)',
        'execute unless score @s ct_capacity matches 8 run function cardtable:chairs/layout/position4',
        'execute if score @s ct_capacity matches 8 run function cardtable:chairs/layout/position8',
    ])
    write('table/ensure_seats',['# Preserve enabled slots and repaired seats after reload or reconnect.','function cardtable:chairs/layout/ensure'])
    write('table/ensure_seats8',['# Compatibility entry; the shared layout chooses table capacity.','function cardtable:chairs/layout/ensure'])
    # Spawning remains compatible with old table init, which assigns the four legacy new-seat tags.
    write('table/spawn_seats',[
        'function cardtable:chairs/layout/normalize',
        'scoreboard players operation #seat_owner ct_ctx = @s ct_id',
        'execute unless score @s ct_capacity matches 8 run function cardtable:chairs/layout/ensure4',
        'execute if score @s ct_capacity matches 8 run function cardtable:chairs/layout/ensure8',
        'execute if score @s ct_capacity matches 8 run function cardtable:table/spawn_chairs8',
        'data merge entity @s {data:{cardtable:{chairs_version:1}}}',
    ])
    write('table/spawn_seats8',['function cardtable:table/spawn_seats'])
    for cap in (4,8):
        write(f'table/spawn_chairs{cap}',[
            'execute if score @s ct_skin matches 1..6 run return 0',
            'scoreboard players operation #seat_owner ct_ctx = @s ct_id',
            f'execute as @e[tag=ct.chair{cap}] if score @s ct_id = #seat_owner ct_ctx run kill @s',
            'function cardtable:chairs/layout/spawn_visual',
        ])
    # Ensure can recover an offline player's vehicle and move it to the enabled slot's actual position.
    ensure=BASE/'seat/ensure_one.mcfunction'
    text=ensure.read_text(encoding='utf-8')
    anchor='kill @e[type=minecraft:interaction,tag=ct.seat_candidate,tag=!ct.seat_keep,tag=!ct.seat_occupied]'
    move='execute if entity @s[tag=ct.layout_busy] as @e[tag=ct.seat_keep] run tp @s ~ ~ ~'
    if move not in text:text=text.replace(anchor,anchor+'\n'+move)
    repair='execute as @e[tag=ct.seat_keep,tag=!ct.seat_occupied] unless entity @s[distance=..0.001] run tp @s ~ ~ ~'
    if repair not in text:text=text.replace(move,move+'\n# 离线旧载具可能晚于缩椅回载；只校正无人且偏离当前锚点的副本。\n'+repair)
    write_guarded(ensure, text,encoding='utf-8')
    mount=BASE/'seat/mount.mcfunction'
    text=mount.read_text(encoding='utf-8')
    hook='''# A chess game may assign a previously hidden stable slot; reconcile all players together.
scoreboard players operation #mount_table ct_ctx = @s ct_id
execute as @e[type=minecraft:marker,tag=ct.controller] if score @s ct_id = #mount_table ct_ctx at @s run function cardtable:chairs/layout/ensure
'''
    if hook not in text:text=hook+text
    write_guarded(mount, text,encoding='utf-8')
    # Theme generation keeps only furniture and decor; all chairs now share the layout renderer.
    for p in (BASE/'skin').glob('*.mcfunction'):
        if not re.match(r'(?:elegant|electro|toys|vintage|bamboo|garden)[48]$',p.stem):continue
        text=p.read_text(encoding='utf-8')
        lines=text.splitlines()
        first=None; kept=[]
        for line in lines:
            if 'summon minecraft:item_display' in line and re.search(r'model:"(?:sofa|\w+_chair)"',line):
                if first is None:first=len(kept)
                continue
            kept.append(line)
        if first is not None:kept.insert(first,'function cardtable:chairs/layout/spawn_visual')
        write('skin/'+p.stem,kept)
    themes=PACK/'tools/build_table_themes.mjs'
    source=themes.read_text(encoding='utf-8')
    old='add(x,.5,z,t.models.chair,((yaw+(t.chairOffset||0)+540)%360)-180);'
    new='/* Chairs are generated by the stable-slot layout renderer. */'
    if old in source:
        source=source.replace(old,new)
        source=source.replace('const r=cap===4?2:2.5;',"s+='function cardtable:chairs/layout/spawn_visual\\n';\n const r=cap===4?2:2.5;")
        write_guarded(themes, source,encoding='utf-8')
    # Hand-written Avalon reveal follows the same side center as the public chairs.
    start=PACK/'data/avalon/function/reveal/start.mcfunction'
    source=start.read_text(encoding='utf-8')
    hook='\n'.join(f'scoreboard players operation #reveal_c{i} av_ctx = @s ct_c{i}' for i in range(1,9))
    if '#reveal_c1 av_ctx' not in source:
        source=source.replace('execute as @a[tag=av.audience] run function avalon:reveal/player',hook+'\nexecute as @a[tag=av.audience] run function avalon:reveal/player')
        write_guarded(start, source,encoding='utf-8')
    p=PACK/'data/avalon/function/reveal/player.mcfunction'
    source=p.read_text(encoding='utf-8')
    if '#reveal_c' not in source:
        lines=[]
        for line in source.splitlines():
            found=re.match(r'execute if score @s av_seat matches ([1-8]) positioned ~([^ ]+) ~1.08 ~([^ ]+) (.*)',line)
            if not found:lines.append(line);continue
            seat=int(found[1]);x,z=found.group(2,3);other=seat+1 if seat%2 else seat-1
            cx,cz=('0',z) if seat<=2 or 5<=seat<=6 else (x,'0')
            lines += [f'execute if score #reveal_c{other} av_ctx matches 1 if score @s av_seat matches {seat} positioned ~{x} ~1.08 ~{z} {found[4]}',
                      f'execute unless score #reveal_c{other} av_ctx matches 1 if score @s av_seat matches {seat} positioned ~{cx} ~1.08 ~{cz} {found[4]}']
        write_guarded(p, '\n'.join(lines)+'\n',encoding='utf-8')


if __name__=='__main__':
    build()
    print('Built stable chair layouts for 4- and 8-seat tables.')
