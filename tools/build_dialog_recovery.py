"""情书／UNO常驻Dialog恢复入口，以及花火既有奖励染料的回收与补扫。"""
from pathlib import Path

PACK = Path(__file__).resolve().parents[1]


def normalize_recovery(game, name, text):
    if game == 'hanabi':
        if name == 'input/reopen_reward' and '#reward_reopen_owned' not in text:
            start = text.index('tag @e[tag=hb.reward_reopen_drop] remove hb.reward_reopen_drop')
            anchor = 'execute unless entity @s[tag=hb.reward_pending] run return 0'
            end = text.index(anchor, start) + len(anchor)
            block = '''execute unless entity @s[tag=hb.reward_pending] run return 0
# 不依赖最近物品；只回收当前玩家亲自丢出的奖励恢复染料。
tag @a[tag=hb.reward_reopen_actor] remove hb.reward_reopen_actor
tag @s add hb.reward_reopen_actor
scoreboard players set #reward_reopen_owned hb_ctx 0
execute at @s as @e[type=minecraft:item,distance=..3] if items entity @s contents minecraft:purple_dye[minecraft:custom_data~{hanabi:{action:'reward_reopen'}}] run function hanabi:input/consume_reward_reopen
tag @s remove hb.reward_reopen_actor
execute unless score #reward_reopen_owned hb_ctx matches 1 run return 0'''
            text = text[:start] + block + text[end:]
        if name == 'tick' and '# reward-reopen-fallback' not in text:
            text += '''\n# reward-reopen-fallback: 丢弃统计先到、物品下一刻才出现时也能恢复。
execute as @a[tag=hb.player,tag=hb.reward_pending,scores={hb_drop_reward=0}] at @s if entity @e[type=minecraft:item,distance=..3,nbt={Item:{id:"minecraft:purple_dye"}}] run function hanabi:input/reopen_reward
'''
        return text
    if game not in ('uno', 'love_letter'): return text
    call = f'function {game}:input/ensure_reopen'
    if name == 'input/give' and call not in text:
        anchor = f'function {game}:input/give_' + ('tool' if game == 'uno' else 'tools') + ' with storage '
        if game == 'uno': text = call + '\n' + text
        else:
            text = text.replace('function love_letter:input/give_tools with storage love_letter:input', 'function love_letter:input/give_tools with storage love_letter:input\n' + call)
    if game == 'love_letter' and name == 'input/give':
        text = text.replace(call + '\nfunction love_letter:input/give_tools', 'function love_letter:input/give_tools')
        if not text.rstrip().endswith(call): text = text.rstrip() + '\n' + call + '\n'
    if name == 'input/tick' and '#reopen_clock' not in text:
        ctx, tag = ('un_ctx', 'un.player') if game == 'uno' else ('ll_ctx', 'll.player')
        text = text.rstrip() + f'\n# 恢复物每秒补齐一次，重载或阶段切换后仍可使用。\nscoreboard players add #reopen_clock {ctx} 1\nexecute if score #reopen_clock {ctx} matches 20.. as @a[tag={tag}] run {call}\nexecute if score #reopen_clock {ctx} matches 20.. run scoreboard players set #reopen_clock {ctx} 0\n'
    if game == 'uno':
        if name == 'input/drop' and 'reopen:1b' not in text:
            anchor = 'tag @s remove un.dropper'
            text = text.replace(anchor, 'execute as @e[type=minecraft:item,distance=..4] if items entity @s contents minecraft:purple_dye[minecraft:custom_data~{uno:{reopen:1b}}] run function uno:input/check_drop\n' + anchor)
        if name == 'input/check_drop' and '#ui_drop_table' not in text:
            text = text.replace('kill @s', 'execute store result score #ui_drop_table un_ctx run data get entity @s Item.components."minecraft:custom_data".uno.table\nkill @s', 1)
            text = text.replace('at @s run function uno:ui/open', 'if score @s un_table = #ui_drop_table un_ctx at @s run function uno:ui/open')
        if name == 'player/clear_state' and 'reopen:1b' not in text:
            text += '\nclear @s minecraft:purple_dye[minecraft:custom_data~{uno:{reopen:1b}}]\n'
    else:
        if name == 'input/check_drop' and 'input/reopen with storage' not in text:
            anchor = '# selection: begin'
            block = '''execute if data storage love_letter:input dropped{reopen:1b} run kill @s
execute if data storage love_letter:input dropped{reopen:1b} as @a[tag=ll.dropper,limit=1] at @s run function love_letter:input/reopen with storage love_letter:input dropped
execute if data storage love_letter:input dropped{reopen:1b} run return 0
'''
            if anchor not in text:
                anchor = 'execute store result score #tool_action'
            if 'data modify storage love_letter:input dropped set from entity' not in text:
                block = 'data modify storage love_letter:input dropped set from entity @s Item.components."minecraft:custom_data".love_letter\n' + block
            text = text.replace(anchor, block + anchor, 1)
    return text


