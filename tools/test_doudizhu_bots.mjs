import fs from 'node:fs';
import path from 'node:path';
import assert from 'node:assert/strict';
import {classify} from './test_doudizhu.mjs';
const stage=path.resolve(import.meta.dirname,'doudizhu-bot-stage/data');
const target='C:/Users/Chen Yuru/AppData/Roaming/.minecraft/versions/26.2-Fabric 0.19.3/saves/卡牌游戏/datapacks/fimelcard-dp/data';
const read=p=>fs.readFileSync(fs.existsSync(path.join(stage,p))?path.join(stage,p):path.join(target,p),'utf8');
// 读取实际生成的候选指令顺序、条件和参数，再用现有牌型函数检查最终组合。
const commands=read('doudizhu/function/bot/search.mcfunction').split(/\r?\n/).filter(l=>l.includes('run function doudizhu:bot/candidate'));
const candidates=commands.map(line=>({conditions:[...line.matchAll(/if score (#[\w]+) dd_ctx matches (\S+)/g)].map(m=>[m[1],m[2]]),args:Object.fromEntries([...line.matchAll(/(low|high|copies|wings|unit|no_rocket):(\d+)/g)].map(m=>[m[1],+m[2]]))}));
const matches=(v,r)=>r.includes('..')?((([a,b])=>v>=(a===''?-Infinity:+a)&&v<=(b===''?Infinity:+b))(r.split('..'))):v===+r;
function bot(hand,last={type:0,n:0,high:0}) {
 const have=Array.from({length:18},(_,r)=>hand.filter(x=>x===r).length);
 for(const {conditions,args:a} of candidates) {
  const scores={'#bot_found':0,'#bot_type':last.type,'#bot_len':last.n,'#bot_high':last.high};
  for(let r=3;r<=17;r++)scores['#have'+r]=have[r];
  if(!conditions.every(([k,r])=>matches(scores[k],r)))continue;
  const selected=[];for(let r=a.low;r<=a.high;r++)for(let j=0;j<a.copies;j++)selected.push(r);
  let need=a.wings;
  for(let r=3;r<=17&&need;r++)if(r<a.low||r>a.high){
    if(a.unit===2&&have[r]>=2){selected.push(r,r);need--;}
    if(a.unit===1)for(let j=0;j<Math.min(2,have[r])&&need;j++){selected.push(r);need--;}
  }
  if(need||(a.no_rocket&&selected.includes(16)&&selected.includes(17)))continue;
  const shape=classify(selected);
  if((last.type===0&&shape.type===1)||(shape.type===last.type&&shape.n===last.n&&shape.high>last.high)||(shape.type===13&&last.type>=1&&last.type<=12)||(shape.type===14&&last.type>=1&&last.type<=13))return selected;
 }
 return [];
}
const tests=[
 [[3,3,3,3,4,4,16,17],[],[3]],
 [[4,7,10,16],[6],[7]],
 [[3,3,6,6,9,9],[5,5],[6,6]],
 [[5,5,5,7,7,7],[4,4,4],[5,5,5]],
 [[3,5,5,5,7,7,7,8],[4,4,4,6],[5,5,5,3]],
 [[3,3,5,5,5,9,9],[4,4,4,6,6],[5,5,5,3,3]],
 [[4,5,6,7,8,9],[3,4,5,6,7],[4,5,6,7,8]],
 [[4,4,5,5,6,6,7,7],[3,3,4,4,5,5],[4,4,5,5,6,6]],
 [[4,4,4,5,5,5,9],[3,3,3,4,4,4],[4,4,4,5,5,5]],
 [[3,3,4,4,4,5,5,5],[3,3,3,4,4,4,8,9],[4,4,4,5,5,5,3,3]],
 [[3,3,4,4,4,5,5,5,8,8],[3,3,3,4,4,4,9,9,10,10],[4,4,4,5,5,5,3,3,8,8]],
 [[3,3,8,8,8,8],[7,7,7,7,4,5],[8,8,8,8,3,3]],
 [[3,3,4,4,8,8,8,8],[7,7,7,7,5,5,6,6],[8,8,8,8,3,3,4,4]],
 [[3,3,3,3,4,4,4,4,16,17],[15,15],[3,3,3,3]],
 [[4,4,4,4,8,8,8,8],[5,5,5,5],[8,8,8,8]],
 [[3,3,3,3,16,17],[15,15,15,15],[16,17]],
 [[3,4,16,17],[16,17],[]],
 [[3,4,5,6],[15],[]],
 [[3,3,3,3,6,6],[5,5],[6,6]],
 [[4,4,4,5,5,5,16,17],[3,3,3,4,4,4,8,9],[16,17]]
];
for(const [hand,previous,expected]of tests)assert.deepEqual(bot(hand,previous.length?classify(previous):undefined),expected,JSON.stringify({hand,previous}));
// 八座桌中的稀疏真人座位仍只补足三名，不改动真实座位数量。
for(const humanSeats of [[1],[8],[2,7],[7,8],[1,4,8]]){
 const actors=[...humanSeats];for(let seat=1;actors.length<3&&seat<=4;seat++)if(!actors.includes(seat))actors.push(seat);
 assert.equal(actors.length,3);assert.equal(new Set(actors).size,3);
 actors.sort((a,b)=>a-b);let turn=actors[0];for(let i=0;i<9;i++){const next=actors.find(s=>s>turn)??actors[0];assert.equal(next,actors[(actors.indexOf(turn)+1)%3]);turn=next;}
}
// 对三个简单人机进行整局推演，检查出牌后严格减牌、不能压过时才跳过，最终能结束。
for(let seed=1;seed<=12;seed++){
 let state=seed;const deck=[];for(let r=3;r<=17;r++)for(let n=0;n<(r<16?4:1);n++)deck.push(r);
 const hands=[[],[],[]];for(let i=0;i<54;i++){state=(Math.imul(state,1664525)+1013904223)>>>0;hands[i<51?i%3:0].push(deck.splice(state%deck.length,1)[0]);}
 let turn=0,last,passes=0,done=false;
 for(let step=0;step<250;step++){
  const selection=bot(hands[turn],last);
  if(selection.length){for(const r of selection){const i=hands[turn].indexOf(r);assert(i>=0);hands[turn].splice(i,1);}last=classify(selection);passes=0;if(!hands[turn].length){done=true;break;}}
  else{assert(last);if(++passes===2){last=undefined;passes=0;}}
  turn=(turn+1)%3;
 }
 assert(done,'测试牌局不能结束');
}
const walk=d=>fs.readdirSync(d,{withFileTypes:true}).flatMap(e=>e.isDirectory()?walk(path.join(d,e.name)):[path.join(d,e.name)]);
for(const f of walk(stage).filter(f=>f.endsWith('.mcfunction'))){const text=fs.readFileSync(f,'utf8');for(const m of text.matchAll(/\bfunction (doudizhu|cardtable):([a-z0-9_/]+)/g))read(m[1]+'/function/'+m[2]+'.mcfunction');}
assert(read('doudizhu/function/round/advance.mcfunction').includes('#next dd_ctx 9'));
assert(read('doudizhu/function/system/maintenance.mcfunction').includes('#online dd_ctx = @s dd_humans'));
assert(read('doudizhu/function/game/abort.mcfunction').includes('tag=dd.bot'));
for(const size of [4,8])assert(read('cardtable/function/menu/picker/show'+size+'.mcfunction').includes('斗地主（1–3人+人机）'));
console.log('20个人机跟牌案例、稀疏座位、12局完整模拟和目标版本函数引用通过。');
