"""26.2物品镜像回归：用两个容器桥接玩家的快捷栏和主物品栏。

生产mcfunction原样执行权威状态读取、计数、槽位恢复和Q分派。由于
GameTest没有客户端玩家，仅把clear和玩家槽位映射到同容量的两个容器，
不替换规则或物品组件；模型与中文名称仍由原版服务端解析。
"""
from pathlib import Path
import json
import re
import shutil
from test_catan_engine import Suite, TABLE, OTHER, run
from build_splendor_inventory import NAMES, ITEMS

PACK = Path(__file__).resolve().parents[1]
ACTOR = '@e[type=minecraft:chest_minecart,tag=si.actor,limit=1]'
BAG = '@e[type=minecraft:chest_minecart,tag=si.bag,limit=1]'


class InventorySuite(Suite):
    def call(self, name):
        return [f'execute as {ACTOR} at @s run function splendor:inventory/{name}']

    def setup(self):
        return ['kill @e[tag=ce.fixture]',
                'execute positioned 8 64 8 summon minecraft:marker run function catan_engine_test:table {table:101}',
                'execute positioned 40 64 8 summon minecraft:marker run function catan_engine_test:table {table:202}',
                f'tag {TABLE} add ct.controller', f'tag {OTHER} add ct.controller',
                f'scoreboard players set {TABLE} ct_id 101', f'scoreboard players set {OTHER} ct_id 202',
                f'scoreboard players set {TABLE} ct_game 22', f'scoreboard players set {OTHER} ct_game 22',
                f'scoreboard players set {TABLE} ct_state 1', f'scoreboard players set {OTHER} ct_state 1',
                'scoreboard players set #players sp_ctx 2',
                f'execute as {TABLE} run function splendor:engine/init',
                f'execute as {OTHER} run function splendor:engine/init',
                'summon minecraft:chest_minecart 8 64 8 {Tags:["si.actor","ce.fixture","sp.player","ct.player"]}',
                'summon minecraft:chest_minecart 8 64 9 {Tags:["si.bag","ce.fixture"]}',
                f'scoreboard players set {ACTOR} sp_table 101', f'scoreboard players set {ACTOR} ct_id 101',
                f'scoreboard players set {ACTOR} sp_side 1', f'scoreboard players set {ACTOR} ct_paused 0',
                f'scoreboard players set {ACTOR} sp_idrop 0',
                'scoreboard players set #reserve_calls ce 0', 'scoreboard players set #return_calls ce 0']

    def set(self, path, value, table=101):
        return [f'data modify entity {TABLE if table == 101 else OTHER} data.splendor.{path} set value ' + json.dumps(value, separators=(',', ':'))]

    def has(self, slot, metadata, name, bag=False):
        return self.check(f'items entity {BAG if bag else ACTOR} container.{slot} *[minecraft:custom_data~{{splendor:{{{metadata}}}}}]', name)

    def count(self, slot, value, name, bag=False):
        return [f'execute store result score #value ce run data get entity {BAG if bag else ACTOR} Items[{{Slot:{slot}b}}].count'] + self.score('#value', 'ce', value, name)

    def empty(self, slot, name, bag=False):
        who = BAG if bag else ACTOR
        return self.check('entity ' + who[:-1] + f',nbt=!{{Items:[{{Slot:{slot}b}}]}}]', name)


