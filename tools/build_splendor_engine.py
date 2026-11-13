"""生成22号璀璨宝石的原子NBT规则引擎；不依赖玩家实体或外部进程。"""
from pathlib import Path
from textwrap import dedent
import json
from build_table_pause_guards import write_guarded

PACK = Path(__file__).resolve().parents[1]
ROOT = PACK / 'data/splendor/function/engine'
DATA = json.loads((PACK / 'tools/splendor_cards.json').read_text(encoding='utf-8'))


def js(value):
    return json.dumps(value, ensure_ascii=False, separators=(',', ':'))


def put(name, body):
    path = ROOT / (name + '.mcfunction')
    path.parent.mkdir(parents=True, exist_ok=True)
    if isinstance(body, list):
        body = '\n'.join(body)
    write_guarded(path, '\n'.join(x.strip() for x in dedent(body).strip().splitlines()) + '\n', encoding='utf-8')


def err(code):
    return f'return run function splendor:engine/error {{id:{code}}}'


def reject(condition, code):
    return f'execute {condition} run ' + err(code)


def build():
    assert len(DATA['cards']) == 90 and len(DATA['nobles']) == 10
    assert [sum(c['tier'] == t for c in DATA['cards']) for t in (1, 2, 3)] == [40, 30, 20]
    put('install', ['scoreboard objectives add sp_ctx dummy',
                    'data modify storage splendor:cards cards set value ' + js(DATA['cards']),
                    'data modify storage splendor:cards nobles set value ' + js(DATA['nobles'])])
    put('error', '$scoreboard players set #error sp_ctx $(id)\nscoreboard players set #ok sp_ctx 0\nreturn 0')
    player = dict(tokens=[0]*6, bonus=[0]*5, cards=[], reserve=[], nobles=[], vp=0, token_count=0, card_count=0)
    state = dict(version=1, n=4, phase=1, turn=1, epoch=1, round=1, final_round=0,
                 winners=[], bank=[7]*5+[5], market=[-1]*12, deck1=[], deck2=[], deck3=[], nobles=[-1]*5,
                 eligible=[], discard_due=0,
                 last=dict(code=0, actor=0, target=-1, card=-1, take=[0]*6, pay=[0]*6, noble=-1))
    state.update({'p'+str(p): player.copy() for p in range(1, 5)})
    put('init', [reject('unless score #players sp_ctx matches 2..4', 2),
                 'data modify storage splendor:engine state set value ' + js(state),
                 'execute store result storage splendor:engine state.n int 1 run scoreboard players get #players sp_ctx',
                 'execute if score #players sp_ctx matches 2 run data modify storage splendor:engine state.bank set value [4,4,4,4,4,5]',
                 'execute if score #players sp_ctx matches 3 run data modify storage splendor:engine state.bank set value [5,5,5,5,5,5]',
                 'function splendor:engine/init_decks',
                 'data modify entity @s data.splendor set from storage splendor:engine state',
                 'scoreboard players set #ok sp_ctx 1', 'scoreboard players set #error sp_ctx 0'])
    init_decks = []
    for tier in (1, 2, 3):
        ids = [c['id'] for c in DATA['cards'] if c['tier'] == tier]
        init_decks += ['data modify storage splendor:engine bag set value '+js(ids)]
        for i in range(len(ids)):
            init_decks += [f'function splendor:engine/shuffle {{max:{len(ids)-i-1},tier:{tier}}}']
        for slot in range((tier-1)*4, tier*4):
            init_decks += [f'function splendor:engine/refill {{slot:{slot},tier:{tier}}}']
    init_decks += ['data modify storage splendor:engine bag set value '+js(list(range(10)))]
    for slot in range(5):
        init_decks += [f'execute if score #players sp_ctx matches {max(2,slot)}..4 run function splendor:engine/noble_draw {{max:{9-slot},slot:{slot}}}']
    init_decks += ['data remove storage splendor:engine bag']
    put('init_decks', init_decks)
    put('shuffle', '$execute store result storage splendor:engine draw.pick int 1 run random value 0..$(max)\n$data modify storage splendor:engine draw.tier set value $(tier)\nfunction splendor:engine/shuffle_pick with storage splendor:engine draw')
    put('shuffle_pick', '$data modify storage splendor:engine state.deck$(tier) append from storage splendor:engine bag[$(pick)]\n$data remove storage splendor:engine bag[$(pick)]')
    put('noble_draw', '$execute store result storage splendor:engine draw.pick int 1 run random value 0..$(max)\n$data modify storage splendor:engine draw.slot set value $(slot)\nfunction splendor:engine/noble_pick with storage splendor:engine draw')
    put('noble_pick', '$data modify storage splendor:engine state.nobles[$(slot)] set from storage splendor:engine bag[$(pick)]\n$data remove storage splendor:engine bag[$(pick)]')
    put('refill', '$data modify storage splendor:engine state.market[$(slot)] set value -1\n$execute unless data storage splendor:engine state.deck$(tier)[0] run return 0\n$data modify storage splendor:engine state.market[$(slot)] set from storage splendor:engine state.deck$(tier)[0]\n$data remove storage splendor:engine state.deck$(tier)[0]')
    put('context', 'data modify storage splendor:engine state set from entity @s data.splendor\nfunction splendor:engine/cache')
    put('cache', [f'execute store result score #{k} sp_ctx run data get storage splendor:engine state.{k}' for k in ('n','phase','turn','epoch','round','final_round')] +
        [f'execute store result score #bank{k} sp_ctx run data get storage splendor:engine state.bank[{k}]' for k in range(6)])
    put('load_actor', [f'$execute store result score #token{k} sp_ctx run data get storage splendor:engine state.p$(actor).tokens[{k}]' for k in range(6)] +
        [f'$execute store result score #bonus{k} sp_ctx run data get storage splendor:engine state.p$(actor).bonus[{k}]' for k in range(5)] +
        ['$execute store result score #vp sp_ctx run data get storage splendor:engine state.p$(actor).vp',
         '$execute store result score #reserved sp_ctx run data get storage splendor:engine state.p$(actor).reserve',
         '$execute store result score #bought sp_ctx run data get storage splendor:engine state.p$(actor).cards'])
    put('save_actor', [f'$execute store result storage splendor:engine state.p$(actor).tokens[{k}] int 1 run scoreboard players get #token{k} sp_ctx' for k in range(6)] +
        [f'$execute store result storage splendor:engine state.p$(actor).bonus[{k}] int 1 run scoreboard players get #bonus{k} sp_ctx' for k in range(5)] +
        ['$execute store result storage splendor:engine state.p$(actor).vp int 1 run scoreboard players get #vp sp_ctx'])
    put('save_bank', [f'execute store result storage splendor:engine state.bank[{k}] int 1 run scoreboard players get #bank{k} sp_ctx' for k in range(6)])
    action = ['scoreboard players set #ok sp_ctx 0', 'scoreboard players set #error sp_ctx 1',
              reject('if score @s ct_paused matches 1', 13),
              reject('unless data entity @s data.splendor{version:1}', 1),
              'function splendor:engine/context',
              'data modify storage splendor:engine request set value {actor:0,code:0,target:-1,epoch:-1,take:[0,0,0,0,0,0],pay:[0,0,0,0,0,0]}',
              'data modify storage splendor:engine request merge from storage splendor:action input',
              'data modify storage splendor:engine normalized set from storage splendor:engine request']
    for k in ('actor','code','target','epoch'):
        h = 'given_epoch' if k == 'epoch' else k
        action += [f'scoreboard players set #{h} sp_ctx -999', f'execute store result score #{h} sp_ctx run data get storage splendor:engine request.{k}',
                   f'execute store result storage splendor:engine normalized.{k} int 1 run scoreboard players get #{h} sp_ctx']
    for arr in ('take','pay'):
        action += [f'execute store result score #length sp_ctx run data get storage splendor:engine request.{arr}', reject('unless score #length sp_ctx matches 6', 10)]
        for k in range(6):
            action += [f'scoreboard players set #{arr}{k} sp_ctx -999',
                       f'execute store result score #{arr}{k} sp_ctx run data get storage splendor:engine request.{arr}[{k}]',
                       reject(f'unless score #{arr}{k} sp_ctx matches 0..10', 10),
                       f'execute store result storage splendor:engine normalized.{arr}[{k}] int 1 run scoreboard players get #{arr}{k} sp_ctx']
    action += ['execute store success score #different sp_ctx run data modify storage splendor:engine normalized set from storage splendor:engine request',
               reject('if score #different sp_ctx matches 1', 10),
               reject('unless score #actor sp_ctx matches 1..4', 2), reject('if score #actor sp_ctx > #n sp_ctx', 2),
               reject('unless score #given_epoch sp_ctx = #epoch sp_ctx', 3), reject('unless score #actor sp_ctx = #turn sp_ctx', 4),
               reject('if score #phase sp_ctx matches 4', 5),
               'function splendor:engine/load_actor with storage splendor:engine request',
               'data modify storage splendor:engine state.last set value {code:0,actor:0,target:-1,card:-1,take:[0,0,0,0,0,0],pay:[0,0,0,0,0,0],noble:-1}',
               'data modify storage splendor:engine state.last.code set from storage splendor:engine request.code',
               'data modify storage splendor:engine state.last.actor set from storage splendor:engine request.actor',
               'data modify storage splendor:engine state.last.target set from storage splendor:engine request.target',
               'function splendor:engine/dispatch', 'execute unless score #ok sp_ctx matches 1 run return 0',
               'function splendor:engine/commit', 'return 1']
    put('action', action)
    put('dispatch', [f'execute if score #code sp_ctx matches {c} run return run function splendor:engine/{p}' for c,p in ((1,'take'),(2,'reserve'),(3,'buy'),(4,'discard'),(5,'noble/select'))]+[err(9)])
    put('commit', ['function splendor:engine/stats', 'scoreboard players add #epoch sp_ctx 1',
                   'execute store result storage splendor:engine state.epoch int 1 run scoreboard players get #epoch sp_ctx',
                   'data modify entity @s data.splendor set from storage splendor:engine state',
                   'scoreboard players set #error sp_ctx 0', 'scoreboard players set #ok sp_ctx 1'])
    build_take()
    build_cards()
    build_turn()
    print('Generated SPLENDOR rules:', len(list(ROOT.rglob('*.mcfunction'))))


