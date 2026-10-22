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
  if(n==='log'||n==='input/sync'||n==='settings/invalid')return;
  if(n==='player/audience'){for(const e of all){e.tags.delete('dd.actors');e.tags.delete('dd.audience');if(e.s.dd_id===self.s.dd_id&&e.tags.has('dd.actor')){e.tags.add('dd.actors');if(e.player)e.tags.add('dd.audience');}}return;}
  if(n==='action/context'){table.tags.add('dd.current');return;}
  if(n==='action/clear_context'){table.tags.delete('dd.current');return;}
  if(n==='dialog/can_play'){fake['#can_play:dd_ctx']=out.legal??0;out.probes=(out.probes||0)+1;return;}
  if(n==='action/pass'){out.passes=(out.passes||0)+1;table.s.dd_turn=8;table.s.dd_autopass=-1;return;}
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
    else if((m=prefix.match(/^(if|unless) score (\S+) (\S+) (=|<|>) (\S+) (\S+)(?: |$)/)))contexts=contexts.filter(c=>{const a=get(m[2],m[3],c),b=get(m[5],m[6],c);return (a!==undefined&&b!==undefined&&(m[4]==='='?a===b:m[4]==='<'?a<b:a>b))===(m[1]==='if');});
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
  if((m=line.match(/^scoreboard players operation (\S+) (\S+) (=|\+=|-=|\*=|\/=|%=|>) (\S+) (\S+)$/))){const [,a,ao,op,b,bo]=m,x=get(a,ao,self)||0,y=get(b,bo,self);put(a,ao,op==='='?y:op==='+='?x+y:op==='-='?x-y:op==='*='?x*y:op==='/='?Math.floor(x/y):op==='%='?((x%y)+y)%y:Math.max(x,y),self);return;}
  throw Error(line);
 }
 return {table,actors,other,fake,out,call};
}

function setup(){const w=world();w.table.s.dd_turn=2;w.table.s.dd_type=1;w.table.s.dd_autopass=-1;for(const a of w.actors)a.tags.add('dd.player');return w;}
const w=setup();w.call('autopass/tick',w.table);assert.equal(w.table.s.dd_autopass,100);assert.equal(w.out.probes,1);
for(let i=0;i<99;i++)w.call('autopass/tick',w.table);assert.equal(w.out.passes,undefined);assert.equal(w.table.s.dd_autopass,1);
w.call('autopass/tick',w.table);assert.equal(w.out.passes,1);assert.equal(w.out.probes,2);
for(const legal of [0,1]){const t=setup();t.out.legal=legal;if(!legal)t.table.s.dd_type=0;for(let i=0;i<110;i++)t.call('autopass/tick',t.table);assert.equal(t.out.passes,undefined);}
const changed=setup();changed.call('autopass/tick',changed.table);changed.out.legal=1;for(let i=0;i<100;i++)changed.call('autopass/tick',changed.table);assert.equal(changed.out.passes,undefined);
const manual=setup();manual.call('autopass/tick',manual.table);manual.table.s.dd_turn=5;manual.table.s.dd_autopass=-1;manual.out.legal=1;for(let i=0;i<110;i++)manual.call('autopass/tick',manual.table);assert.equal(manual.out.passes,undefined);
const cross=setup();cross.actors[0].s.ct_id=99;for(let i=0;i<110;i++)cross.call('autopass/tick',cross.table);assert.equal(cross.out.passes,undefined);
assert.match(read('hud/row_text'),/unless score @e\[tag=dd.current,limit=1\] dd_counts matches 0 run data modify/);
assert.match(read('action/play'),/unless score @e\[tag=dd.current,limit=1\] dd_counts matches 0.*run tellraw/);
console.log('PASS: 100刻计时、只探测两次、可出不自动过、领出不自动过、手动切回合、到期复验、跨桌隔离及隐藏牌数入口。');
