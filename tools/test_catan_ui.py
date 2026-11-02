"""Vanilla Dialog codec and CATAN private UI/session boundaries (fixture clients).

Runs audio/settings cases as well. Game/action is observed at its call boundary;
rule legality is tested by test_catan_engine.py, not replaced by UI expectations.
"""
from pathlib import Path
import json
import re
import shutil
import sys
import hashlib
import tempfile
from PIL import Image
import build_catan_ui as ui
import build_catan_font as font
import test_catan_sound as sound_test
from test_catan_sound import listener, TABLE, OTHER
from catan_topology import PORTS, PORT_RESOURCES
import test_love_letter_engine as base


def font_checks():
    rp = font.RP
    definition = json.loads((rp / 'assets/card/font/catan.json').read_text(encoding='utf-8'))
    manifest = json.loads((rp / '.source/catan/font/manifest.json').read_text(encoding='utf-8'))
    glyphs = []
    checked = 0
    for provider in definition['providers']:
        namespace, path = provider['file'].split(':')
        image = Image.open(rp / 'assets' / namespace / 'textures' / path)
        rows = provider['chars']
        width, height = len(rows[0]), len(rows)
        assert len({len(row) for row in rows}) == 1
        assert image.width % width == image.height % height == 0
        assert 0 < image.width / width <= 256 and 0 < image.height / height <= 256
        assert image.mode == 'RGBA' and image.getchannel('A').getbbox()
        assert provider['height'] == 14 and provider['ascent'] == 12
        glyphs += [char for row in rows for char in row]
        checked += 5
    assert glyphs == font.RESOURCE_GLYPHS + font.DEVELOPMENT_GLYPHS
    assert len(glyphs) == len(set(glyphs)) == 10
    for name, record in manifest['resources'].items():
        assert hashlib.sha256((rp / record['source']).read_bytes()).hexdigest() == record['sha256']
        checked += 1
    with tempfile.TemporaryDirectory(prefix='fimel-catan-font-') as directory:
        target = Path(directory)
        shutil.copytree(rp / 'assets/card/textures/item/catan/resource', target / 'assets/card/textures/item/catan/resource')
        font.build(target)
        for path in (target / 'assets').rglob('*'):
            if path.is_file():
                assert path.read_bytes() == (rp / path.relative_to(target)).read_bytes(), path
                checked += 1
    # Resource font applies only to the picture component; Chinese text keeps the default font.
    for path in (base.PACK / 'data/catan/function/ui').glob('*.mcfunction'):
        source = path.read_text(encoding='utf-8')
        if 'font:"card:catan"' in source:
            assert 'text:"$(icon)",font:"card:catan",color:"white"' in source
        checked += 1
    print(f'Catan Dialog font/source: {checked} checks passed', flush=True)


