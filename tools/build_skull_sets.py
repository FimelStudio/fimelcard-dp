"""Install eight distinct Skull art pairs from saved ImageGen source atlases."""
from pathlib import Path
import json,shutil
from PIL import Image
P=Path(__file__).resolve().parents[1];R=P.parents[3]/'resourcepacks/fimelcard-rp';F=P/'data/skull/function'
def build():
 entries=json.loads((P/'docs/skull-art/sets.json').read_text(encoding='utf8'))
 for entry in entries:
  seat=entry['seat'];im=Image.open(P/entry['source']).convert('RGB')
  for index,kind in enumerate(['flower','skull']):
   texture=f'card:item/skull/set{seat}/{kind}';model=f'card:item/skull/set{seat}/{kind}'
   out=R/f'assets/card/textures/item/skull/set{seat}/{kind}.png';out.parent.mkdir(parents=True,exist_ok=True)
   im.crop((round(index*im.width/2),0,round((index+1)*im.width/2),im.height)).resize((256,384),Image.Resampling.LANCZOS).save(out)
   data=json.loads((R/f'assets/card/models/item/skull/{kind}.json').read_text(encoding='utf8'))
   data['textures']['front']=texture;data['textures']['particle']=texture
   out=R/f'assets/card/models/item/skull/set{seat}/{kind}.json';out.parent.mkdir(parents=True,exist_ok=True);out.write_text(json.dumps(data,ensure_ascii=False,indent=2),encoding='utf8')
   data=json.loads((R/f'assets/card/items/skull/{kind}.json').read_text(encoding='utf8'));data['model']['fallback']['model']=model
   out=R/f'assets/card/items/skull/set{seat}/{kind}.json';out.parent.mkdir(parents=True,exist_ok=True);out.write_text(json.dumps(data,ensure_ascii=False,indent=2),encoding='utf8')
 cards=[{'slot':slot,'type':int(slot==4),'model':'card:skull/set$(seat)/'+('skull' if slot==4 else 'flower'),'name':('骷髅牌' if slot==4 else '花牌')+' · 第$(seat)套'} for slot in range(1,5)]
 (F/'deck/init_seat.mcfunction').write_text('$data modify entity @s data.skull.seats.s$(seat) set value '+json.dumps({'owned':cards,'hand':[],'stack':[],'visible':[]},ensure_ascii=False,separators=(',',':'))+'\n',encoding='utf8')
 f=F/'challenge/flip.mcfunction';s=f.read_text(encoding='utf8');s=s.replace('data modify storage skull:io visual.model set value "card:skull/flower"\nexecute if data storage skull:io revealed{type:1} run data modify storage skull:io visual.model set value "card:skull/skull"','data modify storage skull:io visual.model set from storage skull:io revealed.model');f.write_text(s,encoding='utf8')
 for name in ['ui/build','ui/discard','rules/show']:
  f=F/(name+'.mcfunction');s=f.read_text(encoding='utf8').replace('花牌＝万寿菊','花牌＝各自套装的花卉').replace('（万寿菊）','').replace('花牌 · 万寿菊','花牌');f.write_text(s,encoding='utf8')
 for folder in ['assets/card/textures/item/skull','assets/card/models/item/skull','assets/card/items/skull']:shutil.copytree(R/folder,R.parent/'Fimel桌游馆'/folder,dirs_exist_ok=True)
 __import__('fix_skull_card_display').build()
if __name__=='__main__':build()
