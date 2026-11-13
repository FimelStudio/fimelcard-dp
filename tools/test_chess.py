"""国际象棋整包原版26.2 GameTest；独立临时世界，不读取或改写玩家存档。

使用 marker 模拟后台参与者，覆盖真实规则、动画、时钟、悔棋、和棋及公共接入。
真人右键、Q投掷与客户端模型的视觉效果另需游戏内复测。
"""
from pathlib import Path
import argparse
import json
import re
import shutil
import subprocess
import tempfile
import time

PACK = Path(__file__).resolve().parents[1]
A = '@e[type=minecraft:marker,tag=cg.table,scores={ct_id=101},limit=1]'
B = '@e[type=minecraft:marker,tag=cg.table,scores={ct_id=202},limit=1]'


def person(side, table=101):
    return f'@e[type=minecraft:marker,tag=ch.player,scores={{ch_table={table},ch_side={side}}},limit=1]'


def square(sq, table=101):
    return f'@e[type=minecraft:marker,tag=ch.square,scores={{ct_id={table},ch_sq={sq}}},limit=1]'


class Suite:
    def __init__(self):
        self.files, self.cases, self.expected = {}, [], []

    def file(self, name, lines):
        self.files[name] = ('\n'.join(lines) if isinstance(lines, list) else lines).strip() + '\n'

    def check(self, condition, name):
        assert name not in self.expected, name
        self.expected.append(name)
        return [f'execute if {condition} run say CHESS_GAME_PASS {name}', f'execute unless {condition} run say CHESS_GAME_FAIL {name}']

    def score(self, target, objective, value, name):
        return self.check(f'score {target} {objective} matches {value}', name)

    def count(self, selector, value, name):
        return ['scoreboard players set #count cg 0', f'execute as {selector} run scoreboard players add #count cg 1'] + self.score('#count','cg',value,name)

    def call(self, name, table=101):
        return [f'execute as {A if table==101 else B} at @s run function chess:{name}']

    def setup(self, cap=4, table=101, reset=True):
        return (['function chess_game_test:reset'] if reset else []) + [
            f'execute positioned {8 if table==101 else 40} 64 8 summon minecraft:marker run function chess_game_test:table {{table:{table},cap:{cap}}}']

    def actor(self, side, table=101):
        return ['tag @e[tag=ch.actor] remove ch.actor', f'tag {person(side,table)} add ch.actor']

    def click(self, side, target, table=101):
        return self.actor(side,table) + [f'scoreboard players set #target ch_ctx {target}'] + self.call('game/click',table)

    def move(self, side, source, target):
        return self.click(side,source) + self.click(side,target) + self.call('game/animation_done')

    def position(self, fen, turn=1, castle=0, ep=-1):
        result=self.setup()+self.call('system/context')+['scoreboard players set @e[tag=ch.board] ch_piece 0']
        pieces={'p':1,'n':2,'b':3,'r':4,'q':5,'k':6}
        for rank,row in enumerate(fen.split('/')):
            file=0
            for char in row:
                if char.isdigit(): file+=int(char);continue
                sq=(7-rank)*8+file
                result+=[f'scoreboard players set {square(sq)} ch_piece {pieces[char.lower()] * (1 if char.isupper() else -1)}']
                file+=1
        result += [f'scoreboard players set {A} ch_turn {turn}',f'scoreboard players set {A} ch_castle {castle}',f'scoreboard players set {A} ch_ep {ep}',f'data modify entity {A} data.chess.history set value []']
        return result+self.call('engine/cache')+self.call('engine/history/record')+self.call('visual/refresh')

    def case(self, name, lines):
        self.cases.append(name)
        self.file('case/'+name,lines)

    def build(self):
        self.file('reset',['kill @e[tag=ch.visual]','kill @e[tag=ch.square]','kill @e[tag=cg.fixture]','kill @e[tag=ct.menu]','kill @e[tag=ct.vote]'])
        self.file('table','''
tag @s add cg.fixture
tag @s add cg.table
tag @s add ct.controller
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ct_capacity $(cap)
scoreboard players set @s ct_game 12
scoreboard players set @s ct_state 0
scoreboard players set @s ct_joined 2
function chess:game/init_table
scoreboard players set @s ch_state 1
scoreboard players set @s ct_state 1
scoreboard players set @s ch_wtime 12000
scoreboard players set @s ch_btime 12000
scoreboard players set @s ch_white 3
scoreboard players set @s ch_black 1
scoreboard players set @s ch_pulse -1000
$execute summon minecraft:marker run function chess_game_test:person {table:$(table),side:1,seat:3}
$execute summon minecraft:marker run function chess_game_test:person {table:$(table),side:-1,seat:1}
function chess:system/context
function chess:clock/create
''')
        self.file('person','''
tag @s add cg.fixture
tag @s add ch.player
tag @s add ct.player
$scoreboard players set @s ch_side $(side)
$scoreboard players set @s ch_seat $(seat)
$scoreboard players set @s ct_seat $(seat)
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ch_table $(table)
''')
        for cap in (4,8):
            c=self.setup(cap)
            c+=self.count('@e[tag=ch.tile,scores={ct_id=101}]',64,f'preview_{cap}_cells')
            c+=self.count('@e[tag=ch.man,scores={ct_id=101}]',32,f'preview_{cap}_pieces')
            c+=self.count('@e[tag=ch.square,scores={ct_id=101}]',64,f'preview_{cap}_rule_squares')
            c+=self.count('@e[tag=ch.clock,scores={ct_id=101}]',1,f'clock_{cap}_one')
            self.case('preview_'+str(cap),c)
        c=self.setup()+self.click(1,12)+self.score(A,'ch_sel',12,'select_pawn')+self.click(1,6)+self.score(A,'ch_sel',6,'reselect_knight')
        c+=self.click(-1,52)+self.score(A,'ch_sel',6,'wrong_turn_cannot_change_selection')
        c+=self.click(1,36)+self.score(A,'ch_sel',-1,'illegal_clears_selection')+self.score(square(6),'ch_piece',2,'illegal_keeps_knight')
        self.case('selection',c)
        c=self.setup()+self.click(1,12)+self.click(1,28)
        c+=self.score(A,'ch_state',2,'move_locks_animation')+self.score(A,'ch_timer',8,'move_eight_ticks')+self.score(A,'ch_turn',-1,'move_turn_black')
        c+=self.score(square(12),'ch_piece',0,'move_source_empty')+self.score(square(28),'ch_piece',1,'move_destination_pawn')
        c+=self.check(f'data entity {A} data.chess.last{{from:12,to:28,piece:1}}','move_last_metadata')
        for _ in range(8): c+=self.call('system/tick')
        c+=self.score(A,'ch_state',1,'animation_unlocks')+self.score(A,'ch_wtime',12000,'animation_preserves_white_clock')+self.score(A,'ch_btime',12000,'animation_preserves_black_clock')
        c+=self.call('system/tick')+self.score(A,'ch_btime',11999,'black_clock_ticks')+self.score(A,'ch_wtime',12000,'waiting_white_clock_paused')
        self.case('move_and_clocks',c)
        c=self.setup()+[f'scoreboard players set {A} ch_time 0']+self.call('clock/tick')+self.score(A,'ch_wtime',12000,'unlimited_clock_unchanged')
        c+=[f'scoreboard players set {A} ch_state 3',f'scoreboard players set {A} ch_time 10']+self.call('clock/tick')+self.score(A,'ch_wtime',11999,'promotion_clock_ticks')
        self.case('clock_modes',c)
        c=self.setup()+self.move(1,12,28)+self.actor(1)+self.call('game/offer_undo')+self.score(A,'ch_undo',1,'undo_request_white')
        c+=self.call('game/accept_undo')+self.score(square(28),'ch_piece',1,'cannot_accept_own_undo')
        c+=self.actor(-1)+self.call('game/accept_undo')+self.score(square(12),'ch_piece',1,'undo_restores_source')+self.score(square(28),'ch_piece',0,'undo_clears_destination')
        c+=self.score(A,'ch_turn',1,'undo_restores_turn')+self.score(A,'ch_ep',-1,'undo_restores_ep')+self.score(A,'ch_castle',15,'undo_restores_castling')
        c+=self.score(A,'ch_wtime',12000,'undo_restores_clock')+self.score(A,'ch_undo',0,'undo_clears_request')
        c+=self.check(f'data entity {A} data.chess.history[0]','undo_keeps_history')
        c+=self.count('@e[tag=ch.man,scores={ct_id=101}]',32,'undo_restores_visuals')
        self.case('undo_agreement',c)
        c=self.setup()+self.move(1,12,28)+self.move(-1,51,35)+self.move(1,28,35)
        c+=self.score(A,'ch_wcapt',1,'capture_count')+self.count('@e[tag=ch.captured,scores={ct_id=101}]',1,'capture_display')
        c+=['schedule function chess_game_test:undo_capture_restore 1t']
        restore=self.actor(1)+self.call('game/offer_undo')+self.actor(-1)+self.call('game/accept_undo')
        restore+=self.score(square(28),'ch_piece',1,'undo_capture_white_restored')+self.score(square(35),'ch_piece',-1,'undo_capture_black_restored')
        restore+=self.score(A,'ch_wcapt',0,'undo_capture_count')+self.count('@e[tag=ch.captured,scores={ct_id=101}]',0,'undo_capture_visual_restored')
        self.file('undo_capture_restore',restore)
        self.case('undo_capture',c)
        c=self.setup()+self.move(1,12,28)+self.actor(1)+self.call('game/offer_undo')+self.actor(-1)+self.call('game/decline_undo')
        c+=self.score(A,'ch_undo',0,'decline_undo_clears')+self.score(square(28),'ch_piece',1,'decline_undo_keeps_board')
        self.case('undo_decline',c)
        # 特殊走法的悔棋必须还原易位车、过路兵及升变棋种，而非只把目标子移回。
        c=self.position('4k3/8/8/8/8/8/8/R3K2R',castle=3)+self.move(1,4,6)
        c+=self.score(square(5),'ch_piece',4,'castle_rook_moved')+['schedule function chess_game_test:undo_castle_restore 1t']
        restore=self.actor(1)+self.call('game/offer_undo')+self.actor(-1)+self.call('game/accept_undo')
        restore+=self.score(square(4),'ch_piece',6,'undo_castle_king')+self.score(square(7),'ch_piece',4,'undo_castle_rook')+self.score(square(5),'ch_piece',0,'undo_castle_rook_target_empty')+self.score(A,'ch_castle',3,'undo_castle_rights')
        self.file('undo_castle_restore',restore);self.case('undo_castle',c)
        c=self.position('4k3/8/8/3pP3/8/8/8/4K3',ep=43)+self.move(1,36,43)
        c+=self.score(square(35),'ch_piece',0,'ep_captures_adjacent_pawn')+['schedule function chess_game_test:undo_ep_restore 1t']
        restore=self.actor(1)+self.call('game/offer_undo')+self.actor(-1)+self.call('game/accept_undo')
        restore+=self.score(square(36),'ch_piece',1,'undo_ep_white_pawn')+self.score(square(35),'ch_piece',-1,'undo_ep_black_pawn')+self.score(square(43),'ch_piece',0,'undo_ep_target_empty')+self.score(A,'ch_ep',43,'undo_ep_right')
        self.file('undo_ep_restore',restore);self.case('undo_ep',c)
        c=self.position('4k2r/P7/8/8/8/8/8/4K3')+self.click(1,48)+self.click(1,56)
        c+=self.score(A,'ch_state',3,'promotion_pending_phase')+self.score(square(48),'ch_piece',1,'promotion_pending_no_board_change')
        c+=self.call('clock/tick')+self.actor(1)+['scoreboard players set #promo ch_ctx 2']+self.call('game/promote')+self.call('game/animation_done')
        c+=self.score(square(56),'ch_piece',2,'promotion_knight_committed')+['schedule function chess_game_test:undo_promotion_restore 1t']
        restore=self.actor(1)+self.call('game/offer_undo')+self.actor(-1)+self.call('game/accept_undo')
        restore+=self.score(square(48),'ch_piece',1,'undo_promotion_restores_pawn')+self.score(square(56),'ch_piece',0,'undo_promotion_clears_rank_eight')+self.score(A,'ch_wtime',11999,'undo_promotion_keeps_thinking_time')
        self.file('undo_promotion_restore',restore);self.case('undo_promotion',c)
        c=self.setup()+self.actor(1)+self.call('game/offer_draw')+self.call('game/accept_draw')+self.score(A,'ch_state',1,'cannot_accept_own_draw')
        c+=self.actor(-1)+self.call('game/accept_draw')+self.score(A,'ch_state',4,'draw_agreed_finish')+self.score(A,'ch_result',3,'draw_agreed_result')+self.score(A,'ch_reason',8,'draw_agreed_reason')
        self.case('draw_agreement',c)
        c=self.setup()+self.actor(1)+self.call('game/offer_draw')+self.actor(-1)+self.call('game/decline_draw')+self.score(A,'ch_draw',0,'draw_declined')+self.score(A,'ch_state',1,'draw_declined_continues')
        self.case('draw_decline',c)
        c=self.setup()+self.move(1,12,28)+self.actor(1)
        c += [f'scoreboard players operation {person(1)} ch_seen = {A} ch_epoch', f'scoreboard players operation {person(1)} ch_ui_load = #ui_load ch_ctx',
              f'scoreboard players operation {person(1)} ch_action = {A} ch_epoch','scoreboard players set #hundred cg 100',
              f'scoreboard players operation {person(1)} ch_action *= #hundred cg',f'scoreboard players add {person(1)} ch_action 6',
              f'execute as {person(1)} at @s run function chess:input/submit']
        c+=self.score(A,'ch_undo',1,'trigger_requests_undo')
        # 申请推进epoch后，旧面板中的另一方同意按钮必须失效。
        c+=self.actor(-1)+[f'scoreboard players operation {person(-1)} ch_seen = {person(1)} ch_seen',f'scoreboard players operation {person(-1)} ch_ui_load = #ui_load ch_ctx',
             f'scoreboard players operation {person(-1)} ch_action = {person(1)} ch_seen',f'scoreboard players operation {person(-1)} ch_action *= #hundred cg',f'scoreboard players add {person(-1)} ch_action 7',f'execute as {person(-1)} at @s run function chess:input/submit']
        c+=self.score(square(28),'ch_piece',1,'stale_trigger_cannot_undo')+self.score(A,'ch_undo',1,'stale_trigger_keeps_pending_request')
        self.case('input_nonces',c)
        # 原生产 save 路径：有效0/5/30、非法步长与四座越界，均以完整会话提交。
        for value in (0,5,30,7):
            c=self.setup()+[f'scoreboard players set {A} ct_state 0', f'scoreboard players operation {person(1)} ch_nonce = #ui_load ch_ctx',
                f'scoreboard players set {person(1)} ch_setnonce 100000',f'scoreboard players set {person(1)} ch_set_table 101',
                f'scoreboard players operation {person(1)} ch_setepoch = {A} ch_epoch',f'scoreboard players set {person(1)} ch_settings {int("1000005"+str(value))}',
                f'execute as {person(1)} at @s run function chess:settings/save']
            c+=self.score(A,'ch_time',10 if value==7 else value,'time_setting_'+str(value))
            self.case('time_setting_'+str(value),c)
        c=self.setup()+[f'scoreboard players set {A} ct_state 0',f'scoreboard players operation {person(1)} ch_nonce = #ui_load ch_ctx',f'scoreboard players set {person(1)} ch_setnonce 100000',f'scoreboard players set {person(1)} ch_set_table 101',f'scoreboard players operation {person(1)} ch_setepoch = {A} ch_epoch',f'scoreboard players set {person(1)} ch_settings 10000048',f'execute as {person(1)} at @s run function chess:settings/save']
        c+=self.score(A,'ch_first',0,'first_setting_rejects_nonexistent_seat')
        self.case('first_setting_bounds',c)
        c=self.setup()+self.actor(1)+self.call('game/resign')+self.score(A,'ch_result',2,'white_resigns_black_wins')+self.score(A,'ch_reason',7,'resign_reason')
        self.case('resign',c)
        c=self.setup()+[f'scoreboard players set {A} ch_wtime 1']+self.call('clock/tick')+self.score(A,'ch_state',4,'timeout_finishes')+self.score(A,'ch_result',2,'timeout_white_loses')+self.score(A,'ch_reason',6,'timeout_reason')
        self.case('timeout',c)
        c=self.setup()+self.actor(1)+self.call('game/claim_draw')+self.score(A,'ch_state',1,'premature_claim_rejected')
        c+=[f'scoreboard players set {A} ch_half 100']+self.call('game/claim_draw')+self.score(A,'ch_result',3,'fifty_claim_result')+self.score(A,'ch_reason',10,'fifty_claim_reason')
        self.case('draw_claim',c)
        c=self.position('7k/5Q2/6K1/8/8/8/8/8',turn=-1)+self.call('engine/evaluate')+self.score(A,'ch_result',3,'integrated_stalemate_draw')+self.score(A,'ch_reason',2,'integrated_stalemate_reason')
        self.case('stalemate',c)
        c=self.setup()+self.move(1,12,28)+[f'scoreboard players set {A} ch_btime 9876']+self.call('system/reload')
        c+=self.score(square(28),'ch_piece',1,'reload_keeps_board')+self.score(A,'ch_turn',-1,'reload_keeps_turn')+self.score(A,'ch_btime',9876,'reload_keeps_clock')+self.score(A,'ch_ep',20,'reload_keeps_ep')
        c+=self.check(f'data entity {A} data.chess.undo.board[12]','reload_keeps_undo')+self.count('@e[tag=ch.clock,scores={ct_id=101}]',1,'reload_one_clock')
        self.case('reload',c)
        c=self.setup()+self.move(1,12,28)+['scoreboard objectives remove ch_first','scoreboard objectives remove ch_undo']
        c += ['scoreboard objectives remove '+name for name in ('ch_bot','ch_level','ch_hints','ch_aistate','ch_aiwait','ch_aiepoch')]
        c += ['scoreboard players set #version ch_ctx 1','function chess:load']
        c+=self.score('#version','ch_ctx',3,'migration_version')+self.score(A,'ch_first',0,'migration_adds_first')+self.score(A,'ch_undo',0,'migration_adds_undo')
        c+=self.score(A,'ch_bot',0,'migration_keeps_pvp')+self.score(A,'ch_level',2,'migration_normal_ai_default')+self.score(A,'ch_hints',1,'migration_enables_hints')
        c+=self.score(square(28),'ch_piece',1,'migration_keeps_board')+self.score(A,'ch_turn',-1,'migration_keeps_turn')+self.check(f'data entity {A} data.chess.undo.board[12]','migration_keeps_undo_snapshot')
        self.case('migration_v1',c)
        c=self.setup()+self.setup(table=202,reset=False)+self.click(1,12,202)+self.click(1,28,202)
        c+=self.score(square(12),'ch_piece',1,'table_b_preserves_a')+self.score(square(28,202),'ch_piece',1,'table_b_moves_b')
        c+=self.actor(1,202)+['scoreboard players set #target ch_ctx 12']+self.call('game/click')+self.score(A,'ch_sel',-1,'foreign_actor_rejected')
        c+=self.call('game/remove')+self.count('@e[tag=ch.square,scores={ct_id=101}]',0,'remove_clears_own_rules')+self.count('@e[tag=ch.visual,scores={ct_id=101}]',0,'remove_clears_own_visuals')+self.count('@e[tag=ch.square,scores={ct_id=202}]',64,'remove_preserves_other_rules')
        self.case('isolation',c)
        c=self.setup()+self.call('game/abort')+self.score(A,'ct_state',0,'abort_returns_lobby')+self.score(A,'ch_state',0,'abort_resets_phase')
        c+=self.count('@e[tag=ch.man,scores={ct_id=101}]',32,'abort_restores_preview')+self.count('@e[tag=ch.clock,scores={ct_id=101}]',0,'abort_removes_clock')
        self.case('abort',c)
        # 正常结算返回大厅保留最终棋面；重载或设置重建均不得重新摆开局。
        c=self.setup()+self.move(1,12,28)+[f'scoreboard players set {A} ch_result 3',f'scoreboard players set {A} ch_reason 8']+self.call('game/finish')
        c += [f'scoreboard players set {A} ch_timer 1'] + self.call('game/result_tick')
        c += self.score(A,'ct_state',0,'review_returns_lobby')+self.score(A,'ch_state',0,'review_stops_game')
        c += self.check(f'data entity {A} data.chess{{review:1b}}','review_flag_persisted')
        c += self.score(square(28),'ch_piece',1,'review_keeps_final_pawn')+self.score(square(12),'ch_piece',0,'review_keeps_empty_source')
        c += self.count('@e[tag=ch.clock,scores={ct_id=101}]',0,'review_removes_clock')
        c += self.count('@e[tag=ch.hint,scores={ct_id=101}]',0,'review_removes_hints')
        c += self.count('@e[type=minecraft:interaction,tag=ct.menu,scores={ct_id=101,ct_kind=23}]',1,'review_restores_settings_button')
        c += self.call('system/reload')+self.score(square(28),'ch_piece',1,'review_reload_keeps_final_pawn')
        c += [f'scoreboard players set {A} ch_palette 2']+self.call('game/preview')
        c += self.score(square(28),'ch_piece',1,'review_appearance_keeps_final_pawn')
        c += self.call('game/remove')+self.count('@e[tag=ch.square,scores={ct_id=101}]',0,'review_switch_clears_rules')
        c += [f'execute store success score #review cg if data entity {A} data.chess.review']+self.score('#review','cg',0,'review_switch_clears_flag')
        self.case('final_board_review',c)
        c=self.setup()+[f'execute as {A} at @s run function cardtable:table/remove']+self.count('@e[tag=ch.square,scores={ct_id=101}]',0,'delete_table_removes_rules')+self.count('@e[tag=ch.visual,scores={ct_id=101}]',0,'delete_table_removes_visuals')
        self.case('delete_table',c)
        c=self.setup()+[f'scoreboard players set {A} ct_state 0','scoreboard players set #pick_choice ct_ctx 11',f'execute as {A} at @s run function cardtable:menu/select_game']
        c+=self.score(A,'ct_game',11,'switch_to_uno')+self.count('@e[tag=ch.square,scores={ct_id=101}]',0,'switch_clears_rules')+self.count('@e[tag=ch.visual,scores={ct_id=101}]',0,'switch_clears_preview')
        self.case('switch',c)
        # 执行真实公共分发器：国际象棋及已有游戏均不得落入缺少界面的兜底。
        # 测试副本只记录入口和兜底次数，不替换实际窗口行为。
        for game in (12, 11, 0):
            c=self.setup()+[f'scoreboard players set {A} ct_state 0', f'scoreboard players set {A} ct_game {game}']
            for kind, entry in [('settings', 'open_settings'), ('rules', 'open_rules')]:
                c += [f'scoreboard players set #route_{kind} cg 0',
                      f'scoreboard players set #missing_{kind} cg 0',
                      f'execute as {A} at @s run function cardtable:game/{entry}']
                c += self.score(f'#route_{kind}', 'cg', 1 if game == 12 else 0, f'route_{game}_{kind}_entry')
                c += self.score(f'#missing_{kind}', 'cg', 1 if game == 0 else 0, f'route_{game}_{kind}_fallback')
            self.case(f'routes_{game}',c)
        # 真实 Dialog codec 解析：无在线玩家时仍会先解析整条命令。
        self.case('dialogs',['function chess_game_test:dialogs','say CHESS_GAME_DIALOGS_DONE'])
        self.file('dialogs',(PACK/'tools/test_chess_dialogs.mcfunction').read_text(encoding='utf-8'))
        self.file('finish',['function chess_game_test:reset','say CHESS_GAME_FINISHED'])
        self.file('bootstrap',['forceload add -16 -16 63 31','scoreboard objectives add cg dummy','schedule function chess_game_test:case/'+self.cases[0]+' 40t'])
        for i,name in enumerate(self.cases):
            self.files['case/'+name]+='schedule function chess_game_test:'+('case/'+self.cases[i+1] if i+1<len(self.cases) else 'finish')+' 3t\n'


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--java',type=Path,default=Path('C:/Temp/fimel-uno-java25/jdk-25.0.5+8-jre/bin/java.exe'))
    parser.add_argument('--minecraft-root',type=Path,default=Path('D:/PCL2/MinecraftPcl'))
    parser.add_argument('--version',default='26.2-Fabric_0.19.3')
    args=parser.parse_args()
    output=Path(tempfile.mkdtemp(prefix='fimel-chess-game-'))
    target=output/'packs/fimel_cards'
    shutil.copytree(PACK/'data',target/'data')
    shutil.copy2(PACK/'pack.mcmeta',target/'pack.mcmeta')
    suite=Suite();suite.build()
    for kind, entry, endpoint in [('settings', 'open_settings', 'settings/open'), ('rules', 'open_rules', 'rules/show')]:
        common = target / f'data/cardtable/function/game/{entry}.mcfunction'
        body = common.read_text(encoding='utf-8')
        fallback = next(line for line in body.splitlines() if '当前游戏没有提供' in line)
        suite.file('missing_'+kind, [f'scoreboard players add #missing_{kind} cg 1', fallback])
        common.write_text(body.replace(fallback, 'function chess_game_test:missing_'+kind), encoding='utf-8')
        function = target / f'data/chess/function/{endpoint}.mcfunction'
        function.write_text(f'scoreboard players add #route_{kind} cg 1\n'+function.read_text(encoding='utf-8'), encoding='utf-8')
    for name,body in suite.files.items():
        dest=target/'data/chess_game_test/function'/(name+'.mcfunction');dest.parent.mkdir(parents=True,exist_ok=True);dest.write_text(body,encoding='utf-8')
    for name,body in {
        'test_environment/default.json':{'type':'minecraft:function','setup':'chess_game_test:bootstrap'},
        'test_instance/game.json':{'type':'minecraft:function','environment':'chess_game_test:default','function':'minecraft:always_pass','max_ticks':1,'setup_ticks':240,'required':True,'structure':'minecraft:empty'},
    }.items():
        dest=target/'data/chess_game_test'/name;dest.parent.mkdir(parents=True,exist_ok=True);dest.write_text(json.dumps(body),encoding='utf-8')
    launch=args.minecraft_root/'versions'/args.version/(args.version+'.json')
    meta=json.loads(launch.read_text(encoding='utf-8-sig'));classpath=[launch.with_suffix('.jar')]
    for lib in meta['libraries']:
        entry=lib.get('downloads',{}).get('artifact',{})
        if entry.get('path'):
            path=args.minecraft_root/'libraries'/entry['path']
            if path.is_file(): classpath.append(path)
    options=['-Xms256M','-Xmx1536M','-Djava.awt.headless=true','-Dfile.encoding=UTF-8','--enable-native-access=ALL-UNNAMED','-cp',';'.join(map(str,classpath)),'net.minecraft.gametest.Main','--packs',str(output/'packs'),'--universe',str(output/'universe'),'--tests','chess_game_test:*','--report',str(output/'gametest.xml')]
    argfile=output/'java-args.txt';argfile.write_text('\n'.join('"'+v.replace('\\','\\\\').replace('"','\\"')+'"' for v in options),encoding='utf-8')
    print('Chess integration GameTest: '+str(output),flush=True);start=time.monotonic()
    proc=subprocess.run([str(args.java),'@'+str(argfile)],cwd=output,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True,encoding='utf-8',errors='replace',timeout=180)
    (output/'game.log').write_text(proc.stdout,encoding='utf-8')
    passed=set(re.findall(r'CHESS_GAME_PASS ([a-z0-9_]+)',proc.stdout));failed=sorted(set(re.findall(r'CHESS_GAME_FAIL ([a-z0-9_]+)',proc.stdout)))
    errors=[line for line in proc.stdout.splitlines() if any(s in line for s in ['[ERROR]','/ERROR]','Failed to load','Failed to parse','Unknown function','Unknown or incomplete command',"Couldn't parse",'Command execution stopped'])]
    result={'exit_code':proc.returncode,'seconds':round(time.monotonic()-start,1),'assertions':len(suite.expected),'passed':len(passed),'failed':failed,'missing':sorted(set(suite.expected)-passed),'errors':errors,'finished':'CHESS_GAME_FINISHED' in proc.stdout,'dialogs':'CHESS_DIALOGS_END' in proc.stdout,'output':str(output)}
    (output/'result.json').write_text(json.dumps(result,ensure_ascii=False,indent=2),encoding='utf-8');print(json.dumps(result,ensure_ascii=False,indent=2),flush=True)
    return int(bool(proc.returncode or failed or result['missing'] or errors or not result['finished'] or not result['dialogs']))


if __name__=='__main__':
    raise SystemExit(main())
