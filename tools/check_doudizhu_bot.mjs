import fs from 'node:fs';
import assert from 'node:assert/strict';
const cache=new Map();
const read=n=>{if(!cache.has(n))cache.set(n,fs.readFileSync('data/doudizhu/function/'+n+'.mcfunction','utf8').split(/\r?\n/).filter(l=>l&&!l.startsWith('#')));return cache.get(n);};
const range=(v,r)=>v!==undefined&&(r.includes('..')?v>=Number(r.split('..')[0]||-Infinity)&&v<=Number(r.split('..')[1]||Infinity):v===Number(r));
function simulate(hand,{type=0,len=0,high=0,lord=1,last=1,enemy=8,probe=false,selected=[]}={}){
 const make=(tags,s)=>({tags:new Set(tags),s});
 const bot=make(['dd.actor','dd.bot'],{dd_id:1,dd_seat:1});
 const table=make(['dd.current'],{dd_type:type,dd_len:len,dd_high:high,dd_lord:lord,dd_last:last});
 const actors=[bot,make(['dd.actor'],{dd_id:1,dd_seat:2}),make(['dd.actor'],{dd_id:1,dd_seat:3})];
 const cards=hand.map(r=>make(['dd.hand','dd.card'],{dd_id:1,dd_owner:1,dd_rank:r,dd_selected:0}));
 const all=[table,...actors,...cards,...Array.from({length:enemy},()=>make(['dd.card'],{dd_id:1,dd_owner:2})),...Array.from({length:8},()=>make(['dd.card'],{dd_id:1,dd_owner:3})),make(['dd.actor'],{dd_id:99,dd_seat:2}),make(['dd.card'],{dd_id:99,dd_owner:2})];
 const fake={};let commands=0;
 function select(q,self){if(q==='@s')return [self];let a=all;for(const m of q.matchAll(/tag=([^,\]]+)/g)){const v=m[1];a=a.filter(e=>v[0]==='!'?!e.tags.has(v.slice(1)):e.tags.has(v));}const ss=q.match(/scores=\{([^}]+)\}/)?.[1];if(ss)for(const c of ss.split(',')){const [k,r]=c.split('=');a=a.filter(e=>range(e.s[k],r));}const limit=q.match(/limit=(\d+)/);return limit?a.slice(0,+limit[1]):a;}
 const get=(who,obj,self)=>who.startsWith('@')?select(who,self)[0]?.s[obj]:fake[who+':'+obj];
 const put=(who,obj,v,self)=>who.startsWith('@')?select(who,self).forEach(e=>e.s[obj]=v):fake[who+':'+obj]=v;
 function call(n,self,args={}){for(let l of read(n)){if(l[0]==='$')l=l.slice(1).replace(/\$\((\w+)\)/g,(_,k)=>{assert.notEqual(args[k],undefined);return args[k];});if(command(l,self))break;}}
 function command(l,self){commands++;let m;
  if(l.startsWith('return '))return true;
  if(l.startsWith('execute ')){const at=l.indexOf(' run ');let p=l.slice(8,at),contexts=[self];while(p){
   if((m=p.match(/^as (\S+)(?: |$)/)))contexts=contexts.flatMap(c=>select(m[1],c));
   else if((m=p.match(/^(if|unless) entity (\S+)(?: |$)/)))contexts=contexts.filter(c=>(select(m[2],c).length>0)===(m[1]==='if'));
   else if((m=p.match(/^(if|unless) score (\S+) (\S+) matches (\S+)(?: |$)/)))contexts=contexts.filter(c=>range(get(m[2],m[3],c),m[4])===(m[1]==='if'));
   else if((m=p.match(/^(if|unless) score (\S+) (\S+) (=|<|>) (\S+) (\S+)(?: |$)/)))contexts=contexts.filter(c=>{const a=get(m[2],m[3],c),b=get(m[5],m[6],c);return (a!==undefined&&b!==undefined&&(m[4]==='='?a===b:m[4]==='<'?a<b:a>b))===(m[1]==='if');});
   else throw Error(p);
   p=p.slice(m[0].length);if(!contexts.length)return false;
  }for(const c of contexts)if(command(l.slice(at+5),c))return true;return false;}
  if((m=l.match(/^function doudizhu:(\S+)(?: \{(.*)\})?$/))){const args={};if(m[2])for(const part of m[2].split(',')){const [k,v]=part.split(':');args[k]=+v;}call(m[1],self,args);return;}
  if((m=l.match(/^tag (\S+) (add|remove) (\S+)$/))){for(const e of select(m[1],self))e.tags[m[2]==='add'?'add':'delete'](m[3]);return;}
  if((m=l.match(/^scoreboard players (set|add|remove) (\S+) (\S+) (-?\d+)$/))){const [,op,k,o,n]=m;put(k,o,op==='set'?+n:(get(k,o,self)||0)+(op==='remove'?-1:1)*n,self);return;}
  if((m=l.match(/^scoreboard players operation (\S+) (\S+) (=|\+=|-=|\*=|<|>) (\S+) (\S+)$/))){const [,a,ao,op,b,bo]=m,x=get(a,ao,self)||0,y=get(b,bo,self);put(a,ao,op==='='?y:op==='+='?x+y:op==='-='?x-y:op==='*='?x*y:op==='<'?Math.min(x,y):Math.max(x,y),self);return;}
  throw Error(l);
 }
 for(const i of selected)cards[i].s.dd_selected=1;
 call(probe?'dialog/can_play':'bot/search',bot);
 const chosen=cards.filter(c=>c.s.dd_selected===1).map(c=>c.s.dd_rank);
 if(!probe&&fake['#bot_found:dd_ctx']===1){call('rules/classify',bot);const t=fake['#type:dd_ctx'],n=fake['#n:dd_ctx'],h=fake['#high:dd_ctx'];assert.ok(t>0);assert.ok(type===0||(t===type&&n===len&&h>high)||(t===13&&type<13)||(t===14&&type<14));}else if(!probe)assert.equal(chosen.length,0);
 return {chosen,commands,canPlay:fake['#can_play:dd_ctx'],probe:fake['#bot_probe:dd_ctx'],cost:fake['#bot_best_cost:dd_ctx']};
}
assert.deepEqual(simulate([3,4,5,6,7]).chosen,[3,4,5,6,7]);
assert.deepEqual(simulate([3,3,4,4,5,5]).chosen,[3,3,4,4,5,5]);
assert.deepEqual(simulate([3,3,3,4,4,4,8,9]).chosen,[3,3,3,4,4,4,8,9]);
assert.deepEqual(simulate([3,3,3,3,6,9],{type:1,len:1,high:5}).chosen,[6]);
assert.deepEqual(simulate([6,9,14],{type:1,len:1,high:5,enemy:1}).chosen,[14]);
assert.deepEqual(simulate([6,9,14],{type:1,len:1,high:5,lord:2,last:3}).chosen,[]);
assert.deepEqual(simulate([14],{type:1,len:1,high:5,lord:2,last:3}).chosen,[14]);
assert.deepEqual(simulate([3,3,3,3,5],{type:2,len:2,high:14}).chosen,[3,3,3,3]);
assert.deepEqual(simulate([16,17],{type:13,len:4,high:15}).chosen,[16,17]);
let seed=12345,maxCommands=0;
const rnd=n=>{seed=(Math.imul(seed,1664525)+1013904223)>>>0;return seed%n;};
for(let i=0;i<80;i++){const deck=Array.from({length:52},(_,j)=>3+Math.floor(j/4)).concat([16,17]);const h=[];for(let j=0;j<8+rnd(13);j++)h.push(deck.splice(rnd(deck.length),1)[0]);const follow=i%3;const r=simulate(h,{type:follow,len:follow?follow:0,high:5+rnd(10),enemy:1+rnd(8)});maxCommands=Math.max(maxCommands,r.commands);if(follow===0)assert.ok(r.chosen.length>0);}
const worst=simulate([3,3,3,4,4,4,5,5,5,6,6,6,7,7,7,8,8,8,16,17]);maxCommands=Math.max(maxCommands,worst.commands);
assert.ok(maxCommands<60000,'Bounded command count: '+maxCommands);
console.log('PASS: real bot and classification commands; combinations, bomb preservation, teammate passing, emergency blocking, legal random replies; max '+maxCommands+' interpreted commands.');

