"""幂等注册游戏12；保留公共牌桌现有游戏及手工改动。"""
from pathlib import Path
import json

PACK = Path(__file__).resolve().parents[1]
COMMON = PACK / 'data/cardtable/function'


def update(path, old, new):
    text = path.read_text(encoding='utf-8')
    if old in text and new not in text:
        path.write_text(text.replace(old, new), encoding='utf-8')


def append(path, line):
    text = path.read_text(encoding='utf-8')
    if line not in text:
        path.write_text(text.rstrip() + '\n' + line + '\n', encoding='utf-8')


def before_fallback(path, line):
    # 分发器必须先匹配游戏，再执行“没有提供界面”的兜底提示。
    # 同时迁移早期生成器追加在兜底之后的分支。
    lines = [entry for entry in path.read_text(encoding='utf-8').splitlines()
             if entry.strip() != line]
    index = next(i for i, entry in enumerate(lines) if '当前游戏没有提供' in entry)
    lines.insert(index, line)
    path.write_text('\n'.join(lines) + '\n', encoding='utf-8')


for name, entry in [('game/init_selected','game/init_table'),('game/open_settings','settings/open'),('game/open_rules','rules/show'),('vote/finish','game/end_vote')]:
    tail = 'return run ' if name != 'game/init_selected' else ''
    branch = f'execute if score @s ct_game matches 12 run {tail}function chess:{entry}'
    if name in ('game/open_settings', 'game/open_rules'):
        before_fallback(COMMON / (name + '.mcfunction'), branch)
    else:
        append(COMMON / (name + '.mcfunction'), branch)
update(COMMON/'game/start.mcfunction', 'execute unless score @s ct_start matches 1 run return fail', 'execute if score @s ct_game matches 12 run function chess:game/start\nexecute unless score @s ct_start matches 1 run return fail')
update(COMMON/'load.mcfunction', '#game_count ct_ctx 11', '#game_count ct_ctx 12')
for name in ['menu/render','menu/picker/handle']:
    update(COMMON/(name+'.mcfunction'), 'matches 1..11', 'matches 1..12')
update(COMMON/'menu/render.mcfunction', 'execute if score @s ct_game matches 11 run function cardtable:menu/game_name_uno', 'execute if score @s ct_game matches 11 run function cardtable:menu/game_name_uno\nexecute if score @s ct_game matches 12 run function cardtable:menu/game_name_chess')
update(COMMON/'menu/select_game.mcfunction', 'scoreboard players operation @s ct_game = #pick_choice ct_ctx', 'execute if score @s ct_game matches 12 run function chess:game/remove\nscoreboard players operation @s ct_game = #pick_choice ct_ctx')
update(COMMON/'menu/select_game.mcfunction', 'function cardtable:game/init_selected', 'execute if score @s ct_game matches 12 run tellraw @a[tag=ct.switch_actor,limit=1] {text:"[牌桌] 已选择：国际象棋",color:"gold"}\nfunction cardtable:game/init_selected')
update(COMMON/'table/remove.mcfunction', 'execute if score @s ct_skin matches 1..6 unless', 'execute if score @s ct_state matches 1 if score @s ct_game matches 12 run function chess:game/abort\nexecute if score @s ct_game matches 12 run function chess:game/remove\n\nexecute if score @s ct_skin matches 1..6 unless')
append(COMMON/'game/remove_offline_player.mcfunction', 'execute if entity @s[tag=ch.player] run function chess:player/clear_state')
for name in ['seat/leave','seat/remove_player']:
    path = COMMON/(name+'.mcfunction')
    text = path.read_text(encoding='utf-8')
    line = 'execute if score @s ch_setnonce matches 1.. run function chess:input/clear'
    if line not in text:
        path.write_text(line+'\n'+text, encoding='utf-8')
source=(COMMON/'menu/game_name_uno.mcfunction').read_text(encoding='utf-8')
(COMMON/'menu/game_name_chess.mcfunction').write_text(source.replace('"UNO"','"国际象棋"').replace('color:"red"','color:"gold"'), encoding='utf-8')
for capacity in [4,8]:
    path=COMMON/f'menu/picker/show{capacity}.mcfunction'
    raw=path.read_text(encoding='utf-8')
    dialog=json.loads(raw[raw.index('{'):])
    if len(dialog['actions'])==11:
        dialog['actions'].append({'label':{'text':'国际象棋（1–2人+人机）'},'width':150,'action':{'type':'minecraft:run_command','command':'trigger ct_game_pick set $(p12)'}})
    dialog['actions'][11]['label']['text'] = '国际象棋（1–2人+人机）'
    path.write_text('$dialog show @a[tag=ct.switch_actor,limit=1] '+json.dumps(dialog,ensure_ascii=False,separators=(',',':'))+'\n',encoding='utf-8')
update(COMMON/'menu/picker/open.mcfunction', 'execute if score @s ct_capacity matches 8 run return', 'scoreboard players add #pick_button ct_ctx 1\nexecute store result storage cardtable:picker p12 int 1 run scoreboard players get #pick_button ct_ctx\nexecute if score @s ct_capacity matches 8 run return')
for name in ['load','tick']:
    path=PACK/f'data/minecraft/tags/function/{name}.json'
    data=json.loads(path.read_text(encoding='utf-8'))
    if f'chess:{name}' not in data['values']:
        data['values'].append(f'chess:{name}')
    path.write_text(json.dumps(data,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
update(PACK/'tools/check_game_picker.mjs', "'斗地主','UNO'];", "'斗地主','UNO','国际象棋'];")
update(PACK/'tools/check_game_picker.mjs', '1,2],max=[4,8,5,5,8,8,6,8,6,3,8]', '1,2,1],max=[4,8,5,5,8,8,6,8,6,3,8,2]')
update(PACK/'tools/check_admin_abort.mjs', "['uno', 'un'],", "['uno', 'un'], ['chess', 'ch'],")
update(PACK/'tools/check_admin_abort.mjs', "else if (key === 'sort') sort = value;", "else if (key === 'scores') {\n        const m = value.match(/^\\{(\\w+):?(?:=)?(-?\\d+)\\}$/);\n        assert.ok(m, '只支持单一精确分值');\n        selected = selected.filter(entity => entity.scores[m[1]] === Number(m[2]));\n      } else if (key === 'sort') sort = value;")
# option.split('=')必须保留 scores={ct_state=1} 内的等号。
update(PACK/'tools/check_admin_abort.mjs', ".map(option => option.split('='))", ".map(option => [option.slice(0,option.indexOf('=')), option.slice(option.indexOf('=')+1)])")
update(PACK/'tools/check_admin_abort.mjs', 'scores: {ct_id: 42}', 'scores: {ct_id: 42, ct_state: 1}')
update(PACK/'tools/check_table_end_reentry.cjs', "'doudizhu','uno'];", "'doudizhu','uno','chess'];")
print('Chess registered as game 12.')
