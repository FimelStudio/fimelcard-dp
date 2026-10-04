import fs from 'node:fs';
import path from 'node:path';
import assert from 'node:assert/strict';
const root=path.resolve(import.meta.dirname,'..');
const functions=path.join(root,'data/doudizhu/function');
const functionCache=new Map();
const read=name=>{if(!functionCache.has(name))functionCache.set(name,fs.readFileSync(path.join(functions,name+'.mcfunction'),'utf8'));return functionCache.get(name);};
// 直接执行生成的牌型函数里的记分板分支，避免仅测试另写的一份规则。
export function classify(hand) {
  const scores=new Map();
  const count=rank=>hand.filter(x=>x===rank).length;
  const value=k=>scores.get(k)??0;
  function run(name,args={}) {
    for (let line of read(name).split(/\r?\n/)) {
      line=line.trim(); if(!line||line.startsWith('#')) continue;
      if(line.startsWith('$')) line=line.slice(1).replace(/\$\((\w+)\)/g,(_,k)=>args[k]);
      let repetitions=1;
      if(line.startsWith('execute ')) {
        const cut=line.lastIndexOf(' run '), cond=line.slice(8,cut); line=line.slice(cut+5);
        const selector=/^as @e\[tag=dd.hand,scores=\{dd_selected=1,dd_rank=(\d+)\}\]$/.exec(cond);
        if(selector) repetitions=count(+selector[1]);
        else {
          const pattern=/(if|unless) score (\S+) dd_ctx (matches \S+|[<>=]+ \S+ dd_ctx)/g;
          const parts=[...cond.matchAll(pattern)];
          assert.equal(parts.map(x=>x[0]).join(' '),cond,'未支持条件: '+cond);
          const okay=parts.every(([,mode,lhs,comparison])=>{
            let yes;
            if(comparison.startsWith('matches ')) {
              const range=comparison.slice(8), n=value(lhs);
              if(range.includes('..')) {const [a,b]=range.split('..'); yes=n>=(a===''?-Infinity:+a)&&n<=(b===''?Infinity:+b);}
              else yes=n===+range;
            } else {const [op,rhs]=comparison.split(' '),a=value(lhs),b=value(rhs); yes=op==='='?a===b:op==='<'?a<b:op==='>'?a>b:op==='<='?a<=b:a>=b;}
            return mode==='if'?yes:!yes;
          });
          if(!okay) continue;
        }
      }
      for(let i=0;i<repetitions;i++) {
        let m;
        if((m=/^scoreboard players (set|add) (\S+) dd_ctx (-?\d+)$/.exec(line))) scores.set(m[2],m[1]==='set'?+m[3]:value(m[2])+(+m[3]));
        else if((m=/^scoreboard players operation (\S+) dd_ctx \+= (\S+) dd_ctx$/.exec(line))) scores.set(m[1],value(m[1])+value(m[2]));
        else if((m=/^function doudizhu:(\S+)(?: \{(.*)\})?$/.exec(line))) {
          const params={}; if(m[2]) for(const pair of m[2].split(',')) {const [k,v]=pair.split(':');params[k]=+v;}
          run(m[1],params);
        } else if(line==='return 0') return;
        else throw Error('未支持命令: '+line);
      }
    }
  }
  run('rules/classify'); return {type:value('#type'),high:value('#high'),n:value('#n')};
}
const cases=[
  ['空选',[],0],['单张',[17],1,17],['对子',[15,15],2,15],['三张',[10,10,10],3,10],
  ['三带一',[5,5,5,17],4,5],['三带二',[5,5,5,3,3],5,5],
  ['顺子',[3,4,5,6,7],6,7],['A结尾顺子',[10,11,12,13,14],6,14],
  ['含2的顺子',[11,12,13,14,15],0],['短顺子',[3,4,5,6],0],['断顺子',[3,4,5,7,8],0],
  ['连对',[3,3,4,4,5,5],7,5],['短连对',[3,3,4,4],0],['含2连对',[13,13,14,14,15,15],0],
  ['飞机',[3,3,3,4,4,4],8,4],['四组三张优先纯飞机',[3,3,3,4,4,4,5,5,5,6,6,6],8,6],
  ['飞机带单',[3,3,3,4,4,4,8,9],9,4],['飞机带一对单翅',[3,3,3,4,4,4,8,8],9,4],
  ['飞机带双王非法',[3,3,3,4,4,4,16,17],0],['飞机主体含2',[14,14,14,15,15,15],0],
  ['飞机带对',[3,3,3,4,4,4,8,8,9,9],10,4],['飞机对翼数量不对',[3,3,3,4,4,4,8,8,9,10],0],
  ['四带二单',[7,7,7,7,3,4],11,7],['四带一对',[7,7,7,7,3,3],11,7],
  ['四带两对',[7,7,7,7,3,3,4,4],12,7],['两炸弹不可当四带两对',[7,7,7,7,8,8,8,8],0],
  ['炸弹',[15,15,15,15],13,15],['王炸',[16,17],14,17],
  ['四张不能当飞机主体',[3,3,3,3,4,4,4,5],0],['两个不连续三张',[3,3,3,5,5,5],0],
  ['单翅不能用炸弹',[3,3,3,4,4,4,5,5,5,6,6,6,9,9,9,9],0],
  ['最长顺子',[3,4,5,6,7,8,9,10,11,12,13,14],6,14]
];
for(const [name,hand,type,high] of cases) {const actual=classify(hand);assert.equal(actual.type,type,name);if(high)assert.equal(actual.high,high,name);}
const beats=(a,b)=>b.type===0||a.type===14||(a.type===13&&b.type<13)||(a.type===b.type&&a.n===b.n&&a.high>b.high);
assert(!beats(classify([3,4,5,6,7,8]),classify([3,4,5,6,7])));
assert(beats(classify([3,3,3,3]),classify([15,15])));
assert(!beats(classify([15,15,15,15]),classify([16,17])));
assert(beats(classify([16,17]),classify([15,15,15,15])));
// 权威牌组唯一性，以及取牌算法在各随机顺序下的17/17/17/3数量。
const deck=[...read('deck/create').matchAll(/\{id:(\d+),rank:(\d+)\}/g)].map(m=>({id:+m[1],rank:+m[2]}));
assert.equal(deck.length,54);assert.equal(new Set(deck.map(c=>c.id)).size,54);
for(let r=3;r<=17;r++)assert.equal(deck.filter(c=>c.rank===r).length,r<16?4:1);
assert.equal((read('deal/hand').match(/sort=random,limit=1/g)||[]).length,17);
for(let seed=1;seed<=200;seed++) {let state=seed;const pool=[...deck],hands=[];for(let p=0;p<3;p++){const hand=[];for(let i=0;i<17;i++){state=(Math.imul(state,1664525)+1013904223)>>>0;hand.push(pool.splice(state%pool.length,1)[0]);}hands.push(hand);}assert.equal(pool.length,3);assert.equal(new Set([...hands.flat(),...pool].map(c=>c.id)).size,54);}
const walk=dir=>fs.readdirSync(dir,{withFileTypes:true}).flatMap(e=>e.isDirectory()?walk(path.join(dir,e.name)):[path.join(dir,e.name)]);
for(const f of walk(functions)) {
 const text=fs.readFileSync(f,'utf8');
 for(const m of text.matchAll(/\bfunction (doudizhu|cardtable):([a-z0-9_/]+)/g))assert(fs.existsSync(path.join(root,'data',m[1],'function',m[2]+'.mcfunction')),`${f}: ${m[0]}`);
 for(const m of text.matchAll(/scoreboard objectives add (\S+)/g))assert(m[1].length<=16);
}
for(const kind of ['load','tick']){const entries=JSON.parse(fs.readFileSync(path.join(root,`data/minecraft/tags/function/${kind}.json`),'utf8')).values;assert.equal(entries.filter(s=>s===`doudizhu:${kind}`).length,1);}
const rp=path.resolve(root,'../fimelcard-rp');
for(const f of walk(path.join(rp,'assets/card/font/doudizhu'))) {
 const json=JSON.parse(fs.readFileSync(f,'utf8').replace(/^\uFEFF/,''));
 for(const p of json.providers)if(p.type==='bitmap'){
   assert(fs.existsSync(path.join(rp,'assets/card/textures',p.file.split(':')[1])));
   assert(p.ascent<=p.height);assert(p.chars.every(row=>[...row].length===9));
   assert.equal(new Set(p.chars.join('')).size,p.chars.join('').length);
 }
}
console.log(`${cases.length}个牌型案例、压牌比较、200轮发牌、不重复注册和字体引用检查通过。`);
