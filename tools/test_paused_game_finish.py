"""原版26.2回归：离线投票实际结束、结算倒计时与旧玩家重连清理。

复制完整数据包到临时世界，保留生产 vote/finish、各游戏 finish/cleanup/tick
及全部会话逻辑。仅将在线玩家选择器桥接为盔甲架；玩家专用显示命令以
execute as 保留编译，clear 则在替身的手持槽真实执行等价的物品筛选。
因此本测试验证服务端状态，客户端 BetterTitle 画面仍需真人复测。
复现修复前版本：--baseline-ref e9da691 --case g4_offline_vote_finish。
"""
from pathlib import Path
import json
import re
import subprocess
import sys

from build_table_sessions import GAMES
from test_love_letter_engine import Suite as Base, run


C = '@e[type=minecraft:marker,tag=pf.table,scores={ct_id=101},limit=1]'
D = '@e[type=minecraft:marker,tag=pf.table,scores={ct_id=202},limit=1]'


def player(seat=1, table=101):
    # pf_seat/pf_table survive the production cleanup whose ct_* scores are reset.
    return f'@e[tag=pf.player,scores={{pf_table={table},pf_seat={seat}}},limit=1]'


class Suite(Base):
    def call(self, name, table=101):
        return [f'execute as {C if table == 101 else D} at @s run function cardtable:{name}']

    def setup(self, game=4, table=101, reset=True):
        namespace, pre = GAMES[game - 1]
        ctrl = C if table == 101 else D
        lines = ['function love_letter_test:reset'] if reset else []
        lines += [f'execute positioned {8 if table == 101 else 40} 64 8 summon minecraft:marker run function love_letter_test:table {{table:{table},game:{game}}}',
                  f'tag {ctrl} add {pre}.controller']
        for obj in ('id', 'table'):
            lines += [f'scoreboard players set {ctrl} {pre}_{obj} {table}']
        lines += [f'scoreboard players set {ctrl} {pre}_state {2 if game == 4 else 1}']
        for seat in (1, 3):
            p = player(seat, table)
            lines += [f'execute positioned {8 if table == 101 else 40} 64 8 summon minecraft:armor_stand run function love_letter_test:player {{table:{table},seat:{seat}}}',
                      f'tag {p} add {pre}.player']
            for obj in ('id', 'table'):
                lines += [f'scoreboard players set {p} {pre}_{obj} {table}']
            lines += [f'scoreboard players set {p} {pre}_seat {seat}']
        # Abraca's own panel displaced an already active panel before disconnect.
        if game == 4:
            for seat in (1, 3):
                p = player(seat, table)
                lines += [f'scoreboard players set {p} ab_prev_panel 77',
                          f'scoreboard players reset {p} ab_panel',
                          f'execute as {p} run function fimel_title:new_panel {{id:"@s ab_panel"}}',
                          f'scoreboard players operation {p} pf_panel = {p} ab_panel',
                          f'scoreboard players operation {p} fbt_panel = {p} ab_panel',
                          'data modify storage fimel_title:io panel_buffer set value [{text:"OLD_ABRACA_HAND"}]',
                          f'scoreboard players operation panel_id fbt_io = {p} ab_panel',
                          'function fimel_title:replace_panel',
                          f'scoreboard players set {p} ab_hp 6',
                          f'item replace entity {p} weapon.mainhand with minecraft:paper[minecraft:custom_data={{abraca:{{cast:1b}}}}]',
                          f'item replace entity {p} weapon.offhand with minecraft:paper[minecraft:custom_data={{abraca:{{stone:1b}}}}]']
        return lines + self.call('session/start', table)

    def offline(self, seat=3, table=101):
        return [f'tag {player(seat, table)} remove pf.online', 'function cardtable:session/pre_tick']

    def rejoin(self, seat=3, table=101):
        return [f'tag {player(seat, table)} add pf.online', 'function cardtable:session/pre_tick']

    def vote(self, table=101):
        return [f'scoreboard players set {player(1, table)} ct_voted 1'] + self.call('vote/count', table) + self.call('vote/finish', table)

    def ticks(self, namespace, count=121):
        # Split below into scheduled one-tick steps: preserve the production
        # command limit and the actual relation between pre_tick and game tick.
        return [f'# pf_ticks {namespace} {count}']

    def clean_return(self, game, key, table=101):
        pre = GAMES[game - 1][1]
        p = player(3, table)
        lines = self.rejoin(3, table)
        lines += self.check(f'entity {p[:-1]},tag=!ct.player,tag=!{pre}.player]', key + '_old_player_tags_removed')
        lines += [f'execute store success score #old_session lt run scoreboard players get {p} ct_session']
        lines += self.score('#old_session', 'lt', 0, key + '_old_session_removed')
        lines += self.score(p, 'ct_paused', 0, key + '_player_unpaused')
        if game == 4:
            lines += self.score(p, 'fbt_panel', 77, key + '_previous_hud_restored')
            lines += [f'execute store result storage love_letter_test:run panel.id int 1 run scoreboard players get {p} pf_panel',
                      'function love_letter_test:panel_size with storage love_letter_test:run panel']
            lines += self.score('#panel_size', 'lt', 0, key + '_own_hud_buffer_cleared')
            for slot, suffix in (('weapon.mainhand', 'cast_tool'), ('weapon.offhand', 'legacy_stone')):
                lines += ['scoreboard players set #item_left lt 0',
                          f'execute if items entity {p} {slot} * run scoreboard players set #item_left lt 1']
                lines += self.score('#item_left', 'lt', 0, key + '_' + suffix + '_removed')
        return lines

    def build(self):
        self.file('reset', [
            'kill @e[tag=pf.fixture]', 'kill @e[tag=ct.part]',
            'kill @e[tag=ab.final_info]', 'kill @e[tag=ab.info]',
        ])
        self.file('table', '''
tag @s add pf.fixture
tag @s add pf.table
tag @s add ct.controller
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ct_game $(game)
scoreboard players set @s ct_state 1
scoreboard players set @s ct_capacity 8
scoreboard players set @s ct_joined 2
scoreboard players set @s ct_chairs 8
scoreboard players set @s ct_paused 0
scoreboard players set @s ct_votes 0
data modify entity @s data.cardtable set value {menu_version:13,chairs_version:1,rules_version:5,vote_version:1}
''')
        self.file('player', '''
tag @s add pf.fixture
tag @s add pf.player
tag @s add pf.online
tag @s add ct.player
data merge entity @s {NoGravity:1b,Invisible:1b}
$scoreboard players set @s pf_table $(table)
$scoreboard players set @s pf_seat $(seat)
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ct_seat $(seat)
scoreboard players set @s ct_online 1
scoreboard players set @s ct_voted 0
''')
        self.file('panel_size', '$execute store result score #panel_size lt run data get storage fimel_title:io panels[$(id)]')
        for game, (namespace, pre) in enumerate(GAMES, 1):
            key = f'g{game}'
            lines = self.setup(game) + self.offline()
            lines += self.score(C, 'ct_paused', 1, key + '_offline_paused')
            lines += self.vote()
            lines += self.score(C, 'ct_paused', 0, key + '_vote_thaws_ending')
            lines += ['function cardtable:session/pre_tick']
            lines += self.score(C, 'ct_paused', 0, key + '_pre_tick_keeps_ending_unpaused')
            if game == 4:
                lines += self.score(C, 'ct_finishing', 1, key + '_delayed_ending_marked')
                lines += self.score(C, 'ab_timer', 120, key + '_actual_final_countdown')
            lines += self.ticks(namespace, 121 if game == 4 else 2)
            lines += self.score(C, 'ct_state', 0, key + '_lobby_without_offline_member')
            lines += self.score(C, 'ct_paused', 0, key + '_lobby_not_paused')
            lines += self.clean_return(game, key)
            lines += self.score(C, 'ct_state', 0, key + '_rejoin_keeps_lobby')
            self.case(key + '_offline_vote_finish', lines)

        # Returning while the six-second result is still visible must clean the
        # old identity immediately, rather than reattach to an ending session.
        lines = self.setup() + self.offline() + self.vote() + self.ticks('abraca', 30)
        lines += self.score(C, 'ab_timer', 90, 'ab_mid_result_advances')
        lines += self.clean_return(4, 'ab_mid_result')
        lines += self.score(C, 'ab_timer', 90, 'ab_return_does_not_restart_timer')
        lines += self.call('vote/finish')
        lines += self.score(C, 'ab_timer', 90, 'ab_repeat_vote_does_not_restart_timer')
        lines += self.ticks('abraca', 91)
        lines += self.score(C, 'ct_state', 0, 'ab_mid_result_lobby')
        self.case('abraca_return_during_result', lines)

        # Normal completion uses the same production finish, with a disconnected
        # participant. This must not rely on the public vote dispatch thawing it.
        lines = self.setup() + self.offline()
        lines += [f'execute as {C} at @s run function abraca:game/finish']
        lines += ['function cardtable:session/pre_tick']
        lines += self.score(C, 'ct_paused', 0, 'ab_normal_finish_thaws')
        lines += self.ticks('abraca', 121)
        lines += self.score(C, 'ct_state', 0, 'ab_normal_finish_lobby')
        lines += self.clean_return(4, 'ab_normal_finish')
        self.case('abraca_normal_finish', lines)

        # Starting a fresh session on the same physical table cannot adopt the
        # old offline player's tags, tools or BetterTitle panel.
        lines = self.setup() + self.offline() + self.vote() + self.ticks('abraca')
        lines += [f'scoreboard players set {C} ct_state 1', f'scoreboard players set {C} ct_game 11',
                  f'tag {C} add un.controller', f'scoreboard players set {C} un_state 1',
                  f'scoreboard players set {player()} ct_online 1', f'tag {player()} add ct.player',
                  f'scoreboard players set {player()} ct_id 101', f'scoreboard players set {player()} ct_seat 1',
                  f'tag {player()} add un.player']
        lines += self.call('session/start')
        lines += [f'scoreboard players operation #new_session lt = {C} ct_session']
        lines += self.clean_return(4, 'ab_new_session')
        lines += self.score(C, 'ct_state', 1, 'ab_new_session_still_active')
        lines += self.score(C, 'ct_expected', 1, 'ab_new_session_keeps_only_new_members')
        lines += self.check(f'score {C} ct_session = #new_session lt', 'ab_new_session_not_replaced')
        lines += self.score(C, 'ct_paused', 0, 'ab_new_session_not_paused_by_old_member')
        self.case('abraca_new_session_isolation', lines)

        # The persistent ended registry must work without a loaded controller.
        lines = self.setup() + self.offline() + self.vote() + self.ticks('abraca')
        lines += [f'kill {C}'] + self.clean_return(4, 'ab_unloaded_ended_table')
        self.case('abraca_ended_table_unloaded', lines)

        # A paused second table's own timer and pending identity are untouched.
        lines = self.setup() + self.setup(4, 202, False)
        lines += self.offline() + self.offline(3, 202)
        lines += [f'scoreboard players set {D} ab_timer 57'] + self.vote()
        lines += self.ticks('abraca', 121)
        lines += self.score(C, 'ct_state', 0, 'ab_two_tables_first_lobby')
        lines += self.score(D, 'ct_state', 1, 'ab_two_tables_second_active')
        lines += self.score(D, 'ct_paused', 1, 'ab_two_tables_second_still_paused')
        lines += self.score(D, 'ab_timer', 57, 'ab_two_tables_second_timer_untouched')
        lines += self.clean_return(4, 'ab_two_tables_first')
        lines += self.check(f'entity {player(3,202)[:-1]},tag=ab.player,tag=ct.player]', 'ab_two_tables_second_identity_untouched')
        self.case('abraca_two_tables', lines)

        lines = self.setup() + self.offline() + self.vote() + self.ticks('abraca')
        lines += [f'tag {player(3)} add pf.online', 'function abraca:load']
        lines += self.clean_return(4, 'ab_reload_old_lobby')
        lines += self.score(C, 'ct_state', 0, 'ab_reload_old_lobby_stays_lobby')
        self.case('abraca_reload_old_lobby', lines)

        lines = self.setup() + self.offline()
        lines += [f'execute as {C} at @s run function abraca:game/finish',
                  'function cardtable:session/load', 'function abraca:load']
        lines += self.score(C, 'ct_paused', 0, 'ab_reload_old_result_thaws')
        lines += self.score(C, 'ct_finishing', 1, 'ab_reload_old_result_remains_final')
        lines += self.ticks('abraca', 121)
        lines += self.score(C, 'ct_state', 0, 'ab_reload_old_result_lobby')
        lines += self.clean_return(4, 'ab_reload_old_result')
        self.case('abraca_reload_old_result', lines)

        lines = self.setup()
        lines += [f'scoreboard players set {player()} fbt_panel 555',
                  f'execute as {player()} run function abraca:player/clear_state']
        lines += self.score(player(), 'fbt_panel', 555, 'ab_other_hud_not_overwritten')
        lines += [f'execute store result storage love_letter_test:run panel.id int 1 run scoreboard players get {player()} pf_panel',
                  'function love_letter_test:panel_size with storage love_letter_test:run panel']
        lines += self.score('#panel_size', 'lt', 0, 'ab_other_hud_own_old_buffer_still_cleared')
        self.case('abraca_external_hud_preserved', lines)

        # Between-round result screens still belong to an active match. Their
        # timers and old members must remain paused while someone is offline.
        for game, state in ((10, 4), (11, 5), (17, 3), (18, 4)):
            namespace, pre = GAMES[game - 1]
            key = f'g{game}_intermission'
            lines = self.setup(game)
            lines += [f'scoreboard players set {C} {pre}_state {state}',
                      f'scoreboard players set {C} {pre}_timer 55']
            if game == 10:
                lines += [f'scoreboard players set {C} dd_round 1', f'scoreboard players set {C} dd_limit 3']
            if game == 11:
                lines += [f'scoreboard players set {C} un_matchend 0']
            lines += self.offline() + self.ticks(namespace, 5)
            lines += self.score(C, 'ct_state', 1, key + '_match_still_active')
            lines += self.score(C, 'ct_paused', 1, key + '_still_paused')
            lines += self.score(C, pre + '_timer', 55, key + '_timer_frozen')
            lines += self.check(f'entity {player(3)[:-1]},tag=ct.player,tag={pre}.player]', key + '_old_member_retained')
            lines += ['scoreboard players set #closed lt 0', f'execute if score {C} ct_finishing matches 1 run scoreboard players set #closed lt 1']
            lines += self.score('#closed', 'lt', 0, key + '_not_final')
            self.case(key, lines)

        # Exercise each production terminal phase independently of vote/finish.
        # These are real final-state values from the individual game engines,
        # including the two final/intermission distinctions in DD and UNO.
        lines = []
        final_states = ((2, 17), (3, 3), (4, 3), (7, 4), (10, 4), (11, 5),
                        (12, 4), (13, 4), (14, 4), (15, 5), (16, 5),
                        (17, 4), (18, 5), (19, 4), (20, 4), (21, 11),
                        (22, 4), (23, 5))
        for game, state in final_states:
            pre = GAMES[game - 1][1]
            key = f'g{game}_terminal'
            lines += self.setup(game) + self.offline()
            lines += [f'execute store result storage love_letter_test:run terminal.round int 1 run scoreboard players get {C} ct_session',
                      f'scoreboard players set {C} {pre}_state {state}']
            if game == 10:
                lines += [f'scoreboard players set {C} dd_round 3', f'scoreboard players set {C} dd_limit 3']
            if game == 11:
                lines += [f'scoreboard players set {C} un_matchend 1']
            lines += ['function cardtable:session/pre_tick']
            lines += self.score(C, 'ct_finishing', 1, key + '_recognized')
            lines += self.score(C, 'ct_paused', 0, key + '_countdown_released')
            lines += self.score(C, 'ct_session', 0, key + '_session_closed')
            lines += ['scoreboard players set #round_active ct_ctx 0',
                      'function cardtable:session/registry_check with storage love_letter_test:run terminal']
            lines += self.score('#round_active', 'ct_ctx', 0, key + '_registry_ended')
            lines += self.clean_return(game, key)
            lines += self.score(C, 'ct_state', 1, key + '_return_does_not_abort_final_display')
        self.case('terminal_phases', lines)

        self.file('finish', ['function love_letter_test:reset', 'say LOVELETTER_FINISHED'])
        self.file('bootstrap', [
            'forceload add -16 -16 63 31',
            'scoreboard objectives add lt dummy',
            'scoreboard objectives add pf_table dummy',
            'scoreboard objectives add pf_seat dummy',
            'scoreboard objectives add pf_panel dummy',
            'schedule function love_letter_test:case/' + self.cases[0] + ' 2t',
        ])
        for index, name in enumerate(self.cases):
            nxt = 'case/' + self.cases[index + 1] if index + 1 < len(self.cases) else 'finish'
            self.files['case/' + name] += f'schedule function love_letter_test:{nxt} 1t\n'

    def schedule_steps(self, selected=None):
        """Give every production tick its own server tick, without runner forks."""
        if selected:
            if selected not in self.cases:
                raise SystemExit('Unknown case: ' + selected)
            self.cases = [selected]
            self.files['case/' + selected] = re.sub(
                r'schedule function love_letter_test:case/[a-z0-9_]+ 1t',
                'schedule function love_letter_test:finish 1t', self.files['case/' + selected])
            self.files['bootstrap'] = re.sub(
                r'schedule function love_letter_test:case/[a-z0-9_]+ 2t',
                'schedule function love_letter_test:case/' + selected + ' 2t', self.files['bootstrap'])
        self.setup_ticks = len(self.cases) + 30
        for name in self.cases:
            path = 'case/' + name
            body = self.files[path]
            chunks = re.split(r'^# pf_ticks ([a-z_]+) (\d+)\n', body, flags=re.M)
            next_path = path
            for index in range(1, len(chunks), 3):
                namespace, count, remaining = chunks[index:index + 3]
                self.setup_ticks += int(count) + 1
                tick_path = f'steps/{name}_{index}'
                continuation = f'continue/{name}_{index}'
                self.file(next_path, chunks[index - 1] +
                          f'scoreboard players set #step lt 0\nschedule function love_letter_test:{tick_path} 1t\n')
                self.file(tick_path, [
                    'function cardtable:session/pre_tick', f'function {namespace}:tick',
                    'scoreboard players add #step lt 1',
                    f'execute if score #step lt matches ..{int(count)-1} run schedule function love_letter_test:{tick_path} 1t',
                    f'execute if score #step lt matches {count}.. run schedule function love_letter_test:{continuation} 1t',
                ])
                next_path = continuation
            if len(chunks) > 1:
                self.file(next_path, chunks[-1])
        if selected:
            self.expected = []
            for path, body in self.files.items():
                if path in ('case/' + selected,) or path.startswith(('continue/' + selected + '_', 'steps/' + selected + '_')):
                    self.expected += re.findall(r'LOVELETTER_PASS ([a-z0-9_]+)', body)


