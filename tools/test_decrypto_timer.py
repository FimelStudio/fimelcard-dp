"""26.2 isolated server: execute the real timer, timeout and scoring functions.

Only visual delivery and the next-round/end-game boundary are intercepted.
No player save or active table is opened.
"""
import json
import shutil
from pathlib import Path
from test_catan_engine import Suite, TABLE, OTHER, run

PACK=Path(__file__).resolve().parents[1]


def build():
    s=Suite()
    def call(name,table=TABLE):
        return [f'execute as {table} at @s run function decrypto:{name}']
    def setv(path,value):
        return [f'data modify entity {TABLE} data.decrypto.{path} set value '+json.dumps(value,separators=(',',':'))]
    def score(obj,value):return [f'scoreboard players set {TABLE} {obj} {value}']
    def eq(path,value,label):
        # NBT structural equality via the native data modification return value.
        return ['data modify storage decrypto_test:assert value set value '+json.dumps(value,separators=(',',':')),
                f'execute store success score #different ce run data modify storage decrypto_test:assert value set from entity {TABLE} data.decrypto.{path}']+s.score('#different','ce',0,label)
    def setup(mode=4,round=2):
        body=['kill @e[tag=ce.fixture]',
              'execute positioned 8 64 8 summon minecraft:marker run function catan_engine_test:table {table:101}',
              f'tag {TABLE} add dc.controller','scoreboard players set #clock dc_ctx 0',
              'scoreboard players set #rounds ce 0','scoreboard players set #finished ce 0']
        for obj,value in dict(dc_id=101,dc_state=2,dc_mode=mode,dc_round=round,dc_sync=1,dc_timer=1,dc_seconds=1,
                              dc_encode_limit=1,dc_guess_limit=2,dc_we=0,dc_be=0,dc_wi=0,dc_bi=0,
                              dc_w1=1,dc_w2=2,dc_w3=3,dc_b1=2,dc_b2=3,dc_b3=4,ct_paused=0).items():
            body+=score(obj,value)
        return body+setv('sync',{'white':{},'black':{},'answers':{}})
    clues=[{'text':'one'},{'text':'two'},{'text':'three'}]
    c=setup()+score('dc_encode_limit',-1)+score('dc_guess_limit',9)+call('timer/init')
    c+=s.score(TABLE,'dc_encode_limit',0,'invalid_encoding_limit_defaults_off')+s.score(TABLE,'dc_guess_limit',0,'invalid_guess_limit_defaults_off')
    for value,seconds in enumerate((0,60,90,120,180,240)):
        c+=score('dc_encode_limit',value)+call('timer/start {limit:"dc_encode_limit"}')
        c+=s.score(TABLE,'dc_seconds',seconds,f'limit_{value}_seconds')+s.score(TABLE,'dc_timer',20*seconds,f'limit_{value}_ticks')
    c+=score('dc_timer',61)+score('dc_seconds',4)+call('timer/tick')
    c+=s.score(TABLE,'dc_seconds',3,'seconds_round_up')+s.score(TABLE,'dc_timer',60,'tick_consumes_one')
    s.case('limits',c)
    c=setup()+score('ct_paused',1)+call('tick')+s.score(TABLE,'dc_timer',1,'paused_table_does_not_count_down')
    c+=score('ct_paused',0)+score('dc_timer',0)+call('tick')+s.score(TABLE,'dc_we',0,'unlimited_does_not_expire')
    c+=score('dc_timer',77)+call('sync/resume')+s.score(TABLE,'dc_timer',77,'resume_keeps_remaining_ticks')
    s.case('pause_resume',c)
    for missing in ('white','black','both'):
        c=setup()
        if missing!='white' and missing!='both':c+=setv('sync.white.clues',clues)
        if missing!='black' and missing!='both':c+=setv('sync.black.clues',clues)
        c+=call('timer/tick')
        for side,error,decode,intercept in [('white','dc_we','p6','p5'),('black','dc_be','p8','p7')]:
            absent=missing in (side,'both')
            c+=s.score(TABLE,error,int(absent),f'{missing}_{side}_encoding_error_once')
            if absent:
                c+=eq('sync.answers.'+decode,[-1]*3,f'{missing}_{side}_decode_cancelled')
                c+=eq('sync.answers.'+intercept,[-1]*3,f'{missing}_{side}_interception_cancelled')
            else:
                c+=s.check(f'entity {TABLE}',f'{missing}_{side}_table_survives')
                c+=['scoreboard players set #present ce 0',f'execute if data entity {TABLE} data.decrypto.sync.answers.{intercept} run scoreboard players set #present ce 1']+s.score('#present','ce',0,f'{missing}_{side}_interception_still_pending')
        if missing=='both':
            c+=s.score('#rounds','ce',1,'both_missing_advance_once')
        else:
            c+=s.score(TABLE,'dc_state',5,missing+'_starts_guess_phase')+s.score(TABLE,'dc_timer',1800,missing+'_fresh_guess_limit')
            # Correctly decode and intercept the valid password: no second
            # error for the cancelled password, and surviving interception scores.
            good=[2,3,4] if missing=='white' else [1,2,3]
            for answer in (('p8','p7') if missing=='white' else ('p6','p5')):
                c+=setv('sync.answers.'+answer,good)
            c+=call('timer/guess_timeout')+s.score(TABLE,'dc_we',int(missing=='white'),missing+'_red_error_not_duplicated')
            c+=s.score(TABLE,'dc_be',int(missing=='black'),missing+'_blue_error_not_duplicated')
            c+=s.score(TABLE,'dc_wi' if missing=='white' else 'dc_bi',1,missing+'_other_password_interception_scores')
        s.case('encoding_'+missing,c)
    c=setup()+setv('sync.white.clues',clues)+setv('sync.black.clues',clues)+score('dc_state',5)
    c+=setv('sync.answers.p6',[1,2,3])+setv('sync.answers.p7',[2,3,4])+call('timer/guess_timeout')
    c+=s.score(TABLE,'dc_we',0,'submitted_decode_preserved')+s.score(TABLE,'dc_be',1,'missing_decode_is_error')
    c+=s.score(TABLE,'dc_bi',0,'missing_intercept_has_no_success')+s.score(TABLE,'dc_wi',1,'submitted_intercept_preserved')
    c+=eq('sync.answers.p5',[0]*3,'missing_intercept_filled_failure')+s.score(TABLE,'dc_timer',0,'resolved_timer_stops')
    s.case('guess_timeout',c)
    c=setup(round=1)+setv('sync.white.clues',clues)+setv('sync.black.clues',clues)+score('dc_state',5)+call('timer/guess_timeout')
    c+=s.score(TABLE,'dc_we',1,'first_round_missing_red_decode')+s.score(TABLE,'dc_be',1,'first_round_missing_blue_decode')
    c+=['scoreboard players set #present ce 0',f'execute if data entity {TABLE} data.decrypto.sync.answers.p5 run scoreboard players set #present ce 1']+s.score('#present','ce',0,'first_round_no_intercept_answer')
    s.case('first_round',c)
    c=setup()+score('dc_we',1)+setv('sync.black.clues',clues)+call('timer/tick')
    c+=s.score('#finished','ce',1,'second_encoding_error_finishes')+s.score(TABLE,'dc_state',9,'finished_does_not_open_guess_phase')
    s.case('encoding_win',c)
    c=setup(mode=3)+setv('sync.white.clues',clues)+setv('sync.answers.p5',[1,2,3])+score('dc_state',5)+call('timer/guess_timeout')
    c+=s.score(TABLE,'dc_we',1,'three_player_decode_timeout_error')+s.score(TABLE,'dc_bi',1,'three_player_intercept_still_scores')+s.score('#finished','ce',1,'three_player_combined_threat_wins')
    s.case('three_player',c)
    c=setup()+setv('sync.black.clues',clues)+['data modify storage decrypto:input clues set value '+json.dumps(clues),'scoreboard players set #sync_team dc_ctx 1']+call('sync/save_clues')
    c+=call('tick')+s.score(TABLE,'dc_we',0,'deadline_submission_not_punished')+s.score(TABLE,'dc_state',5,'deadline_submission_opens_guess_phase')+s.score(TABLE,'dc_timer',1799,'old_deadline_does_not_expire_new_phase')
    c+=['execute positioned 40 64 8 summon minecraft:marker run function catan_engine_test:table {table:202}',f'scoreboard players set {OTHER} dc_timer 333']+call('timer/tick')+s.score(OTHER,'dc_timer',333,'other_table_timer_unchanged')
    s.case('boundary_isolation',c)
    s.finish()
    s.files['bootstrap']='\n'.join(['forceload add 0 0 63 31','scoreboard objectives add ce dummy','scoreboard objectives add ce_id dummy','scoreboard objectives add ct_ctx dummy','scoreboard objectives add ct_paused dummy','scoreboard players set #version ct_ctx 1','function decrypto:load',f'schedule function catan_engine_test:case/{next(iter(s.cases))} 5t'])+'\n'
    return s


def prepare(target):
    for ns in ('decrypto','fimel_title','fimel_sklibs'):
        shutil.copytree(PACK/f'data/{ns}',target/f'data/{ns}',dirs_exist_ok=True)
    root=target/'data/decrypto/function'
    # Presentation has no effect on the counters or authoritative answers.
    for name in ('marker/update','hint/update','title/update_all','title/render_all','notes/add_white','notes/add_black','hud/clear_clues'):
        (root/(name+'.mcfunction')).write_text('# Presentation boundary\n',encoding='utf-8')
    (root/'round/next.mcfunction').write_text('scoreboard players add #rounds ce 1\n',encoding='utf-8')
    (root/'game/finish.mcfunction').write_text('scoreboard players add #finished ce 1\nscoreboard players set @s dc_state 9\n',encoding='utf-8')
    (target/'data/minecraft/tags/function/load.json').write_text(json.dumps({'values':[]}),encoding='utf-8')


if __name__=='__main__':
    raise SystemExit(run(build(),prepare_target=prepare,prefix='fimel-decrypto-timer-',setup_ticks=200))
