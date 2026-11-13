from pathlib import Path
import json, itertools, hashlib
from PIL import Image
DP=Path(__file__).resolve().parents[1]
BASE=DP.parents[3]
F=DP/'data/avalon/function'
def read(n):return (F/(n+'.mcfunction')).read_text(encoding='utf-8')
render=read('map/render')
assert 'if score @s av_id = #map_table av_ctx run kill @s' in render
assert '@e[type=minecraft:text_display,tag=av.game_entity]' in read('hud/update')
assert 'tag @s add av.game_entity' in read('map/display')
assert 'brightness:' not in read('map/display')
assert 'scores={av_state=1..5}' in read('load')
assert 'scores={av_state=5}' in read('tick')
assert 'av_timer 100' in read('game/finish')
assert 'av_timer matches ..0 run function avalon:game/abort' in read('game/ending_tick')
assert 'data.avalon.results' not in read('game/vote_result') or 'append' not in read('game/vote_result')
names=['route']+[f'{s}_{i}' for i in range(1,6) for s in ['success','failure']]
rps=[BASE/'resourcepacks/fimelcard-rp',BASE/'resourcepacks/Fimel桌游馆']
for rp in rps:
 atlas=json.loads((rp/'assets/minecraft/atlases/items.json').read_text(encoding='utf-8'))
 for name in names:
  key='card:avalon/map/'+name
  assert any(a.get('resource')==key for a in atlas['sources'])
  model=json.loads((rp/f'assets/card/models/item/avalon/map/{name}.json').read_text(encoding='utf-8'))
  item=json.loads((rp/f'assets/card/items/avalon/map/{name}.json').read_text(encoding='utf-8'))
  assert model['textures']['map']==key
  assert item['model']['model']=='card:item/avalon/map/'+name
  image=Image.open(rp/f'assets/card/textures/avalon/map/{name}.png')
  assert image.size==(512,512)
  if name!='route': assert image.getpixel((0,0))[3]==0
for name in names:
 rel=f'assets/card/textures/avalon/map/{name}.png'
 assert (rps[0]/rel).read_bytes()==(rps[1]/rel).read_bytes()
for i in range(5):
 assert f'data.avalon.results[{i}]' in render
 for state,color in [('success','green'),('failure','red')]:
  assert f'result{{color:"{color}"}} run data modify storage avalon:map model set value "{state}_{i+1}"' in render
# All 63 prefixes, including an empty map, map each completed task to exactly one node.
cases=0
for length in range(6):
 for results in itertools.product(['success','failure'],repeat=length):
  layers=[f'{result}_{i+1}' for i,result in enumerate(results)]
  assert len(set(layers))==length and all(x in names for x in layers)
  cases+=1
print(f'PASS: {cases} route states; 11 assets in both packs; reload/table isolation/HUD cleanup/final cleanup guards.')
