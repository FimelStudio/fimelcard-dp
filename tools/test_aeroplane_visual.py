"""飞行棋真实26.2展示验收：骰面定格、跨刻翻滚、飞机插值和返航。"""
from test_aeroplane_chess import Suite as Base, TABLE, OTHER, plane, run
from test_aeroplane_geometry import manifest, expected_point


class Suite(Base):
    def numeric(self,entity,path,expected,label,tolerance=3):
        return [f'execute store result score #numeric ag run data get entity {entity} {path} 100000']+self.check(
            f'score #numeric ag matches {round(expected*100000)-tolerance}..{round(expected*100000)+tolerance}',label)

    def build(self):
        data=manifest()
        self.file('reset',['kill @e[tag=ac.visual]','kill @e[tag=ac.plane]','kill @e[tag=ac.side]','kill @e[tag=ag.table]'])
        self.file('table','''
tag @s add ag.table
tag @s add ct.controller
tag @s add ac.controller
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ct_capacity $(cap)
$scoreboard players set @s ac_orient $(orient)
scoreboard players set @s ct_game 15
scoreboard players set @s ct_state 0
scoreboard players set @s ac_state 0
scoreboard players set @s ac_palette 0
scoreboard players set @s ac_roll 1
scoreboard players set @s ac_selected -1
scoreboard players set @s ac_turn 0
scoreboard players set @s ac_hints 1
function aeroplane_chess:engine/init_board
function aeroplane_chess:visual/setup
''')
        for cap in (4,8):
            for orient in (0,1):
                label=f'preview_{cap}_{orient}'
                c=self.setup(cap,orient)
                for tag,count in [('ac.man',16),('ac.plane_click',16),('ac.die',1),('ac.dice_click',1),('ac.board_display',1)]:
                    c+=self.count(f'@e[tag={tag},scores={{ct_id=101}}]',count,label+'_'+tag.replace('.','_'))
                c+=self.check('data entity @e[tag=ac.board_display,limit=1] item.components{"minecraft:item_model":"card:aeroplane_chess/board/classic"}',label+'_classic_only')
                c+=self.numeric('@e[tag=ac.die,scores={ct_id=101},limit=1]','transformation.translation[1]',{4:2.7,8:3.6}[cap]/data['grid']*.8*7/16+.012,label+'_die_rests_on_board')
                c+=[f'scoreboard players set @e[tag=ac.board,scores={{ac_color=1}}] ac_active 0',f'scoreboard players set @e[tag=ac.board,scores={{ac_color=3}}] ac_active 0']+self.call('visual/refresh')
                c+=self.count('@e[tag=ac.man,scores={ct_id=101}]',8,label+'_inactive_hidden')
                self.case(label,c)
        # Independent literal face rotations, verified against native model normals by asset test.
        rotations={1:(0,0,0,1),2:(2**-.5,0,0,2**-.5),3:(0,0,2**-.5,2**-.5),
                   4:(0,0,-2**-.5,2**-.5),5:(-2**-.5,0,0,2**-.5),6:(1,0,0,0)}
        die='@e[tag=ac.die,scores={ct_id=101},limit=1]'
        for roll,q in rotations.items():
            c=self.setup()+[f'scoreboard players set {TABLE} ac_roll {roll}']
            for timer in (20,15,10,5,0):
                c+=[f'scoreboard players set {TABLE} ac_timer {timer}']+self.call('visual/roll_tick')
                c+=self.score(TABLE,'ac_roll',roll,f'die_{roll}_{timer}_locked')
                c+=self.check(f'data entity {die} {{interpolation_duration:1}}',f'die_{roll}_{timer}_smooth')
            c+=self.call('visual/roll_done')
            for i,value in enumerate(q):c+=self.numeric(die,f'transformation.left_rotation[{i}]',value,f'die_{roll}_quaternion_{i}')
            self.case('die_'+str(roll),c)
        # Cross-tick motion begins with the original pose and locks to its exact endpoint.
        step=2.7/data['grid']
        start=expected_point(data,0,1,0,2.7,0)
        end=expected_point(data,0,1,1,2.7,0)
        man='@e[tag=ac.man,scores={ct_id=101,ac_color=0,ac_plane=1},limit=1]'
        c=self.setup()+[f'scoreboard players set {plane(0,1)} ac_pos 0']+self.call('visual/refresh')
        c+=[f'scoreboard players set {TABLE} ac_selected 1',f'scoreboard players set {TABLE} ac_frompos 0',f'scoreboard players set {TABLE} ac_topos 1',f'scoreboard players set {TABLE} ac_kind 3',f'scoreboard players set {TABLE} ac_timer 4']+self.call('visual/move')
        c+=self.numeric(man,'transformation.translation[0]',start['x'],'move_initial_x')
        c+=self.numeric(man,'transformation.translation[2]',start['z'],'move_initial_z')
        self.cases.append('move_begin');self.file('case/move_begin',c+['schedule function aeroplane_test:move_next 1t'])
        c=[f'scoreboard players set {TABLE} ac_timer 2']+self.call('visual/move_tick')
        c+=self.numeric(man,'transformation.translation[0]',(start['x']+end['x'])/2,'move_midpoint_x')
        c+=self.numeric(man,'transformation.translation[2]',(start['z']+end['z'])/2,'move_midpoint_z')
        c+=self.numeric(man,'transformation.translation[1]',step*.72*.5+.012+.175,'move_flight_arc')
        c+=self.call('visual/finish_move')+self.numeric(man,'transformation.translation[0]',end['x'],'move_endpoint_x')
        c+=self.numeric(man,'transformation.translation[2]',end['z'],'move_endpoint_z')
        c+=self.numeric(man,'transformation.translation[1]',step*.72*.5+.012,'move_endpoint_height')
        c+=self.score(plane(0,1),'ac_pos',0,'visual_does_not_commit_logic')
        c+=self.check(f'data entity {TABLE} data.aeroplane_visual{{color:0,plane:1,total:4}}','movement_snapshot')
        c+=self.check(f'data entity {TABLE} data.aeroplane_visual.from','movement_from_saved')
        self.file('move_next',c)
        c=self.setup()+[f'scoreboard players set {plane(1,2)} ac_pos 10']+self.call('visual/refresh')
        c+=[f'scoreboard players set {plane(1,2)} ac_prev 10',f'scoreboard players set {plane(1,2)} ac_pos -1',f'tag {plane(1,2)} add ac.captured']+self.call('visual/capture')
        captured='@e[tag=ac.man,scores={ct_id=101,ac_color=1,ac_plane=2},limit=1]'
        c+=self.check(f'data entity {captured} {{interpolation_duration:6}}','capture_six_tick_return')
        c+=self.score(plane(1,2),'ac_pos',-1,'capture_preserves_logical_hangar')
        hangar=expected_point(data,1,2,-1,2.7,0)
        c+=self.numeric(captured,'transformation.translation[0]',hangar['x'],'capture_hangar_x')
        c+=self.numeric(captured,'transformation.translation[2]',hangar['z'],'capture_hangar_z')
        self.case('capture',c)
        c=self.setup()+[f'scoreboard players set {TABLE} ac_state 3',f'scoreboard players set {plane(0,0)} ac_legal 1',f'scoreboard players set {plane(0,2)} ac_legal 1',f'scoreboard players set {plane(2,0)} ac_legal 1']+self.call('visual/select')
        c+=self.count('@e[tag=ac.highlight,scores={ct_id=101}]',2,'hints_only_current_color')
        c+=[f'scoreboard players set {TABLE} ac_hints 0']+self.call('visual/select')+self.count('@e[tag=ac.highlight,scores={ct_id=101}]',0,'hints_disabled')
        self.case('hints',c)
        c=self.setup()+self.setup(8,1,202,False)+self.call('visual/clear')
        c+=self.count('@e[tag=ac.visual,scores={ct_id=101}]',0,'clear_own')
        c+=self.count('@e[tag=ac.visual,scores={ct_id=202}]',35,'clear_other_kept')
        self.case('isolation',c)
        self.position_alignment(data)
        self.file('finish',['function aeroplane_test:reset','say AEROPLANE_FINISHED'])
        self.file('bootstrap',['forceload add -16 -16 63 31','scoreboard objectives add ag dummy','function aeroplane_chess:load','schedule function aeroplane_test:case/'+self.cases[0]+' 20t'])
        for i,name in enumerate(self.cases):
            key='move_next' if name=='move_begin' else 'case/'+name
            self.files[key]+='schedule function aeroplane_test:'+('case/'+self.cases[i+1] if i+1<len(self.cases) else 'finish')+' 1t\n'

    def position_alignment(self,data):
        """逐点校验真实macro生成的模型、碰撞实体与已画出的格心同位。

        环格取本色飞机，52个global索引均能用合法相对位置3/7/.../51访问。
        额外覆盖全部16停机位、四个起飞位与24格内道，分批限制函数链长度。
        """
        points=[]
        for index in range(52):
            color=(index+2)%4
            relative=(index-data['colors'][color]['start'])%52+1
            assert relative<=51
            points.append((color,0,relative,f'ring{index}'))
        for color in range(4):
            points.extend((color,number,-1,f'hangar{color}_{number}') for number in range(4))
            points.append((color,0,0,f'launch{color}'))
            points.extend((color,0,position,f'home{color}_{position}') for position in range(52,58))
        for cap,foot in ((4,2.7),(8,3.6)):
            for orient in (0,1):
                for batch in range(0,len(points),6):
                    lines=self.setup(cap,orient)
                    for color,number,position,name in points[batch:batch+6]:
                        key=f'align_{cap}_{orient}_{name}'
                        man=f'@e[tag=ac.man,scores={{ct_id=101,ac_color={color},ac_plane={number}}},limit=1]'
                        hit=f'@e[tag=ac.plane_click,scores={{ct_id=101,ac_color={color},ac_plane={number}}},limit=1]'
                        expected=expected_point(data,color,number,position,foot,orient)
                        lines+=['scoreboard players set @e[tag=ac.board] ac_active 0',
                                f'scoreboard players set {plane(color,number)} ac_active 1',
                                f'scoreboard players set {plane(color,number)} ac_pos {position}']+self.call('visual/refresh')
                        lines+=self.count('@e[tag=ac.man,scores={ct_id=101}]',1,key+'_one_model')
                        lines+=self.count('@e[tag=ac.plane_click,scores={ct_id=101}]',1,key+'_one_hit')
                        for axis,index in [('x',0),('z',2)]:
                            lines+=self.numeric(man,f'transformation.translation[{index}]',expected[axis],key+'_model_'+axis)
                            # setup 使用整数绝对坐标8，Minecraft会自动置中成8.5。
                            lines+=self.numeric(hit,f'Pos[{index}]',8.5+expected[axis],key+'_hit_'+axis)
                        lines+=self.numeric(man,'transformation.left_rotation[1]',expected['qy'],key+'_facing_y')
                        lines+=self.numeric(man,'transformation.left_rotation[3]',expected['qw'],key+'_facing_w')
                        lines+=self.numeric(hit,'width',foot/data['grid']*.72,key+'_hit_width')
                        model='card:aeroplane_chess/plane/classic_'+data['colors'][color]['name']
                        lines+=self.check(f'data entity {man} item.components{{"minecraft:item_model":"{model}"}}',key+'_piece_color')
                    self.case(f'position_batch_{cap}_{orient}_{batch//6}',lines)


if __name__=='__main__':
    suite=Suite();suite.build();raise SystemExit(run(suite))
