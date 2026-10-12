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
  if(n==='deal/start'){out.deals++;self.s.dd_state=1;return;}
  if(n==='game/abort'){out.ends++;out.totals=actors.map(e=>e.s.dd_total);self.s.ct_state=0;return;}
  for(const line of read(n).split(/\r?\n/))if(command(line,self))break;
 }
 function command(line,self){
  if(!line||line.startsWith('#')||/^(tellraw|dialog|clear|data) /.test(line))return;
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
  if((m=line.match(/^scoreboard players operation (\S+) (\S+) (=|\+=|-=|\*=|>) (\S+) (\S+)$/))){const [,a,ao,op,b,bo]=m,x=get(a,ao,self)||0,y=get(b,bo,self);put(a,ao,op==='='?y:op==='+='?x+y:op==='-='?x-y:op==='*='?x*y:Math.max(x,y),self);return;}
  throw Error(line);
 }
 return {table,actors,other,fake,out,call};
}
let cases=0;
for(const limit of [1,2,3,32])for(const lordSeat of [2,5,8]){
 const w=world(),expected=[0,0,0];w.table.s.dd_limit=limit;
 for(let r=1;r<=limit;r++){
  w.table.s.dd_state=3;w.table.s.dd_lord=lordSeat;w.table.s.dd_bid=r%3+1;w.table.s.dd_mult=2;
  const lordWins=r%2===1;w.fake['#winner:dd_ctx']=lordWins?lordSeat:w.actors.find(a=>a.s.dd_seat!==lordSeat).s.dd_seat;
  const spring=r%3===0;for(const a of w.actors)a.s.dd_plays=spring?(lordWins&&a.s.dd_seat!==lordSeat?0:!lordWins&&a.s.dd_seat===lordSeat?1:2):2;
  w.call('game/finish',w.table);
  const unit=(r%3+1)*2*(spring?2:1);w.actors.forEach((a,i)=>expected[i]+=unit*(a.s.dd_seat===lordSeat?2:-1)*(lordWins?1:-1));
  assert.deepEqual(w.actors.map(a=>a.s.dd_total),expected);assert.equal(expected.reduce((a,b)=>a+b),0);
  w.call('game/finish',w.table);assert.deepEqual(w.actors.map(a=>a.s.dd_total),expected,'不得重复结算');
  const saved={...w.table.s};w.call('game/ensure_match',w.table);assert.deepEqual(w.table.s,saved,'重载不得改动局数/计时');
  for(let t=0;t<99;t++)w.call('game/intermission',w.table);
  assert.equal(w.table.s.dd_state,4);assert.equal(w.out.ends,0);
  w.call('game/intermission',w.table);
  if(r<limit){assert.equal(w.table.s.dd_round,r+1);assert.equal(w.out.deals,r);}else{assert.equal(w.out.ends,1);assert.deepEqual(w.out.totals,expected);}
  cases++;
 }
 assert.equal(w.other.s.dd_max,7);
}
for(const rounds of [0,1,16,32,33,999])for(const state of [0,1])for(const sameTable of [true,false])for(const game of [10,9]){
 const w=world(),p=w.actors[0];p.s.dd_settings=rounds;p.s.dd_set_table=sameTable?12:13;w.table.s.ct_state=state;w.table.s.ct_game=game;w.table.s.dd_max=1;
 w.call('settings/save',p);assert.equal(w.table.s.dd_max,rounds>=1&&rounds<=32&&state===0&&sameTable&&game===10?rounds:1);assert.equal(w.other.s.dd_max,7);assert.equal(p.s.dd_settings,undefined);
}
const dialog=JSON.parse(read('settings/show').slice(read('settings/show').indexOf('{')).replace('$(initial)','1'));
assert.equal(dialog.inputs[0].end,32);assert.equal(dialog.yes.action.template,'trigger dd_settings set $(rounds)');
assert.ok(!read('deal/start').includes('dd_total'));assert.ok(!read('game/abort').includes('reset @s dd_max'));
assert.match(read('bid/finish'),/matches 0 run return run function doudizhu:deal\/start/);
assert.match(read('deal/start'),/data.doudizhu set value \{\}/);
assert.match(read('load'),/matches 3 run function doudizhu:system\/upgrade_v4/);
for(const p of ['player/init','bot/init'])assert.match(read(p),/set @s dd_total 0/);
const walk=p=>fs.readdirSync(p,{withFileTypes:true}).flatMap(e=>e.isDirectory()?walk(p+'/'+e.name):[p+'/'+e.name]);
for(const p of walk('data/doudizhu/function'))for(const m of fs.readFileSync(p,'utf8').matchAll(/\bfunction (doudizhu|cardtable):([\w/]+)/g))assert.ok(fs.existsSync('data/'+m[1]+'/function/'+m[2]+'.mcfunction'),p+' -> '+m[0]);
console.log('通过：'+cases+'局实际结算指令、正负累计/春天/人机/防重复、100刻自动续局、整场总分、96种设置提交、重载保护及函数引用。');
