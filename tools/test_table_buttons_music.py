"""Native 26.2 checks for rebuilt button bindings and per-table track music."""
import json
import shutil
from pathlib import Path
from boardgame_assets import RP
from test_catan_engine import Suite,TABLE,OTHER,run

PACK=Path(__file__).resolve().parents[1]


def build():
    s=Suite()
    def call(ns,name,who=TABLE):return [f'execute as {who} at @s run function {ns}:{name}']
    def score(name,value):return [f'scoreboard players set {TABLE} {name} {value}']
    def count(tag,expected,label,table=101,kind=None):
        select=f'@e[tag={tag},scores={{ct_id={table}'+(f',ct_kind={kind}' if kind is not None else '')+'}]'
        return ['scoreboard players set #count ce 0',f'execute as {select} run scoreboard players add #count ce 1']+s.score('#count','ce',expected,label)
    c=['execute positioned 8 64 8 summon minecraft:marker run function catan_engine_test:table {table:101}']
    for key,val in dict(ct_id=101,ct_capacity=8,ct_game=1,ct_state=0,ct_joined=0).items():c+=score(key,val)
    c+=call('cardtable','table/repair_buttons')+count('ct.menu',1,'one_start_hitbox',kind=22)
    c+=[f'execute store result score #y ce run data get entity @e[tag=ct.menu,scores={{ct_id=101,ct_kind=22}},limit=1] Pos[1] 1000']+s.score('#y','ce','65599..65601','start_hitbox_is_at_text_base')
    c+=s.check('data entity @e[tag=ct.menu,scores={ct_id=101,ct_kind=22},limit=1] {width:1.3f,height:0.23f}','start_hitbox_size')
    c+=count('ct.rules',12,'twelve_rule_strip_cells',kind=31)
    c+=score('ct_state',1)+call('cardtable','table/repair_buttons')+count('ct.vote',12,'twelve_vote_strip_cells',kind=30)
    c+=s.check(f'data entity {TABLE} data.cardtable{{button_regions_version:1}}','old_table_migration_marked')
    s.case('buttons',c)
    # Entity removals are finalized at tick boundaries. Check stable state
    # after a repeated refresh, as it occurs across reload/maintenance ticks.
    s.case('buttons_rebuild',call('cardtable','table/repair_buttons'))
    c=count('ct.vote',12,'repair_does_not_duplicate_vote_cells',kind=30)+count('ct.rules',12,'repair_does_not_duplicate_rule_cells',kind=31)
    c+=['execute positioned 40 64 8 summon minecraft:marker run function catan_engine_test:table {table:202}',f'scoreboard players set {OTHER} ct_id 202',f'scoreboard players set {OTHER} ct_capacity 8']
    c+=call('cardtable','rules/render',OTHER)+call('cardtable','table/repair_buttons')+count('ct.rules',12,'repair_preserves_other_table',202,31)
    s.case('buttons_isolation',c)
    ticks=json.loads((RP/'.source/magical_athlete/audio/manifest.json').read_text(encoding='utf-8'))['audio']['bgm_wild']['loop_ticks']
    c=score('ct_paused',0)+score('ma_music',1)+[f'data modify entity {TABLE} data.magical_athlete.track set value 0']
    c+=call('magical_athlete','sound/start')+s.score(TABLE,'ma_music_tick',640,'mild_loop_length')
    c+=[f'data modify entity {TABLE} data.magical_athlete.track set value 1']+call('magical_athlete','sound/tick')+s.score(TABLE,'ma_music_tick',ticks,'track_change_uses_full_wild_length')
    c+=s.check(f'data entity {TABLE} data.ma_sound{{track:1}}','wild_track_remembered')
    c+=score('ma_music_tick',1)+call('magical_athlete','sound/tick')+s.score(TABLE,'ma_music_tick',ticks,'wild_repeats_at_its_own_end')
    c+=score('ct_paused',1)+call('magical_athlete','sound/tick')+s.score(TABLE,'ma_music_tick',ticks,'pause_freezes_music_timer')
    c+=score('ct_paused',0)+[f'data modify entity {TABLE} data.magical_athlete.track set value 0']+call('magical_athlete','sound/tick')+s.score(TABLE,'ma_music_tick',640,'returning_to_mild_switches_immediately')
    c+=[f'scoreboard players set {OTHER} ma_music_tick 333']+call('magical_athlete','sound/tick')+s.score(OTHER,'ma_music_tick',333,'music_timer_isolated_by_table')
    c+=call('magical_athlete','sound/stop')+s.score(TABLE,'ma_music_tick',0,'stop_clears_loop_timer')
    c+=score('ma_music',0)+call('magical_athlete','sound/start')+s.score(TABLE,'ma_music_tick',0,'music_off_does_not_restart')
    s.case('music',c)
    s.finish()
    s.files['bootstrap']='\n'.join(['forceload add 0 0 63 31','scoreboard objectives add ce dummy','scoreboard objectives add ce_id dummy','scoreboard objectives add ct_ctx dummy','function cardtable:system/install','function cardtable:session/load','function magical_athlete:load',f'schedule function catan_engine_test:case/{next(iter(s.cases))} 40t'])+'\n'
    return s


def prepare(target):
    for ns in ('cardtable','magical_athlete','fimel_title','fimel_sklibs'):
        shutil.copytree(PACK/f'data/{ns}',target/f'data/{ns}',dirs_exist_ok=True)
    (target/'data/minecraft/tags/function/load.json').write_text(json.dumps({'values':[]}),encoding='utf-8')


if __name__=='__main__':
    raise SystemExit(run(build(),prepare_target=prepare,prefix='fimel-buttons-music-',setup_ticks=120))
