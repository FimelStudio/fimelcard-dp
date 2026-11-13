"""幂等接入第13款游戏中国象棋，保留既有游戏与牌桌接口。"""
from pathlib import Path
import json
import register_boardgames as base
from game_picker_ui import load_picker, write_picker, game_number


PACK = Path(__file__).resolve().parents[1]
COMMON = PACK/'data/cardtable/function'


def read(name):
    return (COMMON/(name+'.mcfunction')).read_text(encoding='utf-8')


def write(name, body):
    (COMMON/(name+'.mcfunction')).write_text(body.rstrip()+'\n', encoding='utf-8')


def insert(name, line, before=None):
    text = read(name)
    if line in text:
        return
    if before is None:
        write(name, text.rstrip()+'\n'+line)
    else:
        assert before in text, (name, before)
        write(name, text.replace(before, line+'\n'+before, 1))


def main():
    for name, endpoint in [('game/init_selected','game/init_table'),('game/open_settings','settings/open'),
                           ('game/open_rules','rules/show'),('vote/finish','game/end_vote')]:
        returned = '' if name == 'game/init_selected' else 'return run '
        line = f'execute if score @s ct_game matches 13 run {returned}function xiangqi:{endpoint}'
        if name in ('game/open_settings','game/open_rules'):
            fallback = next(line for line in read(name).splitlines() if '当前游戏没有提供' in line)
            insert(name, line, fallback)
        else:
            insert(name, line)
    insert('game/start','execute if score @s ct_game matches 13 run function xiangqi:game/start',
           'execute unless score @s ct_start matches 1 run return fail')
    write('load', read('load').replace('#game_count ct_ctx 12', '#game_count ct_ctx 13'))
    for name in ('menu/render','menu/picker/handle'):
        write(name, read(name).replace('matches 1..12','matches 1..13'))
    insert('menu/render','execute if score @s ct_game matches 13 run function cardtable:menu/game_name_xiangqi',
           'execute unless score @s ct_capacity matches 4')
    source = read('menu/game_name_chess').replace('国际象棋','中国象棋')
    if not (COMMON/'menu/game_name_xiangqi.mcfunction').exists():
        write('menu/game_name_xiangqi', source)
    insert('menu/select_game','execute if score @s ct_game matches 13 run function xiangqi:game/remove',
           'scoreboard players operation @s ct_game = #pick_choice ct_ctx')
    insert('menu/select_game','execute if score @s ct_game matches 13 run tellraw @a[tag=ct.switch_actor,limit=1] {text:"[牌桌] 已选择：中国象棋",color:"gold"}',
           'function cardtable:game/init_selected')
    insert('table/remove','execute if score @s ct_state matches 1 if score @s ct_game matches 13 run function xiangqi:game/abort\nexecute if score @s ct_game matches 13 run function xiangqi:game/remove',
           'execute if score @s ct_skin matches 1..6 unless')
    insert('game/remove_offline_player','execute if entity @s[tag=xq.player] run function xiangqi:player/clear_state')
    for name in ('seat/leave','seat/remove_player'):
        line = 'execute if score @s xq_setnonce matches 1.. run function xiangqi:input/clear'
        if line not in read(name):
            write(name,line+'\n'+read(name))
    for capacity in (4,8):
        dialog = load_picker(PACK,capacity)
        action = {'label':{'text':'中国象棋（1–2人+人机）'},'width':150,
                  'action':{'type':'minecraft:run_command','command':'trigger ct_game_pick set $(p13)'}}
        if not any(game_number(entry)==13 for entry in dialog['actions']):
            dialog['actions'].append(action)
        write_picker(PACK,capacity,dialog)
    base.picker_button(13)
    base.normalize_picker_ids()
    for kind in ('load','tick'):
        path = PACK/f'data/minecraft/tags/function/{kind}.json'
        data = json.loads(path.read_text(encoding='utf-8'))
        if 'xiangqi:'+kind not in data['values']:
            data['values'].append('xiangqi:'+kind)
        path.write_text(json.dumps(data,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    path = PACK/'tools/check_game_picker.mjs'
    code = path.read_text(encoding='utf-8')
    code = code.replace("'UNO','国际象棋'];", "'UNO','国际象棋','中国象棋'];")
    code = code.replace('3,8,2];','3,8,2,2];').replace('1,2,1],max=', '1,2,1,1],max=')
    code = code.replace('[9,11].includes(i)', '[9,11,12].includes(i)')
    path.write_text(code,encoding='utf-8')
    path = PACK/'tools/check_admin_abort.mjs'
    code = path.read_text(encoding='utf-8')
    if "['xiangqi', 'xq']" not in code:
        code = code.replace("['chess', 'ch'],", "['chess', 'ch'], ['xiangqi', 'xq'],")
    path.write_text(code,encoding='utf-8')
    path = PACK/'tools/check_table_end_reentry.cjs'
    code = path.read_text(encoding='utf-8').replace("'uno','chess'];", "'uno','chess','xiangqi'];")
    path.write_text(code,encoding='utf-8')
    path = PACK/'tools/check_table_vote_remote.mjs'
    code = path.read_text(encoding='utf-8').replace('game<=10','game<=13').replace('10游戏结束分派','13游戏结束分派')
    path.write_text(code,encoding='utf-8')
    print('中国象棋已注册为游戏13。')


if __name__ == '__main__':
    main()
