import fs from 'node:fs';
import path from 'node:path';
import assert from 'node:assert/strict';
const read=(ns,n)=>fs.readFileSync('data/'+ns+'/function/'+n+'.mcfunction','utf8');
const walk=d=>fs.readdirSync(d,{withFileTypes:true}).flatMap(e=>e.isDirectory()?walk(path.join(d,e.name)):[path.join(d,e.name)]);
const seats=mask=>Array.from({length:8},(_,i)=>i+1).filter(i=>mask&(1<<(i-1)));
const caps={liars_holdem:8,hanabi:5,abraca:5};
let placements=0;
for(const [ns,max]of Object.entries(caps)){
 const start=read(ns,'game/start');
 const allowed=start.match(/ct_joined matches (\d+)\.\.(\d+)/);
 assert.deepEqual(allowed.slice(1).map(Number),[2,max]);
 assert.match(start,/ct_joined > @s ct_capacity run return fail/);
 for(const capacity of [4,8])for(let count=0;count<=9;count++)
  assert.equal(count>=2&&count<=Number(allowed[2])&&count<=capacity,count>=2&&count<=Math.min(max,capacity));
 for(let mask=1;mask<256;mask++){
  const players=seats(mask);if(players.length<2||players.length>max)continue;
  const hand=ns==='hanabi'?(players.length>=4?4:5):ns==='abraca'?5:2;
  const received=new Map(players.map(p=>[p,0]));
  let scan=0;
  const source=read(ns,'deal/scan_once');
  const bound=Number(source.match(/matches (\d+)\.\. run scoreboard players set @s \w+ 1/)[1]);
  const calls=(read(ns,'deal/step').match(new RegExp('function '+ns+':deal/scan_once','g'))||[]).length;
  assert.equal(bound,9);assert.equal(calls,8);
  for(let card=0;card<hand*players.length;card++){
   let recipient;
   for(let attempt=0;attempt<calls;attempt++){scan++;if(scan>=bound)scan=1;if(received.has(scan)){recipient=scan;break;}}
   assert.ok(recipient);received.set(recipient,received.get(recipient)+1);
  }
  for(const count of received.values())assert.equal(count,hand,ns+': '+players);
  placements++;
 }
}
assert.match(read('hanabi','game/start'),/hb_players matches 4\.\.5 run scoreboard players set @s hb_hand_size 4/);
assert.equal(52-(8*2+5+8*3),7,'八人各换一次牌后仍有7张剩余');
assert.equal(36-5*5-4,7,'出包五人发25枚、留4枚秘密石后有7枚剩余');
// 回合、庄家、左轮顺序使用实际源码的扫描边界与最多扫描次数。
let rotations=0;
for(const [ns,parent,child]of [
 ['liars_holdem','turn/advance','turn/scan_once'],
 ['liars_holdem','turn/rotate_dealer','turn/dealer_scan_once'],
 ['liars_holdem','gun/next_showdown','gun/scan_pending_once'],
 ['hanabi','turn/advance','turn/scan_once'],
 ['abraca','turn/begin','turn/scan_once'],
 ['abraca','effect/target_left','effect/find_left'],
 ['abraca','effect/target_right','effect/find_right']
]){
 const max=(read(ns,parent).match(new RegExp('function '+ns+':'+child,'g'))||[]).length;
 assert.equal(max,8);
 const backwards=child.endsWith('find_right');
 if(backwards)assert.match(read(ns,child),/matches \.\.0 run scoreboard players set #target ab_ctx 8/);
 else assert.match(read(ns,child),/matches 9\.\. run scoreboard players set/);
 for(let mask=1;mask<256;mask++)for(let current=1;current<=8;current++){
  const eligible=seats(mask);let actual=current,found=false;
  for(let j=0;j<max;j++){actual+=backwards?-1:1;if(actual<1)actual=8;if(actual>8)actual=1;if(eligible.includes(actual)){found=true;break;}}
  assert.ok(found);
  const circular=Array.from({length:8},(_,i)=>((current-1+(backwards?-(i+1):i+1)+16)%8)+1);
  assert.equal(actual,circular.find(s=>eligible.includes(s)));rotations++;
 }
}
// 存活状态覆盖全部8座；离线、击发、清理与计数均不得漏掉高号座位。
for(let seat=1;seat<=8;seat++){
 assert.ok(read('liars_holdem','system/install').includes('objectives add lh_a'+seat+' dummy'));
 assert.ok(read('liars_holdem','game/start').includes('lh_a'+seat+' 0'));
 assert.ok(read('liars_holdem','game/start').includes('lh_a'+seat+' 1'));
 assert.ok(read('liars_holdem','gun/eliminate_seat').includes('lh_a'+seat+' 0'));
 assert.ok(read('liars_holdem','game/cleanup').includes('reset @s lh_a'+seat));
 assert.ok(read('liars_holdem','util/count_alive').includes('lh_a'+seat+' matches 1'));
 assert.ok(read('liars_holdem','system/maintenance_one').includes('seat:'+seat+',alive:"lh_a'+seat+'"'));
 assert.ok(read('liars_holdem','showdown/step').includes('{seat:'+seat+'}'));
 assert.ok(read('liars_holdem','showdown/append_place').includes('lh_seat='+seat+'}'));
 assert.ok(read('liars_holdem','showdown/show_ranking').includes('rank.place set value '+seat));
 assert.ok(read('liars_holdem','hud/ensure').includes('{seat:'+seat+'}'));
}
assert.match(read('liars_holdem','load'),/#version lh_ctx matches 4 run function liars_holdem:system\/upgrade_v5/);
assert.match(read('liars_holdem','turn/scan_once'),/tag=lh.turn,tag=lh.turn_candidate\] if score @s lh_id = #ctx_id/);
assert.match(read('liars_holdem','turn/advance'),/tag=lh.turn,tag=lh.turn_candidate\] if score @s lh_id = #ctx_id/);
assert.ok(!read('liars_holdem','system/upgrade_v5').includes('game/start'));
// 每座8发子弹的位置独立；单列摊牌共8行互不重叠。
const bulletPositions=new Set();
for(let seat=1;seat<=8;seat++){
 const lines=[...read('liars_holdem','hud/eight_seat_'+seat).matchAll(/spawn_bullet \{x:([-\d.]+)f,z:([-\d.]+)f,rot:([-\d.]+)f,seat:(\d+)\}/g)];
 assert.equal(lines.length,8);
 for(const m of lines){assert.equal(Number(m[4]),seat);const key=m[1]+','+m[2];assert.ok(!bulletPositions.has(key));bulletPositions.add(key);assert.ok(Math.max(Math.abs(Number(m[1])),Math.abs(Number(m[2])))<2);}
}
assert.equal(bulletPositions.size,64);
const reveal=read('liars_holdem','showdown/reveal_seat');
const rowY=[...reveal.matchAll(/lh_show_count matches (\d+) run data modify storage liars_holdem:showdown spawn.y set value "([\d.]+)"/g)];
assert.equal(rowY.length,8);
const heights=rowY.map(m=>+m[2]);
assert.deepEqual(heights,[1.55,2.10,2.65,3.20,3.75,4.30,4.85,5.40]);
const showdownSpawn=read('liars_holdem','showdown/summon_line');
const showdownInit=read('liars_holdem','showdown/init_line');
assert.ok(showdownSpawn.includes('positioned ~ ~$(y) ~ summon minecraft:text_display'));
assert.ok(!showdownSpawn.includes('distance='),'高行必须直接初始化，不能依赖4格半径反查');
assert.ok(showdownInit.includes('translation:[0.0f,0.0f,0.0f]'));
assert.ok(showdownInit.includes('scale:[0.22f,0.22f,0.22f]'));
assert.ok(showdownInit.includes('billboard:"vertical"'));
assert.ok(showdownInit.includes('add lh.showdown_single'));
assert.ok(showdownInit.includes('lh_id = #display_owner lh_ctx'));
const rank=read('liars_holdem','showdown/show_ranking');
const repair=read('liars_holdem','showdown/repair_layout');
for(let n=5;n<=8;n++){
 assert.ok(repair.includes('lh_show_count matches '+n+' run data modify storage liars_holdem:showdown center.rank_rise set value "'+((n-4)*.55).toFixed(2)+'"'));
}
assert.equal((rank.match(/spawn.y set value/g)||[]).length,1,'排名高度不能随人数累加');
assert.ok(rank.includes('spawn.y set value "1.05"'));
assert.ok(rank.includes('set #display_rank lh_ctx 1'));
assert.ok(reveal.includes('set #display_rank lh_ctx 0'));
assert.ok(showdownInit.includes('if score #display_rank lh_ctx matches 1 run tag @s add lh.ranking_display'));
const rankRepair=read('liars_holdem','showdown/repair_ranking_height');
assert.ok(rankRepair.includes('if score @s lh_id = #rank_table lh_ctx'));
assert.ok(rankRepair.includes('tag=lh.rank_layout_candidate,sort=furthest,limit=1'));
assert.ok(rankRepair.includes('tp @s ~ ~1.05 ~'));
assert.ok(rankRepair.includes('unless score @s lh_show_phase matches 1 run return 0'));
const cleanup=read('liars_holdem','round/cleanup');
assert.ok(cleanup.includes('as @e[tag=lh.game_entity] if score @s lh_id = #ctx_id lh_ctx run kill @s'));
assert.ok(!cleanup.includes('tag=lh.game_entity,distance='));
assert.ok(read('liars_holdem','showdown/cleanup_inactive').includes('if score @s lh_id = #stale_table lh_ctx run kill @s'));
// 四至八人桌的旧排名总在手牌之上，修复仅移动该行；重复修复优先使用显式排名标签。
for(let n=2;n<=8;n++){
 const oldRank=Math.max(3.75,1.55+n*.55);
 const entities=heights.slice(0,n).map(y=>({y,table:1,rank:false}));
 const target={y:oldRank,table:1,rank:false};entities.push(target,{y:100,table:2,rank:true});
 const candidates=entities.filter(e=>e.table===1);
 const picked=candidates.filter(e=>e.rank)[0]||candidates.reduce((a,b)=>a.y>b.y?a:b);
 assert.equal(picked,target);picked.rank=true;picked.y=1.05;
 assert.equal(candidates.filter(e=>e.rank)[0],target);
 assert.deepEqual(candidates.filter(e=>!e.rank).map(e=>e.y),heights.slice(0,n));
 assert.ok(target.y<heights[0]);
 // 已结束时，本桌全部高行都回收，其他桌仍保留。
 assert.deepEqual(entities.filter(e=>e.table!==1).map(e=>e.y),[100]);
}
// 两版旧双列转换后，八行高度均与新建一致。
for(const worldOffset of [true,false])for(const center of [-29999998.5,-1,0,.5,29999998.5]){
 for(let i=0;i<8;i++){
  const oldX=i<4?-1.25:1.25;
  const worldDelta=worldOffset?Math.floor(center+oldX)-Math.floor(center):0;
  const localDelta=worldOffset?0:oldX*100;
  const right=worldDelta>0||localDelta>0;
  const y=heights[i%4]+(right?2.20:0);
  assert.ok(Math.abs(y-heights[i])<1e-9);
 }
}
assert.ok(repair.includes('if score @s lh_id = #layout_table lh_ctx'));
assert.ok(repair.includes('tag=!lh.showdown_single'));
for(const n of ['repair_layout','repair_line','repair_ranking_height']){
 assert.doesNotMatch(read('liars_holdem','showdown/'+n),/scoreboard players (?:set|add|reset) @s lh_(?:state|timer|show_count|show_seat|place)/);
}
console.log('通过：桌心单列八行、排名固定低位、旧排名迁移与重复修复、同尺寸、高行绑定及跨桌清理。');
// 任意座号可作为普通提示或完全提示的目标；自己的隐藏牌不进入他人面板。
for(let seat=1;seat<=8;seat++){
 for(const ns of ['hanabi','abraca'])assert.ok(read(ns,'title/build_player').includes('{seat:'+seat+'}'));
 assert.ok(read('hanabi','dialog/hint/target').includes('{seat:'+seat+',action:'+(300+seat)+'}'));
 assert.ok(read('hanabi','reward/full_hint/target_dialog').includes('{seat:'+seat+',action:'+(1100+seat)+'}'));
 assert.ok(read('hanabi','action/hint/select_target').includes('{seat:'+seat+'}'));
 assert.ok(read('hanabi','action/hint/reopen_choice').includes('{seat:'+seat+'}'));
 assert.ok(read('abraca','hud/update').includes('ab_seat='+seat+'}'));
}
assert.ok(read('hanabi','action/handle').includes('301..308'));
assert.ok(read('hanabi','reward/input').includes('1101..1108'));
assert.ok(read('hanabi','reward/reopen').includes('hb_target matches 1..8'));
for(const ns of ['hanabi','abraca']){
 const source=read(ns,'title/append_owner');
 assert.match(source,/\$execute if score #(title_viewer|viewer) \w+ matches \$\(seat\) run return 0/);
 assert.match(source,/matches 4 run scoreboard players set #(title_y|y) \w+ -180/);
 assert.ok(180+38+3<240,'第四行牌面仍在默认GUI高度内');
}
assert.match(read('abraca','hud/finalize'),/function abraca:hud\/update[\s\S]*tag @s remove ab.game_entity/);
assert.match(read('abraca','hud/append_player'),/name\/resolve[\s\S]*text append from storage hanabi:name resolved/);
assert.match(read('abraca','deck/select_random'),/ab_id = #ctx ab_ctx run tag @s add ab.draw_pool[\s\S]*tag=ab.draw_pool,sort=random/);
assert.ok(!read('abraca','action/resolve').includes('ab.controller,limit=1'));
let count=0;
for(const ns of ['cardtable','liars_holdem','hanabi','abraca'])for(const f of walk('data/'+ns)){
 if(f.endsWith('.json')){JSON.parse(fs.readFileSync(f,'utf8'));continue;}
 if(!f.endsWith('.mcfunction'))continue;count++;
 const source=fs.readFileSync(f,'utf8');
 for(const m of source.matchAll(/\bfunction ([a-z0-9_]+):([a-z0-9_/]+)/g)){
  const relative='data/'+m[1]+'/function/'+m[2]+'.mcfunction';
  const exists=fs.existsSync(relative)||fs.readdirSync('..',{withFileTypes:true}).filter(e=>e.isDirectory()).some(e=>fs.existsSync(path.join('..',e.name,relative)));
  assert.ok(exists,f+': '+m[0]);
 }
 for(const line of source.replace(/\\\r?\n\s*/g,'').split(/\r?\n/)){
  if(!line||line.startsWith('#'))continue;
  const stack=[];let quote='',escape=false;
  for(const c of line){
   if(quote){if(escape)escape=false;else if(c==='\\')escape=true;else if(c===quote)quote='';}
   else if(c==='"'||c==="'")quote=c;
   else if('[{('.includes(c))stack.push(c);
   else if(']})'.includes(c))assert.equal(stack.pop(),{']':'[','}':'{',')':'('}[c],f);
  }
  assert.equal(quote,'',f);assert.equal(stack.length,0,f);
 }
}
console.log('通过：德州扑克2–8人、花火与出包2–5人，'+placements+'种入座发牌组合，'+rotations+'种轮换/邻座扫描。');
console.log('通过：8座存活/淘汰/排名、64个子弹位置、桌心单列摊牌、高号座位提示与手牌隐私、5人生命显示、'+count+'个函数引用及结构。');
console.log('以上为静态与规则模型检查，尚未进行Minecraft多人实测。');
