import fs from 'node:fs';
import assert from 'node:assert/strict';
const read=n=>fs.readFileSync('data/doudizhu/function/'+n+'.mcfunction','utf8');
const range=(v,r)=>v!==undefined&&(r.includes('..')?v>=Number(r.split('..')[0]||-Infinity)&&v<=Number(r.split('..')[1]||Infinity):v===Number(r));
// 运行实际记分与流程指令；渲染、物品、发牌和最终销毁以观测点替代。
function world(){
 const make=(tags,scores,player=false)=>({tags:new Set(tags),s:{...scores},player});
 const table=make(['ct.controller','dd.controller'],{ct_id:12,dd_id:12,ct_game:10,ct_state:1,dd_state:3,dd_round:1,dd_limit:3,dd_lord:2,dd_bid:1,dd_mult:1});
 const actors=[2,5,8].map((seat,i)=>make(['dd.actor','dd.actors','dd.audience','ct.player'],{dd_id:12,ct_id:12,dd_seat:seat,dd_plays:2,dd_total:0},i<2));
 const other=make(['ct.controller'],{ct_id:13,ct_game:10,ct_state:0,dd_max:7});
 const all=[table,...actors,other],fake={},out={deals:0,ends:0};
 function select(q,self){
  if(q==='@s')return [self];
  let a=all.filter(e=>!q.startsWith('@a')||e.player);
  for(const m of q.matchAll(/tag=([^,\]]+)/g))a=a.filter(e=>e.tags.has(m[1]));
  const scores=q.match(/scores=\{([^}]+)\}/)?.[1];
  if(scores)for(const clause of scores.split(',')){const [key,r]=clause.split('=');a=a.filter(e=>range(e.s[key],r));}
  return q.includes('limit=1')?a.slice(0,1):a;
 }
 const get=(who,obj,self)=>who.startsWith('@')?select(who,self)[0]?.s[obj]:fake[who+':'+obj];
 const put=(who,obj,val,self)=>{if(who.startsWith('@'))for(const e of select(who,self)){if(val===undefined)delete e.s[obj];else e.s[obj]=val;}else fake[who+':'+obj]=val;};
 function call(n,self){
  if(n==='log'||n==='input/sync'||n==='settings/invalid'||n==='round/announce')return;
  if(n==='player/audience'){for(const e of all){e.tags.delete('dd.actors');e.tags.delete('dd.audience');if(e.s.dd_id===self.s.dd_id&&e.tags.has('dd.actor')){e.tags.add('dd.actors');if(e.player)e.tags.add('dd.audience');}}return;}
  if(n==='bid/finish'){if(self.s.dd_bid===0){out.deals++;self.s.dd_state=1;}else{self.s.dd_state=3;out.lord=self.s.dd_lord;}return;}
  if(n==='deal/start'){out.deals++;self.s.dd_state=1;return;}
  if(n==='game/abort'){out.ends++;out.totals=actors.map(e=>e.s.dd_total);self.s.ct_state=0;return;}
  for(const line of read(n).split(/\r?\n/))if(command(line,self))break;
 }
 function command(line,self){
  if(!line||line.startsWith('#')||/^(tellraw|dialog|clear|data|stopsound|playsound) /.test(line))return;
  if(line==='return 0')return true;
  if(line.startsWith('return run ')){command(line.slice(11),self);return true;}
  if(line.startsWith('execute ')){
   const split=line.indexOf(' run '),body=line.slice(split+5);let prefix=line.slice(8,split),contexts=[self];
   while(prefix){let m;
    if((m=prefix.match(/^as (\S+)(?: |$)/)))contexts=contexts.flatMap(c=>select(m[1],c));
    else if((m=prefix.match(/^at @s(?: |$)/))){}
    else if((m=prefix.match(/^(if|unless) entity (\S+)(?: |$)/)))contexts=contexts.filter(c=>(select(m[2],c).length>0)===(m[1]==='if'));
    else if((m=prefix.match(/^(if|unless) score (\S+) (\S+) matches (\S+)(?: |$)/)))contexts=contexts.filter(c=>range(get(m[2],m[3],c),m[4])===(m[1]==='if'));
    else if((m=prefix.match(/^(if|unless) score (\S+) (\S+) (=|<=|<|>) (\S+) (\S+)(?: |$)/)))contexts=contexts.filter(c=>{const a=get(m[2],m[3],c),b=get(m[5],m[6],c);return (a!==undefined&&b!==undefined&&(m[4]==='='?a===b:m[4]==='<'?a<b:m[4]==='<='?a<=b:a>b))===(m[1]==='if');});
    else throw Error(prefix);
    prefix=prefix.slice(m[0].length);
   }
   for(const c of contexts)if(command(body,c))return true;
   return;
  }
  let m;
  if((m=line.match(/^function doudizhu:(\S+)/))){call(m[1],self);return;}
  if((m=line.match(/^tag (\S+) (add|remove) (\S+)$/))){for(const e of select(m[1],self))e.tags[m[2]==='add'?'add':'delete'](m[3]);return;}
  if((m=line.match(/^scoreboard players (set|add|remove|reset) (\S+) (\S+)(?: (-?\d+))?$/))){const [,op,key,obj,n]=m;put(key,obj,op==='reset'?undefined:op==='set'?Number(n):(get(key,obj,self)||0)+(op==='remove'?-1:1)*Number(n),self);return;}
  if((m=line.match(/^scoreboard players operation (\S+) (\S+) (=|\+=|-=|\*=|\/=|%=|>|<) (\S+) (\S+)$/))){const [,a,ao,op,b,bo]=m,x=get(a,ao,self)||0,y=get(b,bo,self);put(a,ao,op==='='?y:op==='+='?x+y:op==='-='?x-y:op==='*='?x*y:op==='/='?Math.floor(x/y):op==='%='?((x%y)+y)%y:op==='<'?Math.min(x,y):Math.max(x,y),self);return;}
  throw Error(line);
 }
 return {table,actors,other,fake,out,call};
}

