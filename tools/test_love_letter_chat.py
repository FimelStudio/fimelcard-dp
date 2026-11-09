"""情书公开日志与淘汰 subtitle：验证目标、效果、反杀归属和私密信息边界。"""
import json
import re
import shutil
from pathlib import Path
from test_catan_engine import Suite, TABLE, run

PACK=Path(__file__).resolve().parents[1]
ROLES=('间谍','侍卫','牧师','男爵','侍女','王子','大臣','国王','女爵','公主')


def build_suite():
    s=Suite()
    def setup(card,target=0,dead=(),guess=9,forced=4):
        action=dict(actor=1,card=card,target=target,guess=guess,forced=forced,eliminated=list(dead))
        return ['kill @e[tag=ce.fixture]',
                'execute positioned 8 64 8 summon minecraft:marker run function catan_engine_test:table {table:101}',
                f'scoreboard players set {TABLE} ct_id 101',
                f'data modify entity {TABLE} data.love_letter set value '+json.dumps({'action':action}),
                f'data modify entity {TABLE} data.ll_private set value {{secret:"PRIVATE_SENTINEL"}}',
                'execute positioned 8 64 8 summon minecraft:marker run function catan_engine_test:part {seat:1,name:"Alice"}',
                'execute positioned 8 64 8 summon minecraft:marker run function catan_engine_test:part {seat:3,name:"Bob"}',
                'data modify storage love_letter_chat_test:run victims set value []',
                'data modify storage love_letter_chat_test:run killers set value []',
                f'data modify storage love_letter_chat_test:run snapshot set from entity {TABLE} data.love_letter']
    def call():
        return [f'execute as {TABLE} run function love_letter:game/announce']
    def matches(field,value,name):
        return ['data modify storage love_letter_chat_test:run expected set value '+json.dumps(value),
                f'execute store success score #different ce run data modify storage love_letter_chat_test:run expected set from storage love_letter_chat_test:run {field}']+s.score('#different','ce',0,name)
    for card in range(10):
        target=3 if card in (1,2,3,5,7) else 0
        c=setup(card,target,dead=(1,) if card==9 else ())+call()
        c+=s.check('data storage love_letter_chat_test:run sent[{text:"Alice"}]',f'role_{card}_actor_named')
        c+=s.check(f'data storage love_letter_chat_test:run sent[{{text:"{card} · {ROLES[card]}"}}]',f'role_{card}_played_card')
        if target:
            c+=s.check('data storage love_letter_chat_test:run sent[{text:"Bob"}]',f'role_{card}_target_named')
        c+=[f'execute store success score #different ce run data modify storage love_letter_chat_test:run snapshot set from entity {TABLE} data.love_letter']
        c+=s.score('#different','ce',0,f'role_{card}_authority_untouched')
        s.case('role_'+str(card),c)
    for name,card,target,dead,killers,victims in (
        ('guard_hit',1,3,(3,),[1],[3]),
        ('baron_win',3,3,(3,),[1],[3]),
        ('baron_counterkill',3,3,(1,),[3],[1]),
        ('prince_self',5,1,(1,),[],[1]),
        ('princess_self',9,0,(1,),[],[1]),
    ):
        c=setup(card,target,dead,forced=9)+call()
        c+=matches('killers',killers,name+'_killer_subtitle_recipient')
        c+=matches('victims',victims,name+'_victim_subtitle_recipient')
        s.case(name,c)
    c=setup(2)+call()+s.check('data storage love_letter_chat_test:run sent[{text:"，没有可选目标，本次效果不生效"}]','no_target_explained')
    c+=matches('killers',[],'no_target_no_kill_subtitle')
    s.case('no_target',c)
    s.file('part','''
tag @s add ce.fixture
tag @s add ll.board
tag @s add ll.audience
scoreboard players set @s ct_id 101
$scoreboard players set @s ll_seat $(seat)
$data modify entity @s data.ll_name set value {text:"$(name)"}
''')
    s.finish()
    return s


def prepare(target):
    source=PACK/'data/love_letter/function/game'
    dest=target/'data/love_letter/function/game'
    shutil.copytree(source/'chat',dest/'chat')
    for name in ('announce','role_name'):
        shutil.copy2(source/(name+'.mcfunction'),dest/(name+'.mcfunction'))
    for path in dest.rglob('*.mcfunction'):
        text=path.read_text(encoding='utf-8')
        assert not re.search(r'\bll_(?:hand|extra)\b|data\.ll_(?:private|buffer)',text),path
        lines=[line.replace('@a[','@e[') if 'run function love_letter:game/chat/subtitle_' in line else line for line in text.splitlines()]
        path.write_text('\n'.join(lines)+'\n',encoding='utf-8')
    send=dest/'chat/send.mcfunction'
    send.write_text(send.read_text(encoding='utf-8')+'$data modify storage love_letter_chat_test:run sent set value $(message)\n',encoding='utf-8')
    for name,field in (('subtitle_victim','victims'),('subtitle_killer','killers')):
        path=dest/f'chat/{name}.mcfunction'
        path.write_text(path.read_text(encoding='utf-8')+'execute store result storage love_letter_chat_test:run recipient int 1 run scoreboard players get @s ll_seat\n'+f'data modify storage love_letter_chat_test:run {field} append from storage love_letter_chat_test:run recipient\n',encoding='utf-8')
    sound=target/'data/love_letter/function/sound/play.mcfunction'
    sound.parent.mkdir(parents=True)
    sound.write_text('return 0\n',encoding='utf-8')
    load=target/'data/love_letter_chat_test/function/load.mcfunction'
    load.parent.mkdir(parents=True)
    load.write_text('scoreboard objectives add ll_ctx dummy\nscoreboard objectives add ct_id dummy\nscoreboard objectives add ll_seat dummy\n',encoding='utf-8')
    (target/'data/minecraft/tags/function/load.json').write_text(json.dumps({'values':['love_letter_chat_test:load']}),encoding='utf-8')


if __name__=='__main__':
    raise SystemExit(run(build_suite(),prepare_target=prepare,prefix='fimel-love-letter-chat-'))
