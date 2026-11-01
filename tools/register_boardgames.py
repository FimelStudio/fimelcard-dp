"""幂等注册五子棋14、飞行棋15；保留已有和未来游戏的按钮、分派与编号。"""
from pathlib import Path
import json
import re

PACK=Path(__file__).resolve().parents[1]
COMMON=PACK/'data/cardtable/function'
GAMES=((14,'gomoku','gm','五子棋',2),(15,'aeroplane_chess','ac','飞行棋',4))


def read(name):return (COMMON/(name+'.mcfunction')).read_text(encoding='utf-8')
def write(name,body):
    path=COMMON/(name+'.mcfunction');path.parent.mkdir(parents=True,exist_ok=True)
    path.write_text(body.rstrip()+'\n',encoding='utf-8')


def insert(name,line,before=None):
    body=read(name)
    if line in body:return
    if before is None:write(name,body.rstrip()+'\n'+line)
    else:
        assert before in body,(name,before)
        write(name,body.replace(before,line+'\n'+before,1))


def before_fallback(name,line):
    lines=[entry for entry in read(name).splitlines() if entry.strip()!=line]
    index=next(i for i,entry in enumerate(lines) if '当前游戏没有提供' in entry)
    lines.insert(index,line);write(name,'\n'.join(lines))


def picker_button(game):
    """按游戏编号插入会话值；未来编号的既有计数顺序保持不变。"""
    body=read('menu/picker/open')
    pattern=r'(?:scoreboard players operation #pick_button ct_ctx = #pick_nonce ct_ctx\n)?scoreboard players add #pick_button ct_ctx \d+\nexecute store result storage cardtable:picker p(\d+) int 1 run scoreboard players get #pick_button ct_ctx'
    existing=list(re.finditer(pattern,body))
    if any(int(match[1])==game for match in existing):return
    next_value=next((match.start() for match in existing if int(match[1])>game),None)
    if next_value is None:next_value=body.index('execute if score @s ct_capacity matches 8 run return')
    block=f'scoreboard players operation #pick_button ct_ctx = #pick_nonce ct_ctx\nscoreboard players add #pick_button ct_ctx {game}\nexecute store result storage cardtable:picker p{game} int 1 run scoreboard players get #pick_button ct_ctx\n'
    write('menu/picker/open',body[:next_value]+block+body[next_value:])


def normalize_picker_ids():
    """窗口值按真实编号编码；保留作者跳过的编号，禁止手填未注册游戏。"""
    source=read('menu/picker/open')
    pattern=r'(?:scoreboard players operation #pick_button ct_ctx = #pick_nonce ct_ctx\n)?scoreboard players add #pick_button ct_ctx \d+\nexecute store result storage cardtable:picker p(\d+) int 1 run scoreboard players get #pick_button ct_ctx'
    def encode(match):
        game=int(match[1])
        return f'scoreboard players operation #pick_button ct_ctx = #pick_nonce ct_ctx\nscoreboard players add #pick_button ct_ctx {game}\nexecute store result storage cardtable:picker p{game} int 1 run scoreboard players get #pick_button ct_ctx'
    source=re.sub(pattern,encode,source)
    write('menu/picker/open',source)
    registered={int(value) for value in re.findall(r'cardtable:picker p(\d+) int',source)}
    body=read('menu/picker/handle')
    anchor='scoreboard players operation #pick_table ct_ctx = @s ct_pick_table'
    # 不把行尾注释交给命令解析器；专属标记写在独立注释行。
    body=re.sub(r'^# unregistered-id \d+\nexecute if score #pick_choice ct_ctx matches \d+ run return run function cardtable:menu/picker/invalid\n','',body,flags=re.M)
    guards=''.join(f'# unregistered-id {game}\nexecute if score #pick_choice ct_ctx matches {game} run return run function cardtable:menu/picker/invalid\n' for game in range(1,max(registered)+1) if game not in registered)
    write('menu/picker/handle',body.replace(anchor,guards+anchor,1))
    render=re.sub(r'^# unregistered-game \d+\nexecute if score @s ct_game matches \d+ run scoreboard players set @s ct_game 1\n','',read('menu/render'),flags=re.M)
    fallback=next(line for line in render.splitlines() if line.startswith('execute unless score @s ct_game matches 1..'))
    missing=''.join(f'\n# unregistered-game {game}\nexecute if score @s ct_game matches {game} run scoreboard players set @s ct_game 1' for game in range(1,max(registered)+1) if game not in registered)
    write('menu/render',render.replace(fallback,fallback+missing,1))