def build_suite():
    s = InventorySuite()
    body = s.setup() + s.set('p1.tokens', [2, 3, 1, 2, 1, 1]) + s.set('p1.cards', [0, 0, 1]) + s.set('p1.nobles', [0]) + s.set('p1.reserve', [50, 89]) + s.call('sync')
    for i, name in enumerate(NAMES):
        body += s.has(i, f'kind:0,color:{i},table:101,owner:1', f'gem_{i}_metadata')
        body += s.check(f'items entity {ACTOR} container.{i} minecraft:paper[minecraft:item_model="minecraft:{ITEMS[i]}"]', f'gem_{i}_vanilla_model')
        body += s.count(i, [2, 3, 1, 2, 1, 1][i], f'gem_{i}_count')
    body += s.has(6, 'kind:2,reserve_slot:0,card:50,epoch:1', 'reserved_first') + s.has(7, 'kind:2,reserve_slot:1,card:89,epoch:1', 'reserved_second')
    body += s.check(f'items entity {ACTOR} container.6 *[minecraft:item_model="card:splendor/reserved/tier2/sapphire_05"]', 'reserved_private_model_first')
    body += s.check(f'items entity {ACTOR} container.7 *[minecraft:item_model="card:splendor/reserved/tier3/onyx_04"]', 'reserved_private_model_second')
    body += s.has(0, 'kind:1,card:0', 'development_present', True) + s.count(0, 2, 'same_card_stacks', True)
    body += s.has(1, 'kind:1,card:1', 'different_card_separate', True) + s.has(2, 'kind:3,noble:0', 'noble_present', True)
    body += ['data modify storage splendor_inventory_test:run snapshot set from entity ' + TABLE + ' data.splendor'] + s.call('sync')
    body += ['execute store success score #different ce run data modify storage splendor_inventory_test:run snapshot set from entity ' + TABLE + ' data.splendor'] + s.score('#different', 'ce', 0, 'inventory_never_writes_authority')
    body += s.count(0, 2, 'repeat_sync_no_duplicates', True)
    s.case('assets_and_stacking', body)

    body = s.setup() + s.set('p1.tokens', [3, 0, 0, 0, 0, 0]) + s.set('p1.cards', [1]) + s.call('sync')
    body += [f'item replace entity {BAG} container.4 from entity {ACTOR} container.0', f'item replace entity {ACTOR} container.0 with minecraft:air'] + s.call('sync')
    body += s.count(0, 3, 'moved_gem_restored_hotbar') + s.empty(4, 'moved_gem_old_slot_cleared', True)
    body += [f'item replace entity {ACTOR} container.0 with minecraft:air', f'item replace entity {BAG} container.0 with minecraft:air'] + s.call('sync')
    body += s.count(0, 3, 'lost_gem_restored') + s.has(0, 'kind:1,card:1', 'lost_development_restored', True)
    body += s.set('p1.tokens', [0]*6) + s.set('p1.cards', []) + s.call('sync')
    body += s.empty(0, 'paid_gem_removed') + s.empty(0, 'removed_authority_card_removed', True)
    s.case('recovery_and_payment', body)

    body = s.setup() + s.set('p1.tokens', [1, 0, 0, 0, 0, 0]) + [f'item replace entity {ACTOR} container.0 with minecraft:stone 32'] + s.call('sync')
    body += s.count(0, 1, 'gem_uses_hotbar') + s.check(f'items entity {BAG} container.0 minecraft:stone', 'foreign_item_safely_relocated') + s.count(0, 32, 'foreign_stack_unchanged', True)
    body += [f'item replace entity {ACTOR} container.0 with minecraft:dirt 16'] + [f'item replace entity {BAG} container.{i} with minecraft:stone 64' for i in range(27)] + s.set('p1.cards', [89]) + s.call('sync')
    body += s.check(f'items entity {ACTOR} container.0 minecraft:dirt', 'full_inventory_preserves_hotbar_foreign')
    for i in (0, 13, 26):
        body += s.check(f'items entity {BAG} container.{i} minecraft:stone', f'full_inventory_preserves_slot_{i}')
    body += [f'item replace entity {BAG} container.0 with minecraft:air', f'item replace entity {BAG} container.1 with minecraft:air'] + s.call('sync')
    body += s.count(0, 1, 'space_available_recovers_gem') + s.check(f'items entity {BAG} container.0 minecraft:dirt', 'relocated_item_after_full') + s.has(1, 'kind:1,card:89', 'space_available_recovers_card', True)
    s.case('safe_capacity', body)

    body = s.setup() + s.set('p1.reserve', [0, 1, 2]) + s.call('sync')
    body += s.set('epoch', 2) + s.set('p1.reserve', [1, 2]) + s.call('sync')
    body += s.has(6, 'kind:2,card:1,reserve_slot:0,epoch:2', 'reservation_shifts_first') + s.has(7, 'kind:2,card:2,reserve_slot:1,epoch:2', 'reservation_shifts_second')
    body += s.empty(8, 'removed_reserve_slot_cleared')
    body += s.set('p1.tokens', [1, 0, 0, 0, 0, 0], table=202) + s.set('p1.tokens', [4, 0, 0, 0, 0, 0]) + s.call('sync') + s.count(0, 4, 'own_controller_selected')
    body += [f'scoreboard players set {ACTOR} sp_table 202', f'scoreboard players set {ACTOR} ct_id 202'] + s.call('sync') + s.count(0, 1, 'table_switch_replaces_foreign_assets')
    body += s.empty(6, 'old_table_private_card_cleared')
    s.case('reservation_and_table_isolation', body)

    drop = {'table': 101, 'owner': 1, 'kind': 2, 'reserve_slot': 0, 'epoch': 1, 'color': -1}
    body = s.setup() + ['data modify storage splendor_inventory_test:run drop set value ' + json.dumps(drop, separators=(',', ':'))]
    body += [f'execute as {ACTOR} run function splendor:inventory/drop with storage splendor_inventory_test:run drop'] + s.score('#reserve_calls', 'ce', 0, 'death_loss_does_not_buy')
    body += [f'scoreboard players set {ACTOR} sp_idrop 1', f'execute as {ACTOR} run function splendor:inventory/drop with storage splendor_inventory_test:run drop'] + s.score('#reserve_calls', 'ce', 1, 'q_reservation_dispatched') + s.score(ACTOR, 'sp_idrop', 0, 'q_stat_consumed')
    body += [f'scoreboard players set {ACTOR} sp_idrop 1', 'data modify storage splendor_inventory_test:run drop.owner set value 2', f'execute as {ACTOR} run function splendor:inventory/drop with storage splendor_inventory_test:run drop'] + s.score('#reserve_calls', 'ce', 1, 'foreign_owner_no_action')
    body += ['data modify storage splendor_inventory_test:run drop.owner set value 1', 'data modify storage splendor_inventory_test:run drop.kind set value 0', 'data modify storage splendor_inventory_test:run drop.color set value 3', f'execute as {ACTOR} run function splendor:inventory/drop with storage splendor_inventory_test:run drop'] + s.score('#return_calls', 'ce', 1, 'q_gem_return_dispatched')
    body += [f'scoreboard players set {ACTOR} ct_paused 1', f'scoreboard players set {ACTOR} sp_idrop 1', f'execute as {ACTOR} run function splendor:inventory/drop with storage splendor_inventory_test:run drop'] + s.score('#return_calls', 'ce', 1, 'paused_no_action')
    s.case('drop_guards', body)
    body = s.setup() + s.set('p1.tokens', [1, 0, 0, 0, 0, 0]) + s.set('p1.cards', [0]) + s.call('sync')
    body += [f'item replace entity {BAG} container.26 with minecraft:stone 16'] + s.call('clear')
    body += s.empty(0, 'cleanup_removes_gems') + s.empty(0, 'cleanup_removes_development', True) + s.check(f'items entity {BAG} container.26 minecraft:stone', 'cleanup_preserves_foreign_items')
    body += ['summon minecraft:item 8 65 8 {Tags:["si.dropped"],Item:{id:"minecraft:paper",count:1,components:{"minecraft:custom_data":{splendor:{asset:1b,table:101,owner:1,kind:2,reserve_slot:0,epoch:1}}}}}',
             'execute as @e[type=minecraft:item,tag=si.dropped] run function splendor:inventory/item_drop']
    body += ['scoreboard players set #dropped ce 0', 'execute if entity @e[type=minecraft:item,tag=si.dropped] run scoreboard players set #dropped ce 1']
    body += s.score('#dropped', 'ce', 0, 'unowned_drop_removed') + s.score('#reserve_calls', 'ce', 0, 'unowned_death_drop_no_purchase')
    s.case('cleanup_and_unowned_drop', body)
    body = s.setup() + ['data modify storage splendor_inventory_test:run drop set value ' + json.dumps(drop, separators=(',', ':'))]
    body += [f'scoreboard players set {ACTOR} sp_idrop 1'] + s.call('tick') + s.score(ACTOR, 'sp_idrop', 0, 'ordinary_paper_q_stat_expires_this_tick')
    body += ['summon minecraft:armor_stand 8 64 8 {Tags:["si.living","ce.fixture"],Health:20.0f,NoGravity:1b}',
             'execute as @e[type=minecraft:armor_stand,tag=si.living,limit=1] run function catan_engine_test:dead_actor']
    s.case('stale_drop_stat_and_death', body)
    s.file('dead_actor', ['scoreboard players set @s sp_table 101', 'scoreboard players set @s sp_side 1',
                         'scoreboard players set @s ct_paused 0', 'scoreboard players set @s sp_idrop 1',
                         'data merge entity @s {Health:0.0f}',
                         'execute store result score #health ce run data get entity @s Health'] +
           s.score('#health', 'ce', 0, 'living_fixture_is_dead') +
           ['function splendor:inventory/drop with storage splendor_inventory_test:run drop'] +
           s.score('#reserve_calls', 'ce', 0, 'dead_actor_stale_stat_does_not_purchase') +
           ['data modify storage splendor_inventory_test:run drop.kind set value 0',
            'data modify storage splendor_inventory_test:run drop.color set value 1',
            'function splendor:inventory/drop with storage splendor_inventory_test:run drop'] +
           s.score('#return_calls', 'ce', 0, 'dead_actor_stale_stat_does_not_return_gem') +
           ['function splendor:inventory/tick'] +
           s.score('@s', 'sp_idrop', 0, 'dead_actor_tick_expires_stale_stat'))
    s.finish()
    return s


