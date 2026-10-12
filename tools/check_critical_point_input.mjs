import fs from 'node:fs';
import path from 'node:path';
import assert from 'node:assert/strict';
const base=path.join(process.cwd(),'data/critical_point/function');
const read=name=>fs.readFileSync(path.join(base,name+'.mcfunction'),'utf8');
const tick=read('tick');
assert.match(tick,/as @e\[type=minecraft:item,tag=!cp.returned\].*function critical_point:input\/drop/);
assert.doesNotMatch(tick,/distance=|cp_drop=|input\/(?:card|ready|start_vote|reopen_vote|signal_big|signal_small)\b/);
assert.match(read('input/drop'),/execute on origin if entity @s\[tag=cp.player\] at @s run function critical_point:input\/from_player/);
assert.ok(read('input/drop').indexOf('tag @s add cp.input_drop')<read('input/drop').indexOf('execute on origin'));
const dispatch=read('input/from_player');
for(const handler of ['card','ready','start_vote','reopen_vote','signal_big','signal_small']){
 assert.match(dispatch,new RegExp('run return run function critical_point:input/'+handler+'\\b'));
 const source=read('input/'+handler);
 assert.doesNotMatch(source,/distance=|sort=nearest|run tag @s add cp\.(?:card_drop|tool_drop|reopen_drop)/);
 for(const line of source.split(/\r?\n/))
  if(line.startsWith('kill '))assert.match(line,/tag=cp.input_drop,limit=1/);
 assert.match(source,/if score @s cp_id = #ctx cp_ctx/);
}
for(let n=1;n<=5;n++)assert.ok(dispatch.includes('card:'+n+'b'));
assert.match(read('input/return_card'),/Owner set from entity @s UUID/);
assert.match(read('input/return_card'),/add cp.returned/);
for(const kind of ['big','small']){
 const signal=read('input/signal_'+kind);
 assert.match(signal,/if entity @s\[tag=cp.signal_used\] run return 0/);
 assert.ok(signal.indexOf('tag @s add cp.signal_used')<signal.indexOf('tellraw'));
 assert.match(signal,/function critical_point:input\/clear_signal_tools/);
}
assert.match(read('input/give_signal_tools'),/tag @s remove cp.signal_used/);
assert.match(read('player/clear_state'),/tag @s remove cp.signal_used/);
const walk=dir=>fs.readdirSync(dir,{withFileTypes:true}).flatMap(e=>e.isDirectory()?walk(path.join(dir,e.name)):[path.join(dir,e.name)]);
let count=0;
for(const file of walk(base).filter(f=>f.endsWith('.mcfunction'))){
 count++;
 for(const line of fs.readFileSync(file,'utf8').split(/\r?\n/).filter(l=>!l.startsWith('#'))){
  for(const m of line.matchAll(/\bfunction ([a-z0-9_]+):([a-z0-9_/]+)/g))
   assert.ok(fs.existsSync(path.join(process.cwd(),'data',m[1],'function',m[2]+'.mcfunction')),file+': '+m[0]);
  const stack=[];let quote='',escape=false;
  for(const c of line){
   if(quote){if(escape)escape=false;else if(c==='\\')escape=true;else if(c===quote)quote='';}
   else if(c==='"'||c==="'")quote=c;
   else if('[{('.includes(c))stack.push(c);
   else if(']})'.includes(c))assert.equal(stack.pop(),{']':'[','}':'{',')':'('}[c],file);
  }
  assert.equal(stack.length,0,file);assert.equal(quote,'',file);
 }
}
console.log(`PASS: ${count} 个函数的引用和括号检查、掉落物归属路径、精确清除、退牌和信号去重检查。`);
