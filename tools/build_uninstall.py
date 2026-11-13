"""生成完整卸载清单与运行护栏。新增资源后最后运行本工具；不读取玩家存档。"""
from pathlib import Path
import json
import re

PACK=Path(__file__).resolve().parents[1]
DATA=PACK/'data'
ROOT=DATA/'cardtable/function/uninstall'
STATE='cardtable:uninstall'
BEGIN='# uninstall-guard: begin (tools/build_uninstall.py)'
END='# uninstall-guard: end'


def write(path,body):
    path.parent.mkdir(parents=True,exist_ok=True)
    if not isinstance(body,str):body='\n'.join(body)
    path.write_bytes((body.rstrip()+'\n').encode('utf-8'))


def put(name,body):write(ROOT/(name+'.mcfunction'),body)


def inventory():
    objectives=set();storages=set();tags=set();items=set();schedules=set();sounds=set()
    namespaces={p.name for p in DATA.iterdir() if p.is_dir()}-{'minecraft'}
    for p in DATA.rglob('*.mcfunction'):
        if p.is_relative_to(ROOT) or p==DATA/'cardtable/function/admin/uninstall.mcfunction':continue
        text=p.read_text(encoding='utf-8-sig')
        text='\n'.join(line for line in text.splitlines() if not line.lstrip().startswith('#'))
        objectives.update(o for o in re.findall(r'\bscoreboard objectives add\s+([^\s]+)',text) if '$(' not in o)
        storages.update(s for s in re.findall(r'\bstorage\s+([a-z0-9_.-]+:[a-z0-9_./-]+)',text) if s.split(':')[0] in namespaces)
        tags.update(re.findall(r'\btag .+? (?:add|remove)\s+([a-zA-Z0-9_.-]+)',text))
        tags.update(re.findall(r'\btag=!?([a-zA-Z0-9_.-]+)',text))
        # 物品按专属 custom_data 根键识别，不按纸张、羊毛等原版物品类型清空。
        items.update(re.findall(r'minecraft:custom_data[=~]\{([a-zA-Z0-9_]+):',text))
        schedules.update(re.findall(r'\bschedule function\s+([#a-z0-9_.:/-]+)',text))
        sounds.update(s for s in re.findall(r'\b(?:play|stop)sound\s+(?:@[^\s]+\s+\*\s+)?((?:card|[a-z_]+):[a-z0-9_./-]+)',text) if not s.startswith('minecraft:'))
    prefixes=('ct.','fc.','lh.','hb.','ab.','bw.','dc.','cp.','wq.','sk.','dd.','un.','ch.','xq.','gm.','ac.','av.','ll.','gd.','go.','it.','ca.','sp.','ma.','fimel.')
    tags={t for t in tags if t.startswith(prefixes)}-{'ct.uninstall_pending'}
    storages.discard(STATE)
    storages.add('cardtable:installation')
    # 升级不会自动删除旧世界的已建目标；历史清单只能累积，不能因新版删掉定义而漏清。
    objectives.update(('dc_sd','dc_sform'))
    manifest=PACK/'tools/uninstall_manifest.json'
    if manifest.exists():
        previous=json.loads(manifest.read_text(encoding='utf-8'))
        for key,values in [('objectives',objectives),('storages',storages),('tags',tags),
                           ('item_roots',items),('schedules',schedules),('sounds',sounds)]:
            values.update(previous.get(key,[]))
    advancements=sorted(p.relative_to(DATA).parts[0]+':'+p.relative_to(DATA).relative_to(p.relative_to(DATA).parts[0]+'/advancement').with_suffix('').as_posix() for p in DATA.glob('*/advancement/**/*.json'))
    return {'objectives':sorted(objectives),'storages':sorted(storages),'tags':sorted(tags),
            'item_roots':sorted(items),'schedules':sorted(schedules),'sounds':sorted(sounds),'advancements':advancements}


