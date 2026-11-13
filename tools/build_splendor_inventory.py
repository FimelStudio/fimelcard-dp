"""璀璨宝石的可恢复物品镜像；规则状态只从牌桌控制器读取。"""
from pathlib import Path
import json
from build_table_pause_guards import write_guarded

PACK = Path(__file__).resolve().parents[1]
ROOT = PACK / 'data/splendor/function/inventory'
DATA = json.loads((PACK / 'tools/splendor_cards.json').read_text(encoding='utf-8'))
NAMES = ('钻石', '蓝宝石', '祖母绿', '红宝石', '缟玛瑙', '黄金')
ITEMS = ('diamond', 'lapis_lazuli', 'emerald', 'redstone', 'coal', 'gold_ingot')
COLORS = ('aqua', 'blue', 'green', 'red', 'dark_gray', 'gold')


def js(value):
    return json.dumps(value, ensure_ascii=False, separators=(',', ':'))


def put(name, body):
    path = ROOT / (name + '.mcfunction')
    path.parent.mkdir(parents=True, exist_ok=True)
    write_guarded(path, ('\n'.join(body) if isinstance(body, list) else body).strip() + '\n', encoding='utf-8')


def canonical_cards():
    """相同效果和花费共用模型及全部物品组件，不写入实例号或时间戳。"""
    by_signature, canonical, ids = {}, {}, []
    for card in DATA['cards']:
        signature = (card['bonus'], card['points'], tuple(card['cost']))
        first = by_signature.setdefault(signature, card)
        canonical[first['id']] = first
        ids.append(first['id'])
    return canonical, ids


def stack(name, model, metadata, lore, color='white'):
    components = [
        'minecraft:custom_name=' + js(dict(text=name, color=color, italic=False)),
        'minecraft:item_model=' + js(model),
        'minecraft:custom_data={splendor:{asset:1b,table:$(table),owner:$(owner),' + metadata + '}}',
        'minecraft:lore=' + js([dict(text=text, color='gray', italic=False) for text in lore]),
    ]
    return 'minecraft:paper[' + ','.join(components) + ']'


def matcher(metadata=''):
    return '*[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner)' + (',' + metadata if metadata else '') + '}}]'


