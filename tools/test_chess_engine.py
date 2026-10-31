"""独立原版26.2 GameTest：真实执行国际象棋规则函数，不触碰玩家存档。

只复制 engine/，以测试适配器替代棋盘创建/动画回调；完整生命周期另行验收。
可选 --oracle-path 指向安装了 python-chess 的目录，追加确定种子随机局面差分。
"""
from __future__ import annotations

import argparse
import json
import random
import re
import shutil
import subprocess
import sys
import tempfile
import time
from pathlib import Path

PACK = Path(__file__).resolve().parents[1]
C = '@e[type=minecraft:marker,tag=ce.controller,scores={ct_id=101},limit=1]'


def square(name):
    return ord(name[0])-97 + (int(name[1])-1)*8


def cell(name):
    n = square(name) if isinstance(name, str) else name
    return f'@e[type=minecraft:marker,tag=ch.square,scores={{ct_id=101,ch_sq={n}}},limit=1]'


class Suite:
    def __init__(self):
        self.files = {}
        self.cases = []
        self.expected = []

    def file(self, name, text):
        self.files[name] = ('\n'.join(text) if isinstance(text, list) else text).strip()+'\n'

    def case(self, name, commands):
        self.cases.append(name)
        self.file('case/'+name, commands)

    def check(self, condition, name):
        assert name not in self.expected, name
        self.expected.append(name)
        return [f'execute if {condition} run function chess_engine_test:pass {{name:"{name}"}}', f'execute unless {condition} run function chess_engine_test:fail {{name:"{name}"}}']

    def score(self, who, objective, value, name):
        return self.check(f'score {who} {objective} matches {value}', name)

    def piece(self, at, value, name):
        return self.score(cell(at), 'ch_piece', value, name)

    def setup(self, fen=None, turn=1, castle=0, ep=-1, half=0):
        commands = ['function chess_engine_test:reset', 'execute positioned 0 70 0 summon minecraft:marker run function chess_engine_test:controller']
        commands += [f'execute positioned 0 70 0 summon minecraft:marker run function chess_engine_test:square {{sq:{i}}}' for i in range(64)]
        if fen is None:
            return commands + [f'execute as {C} at @s run function chess:engine/init_board']
        board = []
        for row in fen.split()[0].split('/')[::-1]:
            for char in row:
                board.extend([0]*int(char) if char.isdigit() else [{'p':1,'n':2,'b':3,'r':4,'q':5,'k':6}[char.lower()] * (1 if char.isupper() else -1)])
        assert len(board) == 64
        commands += [f'scoreboard players set {cell(i)} ch_piece {v}' for i, v in enumerate(board)]
        commands += [f'scoreboard players set {C} {obj} {value}' for obj, value in [('ch_turn',turn),('ch_castle',castle),('ch_ep',ep),('ch_half',half),('ch_full',1),('ch_repetition',0)]]
        commands += [f'execute as {C} at @s run function chess:system/context', f'execute as {C} at @s run function chess:engine/cache', f'execute as {C} at @s run function chess:engine/history/record']
        return commands

    def move(self, start, to, promo=0):
        a = square(start) if isinstance(start,str) else start
        b = square(to) if isinstance(to,str) else to
        return [f'scoreboard players set #from ch_ctx {a}',f'scoreboard players set #to ch_ctx {b}',f'scoreboard players set #promo ch_ctx {promo}', f'execute as {C} at @s run function chess:engine/try_move']

    def evaluate(self):
        return [f'execute as {C} at @s run function chess:engine/evaluate']

    def build(self, oracle_path=None):
        objectives = 'ch_ctx ch_piece ch_sq ct_id ch_state ch_turn ch_castle ch_ep ch_half ch_full ch_result ch_reason ch_check ch_repetition ce'.split()
        self.file('load', [f'scoreboard objectives add {o} dummy' for o in objectives] + [f'scoreboard players set #{name} ch_ctx {v}' for name,v in [('minus',-1),('two',2),('four',4),('eight',8)]] )
        self.file('pass', '$say CHESS_ENGINE_PASS $(name)')
        self.file('fail', '$say CHESS_ENGINE_FAIL $(name)')
        self.file('reset','kill @e[tag=ce.fixture]')
        self.file('controller','tag @s add ce.fixture\ntag @s add ce.controller\ntag @s add ch.controller\nscoreboard players set @s ct_id 101\nscoreboard players set @s ch_state 1\nscoreboard players set @s ce 0\ndata modify entity @s data.chess.history set value []')
        self.file('square','tag @s add ce.fixture\ntag @s add ch.square\nscoreboard players set @s ct_id 101\n$scoreboard players set @s ch_sq $(sq)\nscoreboard players set @s ch_piece 0')

        c = self.setup()
        c += self.piece('a1',4,'initial_white_rook') + self.piece('e1',6,'initial_white_king') + self.piece('d8',-5,'initial_black_queen')
        c += self.score(C,'ch_repetition',1,'initial_history_count')
        c += self.move('e2','e4') + self.score('#legal','ch_ctx',1,'double_pawn_legal') + self.piece('e4',1,'double_pawn_applied') + self.piece('e2',0,'double_pawn_source_cleared')
        c += self.score(C,'ch_ep',20,'double_pawn_ep_target') + self.score(C,'ch_turn',-1,'turn_toggles')
        c += self.move('e7','e5') + self.score(C,'ch_full',2,'fullmove_increments_after_black')
        c += self.move('g1','f3') + self.score('#legal','ch_ctx',1,'knight_jumps') + self.score(C,'ch_half',1,'quiet_halfmove_clock')
        c += self.check('data entity '+C+' data.chess.last{from:6,to:21,piece:2,captured:0,capture_sq:-1,promotion:0}','last_move_metadata')
        self.case('opening',c)

        c=self.setup()+self.move('a1','a3')+self.score('#legal','ch_ctx',0,'rook_cannot_jump')+self.piece('a1',4,'illegal_preserves_piece')+self.score(C,'ch_turn',1,'illegal_preserves_turn')
        c+=self.move('c1','h6')+self.score('#legal','ch_ctx',0,'bishop_cannot_jump')+self.move('e2','d3')+self.score('#legal','ch_ctx',0,'pawn_cannot_capture_empty')
        c+=self.move('e2','e1')+self.score('#legal','ch_ctx',0,'cannot_capture_own_piece')+self.move('b1','b3')+self.score('#legal','ch_ctx',0,'knight_wrong_shape')
        self.case('illegal_shapes',c)

        c=self.setup('4r1k1/8/8/8/8/8/4R3/4K3')+self.move('e2','f2')+self.score('#legal','ch_ctx',0,'pinned_rook_cannot_expose_king')+self.move('e2','e8')+self.score('#legal','ch_ctx',1,'pinned_rook_can_capture_attacker')
        self.case('pins',c)
        c=self.setup('8/8/8/8/8/4k3/8/4K3')+self.move('e1','e2')+self.score('#legal','ch_ctx',0,'king_cannot_touch_enemy_king')
        self.case('king_adjacency',c)
        c=self.setup('4k3/8/8/8/8/8/4R3/4K3')+self.move('e2','e8')+self.score('#legal','ch_ctx',0,'king_not_capturable')
        self.case('king_capture',c)

        for side,start,to,rf,rt,bit in [(1,'e1','g1','h1','f1',1),(1,'e1','c1','a1','d1',2),(-1,'e8','g8','h8','f8',4),(-1,'e8','c8','a8','d8',8)]:
            name=f'castle_{bit}'
            c=self.setup('r3k2r/8/8/8/8/8/8/R3K2R',turn=side,castle=15)+self.move(start,to)
            c+=self.score('#legal','ch_ctx',1,name+'_legal')+self.piece(to,side*6,name+'_king')+self.piece(rt,side*4,name+'_rook')+self.piece(rf,0,name+'_rook_source')
            c+=self.check('data entity '+C+f' data.chess.last{{rook_from:{square(rf)},rook_to:{square(rt)}}}',name+'_metadata')
            self.case(name,c)
        for name,fen,rights,to in [
            ('castle_rights_missing','4k3/8/8/8/8/8/8/4K2R',0,'g1'),
            ('castle_rook_missing','4k3/8/8/8/8/8/8/4K3',1,'g1'),
            ('castle_through_check','k4r2/8/8/8/8/8/8/4K2R',1,'g1'),
            ('castle_out_of_check','k3r3/8/8/8/8/8/8/4K2R',1,'g1'),
            ('castle_into_check','k5r1/8/8/8/8/8/8/4K2R',1,'g1'),
            ('castle_queenside_bfile_occupied','4k3/8/8/8/8/8/8/RN2K3',2,'c1'),
        ]:
            self.case(name,self.setup(fen,castle=rights)+self.move('e1',to)+self.score('#legal','ch_ctx',0,name))

        c=self.setup('4k3/8/8/8/8/8/8/4K2R',castle=1)+self.move('h1','h2')+self.score(C,'ch_castle',0,'rook_move_revokes_castle')
        c+=self.move('e8','d8')+self.move('h2','h1')+self.score(C,'ch_castle',0,'returning_rook_does_not_restore_castle')
        self.case('castle_rights',c)
        c=self.setup('r3k3/8/8/8/8/8/8/R3K3',castle=10)+self.move('a1','a8')+self.score(C,'ch_castle',0,'capture_home_rook_revokes_both_rights')
        self.case('castle_capture_rights',c)

        c=self.setup('4k3/8/8/3pP3/8/8/8/4K3',ep=square('d6'))+self.move('e5','d6')+self.score('#legal','ch_ctx',1,'ep_legal')+self.piece('d6',1,'ep_pawn_destination')+self.piece('d5',0,'ep_captured_pawn_removed')
        c+=self.check('data entity '+C+' data.chess.last{captured:-1,capture_sq:35}','ep_metadata')+self.score(C,'ch_ep',-1,'ep_expires_after_move')
        self.case('en_passant',c)
        c=self.setup('4k3/8/8/r4pPK/8/8/8/8',ep=square('f6'))+self.move('g5','f6')+self.score('#legal','ch_ctx',0,'ep_cannot_expose_horizontal_check')+self.piece('f5',-1,'illegal_ep_preserves_enemy_pawn')
        self.case('en_passant_pin',c)
        c=self.setup('4k3/8/8/3pP3/8/8/8/4K3')+self.move('e5','d6')+self.score('#legal','ch_ctx',0,'expired_ep_illegal')
        self.case('en_passant_expired',c)

        c=self.setup('4k3/P7/8/8/8/8/8/4K3')+self.move('a7','a8')+self.score('#legal','ch_ctx',2,'promotion_pending_result')+self.piece('a7',1,'pending_promotion_preserves_source')+self.piece('a8',0,'pending_promotion_preserves_destination')+self.score(C,'ch_turn',1,'pending_promotion_preserves_turn')
        self.case('promotion_pending',c)
        for promo in (2,3,4,5):
            c=self.setup('4k3/P7/8/8/8/8/8/4K3')+self.move('a7','a8',promo)+self.score('#legal','ch_ctx',1,f'promotion_{promo}_legal')+self.piece('a8',promo,f'promotion_{promo}_piece')+self.check('data entity '+C+f' data.chess.last{{promotion:{promo}}}',f'promotion_{promo}_metadata')
            self.case(f'promotion_{promo}',c)
        c=self.setup('4k3/8/8/8/8/8/7p/4K3',turn=-1)+self.move('h2','h1',2)+self.piece('h1',-2,'black_underpromotion')
        self.case('black_promotion',c)

        c=self.setup()+self.move('f2','f3')+self.move('e7','e5')+self.move('g2','g4')+self.move('d8','h4')+self.evaluate()+self.score(C,'ch_result',2,'fools_mate_black_wins')+self.score(C,'ch_reason',1,'fools_mate_reason')+self.score(C,'ch_check',1,'fools_mate_check')
        self.case('fools_mate',c)
        c=self.setup('7k/5Q2/6K1/8/8/8/8/8',turn=-1)+self.evaluate()+self.score(C,'ch_result',3,'stalemate_draw')+self.score(C,'ch_reason',2,'stalemate_reason')+self.score(C,'ch_check',0,'stalemate_not_check')
        self.case('stalemate',c)
        for name,fen,dead in [
            ('bare_kings','4k3/8/8/8/8/8/8/4K3',1),
            ('single_knight','4k3/8/8/8/8/8/8/1N2K3',1),
            ('single_bishop','4k3/8/8/8/8/8/8/2B1K3',1),
            ('same_color_bishops','4kb2/8/8/8/8/8/8/2B1K3',1),
            ('opposite_color_bishops','2b1k3/8/8/8/8/8/8/2B1K3',0),
            ('two_knights','4k3/8/8/8/8/8/8/1NN1K3',0),
        ]:
            c=self.setup(fen)+self.evaluate()+self.score(C,'ch_result',3 if dead else 0,name+'_material')
            self.case(name,c)
        c=self.setup('7k/6Q1/5K2/8/8/8/8/8',turn=-1,half=150)+self.evaluate()+self.score(C,'ch_result',1,'mate_precedes_seventyfive')+self.score(C,'ch_reason',1,'mate_precedence_reason')
        self.case('mate_precedence',c)
        c=self.setup('4k3/8/8/8/8/8/R7/4K3',half=149)+self.move('a2','a3')+self.evaluate()+self.score(C,'ch_half',150,'seventyfive_counter')+self.score(C,'ch_result',3,'seventyfive_auto_draw')+self.score(C,'ch_reason',5,'seventyfive_reason')
        self.case('seventyfive',c)
        for cycles in (2,4):
            c=self.setup()
            for _ in range(cycles):
                for a,b in [('g1','f3'),('g8','f6'),('f3','g1'),('f6','g8')]: c+=self.move(a,b)
            c+=self.score(C,'ch_repetition',cycles+1,f'repetition_count_{cycles+1}')+self.evaluate()+self.score(C,'ch_result',3 if cycles==4 else 0,f'repetition_result_{cycles+1}')
            if cycles==4: c+=self.score(C,'ch_reason',4,'fivefold_reason')
            self.case('repetition_'+str(cycles+1),c)

        c=self.setup('4k3/8/8/r4pPK/8/8/8/8',ep=square('f6'))+[f'execute as {C} at @s run function chess:engine/cache',f'scoreboard players set {C} ch_ep -1',f'execute as {C} at @s run function chess:engine/cache',f'execute as {C} at @s run function chess:engine/history/record']+self.score(C,'ch_repetition',2,'pinned_ep_ignored_in_repetition')
        self.case('history_pinned_ep',c)
        c=self.setup('4k3/8/8/3pP3/8/8/8/4K3',ep=square('d6'))+[f'scoreboard players set {C} ch_ep -1',f'execute as {C} at @s run function chess:engine/cache',f'execute as {C} at @s run function chess:engine/history/record']+self.score(C,'ch_repetition',1,'legal_ep_distinguishes_repetition')
        self.case('history_legal_ep',c)
        c=self.setup('4k3/8/8/8/8/8/r7/4K3')+['scoreboard players set #side ch_ctx 1',f'execute as {C} at @s run function chess:engine/can_mate']+self.score('#can_mate','ch_ctx',0,'bare_king_cannot_win_on_time')+['scoreboard players set #side ch_ctx -1',f'execute as {C} at @s run function chess:engine/can_mate']+self.score('#can_mate','ch_ctx',1,'rook_side_can_win_on_time')
        self.case('timeout_material',c)
        for name,fen,side,can in [
            ('knight_vs_queen','4k3/8/8/8/8/8/q7/1N2K3',1,0),
            ('knight_vs_rook','4k3/8/8/8/8/8/r7/1N2K3',1,1),
            ('bishop_vs_queen','4k3/8/8/8/8/8/q7/2B1K3',1,0),
            ('bishop_vs_rook','4k3/8/8/8/8/8/r7/2B1K3',1,0),
            ('bishop_vs_pawn','4k3/p7/8/8/8/8/8/2B1K3',1,1),
            ('bishop_vs_knight','4k1n1/8/8/8/8/8/8/2B1K3',1,1),
            ('bishop_vs_opposite_bishop','2b1k3/8/8/8/8/8/8/2B1K3',1,1),
            ('black_knight_vs_queen','1n2k3/8/8/8/8/8/Q7/4K3',-1,0),
        ]:
            c=self.setup(fen)+[f'scoreboard players set #side ch_ctx {side}',f'execute as {C} at @s run function chess:engine/can_mate']+self.score('#can_mate','ch_ctx',can,'timeout_'+name)
            self.case('timeout_'+name,c)

        # 故障隔离：缺格不能沿用上一桌#b缓存，重复格/非法棋子/丢王均安全拒绝。
        c=self.setup()+['scoreboard players set #b28 ch_ctx 5',f'kill {cell("e4")}']+self.move('e2','e4')
        c+=self.score('#cache_ok','ch_ctx',0,'missing_cell_invalidates_cache')+self.score('#b28','ch_ctx',0,'missing_cell_clears_previous_cache')+self.score('#legal','ch_ctx',0,'missing_cell_rejects_move')+self.piece('e2',1,'missing_cell_preserves_source')
        c+=self.evaluate()+self.score(C,'ch_result',3,'missing_cell_ends_safely')+self.score(C,'ch_reason',11,'missing_cell_error_reason')
        c+=['scoreboard players set #side ch_ctx 1',f'execute as {C} at @s run function chess:engine/can_mate']+self.score('#can_mate','ch_ctx',1,'broken_board_material_conservative')
        self.case('cache_missing',c)
        c=self.setup()+['execute positioned 0 70 0 summon minecraft:marker run function chess_engine_test:square {sq:28}']+self.move('e2','e4')
        c+=self.score('#cache_ok','ch_ctx',0,'duplicate_cell_invalidates_cache')+self.score('#legal','ch_ctx',0,'duplicate_cell_rejects_move')+self.piece('e2',1,'duplicate_cell_preserves_source')
        self.case('cache_duplicate',c)
        c=self.setup()+[f'kill {cell("a3")}', 'execute positioned 0 70 0 summon minecraft:marker run function chess_engine_test:square {sq:28}']+self.move('e2','e4')
        c+=self.score('#cache_size','ch_ctx',64,'duplicate_with_missing_still_has_sixtyfour')+self.score('#cache_ok','ch_ctx',0,'duplicate_with_missing_invalidates_cache')+self.score('#legal','ch_ctx',0,'duplicate_with_missing_rejects_move')
        self.case('cache_duplicate_and_missing',c)
        c=self.setup()+[f'scoreboard players set {cell("a3")} ch_piece 7']+self.move('e2','e4')+self.score('#legal','ch_ctx',0,'invalid_piece_rejects_move')
        self.case('cache_invalid_piece',c)
        c=self.setup()+[f'scoreboard players set {cell("e8")} ch_piece 0']+self.move('e2','e4')+self.score('#legal','ch_ctx',0,'missing_king_rejects_move')
        self.case('cache_missing_king',c)

        history_size=[f'execute store result score #history_size ce run data get entity {C} data.chess.history']
        c=self.setup()+self.move('g1','f3')+history_size+self.score('#history_size','ce',2,'quiet_move_retains_repetition_history')
        c+=self.move('g8','f6')+self.move('e2','e4')+history_size+self.score('#history_size','ce',1,'pawn_move_prunes_old_history')
        c+=self.score(C,'ch_repetition',1,'pawn_move_new_position_count_one')
        self.case('history_prune_pawn',c)
        c=self.setup('r3k1n1/8/8/8/8/8/8/R3K1N1')+self.move('g1','f3')+self.move('g8','f6')+history_size+self.score('#history_size','ce',3,'before_capture_has_three_positions')
        c+=self.move('a1','a8')+history_size+self.score('#history_size','ce',1,'capture_prunes_old_history')+self.score(C,'ch_repetition',1,'capture_new_position_count_one')
        self.case('history_prune_capture',c)
        c=self.setup('rn2k2r/8/8/8/8/8/8/RN2K2R',castle=15)+self.move('b1','c3')+self.move('b8','c6')+history_size+self.score('#history_size','ce',3,'before_right_loss_has_three_positions')
        c+=self.move('h1','h2')+history_size+self.score('#history_size','ce',1,'castle_right_loss_prunes_old_history')+self.score(C,'ch_repetition',1,'right_loss_new_position_count_one')
        self.case('history_prune_rights',c)
        c=self.setup()+self.move('e2','e4')
        for _ in range(2):
            for a,b in [('g8','f6'),('g1','f3'),('f6','g8'),('f3','g1')]:c+=self.move(a,b)
        c+=self.score(C,'ch_repetition',3,'repetition_count_survives_irreversible_pruning')
        self.case('history_prune_repetition',c)

        # 独立枚举所有源/目标格，验证标准初始局面perft(1)=20、perft(2)=400。
        # 每个源格分刻，测试框架本身也遵守默认65536命令链上限。
        self.file('perft_scan', ['$scoreboard players set #from ch_ctx $(source)'] + [command for to in range(64) for command in [f'scoreboard players set #to ch_ctx {to}','scoreboard players set #promo ch_ctx 5',f'execute as {C} at @s run function chess:engine/check_move','execute if score #legal ch_ctx matches 1 run scoreboard players add #perft_branch ce 1']])
        first_moves=[(f'{file}2',f'{file}{rank}') for file in 'abcdefgh' for rank in (3,4)]+[('b1','a3'),('b1','c3'),('g1','f3'),('g1','h3')]
        for branch,first in enumerate([None]+first_moves):
            sources=range(16) if first is None else range(48,64)
            for ordinal,source in enumerate(sources):
                c=[]
                if ordinal==0:
                    c=self.setup()
                    if branch==0:c+=['scoreboard players set #perft_total ce 0']
                    if first is not None:c+=self.move(*first)
                    c+=['scoreboard players set #perft_branch ce 0',f'execute as {C} at @s run function chess:system/context',f'execute as {C} at @s run function chess:engine/cache']
                c+=[f'function chess_engine_test:perft_scan {{source:{source}}}']
                if ordinal==15:
                    c+=self.score('#perft_branch','ce',20,f'perft_branch_{branch}_twenty')
                    if first is not None:c+=['scoreboard players operation #perft_total ce += #perft_branch ce']
                    if branch==20:c+=self.score('#perft_total','ce',400,'perft_depth_two_400')
                self.case(f'perft_{branch}_{source}',c)

        if oracle_path:
            sys.path.insert(0,str(oracle_path))
            import chess
            rng=random.Random(2611)
            positions=[chess.Board(),chess.Board('r3k2r/p1ppqpb1/bn2pnp1/2pP4/1p2P3/2N2N2/PPQBBPPP/R3K2R w KQkq - 0 1')]
            board=chess.Board()
            for ply in range(1,81):
                if board.is_game_over(): board=chess.Board()
                board.push(rng.choice(list(board.legal_moves)))
                if ply in (12,25,42,60,80): positions.append(board.copy())
            for index,board in enumerate(positions):
                rights=(1 if board.has_kingside_castling_rights(chess.WHITE) else 0)+(2 if board.has_queenside_castling_rights(chess.WHITE) else 0)+(4 if board.has_kingside_castling_rights(chess.BLACK) else 0)+(8 if board.has_queenside_castling_rights(chess.BLACK) else 0)
                # 按源棋子分刻，避免把测试自身的所有候选检查塞进一个65536命令链。
                for source,piece in board.piece_map().items():
                    if piece.color != board.turn: continue
                    c=self.setup(board.board_fen(),turn=1 if board.turn else -1,castle=rights,ep=board.ep_square if board.ep_square is not None else -1,half=board.halfmove_clock)
                    c += [f'execute as {C} at @s run function chess:system/context',f'execute as {C} at @s run function chess:engine/cache']
                    # 只测试几何候选以及固定杂点；候选生成独立于生产生成器。
                    targets=set(chess.SQUARES if piece.piece_type in (chess.QUEEN,chess.ROOK,chess.BISHOP) else chess.SQUARES)
                    for target in sorted(targets):
                        if source==target: continue
                        move=chess.Move(source,target,promotion=chess.QUEEN if piece.piece_type==chess.PAWN and chess.square_rank(target) in (0,7) else None)
                        c += [f'scoreboard players set #from ch_ctx {source}',f'scoreboard players set #to ch_ctx {target}','scoreboard players set #promo ch_ctx 5',f'execute as {C} at @s run function chess:engine/check_move']
                        c += self.score('#legal','ch_ctx',1 if move in set(board.legal_moves) else 0,f'oracle_{index}_{source}_{target}')
                    self.case(f'oracle_{index}_{source}',c)

        self.file('finish',['say CHESS_ENGINE_FINISHED','function chess_engine_test:reset'])
        self.file('bootstrap',['forceload add 0 0 15 15','schedule function chess_engine_test:case/'+self.cases[0]+' 5t'])
        for i,name in enumerate(self.cases):
            self.files['case/'+name]+=('schedule function chess_engine_test:case/'+self.cases[i+1]+' 1t\n') if i+1<len(self.cases) else 'function chess_engine_test:finish\n'


