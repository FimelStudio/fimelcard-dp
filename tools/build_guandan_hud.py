"""斗地主式掼蛋叠牌：私有BetterTitle、最多八层、实卡独立高亮及逢人配角标。"""
from pathlib import Path
import json
from PIL import Image, ImageDraw
from build_guandan_ui import NAMES

PACK=Path(__file__).resolve().parents[1]
RP=PACK.parents[3]/'resourcepacks/fimelcard-rp'
ROOT=PACK/'data/guandan/function/hud'
OBJECTIVES={n:'dummy' for n in 'gd_panel gd_prev_panel gd_hud_key'.split()}


def put(name,body):
    path=ROOT/(name+'.mcfunction');path.parent.mkdir(parents=True,exist_ok=True)
    path.write_text(body.strip()+'\n',encoding='utf8')


def functions():
    put('activate','''
execute unless data storage fimel_title:io panels run function fimel_title:code/load
execute if entity @s[tag=gd.hud_active] run return 0
scoreboard players set @s gd_prev_panel 0
execute if score @s fbt_panel matches 1.. run scoreboard players operation @s gd_prev_panel = @s fbt_panel
execute unless entity @s[tag=fimel.anim_text.replace.actionbar] run tag @s add gd.owns_actionbar
tag @s add fimel.anim_text.replace.actionbar
function fimel_title:new_panel {id:"@s gd_panel"}
tag @s add gd.hud_active
''')
    put('deactivate','''
# 只清理自己曾分配的面板；若其他游戏已接管，不改其绑定及 actionbar。
execute if score @s gd_panel matches 1.. run function guandan:hud/empty
execute if entity @s[tag=gd.hud_active] if score @s fbt_panel = @s gd_panel run function guandan:hud/restore
tag @s remove gd.owns_actionbar
tag @s remove gd.hud_active
scoreboard players reset @s gd_prev_panel
''')
    put('empty','data modify storage fimel_title:io panel_buffer set value []\nscoreboard players operation panel_id fbt_io = @s gd_panel\nfunction fimel_title:replace_panel')
    put('restore','''
scoreboard players set @s fbt_panel 0
execute if score @s gd_prev_panel matches 1.. run scoreboard players operation @s fbt_panel = @s gd_prev_panel
execute if entity @s[tag=gd.owns_actionbar] run tag @s remove fimel.anim_text.replace.actionbar
title @s actionbar {text:""}
''')
    put('refresh','function guandan:system/context\nexecute as @a[tag=gd.audience] run function guandan:hud/update')
    put('update','''
execute unless entity @s[type=minecraft:player,tag=gd.player,tag=ct.player] run return 0
execute unless score @s ct_id = @s gd_table run return 0
execute unless entity @e[tag=gd.current,scores={ct_game=18,gd_state=1..5},limit=1] run return 0
scoreboard players operation #hud_table gd_ctx = @s gd_table
execute unless score @e[tag=gd.current,limit=1] ct_id = #hud_table gd_ctx run return 0
function guandan:hud/build
''')
    put('build','''
execute unless entity @s[tag=gd.hud_active] run function guandan:hud/activate
scoreboard players operation #hud_table gd_ctx = @s gd_table
scoreboard players operation #hud_seat gd_ctx = @s gd_seat
tag @e[tag=gd.hudhand] remove gd.hudhand
execute as @e[type=minecraft:marker,tag=gd.card] if score @s ct_id = #hud_table gd_ctx if score @s gd_owner = #hud_seat gd_ctx run tag @s add gd.hudhand
execute as @e[tag=gd.hudhand] run function guandan:hud/card_key
data modify storage guandan:hud hand set value {text:"",color:"white",shadow_color:0,extra:[]}
scoreboard players set #hud_previous gd_ctx -1
scoreboard players set #hud_depth gd_ctx 0
scoreboard players set #hud_maxdepth gd_ctx 0
scoreboard players set #hud_groups gd_ctx 0
scoreboard players set #hud_count gd_ctx 0
function guandan:hud/next_card
tag @e[tag=gd.hudhand] remove gd.hudhand
data modify storage fimel_title:io panel_buffer set value []
data modify storage fimel_title:io text_buffer set value []
data modify storage fimel_title:io neg_text_buffer set value []
execute if score #hud_count gd_ctx matches 1.. run function guandan:hud/line
execute if score #hud_count gd_ctx matches 0 run function guandan:hud/empty_hand
scoreboard players operation panel_id fbt_io = @s gd_panel
function fimel_title:replace_panel
scoreboard players operation @s fbt_panel = @s gd_panel
''')
    put('card_key','scoreboard players operation @s gd_hud_key = @s gd_strength\nscoreboard players set #hud_factor gd_ctx 108\nscoreboard players operation @s gd_hud_key *= #hud_factor gd_ctx\nscoreboard players operation @s gd_hud_key += @s gd_id')
    put('next_card','''
execute unless entity @e[tag=gd.hudhand] run return 0
scoreboard players set #hud_max gd_ctx -1
execute as @e[tag=gd.hudhand] run scoreboard players operation #hud_max gd_ctx > @s gd_hud_key
execute as @e[tag=gd.hudhand] if score @s gd_hud_key = #hud_max gd_ctx run function guandan:hud/card
function guandan:hud/next_card
''')
    put('card','''
execute unless score @s gd_strength = #hud_previous gd_ctx run scoreboard players set #hud_depth gd_ctx 0
execute unless score @s gd_strength = #hud_previous gd_ctx run scoreboard players add #hud_groups gd_ctx 1
execute if score @s gd_strength = #hud_previous gd_ctx run data modify storage guandan:hud hand.extra append value {text:"'''+chr(0xEBF0)+'''",font:"card:guandan/spacing"}
execute unless score #hud_previous gd_ctx matches -1 unless score @s gd_strength = #hud_previous gd_ctx run data modify storage guandan:hud hand.extra append value {text:"'''+chr(0xEBF1)+'''",font:"card:guandan/spacing"}
scoreboard players operation #hud_type gd_ctx = @s gd_type
function guandan:hud/type
execute if score @s gd_point = @e[tag=gd.current,limit=1] gd_level run data modify storage guandan:hud glyph set from storage guandan:hud wild
execute if score @s gd_sel matches 1 run data modify storage guandan:hud glyph set from storage guandan:hud selected
execute if score @s gd_sel matches 1 if score @s gd_point = @e[tag=gd.current,limit=1] gd_level run data modify storage guandan:hud glyph set from storage guandan:hud selected_wild
execute store result storage guandan:hud depth int 1 run scoreboard players get #hud_depth gd_ctx
function guandan:hud/append with storage guandan:hud
tag @s remove gd.hudhand
scoreboard players add #hud_count gd_ctx 1
scoreboard players operation #hud_maxdepth gd_ctx > #hud_depth gd_ctx
scoreboard players operation #hud_previous gd_ctx = @s gd_strength
scoreboard players add #hud_depth gd_ctx 1
''')
    put('type','\n'.join(f'execute if score #hud_type gd_ctx matches {i} run data merge storage guandan:hud '+json.dumps({'glyph':chr(0xEC00+i),'selected':chr(0xED00+i),'wild':chr(0xEE00+i),'selected_wild':chr(0xEF00+i)},ensure_ascii=False,separators=(',',':')) for i in range(54)))
    put('append','$data modify storage guandan:hud hand.extra append value {text:"$(glyph)",font:"card:guandan/hand_$(depth)",shadow_color:0}')
    put('line','''
# 默认与斗地主同样56px；牌型多时仅压紧列间距，保持牌面大小及逐张选择。
execute if score #hud_groups gd_ctx matches 11.. run data modify storage guandan:hud hand.extra[{font:"card:guandan/spacing"}].font set value "card:guandan/spacing_dense"
data modify storage fimel_title:io text set from storage guandan:hud hand
data modify storage fimel_title:io font set value "minecraft:default_mod"
data modify storage fimel_title:io neg_font set value "card:guandan/hud_neg"
function fimel_title:new_part
# BetterTitle半宽回退必须覆盖所有牌面的独立font，否则不可见副本也会重复绘牌。
data modify storage fimel_title:io neg_text_buffer[-1].extra[0].extra[].font set value "card:guandan/hud_neg"
execute if score #hud_groups gd_ctx matches 11.. run data modify storage fimel_title:io neg_text_buffer[-1].extra[0].extra[{text:"'''+chr(0xEBF1)+'''"}].font set value "card:guandan/hud_neg_dense"
data modify storage fimel_title:io tempx set value 4000
scoreboard players operation #hud_y gd_ctx = #hud_maxdepth gd_ctx
scoreboard players set #hud_step gd_ctx 20
scoreboard players operation #hud_y gd_ctx *= #hud_step gd_ctx
scoreboard players add #hud_y gd_ctx 2544
execute store result storage fimel_title:io tempy int 1 run scoreboard players get #hud_y gd_ctx
data modify storage fimel_title:io origin set value "default"
data modify storage fimel_title:io align set value "middle"
function fimel_title:code/new_text_macro with storage fimel_title:io
data modify storage fimel_title:io text_buffer set value []
data modify storage fimel_title:io neg_text_buffer set value []
''')
    put('text','''
data modify storage fimel_title:io x set value 0.0d
data modify storage fimel_title:io dx set value 0.0d
data modify storage fimel_title:io dy set value 0.0d
data modify storage fimel_title:io align set value "middle"
data modify storage fimel_title:io origin set value "default"
function fimel_title:new_text
''')
    put('text_default','data modify storage fimel_title:io font set value "minecraft:default_mod"\ndata modify storage fimel_title:io neg_font set value "minecraft:default_neg"\nfunction guandan:hud/text')
    put('empty_hand','''
data modify storage fimel_title:io text set value {text:"已出完手牌",color:"gray",shadow_color:0}
execute if score @e[tag=gd.current,limit=1] gd_state matches 1 run data modify storage fimel_title:io text.text set value "正在发牌…"
data modify storage fimel_title:io y set value 18.0d
function guandan:hud/text_default
''')
    put('status','''
execute store result storage guandan:hud level int 1 run scoreboard players get @e[tag=gd.current,limit=1] gd_level
'''+ '\n'.join(f'execute if score @e[tag=gd.current,limit=1] gd_level matches {v} run data modify storage guandan:hud level set value "{n}"' for v,n in [(11,'J'),(12,'Q'),(13,'K'),(14,'A')])+'''
function guandan:hud/level_text with storage guandan:hud
execute if score @e[tag=gd.current,limit=1] gd_state matches 1 run data modify storage fimel_title:io text.extra append value {text:" · 正在发牌",color:"gray"}
execute if score @e[tag=gd.current,limit=1] gd_state matches 2 run data modify storage fimel_title:io text.extra append value {text:" · 贡还牌",color:"yellow"}
execute if score @e[tag=gd.current,limit=1] gd_state matches 3 if score @s gd_seat = @e[tag=gd.current,limit=1] gd_turn run data modify storage fimel_title:io text.extra append value {text:" · 轮到你",color:"green"}
execute if score @e[tag=gd.current,limit=1] gd_state matches 3 unless score @s gd_seat = @e[tag=gd.current,limit=1] gd_turn run data modify storage fimel_title:io text.extra append value {text:" · 等待出牌",color:"gray"}
execute if score @e[tag=gd.current,limit=1] gd_state matches 4..5 run data modify storage fimel_title:io text.extra append value {text:" · 结算",color:"gold"}
scoreboard players operation #hud_status_y gd_ctx = #hud_maxdepth gd_ctx
scoreboard players set #hud_step gd_ctx 10
scoreboard players operation #hud_status_y gd_ctx *= #hud_step gd_ctx
scoreboard players add #hud_status_y gd_ctx 86
execute store result storage fimel_title:io y double 1 run scoreboard players get #hud_status_y gd_ctx
execute if score #hud_count gd_ctx matches 0 run data modify storage fimel_title:io y set value 38.0d
function guandan:hud/text_default
''')
    put('level_text','$data modify storage fimel_title:io text set value {text:"掼蛋 · 本级 $(level) · 红桃$(level)逢人配",color:"light_purple",shadow_color:0,extra:[]}')


