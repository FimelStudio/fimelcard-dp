import fs from 'node:fs';
import assert from 'node:assert/strict';
import path from 'node:path';
// 默认定位同一 Minecraft 版本目录的资源包；其他部署可通过环境变量指定。
const resourcePack=process.env.FIMEL_CARD_RESOURCEPACK??path.resolve('../../../../resourcepacks/fimelcard-rp');
const read=n=>fs.readFileSync('data/abraca/function/'+n+'.mcfunction','utf8');
const cards=read('input/give_cards').trim().split(/\r?\n/);
assert.equal(cards.length,8);
for(const [i,line]of cards.entries()){
 assert.ok(line.includes("item_model='card:abraca/spell_"+(i+1)+"'"));
 assert.ok(line.includes('cast:1b,spell:'+(i+1)+',table:$(table),epoch:$(epoch)'));
 assert.ok(line.includes('minecraft:max_stack_size=1'));
 assert.ok(fs.existsSync(path.join(resourcePack,'assets/card/items/abraca/spell_'+(i+1)+'.json')));
}
for(const n of ['deck/deal_one','deck/draw']){
 assert.ok(!read(n).includes('stone:1b'),'不能再发放实际物品牌背');
 assert.ok(read(n).includes('add ab.hand'),'保留后台真实牌');
}
assert.ok(!read('action/success').includes('clear @'));
assert.match(read('input/drop'),/execute on origin if entity @s\[type=minecraft:player,tag=ab.player\]/);
assert.ok(!read('input/drop').includes('nearest'));
assert.ok(read('input/drop').includes('kill @s'));
assert.ok(read('tick').includes('cast:1b'));
assert.ok(read('input/give_tools').indexOf('input/clear_tools')<read('input/give_tools').indexOf('input/give_cards'));
assert.ok(read('ui/open_cast').includes('input/give_tools'));
assert.ok(!read('ui/open_cast').includes('click_event'));
assert.ok(read('ui/open_cast').includes('第9格黑色染料'));
assert.ok(read('input/give_end').includes('unless items entity @s hotbar.8 * run item replace entity @s hotbar.8 with minecraft:black_dye'));
assert.ok(read('input/give_end').includes('cast:1b,spell:9,table:$(table),epoch:$(epoch)'));
assert.ok(read('input/clear_tools').includes('clear @s minecraft:black_dye[minecraft:custom_data~{abraca:{cast:1b}}]'));
assert.ok(read('tick').includes('contents minecraft:black_dye[minecraft:custom_data~{abraca:{cast:1b}}]'));
assert.ok(read('input/from_player').includes('ab_action matches 9 run function abraca:input/clear_tools'));
assert.ok(read('action/handle').includes('unless entity @s[tag=ab.q_input]'));
assert.ok(read('action/handle').includes('scores={ab_state=2}'));
// 从实际提交函数读取拒绝条件，验证origin玩家、回合、桌号、序号、编号和状态。
const lines=read('input/from_player').split(/\r?\n/);
function accepted(p,item,state){
 for(const l of lines.filter(l=>l.startsWith('execute unless'))){
  let ok;
  if(l.includes('entity @s[tag=ab.turn]'))ok=p.turn;
  else if(l.includes('ab_id = #drop_table'))ok=p.table===item.table;
  else if(l.includes('ab_input = #drop_epoch'))ok=p.epoch!==undefined&&p.epoch===item.epoch;
  else if(l.includes('#drop_spell ab_ctx matches 1..9'))ok=item.spell>=1&&item.spell<=9;
  else if(l.includes('#input_live ab_ctx matches 1'))ok=state===2;
  else throw Error(l);
  if(!ok)return false;
 }return true;
}
let checks=0;
for(let spell=0;spell<=10;spell++)for(const turn of [true,false])for(const table of [1,2])for(const epoch of [100,101])for(const state of [1,2,3]){
 const p={turn,table:1,epoch:100},item={spell,table,epoch};
 assert.equal(accepted(p,item,state),turn&&table===1&&epoch===100&&state===2&&spell>=1&&spell<=9);
 checks++;
}
const actor={turn:true,table:1,epoch:100},item={spell:5,table:1,epoch:100};
assert.ok(accepted(actor,item,2));actor.epoch++;
assert.equal(accepted(actor,item,2),false,'同一批重复掉落不能二次施法');
for(const f of ['turn/begin','game/reset_player_round','player/clear_state','load'])assert.ok(read(f).includes('input/clear_tools'));
assert.ok(read('game/resume').includes('ui/open_cast'));
assert.ok(read('game/start').indexOf('check_cast_slots')<read('game/start').indexOf('tag @s add ab.controller'));
assert.equal((read('game/check_cast_slots').match(/hotbar\.[0-8]/g)||[]).length,9);
assert.ok(!read('input/give_cards').includes('item replace'),'不覆盖非游戏物品');
console.log('通过：8张施法牌及第9格黑色结束染料、后台真实牌保留、'+checks+'种输入权限、原丢出者识别、序号去重、回收、重载及九格保护；仍需游戏内Q键实测。');
