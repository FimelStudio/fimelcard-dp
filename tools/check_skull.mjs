import fs from 'node:fs';
import path from 'node:path';
import assert from 'node:assert/strict';
const root=process.cwd(),base=path.join(root,'data/skull/function');
const read=n=>fs.readFileSync(path.join(base,n+'.mcfunction'),'utf8');
const walk=d=>fs.readdirSync(d,{withFileTypes:true}).flatMap(e=>e.isDirectory()?walk(path.join(d,e.name)):[path.join(d,e.name)]);
const files=walk(base).filter(f=>f.endsWith('.mcfunction'));
for(const file of files){
 const source=fs.readFileSync(file,'utf8');
 for(const m of source.matchAll(/\bfunction ([a-z0-9_]+):([a-z0-9_/]+)/g))
  assert.ok(fs.existsSync(path.join(root,'data',m[1],'function',m[2]+'.mcfunction')),file+': '+m[0]);
 for(const line of source.split(/\r?\n/)){
  if(line.startsWith('#'))continue;
  const stack=[];let quote='',escape=false;
  for(const c of line){
   if(quote){if(escape)escape=false;else if(c==='\\')escape=true;else if(c===quote)quote='';}
   else if(c==='"'||c==="'")quote=c;
   else if('[{('.includes(c))stack.push(c);
   else if(']})'.includes(c))assert.equal(stack.pop(),{']':'[','}':'{',')':'('}[c],file);
  }
  assert.equal(stack.length,0,file);assert.equal(quote,'',file);
 }
 // 本模块仅生成中心文字；卡牌模型只通过公共发牌动画短暂出现。
 assert.ok(!/summon minecraft:(?:item_display|item)\b/.test(source),file);
}
const objs=[...read('system/install').matchAll(/objectives add (\w+)/g)].map(m=>m[1]).concat('sk_ctx');
assert.equal(new Set(objs).size,objs.length);assert.ok(objs.every(n=>n.length<=16));
const routes={'game/init_selected':'game/init_table','game/start':'game/start','game/open_settings':'settings/open','game/open_rules':'rules/show','vote/accept':'game/end_vote','table/remove':'game/abort'};
for(const [file,ref]of Object.entries(routes)){
 const source=fs.readFileSync(path.join(root,'data/cardtable/function',file+'.mcfunction'),'utf8');
 assert.ok(source.split(/\r?\n/).some(l=>l.includes('ct_game matches 9')&&l.includes('skull:'+ref)),file);
}
assert.ok(fs.readFileSync(path.join(root,'data/cardtable/function/menu/render.mcfunction'),'utf8').includes('game_name_skull'));
assert.ok(fs.readFileSync(path.join(root,'data/cardtable/function/load.mcfunction'),'utf8').includes('#game_count ct_ctx 10'));
assert.ok(fs.readFileSync(path.join(root,'data/cardtable/function/game/remove_offline_player.mcfunction'),'utf8').includes('skull:player/clear_state'));
for(const kind of ['load','tick'])assert.equal(JSON.parse(fs.readFileSync(path.join(root,'data/minecraft/tags/function',kind+'.json'))).values.filter(x=>x==='skull:'+kind).length,1);
assert.ok(read('hand/give').includes('id:$(seat)$(slot)'));
assert.ok(read('deck/init_seat').includes('card:poker/c_a'));assert.ok(read('deck/init_seat').includes('card:poker/joker'));
assert.ok(read('deal/card').includes('ct.visual_only'));assert.ok(read('deal/card').includes('cardtable:animation/deal/launch'));
assert.ok(!read('hud/update').includes('owned'));assert.ok(!read('hud/update').includes('stack'));
assert.ok(!read('hud/line').includes('type'));assert.ok(read('hud/line').includes('$(count) 张'));
assert.ok(read('hud/update').includes('sk_id = #ctx'));
assert.ok(read('action/handle').includes('ct_id = @s sk_id'));assert.ok(read('action/handle').includes('sk_ui_table = @s sk_id'));
assert.ok(read('action/handle').includes('sk_epoch = #epoch'));
for(const state of [2,3,4,5])assert.ok(read('action/dispatch').includes(state===3?'2..3':'matches '+state));
assert.match(read('input/play'),/sk_state matches 1.*sk_done=0.*round\/play_card/);
assert.match(read('input/play'),/sk_state matches 2.*sk_turn = #actor_seat.*round\/play_card/);
assert.ok(!read('action/dispatch').split(/\r?\n/).some(l=>l.includes('matches 3')&&l.includes('round/play')));
for(const guard of ['#bid sk_ctx > @s sk_bid','#bid sk_ctx > @s sk_total','#bid sk_ctx < @a[tag=sk.actor,limit=1] sk_count'])assert.ok(read('auction/bid').includes(guard));
assert.ok(read('auction/pass').includes('sk_pass 1'));assert.ok(read('auction/pass').includes('#bidders sk_ctx matches 1'));
assert.ok(read('challenge/choose').includes('#own sk_ctx matches 1 run return 0'));
assert.match(read('challenge/flip'),/stack\[-1\][\s\S]*data remove entity @s data.skull.seats.s\$\(seat\).stack\[-1\]/);
assert.ok(read('challenge/fail').includes('sk_source = @s sk_lead'));
assert.ok(read('discard/random').includes('.owned'));assert.ok(read('discard/draw').includes('random value 0..$(max)'));
assert.ok(read('discard/remove').includes('owned[{slot:$(slot)}]'));
assert.ok(read('discard/remove').includes('run tellraw @s'));assert.ok(!read('discard/remove').includes('tellraw @a'));
assert.ok(!read('load').includes('game/abort'));assert.ok(read('load').includes('game/resume'));
assert.ok(read('game/abort').includes('sk_id = #ctx'));assert.ok(read('input/cleanup').includes('table:$(table)'));
assert.ok(read('system/maintenance').includes('unless score #online sk_ctx = @s sk_players'));
assert.ok(read('player/eliminate').includes('cardtable:seat/remove_player'));
assert.ok(read('discard/remove').includes('cardtable:table/recount_players'));
// 验证所有合法叫号范围，最大桌面24张；最高价必须严格上升。
let bidCases=0;
for(let total=2;total<=24;total++)for(let own=1;own<=Math.min(4,total);own++)for(let current=0;current<=total;current++){
 const legal=Array.from({length:24},(_,i)=>i+1).filter(n=>n>current&&n>=own&&n<=total);
 assert.ok(legal.every(n=>n>current&&n>=own&&n<=total));
 if(current===total)assert.equal(legal.length,0);
 bidCases++;
}
// 根据控制器的座位顺序跳过空位、已淘汰和已放弃者。
const next=(seat,allowed)=>{for(let i=0;i<8;i++){seat=seat%8+1;if(allowed.includes(seat))return seat;}throw Error('没有可行动座位');};
let seatCases=0;
for(let mask=1;mask<256;mask++){
 const seats=[1,2,3,4,5,6,7,8].filter(s=>mask&(1<<(s-1)));
 for(const start of [1,2,3,4,5,6,7,8]){assert.ok(seats.includes(next(start,seats)));seatCases++;}
}
// 固定种子整局模拟：真实堆顶顺序、先翻己方、两种弃牌路径、回合归还、淘汰和胜利。
let seed=0x127af6d;const rnd=n=>{seed=(Math.imul(seed,1664525)+1013904223)>>>0;return seed%n;};
let games=0,rounds=0,selfSkulls=0,otherSkulls=0,successes=0,eliminations=0;
for(let size=2;size<=6;size++)for(let sample=0;sample<400;sample++){
 const seats=Array.from({length:size},(_,i)=>((sample+i)%8)+1).sort((a,b)=>a-b);
 const owned=new Map(seats.map(s=>[s,[1,2,3,4]])),wins=new Map(seats.map(s=>[s,0]));
 let live=[...seats],first=live[rnd(live.length)],finished=false;
 for(let round=0;round<32&&!finished;round++){
  rounds++;
  const stacks=new Map(),hands=new Map();
  for(const s of live){const hand=[...owned.get(s)],i=rnd(hand.length);stacks.set(s,[hand.splice(i,1)[0]]);hands.set(s,hand);}
  let turn=first;
  // 有限加牌，剩余牌仅能加到自己堆顶；随后开始叫号。
  for(let added=0;added<18&&rnd(3)!==0;added++){
   const hand=hands.get(turn);if(!hand.length)break;
   stacks.get(turn).push(hand.splice(rnd(hand.length),1)[0]);turn=next(turn,live);
  }
  const total=[...stacks.values()].reduce((a,x)=>a+x.length,0);
  let bid=stacks.get(turn).length+rnd(total-stacks.get(turn).length+1),lead=turn,bidders=[...live];
  turn=next(turn,bidders);
  for(let auction=0;bid<total&&bidders.length>1;auction++){
   assert.ok(auction<80);
   const min=Math.max(bid+1,stacks.get(turn).length);
   if(min>total||rnd(3)===0)bidders=bidders.filter(s=>s!==turn);
   else{bid=min+rnd(total-min+1);lead=turn;}
   if(bidders.length>1)turn=next(turn,bidders);
  }
  assert.ok(bid>=stacks.get(lead).length);
  let flowers=0,source=null;
  while(flowers<bid){
   const options=live.filter(s=>stacks.get(s).length);
   const target=stacks.get(lead).length?lead:options[rnd(options.length)];
   assert.ok(target!==undefined);
   const slot=stacks.get(target).pop();
   if(slot===4){source=target;break;}flowers++;
  }
  if(source===null){wins.set(lead,wins.get(lead)+1);successes++;}
  else{
   if(source===lead)selfSkulls++;else otherSkulls++;
   const cards=owned.get(lead),before=cards.length;
   // 本人自选与随机弃牌的最终候选集合均为全部剩余owned。
   const slot=cards[rnd(cards.length)];cards.splice(cards.indexOf(slot),1);
   assert.equal(cards.length,before-1);
   if(cards.length===0){live=live.filter(s=>s!==lead);eliminations++;}
  }
  finished=live.length===1||[...wins.values()].some(n=>n>=2);
  if(!finished)first=live.includes(lead)?lead:next(lead,live);
  for(const s of live){assert.ok(owned.get(s).length>0);assert.equal(new Set(owned.get(s)).size,owned.get(s).length);}
 }
 assert.ok(finished,'整局未能在有界回合内结束');games++;
}
assert.ok(selfSkulls>0&&otherSkulls>0&&successes>0&&eliminations>0);
console.log('通过：'+files.length+'个函数的引用、结构、注册、模型与中央文字显示约束。');
console.log('通过：'+bidCases+'组叫号范围、'+seatCases+'组座位轮换、'+games+'局完整规则模拟（'+rounds+'轮）。');
console.log('覆盖：己方骷髅自选弃牌、他人骷髅随机弃牌、成功累计、淘汰、重复操作防护、桌号隔离和重载入口。');
console.log('这是静态检查与规则模型验证，不替代Minecraft联机实测。');

assert.ok(read('input/from_player').includes('skull:{card:1b}'));
assert.ok(read('input/from_player').includes('skull:input/card'));
assert.ok(read('input/from_player').includes('sk_seat = #drop_owner'));
assert.ok(read('input/card').includes('sk_id = #ctx'));
assert.ok(read('input/card').includes('sk_epoch = #card_epoch'));
assert.ok(read('input/card').includes('#played sk_ctx matches 0 run function skull:hand/sync'));
assert.ok(read('hand/give').includes('epoch:$(epoch)'));
assert.ok(read('round/play_card').indexOf('run return 0')<read('round/play_card').indexOf('#played sk_ctx 1'));
assert.ok(!read('action/dispatch').includes('round/play'));
assert.ok(!read('ui/build').includes('skull:ui/play'));
assert.ok(read('ui/refresh').includes('sk_state matches 2 as @a[tag=sk.audience] if score @s sk_seat = #turn sk_ctx run function skull:hand/sync'));
console.log('通过：Q键扣牌入口、所有者及交互序号校验、无效出牌返还、旧对话框扣牌移除。');
