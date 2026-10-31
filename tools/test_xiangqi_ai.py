"""原版26.2验收三档中国象棋人机、搜索取消、真实提交和两桌交错。"""
import test_xiangqi as base
from test_xiangqi import A, B, square


class Suite(base.Suite):
    def search(self, name, commands, checks, tables=(101,), side=1, limit=300):
        self.cases.append(name)
        commands += ['scoreboard players set #aiticks xg 0']
        for table in tables:
            target = A if table == 101 else B
            commands += [f'scoreboard players set {target} xq_bot {side}', f'scoreboard players set {target} xq_turn {side}'] + self.call('ai/reset', table)
        self.file('case/' + name, commands + [f'schedule function xiangqi_game_test:wait/{name} 1t'])
        wait = ['scoreboard players add #aiticks xg 1']
        for table in tables:
            target = A if table == 101 else B
            wait += [f'execute if score {target} xq_state matches 1 run function xiangqi_game_test:probe/{name}_{table}']
            self.file(f'probe/{name}_{table}', self.call('ai/tick', table))
        wait += [f'execute if score #aiticks xg matches {limit}.. run return run function xiangqi_game_test:done/{name}', 'scoreboard players set #ai_running xg 0']
        for table in tables:
            target = A if table == 101 else B
            wait += [f'execute if score {target} xq_state matches 1 run scoreboard players set #ai_running xg 1']
        wait += [f'execute if score #ai_running xg matches 1 run return run schedule function xiangqi_game_test:wait/{name} 1t', f'function xiangqi_game_test:done/{name}']
        self.file('wait/' + name, wait)
        self.file('done/' + name, self.score('#aiticks', 'xg', f'..{limit-1}', name + '_bounded') + checks)

    def position_map(self, pieces, turn=1):
        board = {4: 6, 85: -6, 40: 1, **pieces}
        rows = []
        letters = {1: 'P', 2: 'H', 3: 'E', 4: 'R', 5: 'C', 6: 'K', 7: 'A'}
        for rank in reversed(range(10)):
            row, empty = '', 0
            for file in range(9):
                piece = board.get(rank * 9 + file, 0)
                if not piece:
                    empty += 1
                    continue
                if empty:
                    row += str(empty)
                    empty = 0
                char = letters[abs(piece)]
                row += char if piece > 0 else char.lower()
            if empty:
                row += str(empty)
            rows.append(row)
        return self.position('/'.join(rows), turn=turn)

    def build(self):
        super().build()
        self.cases, self.expected = [], []
        for level in (1, 2, 3):
            name = f'opening_{level}'
            commands = self.setup() + [f'scoreboard players set {A} xq_level {level}']
            checks = self.score(A, 'xq_turn', -1, name + '_turn') + self.score(A, 'xq_state', 2, name + '_animation')
            checks += self.check(f'data entity {A} data.xiangqi.undo.board[89]', name + '_undo90')
            checks += self.call('engine/cache') + self.score('#cache_ok', 'xq_ctx', 1, name + '_valid_board')
            checks += ['scoreboard players operation #attack_sq xq_ctx = #wking xq_ctx', 'scoreboard players set #attacker xq_ctx -1', 'function xiangqi:engine/attack']
            checks += self.score('#attacked', 'xq_ctx', 0, name + '_general_safe') + self.score(A, 'xq_aistate', 0, name + '_search_consumed')
            self.search(name, commands, checks)

        for level in (2, 3):
            name = f'capture_{level}'
            commands = self.position_map({0: 4, 18: -4}) + [f'scoreboard players set {A} xq_level {level}']
            checks = self.score(square(18), 'xq_piece', 4, name + '_wins_rook')
            checks += self.check(f'data entity {A} data.xiangqi.last{{from:0,to:18,captured:-4}}', name + '_capture_metadata')
            self.search(name, commands, checks)

        for level in (2, 3):
            name = f'trap_{level}'
            commands = self.position_map({10: 4, 28: -4, 30: -4}) + [f'scoreboard players set {A} xq_level {level}']
            if level == 2:
                checks = self.check(f'data entity {A} data.xiangqi.last{{from:10,to:28}}', 'normal_prefers_rook_gain')
            else:
                checks = self.check(f'data entity {A} data.xiangqi.last', 'hard_submits_legal_move')
                checks += self.check(f'data entity {A} data.xiangqi.last{{captured:0}}', 'hard_avoids_defended_rook_trade')
            self.search(name, commands, checks)

        commands = self.position_map({81: -4, 63: 4}, turn=-1) + [f'scoreboard players set {A} xq_level 2']
        self.search('black', commands, self.score(square(63), 'xq_piece', -4, 'black_captures_down_rank') + self.score(A, 'xq_turn', 1, 'black_turn_flips'), side=-1)

        commands = self.setup() + [f'scoreboard players set {A} xq_bot 1', f'scoreboard players set {A} xq_level 3'] + self.call('ai/reset') + self.call('ai/tick')
        commands += [f'scoreboard players set {A} xq_aiwait 0'] + self.call('ai/tick')
        commands += self.score(square(4), 'xq_piece', 6, 'search_keeps_red_general') + self.score(square(85), 'xq_piece', -6, 'search_keeps_black_general')
        commands += self.score(square(19), 'xq_piece', 5, 'search_keeps_cannon') + self.score(A, 'xq_turn', 1, 'search_keeps_turn')
        commands += self.check(f'data entity {A} data.xiangqi.ai.queue[0]', 'search_queue_persists')
        commands += self.check(f'data entity {A} data.xiangqi.history[0]', 'search_keeps_history')
        commands += [f'scoreboard players add {A} xq_epoch 1'] + self.call('ai/tick') + self.score(A, 'xq_aistate', 0, 'epoch_cancels')
        commands += self.call('ai/tick') + [f'scoreboard players set {A} xq_bot 0'] + self.call('ai/tick') + self.score(A, 'xq_aistate', 0, 'human_mode_cancels')
        commands += [f'scoreboard players set {A} xq_bot 1'] + self.call('ai/tick') + [f'scoreboard players set {A} ct_state 0'] + self.call('ai/tick') + self.score(A, 'xq_aistate', 0, 'lobby_cancels')
        self.case('noncommitting_cancel', commands)

        commands = self.setup() + self.setup(table=202, reset=False) + [f'scoreboard players set {A} xq_level 2', f'scoreboard players set {B} xq_level 3']
        checks = self.score(A, 'xq_turn', -1, 'table_a_moved') + self.score(B, 'xq_turn', -1, 'table_b_moved')
        checks += self.count('@e[tag=xq.square,scores={ct_id=101}]', 90, 'table_a_90') + self.count('@e[tag=xq.square,scores={ct_id=202}]', 90, 'table_b_90')
        checks += self.check(f'data entity {A} data.xiangqi.undo.board[89]', 'table_a_undo') + self.check(f'data entity {B} data.xiangqi.undo.board[89]', 'table_b_undo')
        self.search('isolation', commands, checks, tables=(101, 202))

        # Black has no legal move but is not in check: Xiangqi awards red a win.
        commands = self.position_map({85: -6, 4: 6, 40: 1, 75: 4, 77: 4}, turn=-1) + [f'scoreboard players set {A} xq_level 1']
        self.search('no_moves', commands, self.score(A, 'xq_result', 1, 'no_moves_red_wins') + self.score(A, 'xq_reason', 2, 'no_moves_kunbi'), side=-1)

        commands = self.setup() + [f'kill {square(89)}', f'scoreboard players set {A} xq_bot 1'] + self.call('ai/tick')
        commands += self.score(A, 'xq_result', 3, 'missing_marker_stops_game') + self.score(A, 'xq_reason', 11, 'missing_marker_error_reason')
        commands += self.score(A, 'xq_aistate', 0, 'missing_marker_cancels_search') + self.score(A, 'xq_state', 4, 'missing_marker_finishes')
        self.case('invalid_cache', commands)

        self.file('finish', ['function xiangqi_game_test:reset', 'say XIANGQI_DIALOGS_END', 'say XIANGQI_GAME_FINISHED'])
        self.file('bootstrap', ['forceload add -16 -16 63 31', 'scoreboard objectives add xg dummy', 'schedule function xiangqi_game_test:case/' + self.cases[0] + ' 40t'])
        for index, name in enumerate(self.cases):
            key = 'done/' + name if 'done/' + name in self.files else 'case/' + name
            self.files[key] += 'schedule function xiangqi_game_test:' + ('case/' + self.cases[index+1] if index+1 < len(self.cases) else 'finish') + ' 3t\n'


if __name__ == '__main__':
    suite = Suite()
    suite.build()
    raise SystemExit(base.run(suite, prefix='fimel-xiangqi-ai-', setup_ticks=3000, manual_tick=True))
