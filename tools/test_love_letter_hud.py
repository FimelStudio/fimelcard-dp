"""情书HUD：原版26.2完整加载、真实BetterTitle面板及位图字体几何验收。

仅在临时副本允许测试盔甲架经过生产玩家guard；不修改玩家存档或生产函数。
"""
from pathlib import Path
import json
from PIL import Image
from test_love_letter_engine import run, TABLE, OTHER, part
from test_love_letter_ui import Suite as UISuite, person

PACK=Path(__file__).resolve().parents[1]
RESOURCE=PACK.parents[3]/'resourcepacks/fimelcard-rp'


def geometry():
    font=json.loads((RESOURCE/'assets/card/font/love_letter/hud.json').read_text(encoding='utf-8'))
    negative=json.loads((RESOURCE/'assets/card/font/love_letter/hud_neg.json').read_text(encoding='utf-8'))
    neg={char:value for p in negative['providers'] if p['type']=='space' for char,value in p['advances'].items()}
    roles=['spy','guard','priest','baron','handmaid','prince','chancellor','king','countess','princess']
    checks=0
    for index,name in enumerate(roles):
        glyph=chr(0xE900+index)
        providers=[p for p in font['providers'] if p['type']=='bitmap' and any(glyph in row for row in p['chars'])]
        assert len(providers)==1,(name,'glyph missing or duplicate');checks+=1
        provider=providers[0]
        assert provider['file']==f'card:font/love_letter/{name}.png';checks+=1
        assert provider['height']==56 and provider['ascent']==56;checks+=1
        image=Image.open(RESOURCE/f'assets/card/textures/font/love_letter/{name}.png').convert('RGBA')
        assert image.size==(128,192);checks+=1
        # height=56 只缩放渲染几何；原始字形也必须装得进 256×256 图集。
        assert image.width<=256 and image.height<=256,(name,'glyph cannot fit vanilla FontTexture');checks+=1
        # 原版 BitmapProvider 扫描最后一个有alpha的像素列，缩放后四舍五入，再加1px字距。
        alpha=image.getchannel('A');bounds=alpha.getbbox()
        assert bounds and bounds[2]==128,(name,'unexpected opaque width');checks+=1
        advance=int(bounds[2]*provider['height']/image.height+0.5)+1
        assert advance==38,(name,advance);checks+=1
        assert neg[glyph]==-advance/2,(name,'rewind must equal -half actual advance');checks+=1
    spaces={char:value for p in font['providers'] if p['type']=='space' for char,value in p['advances'].items()}
    assert spaces[chr(0xE90A)]==8 and neg[chr(0xE90A)]==-4;checks+=1
    shifts=json.loads((RESOURCE/'assets/title/font/y_displace.json').read_text(encoding='utf-8'))['providers'][0]['advances']
    shift=lambda y:-shifts[chr(int(str(2500+y*2),16))]/30000
    top=shift(20)+7-56;bottom=top+56
    status_top=shift(84);status_bottom=status_top+8
    assert status_bottom+3<=top;checks+=1
    assert -72+bottom<=-60;checks+=1
    assert 240-72+status_top>=0;checks+=1
    print(f'Love Letter HUD font geometry: {checks} assertions passed',flush=True)
    return checks


