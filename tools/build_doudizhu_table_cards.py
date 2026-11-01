"""Public played cards at actual seats; isolated from hidden hand/deal entities."""
from pathlib import Path
import json,math
P=Path(__file__).resolve().parents[1];F=P/'data/doudizhu/function'
def put(n,s):
 p=F/(n+'.mcfunction');p.parent.mkdir(parents=True,exist_ok=True);p.write_text(s.strip()+'\n',encoding='utf8')
def hook(n,needle,line):
 p=F/(n+'.mcfunction');s=p.read_text(encoding='utf8');s=s.replace(line+'\n','');assert needle in s;s=s.replace(needle,line+'\n'+needle,1);p.write_text(s,encoding='utf8')
def build():
 seats={4:[(0,-.91,0),(.91,0,-90),(0,.91,180),(-.91,0,90)],8:[(-.85,-1.38,0),(.85,-1.38,0),(1.38,-.85,-90),(1.38,.85,-90),(.85,1.38,180),(-.85,1.38,180),(-1.38,.85,90),(-1.38,-.85,90)]}
 models=[s+'_'+r for r in ['3','4','5','6','7','8','9','10','j','q','k','a','2'] for s in 'sdch']+['j_2','j_1']
 load=['data modify storage doudizhu:table_cards models set value '+json.dumps(models)]
 for cap,values in seats.items():
  for seat,(x,z,yaw) in enumerate(values,1):
   a=math.radians(yaw);q=math.sqrt(.5);scale=.43
   def turn(dx,dz):return dx*math.cos(a)+dz*math.sin(a),-dx*math.sin(a)+dz*math.cos(a)
   for count in range(1,21):
    items=[]
    for i in range(count):
     row=i//10;cols=min(10,count-row*10);gap=min(.19,.90/max(1,cols-1));dx,dz=turn(((cols-1)/2-i%10)*gap+scale/16,(row*.44)-scale/16)
     items.append(dict(x=round(x+dx,7),y=round(scale/16+(count-1-i)*.001,7),z=round(z+dz,7),qx=round(q*math.cos(a/2),8),qy=round(q*math.sin(a/2),8),qz=round(-q*math.sin(a/2),8),qw=round(q*math.cos(a/2),8)))
    load.append(f'data modify storage doudizhu:table_cards c{cap}.s{seat}.n{count} set value '+json.dumps(items,separators=(',',':')))
 put('visual/load','\n'.join(load))
 put('visual/clear','scoreboard players operation #vc_table dd_ctx = @s dd_id\nexecute as @e[type=minecraft:item_display,tag=dd.public_card] if score @s dd_id = #vc_table dd_ctx run kill @s')
 put('visual/clear_seat',"""scoreboard players operation #vc_table dd_ctx = @e[tag=dd.current,limit=1] dd_id
scoreboard players operation #vc_seat dd_ctx = @s dd_seat
execute as @e[type=minecraft:item_display,tag=dd.public_card] if score @s dd_id = #vc_table dd_ctx if score @s dd_owner = #vc_seat dd_ctx run kill @s""")
 put('visual/play',"""execute unless data storage doudizhu:table_cards models run function doudizhu:visual/load
execute if score @e[tag=dd.current,limit=1] dd_type matches 0 as @e[tag=dd.current,limit=1] run function doudizhu:visual/clear
function doudizhu:visual/clear_seat
execute store result storage doudizhu:table_cards args.cap int 1 run scoreboard players get @e[tag=dd.current,limit=1] ct_capacity
execute store result storage doudizhu:table_cards args.seat int 1 run scoreboard players get @s dd_seat
data modify storage doudizhu:table_cards cards set value []"""+'\n'+'\n'.join(f'execute if entity @e[tag=dd.hand,scores={{dd_card={i},dd_selected=1}}] run data modify storage doudizhu:table_cards cards append value {i-1}' for i in range(54,0,-1))+"""
execute store result storage doudizhu:table_cards args.count int 1 run data get storage doudizhu:table_cards cards
function doudizhu:visual/layout with storage doudizhu:table_cards args
execute at @e[tag=dd.current,limit=1] positioned ~ ~1.04 ~ run function doudizhu:visual/loop""")
 put('visual/layout','$data modify storage doudizhu:table_cards positions set from storage doudizhu:table_cards c$(cap).s$(seat).n$(count)')
 put('visual/loop',"""execute unless data storage doudizhu:table_cards cards[0] run return 0
execute unless data storage doudizhu:table_cards positions[0] run return 0
data modify storage doudizhu:table_cards args.model_index set from storage doudizhu:table_cards cards[0]
data modify storage doudizhu:table_cards card set from storage doudizhu:table_cards positions[0]
function doudizhu:visual/model with storage doudizhu:table_cards args
execute summon minecraft:item_display run function doudizhu:visual/face with storage doudizhu:table_cards card
data remove storage doudizhu:table_cards cards[0]
data remove storage doudizhu:table_cards positions[0]
function doudizhu:visual/loop""")
 put('visual/model','$data modify storage doudizhu:table_cards card.model set from storage doudizhu:table_cards models[$(model_index)]')
 put('visual/face',"""tag @s add dd.public_card
scoreboard players operation @s dd_id = #vc_table dd_ctx
scoreboard players operation @s dd_owner = #vc_seat dd_ctx
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:poker/$(model)"}},item_display:"none",shadow_radius:0f,view_range:1f,transformation:{translation:[$(x)f,$(y)f,$(z)f],left_rotation:[$(qx)f,$(qy)f,$(qz)f,$(qw)f],right_rotation:[0f,1f,0f,0f],scale:[0.43f,0.43f,0.43f]}}""")
 hook('action/play','function doudizhu:hud/record_play','function doudizhu:visual/play')
 hook('action/pass','function doudizhu:hud/record_pass','function doudizhu:visual/clear_seat')
 hook('deal/start','function doudizhu:game/ensure_match','function doudizhu:visual/clear')
 hook('game/abort','tag @s remove dd.music_exciting','function doudizhu:visual/clear')
 hook('load','scoreboard objectives add dd_speed_time dummy','function doudizhu:visual/load')
if __name__=='__main__':build()