def main():
    for game,namespace,prefix,title,maximum in GAMES:
        for name,endpoint in [('game/init_selected','game/init_table'),('game/open_settings','settings/open'),('game/open_rules','rules/show'),('vote/finish','game/end_vote')]:
            line=f'execute if score @s ct_game matches {game} run '+('' if name=='game/init_selected' else 'return run ')+f'function {namespace}:{endpoint}'
            if name in ('game/open_settings','game/open_rules'):before_fallback(name,line)
            else:insert(name,line)
        insert('game/start',f'execute if score @s ct_game matches {game} run function {namespace}:game/start','execute unless score @s ct_start matches 1 run return fail')
        insert('menu/render',f'execute if score @s ct_game matches {game} run function cardtable:menu/game_name_{namespace}','execute unless score @s ct_capacity matches 4')
        write(f'menu/game_name_{namespace}',read('menu/game_name_chess').replace('国际象棋',title))
        insert('menu/select_game',f'execute if score @s ct_game matches {game} run function {namespace}:game/remove','scoreboard players operation @s ct_game = #pick_choice ct_ctx')
        insert('menu/select_game',f'execute if score @s ct_game matches {game} run tellraw @a[tag=ct.switch_actor,limit=1] {{text:"[牌桌] 已选择：{title}",color:"gold"}}','function cardtable:game/init_selected')
        insert('menu/select_game',f'execute if score @s ct_game matches {game} run function cardtable:log {{text:"切换游戏：{title}"}}','function cardtable:game/init_selected')
        for endpoint in ('abort','remove'):
            guard='if score @s ct_state matches 1 ' if endpoint=='abort' else ''
            insert('table/remove',f'execute {guard}if score @s ct_game matches {game} run function {namespace}:game/{endpoint}','execute if score @s ct_skin matches 1..6 unless')
        insert('game/remove_offline_player',f'execute if entity @s[tag={prefix}.player] run function {namespace}:player/clear_state','function cardtable:seat/remove_player')
        for name in ('seat/leave','seat/remove_player'):
            line=f'execute if score @s {prefix}_setnonce matches 1.. run function {namespace}:settings/clear_session'
            if line not in read(name):write(name,line+'\n'+read(name))
        for capacity in (4,8):
            name=f'menu/picker/show{capacity}'
            raw=read(name);dialog=json.loads(raw[raw.index('{'):])
            action={'label':{'text':f'{title}（1–{maximum}人+人机）'},'width':150,'action':{'type':'minecraft:run_command','command':f'trigger ct_game_pick set $(p{game})'}}
            def number(entry):
                match=re.search(r'\$\(p(\d+)\)',entry.get('action',{}).get('command',''))
                return int(match[1]) if match else 100000
            found=next((i for i,entry in enumerate(dialog['actions']) if number(entry)==game),None)
            if found is None:
                index=next((i for i,entry in enumerate(dialog['actions']) if number(entry)>game),len(dialog['actions']))
                dialog['actions'].insert(index,action)
            else:dialog['actions'][found]=action
            write(name,'$dialog show @a[tag=ct.switch_actor,limit=1] '+json.dumps(dialog,ensure_ascii=False,separators=(',',':')))
        picker_button(game)
        for kind in ('load','tick'):
            path=PACK/f'data/minecraft/tags/function/{kind}.json'
            content=json.loads(path.read_text(encoding='utf-8'))
            if namespace+':'+kind not in content['values']:content['values'].append(namespace+':'+kind)
            path.write_text(json.dumps(content,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    existing=[int(value) for value in re.findall(r'#game_count ct_ctx (\d+)',read('load'))]
    existing+=[int(value) for value in re.findall(r'cardtable:picker p(\d+) int',read('menu/picker/open'))]
    count=max(15,*existing)
    write('load',re.sub(r'(#game_count ct_ctx )\d+',lambda match:match[1]+str(count),read('load')))
    for name in ('menu/render','menu/picker/handle'):
        write(name,re.sub(r'(ct_game matches 1\.\.|#pick_choice ct_ctx matches 1\.\.)(\d+)',lambda match:match[1]+str(max(count,int(match[2]))),read(name)))
    normalize_picker_ids()
    print(f'五子棋14、飞行棋15已注册；游戏编号上限{count}。')


if __name__=='__main__':main()
