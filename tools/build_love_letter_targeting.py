"""情书：短暂保留的朝向选择与不消耗手牌的头颅精准选择。"""
from pathlib import Path
from build_table_pause_guards import write_guarded

ROOT = Path(__file__).resolve().parents[1] / 'data/love_letter/function'


def build(root=ROOT):
    def put(name, body):
        p = root / (name + '.mcfunction')
        p.parent.mkdir(parents=True, exist_ok=True)
        write_guarded(p, body.strip() + '\n', encoding='utf-8')

    def insert(name, anchor, body, before=False):
        p = root / (name + '.mcfunction')
        if not p.exists():
            return
        text = p.read_text(encoding='utf-8')
        start, end = '# selection: begin\n', '# selection: end\n'
        if start in text:
            a = text.index(start)
            b = text.index(end, a) + len(end)
            text = text[:a] + text[b:]
        assert anchor in text, (name, anchor)
        block = start + body.strip() + '\n' + end
        text = text.replace(anchor, block + anchor if before else anchor + block, 1)
        write_guarded(p, text, encoding='utf-8')

    # Exact first, then a forgiving outer hitbox; adjacent players cannot steal a direct hit.
    scan = '''function love_letter:targeting/scan_clear
scoreboard players set #aim ll_ctx 0
scoreboard players set #pitch ll_ctx 0
execute as @a[tag=ll.audience] if score @s ll_seat = #actor ll_ctx run tag @s add ll.aim_actor
execute as @a[tag=ll.aim_actor] store result score #pitch ll_ctx run data get entity @s Rotation[1]
execute if score #pitch ll_ctx matches 50.. run return run function love_letter:targeting/scan_clear
execute as @a[tag=ll.audience] unless score @s ll_seat = #actor ll_ctx run tag @s add ll.aim_candidate
execute as @a[tag=ll.aim_actor] at @s anchored eyes positioned ^ ^ ^ run summon minecraft:marker ~ ~ ~ {Tags:["ll.aim_ray"]}
function love_letter:targeting/ray
function love_letter:targeting/scan_clear'''
    put('targeting/scan', scan)
    ray = []
    for wide in (False, True):
        for step in range(1, 25):
            ray += [f'execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_actor] at @s anchored eyes positioned ^ ^ ^{step*.35:.2f} run tp @e[tag=ll.aim_ray,limit=1] ~ ~ ~',
                    'execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_candidate] at @s anchored eyes positioned ^ ^ ^ run function love_letter:targeting/' + ('body_wide' if wide else 'body')]
    put('targeting/ray', '\n'.join(ray))
    for name, radius in [('body', .45), ('body_wide', .8)]:
        put('targeting/' + name, '\n'.join(
            f'execute if score #aim ll_ctx matches 0 positioned ~ ~{-offset:g} ~ if entity @e[tag=ll.aim_ray,distance=..{radius},limit=1] run scoreboard players operation #aim ll_ctx = @s ll_seat'
            for offset in (0, .5, 1, 1.5)))

    put('targeting/resolve', '''
function love_letter:targeting/scan
scoreboard players set #blocked ll_ctx 0
execute unless score @s ll_aimepoch = @s ll_epoch run scoreboard players set @s ll_aim 0
execute unless score @s ll_aimepoch = @s ll_epoch run scoreboard players set @s ll_aimttl 0
scoreboard players operation @s ll_aimepoch = @s ll_epoch
# 受保护与已出局的身体仍可命中，但不能留下旧目标误打另一人。
scoreboard players set #aim_legal ll_ctx 0
execute as @e[tag=ll.board,scores={ll_alive=1,ll_protect=0}] if score @s ll_seat = #aim ll_ctx run scoreboard players set #aim_legal ll_ctx 1
execute if score #aim ll_ctx matches 1..8 unless score #aim_legal ll_ctx matches 1 run scoreboard players set @s ll_aim 0
execute if score #aim ll_ctx matches 1..8 unless score #aim_legal ll_ctx matches 1 run scoreboard players set @s ll_aimttl 0
execute if score #aim ll_ctx matches 1..8 unless score #aim_legal ll_ctx matches 1 run scoreboard players set #blocked ll_ctx 1
execute if score #blocked ll_ctx matches 1 run scoreboard players set #aim ll_ctx 0
execute if score #blocked ll_ctx matches 1 run return 0
execute if score #pitch ll_ctx matches 50.. run scoreboard players set @s ll_aim 0
execute if score #pitch ll_ctx matches 50.. run scoreboard players set @s ll_aimttl 0
execute if score #aim ll_ctx matches 1..8 run scoreboard players operation @s ll_aim = #aim ll_ctx
execute if score #aim ll_ctx matches 1..8 run scoreboard players set @s ll_aimttl 60
scoreboard players set #remember_legal ll_ctx 0
scoreboard players operation #remember ll_ctx = @s ll_aim
execute as @e[tag=ll.board,scores={ll_alive=1,ll_protect=0}] if score @s ll_seat = #remember ll_ctx run scoreboard players set #remember_legal ll_ctx 1
execute unless score #remember_legal ll_ctx matches 1 run scoreboard players set @s ll_aim 0
execute unless score @s ll_aimttl matches 1.. run scoreboard players set @s ll_aim 0
scoreboard players operation #aim ll_ctx = @s ll_aim
''')
    put('targeting/preflight', '''
tag @e[tag=ll.legal] remove ll.legal
execute as @e[tag=ll.board,scores={ll_alive=1,ll_protect=0}] unless score @s ll_seat = #actor ll_ctx run tag @s add ll.legal
execute if score #card ll_ctx matches 5 as @e[tag=ll.board,scores={ll_alive=1,ll_protect=0}] run tag @s add ll.legal
execute unless entity @e[tag=ll.legal] run return 0
execute if score @s ll_timeout matches 1 run return 0
execute if score @s ll_target_mode matches 1 unless score @s ll_exact matches 1..8 run return run function love_letter:targeting/request
execute unless score @s ll_exact matches 1..8 run function love_letter:targeting/resolve
execute unless score @s ll_exact matches 1..8 if score #blocked ll_ctx matches 1 run scoreboard players set #error ll_ctx 4
execute if score @s ll_exact matches 1..8 run scoreboard players operation #aim ll_ctx = @s ll_exact
execute as @e[tag=ll.legal] if score @s ll_seat = #aim ll_ctx run scoreboard players operation #pre_target ll_ctx = @s ll_seat
execute if score #aim ll_ctx matches 1..8 unless score #pre_target ll_ctx matches 1..8 run scoreboard players set #error ll_ctx 4
execute unless score #error ll_ctx matches 4 if score #aim ll_ctx matches 0 if score #card ll_ctx matches 5 run scoreboard players operation #pre_target ll_ctx = #actor ll_ctx
execute if score #pre_target ll_ctx matches 0 unless score #error ll_ctx matches 4 run scoreboard players set #error ll_ctx 3
''')
    put('targeting/request', '''
scoreboard players operation @s ll_select_slot = #slot ll_ctx
scoreboard players operation @s ll_select_actor = #actor ll_ctx
scoreboard players operation @s ll_select_epoch = @s ll_epoch
scoreboard players set #error ll_ctx 5
''')
    put('targeting/tick', '''
function love_letter:system/context
execute unless score @s ll_state matches 2 run return run function love_letter:targeting/clear
execute unless score @s ll_phase matches 1 run return run function love_letter:targeting/clear
execute unless score @s ll_anim matches 0 run return run function love_letter:targeting/clear
scoreboard players operation #actor ll_ctx = @s ll_turn
scoreboard players set #unavailable ll_ctx 0
execute as @a[tag=ll.audience,scores={ll_hintwait=1..}] if score @s ll_seat = #actor ll_ctx run scoreboard players remove @s ll_hintwait 1
execute if score @s ll_aimttl matches 1.. run scoreboard players remove @s ll_aimttl 1
execute unless score @s ll_target_mode matches 1 run function love_letter:targeting/resolve
execute if score @s ll_target_mode matches 1 run scoreboard players set #aim ll_ctx 0
execute if score @s ll_target_mode matches 1 if score @s ll_select_epoch = @s ll_epoch as @a[tag=ll.audience] if score @s ll_seat = #actor ll_ctx run function love_letter:targeting/head_preview
execute if score @s ll_target_mode matches 1 unless score @s ll_select_epoch = @s ll_epoch as @a[tag=ll.audience] if score @s ll_seat = #actor ll_ctx run function love_letter:targeting/held
execute unless score @e[tag=ll.current,limit=1] ll_target_mode matches 1 as @a[tag=ll.audience] if score @s ll_seat = #actor ll_ctx run function love_letter:targeting/held
function love_letter:targeting/highlight
''')
    put('targeting/highlight', '''
execute as @a[tag=ll.audience,tag=ll.aim_preview] unless score @s ll_seat = #aim ll_ctx run effect clear @s minecraft:glowing
execute as @a[tag=ll.audience,tag=ll.aim_preview] unless score @s ll_seat = #aim ll_ctx run tag @s remove ll.aim_preview
execute as @a[tag=ll.audience] if score @s ll_seat = #aim ll_ctx run tag @s add ll.aim_preview
execute as @a[tag=ll.audience,tag=ll.aim_preview] run effect give @s minecraft:glowing 1 0 true
''')
    put('targeting/held', '''
scoreboard players set #held ll_ctx -1
execute if data entity @s SelectedItem.components."minecraft:custom_data".love_letter{hand:1b} store result score #held ll_ctx run data get entity @s SelectedItem.components."minecraft:custom_data".love_letter.card
execute if score @e[tag=ll.current,limit=1] ll_target_mode matches 1 unless score #held ll_ctx matches 4 run return 0
execute if score #held ll_ctx matches 4 run scoreboard players operation #aim ll_ctx = #actor ll_ctx
execute if score #held ll_ctx matches 5 if score #aim ll_ctx matches 0 run scoreboard players operation #aim ll_ctx = #actor ll_ctx
execute unless score #held ll_ctx matches 1..5 unless score #held ll_ctx matches 7 run return 0
execute if score @s ll_hintwait matches 1.. run return 0
execute unless score #held ll_ctx matches 4 if score #blocked ll_ctx matches 1 run return run title @s actionbar {text:"该玩家已出局或受侍女保护，请选择其他玩家。",color:"yellow"}
function love_letter:targeting/hint
''')
    put('targeting/hint', '''
execute unless score @s ll_hint_target = #aim ll_ctx run scoreboard players set @s ll_hint 0
scoreboard players operation @s ll_hint_target = #aim ll_ctx
execute if score @s ll_hintwait matches 1.. run return 0
execute if score @s ll_hint matches 1.. run scoreboard players remove @s ll_hint 1
execute if score @s ll_hint matches 1.. run return 0
scoreboard players set @s ll_hint 5
tag @a[tag=ll.hint_target] remove ll.hint_target
execute as @a[tag=ll.audience] if score @s ll_seat = #aim ll_ctx run tag @s add ll.hint_target
execute if score #aim ll_ctx matches 1..8 unless score #unavailable ll_ctx matches 1 run title @s actionbar [{text:"已选中：",color:"yellow"},{selector:"@a[tag=ll.hint_target,limit=1]",color:"green"},{text:" · Q 确认",color:"gray"}]
execute if score #aim ll_ctx matches 1..8 if score #unavailable ll_ctx matches 1 run title @s actionbar [{text:"目标：",color:"yellow"},{selector:"@a[tag=ll.hint_target,limit=1]",color:"white"},{text:" · 不可选：已出局、受保护或不能对自己使用",color:"red"}]
execute if score #aim ll_ctx matches 0 run title @s actionbar {text:"未选中玩家 · 朝向目标选中（保留3秒），低头清除",color:"yellow"}
tag @a[tag=ll.hint_target] remove ll.hint_target
''')
    put('targeting/clear', '''
scoreboard players set @s ll_aim 0
scoreboard players set @s ll_aimttl 0
execute as @a[tag=ll.audience,tag=ll.aim_preview] run effect clear @s minecraft:glowing
tag @a[tag=ll.audience,tag=ll.aim_preview] remove ll.aim_preview
''')

    # The original cards stay in authoritative part markers until a valid head is confirmed.
    put('targeting/heads', '''
execute as @e[tag=ll.inventory_controller,limit=1] run function love_letter:system/context
clear @s *[minecraft:custom_data~{love_letter:{hand:1b}}]
scoreboard players set #head_index ll_ctx 0
tag @a[tag=ll.head_actor] remove ll.head_actor
tag @s add ll.head_actor
execute as @a[tag=ll.audience] at @s run function love_letter:targeting/head_data
function love_letter:targeting/cancel_item with storage love_letter:input
tag @a[tag=ll.head_actor] remove ll.head_actor
''')
    put('targeting/head_data', '''
data modify storage love_letter:input uuid set from entity @s UUID
function love_letter:name/resolve
data modify storage love_letter:input head_name set from storage love_letter:name resolved
execute store result storage love_letter:input target int 1 run scoreboard players get @s ll_seat
execute store result storage love_letter:input head_slot int 1 run scoreboard players get #head_index ll_ctx
execute as @a[tag=ll.head_actor,limit=1] run function love_letter:targeting/head_item with storage love_letter:input
scoreboard players add #head_index ll_ctx 1
''')
    put('targeting/head_item', '''
$execute if items entity @s hotbar.$(head_slot) *[minecraft:custom_data~{love_letter:{head:1b,table:$(table),owner:$(owner),epoch:$(epoch),target:$(target)}}] run return 0
$execute if items entity @s hotbar.$(head_slot) * unless items entity @s hotbar.$(head_slot) *[minecraft:custom_data~{love_letter:{tool:1b}}] run return 0
$item replace entity @s hotbar.$(head_slot) with minecraft:player_head[minecraft:profile={id:$(uuid)},minecraft:item_name=[$(head_name),{text:" · Q 指定目标",color:"yellow",italic:false}],minecraft:max_stack_size=1,minecraft:custom_data={love_letter:{tool:1b,head:1b,table:$(table),owner:$(owner),epoch:$(epoch),target:$(target)}}]
''')
    put('targeting/cancel_item', '''
$execute if items entity @s hotbar.8 *[minecraft:custom_data~{love_letter:{head:1b,table:$(table),owner:$(owner),epoch:$(epoch),target:0}}] run return 0
execute if items entity @s hotbar.8 * unless items entity @s hotbar.8 *[minecraft:custom_data~{love_letter:{tool:1b}}] run return 0
$item replace entity @s hotbar.8 with minecraft:purple_dye[minecraft:item_model="minecraft:barrier",minecraft:item_name={text:"取消选人 · Q 返回手牌",color:"yellow",italic:false},minecraft:custom_data={love_letter:{tool:1b,head:1b,table:$(table),owner:$(owner),epoch:$(epoch),target:0}}]
''')
    put('targeting/head_preview', '''
execute as @e[tag=ll.current,limit=1] run function love_letter:targeting/selection_context
scoreboard players set #aim ll_ctx 0
execute if data entity @s SelectedItem.components."minecraft:custom_data".love_letter{head:1b} run data modify storage love_letter:input preview set from entity @s SelectedItem.components."minecraft:custom_data".love_letter
execute if data entity @s SelectedItem.components."minecraft:custom_data".love_letter{head:1b} run function love_letter:targeting/head_preview_validate with storage love_letter:input preview
scoreboard players set #head_legal ll_ctx 0
execute as @e[tag=ll.legal] if score @s ll_seat = #aim ll_ctx run scoreboard players set #head_legal ll_ctx 1
scoreboard players set #unavailable ll_ctx 0
execute unless score #head_legal ll_ctx matches 1 run scoreboard players set #unavailable ll_ctx 1
execute if score #aim ll_ctx matches 1..8 run function love_letter:targeting/hint
execute if score #aim ll_ctx matches 0 unless score @s ll_hintwait matches 1.. run title @s actionbar {text:"请选择玩家头颅，按 Q 指定目标；最后一格 Q 取消。",color:"yellow"}
execute unless score #head_legal ll_ctx matches 1 run scoreboard players set #aim ll_ctx 0
''')
    put('targeting/head_preview_validate', '''
$execute unless score @s ll_table matches $(table) run return 0
$execute unless score @s ll_seat matches $(owner) run return 0
$execute unless score @e[tag=ll.current,limit=1] ll_epoch matches $(epoch) run return 0
$scoreboard players set #aim ll_ctx $(target)
''')
    put('targeting/selection_context', '''
scoreboard players operation #actor ll_ctx = @s ll_select_actor
scoreboard players set #card ll_ctx -1
execute if score @s ll_select_slot matches 0 as @e[tag=ll.board] if score @s ll_seat = #actor ll_ctx run scoreboard players operation #card ll_ctx = @s ll_hand
execute if score @e[tag=ll.current,limit=1] ll_select_slot matches 1 as @e[tag=ll.board] if score @s ll_seat = #actor ll_ctx run scoreboard players operation #card ll_ctx = @s ll_extra
tag @e[tag=ll.legal] remove ll.legal
execute as @e[tag=ll.board,scores={ll_alive=1,ll_protect=0}] unless score @s ll_seat = #actor ll_ctx run tag @s add ll.legal
execute if score #card ll_ctx matches 5 as @e[tag=ll.board,scores={ll_alive=1,ll_protect=0}] run tag @s add ll.legal
''')
    put('targeting/confirm', '''
function love_letter:input/context
execute unless entity @s[tag=ll.actor] run return 0
$execute unless score @s ll_table matches $(table) run return run function love_letter:targeting/stale
$execute unless score @s ll_seat matches $(owner) run return run function love_letter:targeting/stale
$execute unless score @e[tag=ll.current,limit=1] ll_epoch matches $(epoch) run return run function love_letter:targeting/stale
execute unless entity @e[tag=ll.current,scores={ll_state=2,ll_phase=1,ll_anim=0,ll_target_mode=1},limit=1] run return run function love_letter:targeting/stale
execute unless score @e[tag=ll.current,limit=1] ll_select_epoch = @e[tag=ll.current,limit=1] ll_epoch run return run function love_letter:targeting/stale
execute unless score @s ll_seat = @e[tag=ll.current,limit=1] ll_turn run return run function love_letter:targeting/stale
execute unless score @s ll_seat = @e[tag=ll.current,limit=1] ll_select_actor run return run function love_letter:targeting/stale
$execute if score @s ll_seat matches $(owner) if score #actor ll_ctx matches $(owner) run scoreboard players set #head_target ll_ctx $(target)
execute if score #head_target ll_ctx matches 0 run return run function love_letter:targeting/cancel
scoreboard players operation #slot ll_ctx = @e[tag=ll.current,limit=1] ll_select_slot
scoreboard players operation @e[tag=ll.current,limit=1] ll_exact = #head_target ll_ctx
execute as @e[tag=ll.current,limit=1] at @s run function love_letter:engine/play
scoreboard players set @e[tag=ll.current,limit=1] ll_exact 0
execute if score #ok ll_ctx matches 1 run return run function love_letter:targeting/cancel
scoreboard players set @s ll_hintwait 40
title @s actionbar {text:"此目标不可选：已出局、受侍女保护，或此牌不能对自己使用。",color:"yellow"}
function love_letter:input/give
''')
    put('targeting/cancel', '''
scoreboard players set @e[tag=ll.current,limit=1] ll_select_epoch 0
scoreboard players set @e[tag=ll.current,limit=1] ll_exact 0
clear @s *[minecraft:custom_data~{love_letter:{head:1b}}]
function love_letter:input/give
''')
    put('targeting/stale', '''
clear @s *[minecraft:custom_data~{love_letter:{head:1b}}]
scoreboard players set @s ll_hintwait 40
title @s actionbar {text:"选人操作已过期，请重新 Q 出手牌。",color:"yellow"}
function love_letter:input/give
''')

    insert('input/play', 'execute if score #ok ll_ctx matches 1 run return 1\n', '''
execute if score #error ll_ctx matches 5 run return run function love_letter:input/give
scoreboard players set @s ll_hintwait 40
''')
    insert('input/give_tools', 'clear @s *[minecraft:custom_data~{love_letter:{tool:1b,action:0}}]\n', '''
execute if score @e[tag=ll.inventory_controller,limit=1] ll_select_epoch = @e[tag=ll.inventory_controller,limit=1] ll_epoch if score @s ll_seat = @e[tag=ll.inventory_controller,limit=1] ll_select_actor run return run function love_letter:targeting/heads
clear @s *[minecraft:custom_data~{love_letter:{head:1b}}]
''')
    insert('input/check_drop', 'data modify storage love_letter:input dropped set from entity @s Item.components."minecraft:custom_data".love_letter\n', '''
execute if data storage love_letter:input dropped{head:1b} as @a[tag=ll.dropper,limit=1] run function love_letter:targeting/confirm with storage love_letter:input dropped
execute if data storage love_letter:input dropped{head:1b} run return run kill @s
''')
    insert('input/tick', 'execute as @a[tag=ll.player,scores={ll_drop=1..}]', '''
execute as @a[tag=ll.player,scores={ll_head_drop=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function love_letter:input/drop
''', before=True)
    insert('input/drop', 'scoreboard players set @s ll_drop 0\n', 'scoreboard players set @s ll_head_drop 0')
    insert('input/clear', 'scoreboard players reset @s ll_drop\n', '''
scoreboard players reset @s ll_head_drop
scoreboard players reset @s ll_hint
scoreboard players reset @s ll_hintwait
scoreboard players reset @s ll_hint_target
''')
    insert('game/bump_epoch', 'scoreboard players operation @s ll_epoch = #epoch_serial ll_ctx\n', '''
scoreboard players set @s ll_select_epoch 0
scoreboard players set @s ll_exact 0
scoreboard players set @s ll_aim 0
scoreboard players set @s ll_aimttl 0
''')
    insert('game/clear', 'function love_letter:targeting/clear\n', '''
scoreboard players set @s ll_select_epoch 0
scoreboard players set @s ll_exact 0
''')
    # Reserve the full hotbar only for the mode that actually needs head slots.
    insert('game/start', 'execute if score #occupied ll_ctx matches 1 run return run function love_letter:game/bad_slots\n', '\n'.join(
        f'execute if score @s ll_target_mode matches 1 as @a[tag=ct.player] if score @s ct_id = #table ll_ctx if items entity @s hotbar.{slot} * run scoreboard players set #occupied ll_ctx 1'
        for slot in range(2, 9)) + '\nexecute if score @s ll_target_mode matches 1 if score #occupied ll_ctx matches 1 run return run function love_letter:targeting/bad_slots', before=True)
    put('targeting/bad_slots', '''
execute as @a[tag=ct.player] if score @s ct_id = #table ll_ctx run tellraw @s {text:"[情书] 头颅精准选择需要使用快捷栏，请先腾空全部9格。",color:"yellow"}
return fail
''')


if __name__ == '__main__':
    build()