def build_take():
    body = [reject('unless score #phase sp_ctx matches 1', 5), 'scoreboard players set #total sp_ctx 0', 'scoreboard players set #same sp_ctx 0', 'scoreboard players set #available sp_ctx 0', reject('unless score #take5 sp_ctx matches 0', 6)]
    for k in range(5):
        body += [reject(f'unless score #take{k} sp_ctx matches 0..2', 6), reject(f'if score #take{k} sp_ctx > #bank{k} sp_ctx', 6),
                 f'scoreboard players operation #total sp_ctx += #take{k} sp_ctx',
                 f'execute if score #bank{k} sp_ctx matches 1.. run scoreboard players add #available sp_ctx 1',
                 f'execute if score #take{k} sp_ctx matches 2 run scoreboard players add #same sp_ctx 1',
                 reject(f'if score #take{k} sp_ctx matches 2 unless score #bank{k} sp_ctx matches 4..', 6)]
    body += [reject('unless score #total sp_ctx matches 1..3', 6), reject('if score #same sp_ctx matches 1.. unless score #total sp_ctx matches 2', 6)]
    body += ['execute if score #available sp_ctx matches 4.. run scoreboard players set #available sp_ctx 3', reject('if score #same sp_ctx matches 0 unless score #total sp_ctx = #available sp_ctx', 6)]
    for k in range(6):
        body += [f'scoreboard players operation #token{k} sp_ctx += #take{k} sp_ctx', f'scoreboard players operation #bank{k} sp_ctx -= #take{k} sp_ctx']
    body += ['data modify storage splendor:engine state.last.take set from storage splendor:engine request.take',
             'function splendor:engine/save_actor with storage splendor:engine request', 'function splendor:engine/save_bank',
             'function splendor:engine/after_action', 'scoreboard players set #ok sp_ctx 1']
    put('take', body)
    body = [reject('unless score #phase sp_ctx matches 2', 5), 'scoreboard players set #total sp_ctx 0', 'scoreboard players set #held sp_ctx 0']
    for k in range(6):
        body += [reject(f'if score #take{k} sp_ctx > #token{k} sp_ctx', 7), f'scoreboard players operation #total sp_ctx += #take{k} sp_ctx', f'scoreboard players operation #held sp_ctx += #token{k} sp_ctx']
    body += ['scoreboard players remove #held sp_ctx 10', reject('unless score #total sp_ctx = #held sp_ctx', 7)]
    for k in range(6):
        body += [f'scoreboard players operation #token{k} sp_ctx -= #take{k} sp_ctx', f'scoreboard players operation #bank{k} sp_ctx += #take{k} sp_ctx']
    body += ['data modify storage splendor:engine state.last.take set from storage splendor:engine request.take',
             'function splendor:engine/save_actor with storage splendor:engine request', 'function splendor:engine/save_bank',
             'data modify storage splendor:engine state.discard_due set value 0',
             'function splendor:engine/noble/check', 'scoreboard players set #ok sp_ctx 1']
    put('discard', body)


