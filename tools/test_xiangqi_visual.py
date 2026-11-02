"""Independent Xiangqi UV/layout, legal-outline and animated capture regression."""
import json
import math
import re
from pathlib import Path

import build_xiangqi_visual as visual
from test_chess_visual import rotate_quaternion
from test_xiangqi import Suite, A, B, square, run


def asset_checks():
    checks=[]
    commands=(visual.GAME/'board.mcfunction').read_text(encoding='utf-8')
    references={
        (4,0):{0:(-1.02,1.1475),8:(1.02,1.1475),81:(-1.02,-1.1475),89:(1.02,-1.1475),4:(0,1.1475),85:(0,-1.1475)},
        (4,1):{0:(-1.1475,-1.02),8:(-1.1475,1.02),81:(1.1475,-1.02),89:(1.1475,1.02),4:(-1.1475,0),85:(1.1475,0)},
        (8,0):{0:(-1.4,1.575),8:(1.4,1.575),81:(-1.4,-1.575),89:(1.4,-1.575),4:(0,1.575),85:(0,-1.575)},
        (8,1):{0:(-1.575,-1.4),8:(-1.575,1.4),81:(1.575,-1.4),89:(1.575,1.4),4:(-1.575,0),85:(1.575,0)},
    }
    for board in visual.BOARDS:
        model=json.loads((visual.ASSETS/f'models/item/xiangqi/board_{board}.json').read_text(encoding='utf-8'))
        element=model['elements'][0]
        for (cap,orient),reference in references.items():
            prefix=f'execute if score #vis_cap xq_ctx matches {cap} if score #vis_orient xq_ctx matches {orient} run '
            line=next(line for line in commands.splitlines() if line.startswith(prefix))
            pose={key:[float(value.removesuffix('f')) for value in re.search(key+r':\[([^\]]+)\]',line).group(1).split(',')] for key in ('translation','left_rotation','right_rotation','scale')}
            for sq,(x,z) in reference.items():
                file,rank=sq%9,sq//9
                u,v=(32+64*file)/576,(608-64*rank)/640
                point=[element['from'][0]+u*(element['to'][0]-element['from'][0]),element['to'][1],element['from'][2]+v*(element['to'][2]-element['from'][2])]
                point=[(value-8)/16 for value in point]
                point=rotate_quaternion(point,[0,1,0,0])
                point=rotate_quaternion(point,pose['right_rotation'])
                point=[v*s for v,s in zip(point,pose['scale'])]
                point=rotate_quaternion(point,pose['left_rotation'])
                point=[v+t for v,t in zip(point,pose['translation'])]
                assert abs(point[0]-x)<1e-6 and abs(point[2]-z)<1e-6,(board,cap,orient,sq,point,(x,z))
                checks.append(f'board_uv_{board}_{cap}_{orient}_{sq}')
    for palette in visual.PALETTES:
        for side in ('red','black'):
            for kind in visual.PIECES.values():
                model=json.loads((visual.ASSETS/f'models/item/xiangqi/{palette}/{side}_{kind}.json').read_text(encoding='utf-8'))
                assert len(model['elements'])==32
                for element in model['elements']:
                    assert element['from'][1]==0 and element['to'][1]==3
                    assert element['from'][0]>=.5 and element['to'][0]<=15.5
                    assert all(0<=v<=16 for v in element['faces']['up']['uv'])
                bb=json.loads((visual.SOURCE/f'models/{palette}/{side}_{kind}.bbmodel').read_text(encoding='utf-8'))
                assert len(bb['elements'])==32 and len(bb['textures'])==2
                assert {f['texture'] for e in bb['elements'] for f in e['faces'].values()}=={0,1}
                checks.append(f'disc_{palette}_{side}_{kind}')
    print(f'Independent Xiangqi assets: {len(checks)} checks passed.',flush=True)
    return checks