def guards():
    roles={}
    for kind in ('load','tick'):
        values=json.loads((DATA/f'minecraft/tags/function/{kind}.json').read_text(encoding='utf-8'))['values']
        for value in values:
            name=value if isinstance(value,str) else value['id']
            roles.setdefault(name,set()).add(kind)
    for p in DATA.glob('*/advancement/**/*.json'):
        body=json.loads(p.read_text(encoding='utf-8'))
        name=body.get('rewards',{}).get('function')
        if name:roles.setdefault(name,set()).add('event')
        enabled={'type':'minecraft:int_value_check','value':{'type':'minecraft:score','target':{'type':'minecraft:fixed','name':'#version'},'score':'ct_ctx'},'test':{'min':1}}
        for criterion in body.get('criteria',{}).values():
            conditions=criterion.setdefault('conditions',{})
            player=conditions.get('player',[])
            if isinstance(player,dict) and player.get('type')=='minecraft:all_of':player=player['terms']
            elif isinstance(player,dict):player=[{'type':'minecraft:entity_properties','entity':'this','predicate':player}]
            if enabled not in player:player.append(enabled)
            conditions['player']={'type':'minecraft:all_of','terms':player}
        write(p,json.dumps(body,ensure_ascii=False,indent=2))
    for name,kinds in roles.items():
        ns,leaf=name.split(':');p=DATA/ns/'function'/(leaf+'.mcfunction')
        text=p.read_text(encoding='utf-8-sig')
        text=re.sub(re.escape(BEGIN)+r'\n.*?\n'+re.escape(END)+r'\n?','',text,flags=re.S)
        lines=[BEGIN,f'execute if data storage {STATE} active run return 0']
        if kinds-{'load'}:lines+=['execute unless score #version ct_ctx matches 1.. run return 0']
        write(p,[*lines,END,text.lstrip()])
    # 卸载期间 tick advancement 可能被原版再次标为完成，安装时重新分配玩家编号。
    p=DATA/'fimel_vendor/function/load.mcfunction'
    text=p.read_text(encoding='utf-8')
    line='advancement revoke @a only fimel_anim_text:player.count'
    if line not in text:write(p,text+'\n'+line)
    # 记录内置库强加载前的状态，仅撤销确实由本包新建的强加载。
    for name in ('fimel_anim_text:_initialize_/load','fimel_title:code/load'):
        ns,leaf=name.split(':');p=DATA/ns/'function'/(leaf+'.mcfunction')
        lines=p.read_text(encoding='utf-8').splitlines();result=[]
        for line in lines:
            if line.startswith('function cardtable:uninstall/remember_chunk '):continue
            if line=='forceload add 1 1':result+=['function cardtable:uninstall/remember_chunk {x:1,z:1}']
            if line=='forceload add -1 -1 1 1':
                result += [f'function cardtable:uninstall/remember_chunk {{x:{x},z:{z}}}' for x,z in ((-1,-1),(-1,1),(1,-1),(1,1))]
            result.append(line)
        write(p,result)


