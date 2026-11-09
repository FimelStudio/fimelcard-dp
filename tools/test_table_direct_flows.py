"""原版26.2临时世界：运动会与卡坦岛直接输入、原子提交与隔离。

仅在测试副本将玩家选择器桥接为marker；不伪造规则结果。
"""
import json
import shutil
from pathlib import Path
from catan_topology import EDGES, vertex_position
from test_magical_athlete_game import Suite, TABLE, OTHER, person, prepare as ma_prepare
from test_catan_engine import run


def build():
    s=Suite().build()
    fixture={k:v for k,v in s.files.items() if k in ('table','person')}
    s.files=fixture.copy();s.cases={};s.expected=[];s.waiting=set()
    def select(code,side=1,table=101,epoch=1):
        return s.player('direct/use_choice '+json.dumps(dict(code=code,table=table,epoch=epoch),separators=(',',':')),side,table)
    c=s.setup()+s.set('phase',1)+s.set('turn',1)+s.set('pool',list(range(12)))+s.call('game/sync')+s.snapshot()
    c+=select(100)+s.unchanged('draft_first_q_only_previews')+s.score(person(),'ma_confirm',100,'draft_preview_code')
    c+=select(100)+s.check(f'data entity {TABLE} data.magical_athlete.p1{{hand:[0]}}','draft_second_q_recruits')
    c+=s.score('#dialog','ce',0,'draft_no_dialog')
    s.case('ma_draft',c)
    c=s.setup()+s.set('p1.hand',[21,3,4,6,18,19,22,26])+s.set('p2.hand',[0,1,2,5,7,8,9,10])+s.set('phase',2)+s.call('game/sync')
    c+=select(221)+select(221)+s.data('p1.selected',[21],'lineup_first_selected')+s.data('p2.selected',[],'lineup_other_still_secret')+s.score(person(),'ma_dround',1,'private_lineup_first_order')
    c+=select(203,epoch=2)+select(203,epoch=2)+s.data('p1.selected',[21,3],'lineup_double_racer_order')+s.data('phase',2,'lineup_waits_for_other')+s.score(person(),'ma_dround',2,'private_lineup_second_order')
    c+=s.score('#dialog','ce',0,'lineup_no_dialog')
    s.case('ma_lineup',c)
    c=s.setup()+s.set('phase',1)+s.set('turn',1)+s.set('pool',list(range(12)))+s.call('game/sync')+s.snapshot()
    c+=select(100,side=2)+select(100,side=2)+s.unchanged('wrong_draft_player_rejected')
    c+=select(100,epoch=99)+select(100,epoch=99)+s.unchanged('stale_choice_rejected')
    c+=s.player('direct/use_choice {code:100,table:202,epoch:1}')+s.unchanged('cross_table_token_rejected')
    c+=[f'scoreboard players set {person()} ct_paused 1']+select(100)+s.unchanged('paused_choice_rejected')
    s.case('ma_guards',c)
    c=s.setup()+s.set('phase',1)+s.set('turn',1)+s.set('pool',list(range(12)))+s.call('game/sync')+s.player('direct/sync')+select(100)
    c+=[f'scoreboard players set {person()} ma_depoch -1']+s.player('direct/sync')+s.score(person(),'ma_confirm',100,'q_restore_preserves_confirmation')
    c+=select(100)+s.check(f'data entity {TABLE} data.magical_athlete.p1{{hand:[0]}}','q_restore_still_submits')
    s.case('ma_restore',c)
    c=s.setup()+s.set('phase',1)+s.set('pool',list(range(12)))+s.call('game/sync')+s.call('visual/refresh')
    c+=s.check('entity @e[tag=ma.pool,scores={ct_id=101}]','public_pool_on_table')
    c+=s.setup(table=202,reset=False)+s.set('phase',1,202)+s.set('pool',[20,21],202)+s.call('game/sync',202)+s.call('visual/refresh',202)
    c+=s.call('visual/clear')+s.check('entity @e[tag=ma.pool,scores={ct_id=202}]','clear_preserves_other_table_pool')
    s.case('ma_scene',c)
    c=s.setup()+s.set('phase',1)+s.set('turn',1)+s.set('pool',list(range(12)))+s.call('game/sync')+s.snapshot()
    c+=s.player('direct/use {table:101,epoch:1,type:1,id:0}',2)+s.unchanged('other_player_can_read_pool_without_recruiting')+s.equal('storage magical_athlete:direct detail.name','炼金术士','pool_read_shows_name')
    s.case('ma_public_pool_read',c)
    c=s.setup()+s.set('phase',3)+s.set('racers[0]',{'owner':1,'char':21,'power':21,'copy':-1,'pos':5,'trip':0,'status':0,'first':1,'prediction':-1,'done':0})+s.set('pending',{'kind':'genius','owner':1,'pawn':0,'options':[0,1,2,3,4,5,6]})+s.call('game/sync')+s.snapshot()
    c+=s.player('direct/use {table:101,epoch:1,type:2,id:0}',2)+s.unchanged('other_player_can_read_racer_without_acting')+s.equal('storage magical_athlete:direct detail.name','大长腿','racer_read_shows_ability_owner')
    c+=s.player('direct/use {table:101,epoch:1,type:2,id:0}')*2+s.unchanged('numeric_skill_not_cast_by_clicking_racer')
    s.case('ma_public_racer_read',c)
    c=s.setup()+s.set('phase',3)+s.set('racers[0]',{'owner':1,'char':4,'power':4,'pos':7,'trip':1,'status':0})+s.call('game/sync')
    c+=s.call('feedback/event {kind:3,pawn:0,from:7,to:7,source:2,amount:0,die:0}')
    c+=s.equal('storage magical_athlete:feedback event.name','半人马','feedback_identifies_affected_character')
    c+=s.equal(f'entity {person()} data.feedback_subtitle',{'text':'半人马：被绊倒，下次行动需先起身','color':'red'},'feedback_affected_owner_gets_subtitle')
    c+=s.check(f'entity {person(2)}', 'feedback_other_player_exists')
    c+=['scoreboard players set #unexpected ce 0',f'execute if data entity {person(2)} data.feedback_subtitle run scoreboard players set #unexpected ce 1']+s.score('#unexpected','ce',0,'feedback_other_owner_not_interrupted')
    c+=s.call('feedback/check')+s.call('feedback/check')+s.score('#state_changed','ma_ctx',0,'feedback_unchanged_state_not_reannounced')
    s.case('ma_feedback',c)
    for kind,options in {'ready':[0],'reroll':[0,1],'alchemist':[0,1],'rocket':[0,1],'cheerleader':[0,1],'hypnotist':[-1,0,1],'flip':[-1,0,1],'duel':[-1,1],'mastermind':[0,1],'copycat':[0,1],'genius':list(range(7)),'legs':[0,1],'egg':[0,21,35],'twin':list(range(36)),'suckerfish':[0,1],'thirdwheel':[-1,0,13,29]}.items():
        c=s.setup()+s.set('phase',3)+s.set('pending',{'kind':kind,'owner':1,'pawn':0,'options':options})
        for i in range(2):c+=s.set(f'racers[{i}]',{'owner':i+1,'char':i,'power':i,'copy':-1,'pos':5,'trip':0,'status':0,'first':1,'prediction':-1,'done':0})
        c+=s.call('game/sync')+s.player('direct/sync')+s.equal('storage magical_athlete:direct options',options,kind+'_inventory_options')
        c+=s.call('visual/refresh')+s.score('#dialog','ce',0,kind+'_no_forced_dialog')
        if kind=='thirdwheel':c+=s.check('entity @e[tag=ma.hit,scores={ma_dtype=3,ct_id=101}]','thirdwheel_has_board_cells')+s.player('direct/use {table:101,epoch:1,type:3,id:13}')+s.check('entity @e[tag=ma.cell_preview,scores={ct_id=101}]','thirdwheel_cell_preview_visible')
        if kind=='hypnotist':c+=s.check('entity @e[tag=ma.hit,scores={ma_dtype=2,ct_id=101}]','hypnotist_has_racer_targets')
        s.case('ma_skill_'+kind,c)
    # 卡坦岛复用同一真人身份fixture，生产上下文按ct_game和桌号重找控制器。
    def ca_setup(phase=4):
        c=s.setup(n=3)+[f'tag {TABLE} add ca.controller',f'scoreboard players set {TABLE} ct_game 21','scoreboard players set #players ca_ctx 3','scoreboard players set #layout ca_ctx 1']
        c += [f'execute as {TABLE} run function catan:engine/init']
        for i in (1,2,3):
            c += [f'tag {person(i)} add ca.player',f'scoreboard players set {person(i)} ca_side {i}',f'scoreboard players set {person(i)} ca_table 101',f'scoreboard players set {person(i)} ca_seat '+str([1,8,3][i-1]),f'execute as {person(i)} run function catan:ui/init']
        c += [f'data modify entity {TABLE} data.catan.phase set value {phase}',f'data modify entity {TABLE} data.catan.turn set value 1',f'scoreboard players set {TABLE} ca_anim 0',f'scoreboard players set {TABLE} ca_vtimer 0',f'scoreboard players set {TABLE} ca_orient 0',f'execute as {TABLE} run function catan:game/sync',f'execute as {person()} at @s run function catan:input/context']
        return c
    def cp(name,side=1):return [f'execute as {person(side)} at @s run function catan:{name}']
    def cv(path,v):return [f'data modify entity {TABLE} data.catan.{path} set value '+json.dumps(v,separators=(',',':'))]
    def eq(path,v,label):return s.equal(f'entity {TABLE} data.catan.{path}',v,label)
    c=ca_setup(5)+cv('p1.discard_due',4)+cv('p2.discard_due',0)+cv('p3.discard_due',0)
    c+=[f'execute as {TABLE} at @s run function catan:feedback/check']
    c+=s.equal(f'entity {person()} data.feedback_subtitle',{'text':'你需要弃掉 4 张资源','color':'red'},'catan_discard_personal_subtitle')
    c+=['scoreboard players set #unexpected ce 0',f'execute if data entity {person(2)} data.feedback_subtitle run scoreboard players set #unexpected ce 1']+s.score('#unexpected','ce',0,'catan_no_discard_no_subtitle')
    c+=[f'execute as {TABLE} at @s run function catan:feedback/check']+s.score('#state_changed','ca_ctx',0,'catan_same_state_not_reannounced')
    c+=cv('phase',3)+[f'execute as {TABLE} at @s run function catan:game/sync',f'execute as {TABLE} at @s run function catan:feedback/check']
    c+=s.equal(f'entity {person()} data.feedback_subtitle',{'text':'轮到你了 · 投骰或使用旧发展卡','color':'aqua'},'catan_turn_owner_subtitle')
    s.case('ca_feedback',c)
    c=ca_setup()+cv('p1.resources',[1,0,1,1,1])+['scoreboard players set #code ca_ctx 23']+cp('direct/confirm')+eq('p1.resources',[1,0,1,1,1],'buy_preview_no_payment')
    c+=['scoreboard players set #code ca_ctx 23']+cp('direct/confirm')+eq('p1.resources',[1,0,0,0,0],'buy_confirm_pays_once')
    c+=s.score('#dialog','ce',0,'catan_buy_no_dialog')
    s.case('ca_buy',c)
    c=ca_setup(5)+cv('p1.resources',[4,4,0,0,0])+cv('p1.discard_due',4)+cp('direct/discard_begin')
    c+=cp('direct/resource {id:0}')*2+eq('p1.resources',[4,4,0,0,0],'discard_not_paid_early')
    c+=cp('direct/undo')+s.score(person(),'ca_g0',1,'discard_undo_one')
    c+=cp('direct/resource {id:1}')*3+eq('p1.resources',[3,1,0,0,0],'discard_exact_atomic_commit')
    c+=eq('p1.discard_due',0,'discard_requirement_cleared')
    s.case('ca_discard',c)
    c=ca_setup()+cv('p1.resources',[4,0,0,0,0])+cp('direct/bank_begin')+cp('direct/resource {id:0}')+cp('direct/resource {id:1}')
    c+=s.score(person(),'ca_pay',0,'bank_pay_selection')+s.score(person(),'ca_receive',1,'bank_receive_selection')
    c+=['scoreboard players set #code ca_ctx 352']+cp('direct/confirm')+['scoreboard players set #code ca_ctx 352']+cp('direct/confirm')+eq('p1.resources',[0,1,0,0,0],'bank_exchange_without_dialog')
    s.case('ca_bank',c)
    c=ca_setup()+cv('p1.dev',[0,0,1,1,0])+cp('direct/dev_use {id:2,fresh:0}')*2+s.score(person(),'ca_edit',4,'monopoly_opens_inventory_choices')
    c+=cp('direct/resource {id:3}')+s.score(person(),'ca_a',3,'monopoly_resource_selected')
    c+=cp('direct/dev_use {id:0,fresh:1}')+eq('p1.dev',[0,0,1,1,0],'fresh_card_not_consumed')
    s.case('ca_development',c)
    for cap,radius in [(4,.25),(8,.35)]:
        for orient in (0,1):
            a,b=EDGES[0];ax,az=vertex_position(a,radius,orient);bx,bz=vertex_position(b,radius,orient)
            x,z=(ax+bx)/2,(az+bz)/2
            c=ca_setup()+cv(f'vertex_owner[{a}]',1)+cv(f'vertex_level[{a}]',1)+cv('p1.resources',[1,1,0,0,0])+[f'scoreboard players set {TABLE} ct_capacity {cap}',f'scoreboard players set {TABLE} ca_orient {orient}',f'execute at {TABLE} positioned ~{x} ~2 ~{z} run tp {person()} ~ ~ ~ 0 90']
            c+=cp('direct/q_aim {build:3}')+s.score(person(),'ca_mode',3,f'q_build_mode_{cap}_{orient}')+eq('road_owner[0]',0,f'q_road_preview_{cap}_{orient}')
            c+=cp('direct/q_aim {build:3}')+eq('road_owner[0]',1,f'q_road_confirm_{cap}_{orient}')+eq('p1.resources',[0,0,0,0,0],f'q_road_paid_{cap}_{orient}')
            s.case(f'ca_q_build_{cap}_{orient}',c)
    table=fixture['table']
    s.finish();s.files['table']=table
    s.files['bootstrap']='\n'.join(['forceload add 0 0 63 31','scoreboard objectives add ce dummy','scoreboard objectives add mg_pid dummy','function cardtable:system/install','function cardtable:session/load','function magical_athlete:load','function catan:load',f'schedule function catan_engine_test:case/{next(iter(s.cases))} 5t'])+'\n'
    s.files['finish']='kill @e[tag=mg.fixture]\nkill @e[tag=ma.visual]\nkill @e[tag=ma.direct]\nkill @e[tag=ca.visual]\nkill @e[tag=ca.deck_direct]\nsay CATAN_FINISHED\n'
    return s


