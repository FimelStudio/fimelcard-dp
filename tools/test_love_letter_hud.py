"""情书旧 HUD 迁移验收：停用渲染、清理旧面板并归还 actionbar。

在原版 26.2 临时副本中运行，使用真实 BetterTitle 面板存储与生产清理入口；
只将 refresh 的玩家选择器替换为测试盔甲架，不改玩家存档。
"""
from test_love_letter_engine import run
from test_love_letter_ui import Suite as UISuite, person


class Suite(UISuite):
    def update(self, seat=1, table=101):
        return [f'execute as {person(seat, table)} run function love_letter:hud/update']

    def seed_panels(self):
        return ['data modify storage fimel_title:io panels set value [[],[{text:"Old Love Letter"}],[{text:"Other player"}],[{text:"Foreign panel"}]]']

    def legacy_player(self, seat=1, table=101, panel=1, previous=42, owns=True, active=True):
        player=person(seat, table)
        lines=[f'scoreboard players set {player} ll_panel {panel}',
               f'scoreboard players set {player} fbt_panel {panel}']
        if previous is not None:
            lines += [f'scoreboard players set {player} ll_prev_panel {previous}']
        if active:
            lines += [f'tag {player} add ll.hud_active']
        if owns:
            lines += [f'tag {player} add ll.owns_actionbar',
                      f'tag {player} add fimel.anim_text.replace.actionbar']
        return lines

    def panel_empty(self, panel, name):
        return [f'execute store result score #size lt run data get storage fimel_title:io panels[{panel}]']+self.score('#size','lt',0,name)

    def panel_present(self, panel, text, name):
        return self.check(f'data storage fimel_title:io panels[{panel}][{{text:"{text}"}}]',name)

    def no_tag(self, tag, name, seat=1, table=101):
        return self.check(f'entity {person(seat, table)}',name+'_player_exists')+[
            f'execute store success score #tag lt if entity {person(seat, table)[:-1]},tag={tag}]'
        ]+self.score('#tag','lt',0,name)

    def no_score(self, player, objective, name):
        return [f'execute store success score #score_exists lt run scoreboard players get {player} {objective}']+self.score('#score_exists','lt',0,name)

    def build(self):
        self.prepare()
        self.file('person','''
tag @s add lt.fixture
tag @s add lt.person
tag @s add ll.player
tag @s add ct.player
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ll_table $(table)
$scoreboard players set @s ll_seat $(seat)
$scoreboard players set @s ct_seat $(seat)
data merge entity @s {NoGravity:1b,Invisible:1b,Invulnerable:1b}
''')

        # A fresh match must not allocate, bind, or render a BetterTitle panel.
        c=self.setup()+self.seed_panels()+[f'scoreboard players set {person()} fbt_panel 3',
                                         'scoreboard players operation #top_before lt = panel_id_top fbt_int']
        for name in ('activate','update','build','cards','status','points','clock','clock_text','text','refresh'):
            c += [f'execute as {person()} run function love_letter:hud/{name}']
        c+=self.score(person(),'fbt_panel',3,'disabled_entries_preserve_foreign_binding')
        c+=self.check('score panel_id_top fbt_int = #top_before lt','disabled_entries_allocate_no_panels')
        c+=self.no_score(person(),'ll_panel','new_player_has_no_private_panel')
        c+=self.no_tag('ll.hud_active','disabled_entries_do_not_activate')
        c+=self.panel_present(3,'Foreign panel','disabled_entries_preserve_foreign_content')
        self.case('disabled_entries',c)

        c=self.setup()+self.seed_panels()+self.legacy_player()+self.update()
        c+=self.score(person(),'fbt_panel',42,'cleanup_restores_previous_binding')
        c+=self.score(person(),'ll_panel',1,'cleanup_keeps_old_slot_identifier')
        c+=self.panel_empty(1,'cleanup_clears_legacy_content')
        c+=self.panel_present(2,'Other player','cleanup_preserves_other_player_content')
        c+=self.no_tag('ll.hud_active','cleanup_removes_active_tag')
        c+=self.no_tag('ll.owns_actionbar','cleanup_releases_ownership')
        c+=self.no_tag('fimel.anim_text.replace.actionbar','cleanup_releases_actionbar')
        c+=self.no_score(person(),'ll_prev_panel','cleanup_consumes_previous_binding')
        c+=[f'scoreboard players set {person()} fbt_panel 3']+self.update()
        c+=self.score(person(),'fbt_panel',3,'repeated_cleanup_preserves_new_binding')
        self.case('legacy_cleanup',c)

        c=self.setup()+self.seed_panels()+self.legacy_player(previous=None)+self.update()
        c+=self.score(person(),'fbt_panel',0,'cleanup_without_previous_unbinds_panel')
        c+=self.panel_empty(1,'cleanup_without_previous_clears_panel')
        self.case('no_previous_panel',c)

        # A newer panel and a preexisting actionbar claim belong to other code.
        c=self.setup()+self.seed_panels()+self.legacy_player(owns=False)+[
            f'scoreboard players set {person()} fbt_panel 3',
            f'tag {person()} add fimel.anim_text.replace.actionbar']+self.update()
        c+=self.score(person(),'fbt_panel',3,'cleanup_preserves_newer_foreign_binding')
        c+=self.panel_present(3,'Foreign panel','cleanup_preserves_newer_foreign_content')
        c+=self.check(f'entity {person()[:-1]},tag=fimel.anim_text.replace.actionbar]','cleanup_preserves_preexisting_actionbar_claim')
        c+=self.panel_empty(1,'foreign_binding_still_clears_legacy_slot')
        self.case('foreign_ownership',c)

        c=self.setup()+self.seed_panels()+self.legacy_player(active=False)+self.update()
        c+=self.score(person(),'fbt_panel',42,'orphaned_ownership_restores_binding')
        c+=self.panel_empty(1,'orphaned_ownership_clears_old_content')
        c+=self.no_tag('fimel.anim_text.replace.actionbar','orphaned_ownership_releases_actionbar')
        self.case('orphaned_ownership',c)

        # No panel score must not accidentally clear an unrelated panel.
        c=self.setup()+self.seed_panels()+[f'tag {person()} add ll.hud_active',
            f'tag {person()} add ll.owns_actionbar',f'tag {person()} add fimel.anim_text.replace.actionbar',
            f'scoreboard players set {person()} fbt_panel 3']+self.update()
        c+=self.score(person(),'fbt_panel',3,'missing_legacy_panel_preserves_binding')
        c+=self.panel_present(1,'Old Love Letter','missing_legacy_panel_does_not_clear_arbitrary_slot')
        c+=self.no_tag('ll.hud_active','missing_legacy_panel_still_clears_tags')
        self.case('missing_panel',c)

        # Refresh retires old panels across tables, including orphaned ownership tags.
        c=self.setup()+self.setup(table=202,reset=False)+self.seed_panels()
        c+=self.legacy_player()+self.legacy_player(table=202,panel=2,previous=43,active=False)
        c+=self.call('hud/refresh')
        c+=self.score(person(),'fbt_panel',42,'refresh_restores_first_table')
        c+=self.score(person(table=202),'fbt_panel',43,'refresh_restores_second_table')
        c+=self.panel_empty(1,'refresh_clears_first_table')+self.panel_empty(2,'refresh_clears_second_table')
        c+=self.panel_present(3,'Foreign panel','refresh_keeps_unrelated_panel')
        self.case('refresh_all_legacy_players',c)

        c=self.setup()+self.seed_panels()+self.legacy_player()+[
            f'tag {person()} add ll.cleanup_check',
            f'execute as {person()} run function love_letter:player/clear_state']
        cleaned='@e[type=minecraft:armor_stand,tag=ll.cleanup_check,limit=1]'
        c+=self.score(cleaned,'fbt_panel',42,'player_cleanup_restores_binding')
        c+=self.panel_empty(1,'player_cleanup_clears_legacy_panel')
        c+=self.count('@e[tag=ll.cleanup_check,tag=ll.hud_active]',0,'player_cleanup_removes_active_hud')
        c+=self.count('@e[tag=ll.cleanup_check,tag=fimel.anim_text.replace.actionbar]',0,'player_cleanup_releases_actionbar')
        self.case('player_cleanup',c)
        self.finish()
        self.files['bootstrap']=self.files['bootstrap'].replace('function love_letter_test:reset','scoreboard objectives add ct_seat dummy\nfunction love_letter_test:reset')


def prepare_target(target):
    path=target/'data/love_letter/function/hud/refresh.mcfunction'
    path.write_text(path.read_text(encoding='utf-8').replace('@a[','@e[type=minecraft:armor_stand,'),encoding='utf-8')


if __name__=='__main__':
    suite=Suite();suite.build()
    raise SystemExit(run(suite,isolated=False,prepare_target=prepare_target,prefix='fimel-loveletter-hud-'))
