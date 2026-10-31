"""隔离原版26.2世界验证五子棋真实换座、单人人机与两桌隔离。

复用中国象棋的座椅测试场景：两者使用相同的通用牌桌座位契约。
仅在临时副本以盔甲架模拟玩家；真实客户端右键和Q仍需人工验收。
"""
import re
from test_xiangqi_seating import Suite as SeatingCases
from test_gomoku import PACK, run


def translate(body):
    body=body.replace('xiangqi_seat_test:', 'gomoku_game_test:').replace('xiangqi_game_test:', 'gomoku_game_test:')
    body=body.replace('xiangqi', 'gomoku').replace('XIANGQI', 'GOMOKU').replace('xq_', 'gm_').replace('xq.', 'gm.')
    body=body.replace('gm_btime', 'gm_wtime').replace('gm_rtime', 'gm_btime').replace('gm_half', 'gm_moves')
    body=body.replace('red', '__POSITIVE_SIDE__').replace('black', 'white').replace('__POSITIVE_SIDE__', 'black')
    return body.replace('ct_game 13', 'ct_game 14')


class Suite(SeatingCases):
    def build(self):
        super().build()
        # 悔棋与终局重开依赖不同棋种的初始棋面，已由test_gomoku覆盖。
        self.cases=[name for name in self.cases if name not in ('solo_undo_draw','review_restart')]
        keep={'reset','table','person','finish','bootstrap'}|{'case/'+name for name in self.cases}
        self.files={name:translate(body) for name,body in self.files.items() if name in keep}
        for index,name in enumerate(self.cases):
            key='case/'+name
            self.files[key]=re.sub(r'^schedule function .+\n?', '',self.files[key],flags=re.M)
            self.files[key]+='schedule function gomoku_game_test:'+('case/'+self.cases[index+1] if index+1<len(self.cases) else 'case/dialogs')+' 2t\n'
        self.files['dialogs']=(PACK/'tools/test_gomoku_dialogs.mcfunction').read_text(encoding='utf-8')
        self.files['case/dialogs']='function gomoku_game_test:dialogs\nschedule function gomoku_game_test:finish 2t\n'
        self.expected=[value for body in self.files.values() for value in re.findall(r'GOMOKU_GAME_PASS ([a-z0-9_]+)',body)]
        assert len(self.expected)==len(set(self.expected))


def fixture_hook(target):
    # 客户端输出保持真人选择器；仅服务端身份与换座改为测试盔甲架。
    for name in ['game/start','game/assign_sides','game/solo_sides','game/random_first','game/chosen_first','game/reseat','system/reload','system/heartbeat']:
        path=target/f'data/gomoku/function/{name}.mcfunction'
        lines=[]
        for line in path.read_text(encoding='utf-8').splitlines():
            if 'if items entity' in line or 'run function gomoku:input/give' in line:
                continue
            if not any(command in line for command in ['tellraw ','title ','dialog ']):
                line=line.replace('@a[tag=ct.player]', '@e[tag=cs.person,tag=ct.player]')
                line=line.replace('@a[tag=gm.audience', '@e[tag=cs.person,tag=gm.audience')
                line=line.replace('@e[tag=gm.audience', '@e[tag=cs.person,tag=gm.audience')
            lines.append(line)
        path.write_text('\n'.join(lines)+'\n',encoding='utf-8')


if __name__=='__main__':
    suite=Suite();suite.build()
    raise SystemExit(run(suite,prefix='fimel-gomoku-seat-',setup_ticks=300,manual_tick=True,fixture_hook=fixture_hook))
