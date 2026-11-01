"""原版 26.2 揭棋引擎验收，同时保留全部标准象棋规则回归。"""
from pathlib import Path
import argparse
import test_xiangqi_engine as base

C, cell = base.C, base.cell


class Suite(base.Suite):
    def hidden_position(self, pieces, covered=None, hidden=None, turn=1):
        commands = self.setup(pieces, turn)
        commands += [f'scoreboard players set {C} xq_variant 1',
                     'scoreboard players set @e[tag=xq.board] xq_covered 0',
                     'execute as @e[tag=xq.board] run scoreboard players operation @s xq_hidden = @s xq_piece']
        commands += [f'scoreboard players set {cell(i)} xq_covered 1' for i in (covered or [])]
        commands += [f'scoreboard players set {cell(i)} xq_hidden {kind}' for i,kind in (hidden or {}).items()]
        commands += [f'data modify entity {C} data.xiangqi.history set value []']
        return commands+self.call('engine/cache')+self.call('engine/history/record')

    def count(self, selector, value, name):
        return ['execute store result score #count xe if entity '+selector]+self.score('#count','xe',value,name)

    def build(self, oracle=None):
        super().build(oracle)
        c=self.setup()+[f'scoreboard players set {C} xq_variant 1']+self.call('engine/init_board')
        c+=self.count('@e[tag=xq.board,scores={xq_covered=1}]',30,'covered_initial_thirty')
        for side in (1,-1):
            prefix='red' if side==1 else 'black'
            c+=self.count('@e[tag=xq.board,scores={xq_piece='+('1..7' if side==1 else '-7..-1')+',xq_covered=1}]',15,prefix+'_fifteen_covered')
            for kind,n in [(1,5),(2,2),(3,2),(4,2),(5,2),(6,1),(7,2)]:
                c+=self.count('@e[tag=xq.board,scores={xq_hidden='+str(kind*side)+'}]',n,prefix+'_hidden_multiset_'+str(kind))
        c+=self.score(cell(4),'xq_covered',0,'red_general_face_up')+self.score(cell(85),'xq_covered',0,'black_general_face_up')
        c+=self.piece(0,4,'covered_rook_position_template')+self.piece(3,7,'covered_advisor_position_template')
        c+=self.check(f'data entity {C} data.xiangqi.history[{{meta:1}}]','covered_initial_history')
        self.case('covered_initial',c)

        c=self.hidden_position({0:4},covered=[0],hidden={0:2})
        c+=self.probe(0,18)+self.score('#legal','xq_ctx',1,'dark_rook_uses_rook_template')
        c+=self.score(cell(0),'xq_hidden',2,'probe_keeps_private_identity')+self.score(cell(0),'xq_covered',1,'probe_does_not_flip')
        c+=self.probe(0,19)+self.score('#legal','xq_ctx',0,'dark_rook_cannot_move_like_hidden_horse')
        c+=self.move(0,18)+self.piece(18,2,'successful_move_reveals_real_horse')
        c+=self.score(cell(18),'xq_hidden',2,'real_horse_private_value_consistent')+self.score(cell(18),'xq_covered',0,'real_move_flips_destination')
        c+=self.score(cell(0),'xq_hidden',0,'vacated_private_square_cleared')+self.score(cell(0),'xq_covered',0,'vacated_cover_cleared')
        c+=self.check(f'data entity {C} data.xiangqi.last{{piece:2,moved_template:4,was_covered:1,captured_covered:0}}','flip_public_metadata')
        c+=[f'scoreboard players set {C} xq_turn 1']+self.call('engine/cache')+self.probe(18,19)+self.score('#legal','xq_ctx',0,'revealed_horse_cannot_keep_rook_template')
        c+=self.probe(18,37)+self.score('#legal','xq_ctx',1,'revealed_horse_uses_real_shape')
        self.case('covered_flip',c)

        c=self.hidden_position({0:4},covered=[0],hidden={0:1})+self.move(0,10)
        c+=self.score('#legal','xq_ctx',0,'illegal_move_rejected')+self.piece(0,4,'illegal_move_keeps_template')
        c+=self.score(cell(0),'xq_hidden',1,'illegal_move_keeps_hidden')+self.score(cell(0),'xq_covered',1,'illegal_move_keeps_cover')
        self.case('covered_illegal',c)

        variants=[('red_advisor_roams',{37:7},[],37,47,1),
                  ('dark_advisor_stays_in_palace',{21:7},[21],21,29,0),
                  ('red_elephant_crosses',{38:3},[],38,58,1),
                  ('dark_elephant_cannot_cross',{38:3},[38],38,58,0),
                  ('black_elephant_crosses',{51:-3},[],51,31,1),
                  ('revealed_elephant_eye_still_blocks',{38:3,48:1},[],38,58,0),
                  ('general_stays_in_palace',{4:0,22:6},[],22,31,0),
                  ('dark_advisor_first_diagonal',{3:7},[3],3,13,1)]
        for name,pieces,covered,a,b,want in variants:
            side=-1 if pieces.get(a,0)<0 else 1
            c=self.hidden_position(pieces,covered=covered,hidden={i:(1 if side==1 else -1) for i in covered},turn=side)
            c+=self.probe(a,b)+self.score('#legal','xq_ctx',want,name)
            self.case(name,c)

        for covered,want in [(False,1),(True,0)]:
            c=self.hidden_position({75:7},covered=[75] if covered else [])
            c+=['scoreboard players set #attack_sq xq_ctx 85','scoreboard players set #attacker xq_ctx 1']+self.call('engine/attack')
            c+=self.score('#attacked','xq_ctx',want,'advisor_extended_attack_'+str(int(covered)))
            self.case('advisor_attack_'+str(int(covered)),c)

        c=self.hidden_position({0:4,18:-4},covered=[18],hidden={18:-2})+self.move(0,18)
        c+=self.check(f'data entity {C} data.xiangqi.last{{captured:-4,captured_covered:1,piece:4}}','captured_dark_only_public_template')
        c+=self.piece(18,4,'capture_overwrites_with_mover')+self.score(cell(18),'xq_hidden',4,'captured_hidden_not_retained_on_square')
        self.case('covered_capture',c)

        c=self.hidden_position({0:4},covered=[0],hidden={0:1})+self.probe(0,18)
        c+=['scoreboard players operation #first_legal xe = #legal xq_ctx',f'scoreboard players set {cell(0)} xq_hidden 7']+self.probe(0,18)
        c+=self.check('score #first_legal xe = #legal xq_ctx','legal_independent_of_private_identity')
        c+=self.score(cell(0),'xq_hidden',7,'recheck_keeps_private_identity')+self.score(cell(0),'xq_covered',1,'recheck_keeps_cover')
        self.case('covered_no_peeking',c)

        c=self.hidden_position({0:4},covered=[0],hidden={0:1})
        c+=[f'scoreboard players set {cell(0)} xq_covered 0']+self.call('engine/cache')+self.call('engine/history/record')
        c+=self.score(C,'xq_repetition',1,'different_cover_is_different_repetition_key')
        c+=[f'scoreboard players set {cell(0)} xq_covered 1']+self.call('engine/cache')+self.call('engine/history/record')
        c+=self.score(C,'xq_repetition',2,'same_cover_restores_same_repetition_key')
        self.case('covered_repetition',c)

        c=self.hidden_position({4:0,3:6,40:0,37:7})+self.call('engine/material')
        c+=self.score('#dead','xq_ctx',0,'roaming_advisor_not_automatic_dead_material')
        c+=['scoreboard players set #side xq_ctx 1']+self.call('engine/can_mate')
        c+=self.score('#can_mate','xq_ctx',1,'roaming_advisor_can_win_on_time')
        self.case('covered_material',c)

        # Rebuild the sequence after adding the new cases to the standard suite.
        self.file('bootstrap',['forceload add 0 0 15 15','schedule function xiangqi_engine_test:case/'+self.cases[0]+' 5t'])
        for i,name in enumerate(self.cases):
            lines=self.files['case/'+name].splitlines()
            lines=[line for line in lines if not line.startswith('schedule function xiangqi_engine_test:') and line!='function xiangqi_engine_test:finish']
            lines += ['schedule function xiangqi_engine_test:case/'+self.cases[i+1]+' 1t'] if i+1<len(self.cases) else ['function xiangqi_engine_test:finish']
            self.file('case/'+name,lines)


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--pack',type=Path,default=base.PACK)
    parser.add_argument('--minecraft-root',type=Path,default=Path('D:/PCL2/MinecraftPcl'))
    parser.add_argument('--version',default='26.2-Fabric_0.19.3')
    parser.add_argument('--java',type=Path,default=Path('C:/Temp/fimel-java25-validation/jdk-25.0.5+8-jre/bin/java.exe'))
    parser.add_argument('--output',type=Path)
    parser.add_argument('--oracle',type=Path)
    args=parser.parse_args();suite=Suite();suite.build(args.oracle)
    raise SystemExit(base.run(args,suite))
