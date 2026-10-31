from pathlib import Path
import re,json,itertools
P=Path(__file__).resolve().parents[1];F=P/'data/avalon/function'
def read(n):return (F/(n+'.mcfunction')).read_text(encoding='utf8')
errors=[];funcs=list(F.rglob('*.mcfunction'))
for p in funcs:
 s=p.read_text(encoding='utf8')
 for ns,name in re.findall(r'\bfunction ([a-z_0-9]+):([a-z_0-9/]+)',s):
  if not (P/f'data/{ns}/function/{name}.mcfunction').is_file():errors.append(f'{p.name}: missing {ns}:{name}')
 # 所有括号必须配对，字符串中的引号与反斜线按转义处理。
 for ln,line in enumerate(s.splitlines(),1):
  if line.startswith('#'):continue
  stack=[];quote=None;escape=False
  for c in line:
   if quote:
    if escape:escape=False
    elif c=='\\':escape=True
    elif c==quote:quote=None
   elif c in '\"\'':quote=c
   elif c in '{[(':stack.append(c)
   elif c in '}])':
    if not stack or stack.pop()!={'}':'{',']':'[',')':'('}[c]:errors.append(f'{p}:{ln}: bracket')
  if stack or quote:errors.append(f'{p}:{ln}: unterminated')
objectives=set(re.findall(r'objectives add (av_\w+)',read('load')))
for p in funcs:
 for obj in re.findall(r'\bav_\w+',p.read_text(encoding='utf8')):
  if obj not in objectives:errors.append('objective missing '+obj)
for p in (F/'dialog').glob('*.mcfunction'):
 assert 'selector:' not in p.read_text(encoding='utf8'),p
assert 'av_ui_epoch = @e[tag=av.current,limit=1] av_epoch' in read('input/handle')
assert 'av_ui_base' in read('input/handle')
assert 'av_role matches 4..7 run return 0' in read('input/mission')
assert 'scoreboard players set @s av_state 0' in read('game/abort')
assert 'execute at @s run function cardtable:game/return_lobby' in read('game/abort')
assert read('game/finish').startswith('execute unless score @s av_state matches 1..4')
# 从实际人数配置命令提取任务表，再枚举全部任务投票组合。
config={(int(n),int(r)):int(k) for n,r,k in re.findall(r'av_players matches (\d+) if score @s av_round matches (\d+) run scoreboard players set @s av_need (\d+)',read('game/team'))}
expected={5:[2,3,2,3,3],6:[2,3,4,3,4],7:[2,3,3,4,4],8:[3,4,4,5,5]}
cases=0
for n,rows in expected.items():
 for r,k in enumerate(rows,1):
  assert config[n,r]==k
  for votes in itertools.product([0,1],repeat=k):
   threshold=2 if n>=7 and r==4 else 1
   fail=sum(votes)>=threshold
   assert (not fail)==(sum(votes)<threshold);cases+=1
 for votes in itertools.product([0,1],repeat=n):assert (sum(votes)*2>n)==(sum(votes)>n//2);cases+=1
 # 稀疏座位：下一任队长总能找到，轮换一圈恰好覆盖实际入座者。
 for seats in itertools.combinations(range(1,9),n):
  for seat in seats:
   nxt=seat
   for _ in range(8):
    nxt=nxt%8+1
    if nxt in seats:break
   assert nxt in seats and nxt!=seat;cases+=1
assert not errors,errors
for n in ['load','tick']:
 v=json.loads((P/f'data/minecraft/tags/function/{n}.json').read_text(encoding='utf8'));assert v['values'].count('avalon:'+n)==1
for n in ['game/start','game/open_rules','game/open_settings','vote/finish','table/remove']:
 assert 'avalon:' in (P/f'data/cardtable/function/{n}.mcfunction').read_text(encoding='utf8')
print(f'PASS: {len(funcs)} functions; references/objectives/brackets/identity privacy/nonce guards; {cases} voting, mission and sparse-seat cases; lifecycle routes.')

# 强制组队与保护轮的实际命令守卫。
assert 'scoreboard players operation #force av_ctx = @s av_players' in read('game/submit_team')
assert 'scoreboard players remove #force av_ctx 1' in read('game/submit_team')
assert 'if score @s av_reject >= #force av_ctx' in read('game/submit_team')
assert 'scoreboard players set @s av_reject 0' in read('game/mission_start')
assert 'av_players matches 7.. if score @s av_round matches 4' in read('game/mission_result')
assert 'if score @s av_good matches 3.. run return run function avalon:game/assassination' in read('game/mission_result')
assert 'if score @s av_evil matches 3.. run return run function avalon:game/evil_win' in read('game/mission_result')
for role in range(1,8):
 assert f'av_role matches {role} unless items entity @s hotbar.7' in read('player/identity')
assert 'execute as @a[tag=av.audience] run function avalon:player/identity' in read('game/tick')
assert 'if score @s av_seat = #action av_ctx' in read('input/toggle')
assert 'if score @s av_id = #table av_ctx' in read('context')
assert 'if score @s ct_id = #table av_ctx' in read('context')
assert 'unless score #online av_ctx = @s av_players run return run function avalon:game/abort' in read('game/tick')
print('PASS: force-team threshold, protection round, win/assassination routing, seven role cards, table isolation and disconnect cleanup guards.')
