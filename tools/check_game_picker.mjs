import fs from 'node:fs';
import assert from 'node:assert/strict';
const read=n=>fs.readFileSync('data/cardtable/function/'+n+'.mcfunction','utf8').replace(/\r\n/g,'\n');
const names=['Fast Card','赌命德州扑克','花火','出包魔法师','瞎掰王','谍报风云','临界点','问非所答','骷髅牌','斗地主','UNO','国际象棋','中国象棋','五子棋','飞行棋','阿瓦隆','情书','掼蛋'];
const min=[4,2,2,2,3,3,3,2,2,1,2,1,1,1,1,5,2,4],max=[4,8,5,5,8,8,6,8,6,3,8,2,2,2,4,8,6,4];
names[19]='围棋';min[19]=1;max[19]=2;
const ids=names.flatMap((name,i)=>name?[i+1]:[]),count=ids.length,highest=Math.max(...ids);
for(const cap of [4,8]){
 const src=read('menu/picker/show'+cap);
 const d=JSON.parse(src.slice(src.indexOf('{')));
 assert.equal(d.type,'minecraft:multi_action');assert.equal(d.pause,false);
 assert.equal(d.actions.length,cap===8?count:count-1);assert.equal(d.exit_action.action,undefined);
 for(const a of d.actions){
  const id=Number(a.action.command.match(/\$\(p(\d+)\)/)[1]),i=id-1;
  assert.ok(cap===8||id!==16,'四人桌不显示至少五人的阿瓦隆');
  const upper=Math.min(cap,max[i]),range=min[i]===upper?min[i]:min[i]+'–'+upper;
  // 斗地主会补测试人机，国际象棋单人开局时自动对战电脑。
  assert.equal(a.label.text,names[i]+'（'+range+'人'+([9,11,12,13,14,19].includes(i)?'+人机':'')+'）');
  assert.equal(a.action.type,'minecraft:run_command');
  assert.equal(a.action.command,'trigger ct_game_pick set $(p'+id+')');
 }
}
const open=read('menu/picker/open'),handle=read('menu/picker/handle'),select=read('menu/select_game');
assert.match(read('system/upgrade_v5'),/objectives add ct_game_pick trigger/);
assert.match(read('load'),/matches 4 run function cardtable:system\/upgrade_v5/);
assert.match(open,/players enable @a\[tag=ct.switch_actor,limit=1\] ct_game_pick/);
assert.equal((open.match(/store result storage cardtable:picker p\d+ int 1/g)||[]).length,count);
assert.match(open,/players add #pick_nonce ct_ctx 100/,'会话步长必须大于当前游戏数，避免新旧窗口编码重叠');
assert.match(open,/ct_pick_table = @s ct_id/);assert.match(open,/ct_pick_base = #pick_nonce ct_ctx/);
assert.match(read('menu/next_game'),/function cardtable:menu\/picker\/open/);
assert.ok(!read('menu/next_game').includes('players add @s ct_game'));
assert.match(select,/ct_game = #pick_choice ct_ctx run return 0/);
assert.ok(select.indexOf('run return 0')<select.indexOf('function cardtable:game/init_selected'),'选择当前游戏不重置设置');
assert.match(select,/ct_pick_table = #ctx_id ct_ctx run scoreboard players reset @s ct_pick_table/);
for(const n of ids)assert.ok(select.includes('ct_game matches '+n+' run tellraw'));
for(const n of ids)assert.match(open,new RegExp('operation #pick_button ct_ctx = #pick_nonce ct_ctx\\nscoreboard players add #pick_button ct_ctx '+n+'\\nexecute store result storage cardtable:picker p'+n+' int'),'按钮必须按真实编号编码');
assert.ok(!open.includes('cardtable:picker p19 int'),'19号保留，不生成按钮');
assert.match(handle,/if score #pick_choice ct_ctx matches 19 run return run function cardtable:menu\/picker\/invalid/);
// 直接读取提交函数中的三个拒绝条件，模拟合法、离座、跨桌及旧窗口提交。
const guards=handle.split(/\r?\n/).filter(l=>l.startsWith('execute unless')&&!l.includes('ct.switch_controller'));
assert.equal(guards.length,3);
function accepted(player,submitted,base,table,current,state,exists){
 const choice=submitted-base;
 for(const guard of guards){
  let ok;
  if(guard.includes('entity @s[tag=ct.player]'))ok=player;
  else if(guard.includes('ct_pick_table = @s ct_id'))ok=table!==undefined&&table===current;
  else if(guard.includes('#pick_choice ct_ctx matches 1..'+highest))ok=choice>=1&&choice<=highest;
  else throw Error(guard);
  if(!ok)return false;
 }
 return ids.includes(choice)&&exists&&state===0;
}
let checks=0;
for(const base of [100,200,1000])for(const game of ids){
 assert.ok(accepted(true,base+game,base,12,12,0,true));
 for(const args of [
  [false,base+game,base,12,12,0,true],
  [true,base+game,base,12,13,0,true],
  [true,base+game,base,undefined,12,0,true],
  [true,base+game,base,12,12,1,true],
  [true,base+game,base,12,12,0,false],
  [true,base+game,base+100,12,12,0,true],
  [true,base+game,base-100,12,12,0,true]
 ])assert.equal(accepted(...args),false);
 checks+=8;
}
for(const base of [100,200,1000])assert.equal(accepted(true,base+19,base,12,12,0,true),false);
assert.match(handle,/scores=\{ct_state=0\}.*ct_id = #pick_table ct_ctx/);
assert.ok(handle.indexOf('reset @s ct_game_pick')<handle.indexOf('menu/select_game'));
for(const f of ['load','seat/remove_player','game/start'])assert.ok(read(f).includes('reset')&&read(f).includes('ct_pick_table'));
assert.ok(read('tick').includes('scores={ct_game_pick=1..}'));
console.log('通过：两种桌型'+(count*2-1)+'个选择按钮、人数提示、取消/同游戏不改设置、'+checks+'种提交权限与旧窗口情形、升级及开局/离座/重载失效。仍需游戏内右键与普通玩家验收。');
