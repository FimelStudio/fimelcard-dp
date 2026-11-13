"""Run chess display fixtures in an isolated vanilla 26.2 GameTest world."""
from __future__ import annotations

import argparse
import json
import math
import re
import shutil
import subprocess
import tempfile
import time
from pathlib import Path

import build_chess_visual as visual

PACK = Path(__file__).resolve().parents[1]
A = '@e[type=minecraft:marker,tag=cv.controller,scores={ct_id=101},limit=1]'
B = '@e[type=minecraft:marker,tag=cv.controller,scores={ct_id=202},limit=1]'

# Independent world-space reference, seen from the south (orientation 0) or
# west (orientation 1).  Do not calculate these using the visual generator:
# that would miss the same mirrored labels that prompted this regression.
REFERENCE = {
    (4, 0): {'a1': (-.945, .945), 'h1': (.945, .945), 'a8': (-.945, -.945), 'h8': (.945, -.945), 'e1': (.135, .945), 'e8': (.135, -.945)},
    (4, 1): {'a1': (-.945, -.945), 'h1': (-.945, .945), 'a8': (.945, -.945), 'h8': (.945, .945), 'e1': (-.945, .135), 'e8': (.945, .135)},
    (8, 0): {'a1': (-1.295, 1.295), 'h1': (1.295, 1.295), 'a8': (-1.295, -1.295), 'h8': (1.295, -1.295), 'e1': (.185, 1.295), 'e8': (.185, -1.295)},
    (8, 1): {'a1': (-1.295, -1.295), 'h1': (-1.295, 1.295), 'a8': (1.295, -1.295), 'h8': (1.295, 1.295), 'e1': (-1.295, .185), 'e8': (1.295, .185)},
}
KING_ROTATION = {(0, 1): [0, 0, 0, 1], (0, -1): [0, 1, 0, 0], (1, 1): [0, -.7071068, 0, .7071068], (1, -1): [0, .7071068, 0, .7071068]}
# Independent literal orientations after the knight's requested half-turn.
KNIGHT_ROTATION = {(0, 1): [0, .7071068, 0, .7071068], (0, -1): [0, .7071068, 0, -.7071068], (1, 1): [0, 0, 0, 1], (1, -1): [0, 1, 0, 0]}


def rotate_quaternion(point, quaternion):
    """Apply a normalized renderer quaternion without using generator maths."""
    x, y, z, w = quaternion
    norm = math.sqrt(x*x + y*y + z*z + w*w)
    x, y, z, w = (value/norm for value in quaternion)
    px, py, pz = point
    tx, ty, tz = 2*(y*pz-z*py), 2*(z*px-x*pz), 2*(x*py-y*px)
    return [px+w*tx+y*tz-z*ty, py+w*ty+z*tx-x*tz, pz+w*tz+x*ty-y*tx]


def check_board_uv():
    """Trace actual exported UVs through the full 26.2 item-display pipeline.

    Vanilla FaceInfo.UP maps texture U to model X and V to model Z.
    ItemDisplayRenderer.submitInner then rotates the centered model Y by PI.
    A missing right_rotation canceller must fail these tests even though the
    rule markers and pieces still agree with each other.
    """
    passed = []
    board_commands = (PACK/'data/chess/function/visual/board.mcfunction').read_text(encoding='utf-8')
    for board in ('classic', 'green', 'wood', 'blue', 'purple'):
        model = json.loads((visual.ASSETS/f'models/item/chess/board_{board}.json').read_text(encoding='utf-8'))
        element = model['elements'][0]
        assert element['faces']['up']['uv'] == [0, 0, 16, 16]
        assert element['faces']['up'].get('rotation', 0) == 0
        for (capacity, orient), squares in REFERENCE.items():
            prefix = f'execute if score #vis_cap ch_ctx matches {capacity} if score #vis_orient ch_ctx matches {orient} run data merge entity @s '
            line = next(line for line in board_commands.splitlines() if line.startswith(prefix))
            pose = {}
            for key in ('translation', 'left_rotation', 'right_rotation', 'scale'):
                values = re.search(key+r':\[([^\]]+)\]', line).group(1)
                pose[key] = [float(value.removesuffix('f')) for value in values.split(',')]
            for square, expected in squares.items():
                file, rank = ord(square[0])-97, int(square[1])-1
                # Actual pixel centres of the exported 280px board image:
                # a8=(28,28), h1=(252,252), with a 12px coordinate border.
                u, v = (28+32*file)/280, (252-32*rank)/280
                point = [element['from'][0]+u*(element['to'][0]-element['from'][0]), element['to'][1], element['from'][2]+v*(element['to'][2]-element['from'][2])]
                point = [(value-8)/16 for value in point]
                point = rotate_quaternion(point, [0, 1, 0, 0])  # vanilla renderer
                point = rotate_quaternion(point, pose['right_rotation'])
                point = [value*scale for value, scale in zip(point, pose['scale'])]
                point = rotate_quaternion(point, pose['left_rotation'])
                point = [value+shift for value, shift in zip(point, pose['translation'])]
                assert abs(point[0]-expected[0]) < 1e-6 and abs(point[2]-expected[1]) < 1e-6, (board, capacity, orient, square, point, expected)
                passed.append(f'uv_{board}_{capacity}_{orient}_{square}')
    return passed


