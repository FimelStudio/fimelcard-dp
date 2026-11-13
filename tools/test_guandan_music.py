"""原版26.2验证掼蛋共享音乐：时长、开关、残局、结算、暂停、恢复与两桌。"""
import json
import struct
from test_guandan_game import Suite as GameSuite, PACK, TABLE, OTHER, part, person, prepare_target
from test_guandan_cards import run
from build_guandan_music import TRACKS


def check_resources():
    assets = PACK.parents[3] / 'resourcepacks/fimelcard-rp/assets/card'
    sounds = json.loads((assets / 'sounds.json').read_text(encoding='utf-8'))
    for name, (_, ticks) in TRACKS.items():
        assert sounds['doudizhu.' + name]['sounds'] == [{'name': 'card:doudizhu/' + name, 'stream': True}]
        data = (assets / 'sounds/doudizhu' / (name + '.ogg')).read_bytes()
        offset, samples, rate = 0, 0, None
        while offset < len(data):
            assert data[offset:offset+4] == b'OggS'
            segments = data[offset+26]
            start = offset + 27 + segments
            if offset == 0:
                assert data[start+1:start+7] == b'vorbis'
                rate = struct.unpack_from('<I', data, start+12)[0]
            granule = struct.unpack_from('<q', data, offset+6)[0]
            if granule >= 0:
                samples = granule
            offset = start + sum(data[offset+27:offset+27+segments])
        assert offset == len(data)
        assert ticks == -(-samples*20 // rate), (name, samples/rate, ticks)
        body = (PACK / 'data/guandan/function/music' / ('start_' + name + '.mcfunction')).read_text(encoding='utf-8')
        assert f'gd_mtime {ticks}' in body
        assert f'playsound card:doudizhu.{name} record @s ~ ~ ~ 1 1 1' in body
        print(f'Shared {name}: {samples/rate:.3f}s / {ticks} ticks')
    assert not (assets / 'sounds/guandan/normal.ogg').exists()
    assert not (assets / 'sounds/guandan/exciting.ogg').exists()
    print('Shared soundtrack events, Vorbis duration and no duplicate music: PASS', flush=True)


class Suite(GameSuite):
    def music(self, table=101):
        return self.call('music/table_tick', table)

    def setting(self, value):
        return [f'scoreboard players operation #setting_code gt = {person()} gd_setnonce',
                'scoreboard players set #factor gt 100000',
                'scoreboard players operation #setting_code gt *= #factor gt',
                f'scoreboard players add #setting_code gt {7000+value}',
                f'scoreboard players operation {person()} gd_settings = #setting_code gt',
                f'execute as {person()} at @s run function guandan:settings/save']

    def build(self):
        self.prepare()
        c = self.setup_game() + self.score(TABLE, 'gd_audio', 1, 'default_enabled')
        c += [f'scoreboard players set {TABLE} gd_audio 0'] + self.call('game/init_table')
        c += self.score(TABLE, 'gd_audio', 0, 'preserve_disabled_setting')
        c += [f'scoreboard players set {TABLE} gd_audio 9'] + self.call('game/init_table')
        c += self.score(TABLE, 'gd_audio', 1, 'repair_invalid_setting')
        self.case('music_defaults', c)

        c = self.setup_game() + [f'tag {person()} add ct.settings_actor']
        c += self.call('settings/open') + self.setting(0)
        c += self.score(TABLE, 'gd_audio', 0, 'music_setting_click_disables')
        c += self.setting(1) + self.score(TABLE, 'gd_audio', 1, 'music_setting_click_enables')
        c += self.setting(2) + self.score(TABLE, 'gd_audio', 1, 'music_setting_invalid_rejected')
        self.case('music_settings', c)

        c = self.setup_game() + self.start()
        c += self.score(person(), 'gd_music', 1, 'round_starts_normal') + self.score(person(), 'gd_mtime', 580, 'normal_duration')
        c += self.music() + self.score(person(), 'gd_mtime', 579, 'normal_progresses')
        c += [f'scoreboard players set {person()} gd_mtime 0'] + self.music()
        c += self.score(person(), 'gd_mtime', 580, 'normal_loops')
        c += [f'scoreboard players set {TABLE} gd_kind 8'] + self.call('music/check_exciting') + self.music()
        c += self.score(person(), 'gd_music', 2, 'bomb_exciting') + self.score(person(), 'gd_mtime', 623, 'exciting_duration')
        c += [f'scoreboard players set {person()} gd_mtime 0'] + self.music()
        c += self.score(person(), 'gd_mtime', 623, 'exciting_loops')
        c += self.call('round/begin') + self.score(person(), 'gd_music', 1, 'next_round_normal')
        self.case('music_playing', c)

        for kind, name in [(9, 'straight_flush'), (10, 'four_jokers')]:
            c = self.setup_game() + self.start()
            c += [f'scoreboard players set {TABLE} gd_kind {kind}'] + self.call('music/check_exciting') + self.music()
            c += self.score(person(), 'gd_music', 2, name + '_exciting')
            self.case('music_' + name, c)

        c = self.setup_game() + self.start()
        c += [f'scoreboard players set {TABLE} gd_kind 1', f'scoreboard players set {part(4)} gd_count 2', f'tag {part(4)} add gd.bot']
        c += self.call('music/check_exciting') + self.music() + self.score(person(), 'gd_music', 2, 'bot_low_cards_exciting')
        self.case('music_low_cards', c)

        c = self.setup_game() + self.start()
        c += [f'scoreboard players set {TABLE} gd_state 4', f'scoreboard players set {TABLE} gd_winner 0'] + self.music()
        c += self.score(person(1), 'gd_music', 3, 'winning_team_music') + self.score(person(2), 'gd_music', 4, 'losing_team_music')
        c += self.score(person(3), 'gd_music', 3, 'winning_partner_music') + self.score(person(4), 'gd_music', 4, 'losing_partner_music')
        c += self.music() * 80
        c += self.score(person(1), 'gd_mtime', 0, 'win_does_not_loop') + self.score(person(2), 'gd_mtime', 0, 'lose_does_not_loop')
        c += [f'scoreboard players set {TABLE} gd_state 5', f'scoreboard players set {TABLE} gd_matchwin 1'] + self.music()
        c += self.score(person(1), 'gd_music', 4, 'match_result_overrides_round') + self.score(person(2), 'gd_music', 3, 'match_winner_music')
        c += [f'scoreboard players set {TABLE} gd_matchwin 2'] + self.music()
        c += self.score(person(1), 'gd_music', 0, 'match_draw_stops_music') + self.score(person(2), 'gd_music', 0, 'draw_both_teams_silent')
        self.case('music_results', c)

        c = self.setup_game() + self.start()
        c += [f'scoreboard players set {TABLE} ct_paused 1', 'scoreboard players set @e[tag=gd.player] ct_paused 1']
        c += self.call('music/pause') + self.score(person(), 'gd_music', 0, 'pause_stops_music')
        c += self.music() + self.score(person(), 'gd_music', 0, 'paused_tick_does_not_start')
        c += [f'scoreboard players set {person(3)} gd_music 1', f'scoreboard players set {person(3)} gd_mtime 99']
        c += [f'scoreboard players set {TABLE} ct_paused 0', 'scoreboard players set @e[tag=gd.player] ct_paused 0'] + self.music()
        c += self.score(person(), 'gd_music', 1, 'resume_restarts_current_music')
        c += self.score(person(3), 'gd_mtime', 580, 'reconnected_player_restarts_audio')
        c += self.call('system/reload') + self.score(person(), 'gd_music', 1, 'reload_preserves_phase')
        c += [f'scoreboard players set {TABLE} gd_audio 0'] + self.music()
        c += self.score(person(), 'gd_music', 0, 'disabled_stops_music')
        c += self.call('round/begin') + self.score(person(), 'gd_music', 0, 'disabled_next_round_stays_silent')
        self.case('music_pause_reload', c)

        c = self.setup_game() + self.start() + self.setup_game(table=202, reset=False) + self.start(202)
        c += [f'scoreboard players set {TABLE} gd_kind 8'] + self.call('music/check_exciting') + self.music()
        c += self.score(person(), 'gd_music', 2, 'first_table_exciting') + self.score(person(table=202), 'gd_music', 1, 'neighbor_stays_normal')
        c += self.call('music/pause') + self.score(person(), 'gd_music', 0, 'pause_only_first_table')
        c += self.score(person(table=202), 'gd_music', 1, 'neighbor_not_stopped')
        c += self.call('game/abort') + self.score(person(), 'gd_music', 0, 'abort_clears_music')
        c += self.score(person(table=202), 'gd_music', 1, 'abort_preserves_neighbor_music')
        self.case('music_isolation', c)
        self.finish()


if __name__ == '__main__':
    check_resources()
    suite = Suite()
    suite.build()
    raise SystemExit(run(suite, isolated=False, prefix='fimel-guandan-music-', prepare_target=prepare_target))
