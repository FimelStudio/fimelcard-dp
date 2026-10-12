import fs from 'node:fs';
import assert from 'node:assert/strict';
const read=id=>fs.readFileSync('data/'+id.replace(':','/function/')+'.mcfunction','utf8');
const cache=new Map();
const source=id=>{if(!cache.has(id))cache.set(id,read(id).split(/\r?\n/).map(x=>x.trim()).filter(x=>x&&!x.startsWith('#')));return cache.get(id);};
const inRange=(n,r)=>{if(n===undefined)return false;if(!r.includes('..'))return n===+r;const [a,b]=r.split('..');return (a===''||n>=+a)&&(b===''||n<=+b);};
// 解释实际mcfunction的记分/选择器子集，不复制角色计算公式；遇到未覆盖语句立即失败。
class VM {
 constructor(players,controller){this.players=players;this.controller=controller;this.fake={};}
 bag(who,self){return who==='@s'?self.s:(this.fake[who]??={});}
 get(who,obj,self){return this.bag(who,self)[obj];}
 select(selector,self){
  if(!selector.startsWith('@'))throw Error(selector);
  const candidates=selector.startsWith('@s')?[self]:selector.startsWith('@a')?this.players:[this.controller];
  const tags=[...selector.matchAll(/tag=([^,\]]+)/g)].map(x=>x[1]);
  const scores=selector.match(/scores=\{([^}]+)\}/)?.[1].split(',').map(x=>x.split('='))??[];
  return candidates.filter(p=>tags.every(t=>t.startsWith('!')?!p.tags.has(t.slice(1)):p.tags.has(t))&&scores.every(([k,r])=>inRange(p.s[k],r)));
 }
 run(id,self=this.controller){for(const line of source(id)){if(this.line(line,self)==='return')break;}}
 line(line,self){
  if(line.startsWith('execute ')){
   const split=line.indexOf(' run ');assert.ok(split>0,line);
   let prefix=line.slice(8,split),contexts=[self];
   while(prefix){
    let m;
    if((m=prefix.match(/^as (\S+)(?: |$)/))){contexts=contexts.flatMap(c=>this.select(m[1],c));}
    else if((m=prefix.match(/^(if|unless) score (\S+) (\S+) matches (\S+)(?: |$)/))){contexts=contexts.filter(c=>inRange(this.get(m[2],m[3],c),m[4])===(m[1]==='if'));}
    else if((m=prefix.match(/^(if|unless) score (\S+) (\S+) (=|<=|>=|<|>) (\S+) (\S+)(?: |$)/))){
     contexts=contexts.filter(c=>{const a=this.get(m[2],m[3],c),b=this.get(m[5],m[6],c);const ok=a!==undefined&&b!==undefined&&({'=':a===b,'<=':a<=b,'>=':a>=b,'<':a<b,'>':a>b}[m[4]]);return ok===(m[1]==='if');});
    }else if((m=prefix.match(/^(if|unless) entity (\S+)(?: |$)/))){contexts=contexts.filter(c=>(this.select(m[2],c).length>0)===(m[1]==='if'));}
    else throw Error('未解释条件 '+prefix);
    prefix=prefix.slice(m[0].length);
   }
   for(const c of contexts)if(this.line(line.slice(split+5),c)==='return')return 'return';
   return;
  }
  let m;
  if((m=line.match(/^scoreboard players (set|add|remove) (\S+) (\S+) (-?\d+)$/))){const b=this.bag(m[2],self);b[m[3]]=m[1]==='set'?+m[4]:(b[m[3]]??0)+(m[1]==='add'?+m[4]:-m[4]);return;}
  if((m=line.match(/^scoreboard players operation (\S+) (\S+) (=|\+=|-=|%=|\/=) (\S+) (\S+)$/))){
   const b=this.bag(m[1],self),v=this.get(m[4],m[5],self),old=b[m[2]]??0;assert.notEqual(v,undefined,line);
   b[m[2]]=m[3]==='='?v:m[3]==='+='?old+v:m[3]==='-='?old-v:m[3]==='%='?old%v:Math.floor(old/v);return;
  }
  if((m=line.match(/^function (\S+)$/))){this.run(m[1],self);return;}
  if(line==='return 0')return 'return';
  throw Error('未解释命令 '+line);
 }
}
const player=(seat,id=1)=>({tags:new Set(['dc.player','fc.player']),s:{ct_seat:seat,ct_id:id,dc_id:id,fc_id:id,dc_seat:seat}});
const ctrl=(size,id=1)=>({tags:new Set(),s:{ct_id:id,ct_joined:size,dc_id:id,dc_mode:4,dc_round:1,fc_id:id}});
let layouts=0,permissions=0,fast=0;
for(let mask=1;mask<256;mask++){
 const seats=Array.from({length:8},(_,i)=>i+1).filter(n=>mask&(1<<(n-1)));
 if(seats.length===4){
  const players=seats.map(n=>player(n)),foreign=player(2,2),vm=new VM([...players,foreign],ctrl(4));
  vm.fake['#ctx_id']={fc_ctx:1};vm.run('fast_card:player/map_seats');assert.deepEqual(players.map(p=>p.s.fc_seat),[1,2,3,4]);assert.equal(foreign.s.fc_seat,undefined);
  for(let first=1;first<=4;first++){
   const counts=players.map(()=>0);
   for(let i=0;i<17;i++){const target=i===16?first:i%4+1;counts[players.findIndex(p=>p.s.fc_seat===target)]++;}
   assert.equal(counts.filter(n=>n===5).length,1);assert.equal(counts.reduce((a,b)=>a+b),17);
   let turn=first;const seen=[];for(let i=0;i<4;i++){seen.push(players.find(p=>p.s.fc_seat===turn).s.ct_seat);turn=turn%4+1;}
   assert.deepEqual([...seen].sort((a,b)=>a-b),seats);
  }fast++;
 }
 if(seats.length<4)continue;
 const players=seats.map(n=>player(n)),foreign=player(1,2),vm=new VM([...players,foreign],ctrl(seats.length));
 vm.fake['#ctx']={dc_ctx:1};vm.run('decrypto:team/assign');vm.run('decrypto:team/index');
 assert.deepEqual([1,2].map(t=>players.filter(p=>p.s.dc_team===t).length),[Math.ceil(seats.length/2),Math.floor(seats.length/2)]);
 const histories=new Map(players.map(p=>[p,[]]));
 for(let round=1;round<=12;round++){
  vm.controller.s.dc_round=round;vm.run('decrypto:roles/update');
  for(const t of [1,2]){
   const team=players.filter(p=>p.s.dc_team===t),roles=team.map(p=>p.s.dc_role);
   assert.deepEqual([...roles].sort(),team.length===2?[1,4]:team.length===3?[1,2,3]:[0,1,2,3]);
   assert.equal(team.filter(p=>p.s.dc_encoder===1).length,1);
  }
  for(const p of players)histories.get(p).push(p.s.dc_role);
  for(const phase of [1,2,3,4,5,6,7,8]){
   const allowed=[];vm.fake['#phase']={dc_ctx:phase};
   for(const p of players){vm.run('decrypto:player/can_input',p);if(vm.fake['#authorized'].dc_ctx)allowed.push(p);permissions++;}
   assert.equal(allowed.length,[2,4].includes(phase)?0:1);
   for(const p of allowed){
    const expectedTeam=[1,6,7].includes(phase)?1:2;assert.equal(p.s.dc_team,expectedTeam);
    assert.ok(([1,3].includes(phase)?[1]:[5,7].includes(phase)?[3,4]:[2,4]).includes(p.s.dc_role));
   }
  }
  // 已有角色在重载修复函数中不得被重新轮换。
  const before=JSON.stringify(players.map(p=>p.s));vm.run('decrypto:roles/ensure');assert.equal(JSON.stringify(players.map(p=>p.s)),before);
 }
 for(const p of players)assert.equal(new Set(histories.get(p).slice(0,p.s.dc_size)).size,p.s.dc_size);
 assert.deepEqual(foreign.s,player(1,2).s,'不得改动另一桌');layouts++;
}
// 三人局及旧四人局重载：保留随机截密者和本轮加密者，补角色后可继续下一轮。
for(const mode of [3,4]){
 const players=Array.from({length:mode},(_,i)=>player(i+1)),c=ctrl(mode);c.s.dc_mode=mode;
 players.forEach((p,i)=>{p.s.dc_team=i<2?1:2;p.s.dc_encoder=i===1||(mode===4&&i===3)?1:0;});
 const vm=new VM(players,c);vm.run('decrypto:roles/ensure');assert.deepEqual(players.map(p=>p.s.dc_role),mode===3?[2,1,3]:[4,1,4,1]);
 if(mode===3){vm.fake['#ctx']={dc_ctx:1};for(const p of players.filter(p=>p.s.dc_team===1))vm.run('decrypto:player/toggle_encoder',p);vm.run('decrypto:roles/update');assert.deepEqual(players.map(p=>p.s.dc_role),[1,2,3]);}
}
assert.match(read('fast_card:deal/give_card'),/cardtable:deal seat set from storage fast_card:deal seat/);
assert.match(read('fast_card:deal/step'),/fc_seat = #deal_seat fc_ctx store result storage fast_card:deal seat.*get @s ct_seat/);
assert.match(read('fast_card:game/start'),/ct_joined matches 4 run return fail/);
assert.match(read('skull:game/start'),/ct_joined matches 2\.\.6 run return fail/);
assert.match(read('decrypto:game/start'),/ct_joined matches 3\.\.8 run return fail/);
// 根据实际叫号按钮编码确认24种数字和放弃/翻牌/弃牌不冲突。
const bids=[...read('skull:ui/bids').matchAll(/number:(\d+),choice:(\d+)/g)].map(m=>m.slice(1).map(Number));
assert.deepEqual(bids.map(b=>b[0]),Array.from({length:24},(_,i)=>i+1));
const choices=bids.map(b=>b[1]);assert.equal(new Set(choices).size,24);
for(const [n,ch]of bids){assert.equal(ch<70?ch-10:ch-50,n);assert.ok(ch!==30&&!(ch>=41&&ch<=54));}
for(const [file,key]of [['round/seek_next','sk_turn'],['round/seek_first','sk_first']]){
 const src=read('skull:'+file);assert.match(src,/#hops sk_ctx matches 9/);assert.ok(src.includes(key+' matches 9..'));
}
for(let seat=1;seat<=8;seat++){
 assert.ok(read('skull:round/begin').includes('reset_seat {seat:'+seat+'}'));
 assert.ok(read('skull:ui/targets').includes('target_button {seat:'+seat+',choice:'+(40+seat)+'}'));
}
const ticks=[...read('skull:deal/tick').matchAll(/(?:unless|if) score @s ct_capacity matches 8 if score @s sk_deal_time matches (\d+)\.\.(\d+) run function skull:deal\/check/g)];
assert.equal(ticks.length,2);
for(const [i,m]of ticks.entries()){const events=Array.from({length:+m[2]-+m[1]+1},(_,k)=>k+(+m[1])).filter(t=>t%4===0);assert.equal(events.length,i===0?16:32);}
for(const file of ['action/handle','input/use_guess','game/resume_player'])assert.ok(read('decrypto:'+file).includes('function decrypto:player/can_input'));
assert.ok(read('decrypto:round/open_guess').includes('execute as @a[tag=dc.audience] run function decrypto:player/select_guesser'));
assert.ok(!read('decrypto:game/resume').includes('roles/update'));
assert.ok(!read('decrypto:round/start_black').includes('roles/update'));
assert.ok(!read('decrypto:round/next').includes('words/draw'));
assert.match(read('decrypto:system/maintenance'),/unless score #online dc_ctx = #expected dc_ctx run function decrypto:game\/abort/);
console.log('通过：Fast Card '+fast+'种四人座位映射；谍报风云 '+layouts+'种分队布局、12轮职责循环、'+permissions+'次阶段权限检查、双桌隔离及旧局角色恢复。');
console.log('通过：骷髅牌24个叫号编码、8座发牌扫描、翻牌选人及回合回收。静态及指令模型检查，仍需Minecraft内联机测试。');
