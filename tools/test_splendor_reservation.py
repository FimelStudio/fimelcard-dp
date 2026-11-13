"""Native 26.2 reservation confirmation; only client sneak input is bridged."""
import json
import shutil
from test_catan_engine import run
from test_splendor_game import Suite,TABLE,person,PACK,prepare as game_prepare


def build():
    s=Suite().build()
    fixtures={name:s.files[name] for name in ('table','person','bootstrap')}
    s.files=fixtures.copy();s.cases={};s.expected=[];s.waiting=set()
    def setup():
        return s.setup()+s.set('market[0]',0)+s.set('market[1]',1)+s.set('p1.tokens',[0,3,0,0,0,0])+[
            f'scoreboard players set {person()} sp_test_sneak 0']
    def hit(slot=0,sneak=1,cancel=False,epoch=None,table=101):
        lines=[f'scoreboard players set {person()} sp_test_sneak {sneak}',
               'data modify storage reserve_test:input hit set value '+json.dumps(dict(table=table,epoch=epoch or 1,kind=2,id=slot))]
        if epoch is None:lines+=[f'data modify storage reserve_test:input hit.epoch set from entity {TABLE} data.splendor.epoch']
        return lines+s.player('direct/'+('cancel' if cancel else 'use')+' with storage reserve_test:input hit')
    c=setup()+s.snapshot()+hit()+s.unchanged('first_shift_does_not_spend_or_reserve')
    c+=s.score(person(),'sp_select_stage',3,'first_shift_arms_reservation')
    c+=s.storage_equal('storage splendor:hud incoming.text','预约发展卡：再次潜行右键同一张牌确认；左键取消。','actionbar_explains_reservation')
    c+=s.score(person(),'sp_htimer','1..','reservation_notice_persists')
    c+=hit()+s.data('p1.reserve',[0],'second_shift_reserves_selected_card')+s.data('p1.tokens',[0,3,0,0,0,1],'reservation_awards_one_gold')
    s.case('shift_twice',c)
    c=setup()+hit(sneak=0)+s.snapshot()+hit()+s.unchanged('buy_selection_cannot_bypass_reserve_confirmation')
    c+=s.score(person(),'sp_select_stage',3,'changing_buy_to_reserve_arms_only')+hit()+s.data('p1.reserve',[0],'second_shift_after_mode_change_confirms')
    s.case('buy_to_reserve',c)
    c=setup()+hit()+s.snapshot()+hit(sneak=0)+s.unchanged('releasing_shift_does_not_buy_or_reserve')
    c+=s.score(person(),'sp_select_stage',1,'releasing_shift_previews_purchase')+hit(sneak=0)+s.data('p1.cards',[0],'second_plain_click_buys')+s.data('p1.reserve',[],'plain_purchase_is_not_reservation')
    s.case('reserve_to_buy',c)
    c=setup()+hit()+s.snapshot()+hit(slot=1)+s.unchanged('new_card_requires_new_confirmation')
    c+=s.score(person(),'sp_select_id',1,'new_card_selection_updated')+hit(slot=1)+s.data('p1.reserve',[1],'only_new_card_reserved')
    s.case('change_card',c)
    c=setup()+hit()+s.snapshot()+hit(cancel=True)+s.unchanged('left_cancel_does_not_submit')
    c+=s.score(person(),'sp_select_stage',0,'cancel_clears_reserve_mode')+hit()+s.unchanged('shift_after_cancel_only_arms_again')
    s.case('cancel',c)
    c=setup()+s.set('p1.reserve',[50,51,52])+hit()+hit()+s.data('p1.reserve',[50,51,52],'reserve_limit_still_enforced')
    c+=s.data('p1.tokens',[0,3,0,0,0,0],'rejected_reserve_does_not_award_gold')
    s.case('reserve_limit',c)
    c=setup()+hit()+s.set('epoch',2)+s.call('game/sync')+s.snapshot()+hit(epoch=1)+s.unchanged('stale_confirmation_rejected')
    c+=hit()+s.unchanged('fresh_epoch_requires_confirmation_again')
    s.case('stale_epoch',c)
    s.finish()
    s.files.update({name:fixtures[name] for name in ('table','person')})
    bootstrap=fixtures['bootstrap'].splitlines()
    bootstrap[-1]=f'schedule function catan_engine_test:case/{next(iter(s.cases))} 20t'
    s.files['bootstrap']='\n'.join(['scoreboard objectives add sp_test_sneak dummy']+bootstrap)+'\n'
    s.files['finish']='kill @e[tag=sg.fixture]\nkill @e[tag=sp.visual]\nsay CATAN_FINISHED\n'
    return s


def prepare(target):
    for ns in ('splendor','cardtable','fimel_title','fimel_sklibs'):
        shutil.copytree(PACK/f'data/{ns}',target/f'data/{ns}',dirs_exist_ok=True)
    game_prepare(target)
    path=target/'data/splendor/function/direct/card.mcfunction'
    source=path.read_text(encoding='utf-8')
    predicate='if predicate {condition:"minecraft:entity_properties",entity:"this",predicate:{flags:{is_sneaking:true}}}'
    assert predicate in source
    path.write_text(source.replace(predicate,'if score @s sp_test_sneak matches 1'),encoding='utf-8')


if __name__=='__main__':
    raise SystemExit(run(build(),prepare_target=prepare,prefix='fimel-splendor-reservation-',setup_ticks=200))
