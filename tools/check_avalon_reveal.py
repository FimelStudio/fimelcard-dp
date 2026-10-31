from pathlib import Path
import json,re,math
P=Path(__file__).resolve().parents[1];F=P/'data/avalon/function';B=P.parents[3]
def read(n):return (F/(n+'.mcfunction')).read_text(encoding='utf-8')
finish=read('game/finish')
assert finish.index('avalon:reveal/start')<finish.index('avalon:player/clear')
assert 'execute as @a[tag=av.audience]' in read('reveal/start')
uno=(P/'data/uno/function/visual/play.mcfunction').read_text(encoding='utf-8')
ours=read('reveal/player')
for seat in range(1,9):
 u=re.search(r'ct_capacity matches 8 if score #vis_seat un_ctx matches '+str(seat)+r' positioned ~([^ ]+) ~1.04 ~([^ ]+)',uno)
 a=re.search(r'av_seat matches '+str(seat)+r' positioned ~([^ ]+) ~1.08 ~([^ ]+)',ours)
 assert u and a and tuple(map(float,u.groups()))==tuple(map(float,a.groups()))
# Check transformed north-face normal: back upward initially, front upward after flip.
for stage,expected in [('init',-1),('flip',1)]:
 text=read('reveal/'+stage)
 qs=re.findall(r'left_rotation set value \[([^]]+)\]',text)
 assert len(qs)==8
 for values in qs:
  x,y,z,w=[float(v.rstrip('f')) for v in values.split(',')]
  ny=2*(w*x-y*z)
  assert abs(ny-expected)<1e-6,(stage,ny)
for timer,stage in [(95,'lift'),(85,'flip'),(75,'lower')]:
 assert f'av_timer matches {timer} as @e[type=minecraft:item_display,tag=av.reveal] if score @s av_id = #reveal_table av_ctx run function avalon:reveal/{stage}' in read('game/ending_tick')
assert 'tag @s add av.game_entity' in read('reveal/init')
assert 'av_timer matches ..0 run function avalon:game/abort' in read('game/ending_tick')
assert '@e[tag=av.game_entity] if score @s av_id = #table av_ctx run kill @s' in read('game/abort')
roles=['merlin','percival','loyalist','morgana','assassin','oberon','minion']
for rp in [B/'resourcepacks/fimelcard-rp',B/'resourcepacks/Fimel桌游馆']:
 atlas=json.loads((rp/'assets/minecraft/atlases/items.json').read_text(encoding='utf-8'))
 assert any(s.get('resource')=='card:avalon/reveal_back' for s in atlas['sources'])
 for role in roles:
  model=json.loads((rp/f'assets/card/models/item/avalon/reveal/{role}.json').read_text(encoding='utf-8'))
  assert model['elements'][0]['faces']['north']['texture']=='#front'
  assert model['elements'][0]['faces']['south']['texture']=='#back'
  for path in model['textures'].values():assert (rp/('assets/'+path.replace(':','/textures/')+'.png')).exists()
print('PASS: all 8 UNO seat coordinates, front/back normals, 7 role models in both packs, animation timing and scoped cleanup.')
