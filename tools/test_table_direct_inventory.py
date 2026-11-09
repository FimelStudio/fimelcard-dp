"""用等容量容器桥接真实物品组件，验证两款游戏镜像、防丢与普通物品保护。"""
import json
import re
import shutil
from pathlib import Path
from test_catan_engine import Suite, TABLE, run, PACK

A='@e[type=minecraft:chest_minecart,tag=di.actor,limit=1]'
B='@e[type=minecraft:chest_minecart,tag=di.bag,limit=1]'


def build():
    s=Suite()
    def call(ns,name):return [f'execute as {A} at @s run function {ns}:{name}']
    def setup(ns):
        pre='ca' if ns=='catan' else 'ma';game=21 if pre=='ca' else 23
        c=['kill @e[tag=ce.fixture]',f'execute positioned 8 64 8 summon minecraft:marker run function catan_engine_test:table {{table:101}}',f'tag {TABLE} add ct.controller',f'tag {TABLE} add {pre}.controller',f'scoreboard players set {TABLE} ct_id 101',f'scoreboard players set {TABLE} ct_game {game}',f'scoreboard players set {TABLE} ct_state 1',f'scoreboard players set {TABLE} ct_capacity 4',f'scoreboard players set {TABLE} ct_paused 0',f'scoreboard players set {TABLE} {pre}_anim 0',f'scoreboard players set {TABLE} {pre}_orient 0',f'scoreboard players set #players {pre}_ctx '+('3' if pre=='ca' else '2'),f'execute as {TABLE} run function {ns}:engine/init','summon minecraft:chest_minecart 8 64 8 {Tags:["di.actor","ce.fixture","ct.player","'+pre+'.player"]}','summon minecraft:chest_minecart 8 64 9 {Tags:["di.bag","ce.fixture"]}']
        for k,v in [('ct_id',101),('ct_seat',1),('ct_paused',0),(pre+'_table',101),(pre+'_seat',1),(pre+'_side',1)]:c += [f'scoreboard players set {A} {k} {v}']
        c += [f'execute as {TABLE} run function {ns}:game/sync']
        return c
    def set(ns,path,val):return [f'data modify entity {TABLE} data.{ns}.{path} set value '+json.dumps(val,separators=(',',':'))]
    def has(slot,match,label,bag=False):return s.check(f'items entity {B if bag else A} container.{slot} {match}',label)
    def count(slot,value,label,bag=True):
        return [f'execute store result score #count ce run data get entity {B if bag else A} Items[{{Slot:{slot}b}}].count']+s.score('#count','ce',value,label)
    c=setup('catan')+set('catan','p1.resources',[3,2,1,4,5])+set('catan','p1.dev',[1,2,1,1,2])+set('catan','p1.fresh',[1,0,0,0,1])+call('catan','direct/sync')
    for i in range(5):
        c+=has(i,f'minecraft:paper[minecraft:custom_data~{{catan:{{resource:1b,id:{i},table:101}}}}]',f'ca_resource_{i}_metadata',True)+count(i,[3,2,1,4,5][i],f'ca_resource_{i}_count')
    c+=has(5,'minecraft:paper[minecraft:custom_data~{catan:{development:1b,id:0,fresh:0}}]','ca_old_knight_present',True)
    c+=has(6,'minecraft:paper[minecraft:custom_data~{catan:{development:1b,id:0,fresh:1}}]','ca_fresh_knight_distinct',True)
    c+=has(0,'minecraft:paper[minecraft:custom_data~{catan:{build:2}}]','ca_building_tool_is_paper')
    c+=[f'data modify storage direct_inventory_test:run saved set from entity {TABLE} data.catan']+call('catan','direct/sync')
    c+=[f'execute store success score #changed ce run data modify storage direct_inventory_test:run saved set from entity {TABLE} data.catan']+s.score('#changed','ce',0,'ca_inventory_never_changes_authority')
    c+=count(0,3,'ca_repeat_does_not_duplicate')
    c+=[f'item replace entity {A} container.{i} with minecraft:air' for i in range(9)]+call('catan','direct/sync')+has(7,'minecraft:paper[minecraft:custom_data~{catan:{control:1b,action:10}}]','ca_lost_controls_recover')
    c+=[f'item replace entity {A} container.0 with minecraft:paper[minecraft:item_model="card:catan/settlement/red",minecraft:custom_data={{catan:{{tool:1b,build:2,action:1,table:101}}}}]']+call('catan','direct/sync')+has(0,'minecraft:paper[minecraft:custom_data~{catan:{control:1b,build:2}}]','ca_legacy_building_migrates')
    c+=[f'item replace entity {B} container.0 with minecraft:air']+call('catan','direct/sync')+count(0,3,'ca_missing_resource_recovers')
    c+=[f'item replace entity {A} container.0 with minecraft:stone 32',f'scoreboard players set {A} ca_depoch -1']+call('catan','direct/sync')+has(0,'minecraft:stone','ca_preserves_foreign_hotbar_item')
    s.case('ca_inventory',c)
    c=setup('catan')+[f'item replace entity {B} container.{i} with minecraft:stone 64' for i in range(27)]+set('catan','p1.resources',[2,0,0,0,0])+call('catan','direct/sync')
    c+=has(0,'minecraft:stone','ca_full_bag_does_not_overwrite',True)+s.check(f'data entity {TABLE} data.catan.p1{{resources:[2,0,0,0,0]}}','ca_full_bag_assets_retained')
    c+=[f'item replace entity {B} container.0 with minecraft:air']+call('catan','direct/sync')+count(0,2,'ca_space_available_recovers')
    s.case('ca_full_inventory',c)
    c=setup('magical_athlete')+set('magical_athlete','phase',2)+set('magical_athlete','p1.hand',list(range(8)))+[f'execute as {TABLE} run function magical_athlete:game/sync']+call('magical_athlete','direct/sync')
    for i in range(6):c+=has(i,f'minecraft:paper[minecraft:custom_data~{{magical_athlete:{{code:{200+i},table:101,epoch:1}}}}]',f'ma_private_character_{i}')
    for i in range(8):c+=has(i,f'minecraft:paper[minecraft:custom_data~{{magical_athlete:{{roster:1b,char:{i},table:101}}}}]',f'ma_persistent_roster_{i}',True)
    c+=s.score(A,'ma_expected',17,'ma_roster_and_controls_count')
    c+=has(6,'minecraft:paper[minecraft:custom_data~{magical_athlete:{code:9999}}]','ma_page_tool')+has(7,'minecraft:paper[minecraft:custom_data~{magical_athlete:{dice:1b}}]','ma_die_present')+has(8,'minecraft:paper[minecraft:custom_data~{magical_athlete:{code:9998}}]','ma_cancel_present')
    c+=call('magical_athlete','direct/use_choice {code:9999,epoch:1,table:101}')+has(0,'minecraft:paper[minecraft:custom_data~{magical_athlete:{code:206}}]','ma_second_page_first_character')
    c+=[f'item replace entity {A} container.0 with minecraft:stone 32',f'scoreboard players set {A} ma_depoch -1']+call('magical_athlete','direct/sync')+has(0,'minecraft:stone','ma_preserves_foreign_hotbar_item')
    c+=set('magical_athlete','phase',3)+set('magical_athlete','p1.hand',[6,7])+set('magical_athlete','p1.selected',[0,1])+[f'execute as {TABLE} run function magical_athlete:game/sync',f'scoreboard players set {A} ma_depoch -1']+call('magical_athlete','direct/sync')
    c+=has(0,'minecraft:paper[minecraft:custom_name={text:"〔本场已提交〕炼金术士：主要移动掷出1或2，可改走4格。",color:"aqua",italic:false}]','ma_current_lineup_label',True)
    c+=has(2,'minecraft:paper[minecraft:custom_name={text:"〔已使用〕香蕉：超越你的运动员完成移动后绊倒。",color:"aqua",italic:false}]','ma_used_role_kept_and_labeled',True)
    c+=has(7,'minecraft:paper[minecraft:custom_data~{magical_athlete:{roster:1b,char:7}}]','ma_unused_role_kept_during_race',True)
    s.case('ma_inventory',c)
    s.finish()
    s.files['bootstrap']='\n'.join(['forceload add 0 0 63 31','scoreboard objectives add ce dummy','scoreboard objectives add ce_id dummy','function direct_inventory_bridge:load',f'schedule function catan_engine_test:case/{next(iter(s.cases))} 5t'])+'\n'
    return s


