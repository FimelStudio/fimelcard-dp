"""Apply the tested direct interaction layer after the legacy game generators."""
from pathlib import Path
import argparse,json
P=Path(__file__).resolve().parents[1]
def build(game):
 if game=='splendor':
  from build_splendor_direct import build as build_splendor_direct
  build_splendor_direct()
  return
 for name,body in json.loads((P/f'tools/direct_interaction_templates/{game}.json').read_text(encoding='utf8')).items():
  path=P/f'data/{game}/function/{name}.mcfunction';path.parent.mkdir(parents=True,exist_ok=True);path.write_text(body,encoding='utf8')
 rp=P.resolve().parents[3]/'resourcepacks/fimelcard-rp'
 for root in (rp,rp.parent/'Fimel桌游馆'):
  if root!=rp and not (root/'pack.mcmeta').is_file():continue
  if game=='love_letter':
   for model in ['spy','guard','priest','baron','handmaid','prince','chancellor','king','countess','princess']:
    obj={'model':{'type':'minecraft:select','property':'minecraft:display_context','cases':[{'when':['thirdperson_righthand','thirdperson_lefthand','ground'],'model':{'type':'minecraft:model','model':'card:item/love_letter/back'}}],'fallback':{'type':'minecraft:model','model':f'card:item/love_letter/{model}'}}}
    path=root/f'assets/card/items/love_letter/hand/{model}.json';path.parent.mkdir(parents=True,exist_ok=True);path.write_text(json.dumps(obj),encoding='utf8')
  if game=='magical_athlete':
   for name in ('mild','wild'):
    path=root/f'assets/card/models/item/magical_athlete/board/{name}.json'
    if not path.exists():continue
    obj=json.loads(path.read_text(encoding='utf8'))
    for el in obj['elements']:
     if el.get('name')=='board':el['from'][1]=8;el['to'][1]=8.06
    path.write_text(json.dumps(obj,indent=2),encoding='utf8')
  if game=='catan':
   for kind in ('settlement','road','city'):
    src=rp/f'assets/card/models/item/catan/{kind}/red.json'
    if not src.exists():continue
    obj=json.loads(src.read_text(encoding='utf8'));obj['textures']={'all':'minecraft:block/light_gray_concrete','particle':'minecraft:block/light_gray_concrete'}
    for rel,data in [(f'assets/card/models/item/catan/{kind}/gray.json',obj),(f'assets/card/items/catan/{kind}/gray.json',{'model':{'type':'minecraft:model','model':f'card:item/catan/{kind}/gray'}})]:
     path=root/rel;path.parent.mkdir(parents=True,exist_ok=True);path.write_text(json.dumps(data),encoding='utf8')
if __name__=='__main__':
 parser=argparse.ArgumentParser();parser.add_argument('--game',required=True,choices=['splendor','catan','magical_athlete','love_letter']);build(parser.parse_args().game)