def prepare(target):
    shutil.copytree(PACK / 'data/splendor/function/engine', target / 'data/splendor/function/engine')
    dest = target / 'data/splendor/function/inventory'
    shutil.copytree(PACK / 'data/splendor/function/inventory', dest)
    helper = target / 'data/splendor_inventory_bridge/function'
    helper.mkdir(parents=True)
    clear = ['scoreboard players set #bridge_total ce 0',
             f'$execute unless items entity @s container.* $(match) unless items entity {BAG} container.* $(match) run return 0']
    for entity, slots in (('@s', range(9)), (BAG, range(27))):
        for i in slots:
            clear += [f'$execute if items entity {entity} container.{i} $(match) store result score #bridge_count ce run data get entity {entity} Items[{{Slot:{i}b}}].count',
                      f'$execute if items entity {entity} container.{i} $(match) run scoreboard players operation #bridge_total ce += #bridge_count ce',
                      f'$execute if predicate {{condition:"minecraft:value_check",value:$(remove),range:1}} if items entity {entity} container.{i} $(match) run item replace entity {entity} container.{i} with minecraft:air']
    clear += ['return run scoreboard players get #bridge_total ce']
    (helper / 'clear.mcfunction').write_text('\n'.join(clear) + '\n', encoding='utf-8')
    for path in dest.rglob('*.mcfunction'):
        source = path.read_text(encoding='utf-8')
        source = re.sub(r'clear @s (.+?)( 0)?$', lambda m: 'function splendor_inventory_bridge:clear ' + '{match:' + json.dumps(m[1], ensure_ascii=False) + ',remove:' + ('0' if m[2] else '1') + '}', source, flags=re.M)
        source = re.sub(r'items entity @s inventory\.(\d+)', rf'items entity {BAG} container.\1', source)
        source = re.sub(r'item replace entity @s inventory\.(\d+)', rf'item replace entity {BAG} container.\1', source)
        source = source.replace('hotbar.', 'container.').replace('Inventory[', 'Items[')
        if path.stem == 'relocate':
            source = source.replace('item replace entity @s $(dst)', f'item replace entity {BAG} $(dst)')
        source = source.replace('dst:"inventory.', 'dst:"container.')
        path.write_text(source, encoding='utf-8')
    direct = target / 'data/splendor/function/direct'
    direct.mkdir(parents=True)
    (direct / 'reserved_use.mcfunction').write_text('scoreboard players add #reserve_calls ce 1\n$data modify storage splendor_inventory_test:run reserved set value {slot:$(slot),epoch:$(epoch),table:$(table),owner:$(owner)}\n', encoding='utf-8')
    (direct / 'gem_return.mcfunction').write_text('scoreboard players add #return_calls ce 1\n$data modify storage splendor_inventory_test:run returned set value {color:$(color),table:$(table),owner:$(owner)}\n', encoding='utf-8')
    hud = target / 'data/splendor/function/hud'
    hud.mkdir(parents=True)
    (hud / 'notice.mcfunction').write_text('$data modify storage splendor_inventory_test:run notice set value $(text)\n', encoding='utf-8')
    load = target / 'data/splendor_inventory_bridge/function/load.mcfunction'
    load.write_text('\n'.join(f'scoreboard objectives add {name} dummy' for name in ('ct_id', 'ct_state', 'ct_game', 'ct_paused', 'sp_table', 'sp_side')) + '\nfunction splendor:engine/install\nfunction splendor:inventory/load\n', encoding='utf-8')
    (target / 'data/minecraft/tags/function/load.json').write_text(json.dumps({'values': ['splendor_inventory_bridge:load']}), encoding='utf-8')


if __name__ == '__main__':
    raise SystemExit(run(build_suite(), prepare_target=prepare, prefix='fimel-splendor-inventory-'))