// 玩家窗口不能把农民队友让牌策略当成“要不起”，并须恢复选牌。
for(const options of [{lord:2,last:3},{lord:2,last:2},{lord:1,last:2}]){const r=simulate([3,3,5,6,6,7,9,9,9,11,11,12,13,13,14,15,15],{...options,type:1,len:1,high:4,probe:true,selected:[2,3]});assert.equal(r.canPlay,1);assert.deepEqual(r.chosen,[5,6]);assert.equal(r.probe,0);}
assert.equal(simulate([3,3,4],{type:1,len:1,high:14,lord:2,last:3,probe:true}).canPlay,0);
assert.equal(simulate([3,3,3,3,5],{type:2,len:2,high:14,lord:2,last:3,probe:true}).canPlay,1);
assert.equal(simulate([16,17,5],{type:13,len:4,high:15,lord:2,last:3,probe:true}).canPlay,1);
console.log('PASS: 玩家能压单4、队友/对手身份、真实无牌可压、炸弹/王炸应牌和已有选牌恢复。');

// 普通局面仅炸弹/王炸能压时可主动不出，玩家仍可合法出牌。
const bombHand=[3,3,3,3,5,7,9,11,13];
const rocketHand=[3,5,7,9,11,16,17];
for(const hand of [bombHand,rocketHand]){
 assert.deepEqual(simulate(hand,{type:2,len:2,high:15,enemy:8}).chosen,[]);
 assert.equal(simulate(hand,{type:2,len:2,high:15,enemy:8,probe:true}).canPlay,1);
 assert.ok(simulate(hand,{type:2,len:2,high:15,enemy:1}).chosen.length>=2);
 assert.ok(simulate(hand,{type:2,len:2,high:15,enemy:2}).chosen.length>=2);
 assert.ok(simulate(hand).chosen.length>0,'领出不能为了保炸而不出');
}
assert.deepEqual(simulate(bombHand,{type:1,len:1,high:6,enemy:8}).chosen,[7]);
// 唯一可压单张来自完整炸弹或王炸时，平时不拆，紧急时仍拦截。
const splitBomb=[15,15,15,15,3,5,7];
assert.deepEqual(simulate(splitBomb,{type:1,len:1,high:14,enemy:8}).chosen,[]);
assert.deepEqual(simulate(splitBomb,{type:1,len:1,high:14,enemy:1}).chosen,[15]);
assert.deepEqual(simulate([3,5,7,9,11,16,17],{type:1,len:1,high:15,enemy:8}).chosen,[]);
assert.deepEqual(simulate([3,3,3,3],{type:2,len:2,high:15,enemy:8}).chosen,[3,3,3,3]);
console.log('PASS: 非紧急保炸/保王、保留普通应牌、报单报双拦截、残局出炸、领出与玩家合法性不受影响。');

// 主动领出应先处理小散牌，不能把报双拦截权重误用为领出对2。
for(const enemy of [2,8]){
 assert.deepEqual(simulate([3,15,15],{enemy}).chosen,[3]);
 assert.deepEqual(simulate([3,4,15,15],{enemy}).chosen,[3]);
 assert.deepEqual(simulate([3,14,14],{enemy}).chosen,[3]);
 assert.deepEqual(simulate([3,5,7,15,15],{enemy}).chosen,[3]);
}
assert.deepEqual(simulate([3,15,15],{enemy:1}).chosen,[15,15],'报单时避免小单直接放走对手');
assert.deepEqual(simulate([15,15]).chosen,[15,15],'可直接出完的大对子不保留');
assert.deepEqual(simulate([3,15,15],{type:2,len:2,high:14,enemy:2}).chosen,[15,15],'跟牌仍应使用对2拦截');
assert.deepEqual(simulate([10,11,12,13,14]).chosen,[10,11,12,13,14],'整手顺子不受控制牌惩罚');
console.log('PASS: 领出先处理小单、保留A/2控制牌、报单非单张领出、报双跟牌拦截和直接出完。');
