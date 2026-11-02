"""揭棋整包验收：真实座椅、私密身份、悔棋、重载、设置与不透视人机。"""
from pathlib import Path
import test_xiangqi_seating as base

T, U, player = base.TABLE, base.OTHER, base.player


def square(i, table=101):
    return f'@e[type=minecraft:marker,tag=xq.square,scores={{ct_id={table},xq_sq={i}}},limit=1]'


class Suite(base.Suite):
    def start(self, cap=4, orient=0, table=101, reset=True, solo=False):
        seats={(4,0):(3,1),(4,1):(4,2),(8,0):(5,1),(8,1):(7,3)}[cap,orient]
        commands=self.setup(cap,orient,1,seats[:1] if solo else seats,table,reset)
        ctrl=T if table==101 else U
        commands += [f'scoreboard players set {ctrl} xq_variant 1']
        if solo:
            commands += [f'scoreboard players set {ctrl} ct_joined 1']
        return commands+self.call('game/start',table)+[f'scoreboard players set {ctrl} ct_state 1']

    def position(self, pieces, hidden=None, covered=None, table=101, reset=True, solo=False):
        commands=self.start(table=table,reset=reset,solo=solo)+self.call('system/context',table)
        commands += ['scoreboard players set @e[tag=xq.board] xq_piece 0',
                     'scoreboard players set @e[tag=xq.board] xq_covered 0']
        for i,p in {4:6,85:-6,40:1,**pieces}.items():
            commands += [f'scoreboard players set {square(i,table)} xq_piece {p}']
        commands += ['execute as @e[tag=xq.board] run scoreboard players operation @s xq_hidden = @s xq_piece']
        for i,p in (hidden or {}).items():
            commands += [f'scoreboard players set {square(i,table)} xq_hidden {p}']
        for i in (covered or []):
            commands += [f'scoreboard players set {square(i,table)} xq_covered 1']
        ctrl=T if table==101 else U
        commands += [f'data modify entity {ctrl} data.xiangqi.history set value []']
        return commands+self.call('engine/cache',table)+self.call('engine/history/record',table)+self.call('visual/refresh',table)

    def move(self, a,b,table=101):
        return self.call('game/snapshot',table)+[f'scoreboard players set #from xq_ctx {a}',f'scoreboard players set #to xq_ctx {b}']+self.call('engine/try_move',table)+self.call('game/animation_done',table)

    def build(self):
        super().build()
        for cap in (4,8):
            for orient in (0,1):
                name=f'covered_start_{cap}_{orient}'
                commands=self.start(cap,orient)
                commands += self.score(T,'ct_start',1,name+'_started')+self.score(T,'xq_variant',1,name+'_mode')
                commands += self.count('@e[tag=xq.square,scores={ct_id=101,xq_covered=1}]',30,name+'_thirty_dark')
                commands += self.board_sides(cap,orient,name)
                self.case(name,commands)

        commands=self.position({0:4,18:-4},hidden={0:2,18:-7},covered=[0,18])+self.move(0,18)
        commands += self.score(square(18),'xq_piece',2,'covered_real_move_reveals_horse')
        commands += self.check(f'data entity {T} data.xiangqi.undo.hidden[89]','undo_private_ninety')
        commands += self.check(f'data entity {T} data.xiangqi.undo.covered[89]','undo_cover_ninety')
        commands += [f'tag {player(1)} add xq.actor']+self.call('game/offer_undo')
        commands += [f'tag {player(1)} remove xq.actor',f'tag {player(2)} add xq.actor']+self.call('game/accept_undo')
        commands += self.score(square(0),'xq_piece',4,'undo_restores_dark_template')+self.score(square(0),'xq_hidden',2,'undo_restores_private_horse')
        commands += self.score(square(0),'xq_covered',1,'undo_covers_mover_again')
        commands += self.score(square(18),'xq_piece',-4,'undo_restores_captured_template')+self.score(square(18),'xq_hidden',-7,'undo_restores_captured_private_advisor')
        commands += self.score(square(18),'xq_covered',1,'undo_covers_captured_again')+self.score(T,'xq_turn',1,'covered_undo_restores_turn')
        self.case('covered_undo',commands)

        commands=self.position({0:4,81:-4},hidden={0:2,81:-7},covered=[0,81])+self.move(0,18)
        commands += ['function xiangqi:load']
        commands += self.score(square(18),'xq_piece',2,'reload_keeps_revealed_identity')+self.score(square(18),'xq_covered',0,'reload_keeps_revealed_face')
        commands += self.score(square(81),'xq_piece',-4,'reload_keeps_dark_template')+self.score(square(81),'xq_hidden',-7,'reload_keeps_private_identity')
        commands += self.score(square(81),'xq_covered',1,'reload_keeps_dark_face')+self.score(T,'xq_turn',-1,'covered_reload_keeps_turn')
        commands += self.count('@e[tag=xq.square,scores={ct_id=101}]',90,'covered_reload_ninety_markers')
        self.case('covered_reload',commands)

        # 两桌拥有完全一致的公开模板，但真实暗子身份不同。搜索的评分、候选
        # 与最佳走法必须完全相同；中途不允许翻牌或改变任何私密值。
        for level in (2,3):
            name=f'covered_blind_ai_{level}'
            commands=self.position({0:4,18:-4},hidden={0:1,18:-7},covered=[0,18])
            # Each table is started by a separate input in production. Keep its
            # two real start/preview/render passes in separate scheduled chains.
            self.case(name,commands+[f'schedule function xiangqi_seat_test:blind_setup/{name} 1t'])
            second=self.position({0:4,18:-4},hidden={0:7,18:-1},covered=[0,18],table=202,reset=False)
            self.file('blind_setup/'+name,second+[f'schedule function xiangqi_seat_test:blind_begin/{name} 1t'])
            begin=[]
            for table,ctrl in [(101,T),(202,U)]:
                begin += [f'scoreboard players set {ctrl} xq_level {level}']+self.call('system/context',table)+self.call('engine/cache',table)+self.call('ai/begin',table)
            self.file('blind_begin/'+name,begin+[f'schedule function xiangqi_seat_test:blind/{name} 1t'])
            wait=[]
            for table,ctrl in [(101,T),(202,U)]:
                probe=self.call('system/context',table)+self.call('engine/cache',table)
                probe += [f'execute if data entity {ctrl} data.xiangqi.ai.queue[0] run function xiangqi:ai/root_probe' for _ in range(8)]
                self.file(f'blind_probe/{name}_{table}',[f'execute as {ctrl} at @s run function xiangqi_seat_test:blind_raw/{name}_{table}'])
                self.file(f'blind_raw/{name}_{table}',probe)
                wait += [f'function xiangqi_seat_test:blind_probe/{name}_{table}']
            wait += [f'execute if data entity {T} data.xiangqi.ai.queue[0] run return run schedule function xiangqi_seat_test:blind/{name} 1t',
                     f'execute if data entity {U} data.xiangqi.ai.queue[0] run return run schedule function xiangqi_seat_test:blind/{name} 1t',
                     f'function xiangqi_seat_test:done/{name}']
            self.file('blind/'+name,wait)
            done=[f'data modify storage xiangqi_covered_test:comparison best set from entity {T} data.xiangqi.ai.best',
                  f'execute store success score #best_changed cs run data modify storage xiangqi_covered_test:comparison best set from entity {U} data.xiangqi.ai.best']
            done+=self.score('#best_changed','cs',0,name+'_same_public_best')
            done+=self.score(square(0),'xq_hidden',1,name+'_a_private_kept')+self.score(square(0,202),'xq_hidden',7,name+'_b_private_kept')
            done+=self.score(square(0),'xq_covered',1,name+'_a_not_flipped')+self.score(square(0,202),'xq_covered',1,name+'_b_not_flipped')
            self.file('done/'+name,done)

        name='covered_solo_ai_commit'
        commands=self.position({81:-4,63:4},hidden={81:-2,63:7},covered=[81,63],solo=True)
        commands += [f'scoreboard players set {T} xq_turn -1',f'scoreboard players set {T} xq_level 2','scoreboard players set #covered_ai_ticks cs 0']
        commands += self.call('ai/reset')+[f'schedule function xiangqi_seat_test:covered_ai/{name} 1t']
        self.case(name,commands)
        wait=['scoreboard players add #covered_ai_ticks cs 1']+self.call('ai/tick')
        wait += [f'execute if score {T} xq_state matches 1 if score #covered_ai_ticks cs matches ..249 run return run schedule function xiangqi_seat_test:covered_ai/{name} 1t',
                 f'function xiangqi_seat_test:done/{name}']
        self.file('covered_ai/'+name,wait)
        done=self.score('#covered_ai_ticks','cs','..249','solo_dark_ai_search_bounded')
        done+=self.score(T,'xq_turn',1,'solo_dark_ai_commits_turn')+self.score(square(63),'xq_piece',-2,'solo_dark_ai_reveals_own_real_piece')
        done+=self.score(square(63),'xq_covered',0,'solo_dark_ai_turns_piece_face_up')
        done+=self.check(f'data entity {T} data.xiangqi.last{{from:81,to:63,was_covered:1,captured_covered:1,captured:4}}','solo_dark_ai_commit_metadata')
        self.file('done/'+name,done)

        commands=self.position({0:4},hidden={0:2},covered=[0])
        commands += [f'scoreboard players set {T} xq_bot -1']+self.move(0,18)
        # Simulate a real bot reply through the same commit boundary; the saved
        # human undo must include both private identities and both cover flags.
        commands += [f'scoreboard players set {square(81)} xq_piece -4',f'scoreboard players set {square(81)} xq_hidden -7',f'scoreboard players set {square(81)} xq_covered 1']
        commands += self.move(81,72)+[f'tag {player(1)} add xq.actor']+self.call('game/offer_undo')
        commands += self.score(square(0),'xq_piece',4,'solo_undo_restores_nominal_rook')+self.score(square(0),'xq_hidden',2,'solo_undo_restores_hidden_horse')
        commands += self.score(square(0),'xq_covered',1,'solo_undo_recovers_cover')+self.score(T,'xq_turn',1,'solo_covered_undo_back_to_human')
        self.case('covered_solo_undo',commands)

        # Upgrade an existing standard board without the new objectives' per-cell
        # values, then preserve it through the real reload entry.
        commands=self.setup(mode=1,seats=(3,1))+self.call('game/start')+[f'scoreboard players set {T} ct_state 1']
        commands += [f'scoreboard players reset {T} xq_variant','scoreboard players reset @e[tag=xq.square] xq_hidden','scoreboard players reset @e[tag=xq.square] xq_covered','function xiangqi:load']
        commands += self.score(T,'xq_variant',0,'old_board_defaults_standard')+self.score(square(0),'xq_hidden',4,'old_board_private_defaults_public')
        commands += self.count('@e[tag=xq.square,scores={ct_id=101,xq_covered=1}]',0,'old_standard_board_not_hidden')
        self.case('covered_upgrade_old_standard',commands)

        def session(nonce=100000):
            return [f'scoreboard players operation {player(1)} xq_nonce = #ui_load xq_ctx',
                    f'scoreboard players set {player(1)} xq_setnonce {nonce}',
                    f'scoreboard players set {player(1)} xq_set_table 101',
                    f'scoreboard players operation {player(1)} xq_setepoch = {T} xq_epoch']

        def submit(mode,nonce=100000):
            return [f'scoreboard players set {player(1)} xq_settings {nonce*1000+800+mode}',
                    f'execute as {player(1)} at @s run function xiangqi:settings/save']

        commands=self.start()+[f'scoreboard players set {T} ct_state 0',f'scoreboard players set {T} xq_variant 0',
                               f'data modify entity {T} data.xiangqi.review set value 1b',f'scoreboard players set {square(0)} xq_piece 0']
        commands+=session()+submit(1)+self.score(T,'xq_variant',1,'settings_eight_enables_covered')
        commands+=self.count('@e[tag=xq.square,scores={ct_id=101,xq_covered=1}]',30,'settings_eight_resets_to_covered_preview')
        commands += [f'execute store success score #review_exists cs if data entity {T} data.xiangqi.review']
        commands+=self.score('#review_exists','cs',0,'changing_variant_discards_old_review')
        commands+=submit(0)+self.score(T,'xq_variant',1,'variant_settings_replay_rejected')
        commands+=session(100001)+submit(0,100001)+self.score(T,'xq_variant',0,'settings_eight_restores_standard')
        commands+=self.count('@e[tag=xq.square,scores={ct_id=101,xq_covered=1}]',0,'standard_preview_has_no_dark_pieces')
        self.case('covered_settings_variant',commands)

        commands=self.start()+[f'scoreboard players set {T} ct_state 0']+session()
        commands += [f'scoreboard players add {T} xq_epoch 1']+submit(0)
        commands+=self.score(T,'xq_variant',1,'variant_setting_old_epoch_rejected')
        self.case('covered_settings_stale',commands)

        for index,name in enumerate(self.cases):
            key=('done/' if 'done/'+name in self.files else 'case/')+name
            lines=self.files[key].splitlines()
            lines=[line for line in lines if not line.startswith('schedule function xiangqi_seat_test:case/') and line!='schedule function xiangqi_seat_test:finish 2t']
            lines+=['schedule function xiangqi_seat_test:'+('case/'+self.cases[index+1] if index+1<len(self.cases) else 'finish')+' 2t']
            self.file(key,lines)


if __name__=='__main__':
    # Neither the search nor the move hint implementation may read private IDs.
    root=Path(__file__).resolve().parents[1]/'data/xiangqi/function'
    for folder in ['ai','hints']:
        for path in (root/folder).rglob('*.mcfunction'):
            assert 'xq_hidden' not in path.read_text(encoding='utf-8'),path
    suite=Suite();suite.build()
    raise SystemExit(base.main(suite,prefix='fimel-xiangqi-covered-',setup_ticks=700,manual_tick=True,heap_mb=3072))