class Suite(UISuite):
    def render(self,seat=1,table=101,panel=901):
        ctrl=TABLE if table==101 else OTHER
        lines=[f'execute as {ctrl} at @s run function love_letter:system/context']
        if panel is not None:lines+=[f'scoreboard players set {person(seat,table)} ll_panel {panel}']
        return lines+[f'execute as {person(seat,table)} run function love_letter:hud/update']

    def has_card(self,index,name,panel=901,present=True):
        condition='data storage fimel_title:io panels['+str(panel)+'][][{font:"card:love_letter/hud",extra:[{extra:[{text:"'+chr(0xE900+index)+'"}]}]}]'
        return self.check(condition,name) if present else ['execute store success score #has_glyph lt if '+condition]+self.score('#has_glyph','lt',0,name)

    def status(self,text,name,panel=901):
        return self.check('data storage fimel_title:io panels['+str(panel)+'][][{font:"minecraft:default_mod",extra:[{extra:[{text:"'+text+'"}]}]}]',name)

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
        c=self.setup((1,9,8),extra=2)+self.render()
        c+=self.score(person(),'fbt_panel',901,'viewer_private_panel_bound')+self.has_card(1,'first_player_hand_guard')+self.has_card(2,'first_player_extra_priest')+self.has_card(9,'first_player_cannot_see_other_princess',present=False)+self.has_card(8,'first_player_cannot_see_other_countess',present=False)
        c+=self.status('轮到你','current_player_turn_text')
        c+=['data modify storage love_letter_test:hud saved set from storage fimel_title:io panels[901]']+self.render(2,panel=902)
        c+=self.has_card(9,'second_player_own_princess',902)+self.has_card(1,'second_player_cannot_see_guard',902,False)+self.has_card(2,'second_player_cannot_see_priest',902,False)+self.status('等待出牌','second_player_waiting',902)
        c+=['execute store success score #changed lt run data modify storage love_letter_test:hud saved set from storage fimel_title:io panels[901]']+self.score('#changed','lt',0,'second_render_preserves_first_panel')+self.count('@e[tag=ll.hud_part]',0,'temporary_part_tags_cleared')
        self.case('private_hands',c)
        c=self.setup((1,9,8),extra=2)+self.render(panel=None)+self.render(2,panel=None)
        c+=self.score(person(),'ll_panel','1..','first_activation_allocates_panel')+self.score(person(2),'ll_panel','1..','second_activation_allocates_panel')
        c+=['scoreboard players set #same_panel lt 0',f'execute if score {person()} ll_panel = {person(2)} ll_panel run scoreboard players set #same_panel lt 1']+self.score('#same_panel','lt',0,'fresh_players_receive_distinct_private_panels')
        c+=['scoreboard players operation #top_before lt = panel_id_top fbt_int']+self.render(panel=None)+self.check('score panel_id_top fbt_int = #top_before lt','repeat_update_does_not_allocate_panel')
        self.case('initial_allocation',c)
        for role in range(10):
            c=self.setup((role,8,9),extra=9-role)+self.render()+self.has_card(role,f'hand_role_{role}_font')+self.has_card(9-role,f'extra_role_{9-role}_font')
            c+=self.check('data storage fimel_title:io panels[901][][{font:"card:love_letter/hud_neg"}]',f'role_{role}_half_rewind_font')
            c+=self.score(part(),'ll_hand',role,f'role_{role}_hand_readonly')+self.score(part(),'ll_extra',9-role,f'role_{role}_extra_readonly')
            self.case('roles_'+str(role),c)
        c=self.setup((1,9,8),extra=2)+self.setup((7,5,4),extra=6,table=202,reset=False)+self.render()
        c+=['data modify storage love_letter_test:hud saved set from storage fimel_title:io panels[901]']+self.render(table=202,panel=903)
        c+=self.has_card(7,'other_table_own_king',903)+self.has_card(6,'other_table_own_chancellor',903)+self.has_card(1,'other_table_cannot_see_first_guard',903,False)+self.has_card(2,'other_table_cannot_see_first_priest',903,False)
        c+=['execute store success score #changed lt run data modify storage love_letter_test:hud saved set from storage fimel_title:io panels[901]']+self.score('#changed','lt',0,'other_table_preserves_first_panel')
        c+=self.score(person(),'fbt_panel',901,'first_table_keeps_bound_panel')+self.score(person(table=202),'fbt_panel',903,'other_table_keeps_bound_panel')
        self.case('two_tables',c)
        for state,text in [(1,'正在发牌'),(3,'本轮结算'),(4,'整场结束')]:
            c=self.setup()+[f'scoreboard players set {TABLE} ll_state {state}']+self.render()+self.status(text,'state_'+str(state)+'_status')
            self.case('state_'+str(state),c)
        c=self.setup()+[f'scoreboard players set {part()} ll_protect 1',f'scoreboard players set {part()} ll_points 4']+self.render()+self.status(' · 保护中','handmaid_protected_status')+self.status('4 好感','own_points_status')
        c+=[f'scoreboard players set {part()} ll_alive 0',f'scoreboard players set {part()} ll_hand -1',f'scoreboard players set {part()} ll_extra -1']+self.render()+self.status(' · 本轮已淘汰','eliminated_status')
        c+=['execute store success score #has_cards lt if data storage fimel_title:io panels[901][][{font:"card:love_letter/hud"}]']+self.score('#has_cards','lt',0,'eliminated_no_cards')
        self.case('protection_elimination',c)
        for ticks,seconds in [(40,2),(1,1),(0,0)]:
            c=self.setup()+[f'scoreboard players set {TABLE} ll_time_setting 30',f'scoreboard players set {TABLE} ll_clock {ticks}']+self.render()+self.status(f' · {seconds}秒',f'clock_{ticks}_round_up')
            self.case('clock_'+str(ticks),c)
        c=self.setup()+self.render()+['execute store success score #clock_exists lt if data storage fimel_title:io panels[901][][{font:"minecraft:default_mod",extra:[{extra:[{text:" · 0秒"}]}]}]']+self.score('#clock_exists','lt',0,'unlimited_has_no_clock_text')
        self.case('unlimited',c)
        c=self.setup()+self.render()+self.render(2,panel=902)+['data modify storage love_letter_test:hud second set from storage fimel_title:io panels[902]',f'scoreboard players set {person()} ll_prev_panel 42',f'execute as {person()} run function love_letter:hud/deactivate']
        c+=self.score(person(),'fbt_panel',42,'cleanup_restores_previous_panel')+self.score(person(),'ll_panel',901,'cleanup_keeps_reusable_slot')
        c+=['execute store result score #empty lt run data get storage fimel_title:io panels[901]']+self.score('#empty','lt',0,'cleanup_own_panel_empty')
        c+=['execute store success score #changed lt run data modify storage love_letter_test:hud second set from storage fimel_title:io panels[902]']+self.score('#changed','lt',0,'cleanup_keeps_other_player_panel')
        c+=self.count('@e[tag=lt.person,tag=ll.owns_actionbar,scores={ll_seat=1}]',0,'cleanup_actionbar_ownership_returned')
        c+=self.count('@e[tag=lt.person,tag=fimel.anim_text.replace.actionbar,scores={ll_seat=1}]',0,'cleanup_actionbar_claim_removed')
        c+=['scoreboard players operation #top_before lt = panel_id_top fbt_int']+self.render()+self.check('score panel_id_top fbt_int = #top_before lt','repeat_activate_reuses_panel_slot')+self.score(person(),'fbt_panel',901,'repeat_activate_rebinds_private_slot')
        self.case('cleanup_reuse',c)
        c=self.setup()+self.render()+[f'scoreboard players set {person()} fbt_panel 123',f'execute as {person()} run function love_letter:hud/deactivate']+self.score(person(),'fbt_panel',123,'newer_foreign_panel_preserved')
        c+=[f'tag {person()} add fimel.anim_text.replace.actionbar']+self.render()+[f'execute as {person()} run function love_letter:hud/deactivate']+self.count('@e[tag=lt.person,tag=fimel.anim_text.replace.actionbar,scores={ll_seat=1}]',1,'preexisting_actionbar_claim_preserved')
        self.case('foreign_panel',c)
        cleaned='@e[type=minecraft:armor_stand,tag=ll.cleanup_check,limit=1]'
        c=self.setup()+self.render()+[f'tag {person()} add ll.cleanup_check',f'execute as {person()} run function love_letter:player/clear_state']
        c+=self.score(cleaned,'ll_panel',901,'full_player_cleanup_keeps_reusable_slot')
        c+=self.count('@e[tag=ll.cleanup_check,tag=ll.hud_active]',0,'full_cleanup_deactivates_hud')
        c+=[f'scoreboard players set {cleaned} ll_table 101',f'scoreboard players set {cleaned} ll_seat 1',f'tag {cleaned} add ll.player','scoreboard players operation #top_before lt = panel_id_top fbt_int']+self.render(panel=None)
        c+=self.check('score panel_id_top fbt_int = #top_before lt','next_match_reuses_previous_private_slot')+self.score(person(),'fbt_panel',901,'next_match_binds_original_private_slot')
        self.case('full_player_cleanup',c)
        c=self.setup()+self.render()+[f'scoreboard players set {person()} ct_id 202','data modify storage love_letter_test:hud saved set from storage fimel_title:io panels[901]',f'scoreboard players set {part()} ll_hand 9',f'execute as {person()} run function love_letter:hud/update','execute store success score #changed lt run data modify storage love_letter_test:hud saved set from storage fimel_title:io panels[901]']+self.score('#changed','lt',0,'foreign_table_guard_rejects_update')
        self.case('invalid_membership',c)
        self.finish()
        self.files['bootstrap']=self.files['bootstrap'].replace('function love_letter_test:reset','scoreboard objectives add ct_seat dummy\nfunction love_letter_test:reset')


def prepare_target(target):
    root=target/'data/love_letter/function/hud'
    path=root/'update.mcfunction'
    path.write_text(path.read_text(encoding='utf-8').replace('type=minecraft:player','type=minecraft:armor_stand'),encoding='utf-8')
    path=root/'refresh.mcfunction'
    path.write_text(path.read_text(encoding='utf-8').replace('@a[tag=ll.audience]','@e[type=minecraft:armor_stand,tag=ll.audience]'),encoding='utf-8')


if __name__=='__main__':
    geometry();suite=Suite();suite.build();raise SystemExit(run(suite,isolated=False,prepare_target=prepare_target,prefix='fimel-loveletter-hud-'))