def fixture_hook(target, baseline_ref=None):
    """Only player/online and equipment adapters; production business unchanged."""
    selector = r'(@e\[(?:[^\[\]]|\[[^\]]*\])*\])'
    if baseline_ref:
        # Restore committed production versions in the disposable copy only.
        pack = Path(__file__).resolve().parents[1]
        changed = subprocess.run(['git', 'diff', '--name-only', baseline_ref, '--', 'data'], cwd=pack,
                                 check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                                 text=True, encoding='utf-8').stdout.splitlines()
        for relative in changed:
            original = subprocess.run(['git', 'show', baseline_ref + ':' + relative], cwd=pack,
                                      stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            destination = target / relative
            if original.returncode == 0:
                destination.parent.mkdir(parents=True, exist_ok=True)
                destination.write_bytes(original.stdout)
            elif destination.exists():
                destination.unlink()
    for path in (target / 'data').rglob('*.mcfunction'):
        body = path.read_text(encoding='utf-8')
        if '@a' not in body and 'clear @s' not in body:
            continue
        body = re.sub(r'@a\[', '@e[tag=pf.player,tag=pf.online,', body)
        body = re.sub(r'@a(?![a-z_\[])', '@e[tag=pf.player,tag=pf.online]', body)
        body = re.sub(r'\b(tellraw|title|dialog clear|dialog show|stopsound|give|clear) ' + selector,
                      lambda m: 'execute as ' + m[2] + ' run ' + m[1] + ' @s', body)
        body = re.sub(r'\b(playsound \S+ \S+) ' + selector,
                      lambda m: 'execute as ' + m[2] + ' run ' + m[1] + ' @s', body)
        body = re.sub(r'\b(particle .+ (?:force|normal)) ' + selector,
                      lambda m: 'execute as ' + m[2] + ' run ' + m[1] + ' @s', body)
        lines = []
        for line in body.splitlines():
            match = re.match(r'^((?:.* run )?)clear @s(?: (.*))?$', line)
            if not match or line.startswith('#'):
                lines.append(line)
                continue
            query = re.sub(r'\s+\d+$', '', match[2] or '*')
            for slot in ('weapon.mainhand', 'weapon.offhand'):
                lines.append(match[1] + f'execute if items entity @s {slot} {query} run item replace entity @s {slot} with minecraft:air')
        path.write_text('\n'.join(lines) + '\n', encoding='utf-8')


if __name__ == '__main__':
    baseline_ref = None
    if '--baseline-ref' in sys.argv:
        index = sys.argv.index('--baseline-ref')
        baseline_ref = sys.argv[index + 1]
        del sys.argv[index:index + 2]
    selected = None
    if '--case' in sys.argv:
        index = sys.argv.index('--case')
        selected = sys.argv[index + 1]
        del sys.argv[index:index + 2]
    if '--java' not in sys.argv:
        sys.argv += ['--java', 'C:/Temp/fimel-java25-validation/jdk-25.0.5+8-jre/bin/java.exe']
    original_run = subprocess.run

    def heap(command, *args, **kwargs):
        if len(command) > 1 and str(command[1]).startswith('@'):
            path = Path(str(command[1])[1:])
            path.write_text(path.read_text(encoding='utf-8').replace('-Xmx1536M', '-Xmx3072M'), encoding='utf-8')
            instance = path.parent / 'packs/fimel_cards/data/love_letter_test/test_instance/game.json'
            value = json.loads(instance.read_text(encoding='utf-8'))
            value['setup_ticks'] = suite.setup_ticks
            instance.write_text(json.dumps(value), encoding='utf-8')
            kwargs['timeout'] = 900
        return original_run(command, *args, **kwargs)

    subprocess.run = heap
    suite = Suite()
    suite.build()
    suite.schedule_steps(selected)
    raise SystemExit(run(suite, isolated=False, prefix='fimel-paused-game-finish-',
                         prepare_target=lambda target: fixture_hook(target, baseline_ref)))
