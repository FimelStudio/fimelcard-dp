from pathlib import Path
import json,shutil
from PIL import Image,ImageDraw,ImageFont
P=Path(__file__).resolve().parents[1];R=P.parents[3]/'resourcepacks/fimelcard-rp';F=P/'data/skull/function'
def build():
 def write(path,data):path.parent.mkdir(parents=True,exist_ok=True);path.write_text(json.dumps(data,ensure_ascii=False,indent=2),encoding='utf8')
 colors=['#e99b22','#b52c40','#9260cb','#479568','#db579a','#e0bc2d','#e85f48','#5685c5']
 font=ImageFont.truetype('C:/Windows/Fonts/arialbd.ttf',72)
 for seat in range(1,9):
  base=R/f'assets/card/textures/item/skull/set{seat}'
  back=Image.open(R/'assets/card/textures/item/skull/back.png').convert('RGB').resize((256,384))
  d=ImageDraw.Draw(back);d.rectangle((4,4,251,379),outline=colors[seat-1],width=12);d.ellipse((72,136,184,248),fill='#123a3d',outline=colors[seat-1],width=7);d.text((128,192),str(seat),font=font,anchor='mm',fill='#fff4d8');back.save(base/'back.png')
  for kind in ['flower','skull','back']:
   full=Image.open(base/f'{kind}.png').convert('RGBA')
   # Poker UVs sample x=1.333..10, y=.666..15.333 on the front.
   atlas=Image.new('RGBA',(384,384),(170,166,151,255));atlas.paste(full.resize((208,352),Image.Resampling.LANCZOS),(32,16));atlas.save(base/f'{kind}_hand.png')
   path=f'card:item/skull/set{seat}/{kind}'
   table=json.loads((R/'assets/card/models/item/skull/flower.json').read_text(encoding='utf8'))
   table['textures']={'front':path,'back':f'card:item/skull/set{seat}/back','particle':path}
   write(R/f'assets/card/models/item/skull/set{seat}/{kind}_table.json',table)
   hand={'parent':'card:item/fake_card','textures':{'0':path+'_hand','1':f'card:item/skull/set{seat}/back_hand','particle':path+'_hand'}}
   write(R/f'assets/card/models/item/skull/set{seat}/{kind}.json',hand)
   item={'model':{'type':'minecraft:select','property':'minecraft:display_context','cases':[{'when':['thirdperson_righthand','thirdperson_lefthand'],'model':{'type':'minecraft:model','model':f'card:item/skull/set{seat}/back'}},{'when':'none','model':{'type':'minecraft:model','model':path+'_table'}}],'fallback':{'type':'minecraft:model','model':path}}}
   write(R/f'assets/card/items/skull/set{seat}/{kind}.json',item)
 f=F/'round/play_card.mcfunction';s=f.read_text(encoding='utf8').replace('model:"card:skull/back"','model:"card:skull/set$(seat)/back"');f.write_text(s,encoding='utf8')
 # Refresh older already-placed common backs by seat without altering revealed cards.
 f=F/'visual/card.mcfunction';s=f.read_text(encoding='utf8');line='$execute if data storage skull:visual {model:"card:skull/back"} run data modify storage skull:visual model set value "card:skull/set$(seat)/back"'
 if line not in s:s=s.replace('\n$execute positioned','\n'+line+'\n$execute positioned')
 f.write_text(s,encoding='utf8')
 for folder in ['assets/card/textures/item/skull','assets/card/models/item/skull','assets/card/items/skull']:shutil.copytree(R/folder,R.parent/'Fimel桌游馆'/folder,dirs_exist_ok=True)
if __name__=='__main__':build()
