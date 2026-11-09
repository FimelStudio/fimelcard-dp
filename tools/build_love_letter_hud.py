"""Retire the Love Letter BetterTitle panel and clean up panels from old saves."""

from pathlib import Path

from build_table_pause_guards import write_guarded


PACK = Path(__file__).resolve().parents[1]
ROOT = PACK / 'data/love_letter/function/hud'


def put(name, body):
    path = ROOT / (name + '.mcfunction')
    path.parent.mkdir(parents=True, exist_ok=True)
    write_guarded(path, body.strip() + '\n', encoding='utf-8')


def functions():
    # Existing saves can still have a bound private panel and an actionbar claim.
    # Clean it once, then keep the old entry points inert for other generators.
    put('deactivate', '''
execute unless entity @s[tag=ll.hud_active] unless entity @s[tag=ll.owns_actionbar] run return 0
execute if score @s ll_panel matches 1.. run function love_letter:hud/empty
execute if score @s fbt_panel = @s ll_panel run function love_letter:hud/restore
execute if entity @s[tag=ll.owns_actionbar] run tag @s remove fimel.anim_text.replace.actionbar
tag @s remove ll.owns_actionbar
tag @s remove ll.hud_active
scoreboard players reset @s ll_prev_panel
''')
    put('empty', '''
data modify storage fimel_title:io panel_buffer set value []
scoreboard players operation panel_id fbt_io = @s ll_panel
function fimel_title:replace_panel
''')
    put('restore', '''
scoreboard players set @s fbt_panel 0
execute if score @s ll_prev_panel matches 1.. run scoreboard players operation @s fbt_panel = @s ll_prev_panel
title @s actionbar {text:""}
''')
    put('refresh', '''
execute as @a[tag=ll.hud_active] run function love_letter:hud/deactivate
execute as @a[tag=ll.owns_actionbar] run function love_letter:hud/deactivate
''')
    put('update', 'function love_letter:hud/deactivate')
    for obsolete in ('activate', 'build', 'cards', 'status', 'points', 'clock', 'clock_text', 'text'):
        put(obsolete, 'return 0')


if __name__ == '__main__':
    functions()