function setup(mode,start=2){const w=world();w.table.tags.add('dd.current');Object.assign(w.table.s,{dd_state:2,dd_speed_time:0,dd_bidmode:mode,dd_bid:0,dd_bidcount:0,dd_bidphase:0,dd_firstcall:0,dd_bidleft:0,dd_mult:1,dd_lord:0,dd_turn:start});for(const a of w.actors)a.s.dd_eligible=0;return w;}
function submit(w,seat,action,fn='bid/rob_submit'){w.fake['#action:dd_ctx']=action;w.call(fn,w.actors.find(a=>a.s.dd_seat===seat));}
let paths=0;
for(const firstSeat of [2,5,8])for(let mask=0;mask<8;mask++){
 const seats=[2,5,8],idx=seats.indexOf(firstSeat),order=[...seats.slice(idx),...seats.slice(0,idx)];
 const eligible=order.filter((_,i)=>mask&(1<<i));
 for(let lastMask=0;lastMask<2**Math.max(0,eligible.length-1);lastMask++){
  const w=setup(1,firstSeat);let last=0,rob=0;
  for(let i=0;i<3;i++){
   assert.equal(w.table.s.dd_turn,order[i]);const yes=!!(mask&(1<<i));const action=yes?(last?205:204):206;
   if(yes){if(last)rob++;last=order[i];}
   submit(w,order[i],action);
  }
  if(!eligible.length){assert.equal(w.out.deals,1);paths++;continue;}
  const sorted=[...eligible].sort((a,b)=>a-b),start=sorted.indexOf(eligible[0]),second=[...sorted.slice(start),...sorted.slice(0,start)];
  last=second.at(-1); // 无人再抢时最后一名自动获选，不增加倍数。
  for(let i=0;i<second.length-1;i++){
   assert.equal(w.table.s.dd_state,2);
   assert.equal(w.table.s.dd_turn,second[i],'第二轮必须跳过第一轮不要的人');
   const yes=!!(lastMask&(1<<i));
   submit(w,second[i],yes?205:206);
   if(yes){last=second[i];rob++;assert.equal(w.table.s.dd_state,3,'抢地主后必须立即结束叫抢');break;}
  }
  assert.equal(w.out.lord,last);assert.equal(w.table.s.dd_mult,2**rob);assert.equal(w.table.s.dd_bid,1);assert.equal(w.table.s.dd_state,3);paths++;
 }
}
for(const seat of [2,5,8]){
 const w=setup(2);submit(w,seat,207,'bid/speed_submit');assert.equal(w.out.lord,seat);
 for(const a of w.actors)submit(w,a.s.dd_seat,207,'bid/speed_submit');assert.equal(w.out.lord,seat,'手速制仅首个提交生效');assert.equal(w.table.s.dd_mult,4);
}
const wrong=setup(1);submit(wrong,5,204);assert.equal(wrong.table.s.dd_bid,0);submit(wrong,2,205);assert.equal(wrong.table.s.dd_bid,0);submit(wrong,2,201,'bid/submit');assert.equal(wrong.table.s.dd_bid,0);
const scores=setup(0);submit(scores,2,201,'bid/submit');submit(scores,5,202,'bid/submit');submit(scores,8,203,'bid/submit');assert.equal(scores.out.lord,8);assert.equal(scores.table.s.dd_bid,3);
assert.match(read('input/sync'),/dd_bidmode matches 2 run scoreboard players set #tool_turn dd_ctx -1/);
assert.match(read('input/sync_player'),/unless score #tool_turn dd_ctx matches -1/);
assert.match(read('bot/speed_tick'),/dd_bot_timer matches 60/);
assert.match(read('bot/speed_tick'),/dd_id = #speed_table dd_ctx/);
console.log('PASS: '+paths+'条叫抢路径（首位抢即结束/末位自动当选/放弃/跳过/倍数/全不叫）、三人手速竞争、旧叫分回归、越权拒绝与道具路由。');

for(const [ticks,mult] of [[0,4],[39,4],[40,4],[41,2],[60,2],[99,2],[100,2],[101,1],[299,1],[300,1]]){const w=setup(2);w.table.s.dd_speed_time=ticks;submit(w,5,207,'bid/speed_submit');assert.equal(w.table.s.dd_mult,mult);assert.equal(w.out.lord,5);}const timeout=setup(2);for(let i=0;i<300;i++)timeout.call('bid/speed_tick',timeout.table);assert.equal(timeout.out.deals,0);timeout.call('bid/speed_tick',timeout.table);assert.equal(timeout.out.deals,1);assert.equal(timeout.table.s.dd_round,1);submit(timeout,2,207,'bid/speed_submit');assert.equal(timeout.out.lord,undefined);for(const mode of [0,1]){const w=setup(mode);w.call('bid/speed_tick',w.table);assert.equal(w.table.s.dd_speed_time,0);}const late=setup(2);late.table.s.dd_speed_time=301;submit(late,2,207,'bid/speed_submit');assert.equal(late.out.lord,undefined);console.log('PASS: 手速计时0/40/41/100/101/300刻倍数、301刻无人叫重发、不计局数、迟到提交拒绝、其他叫地主模式隔离。');
