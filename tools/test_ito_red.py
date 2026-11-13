from pathlib import Path
import ast,re,itertools
F=Path(__file__).resolve().parents[1]/'data/ito/function'
def read(n):return (F/(n+'.mcfunction')).read_text(encoding='utf8')
# Execute the scoring thresholds read from the actual function for varied rankings.
rules=[(int(a),int(b)) for a,b in re.findall(r'#better it_ctx matches (\d+) run scoreboard players add @s it_total (\d+)',read('red/score'))]
def points(sums):
 players=[n for n in sums for _ in range(2)]
 return [sum(p for threshold,p in rules if sum(1 for y in players if 1<=y<=99 and y>x)==threshold) if 1<=x<=99 else 0 for x in sums]
for sums,expected in [([99,98,97],[2,1,0]),([99,99,98],[2,2,0]),([99,98,98],[2,1,1]),([101,98,0],[0,2,0]),([103,101],[0,0]),([99],[2]),([0],[0])]:assert points(sums)==expected,(sums,points(sums))
for nums in itertools.permutations(range(1,6),4):
 a,b,c,d=nums
 # Rank is by pair sum, not individual number or confirmation order.
 assert points([a+b,c+d])==list(reversed(points([c+d,a+b])))
for nonce in [1,12,999,10000000]:
 for mode in [0,1]:
  for input_mode in [1,2]:
   code=int(f'{nonce}{mode}{input_mode}')
   assert code<2147483647
   assert code%10==input_mode and code//10%10==mode and code//100==nonce
choose=read('red/choose')
assert choose.index('it_offer = @s it_seat')<choose.index('scoreboard players set @s it_done 1')
assert 'tag=it.audience,scores={it_done=0}' in choose
assert 'if score #sum it_ctx matches 100' in choose and 'function ito:game/finish' in choose
assert 'function ito:red/open' in read('input/play_number')
assert read('deal/player').index('it_mode matches 1 run return 0')<read('deal/player').index('it_round matches 2..')
assert 'it_mode matches 1 run return 0' in read('game/play')
assert 'it_total=5..' in read('red/check') and '#aboard it_ctx matches 2..' in read('red/check')
for f in F.rglob('*.mcfunction'):
 for name in re.findall(r'function ito:([a-z0-9_/]+)',f.read_text(encoding='utf8')):assert (F/(name+'.mcfunction')).exists(),(f,name)
for name in ['build_ito.py','build_ito_red.py']:ast.parse((F.parents[2]/'tools'/name).read_text(encoding='utf8'))
print('PASS: score ranking/ties/invalid pairs, settings encoding, mutual consent and availability guards, exact-100 ending, one-card rounds, two-boat threshold, references and generator syntax.')
