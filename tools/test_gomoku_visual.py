"""真实26.2验收五子棋单棋盘交互、视线求交、三尺寸布局与落子/收回展示。"""
from test_gomoku import Suite as BaseSuite, A, B, PACK, square, run


ACTOR='@e[type=minecraft:marker,tag=gv.actor,limit=1]'


def point(size,cap,orient,sq,origin=(8,64,8)):
    # 对照公开布局约定独立计算，不读取生成器或运行时布局表。
    step={4:2.7,8:3.6}[cap]*.875/(size-1)
    x=(sq%19-(size-1)/2)*step
    z=((size-1)/2-sq//19)*step
    if orient:x,z=-z,x
    return origin[0]+x,origin[1]+1.025,origin[2]+z


class Suite(BaseSuite):
    def table(self,cap=4,size=15,orient=0,table=101,origin=(8,64,8),reset=True):
        return (['function gomoku_game_test:reset'] if reset else [])+[
            f'execute positioned {origin[0]:.9f} {origin[1]:.9f} {origin[2]:.9f} summon minecraft:marker run function gomoku_game_test:table {{table:{table},cap:{cap},size:{size},orient:{orient}}}']

    def ray(self,target,expected,name,origin=(8,64,8),eye=None,table=101):
        eye=eye or (origin[0]+.21,origin[1]+3.2,origin[2]+2.1)
        p=' '.join(f'{v:.9f}' for v in eye)
        t=' '.join(f'{v:.9f}' for v in target)
        commands=[f'tp {ACTOR} {p} facing {t}']+self.call('system/context',table)
        commands += [f'execute as {ACTOR} at @s run function gomoku:input/ray']
        commands+=self.score('#ray_ok','gm_ctx',1,name+'_hit')+self.score('#target','gm_ctx',expected,name+'_target')
        return commands+self.count('@e[tag=gm.ray]',0,name+'_scratch_clean')

    def build(self):
        self.file('reset',['kill @e[tag=gm.visual]','kill @e[tag=gm.square]','kill @e[tag=gg.fixture]'])
        self.file('actor','tag @s add gg.fixture\ntag @s add gv.actor')
        self.file('table','''
tag @s add gg.fixture
tag @s add gg.table
tag @s add ct.controller
tag @s add gm.controller
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ct_capacity $(cap)
$scoreboard players set @s gm_size $(size)
$scoreboard players set @s gm_orient $(orient)
scoreboard players set @s ct_game 14
scoreboard players set @s ct_state 1
scoreboard players set @s gm_state 1
scoreboard players set @s gm_board 0
scoreboard players set @s gm_palette 0
scoreboard players set @s gm_coords 1
scoreboard players set @s gm_mark 1
scoreboard players set @s gm_sel -1
function gomoku:system/create_board
function gomoku:engine/init_board
function gomoku:visual/refresh
execute summon minecraft:marker run function gomoku_game_test:actor
''')
        for cap in (4,8):
            for size in (13,15,19):
                for orient in (0,1):
                    name=f'layout_{cap}_{size}_{orient}'
                    c=self.table(cap,size,orient)
                    c+=self.count('@e[type=minecraft:interaction,tag=gm.cell,scores={ct_id=101}]',1,name+'_single_hitbox')
                    c+=self.count('@e[type=minecraft:item_display,tag=gm.board_display,scores={ct_id=101}]',1,name+'_one_board')
                    c+=self.count('@e[type=minecraft:item_display,tag=gm.man,scores={ct_id=101}]',0,name+'_empty_no_stone_displays')
                    c+=self.count('@e[type=minecraft:marker,tag=gm.square,scores={ct_id=101}]',size*size,name+'_server_markers')
                    steps=(0,size//2,size-1)
                    for r in steps:
                        for f in steps:
                            sq=r*19+f;target=point(size,cap,orient,sq)
                            c+=self.check(f'entity {square(sq)}',name+f'_cell_{sq}_exists')
                            c+=self.check(f'entity @e[type=minecraft:marker,tag=gm.square,scores={{ct_id=101,gm_sq={sq}}},x={target[0]:.9f},y={target[1]:.9f},z={target[2]:.9f},distance=..0.00002]',name+f'_cell_{sq}_position')
                            c+=self.ray(target,sq,name+f'_ray_{sq}')
                    self.case(name,c)
        # No fixed-point world-coordinate multiplication: precision remains valid
        # in distant player bases as well as around the world's origin.
        origin=(1000000,96,-1000000)
        c=self.table(8,19,1,origin=origin)
        for sq in (0,18,180,342,360):
            target=point(19,8,1,sq,origin)
            c+=self.ray(target,sq,f'far_world_{sq}',origin)
        self.case('far_world',c)
        c=self.table(size=19)
        for name,eye,target in [
            ('horizontal',(8,67,10),(8,67,8)),
            ('upward',(8,67,10),(8,69,8)),
            ('below_board',(8,64.5,10),(8,64,8)),
            ('far_off_board',(8,67,10),(13,65.025,8)),
        ]:
            c += [f'tp {ACTOR} '+' '.join(f'{v:.9f}' for v in eye)+' facing '+' '.join(f'{v:.9f}' for v in target)]+self.call('system/context')
            c += [f'execute as {ACTOR} at @s run function gomoku:input/ray']
            c+=self.score('#ray_ok','gm_ctx',0,name+'_rejected')+self.count('@e[tag=gm.ray]',0,name+'_clean')
        self.case('ray_rejections',c)
        # Placement is spawned high, then interpolated on the following tick;
        # the logical square and the displayed stone remain separate entities.
        c=self.table()+[f'scoreboard players set {square(140)} gm_piece 1',f'data modify entity {A} data.gomoku.last set value {{sq:140,side:1}}']+self.call('visual/place')
        stone='@e[type=minecraft:item_display,tag=gm.man,scores={ct_id=101,gm_sq=140},limit=1]'
        c+=self.count('@e[type=minecraft:item_display,tag=gm.man,scores={ct_id=101}]',1,'place_one_stone')
        c+=self.check(f'data entity {stone} data.gomoku_visual{{started:0b}}','place_not_started')
        c+=self.check(f'data entity {stone} transformation{{translation:[0.0f,0.24f,0.0f]}}','place_spawn_above_board')
        c+=self.check(f'data entity {stone} item.components{{"minecraft:item_model":"card:gomoku/stone/ebony_black"}}','place_black_model')
        c+=self.count('@e[tag=gm.highlight,scores={ct_id=101}]',1,'last_move_one_cross')
        self.cases.append('place_animation')
        self.file('case/place_animation',c+['schedule function gomoku_game_test:animation_next 1t'])
        c=self.call('visual/tick')+self.check(f'data entity {stone} data.gomoku_visual{{started:1b}}','next_tick_animation_started')
        c+=self.check(f'data entity {stone} {{interpolation_duration:5}}','next_tick_five_frame_duration')
        c+=self.call('visual/finish_move')+self.count('@e[tag=gm.falling,scores={ct_id=101}]',0,'finish_clears_falling')
        c+=[f'scoreboard players set {A} gm_sel 141']+self.call('visual/select')+self.count('@e[tag=gm.highlight,scores={ct_id=101}]',2,'selection_and_last_marks')
        c+=[f'scoreboard players set {square(140)} gm_piece 0',f'data remove entity {A} data.gomoku.last',f'scoreboard players set {A} gm_sel -1']+self.call('visual/undo')
        c+=self.count('@e[tag=gm.retracting,scores={ct_id=101}]',1,'undo_retracts_stone')
        c+=self.check(f'data entity {stone} {{interpolation_duration:4}}','undo_four_frame_duration')
        c+=self.check(f'data entity {stone} transformation{{scale:[0.015f,0.015f,0.015f]}}','undo_shrinks_stone')
        c+=self.call('visual/finish_move')+self.count('@e[tag=gm.man,scores={ct_id=101}]',0,'undo_cleans_display')
        c+=self.count('@e[tag=gm.highlight,scores={ct_id=101}]',0,'undo_cleans_marks')
        self.file('animation_next',c)
        # Winning frames are deduplicated and old highlights vanish on refresh.
        c=self.table()+[f'data modify entity {A} data.gomoku.win set value [140,141,142,143,144]']+self.call('visual/select')
        c+=self.count('@e[tag=gm.highlight,scores={ct_id=101}]',5,'five_winning_frames')
        c+=self.count('@e[tag=gm.highlight,scores={ct_id=101},nbt={Glowing:1b}]',5,'five_winning_frames_glow')
        c+=[f'data modify entity {A} data.gomoku.win set value []']+self.call('visual/select')
        c+=self.count('@e[tag=gm.highlight,scores={ct_id=101}]',0,'winning_frames_cleared')
        self.case('winning_marks',c)
        c=self.table()+self.table(8,19,1,table=202,origin=(40,64,8),reset=False)
        c += self.call('visual/refresh')
        c+=self.count('@e[type=minecraft:interaction,tag=gm.cell,scores={ct_id=101}]',1,'refresh_own_single_hitbox')
        c+=self.count('@e[type=minecraft:interaction,tag=gm.cell,scores={ct_id=202}]',1,'refresh_other_kept_hitbox')
        c += self.call('visual/clear')
        c+=self.count('@e[tag=gm.visual,scores={ct_id=101}]',0,'clear_own_visuals')
        c+=self.count('@e[tag=gm.visual,scores={ct_id=202}]',2,'clear_other_visuals_untouched')
        self.case('isolation',c)
        self.file('dialogs',(PACK/'tools/test_gomoku_dialogs.mcfunction').read_text(encoding='utf-8'))
        self.file('finish',['function gomoku_game_test:reset','function gomoku_game_test:dialogs','say GOMOKU_GAME_FINISHED'])
        self.file('bootstrap',['forceload add -16 -16 63 31','forceload add 999984 -1000016 1000015 -999985','scoreboard objectives add gg dummy','function gomoku:load','schedule function gomoku_game_test:case/'+self.cases[0]+' 40t'])
        for i,name in enumerate(self.cases):
            key='animation_next' if name=='place_animation' else 'case/'+name
            self.files[key]+='schedule function gomoku_game_test:'+('case/'+self.cases[i+1] if i+1<len(self.cases) else 'finish')+' 3t\n'


if __name__=='__main__':
    suite=Suite();suite.build();raise SystemExit(run(suite,prefix='fimel-gomoku-visual-',setup_ticks=180,manual_tick=True))
