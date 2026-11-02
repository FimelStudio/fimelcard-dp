"""原版26.2隔离GameTest：直接运行璀璨宝石生产规则，覆盖原子拒绝与整轮结算。"""
from pathlib import Path
import json
import shutil
from test_catan_engine import Suite, TABLE, OTHER, run

PACK = Path(__file__).resolve().parents[1]


class SplendorSuite(Suite):
    def call(self, name, table=101):
        return [f'execute as {TABLE if table==101 else OTHER} at @s run function splendor:engine/{name}']

    def setup(self, n=4, table=101, reset=True):
        return (['kill @e[tag=ce.fixture]'] if reset else []) + [
            f'execute positioned {8 if table==101 else 40} 64 8 summon minecraft:marker run function catan_engine_test:table {{table:{table}}}',
            f'scoreboard players set #players sp_ctx {n}'] + self.call('init', table)

    def set(self, path, value, table=101):
        return [f'data modify entity {TABLE if table==101 else OTHER} data.splendor.{path} set value ' + json.dumps(value, separators=(',', ':'))]

    def data(self, path, value, name, table=101):
        return [f'execute store result score #value ce run data get entity {TABLE if table==101 else OTHER} data.splendor.{path}'] + self.score('#value', 'ce', value, name)

    def action(self, actor, code, target=-1, take=None, pay=None, epoch=None, table=101):
        request = dict(actor=actor, code=code, target=target, take=take or [0]*6, pay=pay or [0]*6, epoch=epoch if epoch is not None else -1)
        out = ['data modify storage splendor:action input set value ' + json.dumps(request, separators=(',', ':'))]
        if epoch is None:
            out += [f'data modify storage splendor:action input.epoch set from entity {TABLE if table==101 else OTHER} data.splendor.epoch']
        return out + self.call('action', table)

    def snapshot(self, table=101):
        return [f'data modify storage splendor_engine_test:snapshot saved set from entity {TABLE if table==101 else OTHER} data.splendor']

    def unchanged(self, name, table=101):
        return [f'execute store success score #different ce run data modify storage splendor_engine_test:snapshot saved set from entity {TABLE if table==101 else OTHER} data.splendor'] + self.score('#different', 'ce', 0, name)

    def holdings(self, player, tokens, n=4):
        supply = {2: 4, 3: 5, 4: 7}[n]
        return self.set(f'p{player}.tokens', tokens) + self.set('bank', [(supply if k<5 else 5)-v for k,v in enumerate(tokens)])

    def conservation(self, name, n=4):
        out = []
        for k in range(6):
            out += [f'execute store result score #sum ce run data get entity {TABLE} data.splendor.bank[{k}]']
            for p in range(1,5):
                out += [f'execute store result score #part ce run data get entity {TABLE} data.splendor.p{p}.tokens[{k}]', 'scoreboard players operation #sum ce += #part ce']
            out += self.score('#sum', 'ce', 5 if k==5 else {2:4,3:5,4:7}[n], name+'_'+str(k))
        return out


