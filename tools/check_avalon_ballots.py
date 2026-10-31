from pathlib import Path
import json,itertools
P=Path(__file__).resolve().parents[1];B=P.parents[3];F=P/'data/avalon/function'
def read(n):return (F/(n+'.mcfunction')).read_text(encoding='utf8')
assert 'translation:[0f,0f,0f]' in read('hud/init') and 'tp @s ~ ~2.2 ~' in read('hud/init')
assert not any('dialog show' in l for p in (F/'dialog').glob('*.mcfunction') for l in p.read_text(encoding='utf8').splitlines() if not l.lstrip().startswith('#'))
assert 'click_event.command set from storage avalon:chat actions[0].action.command' in read('chat/actions')
for code in [20,21,30,31]:assert '{code:'+str(code)+',' not in read('dialog/open')
assert 'execute on origin if entity @s[tag=av.player,tag=ct.player]' in read('input/drop_ballot')
for guard in ['@s av_id = #ballot_table','@s ct_id = #ballot_table','#ballot_epoch av_ctx = @e[tag=av.current,limit=1] av_epoch']:
 assert guard in read('input/ballot')
assert 'av_vote matches 0' in read('input/dispatch') and 'av_mission matches 0' in read('input/dispatch')
assert 'av_selected matches 1' in read('input/dispatch')
for n in ['input/vote','input/mission']:assert 'clear @a[tag=av.actor,limit=1] *[minecraft:custom_data~{avalon:{ballot:1b}}]' in read(n)
assert 'unless score @a[tag=av.actor,limit=1] av_role matches 4..7 run return' in read('input/mission')
assert 'av_role' not in read('player/mission_ballots'), 'tool issuance must not reveal alignment'
assert 'unless items entity @s $(slot) * run return run item replace' in read('player/give_ballot')
roles=['merlin','percival','loyalist','morgana','assassin','oberon','minion']
contexts=['gui','firstperson_righthand','firstperson_lefthand','thirdperson_righthand','thirdperson_lefthand','ground','fixed','head','none']
cases=0
for rp in [B/'resourcepacks/fimelcard-rp',B/'resourcepacks/Fimel桌游馆']:
 for role in roles:
  m=json.loads((rp/f'assets/card/items/avalon/{role}.json').read_text(encoding='utf8'))['model']
  assert m['property']=='minecraft:display_context'
  for ctx in contexts:
   target=next((x['model'] for x in m['cases'] if x['when']==ctx),m['fallback'])['model']
   assert target==('card:item/avalon/'+role if ctx in contexts[:3] else 'card:item/avalon/private_back')
   cases+=1
  reveal=json.loads((rp/f'assets/card/items/avalon/reveal/{role}.json').read_text(encoding='utf8'))
  assert reveal['model']['model']==f'card:item/avalon/reveal/{role}'
print(f'PASS: fixed HUD anchor; chat-only game actions; Q ballot ownership/table/epoch/double-submit guards; {cases} role display contexts; public end reveal retained.')
