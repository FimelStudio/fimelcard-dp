"""Restore each game through its public, table-bound entry points."""
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
def build(games):
    lines=[]
    for i,(game,pre) in enumerate(games,1):
        base=ROOT/f'data/{game}/function'
        calls=[]
        # Bind all table-scoped selectors before any player inventory operation.
        if (base/'system/context.mcfunction').exists():calls.append('system/context')
        elif (base/'context.mcfunction').exists():calls.append('context')
        if game in ('abraca','bullshit','decrypto','critical_point','skull'):calls.append('game/resume')
        elif game=='hanabi':calls.append('input/restore_table')
        elif game=='avalon':calls.append('game/refresh')
        else:
            if (base/'ui/refresh.mcfunction').exists():calls.append('ui/refresh')
            if (base/'input/give.mcfunction').exists():
                ui=(base/'ui/refresh.mcfunction')
                if not ui.exists() or f'function {game}:input/give' not in ui.read_text(encoding='utf-8'):calls.append('input/give')
            elif (base/'input/give_tools.mcfunction').exists():
                body=(base/'input/give_tools.mcfunction').read_text(encoding='utf-8')
                if not any(l.startswith('$') for l in body.splitlines()):calls.append('input/give_tools')
            if game=='doudizhu':calls.append('system/refresh')
            if (base/'hud/refresh.mcfunction').exists():calls.append('hud/refresh')
        for call in calls:
            line=f'execute if score @s ct_game matches {i}'
            if call.startswith('input/') and call!='input/restore_table':line+=f' as @a[tag={pre}.player,tag=ct.player] if score @s ct_id = #session_table ct_ctx'
            lines.append(line+f' run function {game}:{call}')
    (ROOT/'data/cardtable/function/session/refresh_ui.mcfunction').write_text('\n'.join(lines)+'\n',encoding='utf-8')
if __name__=='__main__':
    from build_table_sessions import GAMES
    build(GAMES)
