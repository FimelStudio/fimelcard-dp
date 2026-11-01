"""原版 26.2 测试基础围棋电脑：三档完整异步搜索、停一手、跨桌提交。"""
from test_weiqi_game import Suite as GameSuite, C, D, person, cell, fixture_hook
from test_guandan_cards import run


class Suite(GameSuite):
    def build(self):
        self.prepare()
        for level in (1,2,3):
            c=self.start(seats=(1,),size=19)+[f'scoreboard players set {C} go_level {level}']
            c+=self.score(C,'go_bot',1,f'level_{level}_bot_black')
            self.case(f'level_{level}_setup',c)
            # 每个case隔一tick，禁止把几十次完整试算挤进单条命令链。
            for tick in range(66):
                self.case(f'level_{level}_tick_{tick}',self.call('ai/tick'))
            c=self.score(C,'go_moves',1,f'level_{level}_made_move')+self.score(C,'go_turn',-1,f'level_{level}_human_turn')
            c+=self.count('@e[tag=go.square,scores={ct_id=101,go_piece=1}]',1,f'level_{level}_one_black_stone')
            c+=self.call('game/animation_done')+self.actor(1)+self.call('game/pass')
            for _ in range(12):c+=self.call('ai/tick')
            c+=self.score(C,'go_state',3,f'level_{level}_answers_pass')+self.score(C,'go_bconfirm',1,f'level_{level}_bot_score_confirmation')
            self.case(f'level_{level}_verify',c)
        # 两桌间夹入context切换，ready->commit仍只能操作自己的盘面。
        c=self.start(seats=(1,))+self.setup(table=202,reset=False)+self.call('game/start',202)
        c += [f'scoreboard players set {C} go_aibest 60',f'scoreboard players set {C} go_aiscore 20',f'scoreboard players operation {C} go_aiepoch = {C} go_epoch',f'scoreboard players set {C} go_aistate 2']
        c+=self.call('system/context',202)+self.call('ai/tick')
        c+=self.score(cell(60),'go_piece',1,'ready_commit_own_board')+self.score(cell(60,202),'go_piece',0,'ready_commit_other_board_untouched')+self.score(D,'go_moves',0,'ready_commit_other_history_untouched')
        self.case('context_isolation',c)
        # 搜索中epoch变化（真人悔棋/重载）会丢掉旧结果。
        c=self.start(seats=(1,))+self.call('ai/start')+[f'scoreboard players add {C} go_epoch 1']+self.call('ai/tick')
        c+=self.score(C,'go_aistate',0,'stale_epoch_cancels_ai')+self.score(C,'go_moves',0,'stale_epoch_no_move')
        self.case('stale_ai',c)
        # 无可落子的棋盘按规则停一手，而不是死循环。
        c=self.start(seats=(1,))+self.call('system/context')+['scoreboard players set @e[tag=go.board] go_piece 1']+self.call('ai/start')
        c += [f'scoreboard players set {C} go_aiwait 11']+self.call('ai/tick')+self.call('ai/tick')
        c+=self.score(C,'go_passes',1,'no_candidate_pass')+self.score(C,'go_turn',-1,'no_candidate_human_turn')
        self.case('no_candidate',c)
        # 人机已回复时一并撤回两手，且取消仍在准备的旧搜索。
        c=self.start(seats=(3,))+self.move(60)+self.call('game/animation_done')
        c += [f'scoreboard players set {C} go_aibest 61',f'scoreboard players set {C} go_aiscore 20',f'scoreboard players operation {C} go_aiepoch = {C} go_epoch']+self.call('ai/commit')+self.call('game/animation_done')
        c+=self.actor(1)+self.call('game/request_undo')+self.score(C,'go_moves',0,'bot_undo_two_turns')+self.score(C,'go_turn',1,'bot_undo_human_turn')
        c+=self.score(cell(60),'go_piece',0,'bot_undo_human_stone')+self.score(cell(61),'go_piece',0,'bot_undo_response_stone')+self.score(C,'go_aistate',0,'bot_undo_cancels_search')
        self.case('bot_undo',c)
        # 真人执白尚未落子，不能只撤回人机的开局一手来无限重抽。
        c=self.start(seats=(1,))+[f'scoreboard players set {C} go_aibest 60',f'scoreboard players set {C} go_aiscore 20',f'scoreboard players operation {C} go_aiepoch = {C} go_epoch']+self.call('ai/commit')+self.call('game/animation_done')
        c+=self.actor(1)+self.call('game/request_undo')+self.score(C,'go_moves',1,'no_human_turn_no_bot_undo')
        self.case('bot_opening_no_undo',c)
        self.finish()


if __name__=='__main__':
    s=Suite();s.build();raise SystemExit(run(s,isolated=False,prefix='fimel-weiqi-ai-',prepare_target=fixture_hook))
