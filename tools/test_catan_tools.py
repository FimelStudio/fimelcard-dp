"""真实 item Thrower/origin 路径与 Q 道具参数的原版回归。"""
import shutil
import json
from test_catan_engine import Suite,run,PACK,C

P='@e[type=minecraft:armor_stand,tag=qt.person,limit=1]'
ITEM='@e[type=minecraft:item,tag=qt.item,limit=1]'


def prepare(target):
    shutil.copytree(PACK/'data/catan',target/'data/catan',dirs_exist_ok=True)
    for path in (target/'data/catan/function').rglob('*.mcfunction'):
        out=[]
        for line in path.read_text(encoding='utf-8').splitlines():
            if 'run function catan:input/give' in line:continue
            if not any(v in line for v in ('tellraw ','title ','dialog ','playsound ','stopsound ','item replace ','clear @')):
                line=line.replace('@a[tag=','@e[type=minecraft:armor_stand,tag=qt.person,tag=')
            out.append(line)
        path.write_text('\n'.join(out)+'\n',encoding='utf-8')
    (target/'data/minecraft/tags/function/load.json').write_text('{"values":["catan:load"]}',encoding='utf-8')


def main():
    s=Suite()
    bootstrap=[]
    for obj in ('ct_id','ct_seat','ct_state','ct_game','ct_capacity'):
        bootstrap += [f'scoreboard objectives add {obj} dummy']
    setup=s.setup(n=3)+[f'tag {C} add ct.controller',f'tag {C} add ca.controller',f'scoreboard players set {C} ct_id 101',f'scoreboard players set {C} ct_game 21',f'scoreboard players set {C} ct_state 1',f'scoreboard players set {C} ct_capacity 4',f'scoreboard players set {C} ca_anim 0',f'execute as {C} run function catan:game/sync']
    for p in range(1,4):setup += [f'data modify entity {C} data.catan.p{p}.name set value {{text:"测试{p}"}}',f'data modify entity {C} data.catan.p{p}.seat set value {p}']
    setup += ['execute positioned 8.0 65.0 8.0 summon minecraft:armor_stand run function catan_engine_test:person',f'execute as {P} run function catan:ui/init']
    s.file('person','''
tag @s add ce.fixture
tag @s add qt.person
tag @s add ct.player
tag @s add ca.player
scoreboard players set @s ct_id 101
scoreboard players set @s ca_table 101
scoreboard players set @s ca_side 1
scoreboard players set @s ca_seat 1
data merge entity @s {Invisible:1b,NoGravity:1b,Invulnerable:1b}
''')
    def item(table=101,action=0,owned=True):
        nbt={'Tags':['qt.item','ce.fixture'],'PickupDelay':32767,'Item':{'id':'minecraft:paper','count':1,'components':{'minecraft:custom_data':{'catan':{'tool':True,'action':action,'table':table}}}}}
        c=['kill @e[tag=qt.item]','summon minecraft:item 8.0 65.0 8.0 '+json.dumps(nbt,separators=(',',':'))]
        if owned:c += [f'data modify entity {ITEM} Thrower set from entity {P} UUID']
        return c
    c=setup+item()+[f'scoreboard players set {P} ca_drop 1',f'execute as {P} at @s run function catan:input/drop']
    c+=s.score(P,'ca_nonce','2..','q_opens_menu')+s.score(P,'ca_drop',0,'q_resets_counter')+s.check('entity '+P.replace('tag=qt.person','tag=qt.person,tag=ca.actor'),'q_resolves_actor')+s.check('entity '+P.replace('tag=qt.person','tag=qt.person,tag=!ca.dropper'),'q_clears_dropper')
    c+=['scoreboard players set #count ce 0','execute as @e[tag=qt.item] run scoreboard players add #count ce 1']+s.score('#count','ce',0,'owned_item_consumed')
    c+=['scoreboard players operation #old_nonce ce = '+P+' ca_nonce']+item(table=202)+[f'execute as {P} at @s run function catan:input/drop']+s.check(f'score {P} ca_nonce = #old_nonce ce','old_table_tool_cannot_open')
    c+=item(owned=False)+[f'execute as {P} at @s run function catan:input/drop']+s.check(f'entity {ITEM}','unowned_tool_not_consumed')
    s.case('q_path',c)
    # 替身没有玩家背包，但仍实际解析动态道具组件。
    c=setup+['data modify storage catan:input table set value 101',f'execute as {P} run function catan:input/menu_tool with storage catan:input',f'execute as {P} run function catan:input/aim_tool with storage catan:input']+s.data('phase',1,'tool_macro_no_rule_mutation')
    s.case('tool_macros',c)
    s.finish();s.files['bootstrap']='\n'.join(bootstrap)+'\n'+s.files['bootstrap']
    return run(s,prepare_target=prepare,prefix='fimel-catan-tools-',setup_ticks=100)


if __name__=='__main__':raise SystemExit(main())
