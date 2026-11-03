"""临时副本验证注册幂等性，以及重跑旧脚本不会覆盖未来游戏。"""
from pathlib import Path
import hashlib
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
from game_picker_ui import load_picker, write_picker, build_picker

PACK=Path(__file__).resolve().parents[1]
REGISTRARS=('register_chess.py','register_boardgames.py','register_xiangqi.py','register_avalon.py','register_love_letter.py','register_guandan.py','register_weiqi.py','register_catan.py')


def hashes(root):
    return {path.relative_to(root).as_posix():hashlib.sha256(path.read_bytes()).hexdigest() for path in root.rglob('*') if path.is_file()}


def main():
    output=Path(tempfile.mkdtemp(prefix='fimel-boardgame-register-'))
    shutil.copytree(PACK/'data/cardtable',output/'data/cardtable')
    shutil.copytree(PACK/'data/minecraft/tags/function',output/'data/minecraft/tags/function')
    for name in [*REGISTRARS,'game_picker_ui.py','check_game_picker.mjs','check_admin_abort.mjs','check_table_end_reentry.cjs','check_table_vote_remote.mjs']:
        path=output/'tools'/name;path.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(PACK/'tools'/name,path)
    for cap in (4,8):
        dest=output/f'docs/game-icons/picker{cap}-original.json';dest.parent.mkdir(parents=True,exist_ok=True)
        shutil.copy2(PACK/f'docs/game-icons/picker{cap}-original.json',dest)
    common=output/'data/cardtable/function'
    original_icons={cap:(common/f'menu/picker/show{cap}.mcfunction').read_bytes() for cap in (4,8)}
    build_picker(output)
    assert all((common/f'menu/picker/show{cap}.mcfunction').read_bytes()==original_icons[cap] for cap in (4,8)), '便携重建器改变了同伴图标布局或切片'
    def buttons(capacity):
        dialog=load_picker(output,capacity)
        return {int(re.search(r'\$\(p(\d+)\)',button['action']['command'])[1]):button for button in dialog['actions']}
    preserved={capacity:{game:buttons(capacity)[game] for game in (18,19,21,22,23)} for capacity in (4,8)}
    for capacity in (4,8):
        assert preserved[capacity][18]['label']['text']=='掼蛋（1–4人+人机）'
        assert preserved[capacity][19]['label']['text']==f'命悬一线（2–{capacity}人）'
        assert preserved[capacity][21]['label']['text']=='卡坦岛（3–4人）'
        assert preserved[capacity][22]['label']['text']=='璀璨宝石（2–4人）'
        assert preserved[capacity][23]['label']['text']==f'胡闹运动会（2–{min(capacity,6)}人）'
    def check_preserved_buttons():
        for capacity in (4,8):
            actual=buttons(capacity)
            for game,button in preserved[capacity].items():
                assert actual[game]==button,(capacity,game,'旧注册脚本覆盖了既有按钮或人数说明')
            text=(common/f'menu/picker/show{capacity}.mcfunction').read_text(encoding='utf-8')
            assert json.loads(text[text.index('{'):])['type']=='minecraft:notice','注册不得把图标界面变回旧按钮'
    def register(script):
        process=subprocess.run([sys.executable,str(output/'tools'/script)],cwd=output,env={**os.environ,'PYTHONUTF8':'1'},capture_output=True,text=True,encoding='utf-8')
        assert process.returncode==0,process.stdout+process.stderr
    def register_all():
        for script in REGISTRARS:
            register(script)
    register_all()
    check_preserved_buttons()
    baseline=hashes(output)
    register_all()
    assert hashes(output)==baseline,'重跑注册脚本改变了既有文件'
    current=int(re.search(r'#game_count ct_ctx (\d+)',(common/'load.mcfunction').read_text(encoding='utf-8'))[1])
    future_id=current+1
    registered=[int(n) for n in re.findall(r'cardtable:picker p(\d+) int',(common/'menu/picker/open.mcfunction').read_text(encoding='utf-8'))]
    future={'label':{'text':'未来游戏 · 保留此文本'},'width':123,'action':{'type':'minecraft:run_command','command':f'trigger ct_game_pick set $(p{future_id})'}}
    expected_actions={}
    for capacity in (4,8):
        dialog=load_picker(output,capacity)
        expected_actions[capacity]=len(dialog['actions'])+1
        # 缺少按钮时重新注册也要恢复掼蛋的人机人数说明。
        dialog['actions']=[action for action in dialog['actions'] if action['action']['command'] not in ('trigger ct_game_pick set $(p14)','trigger ct_game_pick set $(p15)','trigger ct_game_pick set $(p18)')]
        dialog['actions'].append(future)
        write_picker(output,capacity,dialog)
    path=common/'menu/picker/open.mcfunction';text=path.read_text(encoding='utf-8')
    text=re.sub(r'(?:scoreboard players operation #pick_button ct_ctx = #pick_nonce ct_ctx\n)?scoreboard players add #pick_button ct_ctx \d+\nexecute store result storage cardtable:picker p(?:14|15) int 1 run scoreboard players get #pick_button ct_ctx\n','',text)
    text=text.replace('execute if score @s ct_capacity matches 8 run return',f'scoreboard players add #pick_button ct_ctx 1\nexecute store result storage cardtable:picker p{future_id} int 1 run scoreboard players get #pick_button ct_ctx\nexecute if score @s ct_capacity matches 8 run return')
    path.write_text(text,encoding='utf-8')
    for name in ['load','menu/render','menu/picker/handle']:
        path=common/(name+'.mcfunction');text=path.read_text(encoding='utf-8')
        text=re.sub(r'(#game_count ct_ctx )\d+',lambda match:match[1]+str(future_id),text)
        text=re.sub(r'(ct_game matches 1\.\.|#pick_choice ct_ctx matches 1\.\.)\d+',lambda match:match[1]+str(future_id),text)
        path.write_text(text,encoding='utf-8')
    future_branch=f'execute if score @s ct_game matches {future_id} run return run function future_game:settings/open'
    path=common/'game/open_settings.mcfunction';text=path.read_text(encoding='utf-8')
    index=next(line for line in text.splitlines() if '当前游戏没有提供' in line)
    path.write_text(text.replace(index,future_branch+'\n'+index),encoding='utf-8')
    register_all()
    check_preserved_buttons()
    for capacity in (4,8):
        dialog=load_picker(output,capacity)
        assert len(dialog['actions'])==expected_actions[capacity] and dialog['actions'][-1]==future
    text=(common/'menu/picker/open.mcfunction').read_text(encoding='utf-8')
    assert [int(n) for n in re.findall(r'cardtable:picker p(\d+) int',text)]==registered+[future_id]
    for game in (19,21,22,23):
        assert f'cardtable:picker p{game} int' in text
        assert f'if score #pick_choice ct_ctx matches {game} run return run function cardtable:menu/picker/invalid' not in (common/'menu/picker/handle.mcfunction').read_text(encoding='utf-8')
    assert f'#game_count ct_ctx {future_id}' in (common/'load.mcfunction').read_text(encoding='utf-8')
    assert f'matches 1..{future_id}' in (common/'menu/render.mcfunction').read_text(encoding='utf-8')
    assert f'matches 1..{future_id}' in (common/'menu/picker/handle.mcfunction').read_text(encoding='utf-8')
    assert future_branch in (common/'game/open_settings.mcfunction').read_text(encoding='utf-8')
    for kind in ('load','tick'):
        values=json.loads((output/f'data/minecraft/tags/function/{kind}.json').read_text(encoding='utf-8'))['values']
        for namespace in ('avalon','love_letter','guandan','ito','weiqi','catan','splendor','magical_athlete'):
            assert values.count(f'{namespace}:{kind}')==1,f'{namespace}:{kind} 必须恰好登记一次'
    for name,endpoint in [('game/init_selected','game/init_table'),('game/start','game/start'),('game/open_settings','settings/open'),('game/open_rules','rules/show'),('vote/finish','game/end_vote')]:
        source=(common/(name+'.mcfunction')).read_text(encoding='utf-8')
        for game,namespace in ((16,'avalon'),(17,'love_letter'),(18,'guandan'),(19,'ito'),(20,'weiqi'),(21,'catan'),(22,'splendor'),(23,'magical_athlete')):
            pattern=rf'ct_game matches {game} run (?:return run )?function {namespace}:{endpoint}(?:\n|$)'
            assert len(re.findall(pattern,source))==1,(name,game,'分派必须保留且不能重复')
    baseline=hashes(output);register_all()
    assert hashes(output)==baseline,'有未来游戏时重跑注册不幂等'
    print(f'通过：当前{current}款及模拟未来{future_id}款注册幂等；保留掼蛋人数、命悬一线19、卡坦岛21及未来按钮、编号上限、分派和会话顺序；16至21号游戏加载/分派不重复。')
    print('临时副本：'+str(output))


if __name__=='__main__':main()