def build_cards():
    # All paths/macros below are derived from checked numeric target/card IDs.
    put('resolve', ['scoreboard players set #card sp_ctx -1', 'scoreboard players set #tier sp_ctx 1', 'scoreboard players set #index sp_ctx -1',
                    reject('unless score #target sp_ctx matches 0..14', 8),
                    'execute if score #target sp_ctx matches 0..11 run function splendor:engine/resolve_market with storage splendor:engine request',
                    'execute if score #target sp_ctx matches 12..14 run function splendor:engine/resolve_reserved',
                    reject('unless score #card sp_ctx matches 0..89', 8),
                    'execute store result storage splendor:engine meta.card int 1 run scoreboard players get #card sp_ctx',
                    'function splendor:engine/load_card with storage splendor:engine meta',
                    'scoreboard players set #valid sp_ctx 1'])
    put('resolve_market', '$execute store result score #card sp_ctx run data get storage splendor:engine state.market[$(target)]')
    put('resolve_reserved', ['scoreboard players operation #index sp_ctx = #target sp_ctx', 'scoreboard players remove #index sp_ctx 12',
                             'execute store result storage splendor:engine request.index int 1 run scoreboard players get #index sp_ctx',
                             'execute if score #code sp_ctx matches 2 run function splendor:engine/resolve_blind',
                             'execute if score #code sp_ctx matches 3 run function splendor:engine/resolve_reserve_card with storage splendor:engine request'])
    put('resolve_blind', ['scoreboard players operation #tier sp_ctx = #index sp_ctx', 'scoreboard players add #tier sp_ctx 1',
                          'execute store result storage splendor:engine request.tier int 1 run scoreboard players get #tier sp_ctx',
                          'function splendor:engine/resolve_deck with storage splendor:engine request'])
    put('resolve_deck', '$execute if data storage splendor:engine state.deck$(tier)[0] store result score #card sp_ctx run data get storage splendor:engine state.deck$(tier)[0]')
    put('resolve_reserve_card', '$execute if data storage splendor:engine state.p$(actor).reserve[$(index)] store result score #card sp_ctx run data get storage splendor:engine state.p$(actor).reserve[$(index)]')
    put('load_card', ['$execute store result score #tier sp_ctx run data get storage splendor:cards cards[$(card)].tier',
                      '$execute store result score #bonus sp_ctx run data get storage splendor:cards cards[$(card)].bonus',
                      '$execute store result score #points sp_ctx run data get storage splendor:cards cards[$(card)].points']+
        [f'$execute store result score #cost{k} sp_ctx run data get storage splendor:cards cards[$(card)].cost[{k}]' for k in range(5)])
    put('remove_card', ['execute store result storage splendor:engine request.tier int 1 run scoreboard players get #tier sp_ctx',
                        'execute if score #target sp_ctx matches 0..11 run function splendor:engine/remove_market with storage splendor:engine request',
                        'execute if score #target sp_ctx matches 12..14 if score #code sp_ctx matches 2 run function splendor:engine/remove_blind with storage splendor:engine request',
                        'execute if score #target sp_ctx matches 12..14 if score #code sp_ctx matches 3 run function splendor:engine/remove_reserve with storage splendor:engine request',
                        'execute store result storage splendor:engine state.last.card int 1 run scoreboard players get #card sp_ctx'])
    put('remove_market', '$function splendor:engine/refill {slot:$(target),tier:$(tier)}')
    put('remove_blind', '$data remove storage splendor:engine state.deck$(tier)[0]')
    put('remove_reserve', '$data remove storage splendor:engine state.p$(actor).reserve[$(index)]')
    put('reserve', [reject('unless score #phase sp_ctx matches 1', 5), reject('if score #reserved sp_ctx matches 3..', 11),
                    'scoreboard players set #valid sp_ctx 0', 'function splendor:engine/resolve', 'execute unless score #valid sp_ctx matches 1 run return 0',
                    'execute store result storage splendor:engine request.card int 1 run scoreboard players get #card sp_ctx',
                    'function splendor:engine/append_reserve with storage splendor:engine request', 'function splendor:engine/remove_card',
                    'execute if score #bank5 sp_ctx matches 1.. run scoreboard players add #token5 sp_ctx 1',
                    'execute if score #bank5 sp_ctx matches 1.. run data modify storage splendor:engine state.last.take[5] set value 1',
                    'execute if score #bank5 sp_ctx matches 1.. run scoreboard players remove #bank5 sp_ctx 1',
                    'function splendor:engine/save_actor with storage splendor:engine request', 'function splendor:engine/save_bank',
                    'function splendor:engine/after_action', 'scoreboard players set #ok sp_ctx 1'])
    put('append_reserve', '$data modify storage splendor:engine state.p$(actor).reserve append value $(card)')
    body = [reject('unless score #phase sp_ctx matches 1', 5), 'scoreboard players set #valid sp_ctx 0',
            'function splendor:engine/resolve', 'execute unless score #valid sp_ctx matches 1 run return 0', 'scoreboard players set #gold_needed sp_ctx 0']
    for k in range(5):
        body += [f'scoreboard players operation #cost{k} sp_ctx -= #bonus{k} sp_ctx',
                 f'execute if score #cost{k} sp_ctx matches ..-1 run scoreboard players set #cost{k} sp_ctx 0',
                 reject(f'if score #pay{k} sp_ctx > #cost{k} sp_ctx', 12),
                 reject(f'if score #pay{k} sp_ctx > #token{k} sp_ctx', 12),
                 f'scoreboard players operation #cost{k} sp_ctx -= #pay{k} sp_ctx',
                 f'scoreboard players operation #gold_needed sp_ctx += #cost{k} sp_ctx']
    body += [reject('unless score #gold_needed sp_ctx = #pay5 sp_ctx', 12), reject('if score #pay5 sp_ctx > #token5 sp_ctx', 12)]
    for k in range(6):
        body += [f'scoreboard players operation #token{k} sp_ctx -= #pay{k} sp_ctx', f'scoreboard players operation #bank{k} sp_ctx += #pay{k} sp_ctx']
    body += [f'execute if score #bonus sp_ctx matches {k} run scoreboard players add #bonus{k} sp_ctx 1' for k in range(5)]
    body += ['scoreboard players operation #vp sp_ctx += #points sp_ctx',
             'execute store result storage splendor:engine request.card int 1 run scoreboard players get #card sp_ctx',
             'function splendor:engine/append_bought with storage splendor:engine request', 'function splendor:engine/remove_card',
             'data modify storage splendor:engine state.last.pay set from storage splendor:engine request.pay',
             'function splendor:engine/save_actor with storage splendor:engine request', 'function splendor:engine/save_bank',
             'function splendor:engine/after_action', 'scoreboard players set #ok sp_ctx 1']
    put('buy', body)
    put('append_bought', '$data modify storage splendor:engine state.p$(actor).cards append value $(card)')


