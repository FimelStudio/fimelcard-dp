"""Exercise legal destination hints and cleanup in an isolated vanilla 26.2 world.

Uses the existing integration runner; all assertions below inspect real runtime
entities and rule state, including independently specified pinned/EP positions.
"""
import test_chess as integration
from test_chess import A, B, square


class HintSuite(integration.Suite):
    def hint(self, sq, table=101):
        return f'@e[type=minecraft:item_display,tag=ch.hint,scores={{ct_id={table},ch_sq={sq}}},limit=1]'

    def select(self, source, table=101):
        return [f'scoreboard players set {A if table==101 else B} ch_sel {source}'] + self.call('visual/select', table)

    def destinations(self, expected, key, table=101):
        c = self.count(f'@e[tag=ch.hint,scores={{ct_id={table}}}]', len(expected), key+'_count')
        for sq in range(64):
            if sq in expected:
                c += self.check('entity '+self.hint(sq, table), key+f'_square_{sq}')
            else:
                c += [
                    f'execute unless entity {self.hint(sq, table)} run say CHESS_GAME_PASS {key}_absent_{sq}',
                    f'execute if entity {self.hint(sq, table)} run say CHESS_GAME_FAIL {key}_absent_{sq}']
                self.expected.append(key+f'_absent_{sq}')
        return c

    def build(self):
        # Keep the integration runner's bootstrap, fixture methods and codec
        # checks, but replace its scenarios with focused hint regressions.
        super().build()
        self.cases, self.expected = [], []
        positions = [
            ('pawn', None, 1, 12, {20, 28}, 15, -1),
            ('knight', None, 1, 6, {21, 23}, 15, -1),
            ('pin', 'k3r3/8/8/8/8/8/4R3/4K3', 1, 12, {20, 28, 36, 44, 52, 60}, 0, -1),
            ('check_block', 'k3r3/8/8/8/8/2B5/8/4K3', 1, 18, {36}, 0, -1),
            ('castle', '4k3/8/8/8/8/8/8/R3K2R', 1, 4, {2, 3, 5, 6, 11, 12, 13}, 3, -1),
            ('castle_attack', 'k4r2/8/8/8/8/8/8/R3K2R', 1, 4, {2, 3, 11, 12}, 3, -1),
            ('ep', '4k3/8/8/3pP3/8/8/8/4K3', 1, 36, {43, 44}, 0, 43),
            ('ep_discovered_check', '4k3/8/8/K2pP2r/8/8/8/8', 1, 36, {44}, 0, 43),
            ('promotion', '1r2k3/P7/8/8/8/8/8/4K3', 1, 48, {56, 57}, 0, -1),
            ('black_pawn', None, -1, 52, {36, 44}, 15, -1),
            ('queen', '8/7k/8/8/3Q4/8/8/K7', 1, 27,
             {24,25,26,28,29,30,31,3,11,19,35,43,51,59,36,45,54,63,34,41,48,20,13,6,18,9}, 0, -1),
        ]
        for name, fen, turn, source, expected, castle, ep in positions:
            c = self.position(fen, turn, castle, ep) if fen else self.setup()+[f'scoreboard players set {A} ch_turn {turn}']
            c += [f'data modify storage chess_hints_test:state chess set from entity {A} data.chess']
            for objective in ('ch_turn', 'ch_castle', 'ch_ep', 'ch_wtime', 'ch_btime', 'ch_epoch'):
                c += [f'scoreboard players operation #before_{objective} cg = {A} {objective}']
            c += ['scoreboard players set #target ch_ctx 31', 'scoreboard players set #chosen ch_ctx 4',
                  'scoreboard players set #from ch_ctx 17', 'scoreboard players set #to ch_ctx 41', 'scoreboard players set #promo ch_ctx 2']
            c += self.select(source)+self.destinations(expected, name)
            for fake, value in [('target',31),('chosen',4),('from',17),('to',41),('promo',2)]:
                c += self.score('#'+fake,'ch_ctx',value,name+'_preserves_'+fake)
            for objective in ('ch_turn', 'ch_castle', 'ch_ep', 'ch_wtime', 'ch_btime', 'ch_epoch'):
                c += self.check(f'score {A} {objective} = #before_{objective} cg', name+'_preserves_'+objective)
            c += [f'execute store success score #changed cg run data modify storage chess_hints_test:state chess set from entity {A} data.chess']
            c += self.score('#changed','cg',0,name+'_preserves_history_metadata')
            # Every real rule marker must retain its original piece; hints are
            # not allowed to commit even a reversible simulated capture.
            if fen:
                board = [0]*64
                pieces = {'p':1,'n':2,'b':3,'r':4,'q':5,'k':6}
                for rank,row in enumerate(fen.split('/')):
                    file = 0
                    for char in row:
                        if char.isdigit(): file += int(char); continue
                        board[(7-rank)*8+file] = pieces[char.lower()] * (1 if char.isupper() else -1)
                        file += 1
            else:
                board = [4,2,3,5,6,3,2,4]+[1]*8+[0]*32+[-1]*8+[-4,-2,-3,-5,-6,-3,-2,-4]
            for sq,piece in enumerate(board):
                c += self.score(square(sq),'ch_piece',piece,name+f'_preserves_marker_{sq}')
            c += self.count('@e[tag=ch.highlight,scores={ct_id=101}]',1,name+'_gold_source')
            self.case('hints_'+name,c)

        for cap in (4,8):
            for orient in (0,1):
                key=f'layout_{cap}_{orient}'
                c=self.setup(cap)+[f'scoreboard players set {A} ch_orient {orient}']+self.call('visual/refresh')+self.select(12)
                # Independent e4 world offsets for the two board layouts.
                step = .27 if cap==4 else .37
                x,z = (step/2,step/2) if orient==0 else (-step/2,step/2)
                for path,value in [('transformation.translation[0]',x),('transformation.translation[1]',step/2),('transformation.translation[2]',z),('transformation.scale[0]',step)]:
                    c += [f'execute store result score #component cg run data get entity {self.hint(28)} {path} 1000000']
                    expected = round(value*1000000)
                    c += self.score('#component','cg',f'{expected-2}..{expected+2}',key+'_'+path.replace('.','_').replace('[','').replace(']',''))
                c += self.check(f'data entity {self.hint(28)} {{Glowing:1b,glow_color_override:5635925}}',key+'_green_glow')
                c += self.check(f'data entity {self.hint(28)} item.components{{"minecraft:item_model":"card:chess/hint"}}',key+'_emerald_model')
                c += self.check('data entity @e[tag=ch.highlight,scores={ct_id=101},limit=1] item.components{"minecraft:item_model":"card:chess/selection"}',key+'_gold_model')
                c += self.check('data entity @e[tag=ch.highlight,scores={ct_id=101},limit=1] {Glowing:1b,glow_color_override:16766720}',key+'_gold_glow')
                self.case(key,c)

        c=self.setup()+self.select(12)+self.select(6)+self.destinations({21,23},'reselect')
        c += self.count('@e[tag=ch.highlight,scores={ct_id=101,ch_sq=6}]',1,'reselect_gold_transfers')
        c += [f'scoreboard players set {A} ch_hints 0']+self.call('visual/select')+self.count('@e[tag=ch.hint,scores={ct_id=101}]',0,'disabled_clears')
        c += self.count('@e[tag=ch.highlight,scores={ct_id=101}]',1,'disabled_keeps_source')
        c += [f'scoreboard players set {A} ch_hints 1']+self.call('visual/select')+self.count('@e[tag=ch.hint,scores={ct_id=101}]',2,'enabled_restores')
        c += [f'scoreboard players set {A} ch_bot 1']+self.call('visual/select')+self.count('@e[tag=ch.hint,scores={ct_id=101}]',0,'bot_turn_no_hints')
        c += [f'scoreboard players set {A} ch_bot -1']+self.call('visual/select')+self.count('@e[tag=ch.hint,scores={ct_id=101}]',2,'human_bot_game_hints')
        c += self.select(-1)+self.count('@e[tag=ch.hint,scores={ct_id=101}]',0,'clear_selection_clears')
        self.case('hints_settings',c)

        c=self.setup()+self.setup(table=202,reset=False)+self.select(12)+self.select(6,202)
        c += self.select(-1)+self.count('@e[tag=ch.hint,scores={ct_id=101}]',0,'table_a_selection_cleanup')+self.count('@e[tag=ch.hint,scores={ct_id=202}]',2,'table_b_hints_preserved')
        c += self.select(12)+self.call('visual/refresh')+self.count('@e[tag=ch.hint,scores={ct_id=101}]',2,'refresh_no_duplicates')
        c += self.call('game/remove')+self.count('@e[tag=ch.hint,scores={ct_id=101}]',0,'remove_clears_hints')+self.count('@e[tag=ch.hint,scores={ct_id=202}]',2,'remove_preserves_other_hints')
        self.case('hints_isolation',c)

        for event in ('move','illegal','finish','abort','reload','promotion'):
            c=self.position('1r2k3/P7/8/8/8/8/8/4K3') if event=='promotion' else self.setup()
            c += self.click(1,48 if event=='promotion' else 12)
            if event=='move': c+=self.click(1,28)
            elif event=='illegal': c+=self.click(1,36)
            elif event=='finish': c+=self.actor(1)+self.call('game/resign')
            elif event=='abort': c+=self.call('game/abort')
            elif event=='reload': c+=self.call('system/reload')
            else: c+=self.click(1,56)
            c+=self.count('@e[tag=ch.hint,scores={ct_id=101}]',2 if event=='reload' else 0,'cleanup_'+event)
            self.case('cleanup_'+event,c)

        self.file('bootstrap',['forceload add -16 -16 63 31','scoreboard objectives add cg dummy','schedule function chess_game_test:case/'+self.cases[0]+' 40t'])
        for i,name in enumerate(self.cases):
            self.files['case/'+name]+='schedule function chess_game_test:'+('case/'+self.cases[i+1] if i+1<len(self.cases) else 'finish')+' 3t\n'
        self.file('finish',['function chess_game_test:reset','say CHESS_DIALOGS_END','say CHESS_GAME_FINISHED'])


if __name__ == '__main__':
    integration.Suite = HintSuite
    raise SystemExit(integration.main())