class Suite(sound_test.Suite):
    def setup_ui(self, phase=4, actor=1, turn=1, table=101):
        c = self.setup()
        state = {'n': 4, 'epoch': 7, 'phase': phase, 'turn': turn, 'bank': [19] * 5,
            'vertex_owner': [0] * 54, 'vertex_level': [0] * 54, 'port_types': PORT_RESOURCES,
            'eligible': [2, 4]}
        for p, name in enumerate(('Alice', 'Bob', 'Cara', 'Dan'), 1):
            state['p' + str(p)] = {'name': {'text': name}, 'resources': [p + i for i in range(5)],
                'vp': p + 1, 'public_vp': p, 'resource_count': 5 * p + 10, 'dev_count': 4,
                'dev': [1, 2, 3, 4, 1], 'fresh': [2, 1, 0, 1, 1],
                'roads_left': 15, 'settlements_left': 5, 'cities_left': 4, 'discard_due': 4 if phase == 5 else 0}
        for controller in (TABLE, OTHER):
            c += [f'data modify entity {controller} data.catan set value ' + json.dumps(state, separators=(',', ':')),
                f'tag {controller} add ca.controller', f'scoreboard players set {controller} ca_turn {turn}',
                f'scoreboard players set {controller} ca_anim 0', f'scoreboard players set {controller} ca_state {phase}']
        c += ['scoreboard players set #ui_load ca_ctx 1', 'scoreboard players set #panel_serial ca_ctx 1',
            'scoreboard players set #factor ca_ctx 10000', 'scoreboard players set #submitted lt 0']
        c += ['execute as @e[tag=cs.listener] run function catan:ui/init',
            f'execute as {listener(actor,table)} at @s run function catan:input/context']
        return c

    def player_call(self, function, actor=1, table=101):
        return [f'execute as {listener(actor,table)} at @s run function catan:{function}']

    def click(self, code, actor=1, table=101):
        return [f'scoreboard players operation {listener(actor,table)} ca_action = {listener(actor,table)} ca_nonce',
            f'scoreboard players operation {listener(actor,table)} ca_action *= #tenk lt',
            f'scoreboard players add {listener(actor,table)} ca_action {code}'] + self.player_call('ui/handle', actor, table)

    def storage(self, path, expected, name):
        return ['data modify storage love_letter_test:run cmp set value ' + json.dumps(expected, ensure_ascii=False, separators=(',', ':')),
            f'execute store success score #present lt run data get storage catan:ui {path}',
            f'execute store success score #different lt run data modify storage love_letter_test:run cmp set from storage catan:ui {path}',
            'execute unless score #present lt matches 1 run scoreboard players set #different lt 1'] + self.score('#different', 'lt', 0, name)

    def build(self):
        super().build()
        previous = self.cases[-1]
        first = 'ui_phase_1'
        self.files['case/' + previous] = self.files['case/' + previous].replace('schedule function love_letter_test:finish 1t', 'schedule function love_letter_test:case/' + first + ' 1t')
        original_count = len(self.cases)
        for phase, buttons in ((1, 3), (2, 3), (3, 4), (4, 10), (5, 3), (6, 3), (7, 4), (8, 4), (10, 2), (11, 2)):
            c = self.setup_ui(phase) + self.player_call('ui/open')
            c += self.score('#dialog', 'lt', 1, f'ui_phase_{phase}_codec')
            c += self.storage('turn_name', {'text': 'Alice'}, f'ui_phase_{phase}_static_turn_name')
            c += ['execute store result score #buttons lt run data get storage catan:ui buttons'] + self.score('#buttons', 'lt', buttons, f'ui_phase_{phase}_actions')
            self.case('ui_phase_' + str(phase), c)
        c = self.setup_ui(actor=2) + self.player_call('ui/open', 2)
        c += ['execute store result score #buttons lt run data get storage catan:ui buttons'] + self.score('#buttons', 'lt', 3, 'offturn_can_offer_trade')
        c += self.player_call('ui/partners', 2) + ['execute store result score #buttons lt run data get storage catan:ui buttons']
        c += self.score('#buttons', 'lt', 1, 'offturn_partner_only_current_actor') + self.storage('buttons[0].label', {'text': 'Alice'}, 'partner_static_name')
        self.case('ui_offturn_trade', c)
        c = self.setup_ui() + self.player_call('ui/partners')
        c += ['execute store result score #buttons lt run data get storage catan:ui buttons'] + self.score('#buttons', 'lt', 3, 'turn_actor_all_other_partners')
        c += self.storage('buttons[0].label', {'text': 'Bob'}, 'turn_actor_first_partner_name')
        self.case('ui_partners', c)
        c = self.setup_ui() + self.player_call('ui/development')
        c += self.score('#dialog', 'lt', 1, 'development_page_codec')
        c += self.storage('columns', 2, 'development_two_columns')
        c += self.storage('buttons[0].label.extra[0]', {'text': font.DEVELOPMENT_GLYPHS[0], 'font': font.FONT_ID, 'color': 'white'}, 'development_knight_picture_font')
        for i in range(5):
            c += self.storage(f'private.extra[{1+2*i}]', {'text': font.RESOURCE_GLYPHS[i], 'font': font.FONT_ID, 'color': 'white'}, f'own_resource_picture_{i}')
        for i in range(5):
            c += self.storage('old' + str(i), [1, 2, 3, 4, 1][i], f'own_old_dev_{i}') + self.storage('new' + str(i), [2, 1, 0, 1, 1][i], f'own_new_dev_{i}')
        self.case('ui_development', c)
        for edit in range(1, 6):
            c = self.setup_ui(phase=5 if edit == 1 else 4) + [f'scoreboard players set {listener()} ca_edit {edit}'] + self.player_call('ui/editor')
            c += self.score('#dialog', 'lt', 1, f'editor_{edit}_codec') + self.check('data storage catan:ui note.text', f'editor_{edit}_has_summary')
            c += self.storage('columns', 4 if edit == 2 else 2, f'editor_{edit}_columns')
            c += self.storage('buttons[0].width', 110 if edit == 2 else 145, f'editor_{edit}_button_width')
            c += self.storage('buttons[0].label.extra[0].font', font.FONT_ID, f'editor_{edit}_resource_font')
            self.case('ui_editor_' + str(edit), c)
        c = self.setup_ui()
        for port in (PORTS[0], PORTS[5]):
            c += [f'data modify entity {TABLE} data.catan.vertex_owner[{port["vertices"][0]}] set value 1']
        c += self.player_call('ui/bank')
        for i in range(5):
            c += self.storage('ratio' + str(i), 2 if i == 0 else 3, f'port_ratio_{i}') + self.storage('bank' + str(i), 19, f'bank_visible_{i}')
        c += self.player_call('ui/open', 2) + self.player_call('ui/bank', 2)
        for i in range(5):c += self.storage('ratio' + str(i), 4, f'port_other_player_ratio_{i}')
        self.case('ui_port_ratios', c)
        c = self.setup_ui() + self.player_call('ui/discard') + self.click(1010)
        c += self.score(listener(), 'ca_g0', 0, 'editor_subtract_clamps_zero') + self.score('#dialog', 'lt', 2, 'editor_subtract_reopens')
        c += self.click(1000) + self.score(listener(), 'ca_g0', 1, 'editor_increment_works')
        c += self.click(1020) + self.score(listener(), 'ca_w0', 0, 'discard_cannot_edit_trade_request')
        self.case('ui_editor_clicks', c)
        trade = {'id': 8, 'from': 1, 'to': 2, 'offer': [1, 0, 0, 0, 0], 'want': [0, 1, 0, 0, 0]}
        for actor, buttons in ((1, 1), (2, 2)):
            c = self.setup_ui(actor=actor) + [f'data modify entity {TABLE} data.catan.trade set value ' + json.dumps(trade)] + self.player_call('ui/trade_response', actor)
            c += self.score('#dialog', 'lt', 1, f'trade_{actor}_codec') + self.score(listener(actor), 'ca_trade_id', 8, f'trade_{actor}_bound_id')
            c += ['execute store result score #buttons lt run data get storage catan:ui buttons'] + self.score('#buttons', 'lt', buttons, f'trade_{actor}_buttons')
            c += self.storage('trade.from_name', {'text': 'Alice'}, f'trade_{actor}_static_sender') + self.storage('trade.to_name', {'text': 'Bob'}, f'trade_{actor}_static_receiver')
            self.case('ui_trade_' + str(actor), c)
        c = self.setup_ui(actor=3) + [f'data modify entity {TABLE} data.catan.trade set value ' + json.dumps(trade)] + self.player_call('ui/trade_response', 3)
        c += self.score(listener(3), 'ca_panel', 0, 'third_party_not_response_panel') + self.storage('note', {'text': '', 'color': 'aqua'}, 'third_party_no_price')
        self.case('ui_trade_privacy', c)
        c = self.setup_ui(actor=2) + [f'data modify entity {TABLE} data.catan.trade set value ' + json.dumps(trade)] + self.player_call('ui/trade_response', 2)
        c += [f'data modify entity {TABLE} data.catan.trade.id set value 9'] + self.click(360, 2)
        c += self.score('#submitted', 'lt', 1, 'trade_accept_submitted_once') + self.data(TABLE, 'data.test_action.target', 8, 'accept_uses_displayed_trade_id')
        self.case('ui_trade_bound_quote', c)
        c = self.setup_ui(actor=2) + [f'data modify entity {TABLE} data.catan.trade set value ' + json.dumps(trade)] + self.player_call('ui/open', 2) + self.click(360, 2)
        c += self.score('#submitted', 'lt', 0, 'unreviewed_accept_rejected')
        self.case('ui_no_unreviewed_accept', c)
        for label, changes in [
            ('epoch', [f'scoreboard players add {TABLE} ca_epoch 1']),
            ('load', ['scoreboard players add #ui_load ca_ctx 1']),
            ('table', [f'scoreboard players set {listener()} ca_table 202']),
            ('role', [f'tag {listener()} remove ct.player']),
        ]:
            c = self.setup_ui(phase=3) + self.player_call('ui/open') + changes + self.click(10)
            c += self.score('#submitted', 'lt', 0, 'ui_stale_' + label + '_no_submit')
            self.case('ui_guard_' + label, c)
        c = self.setup_ui(phase=3) + self.player_call('ui/open') + [f'scoreboard players operation #saved lt = {listener()} ca_nonce',
            'scoreboard players operation #saved lt *= #tenk lt', 'scoreboard players add #saved lt 10'] + self.click(10)
        c += [f'scoreboard players operation {listener()} ca_action = #saved lt'] + self.player_call('ui/handle') + self.score('#submitted', 'lt', 1, 'ui_nonce_cannot_replay')
        self.case('ui_replay', c)
        c = self.setup_ui(phase=3) + self.player_call('ui/open') + ['scoreboard players set #panel_serial ca_ctx 99999'] + self.player_call('ui/open', 2)
        c += self.score('#ui_load', 'ca_ctx', 2, 'ui_wrap_generation') + self.click(10) + self.score('#submitted', 'lt', 0, 'ui_wrap_old_nonce_refused')
        self.case('ui_wrap', c)
        for i, name in enumerate(self.cases[original_count:], original_count):
            self.files['case/' + name] += 'schedule function love_letter_test:' + ('case/' + self.cases[i + 1] if i + 1 < len(self.cases) else 'finish') + ' 1t\n'
        existing = {'ca_nonce', 'ca_ui_load', 'ca_ui_table', 'ca_seen'}
        extra = {**ui.OBJECTIVES, 'ca_mode': 'dummy', 'ca_pick': 'dummy', 'ca_turn': 'dummy', 'ca_anim': 'dummy', 'ca_action': 'trigger'}
        self.files['bootstrap'] = self.files['bootstrap'].replace('schedule function love_letter_test:case/',
            '\n'.join(f'scoreboard objectives add {key} {kind}' for key, kind in extra.items()) + '\nschedule function love_letter_test:case/', 1)


