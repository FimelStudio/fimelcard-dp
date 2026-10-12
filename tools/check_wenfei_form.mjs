import fs from 'node:fs';
import assert from 'node:assert/strict';
const read=n=>fs.readFileSync('data/wenfei/function/'+n+'.mcfunction','utf8');
const settings=read('settings/dialog');
assert.match(settings,/type:"minecraft:single_option",key:"input"/);
assert.match(settings,/id:"0",display:\{text:"书（默认）"\},initial:true/);
assert.match(settings,/id:"1",display:\{text:"对话框（提交需要OP）"\}/);
assert.match(settings,/\$\(duo\)\$\(multi\)\$\(input\)7/);
const header=read('settings/save').split('scoreboard players operation #ctx')[0];
const inRange=(v,r)=>r.includes('..')?v>=+r.split('..')[0]&&v<=+r.split('..')[1]:v===+r;
function decode(raw){
 const scores={'@s wq_settings':raw,'#ten wq_ctx':10};
 for(const line of header.split(/\r?\n/)){
  let m=line.match(/^scoreboard players set (\S+) (\S+) (-?\d+)$/);
  if(m){scores[m[1]+' '+m[2]]=+m[3];continue;}
  m=line.match(/^scoreboard players operation (\S+) (\S+) (=|%=|\/=) (\S+) (\S+)$/);
  if(m){const a=m[1]+' '+m[2],b=scores[m[4]+' '+m[5]];scores[a]=m[3]==='='?b:m[3]==='%='?scores[a]%b:Math.floor(scores[a]/b);continue;}
  m=line.match(/^execute unless score (#\S+) (\S+) matches (\S+) run return 0$/);
  if(m&&!inRange(scores[m[1]+' '+m[2]],m[3]))return null;
 }
 return [scores['#duo wq_ctx'],scores['#multi wq_ctx'],scores['#input wq_ctx']];
}
for(let duo=1;duo<=6;duo++)for(let multi=1;multi<=6;multi++)for(let mode=0;mode<=1;mode++)assert.deepEqual(decode(Number(`${duo}${multi}${mode}7`)),[duo,multi,mode]);
for(let old=11;old<=66;old++)assert.equal(decode(old),null);
const form=JSON.parse(read('form/build').split(/\r?\n/).find(l=>l.startsWith('data modify storage wenfei:form dialog set value ')).split(' set value ')[1]);
assert.equal(form.inputs.length,1);assert.equal(form.inputs[0].max_length,64);assert.equal(form.inputs[0].initial,'');
assert.match(read('form/build'),/contents.text set from entity @s data.wenfei.correct.text/);
assert.match(read('form/authorize'),/wq_guess=0,wq_done=0/);
assert.match(read('form/authorize'),/wq_state=2,wq_input=1.*wq_id = #form_table/);
assert.match(read('form/receive'),/wq_form = #form_request_token/);
assert.match(read('form/receive'),/wq_epoch = #form_request_epoch/);
assert.match(read('form/receive'),/#form_length wq_ctx matches 1\.\.64/);
assert.match(read('form/receive'),/function wenfei:input\/save_answer/);
assert.match(read('form/receive'),/function wenfei:round\/check_answers/);
assert.ok(read('form/receive').indexOf('set @s wq_done 1')<read('form/receive').indexOf('function wenfei:round/check_answers'));
assert.match(read('input/give_answer'),/#answer_mode wq_ctx matches 1 run return run function wenfei:form\/give_tool/);
assert.match(read('input/give_answer'),/function wenfei:input\/give_answer_item/);
assert.match(read('input/from_player'),/wq_state=2,wq_input=0/);
assert.match(read('player/clear_state'),/tool:"answer_dialog"/);
const rawTemplate=JSON.parse(read('form/template').trim().split(' set value ')[1]);
const substitute=(s,values)=>s.replace(/\$\((\w+)\)/g,(_,key)=>values[key]);
const clientTemplate=substitute(rawTemplate,{a:'$(a)',table:-2147483648,epoch:-2147483648,token:-2147483648});
const escape=s=>s.replace(/[\\'"\n\r\t]/g,c=>({'\n':'\\n','\r':'\\r','\t':'\\t'}[c]||'\\'+c));
let longest=0;
for(const input of ['答'.repeat(64),"'".repeat(64),'"'.repeat(64),'\\'.repeat(64),'😀'.repeat(32),'$(table)']){
 const command=substitute(clientTemplate,{a:escape(input)});
 assert.ok(command.length<=256);longest=Math.max(longest,command.length);
}
console.log(`PASS: 72种设置组合、书/对话框路由、秘密问题可见范围、逐玩家窗口令牌与回合校验、统一公开入口；命令最长 ${longest} 字符。`);