class Fixtures:
    def __init__(self):
        self.files = {}
        self.cases = []
        self.expected = []

    def file(self, name, commands):
        self.files[name] = '\n'.join(commands) + '\n'

    def check(self, condition, name):
        self.expected.append(name)
        return [f'execute if {condition} run say CHESS_VISUAL_PASS {name}', f'execute unless {condition} run say CHESS_VISUAL_FAIL {name}']

    def count(self, selector, expected, name):
        return ['scoreboard players set #count cv_test 0', f'execute as {selector} run scoreboard players add #count cv_test 1'] + self.check(f'score #count cv_test matches {expected}', name)

    def table(self, table=101, capacity=4, orient=0, board=0, palette=0, white=None, black=None):
        selector = A if table == 101 else B
        x = 8.0 if table == 101 else 40.0
        white = white if white is not None else (3 if capacity == 4 else 5)
        black = black if black is not None else 1
        commands = [f'summon minecraft:marker {x} 64 8.0 {{Tags:["cv.fixture","cv.controller","cv.new"],data:{{chess:{{captured:[]}}}}}}']
        for objective, value in {'ct_id': table, 'ct_capacity': capacity, 'ch_orient': orient, 'ch_board': board, 'ch_palette': palette, 'ch_sel': -1, 'ch_white': white, 'ch_black': black}.items():
            commands.append(f'scoreboard players set @e[tag=cv.new,limit=1] {objective} {value}')
        commands.append('tag @e[tag=cv.new] remove cv.new')
        pieces = [4, 2, 3, 5, 6, 3, 2, 4] + [1] * 8 + [0] * 32 + [-1] * 8 + [-4, -2, -3, -5, -6, -3, -2, -4]
        for square, piece in enumerate(pieces):
            commands += [f'summon minecraft:marker {x} 64 8.0 {{Tags:["cv.fixture","ch.square","cv.new"]}}', f'scoreboard players set @e[tag=cv.new,limit=1] ct_id {table}', f'scoreboard players set @e[tag=cv.new,limit=1] ch_sq {square}', f'scoreboard players set @e[tag=cv.new,limit=1] ch_piece {piece}', 'tag @e[tag=cv.new] remove cv.new']
        commands += [f'execute as {selector} at @s run function chess:visual/setup']
        return commands

    def case(self, name, commands):
        self.cases.append(name)
        self.file('case/' + name, ['kill @e[tag=ch.visual]', 'kill @e[tag=cv.fixture]'] + commands)

    def man(self, square, table=101):
        return f'@e[type=minecraft:item_display,tag=ch.man,tag=!ch.captured,scores={{ct_id={table},ch_sq={square}}},limit=1]'

    def marker(self, square, table=101):
        return f'@e[type=minecraft:marker,tag=ch.square,scores={{ct_id={table},ch_sq={square}}},limit=1]'

    def hit(self, square, table=101):
        return f'@e[type=minecraft:interaction,tag=ch.piece_hit,scores={{ct_id={table},ch_sq={square}}},limit=1]'

    def hit_shape(self, square, piece, capacity, name):
        width, height = visual.hit_dimensions(piece, capacity)
        return self.check(f'data entity {self.hit(square)} {{width:{visual.f(width)}f,height:{visual.f(height)}f}}', name)

    def hit_position(self, square, capacity, orient, name):
        x, z = visual.square_position(square, capacity, orient)
        target = self.hit(square)[:-1] + ',distance=..0.00001]'
        # Relative teleport arithmetic can differ from a literal by one double
        # ULP.  Ten micrometres distinguishes squares without demanding an
        # irrelevant binary floating-point representation.
        return [line.replace('execute ', f'execute positioned {visual.f(8+x)} 65.035 {visual.f(8+z)} ', 1) for line in self.check('entity '+target, name)]

    def pose(self, selector, x, z, scale, name):
        return self.check(f'data entity {selector} transformation{{translation:{visual.nbt_vector([x,scale*.5,z])},scale:{visual.nbt_vector([scale]*3)}}}', name)

    def king_rotation(self, square, orient, side, name):
        quaternion = visual.nbt_vector(KING_ROTATION[(orient, side)])
        return self.check(f'data entity {self.man(square)} transformation{{left_rotation:{quaternion}}}', name)

    def knight_rotation(self, square, orient, side, name, selector=None):
        quaternion = visual.nbt_vector(KNIGHT_ROTATION[(orient, side)])
        return self.check(f'data entity {selector or self.man(square)} transformation{{left_rotation:{quaternion}}}', name)

    def commit(self, source, target, piece, captured=0, capture_sq=-1, rook_from=-1, rook_to=-1, promotion=0):
        commands = [f'scoreboard players set {self.marker(source)} ch_piece 0', f'scoreboard players set {self.marker(target)} ch_piece {(-1 if piece<0 else 1)*promotion if promotion else piece}']
        if captured and capture_sq != target:
            commands += [f'scoreboard players set {self.marker(capture_sq)} ch_piece 0']
        if rook_from >= 0:
            commands += [f'scoreboard players set {self.marker(rook_from)} ch_piece 0', f'scoreboard players set {self.marker(rook_to)} ch_piece {4 if piece>0 else -4}']
        commands += [f'data modify entity {A} data.chess.last set value {{from:{source},to:{target},piece:{piece},captured:{captured},capture_sq:{capture_sq},rook_from:{rook_from},rook_to:{rook_to},promotion:{promotion}}}', f'execute as {A} at @s run function chess:visual/move']
        return commands

    def build(self):
        objectives = ['ct_id', 'ct_capacity', 'ch_ctx', 'ch_sq', 'ch_piece', 'ch_owner', 'ch_slot', 'ch_sel', 'ch_board', 'ch_palette', 'ch_orient', 'ch_white', 'ch_black', 'ch_wcapt', 'ch_bcapt', 'cv_test']
        self.file('bootstrap', ['forceload add -16 -16 47 15', 'gamerule minecraft:max_command_sequence_length 65536'] + [f'scoreboard objectives add {objective} dummy' for objective in objectives] + ['schedule function chess_visual_test:case/layout_4_0 40t'])
        for capacity in (4, 8):
            for orient in (0, 1):
                key = f'layout_{capacity}_{orient}'
                commands = self.table(capacity=capacity, orient=orient)
                commands += self.count('@e[tag=ch.tile,scores={ct_id=101}]', 64, key+'_64_tiles')
                commands += self.count('@e[tag=ch.piece_hit,scores={ct_id=101}]', 32, key+'_32_piece_hits')
                commands += self.count('@e[tag=ch.cell,scores={ct_id=101}]', 96, key+'_96_cells')
                commands += self.count('@e[tag=ch.man,scores={ct_id=101}]', 32, key+'_32_men')
                commands += self.count('@e[tag=ch.square,scores={ct_id=101}]', 64, key+'_64_rule_markers')
                commands += self.count('@e[tag=ch.board_display,scores={ct_id=101}]', 1, key+'_one_board')
                commands += self.count('@e[tag=ch.visual,scores={ct_id=101}]', 129, key+'_129_visuals')
                commands += self.check('data entity @e[tag=ch.tile,scores={ct_id=101},limit=1] {height:0.025f}',key+'_flat_tiles')
                board_rotation = '[0f,0f,0f,1f]' if orient == 0 else '[0f,-0.7071068f,0f,0.7071068f]'
                commands += self.check(f'data entity @e[tag=ch.board_display,scores={{ct_id=101}},limit=1] transformation{{left_rotation:{board_rotation},right_rotation:[0f,1f,0f,0f]}}', key+'_board_uv_renderer_rotation')
                for square,side in [(1,1),(6,1),(57,-1),(62,-1)]:
                    commands += self.knight_rotation(square,orient,side,key+f'_knight_{square}_half_turn')
                for name, square, side in [('e1', 4, 1), ('e8', 60, -1)]:
                    x, z = REFERENCE[(capacity, orient)][name]
                    scale = .39 if capacity == 4 else .53
                    commands += self.pose(self.man(square), x, z, scale, key+'_king_'+name+'_literal_position')
                    commands += self.check(f'score {self.man(square)} ch_piece matches {side*6}', key+'_king_'+name+'_piece')
                    commands += self.king_rotation(square, orient, side, key+'_king_'+name+'_extra_quarter_turn')
                    hit = self.hit(square)[:-1] + ',distance=..0.00001]'
                    commands += [line.replace('execute ', f'execute positioned {8+x} 65.035 {8+z} ', 1) for line in self.check('entity '+hit, key+'_king_'+name+'_literal_hit')]
                for square,piece in [(0,4),(1,2),(2,3),(3,5),(4,6),(8,1)]:
                    commands += self.hit_shape(square,piece,capacity,key+f'_hit_shape_{square}')
                    commands += self.hit_position(square,capacity,orient,key+f'_hit_position_{square}')
                for square in (0, 7, 56, 63):
                    x,z=visual.square_position(square,capacity,orient)
                    commands += self.pose(self.man(square), x,z,visual.LAYOUTS[capacity]['piece_scale'], key+f'_square_{square}')
                commands += [f'scoreboard players set {A} ch_sel 12', f'execute as {A} at @s run function chess:visual/select']
                commands += self.count('@e[tag=ch.highlight,scores={ct_id=101}]',1,key+'_selection')
                commands += [f'scoreboard players set {A} ch_sel -1', f'execute as {A} at @s run function chess:visual/select']
                commands += self.count('@e[tag=ch.highlight,scores={ct_id=101}]',0,key+'_selection_cleared')
                commands += self.count('@e[tag=ch.cell,scores={ct_id=101}]',96,key+'_selection_preserves_cells')
                self.case(key, commands)

        for board,board_name in enumerate(visual.BOARDS):
            for palette,palette_name in enumerate(visual.PALETTES):
                key=f'palette_{board}_{palette}'
                commands=self.table(board=board,palette=palette)
                commands += self.check(f'data entity @e[tag=ch.board_display,scores={{ct_id=101}},limit=1] item.components{{"minecraft:item_model":"card:chess/board_{board_name}"}}',key+'_board')
                for square,side,piece in [(0,'white','rook'),(4,'white','king'),(8,'white','pawn'),(57,'black','knight'),(58,'black','bishop'),(59,'black','queen')]:
                    commands += self.check(f'data entity {self.man(square)} item.components{{"minecraft:item_model":"card:chess/{palette_name}/{side}_{piece}"}}',key+f'_man_{square}')
                commands += self.king_rotation(4, 0, 1, key+'_white_king_rotation')
                commands += self.king_rotation(60, 0, -1, key+'_black_king_rotation')
                commands += self.knight_rotation(1, 0, 1, key+'_white_knight_rotation')
                commands += self.knight_rotation(57, 0, -1, key+'_black_knight_rotation')
                self.case(key,commands)

        commands=self.table()+self.table(202,8,1)
        commands += ['summon minecraft:text_display 0 66 0 {Tags:["cv.fixture","cv.new","ch.visual","ch.clock"]}', 'scoreboard players set @e[tag=cv.new,limit=1] ct_id 101','tag @e[tag=cv.new] remove cv.new']
        commands += [f'execute as {A} at @s run function chess:visual/refresh']*2
        commands += self.count('@e[tag=ch.square,scores={ct_id=101}]',64,'refresh_keeps_markers')
        commands += self.count('@e[tag=ch.clock,scores={ct_id=101}]',1,'refresh_keeps_clock')
        commands += self.count('@e[tag=ch.visual,scores={ct_id=101}]',130,'refresh_no_duplicates')
        commands += self.count('@e[tag=ch.visual,scores={ct_id=202}]',129,'refresh_preserves_other_table')
        commands += [f'execute as {A} at @s run function chess:visual/clear']
        commands += self.count('@e[tag=ch.visual,scores={ct_id=101}]',0,'clear_removes_own_visuals')
        commands += self.count('@e[tag=ch.square,scores={ct_id=101}]',64,'clear_keeps_rule_markers')
        commands += self.count('@e[tag=ch.visual,scores={ct_id=202}]',129,'clear_preserves_other_table')
        self.case('isolation',commands)

        for capacity in (4,8):
            for orient in (0,1):
                key=f'move_{capacity}_{orient}'
                commands=self.table(capacity=capacity,orient=orient)+self.commit(12,28,1)
                x,z=visual.square_position(28,capacity,orient)
                commands+=self.pose(self.man(28),x,z,visual.LAYOUTS[capacity]['piece_scale'],key+'_target')
                commands+=self.hit_position(28,capacity,orient,key+'_hit_moves')
                commands+=self.count('@e[tag=ch.piece_hit,scores={ct_id=101,ch_sq=12}]',0,key+'_source_hit_moved')
                commands+=self.count('@e[tag=ch.piece_hit,scores={ct_id=101}]',32,key+'_hit_count_stable')
                commands+=self.check(f'data entity {self.man(28)} {{interpolation_duration:8}}',key+'_eight_tick_animation')
                commands+=self.count('@e[tag=ch.man,tag=ch.moving,scores={ct_id=101}]',1,key+'_moving_one')
                commands+=[f'execute as {A} at @s run function chess:visual/finish_move']
                commands+=self.count('@e[tag=ch.man,tag=ch.moving,scores={ct_id=101}]',0,key+'_animation_finishes')
                self.case(key,commands)

        commands=self.table()+self.commit(12,52,1,-1,52)
        captured='@e[tag=ch.man,tag=ch.captured,scores={ct_id=101,ch_slot=0},limit=1]'
        commands+=self.pose(captured,1.285,-.945,.205,'capture_white_east_right')
        commands+=self.check(f'score {A} ch_wcapt matches 1','capture_counts_capturer')
        commands+=self.check(f'data entity {A} data.chess.captured[{{piece:-1,owner:1,slot:0}}]','capture_persists_record')
        commands+=self.count('@e[tag=ch.man,tag=ch.captured,scores={ct_id=101}]',1,'capture_keeps_captured_man')
        commands+=self.count('@e[tag=ch.man,scores={ct_id=101}]',32,'capture_keeps_total_men')
        commands+=self.count('@e[tag=ch.piece_hit,scores={ct_id=101}]',31,'capture_removes_only_captured_hit')
        commands+=self.hit_position(52,4,0,'capture_mover_hit_at_target')
        commands+=[f'execute as {A} at @s run function chess:visual/refresh']
        commands+=self.pose(captured,1.285,-.945,.205,'capture_restored_same_slot')
        commands+=self.count('@e[tag=ch.man,scores={ct_id=101}]',32,'capture_refresh_keeps_total')
        commands+=self.count('@e[tag=ch.piece_hit,scores={ct_id=101}]',31,'capture_refresh_does_not_restore_captured_hit')
        self.case('capture',commands)

        # Real seating overrides logical orientation; same-edge seats use the
        # two opposite board edges rather than overlap their capture trays.
        for white,black,expected_x,expected_z,name in [(4,2,.945,1.285,'actual_west_seat_right_south'),(1,1,-1.23,.945,'same_edge_shared_right')]:
            commands=self.table(white=white,black=black)+self.commit(12,52,1,-1,52)
            commands+=self.pose(captured,expected_x,expected_z,.10 if white==black else .205,name)
            self.case(name,commands)

        commands=self.table()+['kill @e[tag=ch.man,scores={ct_id=101,ch_sq=5..6}]', 'kill @e[tag=ch.piece_hit,scores={ct_id=101,ch_sq=5..6}]']+self.commit(4,6,6,rook_from=7,rook_to=5)
        commands+=self.count('@e[tag=ch.man,tag=ch.moving,scores={ct_id=101}]',2,'castle_animates_king_and_rook')
        for square,piece in [(6,6),(5,4)]:
            x,z=visual.square_position(square,4,0)
            commands+=self.pose(self.man(square),x,z,.39,f'castle_target_{square}')
            commands+=self.check(f'score {self.man(square)} ch_piece matches {piece}',f'castle_piece_{square}')
            commands+=self.hit_position(square,4,0,f'castle_hit_{square}')
        commands+=self.king_rotation(6,0,1,'castle_king_keeps_extra_quarter_turn')
        self.case('castle',commands)

        # Kings retain their independent quarter-turn after ordinary animated
        # moves and after display rebuilding, for both colours/directions.
        for orient in (0,1):
            for source,target,side in [(4,12,1),(60,52,-1)]:
                key=f'king_move_{orient}_{side if side>0 else "black"}'
                commands=self.table(orient=orient)
                commands += [f'scoreboard players set {self.marker(target)} ch_piece 0', f'kill {self.man(target)}', f'kill {self.hit(target)}']
                commands += self.commit(source,target,side*6)
                commands += self.king_rotation(target,orient,side,key+'_animated_rotation')
                commands += self.check(f'data entity {self.man(target)} {{interpolation_duration:8}}',key+'_animation')
                commands += [f'execute as {A} at @s run function chess:visual/refresh']
                commands += self.king_rotation(target,orient,side,key+'_refresh_rotation')
                self.case(key,commands)

        # The asymmetric knight must keep the half-turn while moving and in
        # the capture tray, including rebuilding either representation.
        for orient in (0,1):
            for source,target,side in [(1,18,1),(57,42,-1)]:
                key=f'knight_move_{orient}_{side if side>0 else "black"}'
                commands=self.table(orient=orient)+self.commit(source,target,side*2)
                commands += self.knight_rotation(target,orient,side,key+'_animated_rotation')
                commands += self.check(f'data entity {self.man(target)} {{interpolation_duration:8}}',key+'_animation')
                commands += [f'execute as {A} at @s run function chess:visual/refresh']
                commands += self.knight_rotation(target,orient,side,key+'_refresh_rotation')
                self.case(key,commands)
            for source,target,side in [(12,57,-1),(52,1,1)]:
                key=f'knight_captured_{orient}_{side if side>0 else "black"}'
                commands=self.table(orient=orient)+self.commit(source,target,-side,side*2,target)
                commands += self.knight_rotation(target,orient,side,key+'_tray_rotation',captured)
                commands += [f'execute as {A} at @s run function chess:visual/refresh']
                commands += self.knight_rotation(target,orient,side,key+'_tray_refresh_rotation',captured)
                self.case(key,commands)

        for source,target,piece,captured_piece,side in [(8,56,1,-4,'white'),(48,0,-1,4,'black')]:
            commands=self.table()+self.commit(source,target,piece,captured_piece,target,promotion=5)
            commands+=self.check(f'data entity {self.man(target)} item.components{{"minecraft:item_model":"card:chess/ebony/{side}_queen"}}',f'promotion_{side}_model')
            commands+=self.check(f'score {self.man(target)} ch_piece matches {5 if piece>0 else -5}',f'promotion_{side}_piece')
            commands+=self.hit_shape(target,5,4,f'promotion_{side}_hit_resizes')
            commands+=self.hit_position(target,4,0,f'promotion_{side}_hit_moves')
            self.case('promotion_'+side,commands)

        for index,name in enumerate(self.cases[:-1]):
            self.files['case/'+name]+='schedule function chess_visual_test:case/'+self.cases[index+1]+' 1t\n'
        self.files['case/'+self.cases[-1]]+='say CHESS_VISUAL_FINISHED\n'