def fonts():
    texture_root=RP/'assets/card/textures/font/guandan'
    texture_root.mkdir(parents=True,exist_ok=True)
    for variant in ('normal','selected','wild','selected_wild'):
        atlas=Image.new('RGBA',(36*9,48*6),(0,0,0,0))
        for i,name in enumerate(NAMES):
            # Use Doudizhu's exact normal/selected cells, remapping physical card IDs.
            dd_names=[suit+'_'+rank for rank in ['3','4','5','6','7','8','9','10','j','q','k','a','2'] for suit in 'sdch']+['j_2','j_1']
            dd_index=dd_names.index(name)
            source_variant='selected' if 'selected' in variant else 'normal'
            with Image.open(RP/f'assets/card/textures/font/doudizhu/{source_variant}.png') as source:
                x=dd_index%9*36;y=dd_index//9*48
                image=source.convert('RGBA').crop((x,y,x+36,y+48))
            draw=ImageDraw.Draw(image)
            # Decorations stay inside the original card silhouette; no outer frame.
            if 'wild' in variant:
                import math
                points=[(25+5*math.cos(-math.pi/2+k*math.pi/5)*(1 if k%2==0 else .43),6+5*math.sin(-math.pi/2+k*math.pi/5)*(1 if k%2==0 else .43)) for k in range(10)]
                draw.polygon(points,fill='#d86bff' if name.startswith('h_') else '#ffd74b',outline='#682887' if name.startswith('h_') else '#946526')
            atlas.paste(image,((i%9)*36,(i//9)*48))
            # 仅移除旧生成器明确创建的逐张字体副本，新图集不需要216个独立provider。
            previous=texture_root/variant/(name+'.png')
            if previous.exists():previous.unlink()
        atlas.save(texture_root/(variant+'.png'))
    target=RP/'assets/card/font/guandan';target.mkdir(parents=True,exist_ok=True)
    providers=[];negative={chr(0xEBF0):21.5,chr(0xEBF1):-1.5}
    for base,variant in [(0xEC00,'normal'),(0xED00,'selected'),(0xEE00,'wild'),(0xEF00,'selected_wild')]:
        providers.append({'type':'bitmap','file':f'card:font/guandan/{variant}.png','height':56,'ascent':56,'chars':[''.join(chr(base+row*9+col) for col in range(9)) for row in range(6)]})
        for i in range(54):negative[chr(base+i)]=-21.5
    output={}
    for depth in range(8):
        output['hand_'+str(depth)]={'providers':[dict(p,ascent=56-depth*10) for p in providers]}
    output['hud_neg']={'providers':[{'type':'space','advances':negative},{'type':'reference','id':'minecraft:default_neg'}]}
    output['hud_neg_dense']={'providers':[{'type':'space','advances':{**negative,chr(0xEBF1):6}},{'type':'reference','id':'minecraft:default_neg'}]}
    output['spacing']={'providers':[{'type':'space','advances':{chr(0xEBF0):-43,chr(0xEBF1):3}}]}
    output['spacing_dense']={'providers':[{'type':'space','advances':{chr(0xEBF0):-43,chr(0xEBF1):-12}}]}
    output['stack_spacing']={'providers':[{'type':'space','advances':{chr(0xEBF1):3,chr(0xEBF2):42}}]}
    slices=[]
    for v,variant in enumerate(('normal','selected','wild','selected_wild')):
        # 36×48牌面分六条，每条36×8；同一个图集按36行读取即可直接得到切片。
        chars=[''.join(chr(0xF000+v*54*6+(row*9+col)*6+part) for col in range(9)) for row in range(6) for part in range(6)]
        slices.append({'type':'bitmap','file':f'card:font/guandan/{variant}.png','height':9,'ascent':7,'chars':chars})
    output['stack']={'providers':slices}
    for name,value in output.items():
        (target/(name+'.json')).write_text(json.dumps(value,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    for obsolete in ('hud.json','dialog.json'):
        previous=target/obsolete
        if previous.exists():previous.unlink()


def build():functions();fonts()
if __name__=='__main__':build(); __import__("build_guandan_layout").build_layout()
