import fs from 'node:fs';
import assert from 'node:assert/strict';
const read=id=>fs.readFileSync('data/'+id.replace(':','/function/')+'.mcfunction','utf8');
// 执行实际结束路径的记分、标签与坐标指令；只替代界面渲染和物品表现。
function runCase(seats,mode){
 const entity=(id,kind,tags,score,pos)=>({id,kind,tags:new Set(tags),score:{...score},pos});
 const table=entity('table','entity',['ct.controller','cp.controller'],{ct_id:12,cp_id:12,ct_state:1,cp_state:4,cp_timer:1,ct_joined:seats.length},[120,70,-40]);
 const players=seats.map(s=>entity('player'+s,'player',['ct.player','cp.player','cp.audience'],{ct_id:12,cp_id:12,cp_seat:s},[120+s,71,-40]));
 const other=entity('other','player',['ct.player','cp.player'],{ct_id:13,cp_id:13,cp_seat:8},[300,70,200]);
 const entities=[table,...players,other],fake={},renders=[];
 const select=(s,ctx)=>{
  if(s==='@s')return [ctx.self];
  let list=entities.filter(e=>s.startsWith('@a')?e.kind==='player':true);
  for(const m of s.matchAll(/tag=([^,\]]+)/g))list=list.filter(e=>e.tags.has(m[1]));
  if(s.includes('limit=1'))list=list.slice(0,1);
  return list;
 };
 const score=(who,obj,ctx)=>who.startsWith('@')?select(who,ctx)[0]?.score[obj]:fake[who+':'+obj];
 const set=(who,obj,value,ctx)=>{if(who.startsWith('@'))for(const e of select(who,ctx)){if(value===undefined)delete e.score[obj];else e.score[obj]=value;}else fake[who+':'+obj]=value;};
 function command(line,ctx){
  if(!line||line.startsWith('#'))return;
  if(line.startsWith('return run ')){command(line.slice(11),ctx);return true;}
  if(line.startsWith('execute ')){
   const at=line.indexOf(' run '),body=line.slice(at+5);let prefix=line.slice(8,at),contexts=[ctx];
   while(prefix){let m;
    if((m=prefix.match(/^as (\S+)(?: |$)/)))contexts=contexts.flatMap(c=>select(m[1],c).map(self=>({...c,self})));
    else if((m=prefix.match(/^at @s(?: |$)/)))contexts=contexts.map(c=>({...c,pos:c.self.pos}));
    else if((m=prefix.match(/^(if|unless) entity (\S+)(?: |$)/)))contexts=contexts.filter(c=>(select(m[2],c).length>0)===(m[1]==='if'));
    else if((m=prefix.match(/^if score (\S+) (\S+) = (\S+) (\S+)(?: |$)/)))contexts=contexts.filter(c=>score(m[1],m[2],c)!==undefined&&score(m[1],m[2],c)===score(m[3],m[4],c));
    else if((m=prefix.match(/^if score @s cp_timer matches \.\.0(?: |$)/)))contexts=contexts.filter(c=>c.self.score.cp_timer<=0);
    else throw Error('未覆盖条件：'+prefix);
    prefix=prefix.slice(m[0].length);
   }
   for(const c of contexts)if(command(body,c))return true;
   return;
  }
  let m;
  if((m=line.match(/^function (\S+)/))){const id=m[1];
   if(id==='cardtable:menu/render'){renders.push({id:ctx.self.score.ct_id,pos:ctx.pos});return;}
   if(id==='cardtable:log'||id==='cardtable:animation/deal/clear')return;
   for(const child of read(id).split(/\r?\n/))if(command(child,ctx))break;
   return;
  }
  if((m=line.match(/^scoreboard players operation (\S+) (\S+) = (\S+) (\S+)$/)))return set(m[1],m[2],score(m[3],m[4],ctx),ctx);
  if((m=line.match(/^scoreboard players (set|reset|remove) (\S+) (\S+)(?: (-?\d+))?$/)))return set(m[2],m[3],m[1]==='reset'?undefined:m[1]==='set'?Number(m[4]):score(m[2],m[3],ctx)-Number(m[4]),ctx);
  if((m=line.match(/^tag (\S+) (add|remove) (\S+)$/))){for(const e of select(m[1],ctx))e.tags[m[2]==='add'?'add':'delete'](m[3]);return;}
  if(/^(clear|dialog clear|kill) /.test(line))return;
  throw Error('未覆盖指令：'+line);
 }
 const initialOther=JSON.stringify({...other,tags:[...other.tags]});
 const actor=mode==='rejoin'||mode==='orphan'?players[0]:table;
 if(mode==='orphan')table.tags.delete('cp.controller');
 const fn=mode==='rejoin'||mode==='orphan'?'game/player_left':mode==='timer'?'game/finish_tick':'game/abort';
 command('function critical_point:'+fn,{self:actor,pos:[0,64,0]});
 assert.equal(JSON.stringify({...other,tags:[...other.tags]}),initialOther,'其他桌玩家不得受影响');
 if(mode==='orphan'){
  assert.equal(renders.length,0);assert.ok(!players[0].tags.has('cp.player'));assert.equal(players[0].score.cp_id,undefined);
 }else{
  assert.deepEqual(renders,[{id:12,pos:table.pos}]);assert.equal(table.score.ct_state,0);
  assert.ok(!table.tags.has('cp.controller'));
  for(const p of players){assert.ok(!p.tags.has('cp.player'));assert.ok(!p.tags.has('cp.audience'));assert.equal(p.score.cp_id,undefined);assert.equal(p.score.ct_id,12);}
 }
}
let checks=0;
for(let mask=1;mask<256;mask++){
 const seats=Array.from({length:8},(_,i)=>i+1).filter(s=>mask&(1<<(s-1)));
 if(seats.length<3||seats.length>6)continue;
 for(const mode of ['timer','abort','rejoin','orphan']){runCase(seats,mode);checks++;}
}
for(const side of ['wolf','villagers'])assert.match(read('critical_point:game/finish_'+side),/set @s cp_timer 100/);
assert.match(read('critical_point:tick'),/cp_state=4.*at @s run function critical_point:game\/finish_tick/);
assert.match(read('critical_point:game/end_vote'),/function critical_point:game\/abort/);
console.log('通过：'+checks+'种结束路径与3至6人座位组合，包含重连位置、已结束对局重连、双桌隔离、计时结束和大厅状态恢复。');