def build():
    from build_table_pause_guards import write_guarded
    for game, prefix, state in [('uno', 'un', '1..5'), ('love_letter', 'll', '1..4')]:
        root = PACK / 'data' / game / 'function'
        def put(name, body):
            path = root / (name + '.mcfunction')
            path.parent.mkdir(parents=True, exist_ok=True)
            write_guarded(path, body.strip() + '\n', encoding='utf-8')
        tag = f'{game}:{{reopen:1b}}'
        game_id = 11 if game == 'uno' else 17
        put('input/ensure_reopen', f'''
execute unless entity @s[tag={prefix}.player,tag=ct.player] run return 0
execute unless score @s {prefix}_table = @s ct_id run return 0
scoreboard players operation #reopen_table {prefix}_ctx = @s {prefix}_table
scoreboard players set #reopen_active {prefix}_ctx 0
execute as @e[type=minecraft:marker,tag=ct.controller,tag={prefix}.controller,scores={{ct_game={game_id},ct_state=1,{prefix}_state={state}}}] if score @s ct_id = #reopen_table {prefix}_ctx run scoreboard players set #reopen_active {prefix}_ctx 1
execute unless score #reopen_active {prefix}_ctx matches 1 run return 0
execute store result storage {game}:reopen table int 1 run scoreboard players get @s {prefix}_table
function {game}:input/place_reopen with storage {game}:reopen
''')
        # 直接give；按桌号检查已有恢复染料，不固定或覆盖任何背包格。
        tool = 'tool:1b,' if game == 'love_letter' else ''
        item = f'minecraft:purple_dye[minecraft:item_name={{text:"恢复对话框 · 按Q使用",color:"light_purple",italic:false}},minecraft:custom_data={{{game}:{{{tool}reopen:1b,action:9,table:$(table)}}}},minecraft:max_stack_size=1]'
        put('input/place_reopen', f'''
$execute store result score #reopen_have {prefix}_ctx run clear @s minecraft:purple_dye[minecraft:custom_data~{{{game}:{{reopen:1b,table:$(table)}}}}] 0
execute if score #reopen_have {prefix}_ctx matches 1.. run return 0
clear @s minecraft:purple_dye[minecraft:custom_data~{{{tag}}}]
$give @s {item}
''')
        if game == 'love_letter':
            put('input/reopen', '''
$execute unless score @s ll_table matches $(table) run return 0
function love_letter:input/context
execute unless entity @s[tag=ll.actor] run return 0
# 选人头颅期间，恢复入口先取消待选目标，再重开手牌窗口。
execute if score @e[tag=ll.current,limit=1] ll_select_epoch = @e[tag=ll.current,limit=1] ll_epoch if score @s ll_seat = @e[tag=ll.current,limit=1] ll_select_actor run function love_letter:targeting/cancel
function love_letter:input/give
function love_letter:ui/open
''')
        for name in ['input/give', 'input/tick', 'input/drop', 'input/check_drop', 'player/clear_state', 'targeting/cancel_item']:
            path = root / (name + '.mcfunction')
            if path.exists():
                write_guarded(path, normalize_recovery(game, name, path.read_text(encoding='utf-8')), encoding='utf-8')


def build_hanabi():
    from build_table_pause_guards import write_guarded
    root = PACK / 'data/hanabi/function'
    path = root / 'input/consume_reward_reopen.mcfunction'
    write_guarded(path, '''# 必须是本次恢复者丢出的物品，不能收走附近其他人的染料。
scoreboard players set #reward_drop_owner hb_ctx 0
execute on origin if entity @s[tag=hb.player,tag=hb.reward_reopen_actor,tag=hb.reward_pending] run scoreboard players set #reward_drop_owner hb_ctx 1
execute unless score #reward_drop_owner hb_ctx matches 1 run return 0
scoreboard players set #reward_reopen_owned hb_ctx 1
kill @s
''', encoding='utf-8')
    for name in ('tick', 'input/reopen_reward'):
        path = root / (name + '.mcfunction')
        write_guarded(path, normalize_recovery('hanabi', name, path.read_text(encoding='utf-8')), encoding='utf-8')


if __name__ == '__main__':
    build()
    build_hanabi()
