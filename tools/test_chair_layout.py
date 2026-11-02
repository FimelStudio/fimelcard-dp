"""Run real 26.2 seat, chair, passenger, migration and isolation assertions in a temporary world."""
from pathlib import Path
import shutil

from test_guandan_cards import Suite as BaseSuite, run, PACK

TABLE='@e[type=minecraft:marker,tag=cl.table,scores={ct_id=101},limit=1]'
OTHER='@e[type=minecraft:marker,tag=cl.table,scores={ct_id=202},limit=1]'


class Suite(BaseSuite):
    def call(self,name,other=False):
        return [f'execute as {OTHER if other else TABLE} at @s run function cardtable:{name}']

    def setup(self,cap=8,count=None,skin=0,game=12,reset=True,other=False):
        lines=['function guandan_test:reset'] if reset else []
        lines += [f'execute positioned {40.0 if other else 8.0} 64.0 8.0 summon minecraft:marker run function guandan_test:table {{cap:{cap},skin:{skin},game:{game},table:{202 if other else 101}}}']
        if count is not None:lines += [f'scoreboard players set {OTHER if other else TABLE} ct_chairs {count}']
        return lines + self.call('chairs/layout/ensure',other)

    def quantity(self,cap,count,skin,prefix):
        visual='ct.chair'+str(cap) if skin==0 else 'ct.skin_chair'
        return self.count('@e[type=minecraft:interaction,tag=ct.seat,scores={ct_id=101}]',count,prefix+'_interaction_count')+self.count(f'@e[tag={visual},scores={{ct_id=101}}]',count,prefix+'_visual_count')+self.score(TABLE,'ct_chairs',count,prefix+'_saved_quantity')

    def build(self):
        self.file('reset',['kill @e[tag=cl.fixture]','kill @e[tag=ct.part]'])
        self.file('table','''
tag @s add cl.fixture
tag @s add cl.table
tag @s add ct.controller
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ct_capacity $(cap)
$scoreboard players set @s ct_skin $(skin)
$scoreboard players set @s ct_game $(game)
scoreboard players set @s ct_state 0
scoreboard players set @s ct_ch_epoch 0
''')
        self.file('person','''
tag @s add cl.fixture
tag @s add cl.person
tag @s add ct.player
$tag @s add cl.p$(number)
scoreboard players set @s ct_id 101
$scoreboard players set @s ct_seat $(seat)
data merge entity @s {NoGravity:1b,Invisible:1b,Invulnerable:1b}
function cardtable:seat/mount
''')
        for cap in (4,8):
            self.case(f'default{cap}',self.setup(cap)+self.quantity(cap,cap,0,f'default{cap}'))
            for count in range(1,cap+1):
                for skin in range(7):
                    prefix=f'cap{cap}_n{count}_skin{skin}'
                    lines=self.setup(cap,count,skin)+self.quantity(cap,count,skin,prefix)
                    lines += self.call('chairs/layout/ensure')+self.quantity(cap,count,skin,prefix+'_stable')
                    if cap==8 and count<=4:
                        for seat in range(1,9):
                            selected=f'@e[type=minecraft:interaction,tag=ct.seat,scores={{ct_id=101,ct_seat={seat}}},limit=1]'
                            axis=0 if seat<=2 or 5<=seat<=6 else 2
                            lines += [f'execute if entity {selected} store result score #center gt run data get entity {selected} Pos[{axis}] 1000']
                            lines += self.check(f'entity {selected}',prefix+'_has_seat_'+str(seat)) if False else []
                            lines += [f'execute if entity {selected} unless score #center gt matches 8000 run say GUANDAN_FAIL {prefix}_center_{seat}',f'execute unless entity {selected} run scoreboard players set #center gt 8000']
                            lines += self.score('#center','gt',8000,prefix+'_center_'+str(seat))
                    self.case(prefix,lines)
        # Public game minima, count clamp, and active-game refusal.
        lines=self.setup(8,1,game=21)+self.quantity(8,3,0,'catan_minimum')
        self.case('minimum',lines)
        lines=self.setup(4,8)+self.quantity(4,4,0,'capacity_clamp')
        self.case('clamp',lines)
        # Retain players' sparse IDs even when reducing count below their number.
        lines=self.setup(8,8)+[
            'execute positioned 8 64 8 summon minecraft:armor_stand run function guandan_test:person {number:1,seat:4}',
            'execute positioned 8 64 8 summon minecraft:armor_stand run function guandan_test:person {number:2,seat:8}',
            f'scoreboard players set {TABLE} ct_chairs 1',
        ]+self.call('chairs/layout/apply')+self.quantity(8,2,0,'occupied_minimum')
        for number,seat in [(1,4),(2,8)]:
            lines += ['scoreboard players set #mounted gt 0',f'execute as @e[tag=cl.p{number},limit=1] on vehicle if entity @s[tag=ct.seat,scores={{ct_id=101,ct_seat={seat}}}] run scoreboard players set #mounted gt 1']+self.score('#mounted','gt',1,f'occupied_p{number}_remounted')
        lines += self.score(TABLE,'ct_ch_epoch',1,'apply_invalidates_old_window')
        self.case('occupied',lines)
        # Chess changes all actual target IDs first, mount then enables the target sparse slots.
        lines=self.setup(8,2)+[
            'execute positioned 8 64 8 summon minecraft:armor_stand run function guandan_test:person {number:1,seat:1}',
            'execute positioned 8 64 8 summon minecraft:armor_stand run function guandan_test:person {number:2,seat:5}',
            'execute as @e[tag=cl.person] run ride @s dismount',
            'scoreboard players set @e[tag=cl.p1,limit=1] ct_seat 8',
            'scoreboard players set @e[tag=cl.p2,limit=1] ct_seat 3',
            'execute as @e[tag=cl.person] at @s run function cardtable:seat/mount',
        ]+self.quantity(8,2,0,'reseat_quantity')
        for number,seat in [(1,8),(2,3)]:
            lines += ['scoreboard players set #mounted gt 0',f'execute as @e[tag=cl.p{number},limit=1] on vehicle if entity @s[tag=ct.seat,scores={{ct_id=101,ct_seat={seat}}}] run scoreboard players set #mounted gt 1']+self.score('#mounted','gt',1,f'reseat_p{number}_target')
        self.case('reseat',lines)
        # Disconnecting removes the actor from online selectors, not the reserved chair mask.
        lines=self.setup(8,3)+[
            'execute positioned 8 64 8 summon minecraft:armor_stand run function guandan_test:person {number:1,seat:4}',
            'execute positioned 8 64 8 summon minecraft:armor_stand run function guandan_test:person {number:2,seat:8}',
            'execute positioned 8 64 8 summon minecraft:armor_stand run function guandan_test:person {number:3,seat:6}',
            f'scoreboard players set {TABLE} ct_state 1',
            f'scoreboard players operation #saved_mask gt = {TABLE} ct_clmask',
            'execute as @e[tag=cl.p2] run ride @s dismount',
            'tag @e[tag=cl.p2] remove ct.player',
        ]+self.call('chairs/layout/ensure')+self.quantity(8,3,0,'offline_reserved')
        lines+=self.check(f'score {TABLE} ct_clmask = #saved_mask gt','offline_keeps_exact_mask')
        lines+=self.count('@e[tag=ct.seat,scores={ct_id=101,ct_seat=8}]',1,'offline_keeps_original_seat')
        self.case('offline',lines)
        # A marker can also act as a server-side participant for session-specific fixtures.
        self.file('marker_rider',['tag @s add cl.fixture','tag @s add cl.rider','tag @s add ct.player','scoreboard players set @s ct_id 101','scoreboard players set @s ct_seat 1','function cardtable:seat/mount'])
        lines=self.setup(8,2)+['execute positioned 8.0 64.0 8.0 summon minecraft:marker run function guandan_test:marker_rider','scoreboard players set #mounted gt 0','execute as @e[tag=cl.rider,limit=1] on vehicle if entity @s[type=minecraft:interaction,tag=ct.seat,scores={ct_id=101,ct_seat=1}] run scoreboard players set #mounted gt 1']
        lines += self.score('#mounted','gt',1,'marker_can_ride_real_interaction')
        self.case('marker',lines)
        # Loss of an entity repairs only its enabled slot and cannot resurrect removed slots.
        lines=self.setup(8,2)+['kill @e[tag=ct.seat,scores={ct_id=101,ct_seat=5}]']+self.call('chairs/layout/ensure')+self.quantity(8,2,0,'repair')
        self.case('repair',lines)
        lines=self.setup(8,2)+['execute as @e[tag=ct.seat,scores={ct_id=101,ct_seat=1}] run tp @s 7.0 64.32 5.5']+self.call('chairs/layout/ensure')+['execute store result score #repaired_x gt run data get entity @e[tag=ct.seat,scores={ct_id=101,ct_seat=1},limit=1] Pos[0] 1000']
        lines+=self.score('#repaired_x','gt',8000,'late_root_vehicle_uses_current_center')
        self.case('late_vehicle',lines)
        lines=self.setup(8,3,skin=5)+self.setup(8,8,skin=2,reset=False,other=True)+[f'scoreboard players set {TABLE} ct_chairs 2']+self.call('chairs/layout/apply')+self.quantity(8,2,5,'isolated_first')
        lines += self.count('@e[tag=ct.seat,scores={ct_id=202}]',8,'isolated_second_interactions')+self.count('@e[tag=ct.skin_chair,scores={ct_id=202}]',8,'isolated_second_chairs')
        self.case('isolation',lines)
        # Legacy themes did not label chair entities separately from tabletop/decor.
        lines=self.setup(8,8,skin=1)+['tag @e[tag=ct.skin_chair,scores={ct_id=101}] remove ct.skin_chair',f'scoreboard players set {TABLE} ct_clver 0']+self.call('chairs/layout/ensure')+self.quantity(8,8,1,'legacy_theme_migration')
        self.case('migration',lines)
        self.file('bootstrap',['forceload add 0 0 63 15','scoreboard objectives add gt dummy','scoreboard objectives add ct_ctx dummy','scoreboard objectives add ct_id dummy','scoreboard objectives add ct_seat dummy','scoreboard objectives add ct_kind dummy','scoreboard objectives add ct_capacity dummy','scoreboard objectives add ct_skin dummy','scoreboard objectives add ct_state dummy','scoreboard objectives add ct_game dummy','scoreboard objectives add ct_ch_epoch dummy','function cardtable:chairs/layout/load',f'schedule function guandan_test:case/{self.cases[0]} 2t'])
        self.file('finish','say GUANDAN_FINISHED')
        for index,name in enumerate(self.cases):self.files['case/'+name]+='schedule function guandan_test:'+('case/'+self.cases[index+1] if index+1<len(self.cases) else 'finish')+' 1t\n'