def build_turn():
    put('after_action', ['scoreboard players set #held sp_ctx 0'] +
        [f'scoreboard players operation #held sp_ctx += #token{k} sp_ctx' for k in range(6)] +
        ['execute if score #held sp_ctx matches 11.. run data modify storage splendor:engine state.phase set value 2',
         'execute if score #held sp_ctx matches 11.. run scoreboard players remove #held sp_ctx 10',
         'execute if data storage splendor:engine state{phase:2} store result storage splendor:engine state.discard_due int 1 run scoreboard players get #held sp_ctx',
         'execute if data storage splendor:engine state{phase:2} run return 1', 'function splendor:engine/noble/check'])
    put('noble/check', ['data modify storage splendor:engine state.eligible set value []'] +
        [f'function splendor:engine/noble/check_slot {{slot:{s}}}' for s in range(5)] +
        ['execute store result score #eligible sp_ctx run data get storage splendor:engine state.eligible',
         'execute if score #eligible sp_ctx matches 2.. run data modify storage splendor:engine state.phase set value 3',
         'execute if score #eligible sp_ctx matches 2.. run return 1',
         'execute if score #eligible sp_ctx matches 1 store result storage splendor:engine request.noble_slot int 1 run data get storage splendor:engine state.eligible[0]',
         'execute if score #eligible sp_ctx matches 1 run function splendor:engine/noble/award with storage splendor:engine request',
         'function splendor:engine/advance'])
    put('noble/check_slot', ['$execute store result score #noble sp_ctx run data get storage splendor:engine state.nobles[$(slot)]',
                             'execute unless score #noble sp_ctx matches 0..9 run return 0',
                             'execute store result storage splendor:engine noble.id int 1 run scoreboard players get #noble sp_ctx',
                             '$data modify storage splendor:engine noble.slot set value $(slot)',
                             'function splendor:engine/noble/check_cost with storage splendor:engine noble'])
    put('noble/check_cost', [f'$execute store result score #need sp_ctx run data get storage splendor:cards nobles[$(id)].cost[{k}]\nexecute if score #bonus{k} sp_ctx < #need sp_ctx run return 0' for k in range(5)] +
        ['$data modify storage splendor:engine state.eligible append value $(slot)'])
    put('noble/select', [reject('unless score #phase sp_ctx matches 3', 5), reject('unless score #target sp_ctx matches 0..4', 8),
                        'scoreboard players set #valid sp_ctx 0'] +
        ['function splendor:engine/noble/select_check with storage splendor:engine request', reject('unless score #valid sp_ctx matches 1', 14),
         'data modify storage splendor:engine request.noble_slot set from storage splendor:engine request.target',
         'function splendor:engine/noble/award with storage splendor:engine request', 'function splendor:engine/advance', 'scoreboard players set #ok sp_ctx 1'])
    put('noble/select_check', '$execute if data storage splendor:engine state.eligible[] run function splendor:engine/noble/select_scan {slot:$(target)}')
    # NBT list matching checks membership rather than using the submitted slot as a list index.
    put('noble/select_scan', '$execute if data storage splendor:engine state{eligible:[$(slot)]} run scoreboard players set #valid sp_ctx 1')
    put('noble/award', ['$data modify storage splendor:engine state.p$(actor).nobles append from storage splendor:engine state.nobles[$(noble_slot)]',
                        '$data modify storage splendor:engine state.last.noble set from storage splendor:engine state.nobles[$(noble_slot)]',
                        '$data modify storage splendor:engine state.nobles[$(noble_slot)] set value -1',
                        'scoreboard players add #vp sp_ctx 3', 'function splendor:engine/save_actor with storage splendor:engine request',
                        'data modify storage splendor:engine state.eligible set value []'])
    put('advance', ['execute if score #vp sp_ctx matches 15.. run scoreboard players set #final_round sp_ctx 1',
                    'execute store result storage splendor:engine state.final_round int 1 run scoreboard players get #final_round sp_ctx',
                    'data modify storage splendor:engine state.phase set value 1',
                    'data modify storage splendor:engine state.eligible set value []',
                    'execute if score #final_round sp_ctx matches 1 if score #turn sp_ctx = #n sp_ctx run return run function splendor:engine/finish',
                    'scoreboard players add #turn sp_ctx 1',
                    'execute if score #turn sp_ctx > #n sp_ctx run scoreboard players add #round sp_ctx 1',
                    'execute if score #turn sp_ctx > #n sp_ctx run scoreboard players set #turn sp_ctx 1',
                    'execute store result storage splendor:engine state.turn int 1 run scoreboard players get #turn sp_ctx',
                    'execute store result storage splendor:engine state.round int 1 run scoreboard players get #round sp_ctx'])
    put('stats', [f'function splendor:engine/stats_player {{actor:{p}}}' for p in range(1, 5)])
    put('stats_player', ['scoreboard players set #held sp_ctx 0'] +
        [f'$execute store result score #part sp_ctx run data get storage splendor:engine state.p$(actor).tokens[{k}]\nscoreboard players operation #held sp_ctx += #part sp_ctx' for k in range(6)] +
        ['$execute store result storage splendor:engine state.p$(actor).token_count int 1 run scoreboard players get #held sp_ctx',
         '$execute store result storage splendor:engine state.p$(actor).card_count int 1 run data get storage splendor:engine state.p$(actor).cards'])
    put('finish', ['data modify storage splendor:engine state.phase set value 4',
                   'data modify storage splendor:engine state.winners set value []', 'scoreboard players set #best_vp sp_ctx -1', 'scoreboard players set #best_cards sp_ctx 999'] +
        [f'execute if score #n sp_ctx matches {p}..4 run function splendor:engine/winner {{actor:{p}}}' for p in range(1, 5)])
    put('winner', ['$execute store result score #pv sp_ctx run data get storage splendor:engine state.p$(actor).vp',
                   '$execute store result score #pc sp_ctx run data get storage splendor:engine state.p$(actor).cards',
                   'execute if score #pv sp_ctx < #best_vp sp_ctx run return 0',
                   'execute if score #pv sp_ctx = #best_vp sp_ctx if score #pc sp_ctx > #best_cards sp_ctx run return 0',
                   'execute if score #pv sp_ctx > #best_vp sp_ctx run data modify storage splendor:engine state.winners set value []',
                   'execute if score #pv sp_ctx = #best_vp sp_ctx if score #pc sp_ctx < #best_cards sp_ctx run data modify storage splendor:engine state.winners set value []',
                   'scoreboard players operation #best_vp sp_ctx = #pv sp_ctx', 'scoreboard players operation #best_cards sp_ctx = #pc sp_ctx',
                   '$data modify storage splendor:engine state.winners append value $(actor)'])


if __name__ == '__main__':
    build()
