"""璀璨宝石全员资产 HUD；普通操作提示与面板共享 actionbar。"""
from __future__ import annotations

import json
from boardgame_assets import PACK, RP, text_file, json_file

ROOT = PACK/'data/splendor/function/hud'
OBJECTIVES = {n: 'dummy' for n in ('sp_hpanel', 'sp_hprev', 'sp_htimer')}


def js(value):
    return json.dumps(value, ensure_ascii=False, separators=(',', ':'))


def put(name, lines):
    text_file(ROOT/(name+'.mcfunction'), '\n'.join(lines) if isinstance(lines, list) else lines)


def build():
    put('load', [f'scoreboard objectives add {n} dummy' for n in OBJECTIVES])
    put('activate', [
        'execute unless data storage fimel_title:io panels run function fimel_title:code/load',
        'execute if entity @s[tag=sp.hud] run return 0',
        'scoreboard players set @s sp_hprev 0',
        'execute if score @s fbt_panel matches 1.. run scoreboard players operation @s sp_hprev = @s fbt_panel',
        'function fimel_title:new_panel {id:"@s sp_hpanel"}',
        'scoreboard players set @s sp_htimer 0',
        'tag @s add sp.hud'])
    put('deactivate', [
        'execute unless entity @s[tag=sp.hud] unless entity @s[tag=sp.owns_hud] run return 0',
        'execute if score @s sp_hpanel matches 1.. run function splendor:hud/empty',
        'execute if score @s fbt_panel = @s sp_hpanel run function splendor:hud/restore',
        'execute if entity @s[tag=sp.owns_hud] run tag @s remove fimel.anim_text.replace.actionbar',
        'tag @s remove sp.owns_hud', 'tag @s remove sp.hud',
        'scoreboard players reset @s sp_hprev', 'scoreboard players reset @s sp_htimer'])
    put('empty', ['data modify storage fimel_title:io panel_buffer set value []',
        'scoreboard players operation panel_id fbt_io = @s sp_hpanel',
        'function fimel_title:replace_panel',
        'execute store result storage splendor:hud panel int 1 run scoreboard players get @s sp_hpanel',
        'function splendor:hud/forget_notice with storage splendor:hud'])
    put('forget_notice', '$data remove storage splendor:hud notices.p$(panel)')
    put('restore', ['scoreboard players set @s fbt_panel 0',
        'execute if score @s sp_hprev matches 1.. run scoreboard players operation @s fbt_panel = @s sp_hprev',
        'title @s actionbar {text:""}'])
    put('build', [
        'execute unless entity @e[tag=sp.current,limit=1] run return 0',
        'execute unless score @s sp_table = @e[tag=sp.current,limit=1] ct_id run return 0',
        'execute unless entity @s[tag=sp.hud] run function splendor:hud/activate',
        # 迁移旧版独占标记；本 HUD 中的 notice 保留普通 actionbar 原点。
        'execute if entity @s[tag=sp.owns_hud] run tag @s remove fimel.anim_text.replace.actionbar',
        'tag @s remove sp.owns_hud',
        'data modify storage fimel_title:io panel_buffer set value []',
        'data modify storage fimel_title:io text_buffer set value []',
        'data modify storage fimel_title:io neg_text_buffer set value []',
        'execute store result score #hud_n sp_ctx run data get entity @e[tag=sp.current,limit=1] data.splendor.n',
        *[f'execute if score #hud_n sp_ctx matches {i+1}..4 run function splendor:hud/relative_row '
          +js({'offset':i,'x':8 if i%2==0 else -8,'y':-8 if i<2 else -64,
               'origin':'up-left' if i%2==0 else 'up-right','align':'left' if i%2==0 else 'right'}) for i in range(4)],
        'execute if score @s sp_htimer matches 1.. run function splendor:hud/show_notice',
        'execute unless score @s sp_htimer matches 1.. run function splendor:hud/status with entity @e[tag=sp.current,limit=1] data.splendor',
        'scoreboard players operation panel_id fbt_io = @s sp_hpanel',
        'function fimel_title:replace_panel',
        'scoreboard players operation @s fbt_panel = @s sp_hpanel'])
    put('relative_row', [
        'scoreboard players operation #hud_side sp_ctx = @s sp_side',
        '$scoreboard players add #hud_side sp_ctx $(offset)',
        'scoreboard players remove #hud_side sp_ctx 1',
        'scoreboard players operation #hud_side sp_ctx %= #hud_n sp_ctx',
        'scoreboard players add #hud_side sp_ctx 1',
        '$data modify storage splendor:hud placement set value {side:0,x:$(x),y:$(y),origin:"$(origin)",align:"$(align)"}',
        'execute store result storage splendor:hud placement.side int 1 run scoreboard players get #hud_side sp_ctx',
        'function splendor:hud/relative_show with storage splendor:hud placement',
    ])
    put('relative_show', '$execute if data entity @e[tag=sp.current,limit=1] data.splendor.p$(side).name run function splendor:hud/row {side:$(side),x:$(x),y:$(y),origin:"$(origin)",align:"$(align)"}')
    put('row', [
        '$data modify storage splendor:hud anchor set value {x:$(x),origin:"$(origin)",align:"$(align)"}',
        '$scoreboard players set #hud_y sp_ctx $(y)',
        '$data modify storage splendor:hud player set from entity @e[tag=sp.current,limit=1] data.splendor.p$(side)',
        'data modify storage splendor:hud row set value {name:{text:"玩家"},vp:0,cards:0,nobles:0,reserved:0,marker:"  ",color:"white"}',
        'data modify storage splendor:hud row.name set from storage splendor:hud player.name',
        'data modify storage splendor:hud row.vp set from storage splendor:hud player.vp',
        'execute store result storage splendor:hud row.cards int 1 run data get storage splendor:hud player.cards',
        'execute store result storage splendor:hud row.nobles int 1 run data get storage splendor:hud player.nobles',
        'execute store result storage splendor:hud row.reserved int 1 run data get storage splendor:hud player.reserve',
        '$execute if score @e[tag=sp.current,limit=1] sp_turn matches $(side) run data modify storage splendor:hud row.marker set value "▶ "',
        '$execute if score @e[tag=sp.current,limit=1] sp_turn matches $(side) run data modify storage splendor:hud row.color set value "yellow"',
        *[f'data modify storage splendor:hud row.t{i} set from storage splendor:hud player.tokens[{i}]' for i in range(6)],
        *[f'data modify storage splendor:hud row.b{i} set from storage splendor:hud player.bonus[{i}]' for i in range(5)],
        'function splendor:hud/row_text with storage splendor:hud row'])
    header = {'text': '', 'bold':False, 'shadow_color': 0, 'extra': [
        {'text': '$(marker)', 'color': '$(color)'}, '$(name)',
        {'text': ' · $(vp)分 · 贵族$(nobles)', 'color': 'gold'}]}
    # Name 是已序列化组件，不能当作普通字符串插入。
    header_text = js(header).replace('"$(name)"', '$(name)')
    tokens = {'text': '宝石 ', 'color': 'gray', 'bold':False, 'shadow_color': 0, 'extra': []}
    bonus = {'text': '折扣 ', 'color': 'gray', 'bold':False, 'shadow_color': 0, 'extra': []}
    for row, field, n in ((tokens, 't', 6), (bonus, 'b', 5)):
        for i in range(n):
            row['extra'] += [{'text': chr(0xE980+i), 'color': 'white'},
                             {'text': '$('+field+str(i)+') ', 'color': 'white'}]
    put('row_text', ['$data modify storage fimel_title:io text set value '+header_text,
        'function splendor:hud/text',
        'scoreboard players remove #hud_y sp_ctx 12',
        '$data modify storage fimel_title:io text set value '+js(tokens), 'function splendor:hud/text',
        'scoreboard players remove #hud_y sp_ctx 12',
        '$data modify storage fimel_title:io text set value '+js(bonus), 'function splendor:hud/text',
        'scoreboard players remove #hud_y sp_ctx 12',
        '$data modify storage fimel_title:io text set value {text:"发展$(cards)张 · 预定$(reserved)/3",color:"gray",bold:false,shadow_color:0}',
        'function splendor:hud/text'])
    put('text', ['execute store result storage splendor:hud anchor.y int 1 run scoreboard players get #hud_y sp_ctx',
        'function splendor:hud/line with storage splendor:hud anchor'])
    put('line', ['data modify storage fimel_title:io font set value "card:splendor/hud"',
        'data modify storage fimel_title:io neg_font set value "card:splendor/hud_neg"',
        '$data modify storage fimel_title:io x set value $(x)d',
        '$data modify storage fimel_title:io y set value $(y)d',
        '$data modify storage fimel_title:io origin set value "$(origin)"',
        '$data modify storage fimel_title:io align set value "$(align)"',
        'data modify storage fimel_title:io dx set value 0.0d',
        'data modify storage fimel_title:io dy set value 0.0d',
        'function fimel_title:new_text'])
    put('center', ['data modify storage fimel_title:io font set value "minecraft:default_mod"',
        'data modify storage fimel_title:io neg_font set value "minecraft:default_neg"',
        'data modify storage fimel_title:io x set value 0.0d',
        'data modify storage fimel_title:io y set value 0.0d',
        'data modify storage fimel_title:io dx set value 0.0d',
        'data modify storage fimel_title:io dy set value 0.0d',
        'data modify storage fimel_title:io origin set value "default"',
        'data modify storage fimel_title:io align set value "middle"',
        'function fimel_title:new_text'])
    put('status', ['$data modify storage fimel_title:io text set value {text:"第$(round)轮 · ",color:"gold",bold:false,extra:[{nbt:"data.splendor.p$(turn).name",entity:"@e[tag=sp.current,limit=1]",interpret:true},{text:" 行动 · 右键选择/确认 · 左键取消",color:"yellow"}]}',
        'execute if score @e[tag=sp.current,limit=1] sp_state matches 2 run data modify storage fimel_title:io text set value {text:"宝石超过10颗：右键选退珠、左键撤销，或Q丢出多余宝石",color:"yellow"}',
        'execute if score @e[tag=sp.current,limit=1] sp_state matches 4 run data modify storage fimel_title:io text set value {text:"交易结束 · 查看本局结果",color:"gold"}',
        'function splendor:hud/center'])
    put('notice', ['$data modify storage splendor:hud incoming set value $(text)',
        'execute unless entity @s[tag=sp.hud] run function splendor:hud/activate',
        'execute store result storage splendor:hud panel int 1 run scoreboard players get @s sp_hpanel',
        'function splendor:hud/store_notice with storage splendor:hud',
        'scoreboard players set @s sp_htimer 100',
        'function splendor:hud/build'])
    put('store_notice', '$data modify storage splendor:hud notices.p$(panel) set from storage splendor:hud incoming')
    put('show_notice', ['execute store result storage splendor:hud panel int 1 run scoreboard players get @s sp_hpanel',
        'function splendor:hud/read_notice with storage splendor:hud',
        'function splendor:hud/center'])
    put('read_notice', '$data modify storage fimel_title:io text set from storage splendor:hud notices.p$(panel)')
    put('tick', ['execute unless score @s sp_htimer matches 1.. run return 0',
        'scoreboard players remove @s sp_htimer 1',
        'execute if score @s sp_htimer matches 0 run function splendor:hud/build'])
    fonts()


