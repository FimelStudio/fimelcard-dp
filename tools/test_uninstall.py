"""隔离存档中验证真实卸载、未知 storage 根键、已加载实体清理和重新安装。"""
import json
from pathlib import Path
from test_catan_engine import Suite,run

PACK=Path(__file__).resolve().parents[1]
M=json.loads((PACK/'tools/uninstall_manifest.json').read_text(encoding='utf-8'))


def build_suite():
    s=Suite()
    s.file('table','tag @s add ce.fixture\n$scoreboard players set @s ce_id $(table)')
    # 外部状态必须保留，模拟外部 BetterTitle 与其他包的数据。
    start=['scoreboard objectives add uninstall_test dummy','scoreboard objectives add unrelated dummy',
           'scoreboard players set sentinel unrelated 42',
           'data merge storage uninstall_test:trace {external:42}',
           'data merge storage title:io {uninstall_test_sentinel:42}',
           'summon minecraft:marker 8 64 8 {Tags:["ce.fixture","uninstall_test.keep"]}',
           'execute in minecraft:overworld run forceload add 1000 1000',
           'execute in minecraft:overworld run summon minecraft:marker 8 64 8 {Tags:["ma.visual","ma.racer_name"]}',
           'execute positioned 8 64 8 summon minecraft:marker run function catan_engine_test:table {table:101}',
           'tag @e[tag=ce.fixture,scores={ce_id=101},limit=1] add ct.controller',
           'scoreboard players set @e[tag=ct.controller,limit=1] ct_id 101',
           'scoreboard players set @e[tag=ct.controller,limit=1] ct_state 1',
           'scoreboard players set @e[tag=ct.controller,limit=1] ct_capacity 4',
           'scoreboard players set @e[tag=ct.controller,limit=1] ct_game 23',
           'tag @e[tag=ct.controller,limit=1] add ma.controller',
           'scoreboard players set #players ma_ctx 2',
           'execute as @e[tag=ct.controller,limit=1] at @s run function magical_athlete:engine/init',
           'execute as @e[tag=ct.controller,limit=1] at @s run function magical_athlete:game/sync']
    start+=s.check('entity @e[tag=ma.racer]','racer_fixture_loaded')
    start+=s.check('entity @e[tag=ct.part]','part_fixture_loaded')
    for storage in M['storages']:
        start += [f'data merge storage {storage} '+json.dumps({'unknown.root:quoted':{'value':[1,2,3]}},separators=(',',':'))]
    # 引号、转义、点号与长名称的根键都必须完全删除。
    roots={'plain':1,'dot.key':2,'key:colon':3,'key"quote':4,"key'quote":5,'key\\slash':6,'a'*180:8}
    start += ['data merge storage cardtable:debug '+json.dumps(roots,separators=(',',':')),
              'schedule function fimel_sklibs:sk_schedule/_1 500t append',
              'scoreboard objectives add fcs_ft_7_test trigger',
              'data modify storage fimel_skform:runtime database.scoreboards append value {scoreboard:"fcs_ft_7_test"}',
              'function cardtable:admin/uninstall',
              'scoreboard players set ticks uninstall_test 0',
              'schedule function catan_engine_test:wait_uninstall 1t replace']
    s.case('uninstall',start)
    s.waiting.add('uninstall')
    s.file('wait_uninstall',[
        'scoreboard players add ticks uninstall_test 1',
        'execute if data storage cardtable:uninstall active if score ticks uninstall_test matches ..1200 run return run schedule function catan_engine_test:wait_uninstall 1t replace',
        'function catan_engine_test:done/uninstall'])
    checks=s.check('score ticks uninstall_test matches ..1200','bounded_cleanup')
    for i,storage in enumerate(M['storages']):
        checks += [f'execute store result score #keys uninstall_test run data get storage {storage} {{}}']
        checks += s.check('score #keys uninstall_test matches 0',f'empty_storage_{i}')
    for i,objective in enumerate(M['objectives']):
        checks += [f'execute store success score #objective uninstall_test run scoreboard players set #probe {objective} 1']
        checks += s.check('score #objective uninstall_test matches 0',f'removed_objective_{i}')
    for tag in ('ma.racer','ma.racer_name','ma.visual','ct.part','ct.controller'):
        name='no_entities_'+tag.replace('.','_')
        # Suite.check 接受 unless 条件时无法再次反向，直接计数。
        checks += ['scoreboard players set #entities uninstall_test 0',f'execute as @e[tag={tag}] run scoreboard players add #entities uninstall_test 1']
        checks += s.check('score #entities uninstall_test matches 0',name)
    checks += s.check('entity @e[tag=uninstall_test.keep]','unrelated_entity_preserved')
    checks += s.check('score sentinel unrelated matches 42','unrelated_objective_preserved')
    checks += ['execute store success score #objective uninstall_test run scoreboard players set #probe fcs_ft_7_test 1']
    checks += s.check('score #objective uninstall_test matches 0','dynamic_form_objective_removed')
    checks += ['execute store success score #scheduled uninstall_test run schedule clear fimel_sklibs:sk_schedule/_1']
    checks += s.check('score #scheduled uninstall_test matches 0','scheduled_callback_cancelled')
    checks += s.check('data storage title:io {uninstall_test_sentinel:42}','external_library_storage_preserved')
    checks += s.check('data storage uninstall_test:trace {external:42}','unrelated_storage_preserved')
    checks += ['execute in minecraft:overworld store success score #forced uninstall_test run forceload query 1000 1000']
    checks += s.check('score #forced uninstall_test matches 1','unrelated_force_load_preserved')
    checks += ['execute in minecraft:overworld store success score #forced uninstall_test run forceload query -1 -1']
    checks += s.check('score #forced uninstall_test matches 0','owned_force_load_removed')
    # 保留文件但尚未 /reload 的期间，所有常驻入口都应安静退出，不能重新生成数据。
    for entry in json.loads((PACK/'data/minecraft/tags/function/tick.json').read_text(encoding='utf-8'))['values']:
        checks += [f'function {entry}']
    checks += ['function fimel_anim_text:_player_/count',
               'execute store result score #keys uninstall_test run data get storage fimel_sklibs:runtime {}']
    checks += s.check('score #keys uninstall_test matches 0','idle_does_not_recreate_storage')
    checks += ['execute store success score #objective uninstall_test run scoreboard players set #probe ct_ctx 1']
    checks += s.check('score #objective uninstall_test matches 0','idle_does_not_recreate_objectives')
    checks += ['schedule function catan_engine_test:reinstall 10t replace']
    s.file('done/uninstall',checks)
    reinstall=['function #minecraft:load']
    reinstall+=s.check('score #version ct_ctx matches 1..','reinstall_initializes_table')
    reinstall+=s.check('score #migration fv_ctx matches 1','reinstall_initializes_vendor')
    reinstall+=s.check('data storage magical_athlete:characters chars[35]','reinstall_restores_36_characters')
    reinstall+=s.check('data storage splendor:cards cards[89]','reinstall_restores_90_cards')
    reinstall+=['function cardtable:admin/uninstall','scoreboard players set ticks uninstall_test 0','schedule function catan_engine_test:wait_repeat 1t replace']
    s.file('reinstall',reinstall)
    s.file('wait_repeat',[
        'scoreboard players add ticks uninstall_test 1',
        'execute if data storage cardtable:uninstall active if score ticks uninstall_test matches ..1200 run return run schedule function catan_engine_test:wait_repeat 1t replace',
        'function catan_engine_test:repeat_done'])
    s.file('repeat_done',s.check('score ticks uninstall_test matches ..1200','repeat_uninstall_completes')+[
        'execute store result score #keys uninstall_test run data get storage cardtable:uninstall {}']+
        s.check('score #keys uninstall_test matches 0','uninstaller_removes_own_state')+[
        'execute in minecraft:overworld run forceload remove 1000 1000',
        'function catan_engine_test:finish'])
    s.file('finish','kill @e[tag=ce.fixture]\nsay CATAN_FINISHED')
    s.file('bootstrap',[
        'forceload add 0 0 63 31','scoreboard objectives add ce dummy','scoreboard objectives add ce_id dummy',
        # GameTest 的非主世界没有在线玩家，forceload 也不保证实体管理器已加载；
        # 本套只创建已加载主世界夹具，不把未加载实体冒充成可以由命令清理的状态。
        'summon minecraft:marker 10 64 10 {Tags:["ma.visual","ma.racer"]}',
        'summon minecraft:marker 12 64 12 {Tags:["ct.part"]}',
        'schedule function catan_engine_test:case/uninstall 5t'])
    return s


def prepare(target):
    (target/'data/minecraft/tags/function/load.json').write_bytes((PACK/'data/minecraft/tags/function/load.json').read_bytes())


if __name__=='__main__':
    raise SystemExit(run(build_suite(),full=True,prepare_target=prepare,prefix='fimel-uninstall-',setup_ticks=2600))