def prepare(target):
    pack=Path(__file__).resolve().parents[1]
    for ns in ('catan','magical_athlete','cardtable','fimel_title','fimel_sklibs'):
        shutil.copytree(pack/f'data/{ns}',target/f'data/{ns}',dirs_exist_ok=True)
    ma_prepare(target)
    import re
    for path in (target/'data/catan/function').rglob('*.mcfunction'):
        lines=[]
        for line in path.read_text(encoding='utf-8').splitlines():
            if not any(t in line for t in ('dialog show ','dialog clear ','tellraw ','playsound ','stopsound ','particle ','run title ','title @')):
                line=re.sub(r'@a\[','@e[type=minecraft:marker,tag=mg.person,',line).replace('@a ','@e[type=minecraft:marker,tag=mg.person] ')
            lines.append(line)
            if 'dialog show ' in line:lines.append('scoreboard players add #dialog ce 1')
        path.write_text('\n'.join(lines)+'\n',encoding='utf-8')
    # 标题只能发给真人：测试副本记录原始组件，验证实际被提醒的身份。
    for ns in ('catan','magical_athlete'):
        (target/f'data/{ns}/function/feedback/subtitle.mcfunction').write_text('$data modify entity @s data.feedback_subtitle set value $(text)\n',encoding='utf-8')
    (target/'data/minecraft/tags/function/load.json').write_text(json.dumps({'values':['magical_athlete:load','catan:load']}),encoding='utf-8')


if __name__=='__main__':raise SystemExit(run(build(),prepare_target=prepare,prefix='fimel-direct-flows-',setup_ticks=200))