def build():
    canonical, ids = canonical_cards()
    put('load', ['scoreboard objectives add sp_idrop minecraft.dropped:minecraft.paper',
                 'scoreboard objectives add sp_ifull dummy',
                 'data modify storage splendor:inventory canonical set value ' + js(ids)])
    put('clear', ['clear @s *[minecraft:custom_data~{splendor:{asset:1b}}]',
                  'clear @s *[minecraft:custom_data~{splendor:{gem:1b}}]',
                  'scoreboard players reset @s sp_idrop', 'scoreboard players reset @s sp_ifull'])
    put('tick', ['execute if entity @s[nbt={Health:0.0f}] run scoreboard players set @s sp_idrop 0',
                 'execute if entity @s[nbt={Health:0.0f}] run return 0',
                 'execute if score @s sp_ifull matches 1.. run scoreboard players remove @s sp_ifull 1',
                 'function splendor:inventory/sync',
                 'scoreboard players set @s sp_idrop 0'])
    put('sync', '''
execute unless entity @s[tag=sp.player,tag=ct.player] run return 0
execute if entity @s[nbt={Health:0.0f}] run return 0
execute unless score @s sp_table = @s ct_id run return 0
execute unless score @s sp_side matches 1..4 run return 0
scoreboard players operation #inv_table sp_ctx = @s sp_table
data remove storage splendor:inventory state
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=22,ct_state=1}] if score @s ct_id = #inv_table sp_ctx run data modify storage splendor:inventory state set from entity @s data.splendor
execute unless data storage splendor:inventory state.p1 run return 0
execute store result storage splendor:inventory ctx.table int 1 run scoreboard players get @s sp_table
execute store result storage splendor:inventory ctx.owner int 1 run scoreboard players get @s sp_side
data modify storage splendor:inventory ctx.epoch set from storage splendor:inventory state.epoch
function splendor:inventory/read with storage splendor:inventory ctx
''')
    read = [
        '$data modify storage splendor:inventory player set from storage splendor:inventory state.p$(owner)',
        'scoreboard players set #inv_all sp_ctx 0',
        'execute store result score #inv_all sp_ctx run clear @s *[minecraft:custom_data~{splendor:{asset:1b}}] 0',
        'scoreboard players set #inv_own sp_ctx 0',
        '$execute store result score #inv_own sp_ctx run clear @s ' + matcher() + ' 0',
        'execute unless score #inv_all sp_ctx = #inv_own sp_ctx run clear @s *[minecraft:custom_data~{splendor:{asset:1b}}]',
        'data modify storage splendor:inventory counts set value {}',
        'data modify storage splendor:inventory work set from storage splendor:inventory player.cards',
        'execute if data storage splendor:inventory work[0] run function splendor:inventory/count_card',
    ]
    for color in range(6):
        read += [f'data modify storage splendor:inventory ctx.count set from storage splendor:inventory player.tokens[{color}]',
                 f'function splendor:inventory/gem/{color} with storage splendor:inventory ctx']
    for index in range(3):
        read += [f'execute unless data storage splendor:inventory player.reserve[{index}] run function splendor:inventory/reserve_clear {{slot:{index}}}',
                 f'execute if data storage splendor:inventory player.reserve[{index}] run function splendor:inventory/reserve_prepare {{slot:{index}}}']
    for card in canonical:
        read += [f'execute if data storage splendor:inventory counts.c{card} run function splendor:inventory/card/{card} with storage splendor:inventory ctx']
    read += ['data modify storage splendor:inventory work set from storage splendor:inventory player.nobles',
             'execute if data storage splendor:inventory work[0] run function splendor:inventory/noble_next']
    # A bought/reserved card removed by a successful transaction must disappear, too.
    # Checking each canonical type also removes moved or forged mirrors absent from authority.
    for card in canonical:
        read += [f'$execute unless data storage splendor:inventory counts.c{card} run clear @s ' + matcher(f'kind:1,card:{card}')]
    for noble in DATA['nobles']:
        read += [f'$execute unless data storage splendor:inventory player{{nobles:[{noble["id"]}]}} run clear @s ' + matcher(f'kind:3,noble:{noble["id"]}')]
    put('read', read)
    put('count_card', '''
data modify storage splendor:inventory count.id set from storage splendor:inventory work[0]
data remove storage splendor:inventory work[0]
function splendor:inventory/count_card_id with storage splendor:inventory count
execute if data storage splendor:inventory work[0] run function splendor:inventory/count_card
''')
    put('count_card_id', '''
$data modify storage splendor:inventory count.canonical set from storage splendor:inventory canonical[$(id)]
function splendor:inventory/count_increment with storage splendor:inventory count
''')
    put('count_increment', '''
scoreboard players set #inv_needed sp_ctx 0
$execute store result score #inv_needed sp_ctx run data get storage splendor:inventory counts.c$(canonical)
scoreboard players add #inv_needed sp_ctx 1
$execute store result storage splendor:inventory counts.c$(canonical) int 1 run scoreboard players get #inv_needed sp_ctx
''')
    put('full', '''
execute unless score @s sp_ifull matches 1.. run title @s actionbar {text:"物品栏已满，请腾出空格；你的璀璨宝石资产会自动补回。",color:"yellow"}
scoreboard players set @s sp_ifull 100
return 0
''')
    put('relocate', '''
$item replace entity @s $(dst) from entity @s $(src)
$item replace entity @s $(src) with minecraft:air
return 1
''')
    for hotbar in range(9):
        put(f'free_hotbar/{hotbar}', [f'execute unless items entity @s hotbar.{hotbar} * run return 1',
            f'execute if items entity @s hotbar.{hotbar} *[minecraft:custom_data~{{splendor:{{asset:1b}}}}] run return 1'] +
            [f'execute unless items entity @s inventory.{slot} * run return run function splendor:inventory/relocate {{src:"hotbar.{hotbar}",dst:"inventory.{slot}"}}' for slot in range(27)] +
            ['return run function splendor:inventory/full'])
    # Non-game items are only relocated into an empty slot, never overwritten.
    put('place', [f'$execute unless items entity @s inventory.{slot} * run return run item replace entity @s inventory.{slot} with $(stack) $(count)' for slot in range(27)] +
        ['return run function splendor:inventory/full'])
    for color, (name, model, tint) in enumerate(zip(NAMES, ITEMS, COLORS)):
        tag = f'kind:0,color:{color}'
        match = matcher(tag)
        item = stack(name, 'minecraft:' + model, tag, ['用于购买发展卡；黄金可替代任意颜色。' if color == 5 else '用于购买同色花费的发展卡。', '宝石超过10颗时，按 Q 选择退回这一色。'], tint)
        put(f'gem/{color}', [
            'scoreboard players set #inv_count sp_ctx 0',
            '$execute store result score #inv_count sp_ctx run clear @s ' + match + ' 0',
            'scoreboard players set #inv_slot sp_ctx -1',
            f'$execute if items entity @s hotbar.{color} ' + match + f' store result score #inv_slot sp_ctx run data get entity @s Inventory[{{Slot:{color}b}}].count',
            '$execute if score #inv_count sp_ctx matches $(count) if score #inv_slot sp_ctx matches $(count) run return 1',
            '$clear @s ' + match,
            '$execute if predicate {condition:"minecraft:value_check",value:$(count),range:0} run return 1',
            f'execute store result score #inv_room sp_ctx run function splendor:inventory/free_hotbar/{color}',
            'execute unless score #inv_room sp_ctx matches 1 run return 0',
            f'function splendor:inventory/gem/place_{color} with storage splendor:inventory ctx',
        ])
        # A macro is parsed before any early return executes. Keep count=0 out
        # of the /item command, whose count argument must be at least one.
        put(f'gem/place_{color}', f'$item replace entity @s hotbar.{color} with ' + item + ' $(count)')
    put('reserve_clear', '$clear @s *[minecraft:custom_data~{splendor:{asset:1b,kind:2,reserve_slot:$(slot)}}]')
    put('reserve_prepare', '''
$data modify storage splendor:inventory ctx.id set from storage splendor:inventory player.reserve[$(slot)]
$data modify storage splendor:inventory ctx.reserve_slot set value $(slot)
function splendor:inventory/reserve_resolve with storage splendor:inventory ctx
''')
    put('reserve_resolve', '$function splendor:inventory/reserved/$(id) with storage splendor:inventory ctx')
    for card in DATA['cards']:
        meta = 'kind:2,reserve_slot:$(reserve_slot),epoch:$(epoch),card:' + str(card['id'])
        components = stack(NAMES[card['bonus']] + f'预定卡 · {card["points"]}分', 'card:splendor/reserved/' + canonical[ids[card['id']]]['name'], meta,
                           ['永久折扣：' + NAMES[card['bonus']] + ' +1', '花费：' + ' '.join(NAMES[i] + str(n) for i, n in enumerate(card['cost']) if n), '按 Q 选中，再按 Q 购买；预定牌最多3张。'], 'gold')
        # Slots are fixed for discoverability; the reserved epoch and source id are
        # deliberate here, while permanent development cards omit both.
        put(f'reserved/{card["id"]}', [
            'scoreboard players set #inv_count sp_ctx 0',
            '$execute store result score #inv_count sp_ctx run clear @s ' + matcher(meta) + ' 0',
            'function splendor:inventory/reserve_check with storage splendor:inventory ctx',
            'execute if score #inv_reserved_ok sp_ctx matches 1 run return 1',
            '$clear @s *[minecraft:custom_data~{splendor:{asset:1b,kind:2,reserve_slot:$(reserve_slot)}}]',
            'function splendor:inventory/reserve_free with storage splendor:inventory ctx',
            'execute unless score #inv_room sp_ctx matches 1 run return 0',
            '$data modify storage splendor:inventory ctx.stack set value ' + js(components),
            'function splendor:inventory/reserve_place with storage splendor:inventory ctx',
        ])
    put('reserve_check', [
        'scoreboard players set #inv_reserved_ok sp_ctx 0',
    ] + [f'$execute if predicate {{condition:"minecraft:value_check",value:$(reserve_slot),range:{i}}} if score #inv_count sp_ctx matches 1 if items entity @s hotbar.{6+i} ' + matcher('kind:2,reserve_slot:$(reserve_slot),epoch:$(epoch),card:$(id)') + ' run scoreboard players set #inv_reserved_ok sp_ctx 1' for i in range(3)])
    put('reserve_free', [f'$execute if predicate {{condition:"minecraft:value_check",value:$(reserve_slot),range:{i}}} store result score #inv_room sp_ctx run function splendor:inventory/free_hotbar/{6+i}' for i in range(3)])
    put('reserve_place', [f'$execute if predicate {{condition:"minecraft:value_check",value:$(reserve_slot),range:{i}}} run item replace entity @s hotbar.{6+i} with $(stack)' for i in range(3)])
    for card in canonical.values():
        card_id = card['id']
        item = stack(NAMES[card['bonus']] + f'发展卡 · {card["points"]}分', 'card:splendor/' + card['name'], f'kind:1,card:{card_id}',
                     ['永久折扣：' + NAMES[card['bonus']] + ' +1', '花费：' + ' '.join(NAMES[i] + str(n) for i, n in enumerate(card['cost']) if n), '已购发展卡永久生效，移动或丢出后会自动恢复。'], COLORS[card['bonus']])
        put(f'card/{card_id}', [
            f'execute store result score #inv_needed sp_ctx run data get storage splendor:inventory counts.c{card_id}',
            'scoreboard players set #inv_count sp_ctx 0',
            '$execute store result score #inv_count sp_ctx run clear @s ' + matcher(f'kind:1,card:{card_id}') + ' 0',
            'execute if score #inv_count sp_ctx = #inv_needed sp_ctx run return 1',
            '$clear @s ' + matcher(f'kind:1,card:{card_id}'),
            '$data modify storage splendor:inventory ctx.stack set value ' + js(item),
            'execute store result storage splendor:inventory ctx.count int 1 run scoreboard players get #inv_needed sp_ctx',
            'function splendor:inventory/place with storage splendor:inventory ctx',
        ])
    put('noble_next', '''
data modify storage splendor:inventory ctx.noble set from storage splendor:inventory work[0]
data remove storage splendor:inventory work[0]
function splendor:inventory/noble_resolve with storage splendor:inventory ctx
execute if data storage splendor:inventory work[0] run function splendor:inventory/noble_next
''')
    put('noble_resolve', '$function splendor:inventory/noble/$(noble) with storage splendor:inventory ctx')
    for noble in DATA['nobles']:
        item = stack(f'贵族 · {noble["points"]}分', 'card:splendor/noble/' + noble['name'], f'kind:3,noble:{noble["id"]}',
                     ['到访条件：' + ' '.join(NAMES[i] + str(n) + '张' for i, n in enumerate(noble['cost']) if n), '已获贵族计入声望；物品丢失后会自动恢复。'], 'light_purple')
        put(f'noble/{noble["id"]}', [
            'scoreboard players set #inv_count sp_ctx 0',
            '$execute store result score #inv_count sp_ctx run clear @s ' + matcher(f'kind:3,noble:{noble["id"]}') + ' 0',
            'execute if score #inv_count sp_ctx matches 1 run return 1',
            '$clear @s ' + matcher(f'kind:3,noble:{noble["id"]}'),
            '$data modify storage splendor:inventory ctx.stack set value ' + js(item),
            'data modify storage splendor:inventory ctx.count set value 1',
            'function splendor:inventory/place with storage splendor:inventory ctx',
        ])
    put('item_drop', '''
data modify storage splendor:inventory dropped set value {asset:0b,kind:-1,table:-1,owner:-1,color:-1,epoch:-1,reserve_slot:-1}
data modify storage splendor:inventory dropped merge from entity @s Item.components."minecraft:custom_data".splendor
execute if data storage splendor:inventory dropped{asset:1b} on origin if entity @s[type=minecraft:player,tag=sp.player] run function splendor:inventory/drop with storage splendor:inventory dropped
kill @s
''')
    put('drop', '''
$execute unless score @s sp_table matches $(table) run return 0
$execute unless score @s sp_side matches $(owner) run return 0
execute if entity @s[nbt={Health:0.0f}] run return 0
execute unless score @s sp_idrop matches 1.. run return 0
scoreboard players set @s sp_idrop 0
execute if score @s ct_paused matches 1 run return 0
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:2} run return run function splendor:direct/reserved_use {slot:$(reserve_slot),epoch:$(epoch),table:$(table),owner:$(owner)}
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:0} run return run function splendor:direct/gem_return {color:$(color),table:$(table),owner:$(owner)}
function splendor:hud/notice {text:{text:"已获得的卡牌持续生效，已为你放回物品栏。",color:"yellow"}}
''')
    print('Generated SPLENDOR inventory:', len(list(ROOT.rglob('*.mcfunction'))))


if __name__ == '__main__':
    build()
