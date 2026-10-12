import fs from 'node:fs';
import assert from 'node:assert/strict';
const read=n=>fs.readFileSync('data/cardtable/function/'+n+'.mcfunction','utf8');
const coords={4:[[0,-2],[2,0],[0,2],[-2,0]],8:[[-1,-2.5],[1,-2.5],[2.5,-1],[2.5,1],[1,2.5],[-1,2.5],[-2.5,1],[-2.5,-1]]};
// 执行修复函数的实际指令子集；未知语法直接失败，不用另写的修复算法替代源码。
function selector(w,s,c){
 if(s==='@s')return [c.self];
 const parts=s.match(/^@e(?:\[(.*)\])?$/)?.[1]?.split(',')||[];
 let out=w.entities.filter(e=>!e.dead);
 for(const p of parts){
  const [key,value]=p.split('=');
  if(key==='tag')out=out.filter(e=>value.startsWith('!')?!e.tags.has(value.slice(1)):e.tags.has(value));
  else if(key==='type')out=out.filter(e=>e.type===value);
  else if(key==='limit')out=out.slice(0,+value);
  else throw Error('selector: '+p);
 }
 return out;
}
const get=(w,c,key,obj)=>key==='@s'?c.self.scores[obj]:w.scores[key+':'+obj];
const set=(w,c,key,obj,value)=>key==='@s'?c.self.scores[obj]=value:w.scores[key+':'+obj]=value;
function run(w,c,line){
 let m;
 if(line.startsWith('execute ')){
  let tokens=line.slice(8).split(' '),contexts=[c];
  while(tokens.length){
   const op=tokens.shift();
   if(op==='run'){for(const ctx of contexts)run(w,ctx,tokens.join(' '));return;}
   if(op==='as'){const s=tokens.shift();contexts=contexts.flatMap(ctx=>selector(w,s,ctx).map(self=>({...ctx,self})));}
   else if(op==='positioned'){
    const xyz=tokens.splice(0,3);contexts=contexts.map(ctx=>({...ctx,pos:xyz.map((v,i)=>ctx.pos[i]+Number(v.slice(1)))}));
   }else if(op==='summon'){
    const type=tokens.shift();contexts=contexts.map(ctx=>{const self={type,tags:new Set(),scores:{},pos:[...ctx.pos],passengers:[]};w.entities.push(self);return {...ctx,self};});
   }else if(op==='on'){
    const relation=tokens.shift();contexts=contexts.flatMap(ctx=>(relation==='passengers'?ctx.self.passengers:ctx.self.vehicle?[ctx.self.vehicle]:[]).map(self=>({...ctx,self})));
   }else if(op==='if'||op==='unless'){
    const kind=tokens.shift();let test;
    if(kind==='loaded'){const xyz=tokens.splice(0,3);test=ctx=>w.loaded(xyz.map((v,i)=>ctx.pos[i]+Number(v.slice(1))));}
    else if(kind==='entity'){const s=tokens.shift();test=ctx=>selector(w,s,ctx).length>0;}
    else if(kind==='score'){
     const [a,ao,cmp]=tokens.splice(0,3);
     if(cmp==='matches'){const val=+tokens.shift();test=ctx=>get(w,ctx,a,ao)===val;}
     else {assert.equal(cmp,'=');const [b,bo]=tokens.splice(0,2);test=ctx=>get(w,ctx,a,ao)!==undefined&&get(w,ctx,a,ao)===get(w,ctx,b,bo);}
    }else throw Error(kind);
    contexts=contexts.filter(ctx=>test(ctx)===(op==='if'));
   }else throw Error('execute: '+op);
  }return;
 }
 if((m=line.match(/^function cardtable:(\S+)$/)))return call(w,c,m[1]);
 if(line.startsWith('return ')){
  if(line.startsWith('return run '))run(w,c,line.slice(11));
  throw 'return';
 }
 if((m=line.match(/^tag (\S+) (add|remove) (\S+)$/))){for(const e of selector(w,m[1],c))e.tags[m[2]==='add'?'add':'delete'](m[3]);return;}
 if((m=line.match(/^kill (\S+)$/))){for(const e of selector(w,m[1],c)){assert.equal(e.passengers.length,0,'不得删除有乘客的座位');e.dead=true;}return;}
 if((m=line.match(/^scoreboard players operation (\S+) (\S+) = (\S+) (\S+)$/)))return set(w,c,m[1],m[2],get(w,c,m[3],m[4]));
 if((m=line.match(/^scoreboard players (set|add) (\S+) (\S+) (\d+)$/)))return set(w,c,m[2],m[3],(m[1]==='add'?(get(w,c,m[2],m[3])||0):0)+Number(m[4]));
 if(line==='data merge entity @s {width:0.96f,height:0.372f,response:1b}')return;
 throw Error('command: '+line);
}
function call(w,c,n){try{for(const line of read(n).split(/\r?\n/).map(s=>s.trim()).filter(s=>s&&!s.startsWith('#')))run(w,c,line);}catch(e){if(e!=='return')throw e;}}
function world(cap,mask){
 const self={type:'minecraft:marker',tags:new Set(['ct.controller']),scores:{ct_id:10,ct_capacity:cap},pos:[0,64,0],passengers:[]};
 const w={entities:[self],scores:{},loaded:()=>true,self};
 for(let i=0;i<cap;i++)if(mask&(1<<i))seat(w,cap,i+1);
 seat(w,cap,1,20); // 邻桌相同座号不受影响。
 return w;
}
function seat(w,cap,n,id=10){
 const [x,z]=coords[cap][n-1],e={type:'minecraft:interaction',tags:new Set(['ct.part','ct.seat',...(cap===8?['ct.seat8']:[])]),scores:{ct_id:id,ct_seat:n,ct_kind:n+10},pos:[x,64.32,z],passengers:[]};
 w.entities.push(e);return e;
}
function repair(w){call(w,{self:w.self,pos:w.self.pos},'table/ensure_seats');}
const seats=w=>w.entities.filter(e=>!e.dead&&e.tags.has('ct.seat')&&e.scores.ct_id===10);
let cases=0;
for(const cap of [4,8])for(let mask=0;mask<1<<cap;mask++){
 const w=world(cap,mask),original=seats(w);repair(w);repair(w);
 assert.equal(seats(w).length,cap);
 for(const e of original)assert.ok(!e.dead);
 for(const e of seats(w)){
  const n=e.scores.ct_seat,[x,z]=coords[cap][n-1];
  assert.deepEqual(e.pos,[x,64.32,z]);assert.equal(e.scores.ct_kind,n+10);
  assert.equal(e.tags.has('ct.seat8'),cap===8);
 }
 assert.equal(w.entities.filter(e=>!e.dead&&e.scores.ct_id===20).length,1);
 cases++;
}
for(const cap of [4,8])for(let n=1;n<=cap;n++){
 const w=world(cap,(1<<cap)-1),old=seat(w,cap,n),player={vehicle:old};
 old.passengers.push(player);repair(w);
 assert.ok(!old.dead);assert.equal(seats(w).length,cap);
 const other=seat(w,cap,n);other.passengers.push({vehicle:other});repair(w);
 assert.equal(seats(w).length,cap+1);assert.ok(!old.dead&&!other.dead);
 other.passengers=[];repair(w);assert.equal(seats(w).length,cap);
 cases++;
}
for(const cap of [4,8])for(const blocked of [[-3,-3],[3,-3],[-3,3],[3,3]]){
 const w=world(cap,0);w.loaded=([x,,z])=>x!==blocked[0]||z!==blocked[1];
 repair(w);assert.equal(seats(w).length,0);cases++;
}
for(const n of ['load','tick'])assert.ok(read(n).includes('run function cardtable:table/ensure_seats'));
for(let n=1;n<=4;n++)assert.ok(read('seat/mount').includes('ct_seat matches '+n+' at @s run tp'));
console.log('通过：'+cases+'种缺座、反复维护、上线带回座位、占用副本、跨桌隔离和未加载区块场景；执行实际修复指令。仍需游戏内退出/重进验收。');