def run(args):
    output=args.output.resolve() if args.output else Path(tempfile.mkdtemp(prefix='fimel-chess-engine-'))
    if args.output: output.mkdir(parents=True,exist_ok=False)
    target=output/'packs'/'chess_engine'
    shutil.copytree(args.pack/'data/chess/function/engine',target/'data/chess/function/engine')
    shutil.copy2(args.pack/'pack.mcmeta',target/'pack.mcmeta')
    suite=Suite();suite.build(args.oracle_path)
    for name,body in suite.files.items():
        dest=target/'data/chess_engine_test/function'/(name+'.mcfunction');dest.parent.mkdir(parents=True,exist_ok=True);dest.write_text(body,encoding='utf-8')
    helpers={
        'chess/function/system/context.mcfunction':'scoreboard players operation #table ch_ctx = @s ct_id\ntag @e[tag=ch.board] remove ch.board\nexecute as @e[type=minecraft:marker,tag=ch.square] if score @s ct_id = #table ch_ctx run tag @s add ch.board\n',
        'chess/function/game/after_move.mcfunction':'scoreboard players add @s ce 1\n',
        'minecraft/tags/function/load.json':json.dumps({'values':['chess_engine_test:load']}),
        'chess_engine_test/test_environment/default.json':json.dumps({'type':'minecraft:function','setup':'chess_engine_test:bootstrap'}),
        'chess_engine_test/test_instance/engine.json':json.dumps({'type':'minecraft:function','environment':'chess_engine_test:default','function':'minecraft:always_pass','max_ticks':1,'required':True,'setup_ticks':len(suite.cases)+30,'structure':'minecraft:empty'}),
    }
    for name,body in helpers.items():
        dest=target/'data'/name;dest.parent.mkdir(parents=True,exist_ok=True);dest.write_text(body,encoding='utf-8')
    launch=args.minecraft_root/'versions'/args.version/(args.version+'.json')
    meta=json.loads(launch.read_text(encoding='utf-8-sig'));classpath=[launch.with_suffix('.jar')]
    for lib in meta['libraries']:
        entry=lib.get('downloads',{}).get('artifact',{})
        if entry.get('path'):
            p=args.minecraft_root/'libraries'/entry['path']
            if p.is_file():classpath.append(p)
    java=args.java or Path.home()/'AppData/Roaming/.minecraft/runtime/java-runtime-epsilon/bin/java.exe'
    options=['-Xms256M','-Xmx1536M','-Djava.awt.headless=true','-Dfile.encoding=UTF-8','--enable-native-access=ALL-UNNAMED','-cp',';'.join(map(str,classpath)),'net.minecraft.gametest.Main','--packs',str(output/'packs'),'--universe',str(output/'universe'),'--tests','chess_engine_test:*','--report',str(output/'gametest.xml')]
    argfile=output/'java-args.txt';argfile.write_text('\n'.join('"'+v.replace('\\','\\\\').replace('"','\\"')+'"' for v in options),encoding='utf-8')
    print('Chess engine GameTest: '+str(output),flush=True);start=time.monotonic()
    proc=subprocess.run([str(java),'@'+str(argfile)],cwd=output,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True,encoding='utf-8',errors='replace',timeout=180)
    (output/'game.log').write_text(proc.stdout,encoding='utf-8')
    passed=set(re.findall(r'CHESS_ENGINE_PASS ([a-z0-9_]+)',proc.stdout));failed=sorted(set(re.findall(r'CHESS_ENGINE_FAIL ([a-z0-9_]+)',proc.stdout)));missing=sorted(set(suite.expected)-passed)
    errors=[line for line in proc.stdout.splitlines() if any(part in line for part in ('[ERROR]','/ERROR]','Failed to load','Failed to parse','Unknown function','Unknown or incomplete command',"Couldn't parse",'Command execution stopped'))]
    result={'exit_code':proc.returncode,'seconds':round(time.monotonic()-start,1),'assertions':len(suite.expected),'passed':len(passed),'failed':failed,'missing':missing,'errors':errors,'finished':'CHESS_ENGINE_FINISHED' in proc.stdout,'output':str(output)}
    (output/'result.json').write_text(json.dumps(result,ensure_ascii=False,indent=2),encoding='utf-8');print(json.dumps(result,ensure_ascii=False,indent=2),flush=True)
    return int(bool(proc.returncode or failed or missing or errors or not result['finished']))


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--pack',type=Path,default=PACK);parser.add_argument('--minecraft-root',type=Path,default=Path('D:/PCL2/MinecraftPcl'));parser.add_argument('--version',default='26.2-Fabric_0.19.3');parser.add_argument('--java',type=Path);parser.add_argument('--output',type=Path);parser.add_argument('--oracle-path',type=Path)
    sys.exit(run(parser.parse_args()))
