"""隔离原版 26.2：围棋生命周期、同意悔棋、计分与复盘。

只在临时副本把服务端真人身份换成盔甲架，保留真实规则与公共座椅实现。
测试世界不读取、不更改用户存档，命令链预算保持默认 65536。
"""
from pathlib import Path
import re
from test_guandan_cards import Suite as BaseSuite, run, PACK

C='@e[type=minecraft:marker,tag=wg.table,scores={ct_id=101},limit=1]'
D='@e[type=minecraft:marker,tag=wg.table,scores={ct_id=202},limit=1]'


def person(n):
    return f'@e[type=minecraft:armor_stand,tag=wg.p{n},limit=1]'


def cell(sq, table=101):
    return f'@e[type=minecraft:marker,tag=go.square,scores={{ct_id={table},go_sq={sq}}},limit=1]'


def fixture_hook(target):
    """仅拓宽服务器身份、骑乘和调用，客户端命令继续使用真人接收者。"""
    for module in ('game','system','player','ai'):
        for p in (target/f'data/weiqi/function/{module}').rglob('*.mcfunction'):
            out=[]
            for line in p.read_text(encoding='utf-8').splitlines():
                if 'if items entity' in line or 'run function weiqi:input/give' in line:
                    continue
                if 'function weiqi:name/capture' in line:
                    line='data modify storage weiqi:runtime name.value set value {text:"测试玩家"}'
                if not any(command in line for command in ('tellraw ','title ','dialog ','playsound ')):
                    line=line.replace('@a[tag=', '@e[type=minecraft:armor_stand,tag=wg.person,tag=')
                out.append(line)
            p.write_text('\n'.join(out)+'\n',encoding='utf-8')


