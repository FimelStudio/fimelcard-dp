"""原版隔离验收：购买提示计入折扣、黄金，并按当前玩家、本桌和实际牌位绘制。"""
import json
import shutil
from pathlib import Path
from test_catan_engine import Suite, TABLE, run

PACK = Path(__file__).resolve().parents[1]
VIEWER = '@e[tag=sa.viewer,limit=1]'


def build_suite():
    s = Suite()
    def setup():
        return ['kill @e[tag=ce.fixture]',
                'execute positioned 8 64 8 summon minecraft:marker run function catan_engine_test:table {table:101}',
                f'scoreboard players set {TABLE} ct_id 101',
                f'scoreboard players set {TABLE} ct_state 1',
                f'scoreboard players set {TABLE} ct_paused 0',
                f'scoreboard players set {TABLE} sp_state 1',
                f'scoreboard players set {TABLE} sp_anim 0',
                f'scoreboard players set {TABLE} sp_turn 1',
                f'data merge entity {TABLE} {{data:{{splendor:{{turn:1,market:[0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],p1:{{tokens:[0,3,0,0,0,0],bonus:[0,0,0,0,0]}},p2:{{tokens:[0,0,0,0,0,0],bonus:[0,0,0,0,0]}}}}}}}}',
                'summon minecraft:marker 8 64 8 {Tags:["ce.fixture","sa.viewer","sp.player","ct.player"]}',
                f'scoreboard players set {VIEWER} ct_id 101',
                f'scoreboard players set {VIEWER} sp_table 101',
                f'scoreboard players set {VIEWER} sp_side 1',
                'summon minecraft:interaction 8.7 65.07 8.6 {Tags:["ce.fixture","sa.hit","sp.hit"],width:0.44f}',
                'scoreboard players set @e[tag=sa.hit,limit=1] sp_table 101',
                'scoreboard players set @e[tag=sa.hit,limit=1] sp_vkind 2',
                'scoreboard players set @e[tag=sa.hit,limit=1] sp_vid 0',
                'scoreboard players set #emitted ce 0']
    def call():
        return [f'execute as {TABLE} at @s run function splendor:visual/affordable/tick']
    def set_data(path, value):
        return [f'data modify entity {TABLE} data.splendor.{path} set value '+json.dumps(value)]

    c=setup()+call()+s.score('#emitted','ce',1,'three_sapphires_can_buy_three_cost')
    c+=s.check('data storage splendor_affordable_test:trace {pos:[8.7d,65.07d,8.6d]}','particle_uses_rotated_hit_position')
    c+=s.check('entity '+VIEWER.replace('limit=1','tag=!sp.affordable_viewer,limit=1'),'temporary_viewer_tag_cleared')
    c+=s.score('#aff_x','sp_ctx','18998..19001','particle_outside_card_width')
    c+=s.score('#aff_z','sp_ctx','24498..24501','particle_outside_card_depth')
    s.case('affordable_position',c)
    for yaw,x,z in ((0,8.89,8.845),(90,8.455,8.79),(180,8.51,8.355),(270,8.945,8.41)):
        c=setup()+[f'data merge entity @e[tag=sa.hit,limit=1] {{Rotation:[{yaw}f,0f]}}']+call()
        for axis,value in ((0,x),(2,z)):
            scaled=round(value*100000)
            c+=['execute store result score #corner ce run data get entity @e[tag=sa.corner,limit=1] Pos['+str(axis)+'] 100000']
            c+=s.score('#corner','ce',f'{scaled-5}..{scaled+5}',f'rotation_{yaw}_corner_{axis}')
        s.case('rotation_'+str(yaw),c)
    for name, tokens, bonus, expected in (
        ('insufficient', [0,2,0,0,0,0], [0]*5, 0),
        ('gold_exact', [0,1,0,0,0,2], [0]*5, 1),
        ('gold_short', [0,1,0,0,0,1], [0]*5, 0),
        ('discount', [0,1,0,0,0,0], [0,2,0,0,0], 1),
        ('free', [0]*6, [0,3,0,0,0], 1),
        ('wrong_color', [3,0,0,0,0,0], [0]*5, 0),
    ):
        c=setup()+set_data('p1.tokens',tokens)+set_data('p1.bonus',bonus)+call()
        s.case(name,c+s.score('#emitted','ce',expected,name+'_particle'))
    for name, command in (
        ('paused',f'scoreboard players set {TABLE} ct_paused 1'),
        ('lobby',f'scoreboard players set {TABLE} ct_state 0'),
        ('discard',f'scoreboard players set {TABLE} sp_state 2'),
        ('noble',f'scoreboard players set {TABLE} sp_state 3'),
        ('finished',f'scoreboard players set {TABLE} sp_state 4'),
        ('animation',f'scoreboard players set {TABLE} sp_anim 1'),
        ('other_turn',f'scoreboard players set {VIEWER} sp_side 2'),
        ('other_table',f'scoreboard players set @e[tag=sa.hit,limit=1] sp_table 202'),
        ('empty_slot',f'data modify entity {TABLE} data.splendor.market[0] set value -1'),
    ):
        s.case(name,setup()+[command]+call()+s.score('#emitted','ce',0,name+'_no_particle'))
    c=setup()+set_data('turn',2)+set_data('p2.tokens',[0,3,0,0,0,0])+set_data('p1.tokens',[0]*6)
    c+=[f'scoreboard players set {TABLE} sp_turn 2',f'scoreboard players set {VIEWER} sp_side 2']+call()
    s.case('next_turn',c+s.score('#emitted','ce',1,'new_turn_reads_new_player_holdings'))
    s.finish()
    return s


def prepare(target):
    dest=target/'data/splendor/function/visual/affordable'
    shutil.copytree(PACK/'data/splendor/function/visual/affordable',dest)
    # 只将玩家选择桥接到 marker。实际粒子命令保留，由原版解析。
    tick=dest/'tick.mcfunction'
    tick.write_text(tick.read_text(encoding='utf-8').replace('@a[','@e[type=minecraft:marker,'),encoding='utf-8')
    emit=dest/'emit.mcfunction'
    emit.write_text(emit.read_text(encoding='utf-8')+'scoreboard players add #emitted ce 1\ndata modify storage splendor_affordable_test:trace pos set from entity @s Pos\n',encoding='utf-8')
    emit_at=dest/'emit_at.mcfunction'
    emit_at.write_text(emit_at.read_text(encoding='utf-8')+'$execute rotated as @s positioned ^$(x) ^0.035 ^$(z) run summon minecraft:marker ~ ~ ~ {Tags:["ce.fixture","sa.corner"]}\n',encoding='utf-8')
    shutil.copytree(PACK/'data/splendor/function/engine',target/'data/splendor/function/engine')
    load=target/'data/splendor_affordable_test/function/load.mcfunction'
    load.parent.mkdir(parents=True)
    objectives=('ct_id','ct_state','ct_paused','sp_table','sp_side','sp_state','sp_anim','sp_turn','sp_vid','sp_vkind')
    load.write_text('\n'.join(f'scoreboard objectives add {name} dummy' for name in objectives)+'\nfunction splendor:engine/install\n',encoding='utf-8')
    (target/'data/minecraft/tags/function/load.json').write_text(json.dumps({'values':['splendor_affordable_test:load']}),encoding='utf-8')


if __name__=='__main__':
    raise SystemExit(run(build_suite(),prepare_target=prepare,prefix='fimel-splendor-affordable-'))