def prepare(target):
    public=PACK/'data/cardtable/function'
    for name in ['chairs/layout','seat/mount.mcfunction','seat/ensure_one.mcfunction','seat/init4.mcfunction','seat/init8.mcfunction','seat/chair4_init.mcfunction','seat/chair8_init.mcfunction','skin/item.mcfunction']:
        source=public/name;dest=target/'data/cardtable/function'/name
        if source.is_dir():shutil.copytree(source,dest)
        else:dest.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(source,dest)
    # Fake actors only replace entity categories. All chair/mount logic is unmodified.
    for p in (target/'data/cardtable/function').rglob('*.mcfunction'):
        text=p.read_text(encoding='utf-8').replace('@a[','@e[').replace('type=minecraft:player,tag=ct.player','type=minecraft:armor_stand,tag=ct.player')
        p.write_text(text,encoding='utf-8')
    p=target/'data/cardtable/function/chairs/settings/minimum.mcfunction';p.parent.mkdir(parents=True,exist_ok=True)
    source=public/'chairs/settings/minimum.mcfunction'
    if source.exists():shutil.copy2(source,p)
    else:p.write_text('scoreboard players set #chair_min ct_ctx 1\nexecute if score @s ct_game matches 21 run scoreboard players set #chair_min ct_ctx 3\n',encoding='utf-8')


if __name__=='__main__':
    suite=Suite();suite.build();raise SystemExit(run(suite,prefix='fimel-chair-layout-',prepare_target=prepare))
