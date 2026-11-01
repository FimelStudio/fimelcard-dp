"""情书私人手牌 BetterTitle 面板，仅读取本桌本人的逻辑手牌。"""
import json
from pathlib import Path

PACK=Path(__file__).resolve().parents[1]
RP=PACK.parents[3]/'resourcepacks/fimelcard-rp'
ROOT=PACK/'data/love_letter/function/hud'
ROLES=['spy','guard','priest','baron','handmaid','prince','chancellor','king','countess','princess']


def put(name,body):
    p=ROOT/(name+'.mcfunction');p.parent.mkdir(parents=True,exist_ok=True)
    p.write_text(body.strip()+'\n',encoding='utf-8')


def functions():
    put('activate','''
execute unless data storage fimel_title:io panels run function fimel_title:code/load
execute if entity @s[tag=ll.hud_active] run return 0
scoreboard players set @s ll_prev_panel 0
execute if score @s fbt_panel matches 1.. run scoreboard players operation @s ll_prev_panel = @s fbt_panel
execute unless entity @s[tag=fimel.anim_text.replace.actionbar] run tag @s add ll.owns_actionbar
tag @s add fimel.anim_text.replace.actionbar
function fimel_title:new_panel {id:"@s ll_panel"}
tag @s add ll.hud_active
''')
    put('deactivate','''
execute if score @s ll_panel matches 1.. run function love_letter:hud/empty
execute if entity @s[tag=ll.hud_active] if score @s fbt_panel = @s ll_panel run function love_letter:hud/restore
execute if entity @s[tag=ll.owns_actionbar] run tag @s remove fimel.anim_text.replace.actionbar
tag @s remove ll.owns_actionbar
tag @s remove ll.hud_active
scoreboard players reset @s ll_prev_panel
''')
    put('empty','''
data modify storage fimel_title:io panel_buffer set value []
scoreboard players operation panel_id fbt_io = @s ll_panel
function fimel_title:replace_panel
''')
    put('restore','''
scoreboard players set @s fbt_panel 0
execute if score @s ll_prev_panel matches 1.. run scoreboard players operation @s fbt_panel = @s ll_prev_panel
title @s actionbar {text:""}
''')
    put('refresh','''
function love_letter:system/context
execute as @a[tag=ll.audience] run function love_letter:hud/update
''')
    put('update','''
execute unless entity @s[type=minecraft:player,tag=ll.player,tag=ct.player] run return 0
execute unless score @s ct_id = @s ll_table run return 0
execute unless entity @e[tag=ll.current,scores={ct_game=17,ll_state=1..4},limit=1] run return 0
scoreboard players operation #hud_table ll_ctx = @s ll_table
execute unless score @e[tag=ll.current,limit=1] ct_id = #hud_table ll_ctx run return 0
function love_letter:hud/build
''')
    put('build','''
execute unless entity @s[tag=ll.hud_active] run function love_letter:hud/activate
scoreboard players operation #hud_seat ll_ctx = @s ll_seat
scoreboard players operation #hud_table ll_ctx = @s ll_table
tag @e[tag=ll.hud_part] remove ll.hud_part
execute as @e[tag=ll.part] if score @s ct_id = #hud_table ll_ctx if score @s ll_seat = #hud_seat ll_ctx run tag @s add ll.hud_part
data modify storage fimel_title:io panel_buffer set value []
data modify storage fimel_title:io text_buffer set value []
data modify storage fimel_title:io neg_text_buffer set value []
execute if entity @e[tag=ll.hud_part,scores={ll_alive=1},limit=1] run function love_letter:hud/cards
function love_letter:hud/status
scoreboard players operation panel_id fbt_io = @s ll_panel
function fimel_title:replace_panel
scoreboard players operation @s fbt_panel = @s ll_panel
tag @e[tag=ll.hud_part] remove ll.hud_part
''')
    commands=['data modify storage fimel_title:io text set value {text:"",shadow_color:0,extra:[]}']
    for slot,objective in enumerate(('ll_hand','ll_extra')):
        if slot:
            commands.append('execute if entity @e[tag=ll.hud_part,scores={ll_extra=0..9},limit=1] run data modify storage fimel_title:io text.extra append value '+json.dumps({'text':chr(0xE90A)},ensure_ascii=False,separators=(',',':')))
        for i,role in enumerate(ROLES):
            commands.append(f'execute if entity @e[tag=ll.hud_part,scores={{{objective}={i}}},limit=1] run data modify storage fimel_title:io text.extra append value '+json.dumps({'text':chr(0xE900+i),'color':'white'},ensure_ascii=False,separators=(',',':')))
    commands += ['data modify storage fimel_title:io font set value "card:love_letter/hud"',
                 'data modify storage fimel_title:io neg_font set value "card:love_letter/hud_neg"',
                 'data modify storage fimel_title:io y set value 20.0d','function love_letter:hud/text']
    put('cards','\n'.join(commands))
    put('status','''
data modify storage fimel_title:io text set value {text:"情书 · ",color:"gold",shadow_color:0,extra:[]}
execute if score @e[tag=ll.current,limit=1] ll_state matches 1 run data modify storage fimel_title:io text.extra append value {text:"正在发牌",color:"yellow"}
execute if score @e[tag=ll.current,limit=1] ll_state matches 2 if score @s ll_seat = @e[tag=ll.current,limit=1] ll_turn run data modify storage fimel_title:io text.extra append value {text:"轮到你",color:"green"}
execute if score @e[tag=ll.current,limit=1] ll_state matches 2 unless score @s ll_seat = @e[tag=ll.current,limit=1] ll_turn run data modify storage fimel_title:io text.extra append value {text:"等待出牌",color:"gray"}
execute if entity @e[tag=ll.hud_part,scores={ll_alive=0},limit=1] run data modify storage fimel_title:io text.extra append value {text:" · 本轮已淘汰",color:"red"}
execute if entity @e[tag=ll.hud_part,scores={ll_alive=1,ll_protect=1},limit=1] run data modify storage fimel_title:io text.extra append value {text:" · 保护中",color:"aqua"}
execute if score @e[tag=ll.current,limit=1] ll_state matches 3 run data modify storage fimel_title:io text.extra append value {text:"本轮结算",color:"yellow"}
execute if score @e[tag=ll.current,limit=1] ll_state matches 4 run data modify storage fimel_title:io text.extra append value {text:"整场结束",color:"yellow"}
data modify storage fimel_title:io text.extra append value {text:" · ",color:"dark_gray"}
execute store result storage love_letter:hud points int 1 run scoreboard players get @e[tag=ll.hud_part,limit=1] ll_points
function love_letter:hud/points with storage love_letter:hud
execute if score @e[tag=ll.current,limit=1] ll_state matches 2 if score @e[tag=ll.current,limit=1] ll_time_setting matches 1.. run function love_letter:hud/clock
data modify storage fimel_title:io y set value 84.0d
data modify storage fimel_title:io font set value "minecraft:default_mod"
data modify storage fimel_title:io neg_font set value "minecraft:default_neg"
function love_letter:hud/text
''')
    put('points','$data modify storage fimel_title:io text.extra append value {text:"$(points) 好感",color:"light_purple"}')
    put('clock','''
scoreboard players operation #hud_seconds ll_ctx = @e[tag=ll.current,limit=1] ll_clock
scoreboard players add #hud_seconds ll_ctx 19
scoreboard players set #hud_twenty ll_ctx 20
scoreboard players operation #hud_seconds ll_ctx /= #hud_twenty ll_ctx
execute store result storage love_letter:hud seconds int 1 run scoreboard players get #hud_seconds ll_ctx
function love_letter:hud/clock_text with storage love_letter:hud
''')
    put('clock_text','$data modify storage fimel_title:io text.extra append value {text:" · $(seconds)秒",color:"yellow"}')
    put('text','''
data modify storage fimel_title:io x set value 0.0d
data modify storage fimel_title:io dx set value 0.0d
data modify storage fimel_title:io dy set value 0.0d
data modify storage fimel_title:io align set value "middle"
data modify storage fimel_title:io origin set value "default"
function fimel_title:new_text
''')


def fonts():
    from PIL import Image
    target=RP/'assets/card/font/love_letter'
    target.mkdir(parents=True,exist_ok=True)
    providers=[];negative={chr(0xE90A):-4}
    for i,role in enumerate(ROLES):
        path=RP/f'assets/card/textures/item/love_letter/{role}.png'
        if not path.exists():
            print('Waiting for role textures before font export: '+str(path));return
        with Image.open(path) as bitmap:w,h=bitmap.size
        glyph=chr(0xE900+i)
        providers.append({'type':'bitmap','file':f'card:item/love_letter/{role}.png','height':56,'ascent':56,'chars':[glyph]})
        negative[glyph]=-(round(56*w/h)+1)/2
    providers += [{'type':'space','advances':{chr(0xE90A):8}},{'type':'reference','id':'minecraft:default_mod'}]
    (target/'hud.json').write_text(json.dumps({'providers':providers},ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    (target/'hud_neg.json').write_text(json.dumps({'providers':[{'type':'space','advances':negative},{'type':'reference','id':'minecraft:default_neg'}]},ensure_ascii=False,indent=2)+'\n',encoding='utf-8')


if __name__=='__main__':
    functions();fonts()