class VisualSuite(Suite):
    def build(self):
        super().build()
        self.files={name:body for name,body in self.files.items() if name in ('table','person','reset','dialogs','bootstrap','finish')}
        self.cases=[];self.expected=[]
        def man(sq,table=101):return f'@e[tag=xq.man,tag=!xq.captured,scores={{ct_id={table},xq_sq={sq}}},limit=1]'
        def hit(sq):return f'@e[tag=xq.piece_hit,scores={{ct_id=101,xq_sq={sq}}},limit=1]'
        def pose(selector,x,z,scale,name):
            return self.check(f'data entity {selector} transformation{{translation:{visual.nbt_vector([x,scale/2,z])},scale:{visual.nbt_vector([scale]*3)}}}',name)
        for cap in (4,8):
            for orient in (0,1):
                key=f'layout_{cap}_{orient}'
                c=self.setup(cap)+[f'scoreboard players set {A} xq_orient {orient}']+self.call('visual/refresh')
                c+=self.count('@e[tag=xq.tile,scores={ct_id=101}]',90,key+'_90_cells')
                c+=self.count('@e[tag=xq.man,scores={ct_id=101}]',32,key+'_32_men')
                c+=self.count('@e[tag=xq.piece_hit,scores={ct_id=101}]',32,key+'_32_hits')
                c+=self.count('@e[tag=xq.board_display,scores={ct_id=101}]',1,key+'_one_board')
                for sq in (0,4,8,81,85,89):
                    x,z=visual.square_position(sq,cap,orient)
                    c+=pose(man(sq),x,z,visual.LAYOUTS[cap]['piece_scale'],key+f'_position_{sq}')
                rotation='[0f,0f,0f,1f]' if orient==0 else '[0f,-0.7071068f,0f,0.7071068f]'
                c+=self.check(f'data entity {man(4)} transformation{{left_rotation:{rotation},right_rotation:[0f,1f,0f,0f]}}',key+'_red_text_direction')
                c+=self.click(1,27)
                c+=self.count('@e[tag=xq.highlight,scores={ct_id=101}]',1,key+'_selection')
                c+=self.count('@e[tag=xq.hint,scores={ct_id=101}]',1,key+'_soldier_one_target')
                c+=self.count('@e[tag=xq.hint,scores={ct_id=101,xq_sq=36}]',1,key+'_soldier_forward')
                c+=self.check('data entity @e[tag=xq.hint,scores={ct_id=101},limit=1] {Glowing:1b}',key+'_real_glowing')
                self.case(key,c)
        for board,board_name in enumerate(visual.BOARDS):
            for palette,palette_name in enumerate(visual.PALETTES):
                key=f'palette_{board}_{palette}'
                c=self.setup()+[f'scoreboard players set {A} xq_board {board}',f'scoreboard players set {A} xq_palette {palette}']+self.call('visual/refresh')
                c+=self.check(f'data entity @e[tag=xq.board_display,scores={{ct_id=101}},limit=1] item.components{{"minecraft:item_model":"card:xiangqi/board_{board_name}"}}',key+'_board')
                for sq,side,kind in [(0,'red','rook'),(1,'red','horse'),(2,'red','elephant'),(3,'red','advisor'),(4,'red','general'),(19,'red','cannon'),(27,'red','pawn'),(85,'black','general'),(54,'black','pawn')]:
                    c+=self.check(f'data entity {man(sq)} item.components{{"minecraft:item_model":"card:xiangqi/{palette_name}/{side}_{kind}"}}',key+f'_piece_{sq}')
                self.case(key,c)
        for cap in (4,8):
            for orient in (0,1):
                key=f'capture_{cap}_{orient}'
                red_seat=(3 if cap==4 else 5) if not orient else (4 if cap==4 else 7)
                black_seat=1 if not orient else (2 if cap==4 else 3)
                c=self.setup(cap)+[f'scoreboard players set {A} xq_orient {orient}',f'scoreboard players set {A} xq_red {red_seat}',f'scoreboard players set {A} xq_black {black_seat}']+self.call('visual/refresh')
                c += [f'scoreboard players set {square(27)} xq_piece 0',f'scoreboard players set {square(54)} xq_piece 1',f'data modify entity {A} data.xiangqi.last set value {{from:27,to:54,piece:1,captured:-1,capture_sq:54}}']+self.call('visual/move')
                captured='@e[tag=xq.man,tag=xq.captured,scores={ct_id=101,xq_slot=0},limit=1]'
                # Capture belongs to red's right: east from south, south from west.
                outward=1.265 if cap==4 else 1.735
                along=-.8925 if cap==4 else -1.225
                x,z=(outward,along) if not orient else (-along,outward)
                c+=pose(captured,x,z,.12 if cap==4 else .165,key+'_right_tray')
                c+=self.count('@e[tag=xq.man,tag=xq.captured,scores={ct_id=101}]',1,key+'_one_captured')
                c+=self.count('@e[tag=xq.piece_hit,scores={ct_id=101}]',31,key+'_captured_hit_removed')
                c+=self.count('@e[tag=xq.man,scores={ct_id=101}]',32,key+'_all_displays_kept')
                c+=self.score(A,'xq_rcapt',1,key+'_capture_count')
                c+=self.call('visual/refresh')+pose(captured,x,z,.12 if cap==4 else .165,key+'_reload_tray')
                self.case(key,c)
        c=self.setup()+self.click(1,1)
        c+=self.count('@e[tag=xq.hint,scores={ct_id=101}]',2,'horse_two_open_destinations')
        c+=self.count('@e[tag=xq.hint,scores={ct_id=101,xq_sq=18}]',1,'horse_left_target')
        c+=self.count('@e[tag=xq.hint,scores={ct_id=101,xq_sq=20}]',1,'horse_right_target')
        c += [f'scoreboard players set {A} xq_hints 0']+self.call('visual/select')
        c+=self.count('@e[tag=xq.hint,scores={ct_id=101}]',0,'toggle_off_clears_targets')
        c+=self.count('@e[tag=xq.highlight,scores={ct_id=101}]',1,'toggle_off_keeps_selection')
        self.case('hints',c)
        c=self.setup()+self.click(1,27)
        c+=self.count('@e[tag=xq.highlight,scores={ct_id=101,xq_sq=27}]',1,'selected_soldier_gold_frame')
        c+=self.check('data entity @e[tag=xq.highlight,scores={ct_id=101},limit=1] {Glowing:1b,glow_color_override:16766720}','selected_gold_real_glow')
        c += ['scoreboard players set #target xq_ctx 777','scoreboard players set #chosen xq_ctx 778']+self.call('hints/refresh')
        c+=self.score('#target','xq_ctx',777,'hints_preserve_input_target')+self.score('#chosen','xq_ctx',778,'hints_preserve_chosen_piece')
        c+=self.count('@e[tag=xq.square,scores={ct_id=101,xq_piece=0}]',58,'hints_preserve_empty_rule_squares')
        c+=self.score(square(27),'xq_piece',1,'hints_preserve_selected_soldier')
        c+=self.click(1,1)
        c+=self.count('@e[tag=xq.highlight,scores={ct_id=101,xq_sq=1}]',1,'reselect_moves_gold_frame')
        c+=self.count('@e[tag=xq.highlight,scores={ct_id=101}]',1,'reselect_only_one_gold_frame')
        c+=self.count('@e[tag=xq.hint,scores={ct_id=101,xq_sq=36}]',0,'reselect_removes_old_target')
        c+=self.count('@e[tag=xq.hint,scores={ct_id=101}]',2,'reselect_rebuilds_horse_targets')
        c+=self.click(1,17)
        c+=self.count('@e[tag=xq.highlight,scores={ct_id=101}]',0,'illegal_clears_gold_frame')
        c+=self.count('@e[tag=xq.hint,scores={ct_id=101}]',0,'illegal_clears_green_frames')
        c+=self.click(-1,82)
        c+=self.count('@e[tag=xq.highlight,scores={ct_id=101}]',0,'wrong_turn_cannot_select')
        c+=self.count('@e[tag=xq.hint,scores={ct_id=101}]',0,'wrong_turn_creates_no_targets')
        c += [f'scoreboard players set {A} xq_bot 1',f'scoreboard players set {A} xq_sel 27']+self.call('visual/select')
        c+=self.count('@e[tag=xq.hint,scores={ct_id=101}]',0,'bot_turn_creates_no_targets')
        self.case('hints_readonly_and_interaction',c)
        # Each initial cannon can capture the opposite horse over one screen.
        for source,sq in ((19,82),(25,88)):
            c=self.setup()+self.click(1,source)
            c+=self.count(f'@e[tag=xq.hint,scores={{ct_id=101,xq_sq={sq}}}]',1,f'cannon_screen_capture_{sq}')
            screen=64 if source==19 else 70
            c+=self.count(f'@e[tag=xq.hint,scores={{ct_id=101,xq_sq={screen}}}]',0,f'cannon_cannot_capture_screen_{screen}')
            self.case(f'hints_cannon_{source}',c)
        c=self.setup()+self.setup(table=202,reset=False)+self.click(1,27)
        c+=self.count('@e[tag=xq.hint,scores={ct_id=202}]',0,'hints_not_on_other_table')
        c+=self.click(1,27,table=202)
        c+=self.count('@e[tag=xq.hint,scores={ct_id=101,xq_sq=36}]',1,'second_query_keeps_first_table_hint')
        c+=self.count('@e[tag=xq.hint,scores={ct_id=202,xq_sq=36}]',1,'second_query_gets_own_table_hint')
        c+=self.call('visual/clear')+self.count('@e[tag=xq.visual,scores={ct_id=101}]',0,'clear_own_visuals')
        c+=self.count('@e[tag=xq.man,scores={ct_id=202}]',32,'clear_preserves_other_table')
        c+=self.count('@e[tag=xq.square,scores={ct_id=101}]',90,'clear_preserves_rules')
        self.case('isolation',c)
        # Setup is separate from input, exactly as tables already exist before
        # the production tick processes two users. Keep the vanilla 65,536
        # limit: two expensive cannon queries must finish in the same chain.
        self.case('stress_prepare_a',self.setup())
        self.case('stress_prepare_b',self.setup(table=202,reset=False))
        c=self.click(1,19)+self.click(1,25)
        c+=self.count('@e[tag=xq.hint,scores={ct_id=101,xq_sq=88}]',1,'same_chain_two_cannon_clicks_finish')
        c+=self.count('@e[tag=xq.highlight,scores={ct_id=101,xq_sq=25}]',1,'same_chain_second_cannon_selected')
        self.case('stress_same_table',c)
        c=self.click(1,19)+self.click(1,19,table=202)
        c+=self.count('@e[tag=xq.hint,scores={ct_id=101,xq_sq=82}]',1,'same_chain_two_tables_first_hint')
        c+=self.count('@e[tag=xq.hint,scores={ct_id=202,xq_sq=82}]',1,'same_chain_two_tables_second_hint')
        c+=self.count('@e[tag=xq.highlight,scores={ct_id=101}]',1,'same_chain_two_tables_first_selection')
        c+=self.count('@e[tag=xq.highlight,scores={ct_id=202}]',1,'same_chain_two_tables_second_selection')
        self.case('stress_two_tables',c)
        self.case('dialogs',['function xiangqi_game_test:dialogs'])
        self.file('bootstrap',['forceload add -16 -16 63 31','scoreboard objectives add xg dummy','function xiangqi:load','schedule function xiangqi_game_test:case/'+self.cases[0]+' 40t'])
        for i,name in enumerate(self.cases):
            self.files['case/'+name]+='schedule function xiangqi_game_test:'+('case/'+self.cases[i+1] if i+1<len(self.cases) else 'finish')+' 3t\n'


if __name__=='__main__':
    asset_checks()
    suite=VisualSuite();suite.build()
    raise SystemExit(run(suite,prefix='fimel-xiangqi-visual-',setup_ticks=300,manual_tick=True))
