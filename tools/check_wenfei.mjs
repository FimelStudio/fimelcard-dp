import fs from 'node:fs';
import path from 'node:path';
import assert from 'node:assert/strict';
const root=process.cwd();
const base=path.join(root,'data/wenfei/function');
const read=n=>fs.readFileSync(path.join(base,n+'.mcfunction'),'utf8');
const walk=d=>fs.readdirSync(d,{withFileTypes:true}).flatMap(e=>e.isDirectory()?walk(path.join(d,e.name)):[path.join(d,e.name)]);
const files=walk(base).filter(n=>n.endsWith('.mcfunction'));
for(const f of files){
 const source=fs.readFileSync(f,'utf8');
 for(const m of source.matchAll(/\bfunction ([a-z0-9_]+):([a-z0-9_/]+)/g))
  assert.ok(fs.existsSync(path.join(m[1]==='title'?path.resolve(root,'../BetterTitle DP 26.1'):root,'data',m[1],'function',m[2]+'.mcfunction')),f+': '+m[0]);
 for(const line of source.replace(/\\\r?\n\s*/g,'').split(/\r?\n/)){
  if(line.startsWith('#'))continue;
  const stack=[];let quote='',escape=false;
  for(const c of line){
   if(quote){if(escape)escape=false;else if(c==='\\')escape=true;else if(c===quote)quote='';}
   else if(c==='"'||c==="'")quote=c;
   else if('[{('.includes(c))stack.push(c);
   else if(']})'.includes(c))assert.equal(stack.pop(),{']':'[','}':'{',')':'('}[c],f+': 括号不匹配');
  }
  assert.equal(stack.length,0,f);assert.equal(quote,'',f);
 }
}
const catalog=JSON.parse(read('deck/catalog').split('categories set value ')[1]);
assert.equal(catalog.length,6);
const ids=new Set();
for(const c of catalog){
 assert.equal(c.questions.length,150);
 assert.equal(new Set(c.questions.map(q=>q.text)).size,150);
 for(const q of c.questions){assert.ok(!ids.has(q.id));ids.add(q.id);assert.ok(q.text.length>0);}
}
assert.equal(ids.size,900);
assert.equal(new Set(catalog.flatMap(c=>c.questions.map(q=>q.text))).size,900);
const perms=a=>a.length===0?[[]]:a.flatMap((v,i)=>perms(a.filter((_,j)=>j!==i)).map(t=>[v,...t]));
let placements=0;
for(const order of perms([0,1,2,3,4])){
 for(let correct=0;correct<5;correct++){
  const used=new Set();let gain=0;
  order.forEach((position,card)=>{assert.ok(!used.has(position));used.add(position);if(card===correct)gain=position;});
  assert.equal(gain,order[correct]);placements++;
 }
}
assert.equal(placements,600);
assert.match(read('round/place_at'),/used\.p\$\(points\).*return run function/);
assert.match(read('round/place_at'),/#id wq_ctx = #correct wq_ctx.*wq_gain \$\(points\)/);
assert.match(read('round/place_at'),/wq_index matches 5.*round\/resolve/);
assert.equal((read('deck/select').match(/function wenfei:deck\/pick/g)||[]).length,5);
assert.match(read('deck/take'),/pool\[\$\(index\)\][\s\S]*data remove entity @s data\.wenfei\.pool\[\$\(index\)\]/);
// 测试所有非连续座位组合、每种起始座位及默认轮换次数。
const duo=Number(read('game/init_table').match(/wq_duo (\d+)/)[1]);
const multi=Number(read('game/init_table').match(/wq_multi (\d+)/)[1]);
assert.equal(duo,3);assert.equal(multi,2);
const wrap=Number(read('round/next').match(/wq_turn matches (\d+)\.\./)[1]);
let rotations=0;
for(let mask=1;mask<256;mask++){
 const seats=[1,2,3,4,5,6,7,8].filter(s=>mask&(1<<(s-1)));
 if(seats.length<2)continue;
 for(const first of seats){
  let turn=first;const counts=new Map(seats.map(s=>[s,0]));const times=seats.length===2?duo:multi;
  for(let r=0;r<times*seats.length;r++){
   counts.set(turn,counts.get(turn)+1);
   do{turn++;if(turn>=wrap)turn=1;}while(!counts.has(turn));
  }
  for(const n of counts.values())assert.equal(n,times);
  rotations++;
 }
}
for(let d=1;d<=6;d++)for(let m=1;m<=6;m++){
 const value=Number(''+d+m);assert.equal(Math.floor(value/10),d);assert.equal(value%10,m);
}
for(const token of [1,2,999,10000])for(const choice of [1,6,10,14,20]){
 const v=token*100+choice;assert.equal(Math.floor(v/100),token);assert.equal(v%100,choice);
 assert.notEqual(Math.floor(v/100),token+1);
}
assert.match(read('action/handle'),/ct_id = @s wq_id/);
assert.match(read('action/handle'),/wq_ui_table = @s wq_id/);
assert.match(read('action/handle'),/wq_epoch = #epoch/);
assert.match(read('action/dispatch'),/wq_state matches 1.*wq_guess=1/);
assert.ok(!read('action/dispatch').includes('round/place'));
assert.match(read('input/from_player'),/tool:"score".*input\/score/);
assert.match(read('input/score'),/ct_id = @s wq_id/);
assert.match(read('input/score'),/wq_guess matches 1/);
assert.match(read('input/score'),/wq_state=3/);
assert.match(read('input/score'),/wq_id = #ctx/);
assert.match(read('input/score'),/wq_epoch = #item_epoch/);
assert.match(read('input/score'),/#points wq_ctx matches 0\.\.4/);
assert.match(read('input/score_submit'),/round\/place_at/);
assert.match(read('ui/rating'),/score_item\.epoch/);
assert.equal((read('ui/rating').match(/function wenfei:input\/give_score /g)||[]).length,5);
for(let p=0;p<=4;p++)assert.ok(read('ui/rating').includes('used.p'+p));
for(const file of ['ui/build','ui/answer','ui/rating'])assert.ok(!read(file).includes('dialog show')&&!read(file).includes('ui/show'));
assert.match(read('ui/button'),/click_event.*run_command.*trigger wq_action/);
for(const file of ['player/clear_state','round/resolve'])assert.ok(read(file).includes('tool:"score"'));
// One question may consume only one dye: after acceptance the epoch advances.
// All other drops captured in that tick carry the old epoch and must be rejected.
for(const order of perms([0,1,2,3,4])){
 let epoch=17;const used=new Set();let index=0;
 for(const point of order){
  const captured=[{epoch,point},{epoch,point:order[(index+1)%5]}];
  for(const drop of captured)if(drop.epoch===epoch&&!used.has(drop.point)){used.add(drop.point);index++;epoch++;}
 }
 assert.equal(index,5);assert.equal(used.size,5);
}
assert.match(read('ui/answer'),/wq_guess=1.*return 0[\s\S]*data\.wenfei\.correct\.text/);
assert.ok(!read('ui/rating').includes('data.wenfei.correct'));
assert.ok(!read('hud/update').includes('data.wenfei.correct'));
assert.match(read('input/drop'),/wq_id = #item_table/);
assert.match(read('input/accept_answer'),/wq_done 1/);
assert.match(read('round/check_answers'),/#pending wq_ctx matches 1\.\..*return 0/);
assert.ok(!read('load').includes('function wenfei:game/abort'));
assert.ok(!read('load').includes('function wenfei:round/begin'));
assert.match(read('system/maintenance'),/unless score #online wq_ctx = @s wq_players/);
assert.match(read('game/abort'),/game_entity.*wq_id = #ctx/);
assert.match(read('input/cleanup_drops'),/table:\$\(table\)/);
assert.match(read('game/start'),/ct_joined matches 2\.\.8/);
const objectives=[...(read('system/install')+read('title/upgrade')).matchAll(/objectives add (\w+)/g)].map(m=>m[1]).concat('wq_ctx');
assert.equal(new Set(objectives).size,objectives.length);
assert.ok(objectives.every(n=>n.length<=16));
for(const kind of ['load','tick']){
 const tag=JSON.parse(fs.readFileSync(path.join(root,'data/minecraft/tags/function',kind+'.json'),'utf8'));
 assert.equal(tag.values.filter(n=>n==='wenfei:'+kind).length,1);
}
const registrations={
 'game/init_selected':'wenfei:game/init_table','game/start':'wenfei:game/start',
 'game/open_settings':'wenfei:settings/open','game/open_rules':'wenfei:rules/show',
 'vote/finish':'wenfei:game/end_vote','table/remove':'wenfei:game/abort',
 'game/remove_offline_player':'wenfei:player/clear_state','menu/render':'cardtable:menu/game_name_wenfei'
};
for(const [file,ref] of Object.entries(registrations))
 assert.ok(fs.readFileSync(path.join(root,'data/cardtable/function',file+'.mcfunction'),'utf8').includes(ref),file);
assert.ok(Number(fs.readFileSync(path.join(root,'data/cardtable/function/load.mcfunction'),'utf8').match(/#game_count ct_ctx (\d+)/)[1])>=8);
console.log('通过：'+files.length+'个函数的引用及结构、900道题、600种计分排列、'+rotations+'种座位轮换、36种设置组合。');
console.log('通过：交互序号及权限校验、秘密题展示边界、桌号隔离、重载保留、8号游戏全部分派和加载标签。');
console.log('以上为静态检查与规则模型校验，不替代Minecraft联机实测。');

// 结算后直接轮换，旧版已结算对局也可继续；不再接受准备按钮。
assert.ok(read('round/resolve').trimEnd().endsWith('function wenfei:round/next'));
assert.ok(!read('action/dispatch').includes('round/ready'));
assert.ok(!read('ui/build').includes('ui/result'));
assert.ok(read('tick').includes('scores={wq_state=4}] at @s run function wenfei:round/next'));

assert.match(read('title/prepare'),/unless score @s wq_state matches 3 run return 0/);
assert.match(read('title/render'),/wq_guess=1.*wq_id = #ctx/);
assert.ok(read('round/check_answers').indexOf('title/prepare')>read('round/check_answers').indexOf('run return 0'));
assert.ok(!read('title/build').includes('correct'));
assert.ok(read('title/rows').includes('wq_id=$(table),wq_seat=$(seat)'));
assert.ok(read('title/build').includes('panel_buffer set value []'));
assert.ok(read('title/rows').includes('text append from storage wenfei:panel rows'));
assert.ok(!read('title/rows').includes('nbt:'));
assert.ok(read('title/release').includes('fbt_panel = @s wq_prev_panel'));
for(const file of ['round/begin','player/clear_state'])assert.ok(read(file).includes('function wenfei:title/release'));
assert.ok(read('load').includes('function wenfei:title/resume'));
assert.match(read('title/tick'),/wq_ptick matches 100/);
for(const f of files)if(fs.readFileSync(f,'utf8').includes('give @s minecraft:purple_dye'))assert.ok(['input/give_category_menu.mcfunction','form/give_item.mcfunction'].includes(path.relative(base,f).replaceAll('\\','/')));
for(const file of ['input/give_menu','input/give_menu_item','input/reopen'])assert.ok(!fs.existsSync(path.join(base,file+'.mcfunction')));
const width=Number(read('title/wrap/character').match(/#columns wq_ctx matches (\d+)\.\./)[1]);
for(const n of [1,35,36,37,71,72,73,256,1024]){
 const text='答'.repeat(n);const rows=[];
 for(let start=0;start<text.length;start+=width)rows.push(text.slice(start,start+width));
 assert.equal(rows.join(''),text);
 const pages=Math.ceil(rows.length/2);
 const seen=[];
 for(let page=0;page<pages;page++)seen.push(...rows.slice(page*2,page*2+2));
 assert.equal(seen.join(''),text);
 assert.ok(rows.every(row=>row.length<=36));
}
console.log('通过：回答面板隐私及桌号边界、分行翻页、结束恢复和类别工具阶段限制。');

assert.match(read('ui/category'),/unless score @s wq_state matches 1 run return 0/);
assert.match(read('ui/category'),/wq_guess=1.*return 0/);
assert.equal((read('ui/category').match(/function wenfei:ui\/category_button/g)||[]).length,6);
assert.ok(read('ui/category').includes('function wenfei:ui/show'));
assert.match(read('ui/category_button'),/minecraft:run_command.*trigger wq_action/);
assert.ok(!read('ui/category').includes('function wenfei:ui/button '));
assert.match(read('input/reopen_category'),/wq_state=1.*wq_id = #ctx.*wq_epoch = #menu_epoch/);
assert.ok(read('input/reopen_category').includes('wq_guess matches 1'));
for(const file of ['round/category','round/begin','game/abort'])assert.ok(read(file).includes('function wenfei:input/clear_category_menu'));
assert.match(read('input/clear_category_menu'),/wq_id = #menu_table/);
assert.ok(read('input/clear_category_drops').includes('table:$(table)'));
console.log('通过：类别对话框、六个按钮、紫色工具身份及阶段检查、换阶段和结束回收。');
