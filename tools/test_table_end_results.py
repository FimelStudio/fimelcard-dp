"""原版文本实体结算回归：全部牌面、终局隐私、幂等、两桌隔离及清理。"""
import json
import sys
import test_uno as base


def splendor_state():
    state = {'n':4,'phase':4,'winners':[1,2]}
    for side, cards, nobles in [(1,list(range(17)),[0,9]),(2,list(range(17,33)),[1]),(3,list(range(33,90)),list(range(2,9))),(4,[],[])]:
        state['p'+str(side)] = {'name':{'text':f'玩家{side}'},'vp':15 if side < 3 else 8,'cards':cards,'nobles':nobles}
    return state


def catan_state():
    state = {'n':4,'phase':11,'winner':1,'longest':1,'army':2}
    for side, vp, public in [(1,10,8),(2,8,7),(3,6,6),(4,2,2)]:
        state['p'+str(side)] = {'name':{'text':f'玩家{side}'},'vp':vp,'public_vp':public,
            'settlements_left':3,'cities_left':2,'roads_left':7,'road_length':9,'knights':5,
            'resources':[1,1,1,1,1],'resource_count':5,'dev':[1,2,3,4,1 if side<3 else 0],
            'fresh':[1,0,0,0,1 if side==1 else 0]}
    return state


class Fixtures(base.Fixtures):
    def case(self, name, commands):
        if name == 'real_reload': self.result_cases()
        super().case(name,commands)

    def result_cases(self):
        for game, prefix, number, state in [('splendor','sp',22,splendor_state()),('catan','ca',21,catan_state())]:
            for cap in (4,8):
                label=f'{game}_{cap}'
                own=f'@e[type=minecraft:text_display,tag={prefix}.result,scores={{ct_id=101}}]'
                other=f'@e[type=minecraft:text_display,tag={prefix}.result,scores={{ct_id=202}}]'
                c=self.setup()+self.table(202,create_deck=False)+[f'kill @e[tag={prefix}.result]']
                for table in (base.A,base.B):
                    c += [f'scoreboard players set {table} ct_game {number}',f'scoreboard players set {table} ct_capacity {cap}',
                          f'data modify entity {table} data.{game} set value '+json.dumps(state,ensure_ascii=False)]
                c += [f'data modify storage result_test:snapshot state set from entity {base.A} data.{game}',
                      f'execute as {base.A} at @s run function {game}:result/show']
                c += self.count(own,17,label+'_all_player_rows_rendered')
                c += self.count(own[:-1]+',nbt={billboard:"vertical"}]',17,label+'_vertical_billboards')
                c += [f'execute store success score #mutated ut run data modify storage result_test:snapshot state set from entity {base.A} data.{game}']
                c += self.score('#mutated','ut',0,label+'_render_does_not_mutate_game')
                c += [f'execute as {base.A} at @s run function {game}:result/show']
                c += self.count(own,17,label+'_rebuild_is_idempotent')
                if game=='splendor':
                    for code, name in [(0xE900,'first_card'),(0xE959,'last_card'),(0xEA09,'last_noble')]:
                        c += self.count(own[:-1]+',nbt={text:{extra:[{text:"'+chr(code)+'",font:"card:splendor/small"}]}}]',1,label+'_'+name+'_is_visible')
                    c += self.count(own[:-1]+',nbt={text:{extra:[{text:" ★ 胜者"}]}}]',2,label+'_joint_winners_marked')
                else:
                    c += self.check('data storage catan:result p{hidden:2,d0:2,d4:2,longest_points:2,army_points:0}',label+'_hidden_and_fresh_points_revealed_at_end')
                    c += self.count(own[:-1]+',nbt={text:{extra:[{text:" ★ 胜者"}]}}]',1,label+'_actual_winner_marked')
                c += [f'execute as {base.B} at @s run function {game}:result/show',
                      f'execute as {base.A} at @s run function {game}:visual/clear']
                c += self.count(own,0,label+'_normal_visual_cleanup_removes_results')
                c += self.count(other,17,label+'_cleanup_preserves_other_table')
                c += [f'scoreboard players set {base.A} ct_state 0',f'data modify entity {base.A} data.{game}.review set value 1b',
                      f'execute as {base.A} at @s run function {game}:result/show']
                c += self.count(own,17,label+'_lobby_review_restores_results')
                c += [f'data modify entity {base.A} data.{game}.phase set value 1',f'execute as {base.A} at @s run function {game}:result/show']
                c += self.count(own,0,label+'_active_or_aborted_game_reveals_no_results')
                c += self.count(other,17,label+'_new_game_preserves_other_table_results')
                c += [f'kill @e[tag={prefix}.result]']
                super().case(label+'_end_results',c)


if __name__=='__main__':
    base.Fixtures=Fixtures
    sys.exit(base.main())
