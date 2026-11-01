from pathlib import Path
import json,math,shutil
from PIL import Image
P=Path(__file__).resolve().parents[1];F=P/'data/guandan/function';R=P.parents[3]/'resourcepacks/fimelcard-rp'
def put(n,s):(F/(n+'.mcfunction')).write_text(s.strip()+'\n',encoding='utf8')
def build_layout():
 full={};part={};neg={}
 for v,name in enumerate(['normal','selected','wild','selected_wild']):
  im=Image.open(R/f'assets/card/textures/font/guandan/{name}.png')
  for i in range(54):
   x=i%9*36;y=i//9*48;c=im.crop((x,y,x+36,y+48));a=math.floor(c.getchannel('A').getbbox()[2]*56/48+.5)+1;k=chr(0xD700+v*54+i);full[k]=43-a;neg[k]=0 # Full glyph already rewinds the padded 43px width.
   for j in range(6):
    box=c.crop((0,j*8,36,j*8+8)).getchannel('A').getbbox();a=math.floor((box[2] if box else 0)*9/8+.5)+1;part[chr(0xD000+v*324+i*6+j)]=42-a
 for name,adv in [(f'hand_{i}',full) for i in range(8)]+[('stack',part)]:
  q=R/f'assets/card/font/guandan/{name}.json';d=json.loads(q.read_text(encoding='utf8'));d['providers']=[x for x in d['providers'] if x['type']!='space']+[{'type':'space','advances':adv}];q.write_text(json.dumps(d,ensure_ascii=False),encoding='utf8')
 q=R/'assets/card/font/guandan/hud_neg.json';d=json.loads(q.read_text(encoding='utf8'));d['providers'][0]['advances'].update(neg);q.write_text(json.dumps(d,ensure_ascii=False),encoding='utf8')
 for name in ['hud/type','ui/type']:
  s=(F/(name+'.mcfunction')).read_text(encoding='utf8')
  for v in range(4):
   for i in range(54):
    if name=='hud/type':
     ch=chr([0xEC00,0xED00,0xEE00,0xEF00][v]+i);s=s.replace('"'+ch+'"','"'+ch+chr(0xD700+v*54+i)+'"')
    else:
     for j in range(6):
      k=v*324+i*6+j;ch=chr(0xF000+k);s=s.replace('"'+ch+'"','"'+ch+chr(0xD000+k)+'"')
  put(name,s)
 put('hud/line','\n'.join(l for l in (F/'hud/line.mcfunction').read_text(encoding='utf8').splitlines() if 'spacing_dense' not in l and 'hud_neg_dense' not in l))
 s='scoreboard players set #pub_order gd_ctx 0\nexecute as @e[tag=gd.board] if score @s gd_seat = #hud_seat gd_ctx run scoreboard players operation #pub_order gd_ctx = @s gd_order\n'
 for label,offset,side,y in [('上家',1,'left',-48),('自己',0,'left',-126),('队友',2,'right',-48),('下家',3,'right',-126)]:
  s+=f'scoreboard players operation #pub_target gd_ctx = #pub_order gd_ctx\nscoreboard players add #pub_target gd_ctx {offset}\nscoreboard players operation #pub_target gd_ctx %= #four gd_ctx\ndata modify storage guandan:hud label set value "{label} "\ndata modify storage fimel_title:io y set value {y}.0d\ndata modify storage fimel_title:io x set value {8 if side=="left" else -8}.0d\ndata modify storage fimel_title:io align set value "{side}"\ndata modify storage fimel_title:io origin set value "up-{side}"\nexecute as @e[tag=gd.board] if score @s gd_order = #pub_target gd_ctx run function guandan:hud/public_row\n'
 put('hud/public',s)
 put('hud/public_row','''execute store result storage guandan:hud public_count int 1 run scoreboard players get @s gd_count
function guandan:hud/public_label with storage guandan:hud
data modify storage fimel_title:io text.extra append from entity @s data.gd_name
execute if score @e[tag=gd.current,limit=1] gd_show matches 1 run function guandan:hud/public_count with storage guandan:hud
execute if score @s gd_seat = @e[tag=gd.current,limit=1] gd_turn run data modify storage fimel_title:io text.extra append value {text:" ◀",color:"green"}
data modify storage fimel_title:io font set value "minecraft:default_mod"
data modify storage fimel_title:io neg_font set value "minecraft:default_neg"
data modify storage fimel_title:io dx set value 0.0d
data modify storage fimel_title:io dy set value 0.0d
function fimel_title:new_text
data modify storage fimel_title:io text set value {text:"本轮：",color:"gray",shadow_color:0,extra:[]}
data modify storage guandan:hud shown set from entity @s data.last_play
execute unless data storage guandan:hud shown[0] run data modify storage fimel_title:io text.extra append value {text:"尚未出牌"}
function guandan:hud/public_cards
data modify storage fimel_title:io font set value "card:guandan/public"
data modify storage fimel_title:io neg_font set value "card:guandan/public_neg"
data modify storage fimel_title:io dy set value -20.0d
function fimel_title:new_text
execute unless data entity @s data.last_play[0] run return 0
data modify storage fimel_title:io text set value {text:"",color:"gray",shadow_color:0}
# Resolve the label now, not later in the viewer context.
data modify storage fimel_title:io text.text set from entity @s data.last_label
data modify storage fimel_title:io font set value "minecraft:default_mod"
data modify storage fimel_title:io neg_font set value "minecraft:default_neg"
data modify storage fimel_title:io dy set value -22.0d
function fimel_title:new_text
''')
 put('hud/public_label','$data modify storage fimel_title:io text set value {text:"$(label)",color:"aqua",shadow_color:0,extra:[]}')
 put('hud/public_count','$data modify storage fimel_title:io text.extra append value {text:" 剩余 $(public_count) 张",color:"yellow"}')
 put('hud/public_cards','''execute unless data storage guandan:hud shown[0] run return 0
execute store result score #public_type gd_ctx run data get storage guandan:hud shown[0]
function guandan:hud/public_type
data remove storage guandan:hud shown[0]
function guandan:hud/public_cards''')
 put('hud/public_type','\n'.join(f'execute if score #public_type gd_ctx matches {i} run data modify storage fimel_title:io text.extra append value {{text:"{chr(0xEC00+i)}",color:"white"}}' for i in range(54)))
 q=F/'hud/build.mcfunction';s=q.read_text(encoding='utf8').replace('function guandan:hud/public\n','').replace('function guandan:hud/status\n','');s=s.replace('scoreboard players operation panel_id fbt_io','function guandan:hud/public\nscoreboard players operation panel_id fbt_io');q.write_text(s,encoding='utf8')
 provider={'type':'bitmap','file':'card:font/guandan/normal.png','height':24,'ascent':12,'chars':[''.join(chr(0xEC00+r*9+c) for c in range(9)) for r in range(6)]};adv={};im=Image.open(R/'assets/card/textures/font/guandan/normal.png')
 for i in range(54):
  right=im.crop((i%9*36,i//9*48,i%9*36+36,i//9*48+48)).getchannel('A').getbbox()[2];adv[chr(0xEC00+i)]=-(math.floor(right*24/48+.5)+1)/2
 for n,d in [('public',{'providers':[provider,{'type':'reference','id':'minecraft:default_mod'}]}),('public_neg',{'providers':[{'type':'space','advances':adv},{'type':'reference','id':'minecraft:default_neg'}]})]:
  (R/f'assets/card/font/guandan/{n}.json').write_text(json.dumps(d,ensure_ascii=False),encoding='utf8')
 for folder in ['assets/card/font/guandan','assets/card/textures/font/guandan']:shutil.copytree(R/folder,R.parent/'Fimel桌游馆'/folder,dirs_exist_ok=True)
 __import__('fix_card_stack_seams').build()
if __name__=='__main__':build_layout()