def prepare_target(target):
    sound_test.prepare_target(target)
    dest = target / 'data/catan/function'
    shutil.copytree(base.PACK / 'data/catan/function/ui', dest / 'ui')
    for name in ('input/context', 'system/context'):
        path = dest / (name + '.mcfunction')
        path.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(base.PACK / 'data/catan/function' / (name + '.mcfunction'), path)
    game = dest / 'game/action.mcfunction'
    game.write_text('scoreboard players add #submitted lt 1\ndata modify entity @s data.test_action set from storage catan:action input\n', encoding='utf-8')
    for path in list((dest / 'ui').glob('*.mcfunction')) + [dest / 'input/context.mcfunction', dest / 'system/context.mcfunction']:
        lines = []
        for line in path.read_text(encoding='utf-8').splitlines():
            if 'dialog show ' in line:
                lines += [line, 'scoreboard players add #dialog lt 1']
            elif 'dialog clear ' in line or 'tellraw ' in line:
                lines.append(line)
            else:
                lines.append(sound_test.fixtures(line))
        path.write_text('\n'.join(lines) + '\n', encoding='utf-8')


if __name__ == '__main__':
    font_checks()
    sound_test.asset_checks()
    suite = Suite()
    suite.build()
    original_run = base.subprocess.run
    def run_with_heap(command, *args, **kwargs):
        if len(command) == 2 and str(command[1]).startswith('@'):
            path = Path(str(command[1])[1:])
            path.write_text(path.read_text(encoding='utf-8').replace('-Xmx1536M', '-Xmx3072M'), encoding='utf-8')
        return original_run(command, *args, **kwargs)
    base.subprocess.run = run_with_heap
    raise SystemExit(base.run(suite, isolated=True, prefix='fimel-catan-ui-', prepare_target=prepare_target))