def fonts():
    # BetterTitle每行输出两遍负字距，每遍必须为原宽度的一半。
    from PIL import Image
    font = json.loads((RP/'assets/card/font/splendor/small.json').read_text(encoding='utf-8'))
    advances = {}
    for provider in font['providers']:
        if provider['type'] != 'bitmap':
            continue
        with Image.open(RP/'assets'/provider['file'].replace(':', '/textures/')) as image:
            rows = provider['chars']
            cellw, cellh = image.width//len(rows[0]), image.height//len(rows)
            for y, row in enumerate(rows):
                for x, ch in enumerate(row):
                    if not 0xE980 <= ord(ch) <= 0xE985:
                        continue
                    alpha = image.convert('RGBA').getchannel('A').crop((x*cellw, y*cellh, (x+1)*cellw, (y+1)*cellh))
                    bounds = alpha.getbbox()
                    width = bounds[2] if bounds else 0
                    advances[ch] = -(int(width*provider['height']/cellh+.5)+1)/2
    assert len(advances) == 6
    json_file(RP/'assets/card/font/splendor/hud.json', {'providers': [
        {'type': 'reference', 'id': 'card:splendor/small'}, {'type': 'reference', 'id': 'minecraft:default_mod'}]})
    json_file(RP/'assets/card/font/splendor/hud_neg.json', {'providers': [
        {'type': 'space', 'advances': advances}, {'type': 'reference', 'id': 'minecraft:default_neg'}]})


if __name__ == '__main__':
    build()
