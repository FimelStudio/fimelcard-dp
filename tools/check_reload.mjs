import fs from 'node:fs';
import path from 'node:path';
import assert from 'node:assert/strict';
const root=process.cwd();
const games=['abraca','bullshit','decrypto','critical_point'];
const read=id=>fs.readFileSync(path.join(root,'data',id.replace(':','/function/')+'.mcfunction'),'utf8');
const protectedScore=/^(?:ab_(?:state|phase|timer|turn|last|hp|score)|bw_(?:state|timer|round|turn|question|role|used|bs|score)|dc_(?:state|mode|round|pos|guess[123]|[wb][123]|page|pages|page_tick|team|encoder)|cp_(?:state|timer|round|locked|play|ready|vote|vote_used))$/;
const visited=new Set();
function visit(id){
 // BetterTitle 的渲染库不属于游戏恢复状态机；兼容前置合并后的独立命名空间。
 if(visited.has(id)||id.startsWith('title:')||id.startsWith('fimel_title:'))return;
 visited.add(id);
 assert.ok(!/:(?:game\/(?:abort|start|return_lobby)|round\/(?:begin|start)|vote\/start|turn\/begin|input\/give_book)(?:$|_)/.test(id),'恢复路径不能推进/清空游戏: '+id);
 const source=read(id);
 for(const line of source.split(/\r?\n/).filter(l=>!l.startsWith('#'))){
  for(const m of line.matchAll(/scoreboard players (?:set|add|remove|reset|operation) (\S+) (\S+)/g))
   assert.ok(m[1].startsWith('#')||!protectedScore.test(m[2]),id+': 修改游戏进度 '+line);
  const resolverCleanup=id==='hanabi:name/resolve'&&/^kill @e\[type=minecraft:item_display,tag=hb.name_resolver,/.test(line);
  const promptToolCleanup=id==='decrypto:prompt/give_tool'&&line==="clear @s minecraft:purple_dye[minecraft:custom_data~{decrypto:{tool:'prompt'}}]";
  const abracaToolCleanup=id==='abraca:input/clear_tools'&&[
   'clear @s minecraft:paper[minecraft:custom_data~{abraca:{cast:1b}}]',
   'clear @s minecraft:black_dye[minecraft:custom_data~{abraca:{cast:1b}}]',
   'clear @s minecraft:paper[minecraft:custom_data~{abraca:{stone:1b}}]'
  ].includes(line);
  assert.ok(!/\b(?:kill|clear) @/.test(line)||id.includes(':input/give_')||resolverCleanup||promptToolCleanup||abracaToolCleanup,id+': 意外清除实体/物品');
  for(const m of line.matchAll(/\bfunction ([a-z0-9_]+:[a-z0-9_/]+)/g))visit(m[1]);
 }
}
for(const game of games){
 const source=read(game+':load');
 assert.match(source,new RegExp('function '+game+':game/resume'));
 assert.doesNotMatch(source,/game\/abort|安全结束/);
 visit(game+':game/resume');
}
assert.match(read('bullshit:game/resume_smart'),/if score @s bw_used matches 0 .*place_call/);
assert.match(read('critical_point:game/resume_player'),/if score @s cp_ready matches 0 .*tool:'ready'/);
assert.match(read('critical_point:game/resume_player'),/unless score @s cp_locked matches 0 run return 0/);
assert.ok(![...visited].some(id=>id.endsWith('give_signal_tools')));
assert.ok(visited.has('decrypto:title/render_all'));
assert.ok(!visited.has('decrypto:title/update_all'));
for(const id of visited){
 for(const line of read(id).split(/\r?\n/).filter(l=>!l.startsWith('#'))){
  const stack=[];let quote='',escape=false;
  for(const c of line){
   if(quote){if(escape)escape=false;else if(c==='\\')escape=true;else if(c===quote)quote='';}
   else if(c==='"'||c==="'")quote=c;
   else if('[{('.includes(c))stack.push(c);
   else if(']})'.includes(c))assert.equal(stack.pop(),{']':'[','}':'{',')':'('}[c],id);
  }
  assert.equal(stack.length,0,id);assert.equal(quote,'',id);
 }
}
console.log(`PASS: 四个游戏重载入口、${visited.size} 个恢复调用函数、关键进度保护及命令括号检查。`);