def build_suite():
    s = SplendorSuite()
    def ok(name): return s.score('#ok', 'sp_ctx', 1, name)
    def bad(name, req, error):
        return s.snapshot()+req+s.score('#ok', 'sp_ctx', 0, name+'_rejected')+s.score('#error','sp_ctx',error,name+'_reason')+s.unchanged(name+'_atomic')

    for n in (2,3,4):
        body=s.setup(n)+s.data('phase',1,f'init{n}_phase')+s.data('n',n,f'init{n}_players')+s.data('market',12,f'init{n}_market')
        for tier,count in ((1,36),(2,26),(3,16)):
            body+=s.data(f'deck{tier}',count,f'init{n}_deck{tier}')
        body+=s.conservation(f'init{n}_supply',n)
        for i in range(5):
            body+=s.data(f'nobles[{i}]','0..9' if i<n+1 else -1,f'init{n}_noble{i}')
        body+=['data modify storage splendor_engine_test:ids all set from entity '+TABLE+' data.splendor.market']
        for tier in (1,2,3):
            body+=['data modify storage splendor_engine_test:ids all append from entity '+TABLE+f' data.splendor.deck{tier}[]']
        for card in range(90):
            body+=s.check(f'data storage splendor_engine_test:ids {{all:[{card}]}}',f'init{n}_card{card}')
        s.case('initial_'+str(n),body)

    body=s.setup()+bad('wrong_actor',s.action(2,1,take=[1,1,1,0,0,0]),4)
    body+=bad('expired',s.action(1,1,take=[1,1,1,0,0,0],epoch=0),3)
    body+=bad('fewer_when_full',s.action(1,1,take=[1,1,0,0,0,0]),6)
    body+=bad('gold_take',s.action(1,1,take=[1,1,0,0,0,1]),6)
    body+=bad('mixed_double',s.action(1,1,take=[2,1,0,0,0,0]),6)
    body+=bad('empty_take',s.action(1,1),6)
    body+=s.action(1,1,take=[1,1,1,0,0,0])+ok('take_three')+s.data('turn',2,'take_advances')+s.data('epoch',2,'take_epoch')+s.data('p1.token_count',3,'take_count')+s.conservation('take_conserve')
    body+=bad('previous_turn_replay',s.action(1,1,take=[1,1,1,0,0,0]),4)
    body+=s.action(2,1,take=[0,0,0,2,0,0])+ok('double_take')+s.data('p2.tokens[3]',2,'double_count')+s.conservation('double_conserve')
    s.case('take_and_security',body)

    body=s.setup()+s.set('bank',[2,0,0,0,0,0])+bad('double_under_four',s.action(1,1,take=[2,0,0,0,0,0]),6)
    body+=s.action(1,1,take=[1,0,0,0,0,0])+ok('one_remaining_color')
    body+=s.setup()+s.set('bank',[1,0,0,0,1,0])+s.action(1,1,take=[1,0,0,0,1,0])+ok('two_remaining_colors')
    body+=s.setup()+[f'scoreboard players set {TABLE} ct_paused 1']+bad('paused',s.action(1,1,take=[1,1,1,0,0,0]),13)
    s.case('thin_supply_pause',body)

    body=s.setup()+s.set('market[0]',0)+s.action(1,2,0)+ok('reserve_market')+s.data('p1.reserve[0]',0,'reserve_face')+s.data('p1.tokens[5]',1,'reserve_gold')+s.data('deck1',35,'reserve_refill')+s.conservation('reserve_conserve')
    body+=s.set('turn',1)+s.set('bank[5]',0)+s.action(1,2,12)+ok('reserve_blind_without_gold')+s.data('p1.reserve',2,'reserve_second')+s.data('deck1',34,'reserve_blind_deck')
    body+=s.set('turn',1)+s.action(1,2,13)+ok('reserve_third')+s.set('turn',1)+bad('reserve_limit',s.action(1,2,14),11)
    body+=s.setup()+s.set('deck3',[])+bad('empty_blind_deck',s.action(1,2,14),8)
    s.case('reservations',body)

    body=s.setup()+s.set('market[0]',0)+s.holdings(1,[0,2,0,0,0,1])
    body+=bad('wrong_payment',s.action(1,3,0,pay=[0,1,0,0,0,1]),12)
    body+=bad('overspend',s.action(1,3,0,pay=[0,4,0,0,0,0]),12)
    body+=s.action(1,3,0,pay=[0,2,0,0,0,1])+ok('gold_exact')+s.data('p1.cards[0]',0,'bought_id')+s.data('p1.bonus[0]',1,'bought_bonus')+s.data('p1.token_count',0,'payment_removed')+s.data('deck1',35,'bought_refill')+s.conservation('buy_conserve')
    body+=s.setup()+s.set('p1.reserve',[0,1])+s.set('p1.bonus',[0,0,4,0,0])+s.action(1,3,13)+ok('reserved_free')+s.data('p1.reserve',1,'reserve_removed')+s.data('p1.reserve[0]',0,'reserve_other_kept')+s.data('p1.cards[0]',1,'reserved_bought')+s.data('p1.vp',1,'reserved_vp')
    body+=s.setup()+s.set('market[0]',0)+s.set('p1.bonus',[0,3,0,0,0])+s.action(1,3,0)+ok('free_discount')
    s.case('purchases',body)

    body=s.setup()+s.holdings(1,[2,2,2,2,1,0])+s.action(1,1,take=[1,1,1,0,0,0])+ok('over_limit_taken')+s.data('phase',2,'discard_phase')+s.data('turn',1,'discard_keeps_actor')+s.data('discard_due',2,'discard_due')
    body+=bad('no_skip_discard',s.action(1,2,0),5)+bad('discard_under',s.action(1,4,take=[1,0,0,0,0,0]),7)+bad('discard_over',s.action(1,4,take=[1,1,1,0,0,0]),7)
    body+=s.action(1,4,take=[1,0,0,0,1,0])+ok('discard_choice')+s.data('p1.token_count',10,'discard_to_ten')+s.data('turn',2,'discard_advances')+s.data('p1.tokens[4]',0,'discard_old_token')+s.conservation('discard_conserve')
    s.case('discard',body)

    body=s.setup()+s.set('nobles',[0,-1,-1,-1,-1])+s.set('p1.bonus',[4,4,0,0,0])+s.action(1,2,0)+ok('single_noble_auto')+s.data('p1.nobles[0]',0,'noble_owned')+s.data('p1.vp',3,'noble_three_points')+s.data('nobles[0]',-1,'noble_removed')+s.data('turn',2,'noble_auto_advances')
    body+=s.setup()+s.set('nobles',[0,1,2,-1,-1])+s.set('p1.bonus',[4,4,4,0,0])+s.action(1,2,0)+ok('multi_noble_action')+s.data('phase',3,'noble_choice_phase')+s.data('eligible',2,'noble_two_eligible')
    body+=bad('noble_wrong',s.action(1,5,2),14)+bad('noble_no_skip',s.action(1,1,take=[1,1,1,0,0,0]),5)
    body+=s.action(1,5,1)+ok('noble_choose')+s.data('p1.nobles[0]',1,'noble_chosen')+s.data('p1.vp',3,'one_noble_only')+s.data('turn',2,'noble_choice_advances')+s.data('nobles[0]',0,'other_eligible_kept')
    s.case('nobles',body)

    body=s.setup()+s.set('p1.vp',15)+s.action(1,1,take=[1,1,1,0,0,0])+ok('final_trigger')+s.data('final_round',1,'final_flag')+s.data('phase',1,'final_not_early')
    for p in (2,3): body+=s.action(p,1,take=[1,1,1,0,0,0])+ok(f'final_p{p}')
    body+=s.action(4,1,take=[1,1,1,0,0,0])+ok('final_last')+s.data('phase',4,'final_finished')+s.data('winners[0]',1,'final_winner')+bad('finished_locked',s.action(4,1,take=[1,1,1,0,0,0]),5)
    body+=s.setup()+s.set('p1.vp',15)+s.set('p1.cards',[0,1])+s.set('p2.vp',15)+s.set('p2.cards',[2])+s.set('turn',4)+s.set('final_round',1)+s.action(4,1,take=[1,1,1,0,0,0])+s.data('winners[0]',2,'tiebreak_fewer_cards')
    body+=s.setup()+s.set('p1.vp',15)+s.set('p1.cards',[0])+s.set('p2.vp',15)+s.set('p2.cards',[2])+s.set('turn',4)+s.set('final_round',1)+s.action(4,1,take=[1,1,1,0,0,0])+s.data('winners',2,'shared_win')
    body+=s.setup()+s.set('p4.vp',15)+s.set('turn',4)+s.action(4,1,take=[1,1,1,0,0,0])+s.data('phase',4,'last_player_trigger_immediate')
    s.case('end_round_tiebreak',body)

    body=s.setup()+s.setup(n=2,table=202,reset=False)+s.snapshot(table=202)+s.action(1,1,take=[1,1,1,0,0,0])+ok('isolation_first')+s.unchanged('isolation_other_untouched',table=202)
    body+=s.action(1,2,12,table=202)+ok('isolation_second')+s.data('turn',2,'first_still_turn_two')+s.data('p1.reserve',0,'first_private_reserve_empty')+s.data('p1.reserve',1,'second_private_reserve',table=202)
    s.case('two_tables',body)

    body=s.setup()+s.snapshot()+s.action(1,1,take=[1,1,1,0,0,0],epoch=0)[:1]+[
        f'data modify storage splendor:action input.epoch set from entity {TABLE} data.splendor.epoch',
        'data modify storage splendor:action input.take[0] set value 1.5d']+s.call('action')+s.score('#error','sp_ctx',10,'fraction_reject')+s.unchanged('fraction_atomic')
    body+=s.snapshot()+s.action(1,1,take=[1,1,1,0,0,0],epoch=0)[:1]+[
        f'data modify storage splendor:action input.epoch set from entity {TABLE} data.splendor.epoch',
        'data modify storage splendor:action input.take set value [1,1,1]']+s.call('action')+s.score('#error','sp_ctx',10,'short_vector_reject')+s.unchanged('short_vector_atomic')
    s.case('malformed',body)
    s.finish()
    return s


def prepare(target):
    shutil.copytree(PACK/'data/splendor/function/engine', target/'data/splendor/function/engine')
    path=target/'data/minecraft/tags/function/load.json'
    path.write_text(json.dumps({'values':['splendor:engine/install']}),encoding='utf-8')
    # Pause is part of the production entry guard; the fixture needs its objective.
    bootstrap=target/'data/catan_engine_test/function/bootstrap.mcfunction'
    bootstrap.write_text('scoreboard objectives add ct_paused dummy\n'+bootstrap.read_text(encoding='utf-8'),encoding='utf-8')


if __name__=='__main__':
    raise SystemExit(run(build_suite(),prepare_target=prepare,prefix='fimel-splendor-engine-',setup_ticks=2500))