class Suite(BaseSuite):
    def call(self, name, table=101):
        return [f'execute as {C if table==101 else D} at @s run function weiqi:{name}']

    def setup(self, size=13, cap=4, orient=0, mode=1, seats=(3,1), table=101, reset=True):
        lines=['function guandan_test:reset'] if reset else []
        lines += [f'execute positioned {8.0 if table==101 else 40.0} 64.0 8.0 summon minecraft:marker run function guandan_test:table {{table:{table},size:{size},cap:{cap},orient:{orient},mode:{mode},joined:{len(seats)}}}']
        for index,seat in enumerate(seats,1 if table==101 else 3):
            lines += [f'execute positioned {8.0 if table==101 else 40.0} 64.0 8.0 summon minecraft:armor_stand run function guandan_test:person {{n:{index},seat:{seat},table:{table}}}',f'execute as {person(index)} at @s run function cardtable:seat/mount']
        return lines

    def actor(self,n):
        return ['tag @e[tag=go.actor] remove go.actor',f'tag {person(n)} add go.actor']

    def move(self,to,n=1):
        return self.actor(n)+[f'scoreboard players set #to go_ctx {to}']+self.call('game/click')

    def start(self,**kwargs):
        return self.setup(**kwargs)+self.call('game/start')+[f'scoreboard players set {C if kwargs.get("table",101)==101 else D} ct_state 1']

    def prepare(self):
        self.file('reset',['kill @e[tag=wg.fixture]','kill @e[tag=go.visual]','kill @e[tag=go.square]','kill @e[tag=go.firework]','kill @e[tag=ct.menu]','kill @e[tag=ct.vote]'])
        self.file('table','''
tag @s add wg.fixture
tag @s add wg.table
tag @s add ct.controller
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ct_capacity $(cap)
$scoreboard players set @s ct_joined $(joined)
$scoreboard players set @s go_size $(size)
$scoreboard players set @s go_orient $(orient)
$scoreboard players set @s go_first $(mode)
scoreboard players set @s ct_game 20
scoreboard players set @s ct_state 0
scoreboard players set @s ct_start 0
data merge entity @s {data:{cardtable:{menu_version:20,rules_version:5,chairs_version:1,vote_version:1}}}
function cardtable:table/ensure_seats
scoreboard players operation #fixture_table gt = @s ct_id
execute as @e[tag=ct.seat] if score @s ct_id = #fixture_table gt run tag @s add wg.fixture
''')
        self.file('person','''
tag @s add wg.fixture
tag @s add wg.person
$tag @s add wg.p$(n)
tag @s add ct.player
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ct_seat $(seat)
scoreboard players set @s ct_online 1
data merge entity @s {NoGravity:1b,Invisible:1b,Invulnerable:1b}
''')

    def finish(self):
        self.file('bootstrap',['forceload add 0 0 63 31','scoreboard objectives add gt dummy','function weiqi:load','function guandan_test:reset',f'schedule function guandan_test:case/{self.cases[0]} 2t'])
        self.file('finish',['function guandan_test:reset','say GUANDAN_FINISHED'])
        for i,name in enumerate(self.cases):
            self.files['case/'+name]+='schedule function guandan_test:'+('case/'+self.cases[i+1] if i+1<len(self.cases) else 'finish')+' 2t\n'
        self.setup_ticks=len(self.cases)*2+150

    def build(self):
        self.prepare()
        for size in (13,15,19):
            c=self.start(size=size)+self.score(C,'ct_start',1,f'size_{size}_start')+self.score(C,'go_turn',1,f'size_{size}_black_first')
            c+=self.count(f'@e[tag=go.square,scores={{ct_id=101}}]',size*size,f'size_{size}_squares')
            c+=self.score(C,'go_first',1,f'size_{size}_default_by_seat')+self.score(C,'go_komi',15,f'size_{size}_default_komi')
            c+=self.score(C,'go_btime',12000,f'size_{size}_clock')
            self.case(f'start_{size}',c)
        c=self.start()+self.actor(1)+[f'scoreboard players set {C} go_btime 11001','scoreboard players set #to go_ctx 60']+self.call('game/click')
        c+=self.score(cell(60),'go_piece',1,'click_places_black')+self.score(C,'go_turn',-1,'click_turn_white')+self.score(C,'go_state',2,'click_animates')
        c+=self.call('clock/tick')+self.score(C,'go_wtime',12000,'animation_pauses_clock')
        c+=self.call('game/animation_done')+self.score(C,'go_state',1,'animation_returns_play')
        c+=self.move(60,2)+self.score(C,'go_moves',1,'occupied_no_move')
        c+=self.move(61,1)+self.score(C,'go_moves',1,'wrong_side_no_move')
        self.case('move_guards',c)
        # 悔棋必须对方同意；请求方不能给自己批准。
        c=self.start()+self.move(60)+self.call('game/animation_done')+self.actor(1)+self.call('game/request_undo')
        c+=self.score(C,'go_undo',1,'undo_pending_black')+self.call('game/accept_undo')+self.score(C,'go_moves',1,'own_accept_rejected')
        c+=self.actor(2)+self.call('game/accept_undo')+self.score(C,'go_moves',0,'other_accept_restores_moves')+self.score(cell(60),'go_piece',0,'undo_clears_stone')
        c+=self.score(C,'go_turn',1,'undo_black_turn')+self.score(C,'go_btime',12000,'undo_restores_clock')
        self.case('undo_consent',c)
        # 双停进入计分；标死后撤销确认，争议恢复保留历史和双方轮次。
        c=self.start()+self.move(60)+self.call('game/animation_done')+self.actor(2)+self.call('game/pass')
        c+=self.actor(1)+self.call('game/pass')+self.score(C,'go_state',3,'two_pass_scoring')
        c+=self.actor(1)+self.call('game/confirm_score')+self.score(C,'go_bconfirm',1,'black_confirm')
        c+=['scoreboard players set #to go_ctx 60']+self.actor(2)+self.call('game/toggle_dead')
        c+=self.score(cell(60),'go_dead',1,'mark_whole_group_dead')+self.score(C,'go_bconfirm',0,'mark_resets_confirm')
        c+=self.call('game/resume')+self.score(C,'go_state',1,'resume_play')+self.score(C,'go_passes',0,'resume_reset_passes')+self.score(cell(60),'go_piece',1,'resume_keeps_shape')+self.score(cell(60),'go_dead',0,'resume_clears_dead')+self.score(C,'go_moves',3,'resume_keeps_history_moves')
        self.case('scoring_resume',c)
        # 空盘双方确认：7.5贴目白胜，不把旧提子额外累加进面积。
        c=self.start()+self.actor(1)+self.call('game/pass')+self.actor(2)+self.call('game/pass')
        c+=self.call('game/confirm_score')+self.score(C,'go_state',3,'one_confirmation_not_finish')+self.actor(1)+self.call('game/confirm_score')
        c+=self.score(C,'go_state',4,'two_confirmations_finish')+self.score(C,'go_result',2,'empty_white_komi_win')
        c += [f'scoreboard players set {C} go_timer 37']+self.call('game/finish')+self.score(C,'go_timer',37,'finish_idempotent')
        c+=self.call('game/cleanup')+self.score(C,'ct_state',0,'cleanup_lobby')+self.score(person(1),'go_revelig',1,'review_eligible')
        c+=self.call('game/review_open')+self.score(C,'go_state',5,'review_open')+self.call('game/review_first')+self.score(C,'go_moves',0,'review_initial')
        c+=self.call('game/review_last')+self.score(C,'go_moves',2,'review_final')+self.score(C,'go_result',2,'review_keeps_result')
        c+=self.call('game/review_first')+self.call('game/review_play')+[f'scoreboard players operation #review_epoch gt = {C} go_epoch']
        c+=self.call('game/review_advance')+self.check(f'score {C} go_epoch = #review_epoch gt','auto_review_keeps_panel_epoch')
        c+=self.call('game/review_play')+self.score(C,'go_autoplay',0,'auto_review_can_pause')
        c+=self.call('game/review_close')+self.score(C,'go_state',0,'review_closes_to_lobby')
        self.case('score_finish_review',c)
        # 别桌不能操纵复盘，旧资格不能跨桌。
        c=self.start()+self.actor(1)+self.call('game/resign')+self.call('game/cleanup')
        c += [f'scoreboard players set {person(1)} ct_id 202']+self.call('game/review_first')+self.score(C,'go_state',0,'cross_table_review_rejected')
        self.case('review_cross_table',c)
        # 非法人数和按座位同侧都拒绝，不能提前污染参与身份。
        for count,seats in [(0,()),(3,(1,2,3)),(2,(1,2))]:
            c=self.setup(seats=seats)+self.call('game/start')+self.score(C,'ct_start',0,f'reject_count_or_side_{count}')
            c+=self.count('@e[tag=wg.person,tag=go.player]',0,f'reject_no_identity_{count}')
            self.case('reject_'+str(count),c)
        c=self.start()+self.move(60)+self.call('game/animation_done')+[f'scoreboard players set {C} go_wtime 1']+self.call('clock/tick')
        c+=self.score(C,'go_result',1,'white_timeout_black_wins')+self.score(C,'go_state',4,'timeout_finishes')
        self.case('timeout',c)
        # 中局占地使用保守影响估算，第一子不会把全部空盘算给黑方。
        c=self.start()+self.move(60)+self.call('game/animation_done')+self.actor(1)+self.call('game/estimate')
        c+=self.score(person(1),'go_view',1,'estimate_view_enabled')+self.score(C,'go_barea','1..60','estimate_opening_not_entire_board')
        c+=self.call('system/reload')+self.score(person(1),'go_view',1,'estimate_reload_preserves_view')
        c+=self.move(61,2)+self.score(person(1),'go_view',0,'move_clears_stale_estimate')
        self.case('estimate_reload',c)
        # 重载点目阶段不能清掉死子标记，也不能替双方重新确认。
        c=self.start()+self.move(60)+self.call('game/animation_done')+self.actor(2)+self.call('game/pass')+self.actor(1)+self.call('game/pass')
        c+=['scoreboard players set #to go_ctx 60']+self.call('game/toggle_dead')+self.actor(2)+self.call('game/confirm_score')
        c+=self.call('system/reload')+self.score(C,'go_state',3,'score_reload_keeps_phase')+self.score(C,'go_bconfirm',0,'score_reload_keeps_black_unconfirmed')+self.score(C,'go_wconfirm',1,'score_reload_keeps_white_confirmation')+self.score(cell(60),'go_dead',1,'score_reload_keeps_dead')
        self.case('scoring_reload',c)
        # 上一局已分胜负，新局投票中止时不能把上一局胜负带入复盘。
        c=self.start()+self.actor(1)+self.call('game/resign')+self.call('game/cleanup')+self.call('game/start')
        c += [f'scoreboard players set {C} ct_state 1']+self.call('game/end_vote')+self.actor(1)+self.call('game/review_open')
        c+=self.score(C,'go_state',5,'early_second_game_review')+self.score(C,'go_result',0,'early_second_game_no_old_winner')
        c+=self.check(f'data entity {C} data.weiqi{{finalresult:0}}','early_second_game_final_zero')
        self.case('early_result_reset',c)
        self.finish()


if __name__=='__main__':
    s=Suite();s.build();raise SystemExit(run(s,isolated=False,prefix='fimel-weiqi-game-',prepare_target=fixture_hook))
