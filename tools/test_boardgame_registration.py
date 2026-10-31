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

PACK=Path(__file__).resolve().parents[1]


def hashes(root):
    return {path.relative_to(root).as_posix():hashlib.sha256(path.read_bytes()).hexdigest() for path in root.rglob('*') if path.is_file()}


def main():
    output=Path(tempfile.mkdtemp(prefix='fimel-boardgame-register-'))
    shutil.copytree(PACK/'data/cardtable',output/'data/cardtable')
    shutil.copytree(PACK/'data/minecraft/tags/function',output/'data/minecraft/tags/function')
    for name in ['register_boardgames.py','register_xiangqi.py','check_game_picker.mjs','check_admin_abort.mjs','check_table_end_reentry.cjs','check_table_vote_remote.mjs']:
        path=output/'tools'/name;path.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(PACK/'tools'/name,path)
    def register(script):
        process=subprocess.run([sys.executable,str(output/'tools'/script)],cwd=output,env={**os.environ,'PYTHONUTF8':'1'},capture_output=True,text=True,encoding='utf-8')
        assert process.returncode==0,process.stdout+process.stderr
    register('register_boardgames.py');register('register_xiangqi.py')
    baseline=hashes(output)
    register('register_boardgames.py');register('register_xiangqi.py')
    assert hashes(output)==baseline,'重跑注册脚本改变了既有文件'
    common=output/'data/cardtable/function'
    future={'label':{'text':'未来游戏 · 保留此文本'},'width':123,'action':{'type':'minecraft:run_command','command':'trigger ct_game_pick set $(p17)'}}
    for capacity in (4,8):
        path=common/f'menu/picker/show{capacity}.mcfunction';text=path.read_text(encoding='utf-8');dialog=json.loads(text[text.index('{'):])
        dialog['actions']=[action for action in dialog['actions'] if action['action']['command'] not in ('trigger ct_game_pick set $(p14)','trigger ct_game_pick set $(p15)')]
        dialog['actions'].append(future)
        path.write_text('$dialog show @a[tag=ct.switch_actor,limit=1] '+json.dumps(dialog,ensure_ascii=False,separators=(',',':'))+'\n',encoding='utf-8')
    path=common/'menu/picker/open.mcfunction';text=path.read_text(encoding='utf-8')
    text=re.sub(r'scoreboard players add #pick_button ct_ctx 1\nexecute store result storage cardtable:picker p(?:14|15) int 1 run scoreboard players get #pick_button ct_ctx\n','',text)
    text=text.replace('execute if score @s ct_capacity matches 8 run return','scoreboard players add #pick_button ct_ctx 1\nexecute store result storage cardtable:picker p17 int 1 run scoreboard players get #pick_button ct_ctx\nexecute if score @s ct_capacity matches 8 run return')
    path.write_text(text,encoding='utf-8')
    for name in ['load','menu/render','menu/picker/handle']:
        path=common/(name+'.mcfunction');text=path.read_text(encoding='utf-8').replace('#game_count ct_ctx 15','#game_count ct_ctx 17').replace('matches 1..15','matches 1..17');path.write_text(text,encoding='utf-8')
    future_branch='execute if score @s ct_game matches 17 run return run function future_game:settings/open'
    path=common/'game/open_settings.mcfunction';text=path.read_text(encoding='utf-8')
    index=next(line for line in text.splitlines() if '当前游戏没有提供' in line)
    path.write_text(text.replace(index,future_branch+'\n'+index),encoding='utf-8')
    register('register_boardgames.py');register('register_xiangqi.py')
    for capacity in (4,8):
        text=(common/f'menu/picker/show{capacity}.mcfunction').read_text(encoding='utf-8');dialog=json.loads(text[text.index('{'):])
        assert len(dialog['actions'])==(17 if capacity==8 else 16) and dialog['actions'][-1]==future
    text=(common/'menu/picker/open.mcfunction').read_text(encoding='utf-8')
    assert [int(n) for n in re.findall(r'cardtable:picker p(\d+) int',text)]==list(range(1,18))
    assert '#game_count ct_ctx 17' in (common/'load.mcfunction').read_text(encoding='utf-8')
    assert 'matches 1..17' in (common/'menu/render.mcfunction').read_text(encoding='utf-8')
    assert 'matches 1..17' in (common/'menu/picker/handle.mcfunction').read_text(encoding='utf-8')
    assert future_branch in (common/'game/open_settings.mcfunction').read_text(encoding='utf-8')
    baseline=hashes(output);register('register_boardgames.py');register('register_xiangqi.py')
    assert hashes(output)==baseline,'有未来游戏时重跑注册不幂等'
    print('通过：当前16款及模拟未来17款注册幂等；保留未来按钮、编号上限、分派和会话顺序。')
    print('临时副本：'+str(output))


if __name__=='__main__':main()
