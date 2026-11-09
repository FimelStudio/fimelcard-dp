"""璀璨宝石 HUD 相对排序：运行实际行构建，只桥接 BetterTitle 的最终文字输出。"""
import json
import shutil
from pathlib import Path
from test_catan_engine import Suite, TABLE, run

PACK=Path(__file__).resolve().parents[1]
VIEWER='@e[tag=sh.viewer,limit=1]'


def build_suite():
    s=Suite()
    for n in (2,3,4):
        for viewer in range(1,n+1):
            name=f'{n}_players_viewer_{viewer}'
            state={'n':n,'turn':2,'round':1}
            for side in range(1,5):
                state[f'p{side}']={'name':{'text':f'Player{side}'},'vp':side,'cards':[],
                                  'nobles':[],'reserve':[],'tokens':[side]*6,'bonus':[side]*5}
            c=['kill @e[tag=ce.fixture]',
               'execute positioned 8 64 8 summon minecraft:marker run function catan_engine_test:table {table:101}',
               f'tag {TABLE} add sp.current',f'scoreboard players set {TABLE} ct_id 101',
               f'scoreboard players set {TABLE} sp_turn 2',
               f'data modify entity {TABLE} data.splendor set value '+json.dumps(state),
               'summon minecraft:marker 8 64 8 {Tags:["ce.fixture","sh.viewer","sp.hud"]}',
               f'scoreboard players set {VIEWER} sp_table 101',
               f'scoreboard players set {VIEWER} sp_side {viewer}',
               f'scoreboard players set {VIEWER} sp_hpanel 1',
               f'scoreboard players set {VIEWER} sp_htimer 0',
               'data modify storage splendor_hud_test:trace lines set value []',
               'data modify storage splendor_hud_test:trace names set value []',
               f'execute as {VIEWER} run function splendor:hud/build']
            expected=[{'text':f'Player{(viewer+i-1)%n+1}'} for i in range(n)]
            c+=['data modify storage splendor_hud_test:trace expected set value '+json.dumps(expected),
                'execute store success score #different ce run data modify storage splendor_hud_test:trace expected set from storage splendor_hud_test:trace names']
            c+=s.score('#different','ce',0,name+'_relative_player_order')
            c+=['execute store result score #lines ce run data get storage splendor_hud_test:trace lines']
            c+=s.score('#lines','ce',4*n+1,name+'_no_game_heading')
            c+=s.check('data storage splendor_hud_test:trace {lines:[{x:8d,y:-8d,origin:"up-left",align:"left"}]}',name+'_self_top_left')
            for i in range(n):
                origin='up-left' if i%2==0 else 'up-right'
                y=-8 if i<2 else -64
                c+=[f'data modify storage splendor_hud_test:trace cmp set from storage splendor_hud_test:trace lines[{i*4}]']
                c+=s.check(f'data storage splendor_hud_test:trace cmp{{origin:"{origin}",y:{y}d}}',name+f'_row_{i}_anchor')
            turn_slot=((2-viewer)%n)*4
            c+=[f'data modify storage splendor_hud_test:trace cmp set from storage splendor_hud_test:trace lines[{turn_slot}].text.extra[0]']
            c+=s.check('data storage splendor_hud_test:trace cmp{text:"▶ "}',name+'_turn_marker_follows_player')
            s.case(name,c)
    s.finish()
    return s


def prepare(target):
    dest=target/'data/splendor/function/hud'
    shutil.copytree(PACK/'data/splendor/function/hud',dest)
    row=dest/'row.mcfunction'
    row.write_text(row.read_text(encoding='utf-8')+'data modify storage splendor_hud_test:trace names append from storage splendor:hud player.name\n',encoding='utf-8')
    helper=target/'data/fimel_title/function'
    helper.mkdir(parents=True)
    (helper/'new_text.mcfunction').write_text('\n'.join([
        'data modify storage splendor_hud_test:trace line set value {}',
        *[f'data modify storage splendor_hud_test:trace line.{field} set from storage fimel_title:io {field}' for field in ('text','x','y','origin','align')],
        'data modify storage splendor_hud_test:trace lines append from storage splendor_hud_test:trace line',
    ])+'\n',encoding='utf-8')
    (helper/'replace_panel.mcfunction').write_text('return 0\n',encoding='utf-8')
    # 所有测试参与者已经持有面板；保留未走到的路径以检查函数引用。
    (helper/'new_panel.mcfunction').write_text('return 0\n',encoding='utf-8')
    code=helper/'code'
    code.mkdir()
    (code/'load.mcfunction').write_text('return 0\n',encoding='utf-8')
    load=target/'data/splendor_hud_test/function/load.mcfunction'
    load.parent.mkdir(parents=True)
    objectives=('sp_ctx','ct_id','sp_table','sp_side','sp_turn','sp_hpanel','sp_htimer','fbt_panel','fbt_io')
    load.write_text('\n'.join(f'scoreboard objectives add {name} dummy' for name in objectives)+'\n',encoding='utf-8')
    (target/'data/minecraft/tags/function/load.json').write_text(json.dumps({'values':['splendor_hud_test:load']}),encoding='utf-8')


if __name__=='__main__':
    raise SystemExit(run(build_suite(),prepare_target=prepare,prefix='fimel-splendor-hud-'))