def write_pack(output):
    target=output/'packs/fimel_chess_visual'
    target.mkdir(parents=True)
    shutil.copy2(PACK/'pack.mcmeta',target/'pack.mcmeta')
    shutil.copytree(PACK/'data/chess/function/visual',target/'data/chess/function/visual')
    # The visual selection entry also clears optional destination outlines.
    # This focused fixture leaves ch_hints unset, so no rule query is needed.
    shutil.copytree(PACK/'data/chess/function/hints',target/'data/chess/function/hints')
    fixtures=Fixtures()
    fixtures.build()
    for name,body in fixtures.files.items():
        dest=target/'data/chess_visual_test/function'/(name+'.mcfunction')
        dest.parent.mkdir(parents=True,exist_ok=True)
        dest.write_text(body,encoding='utf-8')
    definitions={'test_environment/default.json':{'type':'minecraft:function','setup':'chess_visual_test:bootstrap'},'test_instance/visual.json':{'type':'minecraft:function','environment':'chess_visual_test:default','function':'minecraft:always_pass','max_ticks':1,'required':True,'setup_ticks':200,'structure':'minecraft:empty'}}
    for name,body in definitions.items():
        dest=target/'data/chess_visual_test'/name
        dest.parent.mkdir(parents=True,exist_ok=True)
        dest.write_text(json.dumps(body),encoding='utf-8')
    return fixtures.expected


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output',type=Path)
    parser.add_argument('--minecraft-root',type=Path,default=Path('D:/PCL2/MinecraftPcl'))
    parser.add_argument('--version',default='26.2-Fabric_0.19.3')
    parser.add_argument('--java',type=Path,default=Path('C:/Temp/fimel-uno-java25/jdk-25.0.5+8-jre/bin/java.exe'))
    args=parser.parse_args()
    output=args.output.resolve() if args.output else Path(tempfile.mkdtemp(prefix='fimel-chess-visual-'))
    output.mkdir(parents=True,exist_ok=True)
    uv_checks=check_board_uv()
    expected=write_pack(output)
    launch=args.minecraft_root/'versions'/args.version/(args.version+'.json')
    meta=json.loads(launch.read_text(encoding='utf-8-sig'))
    classpath=[launch.with_suffix('.jar')]
    for library in meta['libraries']:
        artifact=library.get('downloads',{}).get('artifact',{})
        if artifact.get('path'):
            path=args.minecraft_root/'libraries'/artifact['path']
            if path.is_file(): classpath.append(path)
    options=['-Xms256M','-Xmx1536M','-Djava.awt.headless=true','-Dfile.encoding=UTF-8','--enable-native-access=ALL-UNNAMED','-cp',';'.join(map(str,classpath)),'net.minecraft.gametest.Main','--packs',str(output/'packs'),'--universe',str(output/'universe'),'--tests','chess_visual_test:*','--report',str(output/'gametest.xml')]
    argfile=output/'java-args.txt'
    argfile.write_text('\n'.join('"'+value.replace('\\','\\\\').replace('"','\\"')+'"' for value in options),encoding='utf-8')
    print('Chess visual GameTest: '+str(output),flush=True)
    start=time.monotonic()
    process=subprocess.run([str(args.java),'@'+str(argfile)],cwd=output,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True,encoding='utf-8',errors='replace',timeout=180)
    (output/'game.log').write_text(process.stdout,encoding='utf-8')
    passed=set(re.findall(r'CHESS_VISUAL_PASS ([a-z0-9_]+)',process.stdout))
    failed=sorted(set(re.findall(r'CHESS_VISUAL_FAIL ([a-z0-9_]+)',process.stdout)))
    missing=sorted(set(expected)-passed)
    errors=[line for line in process.stdout.splitlines() if any(part in line for part in ('[ERROR]','/ERROR]','Failed to load','Failed to parse','Unknown function','Unknown or incomplete command',"Couldn't parse"))]
    result={'exit_code':process.returncode,'seconds':round(time.monotonic()-start,1),'assertions':len(expected),'passed':len(passed),'board_uv_checks':len(uv_checks),'failed':failed,'missing':missing,'errors':errors,'finished':'CHESS_VISUAL_FINISHED' in process.stdout,'output':str(output)}
    (output/'result.json').write_text(json.dumps(result,ensure_ascii=False,indent=2),encoding='utf-8')
    print(json.dumps(result,ensure_ascii=False,indent=2),flush=True)
    return int(bool(process.returncode or failed or missing or errors or not result['finished']))


if __name__=='__main__':
    raise SystemExit(main())
