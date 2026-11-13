import fs from 'node:fs';
import path from 'node:path';
import assert from 'node:assert/strict';
const root=process.cwd();
const base=path.join(root,'data/decrypto/function');
const read=n=>fs.readFileSync(path.join(base,n+'.mcfunction'),'utf8');
const walk=d=>fs.readdirSync(d,{withFileTypes:true}).flatMap(e=>e.isDirectory()?walk(path.join(d,e.name)):[path.join(d,e.name)]);
let count=0;
for(const file of walk(base).filter(f=>f.endsWith('.mcfunction'))){
 count++;
 for(const line of fs.readFileSync(file,'utf8').replace(/\\\r?\n\s*/g,'').split(/\r?\n/).filter(l=>!l.startsWith('#'))){
  for(const m of line.matchAll(/\bfunction ([a-z0-9_]+):([a-z0-9_/]+)/g)){
   if(m[1]==='title')continue;
   assert.ok(fs.existsSync(path.join(root,'data',m[1],'function',m[2]+'.mcfunction')),file+': '+m[0]);
  }
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
const build=read('prompt/build');
const baseDialog=JSON.parse(build.split(/\r?\n/).find(l=>l.startsWith('data modify storage decrypto:form dialog set value ')).split(' set value ')[1]);
assert.deepEqual(baseDialog.inputs.map(x=>x.key),['a','b','c']);
for(const input of baseDialog.inputs){assert.equal(input.type,'minecraft:text');assert.equal(input.max_length,24);assert.equal(input.initial,'');}
assert.equal(baseDialog.yes.action.type,'minecraft:dynamic/run_command');
const labels=read('prompt/labels');
for(let i=0;i<3;i++)assert.ok(labels.includes(`dialog.inputs[${i}].label set value {text:"$(d${i+1})："`));
assert.match(build,/dc_state matches 2.*data.decrypto.keywords.white/);
assert.match(build,/dc_state matches 4.*data.decrypto.keywords.black/);
const auth=read('prompt/authorize');
assert.match(auth,/dc_encoder=1/);assert.match(auth,/ct_id = @s dc_id/);
assert.match(auth,/dc_team matches 1.*dc_state=2,dc_input=1.*dc_id = #ctx/);
assert.match(auth,/dc_team matches 2.*dc_state=4,dc_input=1.*dc_id = #ctx/);
assert.match(read('prompt/drop'),/on origin.*function decrypto:prompt\/open/);
assert.match(read('prompt/receive'),/dc_form = #form_token/);
assert.equal((read('prompt/receive').match(/#form_length dc_ctx matches 1\.\.24/g)||[]).length,3);
assert.equal((read('prompt/accept').match(/function decrypto:input\/save_prompt/g)||[]).length,3);
assert.match(read('prompt/submit'),/incoming set value \$\(p\)/);
assert.match(read('prompt/give_selected'),/matches 1 run return run function decrypto:prompt\/give_tool/);
assert.match(read('prompt/give_selected'),/function decrypto:input\/give_book/);
// Every legacy and synchronous book route must reject dialog-only input.
const bookRoutes=read('input/check_book_drop').split(/\r?\n/).filter(l=>/run function decrypto:(sync\/book|input\/accept_book)/.test(l));
assert.equal(bookRoutes.length,3);
for(const route of bookRoutes)assert.match(route,/unless score @s dc_input matches 1/);
const rawTemplate=JSON.parse(labels.split(/\r?\n/).find(l=>l.includes('dialog.yes.action.template')).split(' set value ')[1]);
const substitute=(s,values)=>s.replace(/\$\((\w+)\)/g,(_,key)=>values[key]);
const clientTemplate=substitute(rawTemplate,{a:'$(a)',b:'$(b)',c:'$(c)',table:-2147483648,token:-2147483648});
const escapeText=s=>s.replace(/[\\'"\n\r\t]/g,c=>({'\n':'\\n','\r':'\\r','\t':'\\t'}[c]||'\\'+c));
let maxCommand=0;
for(const sample of ['汉'.repeat(24),"'".repeat(24),'"'.repeat(24),'\\'.repeat(24),'$(table)',"双引号\"与单引号'和反斜杠\\",'😀'.repeat(12)]){
 const text=escapeText(sample);
 const command=substitute(clientTemplate,{a:text,b:text,c:text});
 assert.ok(command.length<=256);maxCommand=Math.max(maxCommand,command.length);
 assert.ok(command.includes('t:-2147483648,n:-2147483648'));
}
// Legacy decimal settings were retired in favour of one-use table sessions.
// Native setting changes and range checks are covered by test_legacy_settings.py.
assert.match(read('settings/save'),/scoreboard players reset @s dc_settings/);
assert.match(read('settings/save'),/return 0/);
assert.doesNotMatch(read('settings/save'),/scoreboard players operation .*dc_round_limit/);
const applySettings=fs.readFileSync(path.join(root,'data/cardtable/function/settings/apply_6.mcfunction'),'utf8');
for(const [field,objective] of [[4,'dc_encode_limit'],[5,'dc_guess_limit']]){
 assert.ok(applySettings.includes(`#setting_field ct_ctx matches ${field} unless score #setting_value ct_ctx matches 0..5 run return 0`));
 assert.ok(applySettings.includes(`#setting_field ct_ctx matches ${field} run scoreboard players operation @s ${objective} = #setting_value ct_ctx`));
}
console.log(`PASS: ${count} 个函数结构与引用、旧窗口拒绝、两种输入路由、限时设置入口、隐私与令牌校验；转义后命令最长 ${maxCommand} 字符。`);