def build():
    guards();m=inventory()
    write(PACK/'tools/uninstall_manifest.json',json.dumps(m,ensure_ascii=False,indent=2))
    write(DATA/'cardtable/function/admin/uninstall.mcfunction',[
        f'execute if data storage {STATE} active run return run tellraw @a {{text:"[牌桌] 正在卸载，请等待完成提示。",color:"yellow"}}',
        f'data modify storage {STATE} active set value 1b',
        'tellraw @a {text:"[牌桌] 开始卸载：结束所有牌局并清理运行数据，请等待完成提示后再移除数据包。",color:"yellow"}',
        'scoreboard objectives add ct_ctx dummy','scoreboard players reset #version ct_ctx',
        f'execute in minecraft:overworld store success storage {STATE} helper_existed byte 1 run forceload query 0 0',
        'execute in minecraft:overworld run forceload add 0 0',
        'function cardtable:uninstall/cancel_schedules',
        *[f'tag @a[tag={tag}] add ct.uninstall_member' for tag in m['tags'] if tag.endswith('.player')],
        'tag @a add ct.uninstall_pending',
        'function cardtable:uninstall/step'])
    put('cancel_schedules',[f'schedule clear {name}' for name in m['schedules']]+['schedule clear cardtable:uninstall/step','schedule clear cardtable:uninstall/storage_tick'])
    put('step',[
        'execute if entity @e[type=minecraft:marker,tag=ct.controller] run return run function cardtable:uninstall/table',
        'execute if entity @a[tag=ct.uninstall_pending] run return run function cardtable:uninstall/next_player',
        'execute if data storage fimel_skform:runtime database.scoreboards[0] run return run function cardtable:uninstall/dynamic_objective',
        'function cardtable:uninstall/entities',
        *[f'advancement revoke @a only {name}' for name in m['advancements']],
        f'data modify storage {STATE} chunks set from storage cardtable:installation chunks',
        f'data modify storage {STATE} queue set value '+json.dumps([{'id':s} for s in m['storages']],separators=(',',':')),
        'schedule function cardtable:uninstall/storage_tick 1t replace'])
    put('table',[
        '# 选择器不限定世界坐标，覆盖所有维度中已加载的控制器。',
        'execute as @e[type=minecraft:marker,tag=ct.controller,limit=1] at @s run function cardtable:table/remove',
        'schedule function cardtable:uninstall/step 1t replace'])
    put('next_player',[
        'execute as @a[tag=ct.uninstall_pending,limit=1] at @s run function cardtable:uninstall/player',
        'schedule function cardtable:uninstall/step 1t replace'])
    put('dynamic_objective',[
        'function cardtable:uninstall/dynamic_remove with storage fimel_skform:runtime database.scoreboards[0]',
        'data remove storage fimel_skform:runtime database.scoreboards[0]',
        'schedule function cardtable:uninstall/step 1t replace'])
    put('dynamic_remove','$scoreboard objectives remove $(scoreboard)')
    put('player',[
        'execute if entity @s[tag=ct.uninstall_member] run dialog clear @s',
        'execute if entity @s[tag=ct.uninstall_member] run title @s clear',
        'execute if entity @s[tag=ct.uninstall_member] run function cardtable:game/remove_offline_player',
        'execute if entity @s[tag=fimel.bt_paused] run function fimel_vendor:hud/release',
        *[f'clear @s *[minecraft:custom_data~{{{key}:{{}}}}]' for key in m['item_roots']],
        *[f'execute if items entity @s enderchest.{slot} *[minecraft:custom_data~{{{key}:{{}}}}] run item replace entity @s enderchest.{slot} with minecraft:air' for key in m['item_roots'] for slot in range(27)],
        *[f'stopsound @s * {sound}' for sound in m['sounds']],
        *[f'tag @s remove {tag}' for tag in m['tags']],
        'tag @s remove ct.uninstall_member','tag @s remove ct.uninstall_pending'])
    put('entities',[
        *[f'kill @e[type=!minecraft:player,tag={tag}]' for tag in m['tags']],
        *[f'execute as @e[type=minecraft:item] if items entity @s contents *[minecraft:custom_data~{{{key}:{{}}}}] run kill @s' for key in m['item_roots']]])
    put('remember_chunk',[
        '$execute if data storage cardtable:installation chunks[{x:$(x),z:$(z)}] run return 0',
        '$data modify storage cardtable:installation chunk set value {x:$(x),z:$(z),existed:1b}',
        '$execute in minecraft:overworld store success storage cardtable:installation chunk.existed byte 1 run forceload query $(x) $(z)',
        'data modify storage cardtable:installation chunks append from storage cardtable:installation chunk',
        'data remove storage cardtable:installation chunk'])
    put('release_chunks',[
        f'execute unless data storage {STATE} chunks[0] run return 0',
        f'function cardtable:uninstall/release_chunk with storage {STATE} chunks[0]',
        f'data remove storage {STATE} chunks[0]',
        'function cardtable:uninstall/release_chunks'])
    put('release_chunk','$execute in minecraft:overworld unless predicate {type:"minecraft:int_value_check",value:$(existed),test:1} run forceload remove $(x) $(z)')
    # 原版不能直接删 storage 根对象。26.2 NBT 文本的首个键位于 extra[2]；
    # 直接读取其原版转义结果，兼容未知、带点、引号和长键。每刻最多 128 个根键。
    put('storage_tick',[
        'execute in minecraft:overworld unless entity @e[tag=ct.uninstall_resolver] positioned 0 0 0 run summon minecraft:item_display ~ ~ ~ {Tags:["ct.uninstall_resolver"],view_range:0f}',
        'scoreboard players set #un_budget ct_ctx 128',
        f'execute unless data storage {STATE} scan if data storage {STATE} queue[0] run function cardtable:uninstall/storage_begin with storage {STATE} queue[0]',
        f'execute if data storage {STATE} scan unless data storage {STATE} scan.done run function cardtable:uninstall/storage_scan',
        f'execute if data storage {STATE} scan.done run data remove storage {STATE} queue[0]',
        f'execute if data storage {STATE} scan.done run data remove storage {STATE} scan',
        f'execute unless data storage {STATE} queue[0] run return run function cardtable:uninstall/finish',
        'schedule function cardtable:uninstall/storage_tick 1t replace'])
    put('storage_begin',[
        f'$data modify storage {STATE} scan set value {{id:"$(id)",quote:""}}',
        '$execute store result score #un_keys ct_ctx run data get storage $(id) {}',
        f'execute if score #un_keys ct_ctx matches 0 run data modify storage {STATE} scan.done set value 1b',
        'execute if score #un_keys ct_ctx matches 0 run return 0',
        f'$data modify storage {STATE} scan.component set value {{nbt:"{{}}",storage:"$(id)"}}',
        'function cardtable:uninstall/storage_stringify'])
    put('storage_stringify',[
        'execute as @e[type=minecraft:item_display,tag=ct.uninstall_resolver,limit=1] at @s run loot replace entity @s contents loot cardtable:uninstall/stringify',
        f'data modify storage {STATE} scan.key set from entity @e[type=minecraft:item_display,tag=ct.uninstall_resolver,limit=1] item.components."minecraft:custom_name".extra[2].text',
        f'execute if data entity @e[type=minecraft:item_display,tag=ct.uninstall_resolver,limit=1] item.components."minecraft:custom_name".extra[2].extra[0] run data modify storage {STATE} scan.quote set from entity @e[type=minecraft:item_display,tag=ct.uninstall_resolver,limit=1] item.components."minecraft:custom_name".extra[2].text',
        f'data modify storage {STATE} scan.key set from entity @e[type=minecraft:item_display,tag=ct.uninstall_resolver,limit=1] item.components."minecraft:custom_name".extra[2].extra[0].text'])
    write(DATA/'cardtable/loot_table/uninstall/stringify.json',json.dumps({'pools':[{'rolls':1,'entries':[{'type':'minecraft:item','name':'minecraft:paper',
        'functions':[{'function':'minecraft:set_name','entity':'this','name':{'nbt':'scan.component','storage':STATE,'interpret':True}}]}]}]},indent=2))
    put('storage_scan',[
        'execute unless score #un_budget ct_ctx matches 1.. run return 0',
        'scoreboard players remove #un_budget ct_ctx 1',
        'function cardtable:uninstall/storage_remove'])
    put('storage_remove',[
        f'execute if data storage {STATE} scan'+json.dumps({'quote':"'"})+f' run function cardtable:uninstall/storage_remove_single with storage {STATE} scan',
        f'execute unless data storage {STATE} scan'+json.dumps({'quote':"'"})+f' run function cardtable:uninstall/storage_remove_double with storage {STATE} scan',
        f'function cardtable:uninstall/storage_begin with storage {STATE} scan',
        f'execute unless data storage {STATE} scan.done run function cardtable:uninstall/storage_scan'])
    # 宏会先解析全部分支，两种引号需要分别放在两个函数中。
    put('storage_remove_single',"$data remove storage $(id) '$(key)'")
    put('storage_remove_double','$data remove storage $(id) "$(key)"')
    put('finish',[
        'function cardtable:uninstall/cancel_schedules',
        'kill @e[type=minecraft:item_display,tag=ct.uninstall_resolver]',
        'function cardtable:uninstall/release_chunks',
        f'execute in minecraft:overworld if data storage {STATE} {{helper_existed:0b}} run forceload remove 0 0',
        *[f'scoreboard objectives remove {o}' for o in m['objectives'] if o!='ct_ctx'],
        'scoreboard objectives remove ct_ctx',
        *[f'data remove storage {STATE} {key}' for key in ('queue','scan','chunks','helper_existed','active')],
        'tellraw @a {text:"[牌桌] 卸载完成：已结束牌局并清理已加载实体、在线玩家状态、storage 和计分板。现在可以移除数据包；以后重新放回并 /reload 即可全新安装。",color:"green"}'])
    print('Uninstall inventory:',', '.join(f'{k}={len(v)}' for k,v in m.items()))


if __name__=='__main__':build()