def prepare(target):
    for ns in ('catan','magical_athlete'):
        shutil.copytree(PACK/f'data/{ns}/function',target/f'data/{ns}/function',dirs_exist_ok=True)
        shutil.copytree(PACK/f'data/{ns}/loot_table',target/f'data/{ns}/loot_table',dirs_exist_ok=True)
    root=target/'data/direct_inventory_bridge/function';root.mkdir(parents=True)
    clear=['scoreboard players set #bridge_total ce 0']
    for who,slots in [('@s',range(9)),(B,range(27))]:
        for i in slots:
            clear += [f'$execute if items entity {who} container.{i} $(match) store result score #bridge_count ce run data get entity {who} Items[{{Slot:{i}b}}].count',f'$execute if items entity {who} container.{i} $(match) run scoreboard players operation #bridge_total ce += #bridge_count ce',f'$execute if predicate {{condition:"minecraft:value_check",value:$(remove),range:1}} if items entity {who} container.{i} $(match) run item replace entity {who} container.{i} with minecraft:air']
    clear+=['return run scoreboard players get #bridge_total ce']
    (root/'clear.mcfunction').write_text('\n'.join(clear)+'\n',encoding='utf-8')
    for ns in ('catan','magical_athlete'):
        dest=target/f'data/{ns}/function'
        for path in dest.rglob('*.mcfunction'):
            body=path.read_text(encoding='utf-8')
            body='\n'.join(line if any(t in line for t in ('dialog show ','dialog clear ','tellraw ','playsound ','stopsound ','title ')) else re.sub(r'@a\[','@e[type=minecraft:chest_minecart,tag=di.actor,',line).replace('@a ','@e[type=minecraft:chest_minecart,tag=di.actor] ') for line in body.splitlines())+'\n'
            body=re.sub(r'clear @s (.+?)( 0)?$',lambda m:'function direct_inventory_bridge:clear {match:'+json.dumps(m[1],ensure_ascii=False)+',remove:'+('0' if m[2] else '1')+'}',body,flags=re.M)
            def bridge_give(match):
                name='give_'+path.stem
                lines=['scoreboard players set #inserted ce 0']+[f'execute if score #inserted ce matches 0 unless items entity {B} container.{i} * run function direct_inventory_bridge:{name}_{i} with storage catan:direct card' for i in range(27)]
                (root/(name+'.mcfunction')).write_text('\n'.join(lines)+'\n',encoding='utf-8')
                for i in range(27):(root/f'{name}_{i}.mcfunction').write_text(f'$item replace entity {B} container.{i} with '+match[1]+' $(count)\nscoreboard players set #inserted ce 1\n',encoding='utf-8')
                return 'function direct_inventory_bridge:'+name+' {count:$(count)}'
            body=re.sub(r'give @s (.+) (\$\(count\))$',bridge_give,body,flags=re.M)
            body=re.sub(r'items entity @s inventory\.(\d+)',rf'items entity {B} container.\1',body)
            body=body.replace('item replace entity @s inventory.',f'item replace entity {B} container.').replace('hotbar.','container.')
            path.write_text(body,encoding='utf-8')
        for name,body in {'notice':'$data modify storage direct_inventory_test:run notice set value $(text)','build':'','deactivate':'','tick':''}.items():
            (dest/f'hud/{name}.mcfunction').write_text(body+'\n',encoding='utf-8')
    (root/'load.mcfunction').write_text('\n'.join(['function catan:system/install','function catan:engine/install','function catan:direct/load','function catan:hud/load','function magical_athlete:system/install','scoreboard objectives add ma_ctx dummy','function magical_athlete:engine/install','function magical_athlete:ui/load','function magical_athlete:direct/load','function magical_athlete:hud/load','scoreboard objectives add ct_id dummy','scoreboard objectives add ct_game dummy','scoreboard objectives add ct_state dummy','scoreboard objectives add ct_capacity dummy','scoreboard objectives add ct_seat dummy','scoreboard objectives add ct_paused dummy'])+'\n',encoding='utf-8')
    (target/'data/minecraft/tags/function/load.json').write_text(json.dumps({'values':['direct_inventory_bridge:load']}),encoding='utf-8')


if __name__=='__main__':raise SystemExit(run(build(),prepare_target=prepare,prefix='fimel-direct-inventory-',setup_ticks=240))
